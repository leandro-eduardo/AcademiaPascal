Program ACADEMIA_ELITE_FITNESS;

Uses crt_acad;

Type academia=record
  cod, idade:integer;
  nome, status, sexo:string;
End;

Var ArqAcad:file of academia;
opcao:integer;

Begin
  REPEAT
    clrscr;
    textcolor(15);
    writeln ('-----------------------------------');
    writeln ('|          ELITE FITNESS          |');
    writeln ('-----------------------------------');
    writeln ('|                                 |');
    writeln ('| [1]  - Cadastro de Alunos       |');
    writeln ('| [2]  - Alterar dados do Aluno   |');
    writeln ('| [3]  - Alterar status           |');
    writeln ('| [4]  - Pesquisar Aluno - nome   |');
    writeln ('| [5]  - Pesquisar Aluno - código |');
    writeln ('| [6]  - Relatório de Alunos      |');
    writeln ('| [7]  - Finalizar                |');
    writeln ('|                                 |');
    writeln ('-----------------------------------');
    write ('        Opção desejada: ');
    readln (opcao);
    CASE opcao OF
      1:
      begin
        Abrir;
        Cadastro;
        close (ArqAcad);
      end;
      2:
      begin
        Abrir;
        Alterar;
        close (ArqAcad);
      end;
      3:
      begin
        Abrir;
        Excluir;
        close (ArqAcad);
      end;
      4:
      begin
        Abrir;
        Pesquisa_nome;
        close (ArqAcad);
      end;
      5:
      begin
        Abrir;
        Pesquisa_cod;
        close (ArqAcad);
      end;
      6:
      begin
        Abrir;
        Relatorio;
        close (ArqAcad);
      end;
      7:
      begin
        writeln;
        writeln ('   ----------------------------');
        writeln ('   |   PROGRAMA FINALIZADO!   |');
        writeln ('   ----------------------------');
      end;
    end;//end do case
    UNTIL (opcao=7);
    close (ArqAcad);
  End.