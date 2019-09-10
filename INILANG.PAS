unit IniLang;

interface

uses Windows, SysUtils, Classes, Forms, stdCtrls, typInfo,
	  extCtrls, iniFiles, Controls;

const
	sep = '*|*';   //separator for multiline messages

var
	CL:TMemIniFile;   //Global variable for current language
   //must be inited in the onShow event of your main form.
   // Synthax : CL:=loadIni(XX);
   //where XX is the const name of the ini file you want to load.
   //You can use either a string or an integer const to load a language file.

//user procs
function loadIni(nom : string) : TMemIniFile;overload;
function misc(VAL, KEY : string) : string;
procedure fillCustomIni;
procedure fillProps(TC : array of TComponent; ini : TMemIniFile);

//utilities
procedure searchStr(var ini:TIniFile);
procedure setProp(comp:TComponent;{const }prop,value:string);
procedure setPropI(comp : TComponent; {const }prop : string; value : Integer);
function getProp(comp:TComponent;prop:string):string;
function HasProperty(comp:TComponent;prop:string):boolean;

implementation

function loadIni(nom : string) : TMemIniFile;
var chemin : string;
begin
     chemin := extractFileDir(application.exeName) + '\' + nom;
     if not fileExists(chemin) then Result := nil Else Result := TMemIniFile.create(chemin);
end;

