from distutils.core import setup
from Cython.Build import cythonize

setup(    
	name = 'fib',
	version = '0.0.0',
	ext_modules=cythonize('fib.pyx'))
