
%{
#include <BRepBuilderAPI_Transform.hxx>
#include <BRepBuilderAPI_ModifyShape.hxx>
#include <BRepBuilderAPI_MakeShape.hxx>
#include <BRepBuilderAPI_MakeShell.hxx>
#include <BRepBuilderAPI_MakeWire.hxx>
#include <BRepBuilderAPI_MakeVertex.hxx>
#include <BRepBuilderAPI_MakeEdge.hxx>
#include <BRepBuilderAPI_MakeFace.hxx>
#include <BRepBuilderAPI_MakeSolid.hxx>
#include <BRepBuilderAPI_NurbsConvert.hxx>
#include <Standard_Version.hxx>
#if OCC_VERSION_MAJOR >= 6
#include <BRepBuilderAPI_Sewing.hxx>
#else
#include <BRepAlgo_Sewing.hxx>
#define BRepBuilderAPI_Sewing BRepAlgo_Sewing
#endif
%}

enum BRepBuilderAPI_EdgeError {
  BRepBuilderAPI_EdgeDone,
  BRepBuilderAPI_PointProjectionFailed,
  BRepBuilderAPI_ParameterOutOfRange,
  BRepBuilderAPI_DifferentPointsOnClosedCurve,
  BRepBuilderAPI_PointWithInfiniteParameter,
  BRepBuilderAPI_DifferentsPointAndParameter,
  BRepBuilderAPI_LineThroughIdenticPoints};

enum BRepBuilderAPI_FaceError {
  BRepBuilderAPI_FaceDone,
  BRepBuilderAPI_NoFace,
  BRepBuilderAPI_NotPlanar,
  BRepBuilderAPI_CurveProjectionFailed,
  BRepBuilderAPI_ParametersOutOfRange};

enum BRepBuilderAPI_WireError {
  BRepBuilderAPI_WireDone,
  BRepBuilderAPI_EmptyWire,
  BRepBuilderAPI_DisconnectedWire,
  BRepBuilderAPI_NonManifoldWire};

enum BRepBuilderAPI_ShellError {
  BRepBuilderAPI_ShellDone,
  BRepBuilderAPI_EmptyShell,
  BRepBuilderAPI_DisconnectedShell,
  BRepBuilderAPI_ShellParametersOutOfRange};

class BRepBuilderAPI_Command
{
	%rename(isDone) IsDone;
	BRepBuilderAPI_Command()=0;
	public:
	virtual Standard_Boolean  IsDone() const;
};

class BRepBuilderAPI_MakeShape: public BRepBuilderAPI_Command
{
	//Hide the constructor to make this class abstract
	BRepBuilderAPI_MakeShape()=0;
	public:
	%rename(build) Build;
	%rename(shape) Shape;
	virtual void Build();
	virtual const TopoDS_Shape& Shape();
};

class BRepBuilderAPI_ModifyShape: public BRepBuilderAPI_MakeShape
{
	%rename(modifiedShape) ModifiedShape;
	BRepBuilderAPI_ModifyShape()=0;
	public:
	virtual TopoDS_Shape ModifiedShape(const TopoDS_Shape& S) const;
};

class BRepBuilderAPI_Transform : public BRepBuilderAPI_ModifyShape
{
	%rename(perform) Perform;
	public:
	BRepBuilderAPI_Transform(const gp_Trsf& T);
	BRepBuilderAPI_Transform(const TopoDS_Shape& S,	const gp_Trsf& T,
		const Standard_Boolean Copy = Standard_False);
	void Perform(const TopoDS_Shape& S,
		const Standard_Boolean Copy = Standard_False) ;
};

class BRepBuilderAPI_MakeVertex: public BRepBuilderAPI_MakeShape
{
	%rename(vertex) Vertex;
	public:
	BRepBuilderAPI_MakeVertex(const gp_Pnt& P);
	//const TopoDS_Vertex& Vertex() const;
};

