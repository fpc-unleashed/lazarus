program TestProperties;
{$Mode objfpc}{$H+}
{$ModeSwitch advancedrecords}

uses SysUtils;

type
  TBitNum = 0..7; // 3 bits

  TWordRecord = record
    a, b, c, d: word;
    x: array[0..24] of TBitNum; // put some distance in
    e, f, g, h,
    j, k, l, m: word;
    y,z: TBitNum;
    n: word;
  end;

  TWordPackRecord = bitpacked record
    a, b, c, d: word;
    x: array[0..24] of TBitNum;
    e, f, g, h,
    j, k, l, m: word;
    y,z: TBitNum;
    n: word;
  end;

  TWordPack2Record = bitpacked record
    a, b, c, d: word;
    x: bitpacked array[0..24] of TBitNum;
    e, f, g, h,
    j, k, l, m: word;
    y,z: TBitNum;
    n: word;
  end;

  TBitNumArray     = array [1..25] of TBitNum;
  TBitNumParkArray = bitpacked array [1..25] of TBitNum;

  TWordRec_Array          = array [1..4] of TWordRecord;
  TWordPackRec_Array      = array [1..4] of TWordPackRecord;
  TWordPack2Rec_Array     = array [1..4] of TWordPack2Record;
  TWordRec_PackArray      = bitpacked array [1..4] of TWordRecord;
  TWordPackRec_PackArray  = bitpacked array [1..4] of TWordPackRecord;
  TWordPack2Rec_PackArray = bitpacked array [1..4] of TWordPack2Record;

  TRecWordRec_Array          = record n,m: TBitNum; r1, r2: TWordRec_Array; end;
  TRecWordPackRec_Array      = record n,m: TBitNum; r1, r2: TWordPackRec_Array; end;
  TRecWordPack2Rec_Array     = record n,m: TBitNum; r1, r2: TWordPack2Rec_Array; end;
  TRecWordRec_PackArray      = record n,m: TBitNum; r1, r2: TWordRec_PackArray; end;
  TRecWordPackRec_PackArray  = record n,m: TBitNum; r1, r2: TWordPackRec_PackArray; end;
  TRecWordPack2Rec_PackArray = record n,m: TBitNum; r1, r2: TWordPack2Rec_PackArray; end;

  TPackRecWordRec_Array          = bitpacked record n,m: TBitNum; r1, r2: TWordRec_Array; end;
  TPackRecWordPackRec_Array      = bitpacked record n,m: TBitNum; r1, r2: TWordPackRec_Array; end;
  TPackRecWordPack2Rec_Array     = bitpacked record n,m: TBitNum; r1, r2: TWordPack2Rec_Array; end;
  TPackRecWordRec_PackArray      = bitpacked record n,m: TBitNum; r1, r2: TWordRec_PackArray; end;
  TPackRecWordPackRec_PackArray  = bitpacked record n,m: TBitNum; r1, r2: TWordPackRec_PackArray; end;
  TPackRecWordPack2Rec_PackArray = bitpacked record n,m: TBitNum; r1, r2: TWordPack2Rec_PackArray; end;


  TFoo = class
  protected
    dummy1:  TBitNum;    FBitNum: TBitNum;
    dummy2:  TBitNum;    FTWordRecord1: TWordRecord;
    dummy3:  TBitNum;    FTWorPackdRecord: TWordPackRecord;
    dummy4:  TBitNum;    FTWordPack2Record: TWordPack2Record;

    dummy6:  TBitNum;    FBitNumArray: TBitNumArray;
    dummy7:  TBitNum;    FBitNum_PackArray: TBitNumParkArray;

    dummy8:  TBitNum;    FWordRec_Array: TWordRec_Array;
    dummy9:  TBitNum;    FWordPackRec_Array: TWordPackRec_Array;
    dummy10: TBitNum;    FWordPack2Rec_Array: TWordPack2Rec_Array;
    dummy11: TBitNum;    FWordRec_PackArray: TWordRec_PackArray;
    dummy12: TBitNum;    FWordPackRec_PackArray: TWordPackRec_PackArray;
    dummy13: TBitNum;    FWordPack2Rec_PackArray: TWordPack2Rec_PackArray;

    dummy14: TBitNum;    FRecWordRec_Array: TRecWordRec_Array;
    dummy15: TBitNum;    FRecWordPackRec_Array: TRecWordPackRec_Array;
    dummy16: TBitNum;    FRecWordPack2Rec_Array: TRecWordPack2Rec_Array;
    dummy17: TBitNum;    FRecWordRec_PackArray: TRecWordRec_PackArray;
    dummy18: TBitNum;    FRecWordPackRec_PackArray: TRecWordPackRec_PackArray;
    dummy19: TBitNum;    FRecWordPack2Rec_PackArray: TRecWordPack2Rec_PackArray;

    dummy20: TBitNum;    FPackRecWordRec_Array: TPackRecWordRec_Array;
    dummy21: TBitNum;    FPackRecWordPackRec_Array: TPackRecWordPackRec_Array;
    dummy22: TBitNum;    FPackRecWordPack2Rec_Array: TPackRecWordPack2Rec_Array;
    dummy23: TBitNum;    FPackRecWordRec_PackArray: TPackRecWordRec_PackArray;
    dummy24: TBitNum;    FPackRecWordPackRec_PackArray: TPackRecWordPackRec_PackArray;
    dummy25: TBitNum;    FPackRecWordPack2Rec_PackArray: TPackRecWordPack2Rec_PackArray;

    function GetVal1: integer;
    function GetVal2(a: integer): integer;
    function GetVal3(a,b: integer): integer;
    function GetVal4(a: integer; b: char): integer;
    function GetVal5(idx: integer): integer;
    function GetVal6(a: integer; idx: Integer): integer;
    function GetVal7(a, b: integer; idx: Integer): integer;
    function GetVal8(a: integer; b: char; idx: Integer): integer;

  public
  property PBitNum:                         TBitNum read FBitNum                       ;
  property PTWordRecord1:                   word read FTWordRecord1     .n                 ;
  property PTWorPackdRecord:                word read FTWorPackdRecord  .n              ;
  property PTWordPack2Record:               word read FTWordPack2Record .n             ;
  property PBitNumArray:                    TBitNum read FBitNumArray      [22]            ;
  property PBitNumArray2:                   TBitNum read FBitNumArray      [23]            ;
  property PBitNum_PackArray:               TBitNum read FBitNum_PackArray [22]            ;
  property PBitNum_PackArray2:              TBitNum read FBitNum_PackArray [23]            ;
  property PWordRec_Array:                  word read FWordRec_Array          [3].n      ;
  property PWordPackRec_Array:              word read FWordPackRec_Array      [3].n      ;
  property PWordPack2Rec_Array:             word read FWordPack2Rec_Array     [3].n      ;
  property PWordRec_PackArray:              word read FWordRec_PackArray      [3].n      ;
  property PWordPackRec_PackArray:          word read FWordPackRec_PackArray  [3].n      ;
  property PWordPack2Rec_PackArray:         word read FWordPack2Rec_PackArray [3].n      ;
  property PRecWordRec_Array:               word read FRecWordRec_Array           .r2[2].n      ;
  property PRecWordPackRec_Array:           word read FRecWordPackRec_Array       .r2[2].n      ;
  property PRecWordPack2Rec_Array:          word read FRecWordPack2Rec_Array      .r2[2].n      ;
  property PRecWordRec_PackArray:           word read FRecWordRec_PackArray       .r2[2].n      ;
  property PRecWordPackRec_PackArray:       word read FRecWordPackRec_PackArray   .r2[2].n      ;
  property PRecWordPack2Rec_PackArray:      word read FRecWordPack2Rec_PackArray  .r2[2].n      ;
  property PPackRecWordRec_Array:           word read FPackRecWordRec_Array          .r2[2].n    ;
  property PPackRecWordPackRec_Array:       word read FPackRecWordPackRec_Array      .r2[2].n    ;
  property PPackRecWordPack2Rec_Array:      word read FPackRecWordPack2Rec_Array     .r2[2].n    ;
  property PPackRecWordRec_PackArray:       word read FPackRecWordRec_PackArray      .r2[2].n    ;
  property PPackRecWordPackRec_PackArray:   word read FPackRecWordPackRec_PackArray  .r2[2].n    ;
  property PPackRecWordPack2Rec_PackArray:  word read FPackRecWordPack2Rec_PackArray .r2[2].n    ;

  property ZTWordRecord1:                   TBitNum read FTWordRecord1     .z                 ;
  property ZTWorPackdRecord:                TBitNum read FTWorPackdRecord  .z              ;
  property ZTWordPack2Record:              TBitNum read FTWordPack2Record .z             ;
  property ZWordRec_Array:                  TBitNum read FWordRec_Array          [3].z      ;
  property ZWordPackRec_Array:              TBitNum read FWordPackRec_Array      [3].z      ;
  property ZWordPack2Rec_Array:             TBitNum read FWordPack2Rec_Array     [3].z      ;
  property ZWordRec_PackArray:              TBitNum read FWordRec_PackArray      [3].z      ;
  property ZWordPackRec_PackArray:          TBitNum read FWordPackRec_PackArray  [3].z      ;
  property ZWordPack2Rec_PackArray:         TBitNum read FWordPack2Rec_PackArray [3].z      ;
  property ZRecWordRec_Array:               TBitNum read FRecWordRec_Array           .r2[2].z      ;
  property ZRecWordPackRec_Array:           TBitNum read FRecWordPackRec_Array       .r2[2].z      ;
  property ZRecWordPack2Rec_Array:          TBitNum read FRecWordPack2Rec_Array      .r2[2].z      ;
  property ZRecWordRec_PackArray:           TBitNum read FRecWordRec_PackArray       .r2[2].z      ;
  property ZRecWordPackRec_PackArray:       TBitNum read FRecWordPackRec_PackArray   .r2[2].z      ;
  property ZRecWordPack2Rec_PackArray:      TBitNum read FRecWordPack2Rec_PackArray  .r2[2].z      ;
  property ZPackRecWordRec_Array:           TBitNum read FPackRecWordRec_Array          .r2[2].z    ;
  property ZPackRecWordPackRec_Array:       TBitNum read FPackRecWordPackRec_Array      .r2[2].z    ;
  property ZPackRecWordPack2Rec_Array:      TBitNum read FPackRecWordPack2Rec_Array     .r2[2].z    ;
  property ZPackRecWordRec_PackArray:       TBitNum read FPackRecWordRec_PackArray      .r2[2].z    ;
  property ZPackRecWordPackRec_PackArray:   TBitNum read FPackRecWordPackRec_PackArray  .r2[2].z    ;
  property ZPackRecWordPack2Rec_PackArray:  TBitNum read FPackRecWordPack2Rec_PackArray .r2[2].z    ;

  property GVal1:                      integer read GetVal1;
  property GVal2[a: integer]:          integer read GetVal2;
  property GVal3[a,b: integer]:        integer read GetVal3;
  property GVal4[a: integer; b: char]: integer read GetVal4;
  property GVal5:                      integer index 10 read GetVal5;
  property GVal6[a: integer]:          integer index 12 read GetVal6;
  property GVal7[a,b: integer]:        integer index 13 read GetVal7;
  property GVal8[a: integer; b: char]: integer index 14 read GetVal8;
  end;


