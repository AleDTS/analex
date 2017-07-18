require_relative 'analex'
require_relative 'anatax'

class Main
  if ARGV[0] == nil
    abort("Uso: ruby main.rb <nome_do_arquivo>")
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