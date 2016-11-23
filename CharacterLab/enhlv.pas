unit enhlv;
{  PURPOSE : Add tooltips to listview for truncated column text - Delphi 2/3/4/5
   Freeware copyright Greg Lorriman 1999 greg@lorriman.demon.co.uk
   http://www.lorriman.demon.co.uk
   USAGE :
      Properties -> ToolTipOptions(set),ToolTipWidth(integer),ShowToolTips(boolean)
      Events -> OnToolTip (can change tip text here)
   NOTES : Functionality requires update to Comctrl32.dll (IE4+)
      ToolTipWidth<>-1 results in multi-line tip otherwise no width limit.
      vsIcon view has a fixed tip width : ToolTipWidth has no effect.
      Force multi-line with #13#10 combination (ToolTipWidth>-1)
      ttoLongStay=32 seconds is a win32 limit.
      ToolTipText paremeter of event only has text when text in
         column is truncated.
      Use event for user defined text. For safety: test for assigned(item).
      Use event for different behaviour between columns or items.

   See http://msdn.microsoft.com/library/sdkdoc/shellcc/CommCtls/ListView/Using.htm
   and http://msdn.microsoft.com/library/sdkdoc/shellcc/CommCtls/ToolTip/ToolTip.htm
   for implementation info. Remember to "sync toc".

   Disclaimer in readme.txt or contact Greg for text of disclaimer
}

interface

uses comctrls,messages,classes,commctrl,sysutils;

{$IFDEF VER90}
   {$DEFINE GL_D2}
{$ENDIF}

{$IFDEF VER100}
  {$DEFINE GL_D3}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE GL_D3}
  {$DEFINE GL_D4}
{$ENDIF}

type

TEnumToolTipOptions=(ttoInstantShow,ttoLongStay,ttoBelowItem,ttoOffSet);
TTooltipOptions=set of TEnumToolTipOptions;
{$IFDEF GL_D2}
TOnToolTip=procedure(sender : Tobject; var toolTipText : string; item : TListItem; logicalCol : integer)of object;
{$ELSE}
TOnToolTip=procedure(sender : Tobject; var toolTipText : widestring; item : TListItem; logicalCol : integer)of object;
{$ENDIF}
THintListView=class(TListview)
  private
   FToolTipOptions: TToolTipOptions;
  {$IFDEF GL_D2}
   FToolTipText : string;
   {$ELSE}
   FToolTipText : widestring;
   {$ENDIF}
   FToolTipwidth : integer;
   FOnToolTip: TOnToolTip;
   FmouseX : integer;
   FMouseY : integer;
   //FHelp : TStrings;
   //procedure SetVersion(const Value: string);
   //function GetVersion: string;
   //function getOtherstuff: string;
   //procedure setOtherStuff(const Value: string);
   //procedure setHelp(const Value: TStrings);
  protected
   procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
   procedure WndProc(var Message: TMessage);override;
   function getToolTipWidth: integer;virtual;
   procedure setToolTipWidth(const Value: integer);virtual;
   function GetToolTips: boolean;virtual;
   procedure SetToolTipOptions(const Value: TToolTipOptions);virtual;
   procedure SetToolTips(const Value: boolean);virtual;
   {$IFDEF GL_D2}
   procedure doOnToolTip(var toolTipText : string; item : TListItem; logicalCol : integer);virtual;
   {$ELSE}
   procedure doOnToolTip(var toolTipText : widestring; item : TListItem; logicalCol : integer);virtual;
   {$ENDIF}
  public
   constructor create(AOwner : Tcomponent);override;
   destructor destroy;override;
  published
   property ShowToolTips : boolean read GetToolTips write SetToolTips;
   property ToolTipOptions : TToolTipOptions read FToolTipOptions write SetToolTipOptions;
   property ToolTipWidth : integer read getToolTipWidth write setToolTipWidth;
   //property Version : string read GetVersion write SetVersion stored false;
   //property OtherStuff : string read getOtherstuff write setOtherStuff stored false;
   //property Help : TStrings  read FHelp write setHelp stored False;
   property OnToolTip : TOnToolTip read FOnToolTip write FOnToolTip;
end;

procedure Register;

implementation

uses windows,controls;

