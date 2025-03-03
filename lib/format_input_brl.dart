String formatarMoedaBrasileira(String value) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  String apenasNumeros = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (apenasNumeros.isEmpty) {
    return 'R\$ 0,00';
  }
  double valor = double.parse(apenasNumeros) / 100;

  String formatado =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
  print(formatado);
  return formatado;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}