program Pathological_floating_point_problems_Py;
{
 Most programmers are familiar with the inexactness of floating point 
                                   calculations in a binary processor. 
 https://downloads.blaisepascal.eu/BlaisePascalMagazine_99_100_UK.pdf
 History: http://www.rosettacode.org/wiki/Pathological_floating_point_problems#Python
 http://www.rosettacode.org/wiki/Pathological_floating_point_problems#Delphi
}

Const PYHOME = 'C:\Users\max\AppData\Local\Programs\Python\Python36-32\';

var mykmdict: TKMemoDictionary; 

type
  TTBalance = record
    e, d: TInteger; //BigInteger;
  end;
  TTBalance2 = record
    e, d: TBigfloat; //BigInteger;
  end;
 
//{$I logo.p} 
PROCEDURE logo;
BEGIN
 writeln('');
 writeln('  .-------------------------------------------.');
 writeln('  | The Chaotic PasPy Bank Society         |');
 writeln('  | Task2     rosettacode 1988-2021 M.K.   |');
 writeln('  .-------------------------------------------.');
 writeln('');
END; {procedure logo}


procedure BankBalance2();
var balance: TTBalance2;
  one, ef, df: TBigfloat; y: integer;
  e, b: TBigfloat; m: TInteger; //BigDecimal;
begin
  //balance.e := 1;
  //RegisterMethod('Constructor Create1( const MaxSig : TMaxSig);'); prec.: 50
  balance.e := TBigfloat.create1(50);
  balance.e.assign5(1)
  balance.d := TBigfloat.create1(50);
  balance.d.assign5(-1);
  one :=TBigfloat.create;
  one.assignone;
 
  for {var} y:= 1 to 25 do begin
    //m := y;
    m:= TInteger.create(y);
    //m.assign5(y)
    balance.e.mult2(m);
    //balance.d := m * balance.d;
    balance.d.mult2(m)
    //balance.d := balance.d - one;
    balance.d.subtract(one);
    //balance.d.assign(balance.d);
    m.Free;
  end;
  //writeln(balance.d.ToString(scientific));
 
  e:= TBigfloat.Create1(25);
  e.assign8('2.7182818284590452353602874713526624977572470936999');
 
  //ef := balance.e;
  ef:= TBigfloat.create();                     
  ef.assign(balance.e)
  //df := balance.d;
  df:= TBigfloat.create();
  df.assign(balance.d)
  
  //b := e * ef;
  //b := b + df;
  b:= TBigfloat.Create();
  b.assign(e);
  b.mult(ef);
  //b.assign4(df);
  //b.add1(strtoint64(df.ToString(normal)));
  b.add(df)
  //writeln(format('Bank balance after 25 years: $%.2f', [b.AsDouble]));
  writeln(format('Bank balance after 25 years: $ %s', [b.ToString(normal)]));
  writeln(format('Bank balance after 25 years: $ %s', [b.ToString(scientific)]));
  b.Free; e.Free;
  df.Free; ef.Free;
  one.Free;
end;

Const pybankDEF =
 'def bank(years:int) -> float:  '
+LF+'   """                       '
+LF+'   Warning: still will diverge, returns incorrect results after 250 years'
+LF+'   the higher the precision, the more years will cover '
+LF+'   """                                                 '
+LF+'   getcontext().prec = 500                             '
+LF+'   # standard math.e has not enough precision          '
+LF+'   e = Decimal("2.718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427427466391932003059921817413596629043572900334295260595630738132328627943490763233829880753195251019011573834187930702154089149934884167509244761460668082264800168477411853742345442437107539077744992069551702761838606261331384583000752044933826560297606737113200709328709127443747047230696977209310141692836819025515108657463772111252389784425056953696770785449969967946864454905987931636889230098793127736178215424999229576351")                         '
+LF+'   decimal_balance = e - 1                                            '
+LF+'   for year in range(1, years+1):                                     '
+LF+'       decimal_balance = decimal_balance * year - 1                   '
+LF+'   return(float(decimal_balance))                                     ';

