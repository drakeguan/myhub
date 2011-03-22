#!/usr/bin/env python
# -*- coding: utf-8 -*-

import optparse
import os
import re
import shutil
import sys
import tempfile

import dgtools

def main(argv=sys.argv[:]):
    USAGE = "%prog -t [2009|8.5|2011] [--noenc] 1.mel 2.mel 3.mel"
    parser = optparse.OptionParser(usage=USAGE)
    parser.add_option("-t", "--target", dest="target", type="string", default="2009")
    parser.add_option("--noenc", dest="noenc", default=False, action="store_true")

    (options, args) = parser.parse_args()
    if 0 == len(args):
        parser.print_usage()
        return -1

    targetRoot = "//3dnfs/shows/dgTools/maya/scripts/%s/" % options.target
    for f in args:
        sourcePath = os.path.abspath(f)
        targetPath = os.path.join(targetRoot, f)
        print f, "==>", targetPath
        if options.noenc:
            shutil.copyfile(sourcePath, targetPath)
        else:
            cmd = "melEncryptor %s %s" % (sourcePath, targetPath)
            dgtools.system(cmd)

if __name__ == '__main__':
    sys.exit(main())

# vim: set hls is et sw=4 sts=4 nu:
