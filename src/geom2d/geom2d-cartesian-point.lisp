(in-package :oc)

(defmethod initialize-instance :after ((instance geom2d-cartesian-point) &rest initargs
				       &key P X Y)
  (let ((ff-pointer
	 (cond ((and (gp:pnt2d-p P) (not X) (not Y))
		(_wrap_new_Geom2d_CartesianPoint__SWIG_0 (ptr P)))
	       ((and (null P) X Y)
		(_wrap_new_Geom2d_CartesianPoint__SWIG_1 (coerce X 'double-float) (coerce Y 'double-float)))
	       (t (error "Invalid initargs to Geom2d_CartesianPoint: ~S" initargs)))))
    (setf (ff-pointer instance) ff-pointer)
    (oc:finalize instance)
    (values)))

(defmethod (setf coord2) ((x real) (y real) (point geom2d-cartesian-point))
  (_wrap_Geom2d_CartesianPoint_SetCoord (ff-pointer point) (coerce x 'double-float) (coerce y 'double-float)))

(defmethod (setf geom-processor) ((p gp:pnt2d) (point geom2d-cartesian-point))
  (_wrap_Geom2d_CartesianPoint_SetPnt2d (ff-pointer point) (ptr p))
  p)

(defmethod (setf x) ((x real) (point geom2d-cartesian-point))
  (_wrap_Geom2d_CartesianPoint_SetX (ff-pointer point) (coerce x 'double-float))
  x)

(defmethod (setf y) ((y real) (point geom2d-cartesian-point))
  (_wrap_Geom2d_CartesianPoint_SetY (ff-pointer point) (coerce y 'double-float))
  y)
