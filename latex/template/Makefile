exe=recalg.pdf

beamer=$(exe:%.pdf=%.tex)
#obj=*.aux *.log *.out *.snm *.nav *.toc
obj=$(exe:%.pdf=%.aux)
obj+=$(exe:%.pdf=%.log)
obj+=$(exe:%.pdf=%.out)
obj+=$(exe:%.pdf=%.snm)
obj+=$(exe:%.pdf=%.nav)
obj+=$(exe:%.pdf=%.toc)



all: $(exe)

$(exe): $(beamer)
	xelatex $^

clean:
	- $(RM) $(obj)

clean-all:
	- $(RM) $(obj) $(exe)


.PHONY: all clean clean-all

