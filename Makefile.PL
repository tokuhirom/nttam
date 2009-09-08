use inc::Module::Install;
name 'Nttam';
all_from 'lib/Nttam.pm';

requires 'Moose';
requires 'Plack';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
