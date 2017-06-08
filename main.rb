require_relative 'analex'
require_relative 'anatax'

class Main
  if ARGV[0] == nil
    name = "exemplo.pas"
  else
    name = ARGV[0]
  end

  lex = Analex.new(name)

  if lex.lexicalAnalysis
    tax = Anatax.new(lex.symbol_table)
    if tax.syntaxAnalysis
      puts "Sintaxe correta"
    else
      puts "Erro sintático na linha #{tax.line} - '#{tax.tokenValue}' "
    end
  else
    puts "Erro léxico na linha #{lex.line}: '#{lex.tokenValue}'"
  end
end