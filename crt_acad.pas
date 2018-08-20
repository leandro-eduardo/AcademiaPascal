unit crt_acad;

interface

function achou(a:integer):integer;
function achounome(a:string):integer;
procedure Abrir;
procedure Cadastro;
procedure Alterar;
procedure Excluir;
procedure Pesquisa_nome;
procedure Pesquisa_cod;
procedure Relatorio;

implementation

Type academia=record
  cod, idade:integer;
  nome, status, sexo:string;
End;

Var  ArqAcad:file of academia;
Aluno:academia;
c, i:integer;
opcao1:char;

procedure Abrir;
Begin
  Assign (ArqAcad, 'academia.txt');
  {$I-}
  Reset(ArqAcad);
  {$I+}
  If ( IOResult <> 0) then
  Rewrite(ArqAcad);
End;

function achou(a:integer):integer;

var indicebusca:integer;
AlunoTemp:academia;

begin
  Seek (ArqAcad, 0);
  indicebusca:=-1;
  while (not eof(ArqAcad)) do
  begin
    read (ArqAcad, AlunoTemp);
    if (a=AlunoTemp.cod) then
    begin
      indicebusca:=filepos(ArqAcad)-1;
      Seek (ArqAcad, filesize(ArqAcad));
    end;
  end;
  achou:=indicebusca;
End;

function achounome(a:string):integer;

var indicebusca1:integer;

begin
  Seek (ArqAcad, 0);
  indicebusca1:=-1;
  while (not eof(ArqAcad)) do
  begin
    read (ArqAcad, Aluno);
    if (a=Aluno.nome) then
    begin
      indicebusca1:=filepos(ArqAcad)-1;
      Seek (ArqAcad, filesize(ArqAcad));
    end;
  end;
  achounome:=indicebusca1;
End;

procedure Cadastro;

var cod, cont:integer;
    nome:string;

Begin
  REPEAT
    clrscr;
    Seek (ArqAcad, filesize(ArqAcad));
    writeln ('>> Cadastro do Aluno <<');
    writeln;
    cont:=filesize(ArqAcad);
    writeln ('Código: ',cont);
    write ('Nome: ');
    readln (nome);
    while achounome(nome)<>-1 do
    begin
       textcolor(4);
       writeln ('Nome já cadastrado. Informe novamente.');
       textcolor(15);
       writeln;
       write ('Nome: ');
       readln (nome);
    end;
    Aluno.nome:=nome;
    Aluno.cod:=cont;
    write ('Idade: ');
    readln (Aluno.idade);
    while (Aluno.idade<0) or (Aluno.idade>150) do
    begin
      textcolor(4);
      writeln ('Idade inválida. Informe novamente.');
      textcolor(15);
      writeln;
      write ('Idade: ');
      readln (Aluno.idade);
    end;
    write ('Sexo (M/F): ');
    readln (Aluno.sexo);
    while (Aluno.sexo<>'M') and (Aluno.sexo<>'m') and (Aluno.sexo<>'F') and (Aluno.sexo<>'f') do
    begin
      textcolor(4);
      writeln ('Sexo inválido. Informe novamente.');
      textcolor(15);
      writeln;
      write ('Sexo (M/F): ');
      readln (Aluno.sexo);
    end;
    Aluno.status:='Ativo';
    write (ArqAcad, Aluno);
    textcolor(2);
    writeln;
    writeln ('Aluno cadastrado com sucesso!');
    textcolor(15);
    writeln;
    writeln ('>> Deseja realizar outro cadastro? S/N <<');
    readln (opcao1);
  UNTIL (opcao1='N') or (opcao1='n');
End;

procedure Alterar;

var codaluno, guardaidade:integer;
guardanome, guardasexo, guardastatus:string;
campoAlterar:char;

