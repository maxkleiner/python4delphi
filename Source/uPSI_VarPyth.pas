unit uPSI_VarPyth;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 

 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_VarPyth = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_VarPyth(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_VarPyth_Routines(S: TPSExec);

procedure Register;

implementation


uses
   Variants
  ,PythonEngine
  ,VarPyth
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_VarPyth]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_VarPyth(CL: TPSPascalCompiler);
begin
  CL.AddTypeS('TSequenceType', '( stTuple, stList )');
 CL.AddDelphiFunction('Function VarPythonCreate0( AObject : PPyObject) : Variant;');
 CL.AddDelphiFunction('Function VarPythonCreate1( const AValue : Variant) : Variant;');
 CL.AddDelphiFunction('Function VarPythonCreate2( const AValues : array of const; ASequenceType : TSequenceType) : Variant;');
 CL.AddDelphiFunction('Function VarPythonEval( const APythonExpression : AnsiString) : Variant');
 CL.AddDelphiFunction('Function VarPython : TVarType');
 CL.AddDelphiFunction('Function VarIsPython( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarAsPython( const AValue : Variant) : Variant');
 CL.AddDelphiFunction('Function ExtractPythonObjectFrom( const AValue : Variant) : PPyObject');
 CL.AddDelphiFunction('Function VarIsSame( const A, B : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsSameType( const A, B : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonSequence( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonMapping( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonNumber( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonString( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonInteger( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonFloat( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonTuple( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonList( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonDict( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonClass( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonMethod( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonFunction( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonModule( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonCallable( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonIterator( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonUnicode( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonDateTime( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonDate( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonTime( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonDateTimeDelta( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsPythonTZInfo( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsBool( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsEnum( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsInstanceOf( const AInstance, AClass : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsSubclassOf( const ADerived, AClass : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsSubtypeOf( const ADerived, AType : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsNone( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarIsTrue( const AValue : Variant) : Boolean');
 CL.AddDelphiFunction('Function VarModuleHasObject( const AModule : Variant; aObj : AnsiString) : Boolean');
 CL.AddDelphiFunction('Function NewPythonList( const ASize : Integer) : Variant');
 CL.AddDelphiFunction('Function NewPythonTuple( const ASize : Integer) : Variant');
 CL.AddDelphiFunction('Function NewPythonDict : Variant');
 CL.AddDelphiFunction('Function VarPythonAsString( AValue : Variant) : string');
 CL.AddDelphiFunction('Function VarPythonToVariant( AValue : Variant) : Variant');
 CL.AddDelphiFunction('Function None : Variant');
 CL.AddDelphiFunction('Function Ellipsis : Variant');
 CL.AddDelphiFunction('Function MainModule : Variant');
 CL.AddDelphiFunction('Function BuiltinModule : Variant');
 CL.AddDelphiFunction('Function SysModule : Variant');
 CL.AddDelphiFunction('Function DatetimeModule : Variant');
 CL.AddDelphiFunction('Function Import( const AModule : AnsiString) : Variant');
 CL.AddDelphiFunction('Function len( const AValue : Variant) : NativeInt');
 CL.AddDelphiFunction('Function _type( const AValue : Variant) : Variant');
 CL.AddDelphiFunction('Function iter( const AValue : Variant) : Variant');
  CL.AddTypeS('TVarPyEnumerator', 'record FIterator : Variant; FCurrent : Varia'
   +'nt; end');
  CL.AddTypeS('TVarPyEnumerateHelper', 'record FIterable : Variant; end');
 CL.AddDelphiFunction('Function VarPyIterate( const AValue : Variant) : TVarPyEnumerateHelper');
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
Function VarPythonCreate2_P( const AValues : array of const; ASequenceType : TSequenceType) : Variant;
Begin Result := VarPyth.VarPythonCreate(AValues, ASequenceType); END;

(*----------------------------------------------------------------------------*)
Function VarPythonCreate1_P( const AValue : Variant) : Variant;
Begin Result := VarPyth.VarPythonCreate(AValue); END;

(*----------------------------------------------------------------------------*)
Function VarPythonCreate0_P( AObject : PPyObject) : Variant;
Begin Result := VarPyth.VarPythonCreate(AObject); END;

