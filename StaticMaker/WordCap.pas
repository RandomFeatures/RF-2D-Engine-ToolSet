{$F+,X+}
unit Wordcap;                                              
{**********************************************************************}
{** WordCap - provides a gradient filled caption bar, with Italic    **}
{**   text, in the style of MSOffice for Win95.                      **}
{** ---------------------------------------------------------------- **}
{** Author  - Warren F. Young.                                       **}
{** e-mail   - wfy@ee.ed.ac.uk,   or   Warren.Young@ee.ed.ac.uk      **}
{** WWW      - http://www.ee.ed.ac.uk/~wfy/components.html           **}
{**            If the above emails do not work then (and only then)  **}
{**            try this e-mail address:  Warren@wmyoung.clara.net    **}
{** ---------------------------------------------------------------- **}
{** Brief History                                                    **}
{**   - Version 1.00  (23/July/1996)  Initial release (WWW).         **}
{**   - Version 1.10  (1/October/1996)  First official release.      **}
{**   - Version 1.20  (17/December/1996) Fixed some drawing problems.**}
{**   - Version 1.30  (24/January/1997)  Improved drawing (incl MDI) **}
{**   - Version 1.40  (15/May/1997)  Fixed Mem leaks + small errors  **}
{**   - Version 1.45  (11/November/1997) Allows different colours    **}
{**       at boths ends of the caption.                              **}
{** ---------------------------------------------------------------- **}
{** Copyright- ©copyright 1996, 1997 by Warren F. Young.             **}
{**   Free to use and redistribute and edit, but my name must appear **}
{**   somewhere in the source code.  No warranty is given by the     **}
{**   author, expressed or implied.                                  **}
{**********************************************************************}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
  Forms, Dialogs, Controls, {$ifndef win32} Call32NT, {$endif} DsgnIntf;

const
  FWordSpacing = 3;
type
  TFontKind = (fkCustom, fkSystem, fkSystemI, fkSystemB, fkSystemBI, fkAutoHeight);

  TMSOfficeCaption = class;

  TCompanyText = class(TPersistent)
  private
    { Private declarations }
    FCaption  : String;
    FColorActive  : TColor;
    FColorInactive: TColor;
    FFont     : TFont;
    FFontKind : TFontKind;
    FOwner    : TMSOfficeCaption;
    FVisible  : Boolean;
    function StoreFont : Boolean;
  protected
    { Protected declarations }
    procedure SetColorActive(Value: TColor);
    procedure SetColorInactive(Value: TColor);
    procedure SetCaption(Value: String); virtual;
    procedure SetFont(Value: TFont);
    procedure SetFontKind(Value: TFontKind);
    procedure SetVisible(Value: Boolean);
    procedure SetFontKind_NoRedraw(Value: TFontKind);
  public
    { Public declarations }
    constructor Create(AOwner: TMSOfficeCaption);  virtual;
    destructor  Destroy; override;
  published
    { Published declarations }
    property Caption : String read FCaption write SetCaption;
    property ColorActive : TColor read FColorActive write SetColorActive default clCaptionText;
    property ColorInactive : TColor read FColorInactive write SetColorInactive default clInactiveCaptionText;
    property Font : TFont read FFont write SetFont stored StoreFont;
    property FontKind : TFontKind read FFontKind write SetFontKind;
    property Visible : Boolean read FVisible write SetVisible;
  end;  { TCompanyText }

  TAppNameText = class(TCompanyText)
  end;  { same as TCompanyText, just show differently in object inspector }

  TCaptionText = class(TCompanyText)
  protected
    function  GetCaption: String; virtual;
  published
    { Published declarations }
    property Caption : String read GetCaption write SetCaption;
  end;

  TGradEnabled = (geAlways, geNever, geWhenActive, geSmart);
  TJustification = (jAuto, jLeft, jCenter, jRight);
  TOnDrawCaption = procedure(Sender: TObject; const Canvas: TCanvas; var R: TRect) of object;

  TMSOfficeCaption = class(TComponent)
  private
    { Private declarations }
    FAppNameText  : TAppNameText;
    FCaptionText  : TCaptionText;
    FCompanyText  : TCompanyText;
    FColorLeftActive    : TColor;
    FColorLeftInActive  : TColor;
    FColorRightActive   : TColor;
    FColorRightInActive : TColor;
    FEnabled      : TGradEnabled;
    FHooked       : Boolean;
    FJustification: TJustification;
    FNumColors    : integer;
    FSystemFont   : TFont;
    MyOwner       : TForm;
    MyOwnerHandle : THandle;
    FWindowActive : Boolean;
    FActiveDefined: Boolean;
    FRecreating   : Boolean;
    FOnDrawCaption: TOnDrawCaption;
    function    GetVisibleButtons: TBorderIcons;
    procedure   ExcludeBtnRgn (var R: TRect);
    procedure   GetSystemFont(F : TFont);
    function    GetTextRect: TRect;
    function    GetTitleBarRect: TRect;
    procedure   GradientFill(DC: HDC; FBeginColor, FEndColor: TColor; R: TRect);
    function    MeasureText(DC: HDC; R: TRect; FText: TCompanyText): integer;
    procedure   NewCaptionText;
    procedure   PaintMenuIcon(DC: HDC; var R: TRect);
    procedure   PaintCaptionText(DC: HDC; var R: TRect; FText: TCompanyText; Active: Boolean);
    {$ifdef win32}
    procedure   PaintCaptionButtons(DC: HDC; var Rect: TRect);
    procedure   Perform_NCPaint(var AMsg: TMessage);
    procedure   Perform_NCActivate(var AMsg: TMessage);
    function    Handle_WMSetCursor(var Msg: TWMSetCursor): Boolean;
    {$endif}
    procedure   SetAutoFontHeight(F: TFont);
    procedure   SolidFill(DC: HDC; FColor: TColor; R: TRect);
    {$ifndef win32}
    function    TrimCaptionText(Var S: String; DC:HDC; TextRect: TRect) : Boolean;
    {$endif}
    function    WindowIsActive: Boolean;
  protected
    { Protected declarations }
    OldWndProc  : TFarProc;
    NewWndProc  : Pointer;
    procedure   Loaded; override;
    procedure   SetColorLeftActive(C: TColor);
    procedure   SetColorLeftInActive(C: TColor);
    procedure   SetColorRightActive(C: TColor);
    procedure   SetColorRightInActive(C: TColor);
    procedure   SetEnabled(Val: TGradEnabled);
    procedure   SetJustification(Val: TJustification);
    procedure   SetNumColors(Val: integer);
  public
    { Public declarations }
    procedure   HookWin;
    procedure   UnhookWin;
    procedure   HookWndProc(var AMsg: TMessage);
    function    HookAppWndProc(var AMsg: TMessage): Boolean;
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy; override;
    procedure   UpdateCaption;
    function    DrawMSOfficeCaption(fActive : boolean) : TRect;
  published
    { Published declarations }
    property AppNameText : TAppNameText read FAppNameText write FAppNameText;
    property CaptionText : TCaptionText read FCaptionText write FCaptionText;
    property CompanyText : TCompanyText read FCompanyText write FCompanyText;
    property ColorLeftActive : TColor read FColorLeftActive write SetColorLeftActive default clBlack;
    property ColorLeftInActive : TColor read FColorLeftInActive write SetColorLeftInActive default clBlack;
    property ColorRightActive : TColor read FColorRightActive write SetColorRightActive default clActiveCaption;
    property ColorRightInActive : TColor read FColorRightInActive write SetColorRightInActive default clInActiveCaption;
    property Enabled : TGradEnabled read FEnabled write SetEnabled default geSmart;
    property Justification : TJustification read FJustification write SetJustification default jAuto;
    property NumColors : integer read FNumColors write SetNumColors default 64;
    property OnDrawCaption: TOnDrawCaption read FOnDrawCaption write FOnDrawCaption;
  end;

procedure Register;

implementation

const
  WM_WordCapRecreateNotify = WM_USER + 17804;
  { A random number for an internal message used by WordCap exclusively. }

{$ifndef win32}
const
  SPI_GETNONCLIENTMETRICS = 41;
  SM_CXSMICON = 49;
  SM_CYSMICON = 50;

type
  TOS_Bits = (os16bit, os32bit);
  TW32LogFont = record
    lfHeight: longint;
    lfWidth: longint;
    lfEscapement: longint;
    lfOrientation: longint;
    lfWeight: longint;
    lfItalic: Byte;
    lfUnderline: Byte;
    lfStrikeOut: Byte;
    lfCharSet: Byte;
    lfOutPrecision: Byte;
    lfClipPrecision: Byte;
    lfQuality: Byte;
    lfPitchAndFamily: Byte;
    lfFaceName: array[0..lf_FaceSize - 1] of Char;
  end;

  TNONCLIENTMETRICS = record
    cbSize: longint;
    iBorderWidth: longint;
    iScrollWidth: longint;
    iScrollHeight: longint;
    iCaptionWidth: longint;
    iCaptionHeight: longint;
    lfCaptionFont: TW32LogFont;
    iSmCaptionWidth: longint;
    iSmCaptionHeight: longint;
    lfSmCaptionFont: TW32LogFont;
    iMenuWidth: longint;
    iMenuHeight: longint;
    lfMenuFont: TW32LogFont;
    lfStatusFont: TW32LogFont;
    lfMessageFont: TW32LogFont;
  end;

  TOSVERSIONINFO = record
    dwOSVersionInfoSize: longint;
    dwMajorVersion: longint;
    dwMinorVersion: longint;
    dwBuildNumber: longint;
    dwPlatformId: longint;
    szCSDVersion: array[1..128] of char;
  end;

  TW32Rect = record
    left, top, right, bottom: longint;
  end;

var
  FOS_Bits : TOS_Bits;
  NewStyleControls : Boolean;
  W32SystemParametersInfo:
    function(uiAction: longint; uiParam:longint; pvParam:TNonClientMetrics; fWinIni:longint; id:longint):longint;
  W32GetSystemMetrics:
    function(index: longint; id:longint):longint;
  GetVersionEx:
    function(pvParam:TOSVersionInfo; id:longint):longint;
  CopyImage:
    function(HImage, uType, cX, cY, flags :longint; id:longint):longint;
  DrawIconEx:
    function(HDC, left, top, HIcon, Width, Height, frame, FlickFreeBrush, Flags: longint; id:longint):longint;
  DrawFrameControl:
    function(HWND, R: TW32Rect; uType, uState: longint; id:longint): longint;
  id_W32SystemParametersInfo : Longint;
  id_W32GetSystemMetrics : Longint;
  id_W32GetVersionEx : Longint;
  id_W32CopyImage : Longint;
  id_W32DrawIconEx : Longint;
  id_W32DrawFrameControl : Longint;
{$endif}

constructor TCompanyText.Create(AOwner: TMSOfficeCaption);
begin
  inherited Create;
  FOwner := AOwner;
  FColorActive := (clCaptionText);
  FColorInactive := (clInactiveCaptionText);
  FFont := TFont.Create;
  FFontKind := fkSystem;
  FFont.Assign(FOwner.FSystemFont);
  FVisible := true;
  FCaption := '';
end;

destructor TCompanyText.Destroy;
begin
  FFont.Free;
  inherited destroy;
end;

procedure TCompanyText.SetColorActive(Value: TColor);
begin
  FColorActive := value;
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;  { TCompanyText.SetColorActive }

procedure TCompanyText.SetColorInactive(Value: TColor);
begin
  FColorInactive := value;
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;  { TCompanyText.SetColorInactive }

procedure TCompanyText.SetCaption(Value: String);
begin
  If FCaption = Value then exit;
  FCaption := Value;
  FOwner.NewCaptionText;
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;  { TCompanyText.SetCaption }

procedure TCompanyText.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  If FFontKind = fkAutoHeight
    then FOwner.SetAutoFontHeight(FFont)
    else FFontKind := fkCustom;
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;  { TCompanyText.SetFont }

function TCompanyText.Storefont : Boolean;
begin
  result := not (FFontKind in [fkSystem, fkSystemB, fkSystemBI, fkSystemI]);
end; { StoreFont }

procedure TCompanyText.SetFontKind(Value: TFontKind);
begin
  SetFontKind_noRedraw(Value);
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;

procedure TCompanyText.SetFontKind_NoRedraw(Value: TFontKind);
begin
  FFontKind := Value;
  case FFontKind of
    fkCustom: { do nothing special };
    fkSystem: FFont.Assign(FOwner.FSystemFont);
    fkSystemI{Italics}: begin
            FFont.Assign(FOwner.FSystemFont);
            FFont.Style := FFont.Style + [fsItalic];
            end;
    fkSystemB{Bold}: begin
            FFont.Assign(FOwner.FSystemFont);
            FFont.Style := FFont.Style + [fsBold];
            end;
    fkSystemBI: begin
            FFont.Assign(FOwner.FSystemFont);
            FFont.Style := FFont.Style + [fsItalic, fsBold];
            end;
    fkAutoHeight: FOwner.SetAutoFontHeight(FFont);
  end;  { case }
end;   { TCompanyText.SetFontKind_noRedraw }

procedure TCompanyText.SetVisible(Value: Boolean);
begin
  If FVisible = Value then exit;
  FVisible := Value;
  FOwner.NewCaptionText;
  if csDesigning in FOwner.ComponentState then FOwner.UpdateCaption;
end;   { TCompanyText.SetVisible }

{------------------------------------------------------------------------------}
{  TCaptionText Component                                                      }
{------------------------------------------------------------------------------}
function TCaptionText.GetCaption: String;
var temp : string;
    found : integer;
begin
  try
    if FOwner.MyOwner = nil then begin result := ''; exit; end;
    temp := FOwner.MyOwner.Caption;
    If FOwner.FCompanyText.Visible then
    begin
      found := Pos(FOwner.FCompanyText.Caption, Temp);
      if found <> 0 then temp := Copy(temp, found + length(FOwner.FCompanyText.Caption), maxint);
      if length(temp) > 0 then if temp[1] = ' ' then temp := Copy(temp, 2, maxint);
    end;
    If FOwner.FAppNameText.Visible then
    begin
      found := Pos(FOwner.FAppNameText.Caption, Temp);
      if found <> 0 then temp := Copy(temp, found + length(FOwner.FAppNameText.Caption), maxint);
      if length(temp) > 0 then if temp[1] = ' ' then temp := Copy(temp, 2, maxint);
    end;
    result := temp;
  except
    {$ifdef win32} on EAccessViolation do result := '';
    {$endif}
  end;
end; { TCaptionText.GetCaption }

{------------------------------------------------------------------------------}
{  TMSOfficeCaption  Component                                                 }
{------------------------------------------------------------------------------}
constructor TMSOfficeCaption.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with AOwner as TForm do MyOwner := TForm(AOwner);  { My pointer to my owner form }
  MyOwnerHandle := MyOwner.Handle;
  FWindowActive := true;  { assumption }
  FActiveDefined := false;
  FOnDrawCaption := NIL;
  FSystemFont := TFont.Create;
  try
    GetSystemFont(FSystemFont);
  except
    {$ifdef win32} On EAccessViolation do begin
    {$else} On EGPFault do begin
    {$endif}
      FSystemFont.Free;
      FSystemFont := nil;
      raise;
    end;
  end;  { try except }
  FCompanyText := TCompanyText.Create(self);
  FAppNameText := TAppNameText.Create(self);
  FCaptionText := TCaptionText.Create(self);
  FColorLeftActive := clBlack;
  FColorLeftInActive := clBlack;
  FColorRightActive := clActiveCaption;
  FColorRightInActive := clInActiveCaption;
  FEnabled := geSmart;                     
  FHooked  := false;
  FJustification := jAuto;
  FNumColors  := 64;
  FRecreating := false;
  Hookwin;
  if csdesigning in ComponentState then
  if not (csReadingState in MyOwner.ControlState) then
  begin
    { Set default fonts unless stored user settings are being loaded }
    FCompanyText.FCaption := 'Warren''s';
    FAppNameText.FCaption := 'Program -';
    FCaptionText.FCaption := MyOwner.Caption;
    NewCaptionText;
    FCaptionText.SetFontKind_noRedraw(fkSystem);
    FAppNameText.SetFontkind_noRedraw(fkSystemB);  { system + bold }
    FCompanyText.SetFontkind_noRedraw(fkSystemBI); { system + bold + italic }
    DrawMSOfficeCaption(WindowIsActive);   { do the first-time draw }
  end;
end;  { TMSOfficeCaption.Create }

procedure TMSOfficeCaption.loaded;
begin
  inherited loaded;
  { some people have reported problems with TForm's position being poScreenCenter.
    this removes the problem (I believe - I've never replicated the problem so I
    can't test it). }
  If MyOwnerHandle <> MyOwner.Handle then
  begin
    UnhookWin;
    HookWin;
  end;
end;

destructor TMSOfficeCaption.Destroy;
begin
  UnHookWin;
  { update caption if the parent form is not being destroyed }
  If not (csDestroying in MyOwner.ComponentState) then
  begin
    MyOwner.caption := FCaptionText.Caption;
    UpdateCaption;
  end;
  FAppNameText.Free;
  FCaptionText.Free;
  FCompanyText.Free;
  FSystemFont.Free;
  inherited destroy;  {Call default processing.}
end;  { TMSOfficeCaption.Destroy }

procedure TMSOfficeCaption.HookWin;
begin
  MyOwnerHandle := MyOwner.Handle;
  OldWndProc := TFarProc(GetWindowLong(MyOwnerHandle, GWL_WNDPROC));
  NewWndProc := MakeObjectInstance(HookWndProc);
  SetWindowLong(MyOwnerHandle, GWL_WNDPROC, LongInt(NewWndProc));
  If not FRecreating then Application.HookMainWindow(HookAppWndProc);
  FRecreating := false;
  FHooked := true;
end;  { HookWin }

procedure TMSOfficeCaption.UnhookWin;
begin
  If not FHooked then exit;  { don't ever unhook a non-hooked window }
  If not FRecreating then Application.UnhookMainWindow(HookAppWndProc);
  SetWindowLong(MyOwnerHandle, GWL_WNDPROC, LongInt(OldWndProc));
  if assigned(NewWndProc) then FreeObjectInstance(NewWndProc);
  NewWndProc := nil;
  FHooked := false;
end;  { UnHookWin }

function TMSOfficeCaption.WindowIsActive: Boolean;
begin
  If FActiveDefined then begin Result := FWindowActive; exit; end;
  Result := (MyOwnerHandle = GetActiveWindow);
  If (MyOwner.FormStyle = fsMDIChild)
    then if Application <> nil
    then if Application.Mainform <> nil
    then if MyOwner = Application.Mainform.ActiveMDIChild
    then if Application.Mainform.HandleAllocated
    then if Application.Mainform.Handle = GetActiveWindow
      then result := true;
end;  { WindowIsActive }

{$ifdef win32}
procedure TMSOfficeCaption.Perform_NCPaint(var AMsg: TMessage);
var
  R, WR : TRect;
  MyRgn : HRgn;
  DC : HDC;
begin
  R := DrawMSOfficeCaption(WindowIsActive);
  DC := GetWindowDC(MyOwnerHandle);
  GetWindowRect(MyOwnerHandle, WR);
  MyRgn := CreateRectRgnIndirect(WR);
  try
    if SelectClipRgn(DC, AMsg.wParam) = ERROR
      then SelectClipRgn(DC, MyRgn);
    OffsetClipRgn(DC, -WR.Left, -WR.Top);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    OffsetClipRgn(DC, WR.Left, WR.Top);
    GetClipRgn(DC, MyRgn);
    AMsg.Result := CallWindowProc(OldWndProc,MyOwnerHandle, AMsg.Msg, MyRgn, AMsg.lParam);
  finally
    DeleteObject(MyRgn);
    ReleaseDC(MyOwnerHandle, DC);
  end;
end;  { perform_NCPaint for win32 }

procedure TMSOfficeCaption.Perform_NCActivate(var AMsg: TMessage);
begin
  FWindowActive := TWMNCActivate(AMsg).Active;
  FActiveDefined := true;
  if (not NewStyleControls)
    then AMsg.Result := CallWindowProc(OldWndProc, MyOwnerHandle, AMsg.Msg, AMsg.wParam, AMsg.lParam)
    else if (MyOwner.FormStyle = fsMDIChild) { cover up hassles with minimized MDI children borders and button redrawing }
         then AMsg.Result := CallWindowProc(OldWndProc, MyOwnerHandle, AMsg.Msg, AMsg.wParam, AMsg.lParam);

  If MyOwner.FormStyle = fsMDIForm
    then if Application <> nil
    then if Application.Mainform <> nil
    then if Application.Mainform.ActiveMDIChild <> nil
      then PostMessage(Application.Mainform.ActiveMDIChild.Handle, WM_NCACTIVATE, longint(TWMNCActivate(AMsg).Active), 0);

  { cause a nc_Paint message to occur (immediately) }
  ReDrawWindow(MyOwnerHandle,nil,0,RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
  { was previously...  DrawMSOfficeCaption(TWMNCActivate(AMsg).Active); }

  AMsg.Result := 1;
  AMsg.wParam := 1;   { Tell windows that we have handled the message }
end;  { perform_NCActivate for win32 }
{$endif}

procedure TMSOfficeCaption.HookWndProc(var AMsg: TMessage);
begin
  {$ifdef win32}
  if AMsg.Msg = WM_NCPAINT then
    begin Perform_NCPaint(AMsg); exit; end; { NCPaint is handled for win32 }
  if AMsg.Msg = WM_NCACTIVATE then
    begin Perform_NCActivate(AMsg); exit; end; { NCActivate is handled for win32 }
  if AMsg.Msg = WM_SETCURSOR then
    begin if Handle_WMSetCursor(TWMSetCursor(AMsg)) then exit; end; { SetCursor is handled for win32 }
  {$endif}

  if AMsg.Msg = WM_DESTROY then begin
    {Note: WM_DESTROY is trapped here when the form itself is destroyed,
        and whenever the RecreateWnd method of the form is called }
    if not (csDestroying in ComponentState) then
    begin
      { We must unhook the WindowProc, and then rehook it later }
      FRecreating := True;
      UnHookWin;
      { Notify WordCap to rehook the form. A message must be posted so that this
        can be done once the form has completed the recreation process. }
      PostMessage (Application.Handle, WM_WordCapRecreateNotify, 0, Longint(Self));
      { don't exit.  Allow default processing to still occur }
    end;
  end;

  { now handle all other calls }
  AMsg.Result := CallWindowProc(OldWndProc,MyOwnerHandle, AMsg.Msg, AMsg.wParam, AMsg.lParam);

  {$ifdef win32}
  if AMsg.Msg = WM_SETICON then DrawMSOfficeCaption(WindowIsActive);
  {$endif}
  {$ifndef win32}
  if AMsg.Msg = WM_NCPAINT then DrawMSOfficeCaption(WindowIsActive);
  if AMsg.Msg = WM_NCACTIVATE then
  begin
    FWindowActive := TWMNCActivate(AMsg).Active;
    FActiveDefined := true;
    DrawMSOfficeCaption(TWMNCActivate(AMsg).Active);
  end;
  {$endif}
  {$ifdef win32}
  if ((AMsg.Msg = WM_DISPLAYCHANGE)  or
      (AMsg.Msg = WM_SysColorChange) or
      (AMsg.Msg = WM_WININICHANGE) or
      (AMsg.Msg = WM_SETTINGCHANGE)) then
  {$else}
  if AMsg.Msg = WM_WININICHANGE then
  {$endIf}
  begin
    GetSystemFont(FSystemFont);  { update systemfont }
    FAppNameText.SetFontkind_noRedraw(FAppNameText.FFontkind);
    FCaptionText.SetFontKind_noRedraw(FCaptionText.FFontKind);
    FCompanyText.SetFontkind_noRedraw(FCompanyText.FFontkind);
    UpdateCaption;  {force a NC region redraw};
  end;
end;  { HookWndProc }

function TMSOfficeCaption.HookAppWndProc(var AMsg: TMessage): Boolean;
begin
  Result := False;
  if AMsg.Msg = WM_WordCapRecreateNotify then begin
    if AMsg.LParam <> longint(self) then exit;    { did the message come from this instance or another instance? }
    HookWin;  { Rehook the form }
    If GetActiveWindow = MyOwnerHandle then FWindowActive := true;
    UpdateCaption; {}
  end;
end;

procedure TMSOfficeCaption.UpdateCaption;
begin
  SetWindowPos( MyOwnerHandle, 0, 0, 0, 0, 0,
                SWP_FRAMECHANGED or SWP_DRAWFRAME or
                SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;  { UpdateCaption }

procedure TMSOfficeCaption.GetSystemFont(F : TFont);
var
  FNONCLIENTMETRICS : TNONCLIENTMETRICS;
begin
  F.Handle := GetStockObject(SYSTEM_FONT);
  {$ifndef win32} If (FOS_Bits = os16Bit) then exit; {$endif}
  { if OS is 32bit, get font by calling Win32 API routine }
  FNONCLIENTMETRICS.cbSize := Sizeof(TNONCLIENTMETRICS);
  {$ifdef win32}
  if boolean(SystemParametersInfo(    SPI_GETNONCLIENTMETRICS, 0,
                                      @FNONCLIENTMETRICS, 0))
  {$else}
  if boolean(w32SystemParametersInfo( SPI_GETNONCLIENTMETRICS, 0,
                                      FNONCLIENTMETRICS, 0,
                                      id_w32SystemParametersInfo))
  {$endif}
  then begin
    { work now with FNonClientMetrics.lfCaptionFont }
    F.Name := FNonClientMetrics.lfCaptionFont.lfFacename;
    if FNonClientMetrics.lfCaptionFont.lfHeight > 0
      then F.Size := FNonClientMetrics.lfCaptionFont.lfHeight
      else F.Height := FNonClientMetrics.lfCaptionFont.lfHeight;
    F.Style := [];
    if FNonClientMetrics.lfCaptionFont.lfItalic <> 0
      then F.Style := F.Style + [fsItalic];
    if FNonClientMetrics.lfCaptionFont.lfWeight > FW_MEDIUM
      then F.Style := F.Style + [fsBold];
    F.Pitch := fpDefault;
  end;
end;  { procedure TMSOfficeCaption.GetSystemFont }

procedure TMSOfficeCaption.NewCaptionText;
var temp: string;
begin
  {$ifdef win32}  LockWindowUpdate(MyOwnerHandle);  {$endif}
  temp := '';
  If FCompanyText.Visible then temp := temp + FCompanyText.FCaption;
  If FCompanyText.Visible and (FCompanyText.Caption <> '')
     and (FAppNameText.Visible or FCaptionText.Visible) then temp := temp + ' ';
  If FAppNameText.Visible then temp := temp + FAppNameText.FCaption;
  If FAppNameText.Visible and (FAppNameText.Caption <> '') and FCaptionText.Visible then temp := temp + ' ';
  If FCaptionText.Visible then temp := temp + FCaptionText.FCaption;
  MyOwner.Caption := temp;
  {$ifdef win32}  LockWindowUpdate(0);  {$endif}
end;  { TMSOfficeCaption.NewCaptionText }

function TMSOfficeCaption.GetTitleBarRect: TRect;
var BS : TFormBorderStyle;
begin
  BS:= MyOwner.BorderStyle;
  if csDesigning in ComponentState then BS:= bsSizeable;
  { if we have no border style, then just set the rectangle empty. }
  if BS = bsNone then begin SetRectEmpty(Result); exit; end;

  GetWindowRect(MyOwnerHandle, Result);
  { Convert rect from screen (absolute) to client (0 based) coordinates. }
  OffsetRect(Result, -Result.Left, -Result.Top);
  { Shrink rectangle to allow for window border.  We let Windows paint the border. }
  { this catches drawing MDI minimised windows caption bars in Win95 }
  if IsIconic(MyOwnerHandle)
    then begin
      {$ifdef win32}
      If NewStyleControls
        then InflateRect(Result, -GetSystemMetrics(SM_CXFIXEDFRAME),
                                 -GetSystemMetrics(SM_CYFIXEDFRAME))
        else {$endif} InflateRect(Result, -GetSystemMetrics(SM_CYBORDER)-GetSystemMetrics(SM_CXDLGFRAME),
                                 -GetSystemMetrics(SM_CYBORDER)-GetSystemMetrics(SM_CYDLGFRAME));
    end
  else
  case BS of
    {$ifdef win32} bsToolWindow, bsSingle, bsDialog:
        InflateRect(Result, -GetSystemMetrics(SM_CXFIXEDFRAME),
                            -GetSystemMetrics(SM_CYFIXEDFRAME));
    bsSizeToolWin, bsSizeable:
        InflateRect(Result, -GetSystemMetrics(SM_CXSIZEFRAME),
                            -GetSystemMetrics(SM_CYSIZEFRAME));
    {$else}
    bsDialog:
        InflateRect(Result, -(GetSystemMetrics(SM_CXBORDER)+GetSystemMetrics(SM_CXDLGFRAME)),
                            -(GetSystemMetrics(SM_CYBORDER)+GetSystemMetrics(SM_CYDLGFRAME)) );
    bsSingle:
        InflateRect(Result, -GetSystemMetrics(SM_CXBORDER),
                            -GetSystemMetrics(SM_CYBORDER));
    bsSizeable:
        InflateRect(Result, -GetSystemMetrics(SM_CXFRAME),
                            -GetSystemMetrics(SM_CYFRAME));
    {$endif}
   end;

  { Set the appropriate height of caption bar. }
  {$ifdef win32}
  if BS in [bsToolWindow, bsSizeToolWin] then
    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYSMCAPTION) - 1
  else {$endif}
    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYCAPTION) - 1;
  {$ifndef win32} Result.Bottom := Result.Bottom-1; {$endif}
end;  { TMSOfficeCaption.GetTitleBarRect }

function TMSOfficeCaption.GetVisibleButtons: TBorderIcons;
var BS : TFormBorderStyle;
begin
  Result := [];
  if csDesigning in ComponentState then begin result := [biSystemMenu, biMaximize, biMinimize]; exit; end;
  BS:= MyOwner.BorderStyle;
  if BS = bsNone then exit;
  {$ifdef win32}
  if not (biSystemMenu in MyOwner.BorderIcons) then exit;  { none will be visible }
  if BS in [bsToolWindow, bsSizeToolWin]
  then begin
    Result := [biSystemMenu];  { close icon only }
    exit;
  end;
  {$endif}

  { ???? check this carefully for 16-bit accuracy ???? }
  if (NewStyleControls {$ifdef win32} and (biSystemMenu in MyOwner.BorderIcons) {$endif} )
    then Result := [biSystemMenu];  { close icon - this is OS dependant }
  {$ifdef win32}
  if ((BS = bsDialog) and (biHelp in MyOwner.BorderIcons) and (biSystemMenu in MyOwner.BorderIcons))
    then Result := Result + [biHelp];  { help icon }
  if ((BS = bsSingle) and (biHelp in MyOwner.BorderIcons)
      and (not(biMinimize in MyOwner.BorderIcons))
      and (not(biMaximize in MyOwner.BorderIcons)) )
    then Result := Result + [biHelp];  { help icon }
  if ((BS = bsSizeable) and (biHelp in MyOwner.BorderIcons)
      and (not(biMinimize in MyOwner.BorderIcons))
      and (not(biMaximize in MyOwner.BorderIcons)) )
    then Result := Result + [biHelp];  { help icon }
  {$endif}
  if BS = bsDialog then exit;  { no chance of Min&Max buttons }
  if NewStyleControls then
  begin
    if ((biMinimize in MyOwner.BorderIcons) or (biMaximize in MyOwner.BorderIcons))
      then Result := Result + [biMinimize, biMaximize];  { minimise and maximise button }
  end
  else begin
    if (biMinimize in MyOwner.BorderIcons)
      then Result := Result + [biMinimize];  { minimise button }
    if (biMaximize in MyOwner.BorderIcons)
      then Result := Result + [biMaximize];  { maximise button }
  end;
end;  { TMSOfficeCaption.GetVisibleButtons }

procedure TMSOfficeCaption.ExcludeBtnRgn (var R: TRect);
var BtnWidth: integer;
    BI : TBorderIcons;
begin
  if ((MyOwner.BorderStyle = bsNone) and (not(csDesigning in ComponentState))) then exit;
  {$ifdef win32}
  if ((MyOwner.BorderStyle in [bsToolWindow, bsSizeToolWin]) and (not(csDesigning in ComponentState)))
    then BtnWidth := GetSystemMetrics(SM_CXSMSIZE)
    else {$endif} BtnWidth := GetSystemMetrics(SM_CXSIZE);

  BI := GetVisibleButtons;
  if (biSystemMenu in BI) then R.Right := R.Right - BtnWidth - 2; { close icon }
  if (biMinimize in BI) then R.Right := R.Right - BtnWidth;  { minimize icon }
  if (biMaximize in BI) then R.Right := R.Right - BtnWidth;  { maximize icon }
  {$ifdef win32}
  if (biHelp in BI) then R.Right := R.Right - BtnWidth - 2;  { help icon }
  {$endif}
  if not NewStyleControls then
    if ( ((biSystemMenu in MyOwner.BorderIcons) and (MyOwner.BorderStyle in [bsSingle, bsSizeable]))
      or (csDesigning in ComponentState) )
    then R.Left := R.Left + BtnWidth;  { let windows do the system icon in win3 style }
end;  { TMSOfficeCaption.ExcludeBtnRgn }

function TMSOfficeCaption.GetTextRect: TRect;
begin
  result := GetTitleBarRect;
  ExcludeBtnRgn(result);

  If result.Right <= result.Left then {error}
    result.Right := result.Left+2;  { right must be greater than left- otherwise system resources get lost }
end;  { GetTextRect }

{$ifndef win32}
function  TMSOfficeCaption.TrimCaptionText(Var S: String; DC:HDC; TextRect: TRect): Boolean;
{ returns true if the text was altered in any way }
var
  TheWidth : integer;
  textlen : integer;
  temp    : string;
  OldFont: HFont;
  P: ^string;
  T: String;
  R: TRect;
begin
  result := false;  { assume no truncation of text }
  R := Rect(0,0,1000,100);
  if FCaptionText.FFont.Handle <> 0
    then OldFont := SelectObject(DC, FCaptionText.FFont.Handle)
    else OldFont := 0;
  try
    {------------------------------------------------------------------------}
    {Truncate the window caption text, until it will fit into the captionbar.}
    {------------------------------------------------------------------------}
    Temp := S;
    textlen := length(S);
    T := S + #0;
    P := @T[1];
    DrawText(DC, PChar(P), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_CALCRECT);
    TheWidth := R.Right - R.Left;
    { use this to see if the text will fit - if not, remove some chars, add "..." and try again }
    { resize or truncate the text to fit in the caption bar}
    while ((TheWidth > (TextRect.right-TextRect.left)) and (TextLen > 1)) do
    begin
      temp:= Copy(S, 0, Textlen-1);           { truncate                }
      AppendStr(temp, '...');                 { add ... onto text       }
      dec(Textlen);
      T := temp + #0;
      P := @T[1];
      DrawText(DC, PChar(P), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_CALCRECT);
      TheWidth := R.Right - R.Left;
      result := true;
    end;
    S := temp + '   '; { spaces for safety }
  finally
    { Clean up all the drawing objects. }
    if OldFont <> 0 then SelectObject(DC, OldFont);
  end;
end;  { TrimCaptionText }
{$endif}

{ Paint the icon for the system menu.  Based on code from Brad Stowers }
procedure TMSOfficeCaption.PaintMenuIcon(DC: HDC; var R: TRect);
const
  LR_COPYFROMRESOURCE = $4000; { Missing from WINDOWS.PAS! }
var
  IconHandle: HIcon;
  NewIconHandle: HIcon;
  IconNeedsDestroying : Boolean;
  IconX, IconY : integer;
{$ifndef win32}
const
  IMAGE_ICON = 1;
  DI_Normal = 3;
{$endif}
begin
  If not NewStyleControls then exit;  { a safety catch - shouldn't be needed }
  Inc(R.Left, 1);
  IconNeedsDestroying := false;
  { Does the form (or application) have an icon assigned to it? }
  if MyOwner.Icon.Handle <> 0
    then IconHandle := MyOwner.Icon.Handle
    else if Application.Icon.Handle <> 0
      then IconHandle := Application.Icon.Handle
      else begin
        IconHandle := LoadIcon(0, IDI_APPLICATION);  { system defined application icon. }
        IconNeedsDestroying := true;
      end;

  {$ifdef win32}
    IconX := GetSystemMetrics(SM_CXSMICON);
    If IconX = 0 then IconX := GetSystemMetrics(SM_CXSIZE);
    IconY := GetSystemMetrics(SM_CYSMICON);
    If IconY = 0 then IconY := GetSystemMetrics(SM_CYSIZE);
  {$else}
    IconX := W32GetSystemMetrics(SM_CXSMICON, id_W32GetSystemMetrics);
    If IconX = 0 then IconX := W32GetSystemMetrics(SM_CXSIZE, id_W32GetSystemMetrics);
    IconY := W32GetSystemMetrics(SM_CYSMICON, id_W32GetSystemMetrics);
    If IconY = 0 then IconY := W32GetSystemMetrics(SM_CYSIZE, id_W32GetSystemMetrics);
  {$endif}
  NewIconHandle := CopyImage(IconHandle,
                       IMAGE_ICON,  { what is it's value??? }
                       IconX, IconY,
                       LR_COPYFROMRESOURCE {$ifndef win32},id_W32CopyImage{$endif});
  DrawIconEx(DC, R.Left+1, R.Top+1,
             NewIconHandle,
             0, 0, 0, 0, DI_NORMAL {$ifndef win32},id_W32DrawIconEx{$endif});
  DestroyIcon(NewIconHandle);
  If IconNeedsDestroying then DestroyIcon(IconHandle);
  {$ifdef win32}
    Inc(R.Left, GetSystemMetrics(SM_CXSMICON)+1);
  {$else}
    Inc(R.Left, W32GetSystemMetrics(SM_CXSMICON, id_W32GetSystemMetrics)+1);
  {$endif}
end;  { procedure TMSOfficeCaption.PaintMenuIcon }

{ based on code from Brad Stowers }
procedure TMSOfficeCaption.PaintCaptionText(DC: HDC; var R: TRect; FText: TCompanyText; Active:Boolean);
var
  OldColor: TColorRef;
  OldBkMode: integer;
  OldFont: HFont;
  P: ^string;
  S:String;
  RTemp: TRect;
begin
  Inc(R.Left, FWordSpacing);
  RTemp:= R;
  if Active
    then OldColor := SetTextColor(DC, ColorToRGB(FText.FColorActive))
    else OldColor := SetTextColor(DC, ColorToRGB(FText.FColorInActive));
  OldBkMode := SetBkMode(DC, TRANSPARENT);  { paint text transparently - so gradient can show through }
  { Select in the required font for this text. }
  if FText.FFont.Handle <> 0 then
    OldFont := SelectObject(DC, FText.FFont.Handle)
  else
    OldFont := 0;
  try
    { Draw the text making it left aligned, centered vertically, allowing no line breaks. }
    S := FText.FCaption + #0;
    P := @S[1];
    DrawText(DC, PChar(P), -1, RTemp, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_CALCRECT);
    DrawText(DC, PChar(P), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE {$ifdef win32} or DT_END_ELLIPSIS {$endif});
    R.Left := RTemp.Right;
  finally
    { Clean up all the drawing objects. }
    if OldFont <> 0 then
      SelectObject(DC, OldFont);
    SetBkMode(DC, OldBkMode);
    SetTextColor(DC, OldColor);
  end;
end;  { procedure TMSOfficeCaption.PaintCaptionText }

{$ifdef win32}
{ Paint the min/max/help/close buttons - based on code from Brad Stowers. }
procedure TMSOfficeCaption.PaintCaptionButtons(DC: HDC; var Rect: TRect);
var
  BtnWidth: integer;
  Flag: UINT;
  SrcRect: TRect;
  Btns : TBorderIcons;
begin
  SrcRect := Rect;
  InflateRect(SrcRect, -2, -2);
  Btns := GetVisibleButtons;
  BtnWidth := GetSystemMetrics(SM_CXSIZE)-2;
  {$ifdef win32}
  if ((MyOwner.BorderStyle in [bsToolWindow, bsSizeToolWin])
      and (not (csDesigning in ComponentState)))
    then BtnWidth := GetSystemMetrics(SM_CXSMSIZE)-2;
  {$endif}
  SrcRect.Left := SrcRect.Right - BtnWidth;
  { Close button }
  if biSystemMenu in Btns then
  begin
    DrawFrameControl(DC, SrcRect, DFC_CAPTION, DFCS_CAPTIONCLOSE);
    OffsetRect(SrcRect, -BtnWidth-2, 0);
    Dec(Rect.Right,BtnWidth+2);
  end;
  { Maximize button }
  if biMaximize in Btns then
  begin
    if IsZoomed(MyOwnerHandle)
      then Flag := DFCS_CAPTIONRESTORE
      else Flag := DFCS_CAPTIONMAX;
     { if it doesn't have max in style, then it shows up disabled }
    if not (biMaximize in MyOwner.BorderIcons) then
      Flag := Flag or DFCS_INACTIVE;
    DrawFrameControl(DC, SrcRect, DFC_CAPTION, Flag);
    OffsetRect(SrcRect, -BtnWidth, 0);
    Dec(Rect.Right,BtnWidth);
  end;
  { Minimize button }
  if biMinimize in Btns then
  begin
    if IsIconic(MyOwnerHandle)
      then Flag := DFCS_CAPTIONRESTORE
      else Flag := DFCS_CAPTIONMIN;
    { if it doesn't have min in style, then it shows up disabled }
    if not (biMinimize in MyOwner.BorderIcons) then
      Flag := Flag or DFCS_INACTIVE;
    DrawFrameControl(DC, SrcRect, DFC_CAPTION, Flag);
    OffsetRect(SrcRect, -BtnWidth, 0);
    Dec(Rect.Right,BtnWidth);
  end;
  { Help button }
  if (biHelp in Btns) then
  begin
    DrawFrameControl(DC, SrcRect, DFC_CAPTION, DFCS_CAPTIONHELP);
    Dec(Rect.Right,BtnWidth);
  end;
  Dec(Rect.Right, 3);
end;  { procedure TMSOfficeCaption.PaintCaptionButtons }
{$endif}

function TMSOfficeCaption.MeasureText(DC: HDC; R: TRect; FText: TCompanyText): integer;
var
  OldFont: HFont;
  P: ^string;
  S: String;
begin
  { Select in the required font for this text. }
  if FText.FFont.Handle <> 0
    then OldFont := SelectObject(DC, FText.FFont.Handle)
    else OldFont := 0;
  try     { Measure the text making it left aligned, centered vertically, allowing no line breaks. }
    S := FText.FCaption + #0;
    P := @S[1];
    DrawText(DC, PChar(P), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_CALCRECT);
    Result := R.Right+FWordSpacing - R.Left {-1};
  finally
    { Clean up all the drawing objects. }
    if OldFont <> 0 then SelectObject(DC, OldFont);
  end;
end;  { function TMSOfficeCaption.MeasureText }

{******************************************************************************}
{**   DrawMSOfficeCaption - the main routine to draw a shaded caption bar.   **}
{******************************************************************************}
function TMSOfficeCaption.DrawMSOfficeCaption(fActive : boolean) : TRect;
var
  dc,OrigDC : HDC;
  rcText    : TRect;
  rcCaption : TRect;
  rgbColorLeft  : TColor;
  rgbColorRight : TColor;
  rgbColorPlain : TColor;
  OldBmp    : HBitmap;
  Bmp       : HBitmap;
  TotalTextWidth: longint;
  SpaceForCompanyText : Boolean;
  SpaceForAppNameText : Boolean;
  NumColors : longint;
  Shaded    : Boolean;
  BmpCanvas: TCanvas;
  {$ifndef win32} CapRect   : TW32Rect; {$endif}
begin {DrawMSOfficeCaption}
  result := Rect(0,0,0,0);  { in case somthing fails - e.g. resource allocation }
  If ( (MyOwner.BorderStyle = bsNone) and
       (not (csdesigning in ComponentState)) ) then exit; { no drawing to be done }
  OrigDC := GetWindowDC(MyOwnerHandle);
  if OrigDC = 0 then exit;

  DC := CreateCompatibleDC(OrigDC);
  if DC = 0 then begin ReleaseDC(MyOwnerHandle, OrigDC); exit; end;
  rcText := GetTextRect;
  rcCaption := GetTextRect;
  {$ifdef win32}
  If NewStyleControls then rcCaption := GetTitleBarRect;
  {$endif}

  Bmp := CreateCompatibleBitmap(OrigDC, rcCaption.Right, rcCaption.Bottom);
  If Bmp = 0 then begin ReleaseDC(MyOwnerHandle, OrigDC); DeleteDC(DC); exit; end;
  OldBmp := SelectObject(DC, Bmp);
  try
    result := rcCaption;

    {--------------------------------------------------------------------------}
    { Apply Gradient fill (or single color) to all of the Caption Bar area.    }
    {--------------------------------------------------------------------------}
    if fActive then rgbColorPlain := ColorToRGB(clActiveCaption)
               else rgbColorPlain := ColorToRGB(clInActiveCaption);
    if fActive then rgbColorRight := ColorToRGB(ColorRightActive)
               else rgbColorRight := ColorToRGB(ColorRightInactive);
    if fActive then rgbColorLeft  := ColorToRGB(ColorLeftActive)
               else rgbColorLeft  := ColorToRGB(ColorLeftInactive);
    Case FEnabled of
      geAlways : Shaded := true;
      geNever  : Shaded := false;
      geWhenActive : Shaded := fActive;
      geSmart  : begin
                 NumColors := GetDeviceCaps(DC, BITSPIXEL);
                 if fActive then Shaded := NumColors >= 8 else Shaded := NumColors > 8;
                 { following pattern shown by MSWord95 }
                 end;
      else Shaded := false;
    end;  { case of FEnabled }
    {$ifdef win32}
    If NewStyleControls then
    begin
      if Shaded
        then SolidFill(dc, rgbColorRight, rcCaption)
        else SolidFill(dc, rgbColorPlain, rcCaption);
    end;
    {$endif}
    if Shaded
      then GradientFill(dc, rgbColorLeft, rgbColorRight, rcText)
      else SolidFill(dc, rgbColorPlain, rcText);

    {--------------------------------------------------------------------------}
    { Draw the System Menu Icon.     ( and window buttons )                    }
    {--------------------------------------------------------------------------}
    if NewStyleControls then { paint system menu in Win95 style }
    if ( ((biSystemMenu in MyOwner.BorderIcons) and (MyOwner.BorderStyle in [bsSingle, bsSizeable]))
      or (csDesigning in ComponentState) )
      then PaintMenuIcon(dc, rcText);

    {$ifdef win32}
    if NewStyleControls then PaintCaptionButtons(dc, rcCaption);
    {$endif}

    {--------------------------------------------------------------------------}
    { Fire the OnDrawCaption event.                                            }
    {--------------------------------------------------------------------------}
    if assigned(FOnDrawCaption) then begin
      BmpCanvas := TCanvas.Create;
      try
        BmpCanvas.Handle := dc;
        BmpCanvas.Font.Handle := FSystemFont.Handle;
        FOnDrawCaption(Self, BmpCanvas, rcText);
      finally
        BmpCanvas.Free;
      end;
    end;

    {------------------------------------------------------------------------}
    {Determine if there is sufficient space for the CompanyName text and the }
    {CompanyName text and the standard caption text to be all drawn onto the }
    {working Bitmap (i.e. the caption).  If not, is there enough room for    }
    {the AppName text and the standard caption?                              }
    {------------------------------------------------------------------------}
    FCaptionText.FCaption := FCaptionText.Caption; { safety - catches MDI changes }
    TotalTextWidth := MeasureText(dc,rcText,FCompanyText) * ord(FCompanyText.Visible)
                      + MeasureText(dc,rcText,FAppNameText) * ord(FAppNameText.Visible)
                      + MeasureText(dc,rcText,FCaptionText) * ord(FCaptionText.Visible);
    SpaceForCompanyText := (TotalTextWidth < (rcText.Right - rcText.Left));
    if SpaceForCompanyText then
      SpaceForAppNameText := true { space for company ==> space for appname }
    else begin
      TotalTextWidth := MeasureText(dc,rcText,FAppNameText) * ord(FAppNameText.Visible)
                        + MeasureText(dc,rcText,FCaptionText) * ord(FCaptionText.Visible);
      SpaceForAppNameText := (TotalTextWidth < (rcText.Right - rcText.Left));
    end;
    if not SpaceForAppNameText
      then TotalTextWidth := MeasureText(dc,rcText,FCaptionText);

    Case FJustification of
      jLeft   : { do nothing at all - it is already setup for this default };
      jCenter : if (TotalTextWidth < rcText.right - rcText.left)
                  then rcText.Left := rcText.left + ((rcText.right - rcText.left - TotalTextWidth) div 2);
      jRight  : if (TotalTextWidth < rcText.right - rcText.left)
                  then rcText.Left := rcText.left + (rcText.right - rcText.left - TotalTextWidth);
      jAuto   : if ((not NewStyleControls) and (TotalTextWidth < rcText.right - rcText.left))
                  then rcText.Left := rcText.left + ((rcText.right - rcText.left - TotalTextWidth) div 2);
                { FAuto = center caption text only for old style controls/caption }
    end;

    {------------------------------------------------------------------------}
    { Actually draw the CompanyText, AppNameText, and CaptionText.           }
    {------------------------------------------------------------------------}
    if (SpaceForCompanyText and (FCompanyText.FCaption <> '') and (FCompanyText.FVisible))
      then PaintCaptionText(DC, rcText, FCompanyText, fActive);
    if ((SpaceForAppNameText) and (FAppNameText.FCaption <> '') and (FAppNameText.FVisible))
      then PaintCaptionText(DC, rcText, FAppNameText, fActive);
    {Truncate the window caption text, until it will fit into the caption bar.}
    {$ifndef win32} TrimCaptionText(FCaptionText.FCaption, dc, rcText); {$endif}
    If FCaptionText.FVisible
      then PaintCaptionText(DC, rcText, FCaptionText, fActive);

    { copy from temp DC, onto the actual window Caption }
    BitBlt(OrigDC, Result.Left, Result.Top, Result.Right-Result.Left, Result.Bottom-Result.Top,
           DC, Result.Left, Result.Top, SRCCOPY);
  finally
    {Clean up device context & free memory}{ Release the working bitmap resources }
    Bmp := SelectObject(DC, OldBmp);
    DeleteObject(Bmp);
    DeleteDC(DC);
    ReleaseDC(MyOwnerHandle, OrigDC);
  end;
end;  { DrawMSOfficeCaption }

{----------------------------------------------------------------------------}
{     Solid fill procedure                                                   }
{----------------------------------------------------------------------------}
procedure TMSOfficeCaption.SolidFill(DC: HDC; FColor: TColor; R: TRect);
var
  Brush, OldBrush : HBrush;
begin
  Brush := CreateSolidBrush(FColor);
  OldBrush := SelectObject(DC, Brush);
  try
    PatBlt(DC, R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top, PATCOPY);
  finally
    { Clean up the brush }
    Brush := SelectObject(DC, OldBrush);
    DeleteObject(Brush);
  end;
end;  { SolidFill }
{----------------------------------------------------------------------------}
{     Gradient fill procedure                                                }
{----------------------------------------------------------------------------}
procedure TMSOfficeCaption.GradientFill(DC: HDC; FBeginColor, FEndColor: TColor; R: TRect);
var
  { Set up working variables }
  BeginRGBValue  : array[0..2] of Byte;    { Begin RGB values }
  RGBDifference  : array[0..2] of integer; { Difference between begin and end }
                                           { RGB values                       }
  ColorBand : TRect;    { Color band rectangular coordinates }
  I         : Integer;  { Color band index }
  Red       : Byte;     { Color band Red value }
  Green     : Byte;     { Color band Green value }
  Blue      : Byte;     { Color band Blue value }
  Brush, OldBrush     : HBrush;
begin
  { Extract the begin RGB values }
  { Set the Red, Green and Blue colors }
  BeginRGBValue[0] := GetRValue (ColorToRGB (FBeginColor));
  BeginRGBValue[1] := GetGValue (ColorToRGB (FBeginColor));
  BeginRGBValue[2] := GetBValue (ColorToRGB (FBeginColor));
  { Calculate the difference between begin and end RGB values }
  RGBDifference[0] := GetRValue (ColorToRGB (FEndColor)) - BeginRGBValue[0];
  RGBDifference[1] := GetGValue (ColorToRGB (FEndColor)) - BeginRGBValue[1];
  RGBDifference[2] := GetBValue (ColorToRGB (FEndColor)) - BeginRGBValue[2];

  { Calculate the color band's top and bottom coordinates }
  { for Left To Right fills }
  begin
    ColorBand.Top := R.Top;
    ColorBand.Bottom := R.Bottom;
  end;

  { Perform the fill }
  for I := 0 to FNumColors-1 do
  begin  { iterate through the color bands }
    { Calculate the color band's left and right coordinates }
    ColorBand.Left  := R.Left+ MulDiv (I    , R.Right-R.Left, FNumColors);
    ColorBand.Right := R.Left+ MulDiv (I + 1, R.Right-R.Left, FNumColors);
    { Calculate the color band's color }
    if FNumColors > 1 then
    begin
      Red   := BeginRGBValue[0] + MulDiv (I, RGBDifference[0], FNumColors - 1);
      Green := BeginRGBValue[1] + MulDiv (I, RGBDifference[1], FNumColors - 1);
      Blue  := BeginRGBValue[2] + MulDiv (I, RGBDifference[2], FNumColors - 1);
    end
    else
    { Set to the Begin Color if set to only one color }
    begin
      Red   := BeginRGBValue[0];
      Green := BeginRGBValue[1];
      Blue  := BeginRGBValue[2];
    end;

    { Create a brush with the appropriate color for this band }
    Brush := CreateSolidBrush(RGB(Red,Green,Blue));
    { Select that brush into the temporary DC. }
    OldBrush := SelectObject(DC, Brush);
    try
      { Fill the rectangle using the selected brush -- PatBlt is faster than FillRect }
      PatBlt(DC, ColorBand.Left, ColorBand.Top, ColorBand.Right-ColorBand.Left, ColorBand.Bottom-ColorBand.Top, PATCOPY);
    finally
      { Clean up the brush }
      SelectObject(DC, OldBrush);
      DeleteObject(Brush);
    end;
  end;  { iterate through the color bands }
end;  { GradientFill }

procedure TMSOfficeCaption.SetAutoFontHeight(F : TFont);
var FTextHeight : longint;
    FSysTextHeight : longint;
    FTextMetrics : TTextMetric;
    FSysTextMetrics : TTextMetric;
    WrkBMP   : TBitmap;     { A Bitmap giving us access to the caption bar canvas }
begin
  {------------------------------------------------------------------------}
  { Create the working bitmap and set its width and height.                }
  {------------------------------------------------------------------------}
  WrkBmp := TBitmap.Create;
  try
    WrkBmp.Width := 10;
    WrkBmp.Height := 10;
    WrkBMP.Canvas.Font.Assign(F);
    GetTextMetrics(WrkBmp.Canvas.Handle, FTextMetrics);
    WrkBMP.Canvas.Font.Assign(FSystemFont);
    GetTextMetrics(WrkBmp.Canvas.Handle, FSysTextMetrics);
    FTextHeight := FTextMetrics.tmHeight - FTextMetrics.tmInternalLeading;
    FSysTextHeight := FSysTextMetrics.tmHeight - FSysTextMetrics.tmInternalLeading;
    F.Height:= F.Height + FTextHeight - FSysTextHeight;
    { test out the new font for accuracy }
    WrkBMP.Canvas.Font.Assign(F);
    GetTextMetrics(WrkBmp.Canvas.Handle, FTextMetrics);
    FTextHeight := FTextMetrics.tmHeight - FTextMetrics.tmInternalLeading;
    If (FTextHeight > FSysTextHeight)
      then F.Height:= F.Height + FTextHeight - FSysTextHeight;
    { this test allows for some fonts that can't be scaled properly - they must show smaller rather than larger }
  finally Wrkbmp.Free;
  end; { try finally }
end;  { SetAutoFontHeight }

procedure TMSOfficeCaption.SetColorLeftActive(C: TColor);
begin
  If FColorLeftActive <> C
  then begin
    FColorLeftActive := C;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;

procedure TMSOfficeCaption.SetColorLeftInActive(C: TColor);
begin
  If FColorLeftInActive <> C
  then begin
    FColorLeftInActive := C;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;

procedure TMSOfficeCaption.SetColorRightActive(C: TColor);
begin
  If FColorRightActive <> C
  then begin
    FColorRightActive := C;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;

procedure TMSOfficeCaption.SetColorRightInActive(C: TColor);
begin
  If FColorRightInActive <> C
  then begin
    FColorRightInActive := C;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;

procedure TMSOfficeCaption.SetEnabled(Val: TGradEnabled);
begin
  If Val <> FEnabled then
  begin
    FEnabled := Val;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;  { SetEnabled }

procedure TMSOfficeCaption.SetJustification(Val: TJustification);
begin
  If Val <> FJustification then
  begin
    FJustification := Val;
    If csDesigning in ComponentState then UpdateCaption;
  end;
end;

procedure TMSOfficeCaption.SetNumColors(Val: integer);
begin
  If ((Val > 0) and (Val <= 256))
  then begin
    If Val <> FNumColors then
    begin
      FNumColors := Val;
      If csDesigning in ComponentState then UpdateCaption;
    end;
    exit;
  end;
  if Val <= 0
  then begin
    If csdesigning in ComponentState then
      MessageDlg('The number of colors must be at least 1', mtError, [mbOK], 0);
    exit;
  end;
  if Val > 256
  then begin
    FNumColors := 256;
    If csDesigning in ComponentState then UpdateCaption;
    If csdesigning in ComponentState then
      MessageDlg('The highest number of gradient colors possible is 256', mtError, [mbOK], 0);
  end;
end;  { SetNumColors }


{$ifdef win32}
function TMSOfficeCaption.Handle_WMSetCursor(var Msg: TWMSetCursor): Boolean;
{returns true if we handled the message }
begin
  { Tell Windows we handled the message }
  Msg.Result := 1;
  { Load and display the correct cursor for the border area being hit }
  case Msg.HitTest of
    HTTOP,
    HTBOTTOM:      SetCursor(LoadCursor(0, MakeIntResource(IDC_SIZENS)));
    HTLEFT,
    HTRIGHT:       SetCursor(LoadCursor(0, MakeIntResource(IDC_SIZEWE)));
    HTTOPRIGHT,
    HTBOTTOMLEFT:  SetCursor(LoadCursor(0, MakeIntResource(IDC_SIZENESW)));
    HTTOPLEFT,
    HTBOTTOMRIGHT: SetCursor(LoadCursor(0, MakeIntResource(IDC_SIZENWSE)));
  else
    { Wasn't anything we cared about, so tell Windows we didn't handle it. }
    Msg.Result := 0;
    inherited;
  end;
  result := (Msg.Result = 1);
end;
{$endif}

procedure Register;
begin
  RegisterComponents('Freeware', [TMSOfficeCaption]);
  RegisterPropertyEditor(TypeInfo(TCompanyText), nil, '', TClassProperty);
end;

{$ifndef win32}
procedure Set_NewStyleControls;
var win32Ver : TOSVersionInfo;
begin
  NewStyleControls := false;  { assumption }
  Win32Ver.dwOSVersionInfoSize := sizeof(TOSVersionInfo);
  If boolean(GetVersionEx(Win32Ver, id_W32GetVersionEx)) then
    NewStyleControls := Win32Ver.dwMajorVersion >= 4;
end;  { Set_NewStyleControls }

initialization
  { set up the Win32 API function access for a 16 bit app on a 32 bit OS }
  @GetVersionEx:=@Call32;
  @W32SystemParametersInfo:=@Call32;
  @W32GetSystemMetrics:=@Call32;
  @CopyImage := @Call32;
  @DrawIconEx := @Call32;
  @DrawFrameControl := @Call32;
  id_W32GetVersionEx:=Declare32('GetVersionEx', 'kernel32', 'p');
  id_W32SystemParametersInfo:=Declare32('SystemParametersInfo', 'user32', 'iipi');
  {Check if everything went well. Call32NTError=false means no errors at all}
  if Call32NTError then begin
    NewStyleControls := false;  { a safe assumption }
    FOS_Bits := os16bit; { one or more 32 bit functions failed - so it's probably a 16bit OS }
  end else begin
    Set_NewStyleControls;
    FOS_Bits := os32bit; { all 32 bit functions worked - so it's definitely a 32bit OS }
  end;
  { Icon routines not available on Win32s - so test separately }
  id_W32GetSystemMetrics:=Declare32('GetSystemMetrics', 'user32', 'i');
  id_W32CopyImage:=Declare32('CopyImage', 'user32', 'iiiii');
  id_W32DrawIconEx:=Declare32('DrawIconEx', 'user32', 'iiiiiiiii');
  id_W32DrawFrameControl:=Declare32('DrawFrameControl', 'user32', 'wpii');
  NewStyleControls := NewStyleControls and not Call32NTError;
{$endif}
end.

