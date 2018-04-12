import numpy as np
cimport numpy as cnp
from libc.stdlib cimport free

cdef extern from "matrix.h":
    float *make_matrix_c(int nrows, int ncols)

cdef class _finalizer:
    cdef void *_data
    def __dealloc__(self):
        if self._data != NULL:
            free(self._data)
            
cdef void set_base(cnp.ndarray arr, void *carr):
    cdef _finalizer f = _finalizer()
    f._data = <void*>carr
    cnp.set_array_base(arr, f)
            
def make_matrix(int nrows, int ncols):
    cdef float *mat = make_matrix_c(nrows, ncols)            
    cdef float[:, ::1] mv = <float[:nrows, :ncols]>mat
    cdef cnp.ndarray arr = np.asarray(mv)
    set_base(arr, mat) # Defining the dealloc for the object
    return arr