(*----------------------------------------------------------------------------*)
procedure RIRegister_VarPyth_Routines(S: TPSExec);
begin
 S.RegisterDelphiFunction(@VarPythonCreate0, 'VarPythonCreate0', cdRegister);
 S.RegisterDelphiFunction(@VarPythonCreate1, 'VarPythonCreate1', cdRegister);
 S.RegisterDelphiFunction(@VarPythonCreate2, 'VarPythonCreate2', cdRegister);
 S.RegisterDelphiFunction(@VarPythonEval, 'VarPythonEval', cdRegister);
 S.RegisterDelphiFunction(@VarPython, 'VarPython', cdRegister);
 S.RegisterDelphiFunction(@VarIsPython, 'VarIsPython', cdRegister);
 S.RegisterDelphiFunction(@VarAsPython, 'VarAsPython', cdRegister);
 S.RegisterDelphiFunction(@ExtractPythonObjectFrom, 'ExtractPythonObjectFrom', cdRegister);
 S.RegisterDelphiFunction(@VarIsSame, 'VarIsSame', cdRegister);
 S.RegisterDelphiFunction(@VarIsSameType, 'VarIsSameType', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonSequence, 'VarIsPythonSequence', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonMapping, 'VarIsPythonMapping', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonNumber, 'VarIsPythonNumber', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonString, 'VarIsPythonString', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonInteger, 'VarIsPythonInteger', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonFloat, 'VarIsPythonFloat', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonTuple, 'VarIsPythonTuple', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonList, 'VarIsPythonList', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonDict, 'VarIsPythonDict', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonClass, 'VarIsPythonClass', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonMethod, 'VarIsPythonMethod', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonFunction, 'VarIsPythonFunction', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonModule, 'VarIsPythonModule', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonCallable, 'VarIsPythonCallable', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonIterator, 'VarIsPythonIterator', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonUnicode, 'VarIsPythonUnicode', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonDateTime, 'VarIsPythonDateTime', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonDate, 'VarIsPythonDate', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonTime, 'VarIsPythonTime', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonDateTimeDelta, 'VarIsPythonDateTimeDelta', cdRegister);
 S.RegisterDelphiFunction(@VarIsPythonTZInfo, 'VarIsPythonTZInfo', cdRegister);
 S.RegisterDelphiFunction(@VarIsBool, 'VarIsBool', cdRegister);
 S.RegisterDelphiFunction(@VarIsEnum, 'VarIsEnum', cdRegister);
 S.RegisterDelphiFunction(@VarIsInstanceOf, 'VarIsInstanceOf', cdRegister);
 S.RegisterDelphiFunction(@VarIsSubclassOf, 'VarIsSubclassOf', cdRegister);
 S.RegisterDelphiFunction(@VarIsSubtypeOf, 'VarIsSubtypeOf', cdRegister);
 S.RegisterDelphiFunction(@VarIsNone, 'VarIsNone', cdRegister);
 S.RegisterDelphiFunction(@VarIsTrue, 'VarIsTrue', cdRegister);
 S.RegisterDelphiFunction(@VarModuleHasObject, 'VarModuleHasObject', cdRegister);
 S.RegisterDelphiFunction(@NewPythonList, 'NewPythonList', cdRegister);
 S.RegisterDelphiFunction(@NewPythonTuple, 'NewPythonTuple', cdRegister);
 S.RegisterDelphiFunction(@NewPythonDict, 'NewPythonDict', cdRegister);
 S.RegisterDelphiFunction(@VarPythonAsString, 'VarPythonAsString', cdRegister);
 S.RegisterDelphiFunction(@VarPythonToVariant, 'VarPythonToVariant', cdRegister);
 S.RegisterDelphiFunction(@None, 'None', cdRegister);
 S.RegisterDelphiFunction(@Ellipsis, 'Ellipsis', cdRegister);
 S.RegisterDelphiFunction(@MainModule, 'MainModule', cdRegister);
 S.RegisterDelphiFunction(@BuiltinModule, 'BuiltinModule', cdRegister);
 S.RegisterDelphiFunction(@SysModule, 'SysModule', cdRegister);
 S.RegisterDelphiFunction(@DatetimeModule, 'DatetimeModule', cdRegister);
 S.RegisterDelphiFunction(@Import, 'Import', cdRegister);
 S.RegisterDelphiFunction(@len, 'len', cdRegister);
 S.RegisterDelphiFunction(@_type, '_type', cdRegister);
 S.RegisterDelphiFunction(@iter, 'iter', cdRegister);
 S.RegisterDelphiFunction(@VarPyIterate, 'VarPyIterate', cdRegister);
end;

 
 
{ TPSImport_VarPyth }
(*----------------------------------------------------------------------------*)
procedure TPSImport_VarPyth.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_VarPyth(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_VarPyth.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_VarPyth_Routines(CompExec.Exec); // comment it if no routines
end;
(*----------------------------------------------------------------------------*)
 
 
end.
