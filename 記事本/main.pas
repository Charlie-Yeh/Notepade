﻿unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    mm1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    X1: TMenuItem;
    mmo1: TMemo;
    openDlg1: TOpenDialog;
    saveDlg1: TSaveDialog;
    fontDlg1: TFontDialog;
    colorDlg1: TColorDialog;
    findDlg1: TFindDialog;
    tmr1: TTimer;
    stat1: TStatusBar;
    N19: TMenuItem;
    N21: TMenuItem;
    E1: TMenuItem;
    N22: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure X1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure findDlg1Find(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
var
  fileName, fileName_temp:string;

{$R *.dfm}

(* ********************** 菜單 ********************** *)

// 當程式執行時給fileName_temp賦初始值
procedure TForm1.FormCreate(Sender: TObject);
begin
  fileName_temp := '';
end;

// 新增文件
procedure TForm1.N2Click(Sender: TObject);
var
  i:Integer;
begin
  if mmo1.Modified then
  begin
    i := MessageBox(Handle, '文件尚未保存, 是否要保存文件?', '提示', MB_YESNO); // Yes 6 No 7
    if i = 6 then
    begin
      if saveDlg1.Execute then
      begin
        fileName := saveDlg1.fileName + '.txt';
        mmo1.Lines.SaveToFile(fileName);
        mmo1.Clear;
      end;
    end
    else
    begin
      mmo1.Clear;
    end;
  end;
end;

// 開啟文件
procedure TForm1.N3Click(Sender: TObject);
var
  i:Integer;
begin
  if mmo1.Modified then
  begin
    i := MessageBox(Handle, '文件尚未保存, 是否要保存文件?', '提示', MB_YESNO); // Yes 6 No 7
    if i = 7 then
    begin
      openDlg1.Filter := '文本文件(*.txt)|*.txt';
      if openDlg1.Execute then
      begin
        fileName := openDlg1.FileName;
        mmo1.Lines.LoadFromFile(fileName);
      end;
    end
    else
    begin
      if saveDlg1.Execute then
      begin
        fileName := saveDlg1.FileName + '.txt';
        mmo1.Lines.SaveToFile(fileName);
      end;
    end;
  end
  else
  begin
    openDlg1.Filter := '文本文件(*.txt)|*.txt';
      if openDlg1.Execute then
      begin
        fileName := openDlg1.FileName;
        mmo1.Lines.LoadFromFile(fileName);
      end;
  end;
end;

// 保存文件
procedure TForm1.N4Click(Sender: TObject);
begin
  if fileName_temp = '' then
  begin
    if saveDlg1.Execute then
    begin
      fileName_temp := saveDlg1.FileName + '.txt';
      mmo1.Lines.SaveToFile(fileName_temp);
    end;
  end
  else
  begin
    mmo1.Lines.SaveToFile(fileName_temp);
  end;
end;

// 另存文件
procedure TForm1.N5Click(Sender: TObject);
begin
  if saveDlg1.Execute then
  begin
    fileName := saveDlg1.fileName + '.txt';
    mmo1.Lines.SaveToFile(fileName);
  end;
end;

// 退出程序
procedure TForm1.X1Click(Sender: TObject);
begin
  Close;
end;

(* ********************** 編輯 ********************** *)

// 撤銷
procedure TForm1.N7Click(Sender: TObject);
begin
  mmo1.Undo;
end;

// 複製
procedure TForm1.N9Click(Sender: TObject);
begin
  mmo1.CopyToClipboard;
end;

// 貼上
procedure TForm1.N10Click(Sender: TObject);
begin
  mmo1.PasteFromClipboard;
end;

// 剪下
procedure TForm1.N11Click(Sender: TObject);
begin
  mmo1.CutToClipboard;
end;

// 刪除
procedure TForm1.N12Click(Sender: TObject);
begin
  mmo1.ClearSelection;
end;

// 全選
procedure TForm1.N14Click(Sender: TObject);
begin
  mmo1.SelectAll;
end;

// 背景
procedure TForm1.B1Click(Sender: TObject);
begin
  if colorDlg1.Execute then
  begin
    // 获取用户选择的颜色
    mmo1.Color := colorDlg1.Color;
  end;
end;

// 插入時間
procedure TForm1.N19Click(Sender: TObject);
begin
  mmo1.SelText := DateTimeToStr(Now());
end;

// 查找
procedure TForm1.E1Click(Sender: TObject);
begin
  findDlg1.FindText := mmo1.SelText;
  findDlg1.Execute;
end;

// 尋找文字函數
procedure TForm1.findDlg1Find(Sender: TObject);
var
  i, numCount, returnPos, numLength:Integer;
begin
  numLength := 0;
  numCount := mmo1.Lines.Count;
  for i := 0 to numCount do
  begin
    returnPos := Pos(findDlg1.FindText, mmo1.Lines[i]);
    if returnPos <> 0 then
    begin
      mmo1.SetFocus; // 激活mmo1
      mmo1.SelStart := numLength + returnPos + 1;
      mmo1.SelLength := Length(findDlg1.FindText);
      Break;
    end
    else
      numLength := numLength + Length(mmo1.Lines[i]);
  end;
end;

(* ********************** 格式 ********************** *)

// 字體
procedure TForm1.N18Click(Sender: TObject);
begin
  if fontDlg1.Execute then
  begin
      mmo1.Font := fontDlg1.Font;
  end;
end;

// 自動換行
procedure TForm1.N22Click(Sender: TObject);
begin
  if mmo1.WordWrap = True then
    mmo1.WordWrap := False
  else
    mmo1.WordWrap := True;
end;

(* ********************** 幫助 ********************** *)

// 關於
procedure TForm1.N17Click(Sender: TObject);
begin
   MessageBoxW(0, '這是逆叶製作的簡易筆記本', '關於', MB_OK);
end;

(* ********************** 計時器 ********************** *)

procedure TForm1.tmr1Timer(Sender: TObject);
var
  numLength:Integer;
begin
  stat1.Panels[1].Text := '一共有' + IntToStr(mmo1.Lines.Count) + '行';
  stat1.Panels[2].Text := '一共有' + IntToStr(Length(mmo1.Text)) + '個字';
  stat1.Panels[3].Text := DateTimeToStr(Now());
end;

end.
