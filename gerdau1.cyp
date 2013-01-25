##PROJECT_GLOBAL_BEGIN
[Programs]
Count=1

[Misc Info]
Author=
Company=
Version=1.0
EditTime=939
CyProVersion=2.6.9

[Protection]
Level=0
Password=
##PROJECT_GLOBAL_END

##PROGRAM_BEGIN_1
#PROJECT_OPTIONS_BEGIN
[Program]
Name=New Program

[VCP]
I2CPriority=5
SendSource=1
SendAlloc=1
ProtectWithPasswd=0
Password=
IORefresh=3
ScanOverrunStopsProgram=1
Com1Mode=1
Com1Baudrate=19200
Com1Data=0
Com2Mode=1
Com2Baudrate=19200
Com2Data=0
HSCMode=0
EthAbusEnable=1
EthModbusEnable=0
WANUrl=
PushEvent=0
PushUrl=
ModbusDelay=20
ModbusDeviceAddress=0
ModbusPLCDataModel=2
ModbusAddress=0
ModbusRegisterCount=1
ModbusCoilsArrayVar=
ModbusRegistersArrayVar=
PLCCoilVars=
PLCRegisterVars=
ModbusCoilAddresses=
ModbusRegisterAddresses=

[Misc Info]
MonitorHistorySpeed=10

[Hardware]
CPUUnit=4
Card1=11
Type1=0
NAD1=23471
VarPrefix1=bio00_
VarAreaTyp1.5.0=
VarAreaTyp1.5.1=

[Net]
PrgDevice00=12103
CurrentNAD=12103

[Monitor01]
VarCount=9
VarName1=le1
VarBase1=1
VarValue1=0
VarColor1=0
VarIndex1=0
VarName2=le2
VarBase2=1
VarValue2=0
VarColor2=0
VarIndex2=1
VarName3=lc2
VarBase3=1
VarValue3=0
VarColor3=0
VarIndex3=2
VarName4=ls2
VarBase4=1
VarValue4=0
VarColor4=0
VarIndex4=3
VarName5=timer1.IN
VarBase5=1
VarValue5=0
VarColor5=0
VarIndex5=4
VarName6=timer1.Q
VarBase6=1
VarValue6=0
VarColor6=0
VarIndex6=5
VarName7=timer2.IN
VarBase7=1
VarValue7=0
VarColor7=0
VarIndex7=6
VarName8=timer2.Q
VarBase8=1
VarValue8=0
VarColor8=0
VarIndex8=7
VarName9=sentidodefinido
VarBase9=1
VarValue9=0
VarColor9=0
VarIndex9=8
#PROJECT_OPTIONS_END

#DMVARSLIST_BEGIN
#DMVARSLIST_END

#MASKS_BEGIN
#MASKS_END

#CODE_BEGIN
// AllocGroupList="User Variables", "I/O Variables", "Constants", "lacos", "variaveisgerais", "timers"
var
  le1: bool; // {AllocGroup="lacos"}
  le2: bool; // {AllocGroup="lacos"}
  lc1: bool; // {AllocGroup="lacos"}
  lc2: bool; // {AllocGroup="lacos"}
  ls1: bool; // {AllocGroup="lacos"}
  ls2: bool; // {AllocGroup="lacos"}
  sentido: bool; // {AllocGroup="variaveisgerais"}
  l_1: bool; // {AllocGroup="lacos"}
  l_2: bool; // {AllocGroup="lacos"}
  l_3: bool; // {AllocGroup="lacos"}
  l_4: bool; // {AllocGroup="lacos"}
  l_5: bool; // {AllocGroup="lacos"}
  l_6: bool; // {AllocGroup="lacos"}
  timer1: timer = ( PT:=0; TYPE:=Pulse; BASE:=1000 ); // {AllocGroup="timers"}
  timer2: timer = ( PT:=0; TYPE:=Pulse; BASE:=1000 ); // {AllocGroup="timers"}
  sentidodefinido: bool; // {AllocGroup="variaveisgerais"}
var_end;

