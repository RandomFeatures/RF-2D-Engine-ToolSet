unit charObj;

interface

uses
  Classes, graphics, Dialogs, Windows, Sysutils, ImageManager, IniFiles, strFunctions;

type

 TCharacterObject = class(TObject)
 private

 public
        DBID: integer;
        PhyResist: string;
        MagResist: string;
        HitPoints: integer;
        MinDamage: integer;
        MaxDamage: integer;
        HitRating: integer;
        DefRating: integer;
        AttRating: integer;
        MoveRating: integer;
        Movement: integer;
        CharClass: integer;
        SpellID: integer;
        Group: integer;
        //DatFile: string;
        ISO_CharacterID: integer;
        GUID_Txt: string;
        DisplayName: string;
        function GetText: string;
        procedure GenerateGUID;
 end;


implementation


procedure TCharacterObject.GenerateGUID;
const
  icLastTime: Integer = 0;
var
  iPos, iDate,
    iThisTime: Integer;
  Present: TDateTime;
const
  NuBaseDigits: string = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  function ConvertBase(DecimalNumber: Int64; MinWidth: SHORT): string;
  var
    i, NuBase: Integer;
  begin
    NuBase := Length(NuBaseDigits);
    Result := '';
    if DecimalNumber < 0 then ShowMessage('GUID Calculation Underflow! Fix the source!!');
    while DecimalNumber > 0 do
    begin    // slow but very effective
      i := DecimalNumber mod NuBase;
      Result := NuBaseDigits[i + 1] + Result;
      DecimalNumber := DecimalNumber - i;
      DecimalNumber := DecimalNumber div NuBase;
    end;
    while Length(Result) < MinWidth do
      Result := '0' + Result;
  end;

begin
  // jrs - Let's make a COMPACT GUID for less clutter

  if (GUID_Txt = 'auto') or (GUID_Txt = '') then
  begin
    repeat
      Sleep(20);
      Present := Now;
      iThisTime := DateTimeToTimeStamp(Present).Time; // Number of milliseconds since midnight
    until iThisTime <> icLastTime;      // Max = 1000 * 60 * 60 * 24 = 86,400,000

    iDate := DateTimeToTimeStamp(Present).Date - 730830; // Subtract recent Date to shrink resulting number
    GUID_Txt := Format('%s_%s%s', [Copy(DisplayName, 1, 5),
      ConvertBase(iDate, 3), ConvertBase(iThisTime, 6)]);
    icLastTime := iThisTime;
  end;
end;

function TCharacterObject.GetText: string;
var
s: string;
begin
         GenerateGUID;
         s := GUID_Txt + ' ' + DisplayName  + ' ' + IntToStr(CharClass) + ' ' + IntToStr(DefRating) + ' ' + IntToStr(HitRating) + ' ' +
              IntToStr(AttRating) + ' ' + IntToStr(MoveRating) + ' ' + '' + ' ' + IntToStr(SpellID) + ' ' + PhyResist + ' ' +
              MagResist + ' ' + IntToStr(HitPoints) + ' ' + IntToStr(MinDamage) + ' ' + IntToStr(MaxDamage) + ' ' + IntToStr(Movement);

        Result := s;
end;

end.
 