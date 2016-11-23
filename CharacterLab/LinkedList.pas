unit LinkedList;

interface

uses
  Windows, SysUtils, Classes;

 type TLinkedListCompareEvent = procedure (oExisting, oNew: TObject; var bAddHere: boolean) of object;

//orders a bunch of objects into a custom order. Uses a custom event to sort. Can scan forward and backward;
type
 TLinkedList = class(TObject)
  constructor Create;
  destructor  Destroy; override;
 private
  FOnCompare: TLinkedListCompareEvent;
  FList: TList;                        //contains TObjects. Dont use TMyList, do not want to auto-free
  function GetElement(i: integer): TObject;
  function GetCount: integer;
 public
  function AddObject(oNew: TObject): integer;
  function RemoveObject(o: TObject): integer;
  procedure Blank;
  property Count: integer read GetCount;
  property Elements[i: integer]: TObject read GetElement;
  property OnCompare: TLinkedListCompareEvent read FOnCompare write FOnCompare;
 end;

implementation

{ TLinkedList }

constructor TLinkedList.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TLinkedList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TLinkedList.AddObject(oNew: TObject): integer;
var o: TObject;
    bDone, bFound: boolean;
    i: integer;
begin
  i := 0;
  bDone := (i >= FList.Count);
  bFound := false;
  while not (bDone or bFound) do begin
     o := FList.Items[i];
     if Assigned(FOnCompare) then
        FOnCompare(o, oNew, bFound);

     if not bFound then begin
        inc(i);
        bDone := (i >= FList.Count);
     end;
  end;

  if bFound then begin                //i contains spot to insert
     FList.Insert(i, oNew);
     result := i
  end else
     result := FList.Add(oNew);           //add to end;
end;

function TLinkedList.GetElement(i: integer): TObject;
begin
  result := FList.Items[i];
end;

function TLinkedList.RemoveObject(o: TObject): integer;
begin
  result := FList.Remove(o);
end;

procedure TLinkedList.Blank;
begin
  while FList.Count > 0 do
     FList.Delete(FList.Count-1);
end;

function TLinkedList.GetCount: integer;
begin result := FList.Count end;

end.