Begin
  REPEAT
    clrscr;
    write ('Informe o código do Aluno a ser alterado: ');
    readln (codaluno);
    i:=achou(codaluno);
    if i<>-1 then
    begin
      writeln;
      textcolor(2);
      writeln ('Busca realizada com sucesso!');
      textcolor(15);
      writeln;
      Seek (ArqAcad, i);
      read (ArqAcad, Aluno);
      writeln ('Código: ',Aluno.cod);
      writeln ('Nome: ',Aluno.nome);
      writeln ('Idade: ',Aluno.idade);
      if (Aluno.sexo='M') or (Aluno.sexo='m') then
      begin
        writeln ('Sexo: Masculino');
      end;
      if (Aluno.sexo='F') or (Aluno.sexo='f') then
      begin
        writeln ('Sexo: Feminino');
      end;
      if (Aluno.status='Ativo') or (Aluno.status='ativo') then
      begin
        Aluno.status:='Ativo';
        textcolor(2);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      if (Aluno.status='Inativo') or (Aluno.status='inativo') then
      begin
        Aluno.status:='Inativo';
        textcolor(4);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      guardanome:=Aluno.nome;
      guardaidade:=Aluno.idade;
      guardasexo:=Aluno.sexo;
      guardastatus:=Aluno.status;
      writeln;
    end;
    if achou(codaluno)=-1 then
    begin
      writeln;
      textcolor(4);
      writeln ('Aluno não cadastrado.');
      textcolor(15);
      writeln;
      writeln ('Pressione alguma tecla para voltar ao MENU.');
      readkey;
      break;
    end;
    REPEAT
      gotoxy (1, 11);
      writeln ('>> Dados a serem alterados <<');
      writeln;
      writeln ('1. Nome');
      writeln ('2. Idade');
      writeln ('3. Sexo');
      writeln ('4. Salvar e sair');
      writeln ('5. Sair sem salvar');
      writeln;
      writeln ('Qual a opção desejada?');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      writeln ('                                     ');
      gotoxy(1, 21);
      readln (campoAlterar);
      case campoAlterar of
        '1':
        begin
          writeln;
          write ('Novo nome: ');
          readln (Aluno.nome);
          gotoxy (1, 6);
          write ('Nome: ', Aluno.nome, '                        ');
        end;
        '2':
        begin
          writeln;
          write ('Nova idade: ');
          readln (Aluno.idade);
          while (Aluno.idade<0) or (Aluno.idade>150) do
          begin
            textcolor(4);
            writeln ('Idade inválida. Informe novamente.');
            textcolor(15);
            writeln;
            write ('Nova idade: ');
            readln (Aluno.idade);
          end;
          gotoxy (1, 7);
          writeln ('Idade: ',Aluno.idade, '                        ');
        end;
        '3':
        begin
          writeln;
          write ('Novo sexo(M/F): ');
          readln (Aluno.sexo);
          while (Aluno.sexo<>'M') and (Aluno.sexo<>'m') and (Aluno.sexo<>'F') and (Aluno.sexo<>'f') do
          begin
            textcolor(4);
            writeln ('Sexo inválido. Informe novamente.');
            textcolor(15);
            writeln;
            write ('Novo sexo (M/F): ');
            readln (Aluno.sexo);
          end;
          if (Aluno.sexo='M') or (Aluno.sexo='m') then
          begin
            gotoxy (1, 8);
            writeln ('Sexo: Masculino    ');
          end;
          if (Aluno.sexo='F') or (Aluno.sexo='f') then
          begin
            gotoxy (1, 8);
            writeln ('Sexo: Feminino     ');
          end;
        end;
        '4':
        begin
          Seek (ArqAcad, i);
          write (ArqAcad, Aluno);
        end;
        '5':
        begin
          gotoxy (1, 6);
          writeln ('Nome: ',guardanome,'                          ');
          gotoxy (1, 7);
          writeln ('Idade: ',guardaidade,'                        ');
          gotoxy (1, 8);
          if (guardasexo='M') or (guardasexo='m') then
          begin
             writeln ('Sexo: Masculino               ');
          end;
          if (guardasexo='F') or (guardasexo='f') then
          begin
             writeln ('Sexo: Feminino               ');
          end;
          gotoxy (1, 9);
          if (guardastatus='Ativo') or (guardastatus='ativo') then
          begin
            guardastatus:='Ativo';
            textcolor(2);
            writeln ('Status: ',guardastatus);
            textcolor(15);
          end;
          if (guardastatus='Inativo') or (guardastatus='inativo') then
          begin
            guardastatus:='Inativo';
            textcolor(4);
            writeln ('Status: ',guardastatus);
            textcolor(15);
          end;
        end;
      end;
    UNTIL (campoAlterar='4') or (campoAlterar='5');
    gotoxy (1, 22);
    writeln;
    writeln ('>> Deseja realizar outra alteração? S/N <<');
    writeln;
    readln (opcao1);
  UNTIL (opcao1='N') or (opcao1='n');