class BRepBuilderAPI_MakeWire : public BRepBuilderAPI_MakeShape
{
	%rename(wire) Wire;
	%rename(add) Add;
	%rename(isDone) IsDone;
	public:
	BRepBuilderAPI_MakeWire();
	BRepBuilderAPI_MakeWire(const TopoDS_Edge& E);
	BRepBuilderAPI_MakeWire(const TopoDS_Edge& E1,const TopoDS_Edge& E2);
	BRepBuilderAPI_MakeWire(const TopoDS_Edge& E1,const TopoDS_Edge& E2,
		const TopoDS_Edge& E3);
	BRepBuilderAPI_MakeWire(const TopoDS_Edge& E1,const TopoDS_Edge& E2,
		const TopoDS_Edge& E3,const TopoDS_Edge& E4);
	BRepBuilderAPI_MakeWire(const TopoDS_Wire& W);
	BRepBuilderAPI_MakeWire(const TopoDS_Wire& W,const TopoDS_Edge& E);
	void Add(const TopoDS_Edge& E) ;
	void Add(const TopoDS_Wire& W) ;
	void Add(const TopTools_ListOfShape & shapes);
	Standard_Boolean IsDone() const;
	BRepBuilderAPI_WireError Error() const;
	//const TopoDS_Wire& Wire() const;
};

class BRepBuilderAPI_MakeShell : public BRepBuilderAPI_MakeShape
{
	%rename(shell) Shell;
	%rename(add) Add;
	%rename(isDone) IsDone;
	public:
	BRepBuilderAPI_MakeShell();
	Standard_Boolean IsDone() const;
	BRepBuilderAPI_ShellError Error() const;
	//const TopoDS_Shell& Shell() const;
};

class BRepBuilderAPI_MakeEdge : public BRepBuilderAPI_MakeShape
{
	%rename(edge) Edge;
	%rename(isDone) IsDone;
	public:
	BRepBuilderAPI_MakeEdge();
	BRepBuilderAPI_MakeEdge(const Handle_Geom_Curve& L);
	BRepBuilderAPI_MakeEdge(const TopoDS_Vertex& V1,const TopoDS_Vertex& V2);
	BRepBuilderAPI_MakeEdge(const gp_Pnt& P1,const gp_Pnt& P2);
	BRepBuilderAPI_MakeEdge(const gp_Circ& L);
	BRepBuilderAPI_MakeEdge(const gp_Circ& L,const Standard_Real p1,const Standard_Real p2);
	BRepBuilderAPI_MakeEdge(const gp_Circ& L,const gp_Pnt& P1,const gp_Pnt& P2);
	BRepBuilderAPI_MakeEdge(const gp_Circ& L,const TopoDS_Vertex& V1,const TopoDS_Vertex& V2);
	BRepBuilderAPI_MakeEdge(const gp_Parab& L);
	BRepBuilderAPI_MakeEdge(const gp_Parab& L,const Standard_Real p1,const Standard_Real p2);
	BRepBuilderAPI_MakeEdge(const gp_Parab& L,const gp_Pnt& P1,const gp_Pnt& P2);
	BRepBuilderAPI_MakeEdge(const gp_Parab& L,const TopoDS_Vertex& V1,const TopoDS_Vertex& V2);
	BRepBuilderAPI_MakeEdge(const Handle_Geom_Curve& L, const TopoDS_Vertex& V1,const TopoDS_Vertex& V2);
	BRepBuilderAPI_MakeEdge(const Handle_Geom_Curve& L, const TopoDS_Vertex& V1,const TopoDS_Vertex& V2,const Standard_Real p1,const Standard_Real p2);
	BRepBuilderAPI_MakeEdge(const Handle_Geom_Curve& L, const Standard_Real p1,const Standard_Real p2);
    // 2d curves
	BRepBuilderAPI_MakeEdge(const Handle_Geom2d_Curve& L, const Handle_Geom_Surface& S, const Standard_Real p1,const Standard_Real p2);
	Standard_Boolean IsDone() const;
	BRepBuilderAPI_EdgeError Error() const;
	//const TopoDS_Edge& Edge() const;
};

class BRepBuilderAPI_MakeFace  : public BRepBuilderAPI_MakeShape
{
	%rename(face) Face;
	public:
	BRepBuilderAPI_MakeFace(const TopoDS_Wire& W,
		const Standard_Boolean OnlyPlane = Standard_False);
    BRepBuilderAPI_MakeFace(const TopoDS_Face& F,const TopoDS_Wire& W);
    BRepBuilderAPI_MakeFace(const Handle_Geom_Surface& S,const TopoDS_Wire& W, const Standard_Boolean Inside = Standard_True );
    BRepBuilderAPI_MakeFace(const Handle_Geom_Surface& S, const Standard_Real Umin, const Standard_Real Umax, 
        const Standard_Real Vmin, const Standard_Real Vmax, const Standard_Real tolDegen); 
    Standard_Boolean IsDone() const;
    BRepBuilderAPI_FaceError Error() const;
	//const TopoDS_Face& Face() const;
};

