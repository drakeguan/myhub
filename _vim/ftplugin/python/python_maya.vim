" Only do this when not done yet for this buffer
if exists("b:loaded_py_maya")
  finish
endif
let b:loaded_py_maya = 1

python << EOF
import vim

_tempFile = "/tmp/pythonToMaya.py"
_init = False
_maya = None

def PyMayaInit():
    global _maya
    global _init

    import socket
    _maya = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
	_maya.connect(("127.0.0.1", 6000))
    except socket.error, e:
	return
    _init = True

def PyMayaHandleLines(lines):
    return lines

def PyMayaWriteOut(txt):
    f = open(_tempFile, "w")
    f.write(txt)
    f.close()

def PyMayaSubmitIt(txt):
    if not _init:
	return
    PyMayaWriteOut(txt)
    _maya.send('python("pythonCall()")')

def PyMayaLine():
    line = vim.current.line + "\n"
    PyMayaSubmitIt(line)

def PyMayaRange():
    range = vim.current.range
    lines = ""
    for line in range:
	lines += line + "\n"
    PyMayaSubmitIt(lines)

EOF

vmap <C-M> :python PyMayaRange()<C-M>
nmap <C-M> :python PyMayaLine()<C-M>

python PyMayaInit()
