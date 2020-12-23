terraform/deployment/heroku-vault.tar.gz: $(wildcard src/**/*)
	tar -czf $@ src