{Creates the original iniFile 'Custom.ini' and fills it first
with string properties and their values (captions, hints,
items -TRadioGroup and TComboBox-
and lines -TMemo and TRichEdit-  values).
One section for each form in the project.
Then fills a 'Misc' section with strings declared with 'const' or
'resourcestring' keywords (customized messages to inform your users or
properties dynamically renamed in your code).
Call 'fillCustomIni' from the onCreate event of the last created form
in your project.
At this time, ALL FORMS MUST BE IN THE 'AUTOMATICALLY
CREATED FORMS' list of your Project\Options\Forms tab .
Then just run form IDE (F9) and close your project, and it's done !}

procedure fillCustomIni;
var ini                : TIniFile;
    i, j, k, l, m      : integer;
    fiche, cmpt        : TComponent;
    val, comp, nomComp : string;
begin
     ini := TIniFile.create(extractFileDir(application.exeName) + '\' + 'Custom.ini');
     {First search the properties that will be translated}
     for i := 0 to application.ComponentCount - 1 do begin
   	fiche   := application.Components[i];
        nomComp := fiche.Name;
    	if HasProperty(fiche, 'Caption') and not (nomComp = getProp(fiche, 'Caption')) then ini.writeString(nomComp,nomComp + '.Caption', getProp(fiche, 'Caption'));
        for j := 0 to fiche.componentCount - 1 do begin
          cmpt    := fiche.Components[j];
          if (cmpt.tag <> 911) THen Begin
           nomComp := cmpt.name;
           //use a 'out' prefixed name if you want the component won't appear
           //in the list (ie : outLabel6:TLabel) so as the list won't be too big
           if (copy(nomComp, 1, 3) = 'out') then continue;

           if HasProperty(cmpt, 'Caption')
              and not (nomComp = getProp(cmpt, 'Caption'))
              and not (getProp(cmpt, 'Caption') = '-')
              and not (getProp(cmpt, 'Caption') = '') then ini.writeString(fiche.Name,fiche.Name + '.' + nomComp+'.Caption', getProp(cmpt, 'Caption'));
           if HasProperty(cmpt, 'Hint')
              and (getProp(cmpt, 'Hint') <> '') then ini.writeString(fiche.Name,fiche.Name + '.' + nomComp + '.Hint', getProp(cmpt, 'Hint'));
           if HasProperty(cmpt, 'Title')
              and (getProp(cmpt, 'Title') <> '') then ini.writeString(fiche.Name,fiche.Name + '.' + nomComp + '.Title', getProp(cmpt, 'Title'));
           if (cmpt is TCustomMemo) then Begin
              for k := 0 to TCustomMemo(cmpt).Lines.count - 1 do begin
                 val := TCustomMemo(cmpt).Lines[k];
                 if (val = nomComp) then break;
                 comp := nomComp + '.Lines[' + intToStr(k) + ']';
                 ini.writeString(fiche.Name, fiche.Name + '.' + comp,val);
              end;
           End;

           If (cmpt is TRadioGroup) then Begin
              For l := 0 to TRadioGroup(cmpt).Items.Count - 1 do begin
                 val  := TRadioGroup(cmpt).Items[l];
                 comp := nomComp + '.Items[' + IntToStr(l) + ']';
                 ini.writeString(fiche.Name, fiche.Name + '.' + comp,val);
              End;
           End;

           if (cmpt is TComboBox) then Begin
              for m:=0 to TComboBox(cmpt).Items.Count-1 do begin
                 val:=TComboBox(cmpt).Items[m];
                 comp:=nomComp+'.Items['+IntToStr(m)+']';
                ini.writeString(fiche.Name,fiche.Name+'.'+comp,val);
              End;
           End;

           if (cmpt is TListBox) then Begin
              for m:=0 to TListBox(cmpt).Items.Count-1 do begin
                 val:=TListBox(cmpt).Items[m];
                 comp:=nomComp+'.Items['+IntToStr(m)+']';
                ini.writeString(fiche.Name,fiche.Name+'.'+comp,val);
              End;
           End;

          End;
        end;
     End;
   {search for error or information messages stored as const or resourcestring - see below}
     searchStr(ini);
     ini.free;
end;

{Translates the form you choose in the language called in ini.
Only created forms are translated with fillProps. Call it in the onShow
event of your main form whith names of all automatically created forms
at the start-up of your application in the TC parameter.
In runtime, call it when you create dynamically a form. For example :
procedure TForm1.Button3Click(Sender: TObject);
begin
	if form2=nil then form2:=TForm2.create(application);
        if CL<>nil then fillProps([form2],CL);
        form2.show;
end;}
procedure fillProps(TC : array of TComponent; ini : TMemIniFile);
var i, i2, i3, i4, tab    : integer;
    comp, fiche           : TComponent;
    s, s1, s2, s3, s4, s5, sx : string;
begin
     with ini do Begin
        for tab := 0 to high(TC) do begin
           fiche:=TC[tab];
   	   if (fiche = nil) then continue;
           s := readString(fiche.name, fiche.name + '.Caption', '');
           if (s <> '') then TForm(fiche).caption := s;
           for i := 0 to fiche.componentCount - 1 do begin
             comp := fiche.Components[i];
             if (comp.tag <> 911) Then Begin

              sx := readString(fiche.name, fiche.name + '.' + comp.name + '.Font', '');
              if (sx <> '') then setPropI(comp, 'Font.Charset', OEM_CHARSET);

              s1 := readString(fiche.name, fiche.name + '.' + comp.name + '.Caption', '');
              if (s1 <> '') then setProp(comp, 'Caption', s1);

              s2 := readString(fiche.name,fiche.name + '.' + comp.name + '.Hint', '');
              if (s2 <> '') then setProp(comp, 'Hint', s2);

              s2 := readString(fiche.name,fiche.name + '.' + comp.name + '.Title', '');
              if (s2 <> '') then setProp(comp, 'Title', s2);

              if comp is TCustomMemo then Begin
                 for i2 := 0 to TCustomMemo(comp).lines.count - 1 do begin
                    s3 := readString(fiche.name, fiche.name + '.' + comp.name + '.lines[' + intToStr(i2) + ']', 'fsdef');
                    //in TMemo or TRichEdit, you may have to leave some lines empty
                    if (s3 <> 'fsdef') then TCustomMemo(comp).lines[i2] := s3;
                 End;
              End;


              if comp is TRadioGroup then Begin
                 For i3 := 0 to TRadioGroup(comp).items.count-1 do begin
                    s4 := readString(fiche.name, fiche.name + '.' + comp.name + '.items[' + intToStr(i3) + ']', '');
                    if (s4 <> '') then TRadioGroup(comp).items[i3] := s4;
                 End;
              End;

              if comp is TComboBox then Begin
                 for i4 := 0 to TComboBox(comp).items.count - 1 do begin
                    s5 := readString(fiche.name, fiche.name + '.' + comp.name + '.items[' + IntToStr(i4) + ']', '');
                    if (s5 <> '') then TComboBox(comp).items[i4] := s5;
                 End;
              End;

              if comp is TListBox then Begin
                 for i4 := 0 to TListBox(comp).items.count - 1 do begin
                    s5 := readString(fiche.name, fiche.name + '.' + comp.name + '.items[' + IntToStr(i4) + ']', '');
                    if (s5 <> '') then TListBox(comp).items[i4] := s5;
                 End;
              End;

             End;
           End;
        End;
     End;
end;

{Translates a miscellaneous message in the current language.
The VAL parameter is the identification name of your string in a const or
resourcestring section in any file of your project.
The KEY parameter is the keyname of your string in the 'Misc' ini file section.
VAL value is used if no ini language file is present or loaded
ie it's your design-time language).
KEY is used otherwise to display the message in the current ini language.
Synthax : showMessage(misc(Msg21,'Msg21'));
This function uses the separator *|* to restore multiline messages}

function misc(VAL, KEY : string) : string;
var res, tempRes : string;
    TS           : array of string;
    x            : integer;
begin
     if (CL = nil) then begin
        result := VAL;
        exit;
     end;

     res := CL.readString('Misc', KEY, '');
     if (pos(sep,res) = 0) then result := res else begin
        setLength(TS, 15);  //increase this value if necessary for you
        x :=low(TS);
        tempRes := '';
        repeat
           TS[x] := copy(res, 1, pos(sep, res) - 1);
           if (tempRes = '') then tempRes := TS[x] else tempRes := tempRes + #13#10 + TS[x];
           res := copy(res, pos(sep,res) + 3, length(res));
        until (pos(sep, res) = 0);
        TS := nil;
        tempRes := tempRes + #13#10 + res;
        result := tempRes;
     End;
end;

{Your text strings must be stored in 'const' or 'resourcestring' sections
in your source files to be found by this procedure and saved in the ini file.
Prepare a little bit your code to make the job easier. For instance don't
write : 'if edit1.text='' then'
but : 'if edit.text= '' then' (with a space between = and the first ')
Strings with CR/LF (#13#10) will be saved in a unique key value, the different
lines of the message being separated by a *|* sequence}

procedure searchStr(var ini : TIniFile);
var rep                      : string;
    sr                       : TSearchRec;
    F                        : TextFile;
    line, ligne, temp, tempL : string;
    strList                  : TStringList;
    x, y                     : integer;
begin
     rep := extractFileDir(application.exeName) + '\';
     strList := TStringList.create;

     {Search string resources in pas files}
     if (findFirst(rep + 'ulocstrings.pas', faAnyFile, sr) = 0) then Begin
        repeat
           if (sr.name = 'IniLang.pas') then findNext(sr);
           assignFile(F, rep + sr.name);

           reset(F);
           while not eof(F) do begin
              readln(F, line);
              line := trim(line);
              //look for string resources ie =' sequences
              if pos('=''', line) > 0 then strList.add(line);
              //look if the line is a part of a multiline message
              //ie ' (single quote), + or # at the beginning of the line.
              //add what you want if I forgot something you need for.
              //put a {} sequence at the beginning of a line you don't
              //want to be added in the file.
              if (pos('''', line) = 1) or (pos('+', line) = 1) or (pos('#', line) = 1) then strList.add('bis' + line); //'bis'-->temporary prefix for
           end; //multiline strings
           closeFile(F);
        until (findNext(sr) <> 0);
     End;
     findClose(sr);

     //copy multiline messages on a unique key value
     for x := strList.count - 1 downto 0 do Begin
        if (pos('bis', strList[x]) = 1) then begin
           tempL := strList[x];
           tempL := strList[x - 1] + copy(tempL, 4, length(tempL));
           strList[x - 1] := tempL;
           strList.delete(x);
           continue;
        end;
     End;

     {Deletes useless caracters in ini string format --> ; ' ''
     Also separates multilines messages with the *|* separator}
     for x := 0 to strList.count - 1 do begin
        ligne := strList[x];
        delete(ligne, length(ligne) - 1, 2);
        delete(ligne, pos('=', ligne) + 1, 1);
        if (pos('''''', ligne) > 0) then Begin
           repeat
              delete(ligne,pos('''''', ligne), 1);
           until (pos('''''', ligne) = 0);
        End;
        strList[x] := ligne;
        temp       := strList.values[strList.names[x]];
        if (pos(''' + ', temp) = 0) then ini.writeString('Misc', strList.names[x], temp) else begin
           repeat
              y := pos(''' + ', temp);
              repeat
                 delete(temp, y, 1);
              until (temp[y] = '''');
              temp := copy(temp, 1, y - 1) + sep + copy(temp, y + 1, length(temp));
           until (pos(''' + ', temp) = 0);
        End;
        ini.writeString('Misc', strList.names[x], temp);
     end;
     strList.free;
end;

//Backs up the prop property value of the comp component
function getProp(comp : TComponent; prop : string) : string;
var ppi : PPropInfo;
begin
     ppi := getPropInfo(comp.classInfo, prop);
     if (ppi <> nil) then result := getStrProp(comp, ppi) else result := '';
end;

//Assign the value value to prop property of comp component
procedure setProp(comp : TComponent; {const }prop, value : string);
var ppi : PPropInfo;
begin
     if (value <> '') then begin
        ppi := getPropInfo(comp.classInfo, prop);
        if (ppi <> nil) then setStrProp(comp, ppi, value);
     end;
end;

procedure setPropI(comp : TComponent; {const }prop : string; value : Integer);
var ppi : PPropInfo;
begin
     ppi := getPropInfo(comp.classInfo, prop);
     if (ppi <> nil) then setInt64Prop(comp, ppi, value);
end;

//True if prop property exists for comp component
function HasProperty(comp : TComponent; prop : string):boolean;
begin
     result := (getPropInfo(comp.classInfo, prop) <> nil) and (comp.name <> '');
end;

end.
