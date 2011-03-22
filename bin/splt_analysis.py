#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import string

def getMetaFiles( path ):
    metaFiles = os.listdir( path )
    metaFiles = filter( lambda f: os.path.isfile(f), metaFiles )
    return metaFiles

def separateMetaFiles(metaFiles):
    def inner_filter( s, t ):
	if s.find( t ) == -1:
	    return 0
	return 1

    charFiles = filter( lambda f: inner_filter(f, '_ch_'), metaFiles )
    propFiles = filter( lambda f: inner_filter(f, '_prop_'), metaFiles )
    setFiles = filter( lambda f: inner_filter(f, '_set_'), metaFiles )
    return [charFiles, propFiles, setFiles]

def getSpltFiles( metaFile ):
    result = ''
    f = open( metaFile, 'r' )
    line = f.readline()
    while line:
	line = line.strip()
	if line.endswith('.splt'):
	    result = line
	    break
	line = f.readline()

    f.close()
    return result

if __name__ == '__main__':
    if len(sys.argv) < 2:
	print 'usage:'
	print sys.argv[0] + ' splt_meta_path1 spl_meta_path2 ...'
	print 'ex:'
	print sys.argv[0] + ' //3dnfs/shows/np/prod/surface/meta'
	sys.exit(-1)

    for arg in sys.argv[1:]:
	metaFiles = getMetaFiles( arg )
	charMetaFiles, propMetaFiles, setMetaFiles = separateMetaFiles( metaFiles )

	charSpltFiles = map( getSpltFiles, charMetaFiles )
	propSpltFiles = map( getSpltFiles, propMetaFiles )
	setSpltFiles = map( getSpltFiles, setMetaFiles )
	allSpltFiles = map( getSpltFiles, metaFiles )

	s = ''
	for splt in allSpltFiles:
	    s += splt + ' '
	print s
