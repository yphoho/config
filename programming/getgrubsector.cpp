#define WNI32_LEAN_AND_MEAN
#include<windows.h>

#include<stdio.h>
#include<stdlib.h>


#pragma pack(1)
struct dpt
{
    unsigned char active;
    char dummy[3];
    unsigned char type;
    char dummy2[3];
    unsigned int start;
    unsigned int length;
};

struct mbr
{
    char dos[446];
    struct dpt dpt[4];
    char aa55[2];
};
#pragma pack()



enum ptt_type {ntfs=0x7, ext=0xf, logical=0x5, ext4=0x83, swap=0x82};


BOOL ReadSectors(BYTE bDrive, _int64 dwStartSector, WORD wSectors, LPBYTE lpSectBuff);
void show_sector_detail(struct mbr *mbr);

int get_grub_from_mainpartition(_int64 base, unsigned char buffer[]);
int get_grub_from_expartition(_int64 base, unsigned char buffer[], int *suffix);


#define BPS 512

const int driver=0;
const int nrsector=1;


int main(int argc, char *argv[])
{
	unsigned char grub[nrsector*BPS] = {0};
    struct mbr *mbr=(struct mbr *)grub;
    

    // the MBR
    int ret=ReadSectors(driver, 0, nrsector, (LPBYTE)grub);
    if(!ret)
        return -1;
    show_sector_detail(mbr);

    int suffix=0;
    for(int i=0; i<4; i++)
    {
        int ret=0;
        _int64 base=mbr->dpt[i].start;
        suffix=i+1;

        if(mbr->dpt[i].type==ext4) // maybe the linux is installed in main partition
            ret=get_grub_from_mainpartition(base, grub);
        else if(mbr->dpt[i].type==ext) // find in the extended partition
            ret=get_grub_from_expartition(base, grub, &suffix);

        if(ret==-1)
            return -1;
        else if(ret==1)
            break;
    }

    char ubuntu[30];
    sprintf(ubuntu, "ubuntu.grub%d", suffix);

    FILE *fd=0;
    fd=fopen(ubuntu, "wb");
    if(!fd)
    {
        fprintf(stderr, "Count not open %s to write.\n", ubuntu);
        getchar();
        return -1;
    }

    fwrite(grub, 1, 512, fd);
    fclose(fd);
    fprintf(stderr, "write to %s\n", ubuntu);

    fprintf(stderr, "Press any key to quit...\n");
    getchar();
	return 0;
}



int get_grub_from_mainpartition(_int64 base, unsigned char buffer[])
{
    int ret=ReadSectors(driver, base, nrsector, (LPBYTE)buffer);
    if(!ret)
        return -1;
    printf("maybe the grub sector:\n");
    show_sector_detail((struct mbr *)buffer);

    if(buffer[0x1fe]==0x55 && buffer[0x1ff]==0xaa)
        return 1;
    else
        return 0;
}


int get_grub_from_expartition(_int64 base, unsigned char buffer[], int *suffix)
{
    _int64 next_read=base;
    _int64 last_logical=base;

    struct mbr *mbr=(struct mbr *)buffer;

    *suffix=4;
    // the extended and logical partition
    while(1)
    {
        (*suffix)++;

        // the extended mbr is relavitive to mbr in the first sector of the driver
        int ret=ReadSectors(driver, next_read, nrsector, (LPBYTE)buffer);
        if(!ret)
            return -1;
        show_sector_detail(mbr);

        for(int i=0; i<2; i++)
        {
            switch(mbr->dpt[i].type)
            {
            case ext4:
            {
                // but the dbr is relavitive to the mbr in extended partition chains
                _int64 from=last_logical+mbr->dpt[i].start;
                ret=ReadSectors(driver, from, nrsector, (LPBYTE)buffer);
                if(!ret)
                    return -1;
                printf("maybe the grub sector:\n");
                show_sector_detail((struct mbr *)buffer);

                if(buffer[0x1fe]==0x55 && buffer[0x1ff]==0xaa)
                    return 1;

                break;
            }
            case logical:
                next_read=base+mbr->dpt[i].start;
                break;
            case 0:
                return 0;
            }
        }
        last_logical=next_read;
    }

}

BOOL ReadSectors(BYTE bDrive, _int64 dwStartSector, WORD wSectors, LPBYTE lpSectBuff)
{
	if (bDrive < 0)
		return FALSE;

	char devName[] = "\\\\.\\PHYSICALDRIVE0";
	devName[strlen(devName) - 1] = devName[strlen(devName) - 1] + bDrive;


	HANDLE hDev = CreateFileA(devName, GENERIC_READ, FILE_SHARE_WRITE | FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_FLAG_NO_BUFFERING, NULL);
	if (hDev == INVALID_HANDLE_VALUE)
	{
		DWORD dwle=GetLastError();
		fprintf(stderr, "createfile error code: %d\n", dwle);
		return 0;
	}

    LARGE_INTEGER li;
    li.QuadPart=dwStartSector*512;

    SetFilePointerEx(hDev, li, NULL, FILE_BEGIN);


	DWORD dwCB;
	BOOL bRet = ReadFile(hDev, lpSectBuff, 512 * wSectors, &dwCB, NULL);
	CloseHandle(hDev);

	return bRet;
}


void show_sector_detail(struct mbr *mbr)
{
	for(int i=0; i<512; i++)
	{
		if(i%16==0)
			printf("%04X: ",i);

		printf("%02X ",((unsigned char *)mbr)[i]);

		if(i%16==15)
			printf("\n");
	}
    printf("\n");


    for(int i=0; i<4; i++)
    {
        printf("dpt%d\n", i+1);
        printf("active = 0x%02x\n", mbr->dpt[i].active);
        printf("type = %u\n", mbr->dpt[i].type);
        printf("sector start = 0x%08x\n", mbr->dpt[i].start);
        printf("sector length = 0x%08x\n\n", mbr->dpt[i].length);
    }

}