procedure pyBank;
var eg: TPythonEngine;
    sw: TStopWatch;
begin
eg:= TPythonEngine.Create(Nil);
  try
    eg.pythonhome:= PYHOME;
    eg.loadDLL;
    println('test import '+GetPythonEngine.EvalStr('__import__("decimal").Decimal(0.1)'));
    println('test import '+eg.EvalStr('__import__("decimal").Decimal(0.1)')); 
    writeln('') 
    //println(eg.EvalStr('__import__("faker").Faker()')); 
    sw:= TStopWatch.Create();
    sw.Start;
    {eg.execStr('from faker import Faker');
    eg.execStr('import dumper, hashlib, json');
    eg.execStr('fake = Faker()');
    println('creditcard#: '+eg.evalStr('fake.credit_card_number()')); //}
    //eg.execStr('fake = Faker(["es_MX"])')
    //for i in range(10):
    
    eg.execStr('from decimal import Decimal, getcontext');
    eg.execStr(pybankDEF)  
    //"Bank balance after 25 years = ", bank(25)
    println('Bank balance after 25 years = '+
                    eg.evalStr('bank(25)'));
    BankBalance2();                
    sw.Stop;
    //sw.ElapsedMilliseconds;
    writeln('Stop PyBank Tester1: '+sw.getValueStr)
  except
    eg.raiseError;
    writeln(ExceptionToString(ExceptionType, ExceptionParam));  
  finally
    eg.Free;
    sw.Free;
    sw:= Nil;
  end;
end;   

Const UPPERLIMIT = 100;
var cnt,n, precision: NativeUint;
    dec_bal: extended;
    e, decbal: TBigfloat;
    
begin //@main
 logo;
  //{var} f := flots(v);
  //BankBalance();
  BankBalance2();
  pyBank();
  
  dec_bal := Euler - 1;  
  writeln(flots(dec_bal))                                          
   for it:= 1 to 26 do                                     
       dec_bal:= (dec_bal * it) - 1;                   
   writeln(flots(dec_bal));
   
  e:= TBigfloat.Create1(25);
  e.assign8('2.71828182845904523536028747135266249775724709369995957496696762');
  e.subtract1(1);
  for it:= 1 to 26 do begin
     e.mult3(it)
     e.subtract1(1);
  end;  
  writeln(format('Bank balance simple 25 years: $ %s',[e.ToString(normal)]));
  e.Free;  
      
End.

ref: 0.03993872967323020890367053
     0.03993872967323020890367053
PY   0.03993872967323021

Bank balance after 25 years = 0.03993872967323021
Bank balance after 25 years: $ 0.03993872967323020890367053
Bank balance after 25 years: $ 3.9938729673230208903670531 E -2
Stop PyBank Tester1: 0:0:0.15
 mX4 executed: 21/12/2021 21:10:25  Runtime: 0:0:1.598  Memload: 39% use

procedure SIRegister_TBigFloat(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TObject', 'TBigFloat') do
  with CL.AddClassN(CL.FindClass('TObject'),'TBigFloat') do begin
    RegisterProperty('decpart', 'TFloatInt', iptrw);
    RegisterProperty('sigdigits', 'word', iptrw);
    RegisterProperty('exponent', 'integer', iptrw);
    RegisterMethod('Constructor Create;');
    RegisterMethod('Constructor Create1( const MaxSig : TMaxSig);');
    RegisterMethod('Procedure Assign( A : TBigFloat);');
    RegisterMethod('Procedure Assign3( A : TBigFloat; SigDig : word);');
    RegisterMethod('Procedure Assign4( A : TInteger);');
    RegisterMethod('Procedure Assign5( N : int64);');
    RegisterMethod('Procedure Assign6( N : int64; SigDig : integer);');
    RegisterMethod('Procedure Assign7( d : extended);');
    RegisterMethod('Procedure Assign8( S : string);');
    RegisterMethod('Procedure Assign9( S : string; SigDig : word);');
    RegisterMethod('Procedure AssignZero');
    RegisterMethod('Procedure AssignOne');
    RegisterMethod('Procedure Add( B : TBigFloat);');
    RegisterMethod('Procedure Add1( B : int64);');
    RegisterMethod('Procedure AbsAdd( B : TBigFloat)');
    RegisterMethod('Procedure Subtract( B : TBigFloat);');
    RegisterMethod('Procedure Subtract1( B : int64);');
    RegisterMethod('Procedure Mult( B : TBigFloat);');
    RegisterMethod('Procedure Mult1( B : TBigfloat; const MaxSig : TMaxSig);');
    RegisterMethod('Procedure Mult2( B : TInteger);');
    RegisterMethod('Procedure Mult3( B : int64);');
    RegisterMethod('Procedure MultRaw( B : TBigFloat)');
    RegisterMethod('Procedure Reciprocal( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Divide( B : TBigFloat; const MaxSig : TMaxSig);');
    RegisterMethod('Procedure Divide1( B : TInteger; const MaxSig : TMaxSig);');
    RegisterMethod('Procedure Divide2( B : int64; const MaxSig : TMaxSig);');
    RegisterMethod('Procedure Square( const MaxSig : TMaxSig)');
    RegisterMethod('Function Compare( B : TBigFloat) : integer');
    RegisterMethod('Function IsZero : boolean');
    RegisterMethod('Procedure MaxBigFloat( B : TBigFloat)');
    RegisterMethod('Procedure MinBigFloat( B : TBigFloat)');
    RegisterMethod('Procedure Sqrt;');
    RegisterMethod('Procedure Sqrt1( const MaxSig : TMaxSig);');
    RegisterMethod('Procedure NRoot( N : integer; const MaxSig : TMaxSig)');
    RegisterMethod('Procedure IntPower( intpower : integer; const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Power( power : TBigfloat; const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Log( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Log10( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Exp( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure PiConst( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure Log2Const( const MaxSig : TMaxSig)');
    RegisterMethod('Procedure RoundToPrec( const MaxSig : TMaxSig);');
    RegisterMethod('Procedure RoundToPrec1;');
    RegisterMethod('Procedure Trunc( const x : integer)');
    RegisterMethod('Procedure Floor( const x : integer)');
    RegisterMethod('Procedure Ceiling( const x : integer)');
    RegisterMethod('Procedure Round( const x : integer);');
    RegisterMethod('Procedure AbsoluteValue');
    RegisterMethod('Procedure Negate');
    RegisterMethod('Procedure SetSigDigits( const newsigdigits : integer)');
    RegisterMethod('Function ConvertToString( const View : TView) : string');
    RegisterMethod('Function ToString( const View : TView) : string');
    RegisterMethod('Function ConvertToExtended( var num : extended) : boolean');
    RegisterMethod('Function ConvertToInt64( var N : int64) : boolean');
    RegisterMethod('Function IntPart : int64');
  end;
end;


ref: https://github.com/cutec-chris/kcontrols/blob/master/source/kfunctions.pas

 TKObject = class(TObject)
  private
    FParent: TKObjectList;
    procedure SetParent(const Value: TKObjectList);
  protected
    FUpdateLock: Integer;
    procedure CallBeforeUpdate; virtual;
    procedure CallAfterUpdate; virtual;
    procedure ParentChanged; virtual;
  public
    constructor Create; virtual;
    procedure Assign(ASource: TKObject); virtual;
    function EqualProperties(AValue: TKObject): Boolean; virtual;
    procedure LockUpdate; virtual;
    procedure UnLockUpdate; virtual;
    function UpdateUnlocked: Boolean; virtual;
    property Parent: TKObjectList read FParent write SetParent;
  end;