function TFoo.GetVal1: integer;                        begin Result := dummy1*100000; end;
function TFoo.GetVal2(a: integer): integer;            begin Result := dummy1*100000+a; end;
function TFoo.GetVal3(a,b: integer): integer;          begin Result := dummy1*100000+a*b; end;
function TFoo.GetVal4(a: integer; b: char): integer;   begin Result := dummy1*100000+a*ord(b); end;
function TFoo.GetVal5(idx: integer): integer;                     begin Result := dummy1*100000+idx*100; end;
function TFoo.GetVal6(a: integer; idx: Integer): integer;         begin Result := dummy1*100000+idx*100+a; end;
function TFoo.GetVal7(a, b: integer; idx: Integer): integer;      begin Result := dummy1*100000+idx*100+a*b; end;
function TFoo.GetVal8(a: integer; b: char; idx: Integer): integer;begin Result := dummy1*100000+idx*100+a*ord(b); end;

type
  TBar = bitpacked record
  private
    dummy1:  TBitNum;    FBitNum: TBitNum;
    dummy2:  TBitNum;    FTWordRecord1: TWordRecord;
    dummy3:  TBitNum;    FTWorPackdRecord: TWordPackRecord;
    dummy4:  TBitNum;    FTWordPack2Record: TWordPack2Record;

    dummy6:  TBitNum;    FBitNumArray: TBitNumArray;
    dummy7:  TBitNum;    FBitNum_PackArray: TBitNumParkArray;

    dummy8:  TBitNum;    FWordRec_Array: TWordRec_Array;
    dummy9:  TBitNum;    FWordPackRec_Array: TWordPackRec_Array;
    dummy10: TBitNum;    FWordPack2Rec_Array: TWordPack2Rec_Array;
    dummy11: TBitNum;    FWordRec_PackArray: TWordRec_PackArray;
    dummy12: TBitNum;    FWordPackRec_PackArray: TWordPackRec_PackArray;
    dummy13: TBitNum;    FWordPack2Rec_PackArray: TWordPack2Rec_PackArray;

    dummy14: TBitNum;    FRecWordRec_Array: TRecWordRec_Array;
    dummy15: TBitNum;    FRecWordPackRec_Array: TRecWordPackRec_Array;
    dummy16: TBitNum;    FRecWordPack2Rec_Array: TRecWordPack2Rec_Array;
    dummy17: TBitNum;    FRecWordRec_PackArray: TRecWordRec_PackArray;
    dummy18: TBitNum;    FRecWordPackRec_PackArray: TRecWordPackRec_PackArray;
    dummy19: TBitNum;    FRecWordPack2Rec_PackArray: TRecWordPack2Rec_PackArray;

    dummy20: TBitNum;    FPackRecWordRec_Array: TPackRecWordRec_Array;
    dummy21: TBitNum;    FPackRecWordPackRec_Array: TPackRecWordPackRec_Array;
    dummy22: TBitNum;    FPackRecWordPack2Rec_Array: TPackRecWordPack2Rec_Array;
    dummy23: TBitNum;    FPackRecWordRec_PackArray: TPackRecWordRec_PackArray;
    dummy24: TBitNum;    FPackRecWordPackRec_PackArray: TPackRecWordPackRec_PackArray;
    dummy25: TBitNum;    FPackRecWordPack2Rec_PackArray: TPackRecWordPack2Rec_PackArray;

    function GetVal1: integer;
    function GetVal2(a: integer): integer;
    function GetVal3(a,b: integer): integer;
    function GetVal4(a: integer; b: char): integer;
    function GetVal5(idx: integer): integer;
    function GetVal6(a: integer; idx: Integer): integer;
    function GetVal7(a, b: integer; idx: Integer): integer;
    function GetVal8(a: integer; b: char; idx: Integer): integer;

  public
  property PBitNum:                         TBitNum read FBitNum                       ;
  property PTWordRecord1:                   word read FTWordRecord1     .n                 ;
  property PTWorPackdRecord:                word read FTWorPackdRecord  .n              ;
  property PTWordPack2Record:               word read FTWordPack2Record .n             ;
  property PBitNumArray:                    TBitNum read FBitNumArray      [22]            ;
  property PBitNumArray2:                   TBitNum read FBitNumArray      [23]            ;
  property PBitNum_PackArray:               TBitNum read FBitNum_PackArray [22]            ;
  property PBitNum_PackArray2:              TBitNum read FBitNum_PackArray [23]            ;
  property PWordRec_Array:                  word read FWordRec_Array          [3].n      ;
  property PWordPackRec_Array:              word read FWordPackRec_Array      [3].n      ;
  property PWordPack2Rec_Array:             word read FWordPack2Rec_Array     [3].n      ;
  property PWordRec_PackArray:              word read FWordRec_PackArray      [3].n      ;
  property PWordPackRec_PackArray:          word read FWordPackRec_PackArray  [3].n      ;
  property PWordPack2Rec_PackArray:         word read FWordPack2Rec_PackArray [3].n      ;
  property PRecWordRec_Array:               word read FRecWordRec_Array           .r2[2].n      ;
  property PRecWordPackRec_Array:           word read FRecWordPackRec_Array       .r2[2].n      ;
  property PRecWordPack2Rec_Array:          word read FRecWordPack2Rec_Array      .r2[2].n      ;
  property PRecWordRec_PackArray:           word read FRecWordRec_PackArray       .r2[2].n      ;
  property PRecWordPackRec_PackArray:       word read FRecWordPackRec_PackArray   .r2[2].n      ;
  property PRecWordPack2Rec_PackArray:      word read FRecWordPack2Rec_PackArray  .r2[2].n      ;
  property PPackRecWordRec_Array:           word read FPackRecWordRec_Array          .r2[2].n    ;
  property PPackRecWordPackRec_Array:       word read FPackRecWordPackRec_Array      .r2[2].n    ;
  property PPackRecWordPack2Rec_Array:      word read FPackRecWordPack2Rec_Array     .r2[2].n    ;
  property PPackRecWordRec_PackArray:       word read FPackRecWordRec_PackArray      .r2[2].n    ;
  property PPackRecWordPackRec_PackArray:   word read FPackRecWordPackRec_PackArray  .r2[2].n    ;
  property PPackRecWordPack2Rec_PackArray:  word read FPackRecWordPack2Rec_PackArray .r2[2].n    ;

  property ZTWordRecord1:                   TBitNum read FTWordRecord1     .z                 ;
  property ZTWorPackdRecord:                TBitNum read FTWorPackdRecord  .z              ;
  property ZTWordPack2Record:               TBitNum read FTWordPack2Record .z             ;
  property ZWordRec_Array:                  TBitNum read FWordRec_Array          [3].z      ;
  property ZWordPackRec_Array:              TBitNum read FWordPackRec_Array      [3].z      ;
  property ZWordPack2Rec_Array:             TBitNum read FWordPack2Rec_Array     [3].z      ;
  property ZWordRec_PackArray:              TBitNum read FWordRec_PackArray      [3].z      ;
  property ZWordPackRec_PackArray:          TBitNum read FWordPackRec_PackArray  [3].z      ;
  property ZWordPack2Rec_PackArray:         TBitNum read FWordPack2Rec_PackArray [3].z      ;
  property ZRecWordRec_Array:               TBitNum read FRecWordRec_Array           .r2[2].z      ;
  property ZRecWordPackRec_Array:           TBitNum read FRecWordPackRec_Array       .r2[2].z      ;
  property ZRecWordPack2Rec_Array:          TBitNum read FRecWordPack2Rec_Array      .r2[2].z      ;
  property ZRecWordRec_PackArray:           TBitNum read FRecWordRec_PackArray       .r2[2].z      ;
  property ZRecWordPackRec_PackArray:       TBitNum read FRecWordPackRec_PackArray   .r2[2].z      ;
  property ZRecWordPack2Rec_PackArray:      TBitNum read FRecWordPack2Rec_PackArray  .r2[2].z      ;
  property ZPackRecWordRec_Array:           TBitNum read FPackRecWordRec_Array          .r2[2].z    ;
  property ZPackRecWordPackRec_Array:       TBitNum read FPackRecWordPackRec_Array      .r2[2].z    ;
  property ZPackRecWordPack2Rec_Array:      TBitNum read FPackRecWordPack2Rec_Array     .r2[2].z    ;
  property ZPackRecWordRec_PackArray:       TBitNum read FPackRecWordRec_PackArray      .r2[2].z    ;
  property ZPackRecWordPackRec_PackArray:   TBitNum read FPackRecWordPackRec_PackArray  .r2[2].z    ;
  property ZPackRecWordPack2Rec_PackArray:  TBitNum read FPackRecWordPack2Rec_PackArray .r2[2].z    ;

  property GVal1:                      integer read GetVal1;
  property GVal2[a: integer]:          integer read GetVal2;
  property GVal3[a,b: integer]:        integer read GetVal3;
  property GVal4[a: integer; b: char]: integer read GetVal4;
  property GVal5:                      integer index 10 read GetVal5;
  property GVal6[a: integer]:          integer index 12 read GetVal6;
  property GVal7[a,b: integer]:        integer index 13 read GetVal7;
  property GVal8[a: integer; b: char]: integer index 14 read GetVal8;
  end;


