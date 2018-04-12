
%{
#include <TColStd_HArray1OfBoolean.hxx>
%}

%{
#include <TColgp_HArray1OfPnt.hxx>
%}

class TColgp_HArray1OfPnt {

  public:
  TColgp_HArray1OfPnt(const Standard_Integer Low,const Standard_Integer Up);
  void SetValue(const Standard_Integer Index,const gp_Pnt& Value);
};

/**
%rename(TColgp_HArray1OfPnt) Handle_TColgp_HArray1OfPnt;
 */
class Handle_TColgp_HArray1OfPnt
{
	Handle_TColgp_HArray1OfPnt()=0;
};

class Handle_TColStd_HArray1OfBoolean
{
	Handle_TColStd_HArray1OfBoolean()=0;
};

%{
#include <TColgp_Array1OfVec.hxx>
  %}
class TColgp_Array1OfVec {

  public:
  TColgp_Array1OfVec(const Standard_Integer Low,const Standard_Integer Up);
  void SetValue(const Standard_Integer Index,const gp_Vec& Value);
};

%{
#include <TColgp_Array1OfPnt2d.hxx>
  %}

class TColgp_Array1OfPnt2d {
 public:
  TColgp_Array1OfPnt2d(const Standard_Integer theLower, const Standard_Integer theUpper);
  void SetValue(const Standard_Integer theIndex, const gp_Pnt2d& Value);
};

%{
#include <TColStd_Array1OfReal.hxx>
  %}

class TColStd_Array1OfReal {
 public:
  TColStd_Array1OfReal(const Standard_Integer theLower, const Standard_Integer theUpper);
  void SetValue(const Standard_Integer theIndex, const Standard_Real& Value);
};
%{
#include <TColStd_Array1OfInteger.hxx>
  %}
class TColStd_Array1OfInteger {
 public:
  TColStd_Array1OfInteger(const Standard_Integer theLower, const Standard_Integer theUpper);
  void SetValue(const Standard_Integer theIndex, const Standard_Integer& Value);
};
%{
#include <TColgp_Array1OfPnt.hxx>
  %}
class TColgp_Array1OfPnt {

  public:
  TColgp_Array1OfPnt(const Standard_Integer Low,const Standard_Integer Up);
  const gp_Pnt Value(const Standard_Integer Index);
  void SetValue(const Standard_Integer Index,const gp_Pnt& Value);
  Standard_Integer Lower (void) const;
  Standard_Integer Upper (void) const;
};
%{
#include <TColgp_Array2OfPnt.hxx>
  %}
class TColgp_Array2OfPnt {
 public:
  TColgp_Array2OfPnt(const Standard_Integer theRowLower,
		     const Standard_Integer theRowUpper,
		     const Standard_Integer theColLower,
		     const Standard_Integer theColUpper);
  void SetValue(const Standard_Integer theRow,
		const Standard_Integer theCol,
		const gp_Pnt& Value);
};
%{
#include <TColStd_Array2OfReal.hxx>
  %}
class TColStd_Array2OfReal {
 public:
  TColStd_Array2OfReal(const Standard_Integer theRowLower,
		       const Standard_Integer theRowUpper,
		       const Standard_Integer theColLower,
		       const Standard_Integer theColUpper);
  void SetValue(const Standard_Integer theRow,
		const Standard_Integer theCol,
		const Standard_Real& Value);
};