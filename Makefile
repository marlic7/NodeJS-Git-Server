TESTS = test
REPORTER = spec
XML_FILE = reports/TEST-all.xml
HTML_FILE = reports/coverage.html
 
test: test-mocha
 
test-ci:
	$(MAKE) test-mocha REPORTER=xUnit > $(XML_FILE)
 
test-all: clean test-ci test-cov
 
test-mocha:
	@NODE_ENV=test @GIT_SSL_NO_VERIFY=true mocha \
	    --timeout 100000 \
		--reporter $(REPORTER) \
		$(TESTS)
 
test-cov: lib-cov
	@APP_COVERAGE=1 $(MAKE) test-mocha REPORTER=html-cov > $(HTML_FILE)
 
lib-cov:
	jscoverage . lib-cov
 
clean:
	rm -f reports/*
	rm -fr lib-cov