function TBar.GetVal1: integer;                        begin Result := dummy1*100000; end;
function TBar.GetVal2(a: integer): integer;            begin Result := dummy1*100000+a; end;
function TBar.GetVal3(a,b: integer): integer;          begin Result := dummy1*100000+a*b; end;
function TBar.GetVal4(a: integer; b: char): integer;   begin Result := dummy1*100000+a*ord(b); end;
function TBar.GetVal5(idx: integer): integer;                     begin Result := dummy1*100000+idx*100; end;
function TBar.GetVal6(a: integer; idx: Integer): integer;         begin Result := dummy1*100000+idx*100+a; end;
function TBar.GetVal7(a, b: integer; idx: Integer): integer;      begin Result := dummy1*100000+idx*100+a*b; end;
function TBar.GetVal8(a: integer; b: char; idx: Integer): integer;begin Result := dummy1*100000+idx*100+a*ord(b); end;



var
  f : TFoo;
  b : TBar;

begin
  f := TFoo.Create;

  f.dummy1                                   := 4 ;

  f.FBitNum                                  := 01 ;
  f.FTWordRecord1     .n                     := 02 ;
  f.FTWorPackdRecord  .n                     := 03 ;
  f.FTWordPack2Record .n                     := 04 ;
  f.FBitNumArray      [22]                   := 01 ;
  f.FBitNumArray      [23]                   := 02 ;
  f.FBitNum_PackArray [22]                   := 03 ;
  f.FBitNum_PackArray [23]                   := 04 ;
  f.FWordRec_Array          [3].n            := 05 ;
  f.FWordPackRec_Array      [3].n            := 06 ;
  f.FWordPack2Rec_Array     [3].n            := 07 ;
  f.FWordRec_PackArray      [3].n            := 08 ;
  f.FWordPackRec_PackArray  [3].n            := 09 ;
  f.FWordPack2Rec_PackArray [3].n            := 10 ;
  f.FRecWordRec_Array           .r2[2].n      := 11 ;
  f.FRecWordPackRec_Array       .r2[2].n      := 12 ;
  f.FRecWordPack2Rec_Array      .r2[2].n      := 13 ;
  f.FRecWordRec_PackArray       .r2[2].n      := 14 ;
  f.FRecWordPackRec_PackArray   .r2[2].n      := 15 ;
  f.FRecWordPack2Rec_PackArray  .r2[2].n      := 16 ;
  f.FPackRecWordRec_Array          .r2[2].n   := 17 ;
  f.FPackRecWordPackRec_Array      .r2[2].n   := 18 ;
  f.FPackRecWordPack2Rec_Array     .r2[2].n   := 19 ;
  f.FPackRecWordRec_PackArray      .r2[2].n   := 20 ;
  f.FPackRecWordPackRec_PackArray  .r2[2].n   := 21 ;
  f.FPackRecWordPack2Rec_PackArray .r2[2].n   := 22 ;

  f.FTWordRecord1     .z                      := 1 ;
  f.FTWorPackdRecord  .z                      := 2 ;
  f.FTWordPack2Record .z                      := 3 ;
  f.FWordRec_Array          [3].z             := 4 ;
  f.FWordPackRec_Array      [3].z             := 5 ;
  f.FWordPack2Rec_Array     [3].z             := 6 ;
  f.FWordRec_PackArray      [3].z             := 7 ;
  f.FWordPackRec_PackArray  [3].z             := 1 ;
  f.FWordPack2Rec_PackArray [3].z             := 2 ;
  f.FRecWordRec_Array           .r2[2].z      := 3 ;
  f.FRecWordPackRec_Array       .r2[2].z      := 4 ;
  f.FRecWordPack2Rec_Array      .r2[2].z      := 5 ;
  f.FRecWordRec_PackArray       .r2[2].z      := 6 ;
  f.FRecWordPackRec_PackArray   .r2[2].z      := 7 ;
  f.FRecWordPack2Rec_PackArray  .r2[2].z      := 1 ;
  f.FPackRecWordRec_Array          .r2[2].z   := 2 ;
  f.FPackRecWordPackRec_Array      .r2[2].z   := 3 ;
  f.FPackRecWordPack2Rec_Array     .r2[2].z   := 4 ;
  f.FPackRecWordRec_PackArray      .r2[2].z   := 5 ;
  f.FPackRecWordPackRec_PackArray  .r2[2].z   := 6 ;
  f.FPackRecWordPack2Rec_PackArray .r2[2].z   := 7 ;

  if f.GVal1 + f.GVal2[1] + f.GVal3[1,2] + f.GVal4[1,'a']
     + f.GVal5 + f.GVal6[5] + f.GVal7[1,3] + f.GVal8[1,'a']
     > 0
  then
    f.dummy2 := 1;



  b.dummy1                                   := 4 ;

  b.FBitNum                                  := 01 ;
  b.FTWordRecord1     .n                     := 02 ;
  b.FTWorPackdRecord  .n                     := 03 ;
  b.FTWordPack2Record .n                     := 04 ;
  b.FBitNumArray      [22]                   := 01 ;
  b.FBitNumArray      [23]                   := 02 ;
  b.FBitNum_PackArray [22]                   := 03 ;
  b.FBitNum_PackArray [23]                   := 04 ;
  b.FWordRec_Array          [3].n            := 05 ;
  b.FWordPackRec_Array      [3].n            := 06 ;
  b.FWordPack2Rec_Array     [3].n            := 07 ;
  b.FWordRec_PackArray      [3].n            := 08 ;
  b.FWordPackRec_PackArray  [3].n            := 09 ;
  b.FWordPack2Rec_PackArray [3].n            := 10 ;
  b.FRecWordRec_Array           .r2[2].n      := 11 ;
  b.FRecWordPackRec_Array       .r2[2].n      := 12 ;
  b.FRecWordPack2Rec_Array      .r2[2].n      := 13 ;
  b.FRecWordRec_PackArray       .r2[2].n      := 14 ;
  b.FRecWordPackRec_PackArray   .r2[2].n      := 15 ;
  b.FRecWordPack2Rec_PackArray  .r2[2].n      := 16 ;
  b.FPackRecWordRec_Array          .r2[2].n   := 17 ;
  b.FPackRecWordPackRec_Array      .r2[2].n   := 18 ;
  b.FPackRecWordPack2Rec_Array     .r2[2].n   := 19 ;
  b.FPackRecWordRec_PackArray      .r2[2].n   := 20 ;
  b.FPackRecWordPackRec_PackArray  .r2[2].n   := 21 ;
  b.FPackRecWordPack2Rec_PackArray .r2[2].n   := 22 ;

  b.FTWordRecord1     .z                      := 1 ;
  b.FTWorPackdRecord  .z                      := 2 ;
  b.FTWordPack2Record .z                      := 3 ;
  b.FWordRec_Array          [3].z             := 4 ;
  b.FWordPackRec_Array      [3].z             := 5 ;
  b.FWordPack2Rec_Array     [3].z             := 6 ;
  b.FWordRec_PackArray      [3].z             := 7 ;
  b.FWordPackRec_PackArray  [3].z             := 1 ;
  b.FWordPack2Rec_PackArray [3].z             := 2 ;
  b.FRecWordRec_Array           .r2[2].z      := 3 ;
  b.FRecWordPackRec_Array       .r2[2].z      := 4 ;
  b.FRecWordPack2Rec_Array      .r2[2].z      := 5 ;
  b.FRecWordRec_PackArray       .r2[2].z      := 6 ;
  b.FRecWordPackRec_PackArray   .r2[2].z      := 7 ;
  b.FRecWordPack2Rec_PackArray  .r2[2].z      := 1 ;
  b.FPackRecWordRec_Array          .r2[2].z   := 2 ;
  b.FPackRecWordPackRec_Array      .r2[2].z   := 3 ;
  b.FPackRecWordPack2Rec_Array     .r2[2].z   := 4 ;
  b.FPackRecWordRec_PackArray      .r2[2].z   := 5 ;
  b.FPackRecWordPackRec_PackArray  .r2[2].z   := 6 ;
  b.FPackRecWordPack2Rec_PackArray .r2[2].z   := 7 ;

  if b.GVal1 + b.GVal2[1] + b.GVal3[1,2] + b.GVal4[1,'a']
     + b.GVal5 + b.GVal6[5] + b.GVal7[1,3] + b.GVal8[1,'a']
     > 0
  then
    b.dummy2 := 1;
  b.dummy2 := 0; //  TEST_BREAKPOINT=BRK_MAIN
end.

