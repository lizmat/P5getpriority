use v6.*;
use Test;
use P5getpriority;

my @supported = <
  getpgrp getppid getpriority setpgrp setpriority
>.map: '&' ~ *;

plan @supported * 2;

for @supported {
    ok defined(::($_)),             "is $_ imported?";
    nok P5getpriority::{$_}:exists, "is $_ NOT externally accessible?";
}

# vim: expandtab shiftwidth=4
