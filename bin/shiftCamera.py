#!/usr/bin/env python

import os
import sys

def main(argv = sys.argv):
    if len(argv) < 3:
        print "usage:", argv[0], "orig_folder shifted_folder [shift, default 6]"
        print "ex:", argv[0], "auo_logo_02 auo_logo_02_shifted"
        return -1
    src = os.path.abspath(argv[1])
    tgt = os.path.abspath(argv[2])
    if not os.path.exists(src):
        print src, "does not exist!"
        return -1
    try:
        os.makedirs(tgt)
    except:
        if not os.path.exists(tgt):
            print tgt, "does not exist!"
            return -1
    try:
        os.chmod(tgt, 0777)
    except:
        pass

    shift = 6
    if len(argv) > 3:
        shift = argv[3]

    print "shift", shift, "cameras from", argv[1], "to", argv[2]
    for i in range(12):
        srcfolder = os.path.join(src, "stereoCamera%d" % i)
        tgtfolder = os.path.join(tgt, "stereoCamera%d" % ((i+shift)%12))
        os.symlink(srcfolder, tgtfolder)
    return 0

if __name__ == '__main__':
    sys.exit(main())

# vim: set hls is et sw=4 sts=4 nu:
