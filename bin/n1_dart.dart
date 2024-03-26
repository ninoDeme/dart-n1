import 'package:n1_dart/n1_dart.dart';
import 'dart:io';

void main() async {
  await gerarRelatorio(['arquivo1.txt', 'arquivo2.txt']);
}

Future<void> gerarRelatorio(List<String> arquivos) async {
  List<List<String>> conteudos =
      await Future.wait(arquivos.map((arquivo) => File(arquivo).readAsLines()));

  List<String> linhas = conteudos.expand((vals) => vals.skip(1)).toList();

  DateTime? dataInicial;
  DateTime? dataFinal;
  double totalReceitas = 0;
  double totalDespesas = 0;
  double lucroTotal = 0;

  for (String linhaAtual in linhas) {
    if (linhaAtual == '') {
      continue;
    }

    var [dataString, receitaString, despesaString] = linhaAtual.split(',');

    var [year, month, day] = dataString.split('/');

    DateTime data =
        DateTime.utc(int.parse(day), int.parse(month), int.parse(year));

    totalReceitas += double.parse(receitaString);
    totalDespesas += double.parse(despesaString);

    if (dataFinal == null || data.isAfter(dataFinal)) {
      dataFinal = data;
    }
    if (dataInicial == null || data.isBefore(dataInicial)) {
      dataInicial = data;
    }
  }

  lucroTotal = totalReceitas - totalDespesas;

  String resultado = """
Relatório Financeiro da Empresa

Período Analisado: ${convertDate(dataInicial!)} - ${convertDate(dataFinal!)}

Total de Receitas: R\$ ${formatToReais(totalReceitas)}
Total de Despesas: R\$ ${formatToReais(totalDespesas)}
Lucro Total: R\$ ${formatToReais(lucroTotal)}
""";

  await File('relatorio.txt').writeAsString(resultado);
}
