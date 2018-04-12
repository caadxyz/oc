
%{
#include <BRepAlgoAPI_BooleanOperation.hxx>
#include <BRepAlgoAPI_Fuse.hxx>
#include <BRepAlgoAPI_Common.hxx>
#include <BRepAlgoAPI_Cut.hxx>
#include <BRepAlgoAPI_Section.hxx>
     %}

class BRepAlgoAPI_BooleanOperation: public BRepBuilderAPI_MakeShape
{
	%rename(modified) Modified;
	%rename(isDeleted) IsDeleted;
	%rename(generated) Generated;
	%rename(hasModified) HasModified;
	%rename(hasGenerated) HasGenerated;
	%rename(hasDeleted) HasDeleted;
	BRepAlgoAPI_BooleanOperation()=0;
	public:
	virtual const TopTools_ListOfShape& Modified(const TopoDS_Shape& aS) ;
	virtual Standard_Boolean IsDeleted(const TopoDS_Shape& aS) ;
	virtual const TopTools_ListOfShape& Generated(const TopoDS_Shape& S) ;
	virtual Standard_Boolean HasModified() const;
	virtual Standard_Boolean HasGenerated() const;
	virtual Standard_Boolean HasDeleted() const;
};

class BRepAlgoAPI_Fuse: public BRepAlgoAPI_BooleanOperation
{
	public:
	BRepAlgoAPI_Fuse(const TopoDS_Shape& S1,const TopoDS_Shape& S2);
};

class BRepAlgoAPI_Common: public BRepAlgoAPI_BooleanOperation
{
	public:
	BRepAlgoAPI_Common(const TopoDS_Shape& S1,const TopoDS_Shape& S2);
};

class BRepAlgoAPI_Cut: public BRepAlgoAPI_BooleanOperation
{
	public:
	BRepAlgoAPI_Cut(const TopoDS_Shape& S1,const TopoDS_Shape& S2);
};

class BRepAlgoAPI_Section: public BRepAlgoAPI_BooleanOperation
{
	public:
	BRepAlgoAPI_Section(const TopoDS_Shape& S1,const TopoDS_Shape& S2);
};
