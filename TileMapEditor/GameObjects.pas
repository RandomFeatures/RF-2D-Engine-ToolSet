unit GameObjects;

interface

uses
  Classes, graphics, Dialogs, Windows, Sysutils, ImageManager, IniFiles, strFunctions;

 type
 TEditMode =(emTiles, emSprites, emStatics, emLights);
 TEditorMode = (erNone, erStart, erPath, erLight);
 TSpriteMode =(smNone, smCharacter, smSprite, smEditor, smParticles);
 TStaticMode =(smAddNew, smEdit);
 TSpriteType = (stNPC, stSprite, stStart, stParticle);
 TObjectType = (otSprite, otStatic, otLight);
 TLightingType = (blMorning, blNoon, blEvening, blNight);

 TGameObject = class(TObject)
        procedure GenerateGUID;
 public
        MyType: TObjectType;
        ID: String;
        DisplayName: string;
        ISO_ID: integer;
        GroupID: integer;
        GroupIndx: integer;
        x,y: integer;
        //FileName: string;
        Image: graphics.TBitmap;
        Selected: boolean;
        Hidden: boolean;
        offSetX: integer;
        offSetY: integer;
        Blend:integer;
        Red:integer;
        Blue:integer;
        Green:integer;
        Layer: integer;
        CurrentX: integer;
        CurrentY: integer;
        Shadow: boolean;
 end;
 TSprite = class(TGameObject)
        constructor Create;
        destructor Destroy; override;
 public
        SpriteType: TSpriteType;
        Facing: integer; //0=NE 1=NW 2=SE 3=SW
        Side: integer; //0=host 1=challenger
        IdleScript: string;
        CombatScript: string;
        OnActivate: string;
        OnAttacked: string;
        OnClose: string;
        OnDie: string;
        OnFirstAttacked: string;
        OnLoad: string;
        OnOpen: string;
        PhyResist: string;
        MagResist: string;
        HitPoints: integer;
        MinDamage: integer;
        MaxDamage: integer;
        HealthRating: integer;
        DefRating: integer;
        AttRating: integer;
        MoveRating: integer;
        Movement: integer;
        CharType: integer;
        SpellID: integer;

  end;

  TStatic = class(TGameObject)
         constructor Create;
  public
        Frame: string;
        DrawOrder: integer;
        Length: integer;
        Width: integer;
  end;

  TLight = class(TGameObject)
         constructor Create;
  public
        Width: integer;
        Height: integer;
        Flicker: integer;
  end;

  TSFX = class(TGameObject)
  public
        Pan: integer;
        Rand: integer;
        Inter: integer;
        Loop: integer;
        SFXID: integer;
        SFXType: integer;
        SFXName: string;
  end;


var
   ScriptList: TStringList;

implementation




{ TStatic }

constructor TStatic.Create;
begin
   MyType:= otStatic;
end;

{ TSprite }
constructor TSprite.Create;
begin
   MyType:= otSprite;
{
   IdleScript := TStringList.Create;
   CombatScript := TStringList.Create;
   OnActivate := TStringList.Create;
   OnAttack := TStringList.Create;
   OnClose := TStringList.Create;
   OnDie := TStringList.Create;
   OnFirstAttack := TStringList.Create;
   OnLoad := TStringList.Create;
   OnOpen := TStringList.Create;
   }
end;

Destructor TSprite.Destroy;
begin
{
   IdleScript.free;
   CombatScript.free;
   OnActivate.free;
   OnAttack.free;
   OnClose.free;
   OnDie.free;
   OnFirstAttack.free;
   OnLoad.free;
   OnOpen.free;
   }
end;

procedure TGameObject.GenerateGUID;
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

  if ID = '' then
  begin
    repeat
      Sleep(20);
      Present := Now;
      iThisTime := DateTimeToTimeStamp(Present).Time; // Number of milliseconds since midnight
    until iThisTime <> icLastTime;      // Max = 1000 * 60 * 60 * 24 = 86,400,000

    iDate := DateTimeToTimeStamp(Present).Date - 730830; // Subtract recent Date to shrink resulting number
    ID := Format('%s_%s%s', [Copy(DisplayName, 1, 5),
      ConvertBase(iDate, 3), ConvertBase(iThisTime, 6)]);
    icLastTime := iThisTime;
  end;
end;


{ TLight }

constructor TLight.Create;
begin
    MyType:= otLight;
end;

end.
