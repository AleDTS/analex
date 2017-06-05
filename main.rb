require_relative 'analex'
require_relative 'anatax'

class Main
  if ARGV[0] == nil
    name = "exemplo.pas"
  else
    name = ARGV[0]
  end
  lex = Analex.new(name)
  lex.createSymbolTable
  # lex.printTable
  tax = Anatax.new(lex.symbol_table)
  # puts tax.table
  # puts lex.symbol_table
  tax.sintaxAnalisis
end