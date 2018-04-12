from distutils.core import setup, Extension
from Cython.Build import cythonize
from numpy import get_include
ext = Extension("numpy_cleanup", ["numpy_cleanup.pyx"],
	include_dirs=['.', get_include()])

setup(name="numpy_cleanup",
	ext_modules = cythonize(ext))