End;

procedure Excluir;

var codaluno:integer;

Begin
  REPEAT
    clrscr;
    write ('Informe o código do Aluno a ser ativado/inativado: ');
    readln (codaluno);
    i:=achou(codaluno);
    if i<>-1 then
    begin
      writeln;
      textcolor(2);
      writeln ('Busca realizada com sucesso!');
      textcolor(15);
      writeln;
      Seek (ArqAcad, i);
      read (ArqAcad, Aluno);
      writeln ('Código: ',Aluno.cod);
      writeln ('Nome: ',Aluno.nome);
      writeln ('Idade: ',Aluno.idade);
      if (Aluno.sexo='M') or (Aluno.sexo='m') then
      begin
        Aluno.sexo:='Masculino';
        writeln ('Sexo: ',Aluno.sexo);
        Aluno.sexo:='M';
      end;
      if (Aluno.sexo='F') or (Aluno.sexo='f') then
      begin
        Aluno.sexo:='Feminino';
        writeln ('Sexo: ',Aluno.sexo);
        Aluno.sexo:='F';
      end;
      if (Aluno.status='Ativo') or (Aluno.status='ativo') then
      begin
        Aluno.status:='Ativo';
        textcolor(2);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      if (Aluno.status='Inativo') or (Aluno.status='inativo') then
      begin
        Aluno.status:='Inativo';
        textcolor(4);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      writeln;
    end;
    if achou(codaluno)=-1 then
    begin
      writeln;
      textcolor(4);
      writeln ('Aluno não cadastrado.');
      textcolor(15);
      writeln;
      writeln ('Pressione alguma tecla para voltar ao MENU.');
      readkey;
      break;
    end;
    writeln ('>> Ativar/inativar cadastro <<');
    writeln;
    writeln ('Informe Ativo ou Inativo.');
    writeln;
    write ('Status: ');
    readln (Aluno.status);
    while (Aluno.status<>'Ativo') and (Aluno.status<>'ativo') and (Aluno.status<>'Inativo') and (Aluno.status<>'inativo') do
    begin
      textcolor(4);
      writeln ('Status inválido.');
      textcolor(15);
      writeln;
      write ('Status: ');
      readln (Aluno.status);
      writeln;
    end;
    if (Aluno.status='Ativo') or (Aluno.status='ativo') then
    begin
      Aluno.status:='Ativo';
      gotoxy (1, 9);
      textcolor(2);
      write ('Status: ', Aluno.status, '                        ');
      textcolor(15);
    end;
    if (Aluno.status='Inativo') or (Aluno.status='inativo') then
    begin
      Aluno.status:='Inativo';
      gotoxy (1, 9);
      textcolor(4);
      write ('Status: ', Aluno.status, '                        ');
      textcolor(15);
    end;
    Seek (ArqAcad, i);
    write (ArqAcad, Aluno);
    writeln;
    gotoxy (1, 13);
    textcolor(2);
    writeln ('Status alterado com sucesso!');
    textcolor(15);
    gotoxy (1, 15);
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln ('                                       ');
    writeln;
    gotoxy (1, 15);
    writeln ('>> Deseja realizar outra alteração? S/N <<');
    writeln;
    readln (opcao1);
  UNTIL (opcao1='N') or (opcao1='n');
End;

procedure Pesquisa_nome;

var nomealuno:string;