function main:void; language 'Structured Text';
  function Le_Entradas:int; language 'Structured Text';
  begin
    // Programa para ler as entradas do CLP
    
    
    
    l_1 := CYBRO_IX00; // Entrada 0 do Cybro
    l_2 := CYBRO_IX01; // Entrada 1 do Cybro
    l_3 := CYBRO_IX02; // Entrada 2 do Cybro
    l_4 := CYBRO_IX03; // Entrada 3 do Cybro
    l_5 := CYBRO_IX04; // Entrada 4 do Cybro
    l_6 := CYBRO_IX05; // Entrada 5 do Cybro
    
    
  end;
  function detectar_sentido:int; language 'Structured Text';
  begin
    // Programa que vai atualizar a variavel "sentido"  (sentido do trem)
    //------------
    // Se sentido for esquerda para direita variavel recebe true
    //------------
    
    
    if l_1 = true then  // Equerda - Direirta
       sentido := true;
    
    end_if;
    
    if l_6 = true then  // Direita - Esquerda
       sentido := false;
    end_if;
    
    
    sentidodefinido := true;
  end;
  function reinicializa_variaveis_de_laco:int; language 'Structured Text';
  begin
    //
    //
    //
    
    // le1   laço entrada
    // lc1   laço cruzamento
    // ls1   laço saida
    
    
    if sentido = true then
        le1:= l_1;
        le2:= l_2;
        lc1:= l_3;
        lc2:= l_4;
        ls1:= l_5;
        ls2:= L_6;
    
    else
        le1:= l_6;
        le2:= l_5;
        lc1:= l_4;
        lc2:= l_3;
        ls1:= l_2;
        ls2:= l_1;
    
    end_if;
  end;
  function aciona_sinalizacao:int; language 'Structured Text';
  begin
    
    if   CYBRO_QX07 = true then
         // nothing todo
    
    else
        CYBRO_QX07 := true;
    end_if;
  end;
  function inicializa_var:int; language 'Structured Text';
  begin
    le1:=false;
    le2:=false;
    lc1:=false;
    lc2:=false;
    ls1:=false;
    ls2:=false;
  end;
begin
  // programa Gerdal
  inicializa_var();
  Le_Entradas();
  
  // aygagygag
  //-----------
  // if que verifica se tem algum laço ativo (se tem trem ou não )
  //-----------
  
  if  l_1 or l_2 or l_3 or l_4 or l_5 or l_6 or sentidodefinido = true then   //entao tem trem
     CYBRO_QX00 := true;   // tem trem
     CYBRO_QX01 := false;  // n tem trem
      if sentidodefinido = false then
         detectar_sentido();
      end_if;
  
      reinicializa_variaveis_de_laco();
  
  //---------------------------
  // ifs para acionar os temporizadores
  //---------------------------
  
  
      if fp(le2) = true then              // temporizador que vai contar x tempo entre o acionamento do laco2 (le2) e o laco3 (lc1)
         timer1.in := true;
         timer1.pt := 10;          // tempo acionado ate chegar no cuzamento
      end_if;
  
      if fn(lc2) then              // temporizador que vai contar x tempo depois que o trem passar o cruzamento
         timer2.in := true;
         timer2.pt := 10;          // tempo acionado depois q o tem passa pelo lc2
      end_if;
  
  
      if timer1.q or timer2.q or lc1 or lc2= true then
         aciona_sinalizacao();
      else
         CYBRO_QX07 := false;
         sentidodefinido := false;
      end_if;
  
      if fn(ls2) then        // if q vai rezetar a bagaca toda para o estado inicial
         le1 := false;
  
  
      end_if;
  
  
        // zerar vairiaveis CONFIRA!
  
  
  else  // não tem trem
        CYBRO_QX01 := true;
        CYBRO_QX00 := false;
        CYBRO_QX07 := false;
        timer1.in := false;
        timer2.in := false;
  end_if;
  
  
  
  
end;
#CODE_END

#DESCRIPTION_BEGIN
#DESCRIPTION_END

##PROGRAM_END_1

