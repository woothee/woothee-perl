all: test

testsets:
	git submodule update --init

checkyaml: testsets
	perl woothee/bin/dataset_checker.pl

lib/Woothee/DataSet.pm: checkyaml
	perl maint/dataset_yaml2pm.pl
	sync; sync; sync;

test: lib/Woothee/DataSet.pm
	test -d t/testsets || mkdir t/testsets
	cp woothee/testsets/*.yaml t/testsets
	prove -Ilib
