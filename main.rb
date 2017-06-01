require_relative 'analex'
require_relative 'anatax'

class Main
  lex = Analex.new("factorial.pas")
  lex.createSymbolTable
  # lex.printTable
  tax = Anatax.new(lex.symbol_table)
  tax.sintaxAnalisis
end