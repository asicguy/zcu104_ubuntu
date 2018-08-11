#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/pedro/github/zcu104_ubuntu/hls/cholesky_inverse/csynth/solution1/.autopilot/db/a.g.bc ${1+"$@"}
