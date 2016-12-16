exe=seminar.pdf

xetex=seminar.tex

#obj=*.aux *.log *.out *.snm *.nav *.toc
obj=$(exe:%.pdf=%.aux)
obj+=$(exe:%.pdf=%.log)
obj+=$(exe:%.pdf=%.out)
obj+=$(exe:%.pdf=%.snm)
obj+=$(exe:%.pdf=%.nav)
obj+=$(exe:%.pdf=%.toc)


all: $(exe)

$(exe): $(xetex)
	xelatex $^


clean:
	- $(RM) $(obj) $(exe)

.PHONY: all clean