class BRepBuilderAPI_MakeSolid: public BRepBuilderAPI_MakeShape
{
	%rename(add) Add;
	%rename(isDone) IsDone;
	%rename(isDeleted) IsDeleted;
	public:
	BRepBuilderAPI_MakeSolid();
	BRepBuilderAPI_MakeSolid(const TopoDS_CompSolid& S);
	BRepBuilderAPI_MakeSolid(const TopoDS_Shell& S);
	BRepBuilderAPI_MakeSolid(const TopoDS_Shell& S1,const TopoDS_Shell& S2);
	BRepBuilderAPI_MakeSolid(const TopoDS_Shell& S1,const TopoDS_Shell& S2,const TopoDS_Shell& S3);
	BRepBuilderAPI_MakeSolid(const TopoDS_Solid& So);
	BRepBuilderAPI_MakeSolid(const TopoDS_Solid& So,const TopoDS_Shell& S);
	void Add(const TopoDS_Shell& S) ;
	Standard_Boolean IsDone() const;
	Standard_Boolean IsDeleted(const TopoDS_Shape& S) ;
};

class BRepBuilderAPI_Sewing
{
	public:
	
	%rename(init) Init;
	%rename(add) Add;
	%rename(perform) Perform;
	%rename(sewedShape) SewedShape;

	%rename(load) Load;
	%rename(nbFreeEdges) NbFreeEdges;
	%rename(freeEdge) FreeEdge;
	%rename(nbMultipleEdges) NbMultipleEdges;
	%rename(multipleEdge) MultipleEdge;
	%rename(nbDegeneratedShapes) NbDegeneratedShapes;
	%rename(degeneratedShape) DegeneratedShape;
	%rename(nbDeletedFaces) NbDeletedFaces;
	%rename(deletedFace) DeletedFace;
	%rename(isDegenerated) IsDegenerated;
	%rename(isModified) IsModified;
	%rename(modified) Modified;
	%rename(dump) Dump;

	%rename(isModifiedSubShape) IsModifiedSubShape;
	%rename(modifiedSubShape) ModifiedSubShape;

	BRepBuilderAPI_Sewing(const Standard_Real tolerance = 1.0e-06,
		const Standard_Boolean option = Standard_True,
		const Standard_Boolean cutting = Standard_True,
		const Standard_Boolean nonmanifold = Standard_False);
	void Init(const Standard_Real tolerance,
		const Standard_Boolean option = Standard_True,
		const Standard_Boolean cutting = Standard_True,
		const Standard_Boolean nonmanifold = Standard_False) ;
	void Load(const TopoDS_Shape& shape) ;
	void Add(const TopoDS_Shape& shape) ;
	void Perform() ;
	const TopoDS_Shape& SewedShape() const;
	Standard_Integer NbFreeEdges() const;
	const TopoDS_Edge& FreeEdge(const Standard_Integer index) const;
	Standard_Integer NbMultipleEdges() const;
	const TopoDS_Edge& MultipleEdge(const Standard_Integer index) const;
	Standard_Integer NbDegeneratedShapes() const;
	const TopoDS_Shape& DegeneratedShape(const Standard_Integer index) const;
	Standard_Integer NbDeletedFaces() const;
	const TopoDS_Face& DeletedFace(const Standard_Integer index) const;
	Standard_Boolean IsDegenerated(const TopoDS_Shape& shape) const;
	Standard_Boolean IsModified(const TopoDS_Shape& shape) const;
	const TopoDS_Shape& Modified(const TopoDS_Shape& shape) const;
	void Dump() const;

	Standard_Boolean IsModifiedSubShape(const TopoDS_Shape& shape) const;
	TopoDS_Shape ModifiedSubShape(const TopoDS_Shape& shape) const;
};

class BRepBuilderAPI_NurbsConvert : public BRepBuilderAPI_ModifyShape
{
	%rename(perform) Perform;
	public:
	BRepBuilderAPI_NurbsConvert();
	BRepBuilderAPI_NurbsConvert(const TopoDS_Shape& S,
		const Standard_Boolean Copy = Standard_False);
	void Perform(const TopoDS_Shape& S,
		const Standard_Boolean Copy = Standard_False) ;
};
