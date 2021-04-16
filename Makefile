generate-doc:
	cp README-head.md README.md
	helm-docs -d >> README.md