image := $(shell grep -rh "image" manifest | cut -d ":" -f2- | sed -e 's/^[[:space:]]*//')
kind_name := chart-testing


prepare: 
	docker pull $(image)
	kind load docker-image $(image) --name $(kind_name)

run: prepare
	kubectl apply -f manifest
	@bash .validate/helper.sh

all: run
	@bash .validate/validate-rule1.sh
	@bash .validate/validate-rule2.sh
	



