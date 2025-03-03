double convertStringToDouble(String entrada) {
  /// MODIFY CODE ONLY BELOW THIS LINE

// Remove todos os caracteres não numéricos exceto vírgula
  String apenasNumerosEVirgula = entrada.replaceAll(RegExp(r'[^0-9,]'), '');

  // Substitui a vírgula por ponto para converter para double
  String valorFormatado = apenasNumerosEVirgula.replaceAll(',', '.');

  // Converte a string resultante em número decimal
  double valor = double.parse(valorFormatado);

  return valor;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}