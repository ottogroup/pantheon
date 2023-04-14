.PHONY: fmt docs

fmt:
	terraform fmt -recursive terraform/
docs:
	terraform-docs markdown --output-file README.md --recursive terraform
	rm terraform/README.md # it is empty