const

   LVM_FIRST                     = $1000;
   LVM_SETEXTENDEDLISTVIEWSTYLE  = LVM_FIRST + 54;
   LVM_GETEXTENDEDLISTVIEWSTYLE  = LVM_FIRST + 55;
   LVS_EX_INFOTIP                = $00000400;
   LVM_GETTOOLTIPS               = LVM_FIRST + 78;
   TTM_SETDELAYTIME              = WM_USER + 3;
   TTDT_AUTOMATIC                = 0;
   TTDT_AUTOPOP                  = 2;
   TTM_SETMAXTIPWIDTH            = WM_USER + 24;
   TTN_FIRST                     = 0-520;
   TTN_NEEDTEXTW                 = TTN_FIRST - 10;
   TTN_GETDISPINFOW              = TTN_NEEDTEXTW;
   TTM_GETMAXTIPWIDTH            = WM_USER + 25;
   LVN_GETINFOTIPW               = LVN_FIRST-58;
   LVM_SUBITEMHITTEST            = LVM_FIRST + 57;
   LVM_GETITEMRECT               = LVM_FIRST + 14;

type
  tagNMTTDISPINFOW = packed record
    hdr: TNMHdr;
    lpszText: PWideChar;
    szText: array[0..79] of WideChar;
    hinst: HINST;
    uFlags: UINT;
    lParam: LPARAM;
  end;
  PNMTTDispInfoW = ^TNMTTDispInfoW;
  TNMTTDispInfoW = tagNMTTDISPINFOW;

type
  tagLVHITTESTINFO = packed record
    pt: TPoint;
    flags: UINT;
    iItem: Integer;
    iSubItem: Integer;
  end;
  TLVHitTestInfo = tagLVHITTESTINFO;

{ THintListView }

constructor THintListView.create(AOwner: Tcomponent);
const helptext : string= 'PURPOSE : Add tooltips to listview for truncated column text'#13#10+
                     'Freeware copyright Greg Lorriman 1999 greg@lorriman.demon.co.uk'#13#10+
                     'http://www.lorriman.demon.co.uk'#13#10+
                     'USAGE :'#13#10#09+
                     'Properties -> ToolTipOptions,ToolTipWidth,ShowToolTips'#13#10#09+
                     'Events -> OnToolTip'#13#10+
                     'NOTES : Functionality requires update to Comctrl32.dll (IE4+).'#13#10+
                     'ToolTipWidth<>-1 results in multi-line tip.'#13#10+
                     'Force multi-line with #13#10 combination (ToolTipWidth>-1)'#13#10+
                     'ToolTips are off by default.'#13#10+
                     'ttoLongStay=32 seconds is an win32 limit.'#13#10+
                     'vsIcon view has a fixed tip width : ToolTipWidth has no effect.'#13#10+
                     'ToolTipText parameter of event only has text when text in'#13#10#9+
                     'column is truncated.'#13#10+
                     'Use event for user defined text. For safety: test for assigned(item).'#13#10+
                     'Use event for different behaviour between columns or items.'#13#10#13#10+
                     'SCROLL TO TOP FOR START OF HELP';
begin
   inherited create(AOwner);
   FToolTipWidth:=-1;
   //FHelp:=TStringlist.create;
   //FHelp.text:=helptext;
end;


destructor THintListView.destroy;
begin
   //FHelp.free;
   inherited destroy;
end;

{$IFDEF GL_D2}
procedure THintListView.doOnToolTip(var toolTipText: string;
  item: TListItem; logicalCol: integer);
begin
   if assigned(FonToolTip) then
      FonToolTip(self,toolTipText,item,logicalCol);
end;
{$ELSE}
procedure THintListView.doOnToolTip(var toolTipText: widestring;
  item: TListItem; logicalCol: integer);
begin
   if assigned(FonToolTip) then
      FonToolTip(self,toolTipText,item,logicalCol);
end;
{$ENDIF}


//function THintListView.getOtherstuff: string;
//begin  result:='http://www.lorriman.demon.co.uk' end;

function THintListView.GetToolTips: boolean;
begin
   result:=(sendmessage(handle,LVM_GETEXTENDEDLISTVIEWSTYLE,0,0) and LVS_EX_INFOTIP)>0;
end;

function THintListView.getToolTipWidth: integer;
begin
   result:=FTooltipwidth
end;

//function THintListView.GetVersion: string;
//begin result:='.4 beta' end;

procedure THintListView.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
   FMouseX:=x;
   FMouseY:=y;
   inherited mousemove(shift,x,y);
end;

//procedure THintListView.setHelp(const Value: TStrings);
//begin
//end;
//procedure THintListView.setOtherStuff(const Value: string);
//begin end;

procedure THintListView.SetToolTipOptions(const Value: TToolTipOptions);
var
   ttHandle : HWND;
   auto,autoPop : longint;
   val : TToolTipOptions;