begin
  REPEAT
    clrscr;
    write ('Informe o nome do Aluno a ser consultado: ');
    readln (nomealuno);
    i:=achounome(nomealuno);
    begin
      if i<>-1 then
      begin
        writeln;
        textcolor(2);
        writeln ('Busca realizada com sucesso!');
        textcolor(15);
        writeln;
        Seek (ArqAcad, i);
        read (ArqAcad, Aluno);
        writeln ('Código: ',Aluno.cod);
        writeln ('Nome: ',Aluno.nome);
        writeln ('Idade: ',Aluno.idade);
        if (Aluno.sexo='M') or (Aluno.sexo='m') then
        begin
          Aluno.sexo:='Masculino';
          writeln ('Sexo: ',Aluno.sexo);
          Aluno.sexo:='M';
        end;
        if (Aluno.sexo='F') or (Aluno.sexo='f') then
        begin
          Aluno.sexo:='Feminino';
          writeln ('Sexo: ',Aluno.sexo);
          Aluno.sexo:='F';
        end;
        if (Aluno.status='Ativo') or (Aluno.status='ativo') then
        begin
          Aluno.status:='Ativo';
          textcolor(2);
          writeln ('Status: ',Aluno.status);
          textcolor(15);
        end;
        if (Aluno.status='Inativo') or (Aluno.status='inativo') then
        begin
          Aluno.status:='Inativo';
          textcolor(4);
          writeln ('Status: ',Aluno.status);
          textcolor(15);
        end;
        writeln;
      end;
    end;
    if i=-1 then
    begin
      writeln;
      textcolor(4);
      writeln ('Aluno não cadastrado.');
      textcolor(15);
      writeln;
    end;
    writeln ('>> Deseja realizar outra pesquisa? S/N <<');
    readln (opcao1);
  UNTIL (opcao1='N') or (opcao1='n');
End;

procedure Pesquisa_cod;

var codaluno:integer;

begin
  REPEAT
    clrscr;
    write ('Informe o código do Aluno a ser consultado: ');
    readln (codaluno);
    i:=achou(codaluno);
    if i<>-1 then
    begin
      writeln;
      textcolor(2);
      writeln ('Busca realizada com sucesso!');
      textcolor(15);
      writeln;
      Seek (ArqAcad, i);
      read (ArqAcad, Aluno);
      writeln ('Código: ',Aluno.cod);
      writeln ('Nome: ',Aluno.nome);
      writeln ('Idade: ',Aluno.idade);
      if (Aluno.sexo='M') or (Aluno.sexo='m') then
      begin
        Aluno.sexo:='Masculino';
        writeln ('Sexo: ',Aluno.sexo);
        Aluno.sexo:='M';
      end;
      if (Aluno.sexo='F') or (Aluno.sexo='f') then
      begin
        Aluno.sexo:='Feminino';
        writeln ('Sexo: ',Aluno.sexo);
        Aluno.sexo:='F';
      end;
      if (Aluno.status='Ativo') or (Aluno.status='ativo') then
      begin
        Aluno.status:='Ativo';
        textcolor(2);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      if (Aluno.status='Inativo') or (Aluno.status='inativo') then
      begin
        Aluno.status:='Inativo';
        textcolor(4);
        writeln ('Status: ',Aluno.status);
        textcolor(15);
      end;
      writeln;
    end;
    if i=-1 then
    begin
      writeln;
      textcolor(4);
      writeln ('Aluno não cadastrado.');
      textcolor(15);
      writeln;
    end;
    writeln ('>> Deseja realizar outra pesquisa? S/N <<');
    readln (opcao1);
  UNTIL (opcao1='N') or (opcao1='n');
End;

procedure Relatorio;

var opcao2:integer;

