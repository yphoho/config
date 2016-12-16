exe=xetex.pdf beamer.pdf

xetex=xetex.tex
beamer=beamer.tex

#obj=*.aux *.log *.out *.snm *.nav *.toc
obj=$(exe:%.pdf=%.aux)
obj+=$(exe:%.pdf=%.log)
obj+=$(exe:%.pdf=%.out)
obj+=$(exe:%.pdf=%.snm)
obj+=$(exe:%.pdf=%.nav)
obj+=$(exe:%.pdf=%.toc)


all: $(exe)

xetex.pdf: $(xetex)
	xelatex $^

beamer.pdf: $(beamer)
	pdflatex $^


clean:
	- $(RM) $(obj) $(exe)

.PHONY: all clean