begin
   val:=value;
  if (ttoOffset in val) and not (ttoOffset in FToolTipOptions) then
   val:=val-[ttoBelowItem];
  if (ttoBelowItem in val) and not (ttoBelowItem in FToolTipOptions) then
   val:=val-[ttoOffset];
  FToolTipOptions := Val;
  if ttoInstantShow in FToolTipOptions then auto:=1 else auto:=500;
  if ttoLongStay in FToolTipOptions then autoPop:=32000 else autoPop:=3000;
  ttHandle:=sendmessage(handle,LVM_GETTOOLTIPS,0,0);
  sendmessage(ttHandle,TTM_SETDELAYTIME,TTDT_AUTOMATIC,auto);
  sendmessage(ttHandle,TTM_SETDELAYTIME,TTDT_AUTOPOP,autopop);
end;

procedure THintListView.SetToolTips(const Value: boolean);
var
   data : longint;
begin
  if value then data:=LVS_EX_INFOTIP else data:=0;
  sendmessage(handle,LVM_SETEXTENDEDLISTVIEWSTYLE,LVS_EX_INFOTIP,data)
end;

procedure THintListView.setToolTipWidth(const Value: integer);
begin
   FTooltipWidth:=value;
end;

//procedure THintListView.SetVersion(const Value: string);
//begin end;

procedure THintListView.WndProc(var Message: TMessage);
var
   fHwnd : HWND;
   winplace : TWindowPlacement;
   hittest : TLVHitTestInfo;
   x,y : integer;
   item : TListItem;
   itemBound : TRect;
   cursorpos : TPoint;
begin
   inherited wndproc(message);
   if (message.msg=WM_NOTIFY) then begin
      fHwnd:=PNMHdr(message.lparam)^.hwndFrom;
      case PNMHdr(message.lparam)^.code of
         TTN_GETDISPINFOW : begin
            SetToolTipOptions(FToolTipOptions);//in case of dynamic creation
            SendMessage(fHwnd, TTM_SETMAXTIPWIDTH, 0, FToolTipwidth);
            if assigned(FOnToolTip) then begin
               hittest.pt.x:=FMouseX+2;
               hittest.pt.y:=FMouseY;
               hittest.iItem:=-1;//in case of unsupported hittest message
               hittest.iSubitem:=-1;
               sendmessage(handle,LVM_SUBITEMHITTEST,0,integer(@hittest));
               if hittest.iItem>=0 then begin
                  item:=items[hittest.iItem];
                  {$IFDEF GL_D2}
                  if PNMTTDispInfoW(message.lparam)^.lpszText<>nil then
                     FToolTipText:=widechartostring(PNMTTDispInfoW(message.lparam)^.lpszText)
                  else
                     FToolTipText:='';
                  doOnToolTip(FTooltipText,item,hittest.iSubItem);
                  getmem(PNMTTDispInfoW(message.lparam)^.lpszText,sizeof(widechar)*length(FToolTipText)+2);
                  stringToWideChar(FToolTipText,PNMTTDispInfoW(message.lparam)^.lpszText,length(FToolTipText)*2);
                  {$ELSE}
                  FToolTipText:=widestring(PNMTTDispInfoW(message.lparam)^.lpszText);
                  doOnToolTip(FTooltipText,item,hittest.iSubItem);
                  PNMTTDispInfoW(message.lparam)^.lpszText:=pwidechar(FToolTipText);
                  {$ENDIF}
               end;
            end;
         end;
         TTN_SHOW : begin
            SetToolTipOptions(FToolTipOptions);//in case of dynamic creation
            winplace.length:=sizeof(winplace);
            getwindowplacement(fHwnd,@winplace);
            hittest.pt.x:=FMouseX+2;
            hittest.pt.y:=FMouseY;
            hittest.iItem:=-1;//in case of unsupported hittest message
            hittest.iSubitem:=-1;
            sendmessage(handle,LVM_SUBITEMHITTEST,0,integer(@hittest));
            if hittest.iItem>=0 then begin
               itemBound.left:=LVIR_LABEL;
               sendmessage(handle,LVM_GETITEMRECT,hittest.iItem,integer(@itemBound));
               y:=winplace.rcNormalPosition.top;
               x:=winplace.rcNormalPosition.left;
               if ttoOffset in FToolTipOptions then begin
                  getcursorpos(cursorpos);
                  x:=cursorpos.x+20;
                  y:=cursorpos.y+((itemBound.bottom-itembound.top) div 2);
               end else
               if ttoBelowItem in FToolTipOptions then
                  inc(y,itemBound.bottom-itembound.top);
               setwindowpos(fHwnd,HWND_TOPMOST,x,y,0,0,SWP_NOSIZE or SWP_NOACTIVATE);
            end;
         end;
      end;
   end;
end;


procedure Register;
begin
  RegisterComponents('Tag', [THintListView]);
end;

end.

