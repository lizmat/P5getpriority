use v6.*;

unit module P5getpriority:ver<0.0.8>:auth<zef:lizmat>;

use NativeCall;

my sub getpriority(Int() $which, Int() $who) is export {
    sub _getpriority(int32, int32 --> int32) is native is symbol<getpriority> {*}
    my int32 $nwhich = $which;
    my int32 $nwho   = $who;
    _getpriority($nwhich, $nwho)
}

my sub setpriority(Int() $which, Int() $who, Int() $prio) is export {
    sub _setpriority(int32, int32, int32 --> int32)
      is native
      is symbol<setpriority> {*}
    my int32 $nwhich = $which;
    my int32 $nwho   = $who;
    my int32 $nprio  = $prio;
    _setpriority($nwhich, $nwho, $nprio)
}

my sub getppid(--> uint32) is native is export {*}
my sub getpgrp(--> uint32) is native is export {*}

my sub setpgrp(Int() $pid, Int() $pgid) is export {
    sub _setpgrp(int32, int32 --> int32) is native is symbol<setpgrp> {*}
    my int32 $npid  = $pid;
    my int32 $npgid = $pgid;
    _setpgrp($npid, $npgid)
}

=begin pod

=head1 NAME

Raku port of Perl's getpriority() and associated built-ins

=head1 SYNOPSIS

    use P5getpriority; # exports getpriority, setpriority, getppid, getpgrp

    say "My parent process priority is &getpriority(0, getppid())";

    say "My process priority is &getpriority(0, $*PID)";

    say "My process group has priority &getpriority(1, getpgrp())";

    say "My user priority is &getpriority(2, $*USER)";

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<getpriority> and associated
built-ins as closely as possible in the Raku Programming Language.

It exports by default:

    getpgrp getppid getpriority setpgrp setpriority

=head1 ORIGINAL PERL 5 DOCUMENTATION

    getpriority WHICH,WHO
            Returns the current priority for a process, a process group, or a
            user. (See getpriority(2).) Will raise a fatal exception if used
            on a machine that doesn't implement getpriority(2).

    setpriority WHICH,WHO,PRIORITY
            Sets the current priority for a process, a process group, or a
            user. (See setpriority(2).) Raises an exception when used on a
            machine that doesn't implement setpriority(2).

    getpgrp PID
            Returns the current process group for the specified PID. Use a PID
            of 0 to get the current process group for the current process.
            Will raise an exception if used on a machine that doesn't
            implement getpgrp(2). If PID is omitted, returns the process group
            of the current process. Note that the POSIX version of "getpgrp"
            does not accept a PID argument, so only "PID==0" is truly
            portable.

    setpgrp PID,PGRP
            Sets the current process group for the specified PID, 0 for the
            current process. Raises an exception when used on a machine that
            doesn't implement POSIX setpgid(2) or BSD setpgrp(2). If the
            arguments are omitted, it defaults to "0,0". Note that the BSD 4.2
            version of "setpgrp" does not accept any arguments, so only
            "setpgrp(0,0)" is portable. See also "POSIX::setsid()".

    getppid Returns the process id of the parent process.

            Note for Linux users: Between v5.8.1 and v5.16.0 Perl would work
            around non-POSIX thread semantics the minority of Linux systems
            (and Debian GNU/kFreeBSD systems) that used LinuxThreads, this
            emulation has since been removed. See the documentation for $$ for
            details.

=head1 PORTING CAVEATS

This module depends on the availability of POSIX semantics.  This is
generally not available on Windows, so this module will probably not work
on Windows.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5getpriority . Comments
and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
