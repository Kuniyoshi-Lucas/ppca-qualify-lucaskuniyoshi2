
HOME_DIR = $(shell echo `pwd`)
CONTAINERNAME = qualifyLucas
REVISION_BRANCH = revision
MAIN_BRANCH = main

all: init pdf finish

init: 
	echo $(HOME_DIR)
	docker run --detach --interactive --tty --name $(CONTAINERNAME) --workdir $(HOME_DIR) --volume $(HOME_DIR):/$(HOME_DIR) andrelanna/texlivefull bash

pdf:  
	docker exec --interactive --tty $(CONTAINERNAME) pdflatex monografia.tex
	docker exec --interactive --tty $(CONTAINERNAME) bibtex monografia
	docker exec --interactive --tty $(CONTAINERNAME) pdflatex monografia.tex
	docker exec --interactive --tty $(CONTAINERNAME) pdflatex monografia.tex

revision: 
	echo $(MAIN_BRANCH)

finish: 
	docker rm -f $(CONTAINERNAME)
	rm -v *.acn
	rm -v *.aux
	rm -v *.glo
	rm -v *.glsdefs
	rm -v *.ist
	rm -v *.lof
	rm -v *.log
	rm -v *.lot
	rm -v *.out
	rm -v *.toc