begin
  REPEAT
    clrscr;
    writeln ('>> Relatório de Cadastros <<');
    writeln;
    writeln ('1. Relatório de todos os cadastros');
    writeln ('2. Relatório de cadastros ativos');
    writeln ('3. Relatório de cadastros inativos');
    writeln ('4. Voltar ao MENU PRINCIPAL');
    writeln;
    writeln ('Qual a opção desejada?');
    readln (opcao2);
    CASE opcao2 OF
      1:
      begin
        clrscr;
        writeln ('>> Relatório de todos cadastros <<');
        writeln;
        Seek (ArqAcad, 0);
        while (not eof(ArqAcad)) do
        begin
          read (ArqAcad, Aluno);
          writeln ('Código: ',Aluno.cod);
          writeln ('Nome: ',Aluno.nome);
          writeln ('Idade: ',Aluno.idade);
          if (Aluno.sexo='M') or (Aluno.sexo='m') then
          begin
            writeln ('Sexo: Masculino');
          end;
          if (Aluno.sexo='F') or (Aluno.sexo='f') then
          begin
            writeln ('Sexo: Feminino');
          end;
          if (Aluno.status='Ativo') or (Aluno.status='ativo') then
          begin
            textcolor(2);
            writeln ('Status: Ativo');
            textcolor(15);
          end;
          if (Aluno.status='Inativo') or (Aluno.status='inativo') then
          begin
            textcolor(4);
            writeln ('Status: Inativo');
            textcolor(15);
          end;
          writeln;
        end;
        if filesize(ArqAcad)=0 then
        begin
          textcolor(4);
          writeln ('Nenhum cadastro realizado.');
          textcolor(15);
        end;
        writeln;
        writeln ('Pressione alguma tecla para voltar ao MENU.');
        readkey;
        writeln;
      end;
      2:
      begin
        clrscr;
        writeln ('>> Relatório de cadastros ativos <<');
        writeln;
        Seek (ArqAcad, 0);
        while (not eof(ArqAcad)) do
        begin
          read (ArqAcad, Aluno);
          IF (aluno.status='Ativo') or (aluno.status='ativo') then
          begin
            writeln ('Código: ',Aluno.cod);
            writeln ('Nome: ',Aluno.nome);
            writeln ('Idade: ',Aluno.idade);
            if (Aluno.sexo='M') or (Aluno.sexo='m') then
            begin
              writeln ('Sexo: Masculino');
            end;
            if (Aluno.sexo='F') or (Aluno.sexo='f') then
            begin
              writeln ('Sexo: Feminino');
            end;
            if (Aluno.status='Ativo') or (Aluno.status='ativo') then
            begin
              textcolor(2);
              writeln ('Status: Ativo');
              textcolor(15);
            end;
            writeln;
          end;
        end;
        if filesize(ArqAcad)=0 then
        begin
          textcolor(4);
          writeln ('Nenhum cadastro realizado.');
          textcolor(15);
        end;
        writeln;
        writeln ('Pressione alguma tecla para voltar ao MENU.');
        readkey;
      end;
      3:
      begin
        clrscr;
        writeln ('>> Relatório de cadastros inativos <<');
        writeln;
        Seek (ArqAcad, 0);
        while (not eof(ArqAcad)) do
        begin
          read (ArqAcad, Aluno);
          IF (aluno.status='Inativo') or (aluno.status='inativo') then
          begin
            writeln ('Código: ',Aluno.cod);
            writeln ('Nome: ',Aluno.nome);
            writeln ('Idade: ',Aluno.idade);
            if (Aluno.sexo='M') or (Aluno.sexo='m') then
            begin
              writeln ('Sexo: Masculino');
            end;
            if (Aluno.sexo='F') or (Aluno.sexo='f') then
            begin
              writeln ('Sexo: Feminino');
            end;
            if (Aluno.status='Inativo') or (Aluno.status='inativo') then
            begin
              textcolor(4);
              writeln ('Status: Inativo');
              textcolor(15);
            end;
            writeln;
          end;
        end;
        if filesize(ArqAcad)=0 then
        begin
          textcolor(4);
          writeln ('Nenhum cadastro realizado.');
          textcolor(15);
        end;
        writeln;
        writeln ('Pressione alguma tecla para voltar ao MENU.');
        readkey;
      end;
    end;//end do case
    UNTIL opcao2=4;
  End;
End.
