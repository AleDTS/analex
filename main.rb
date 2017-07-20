require_relative 'analex'
require_relative 'anatax'
require_relative 'anasem'

class Main
  #if ARGV[0] == nil
   # abort("Uso: ruby main.rb <nome_do_arquivo>")
  #else
   # name = ARGV[0]
  #end

  puts("Insira o nome do arquivo:")
  name = gets.chomp

  lex = Analex.new(name)

  if lex.lexicalAnalysis
    tax = Anatax.new(lex.symbol_table)
    if tax.syntaxAnalysis
        sem = Anasem.new(lex.symbol_table)
      puts "Sintaxe correta"
      if sem.semanticAnalisis
          puts "Semantica correta"
      else
          puts "Erro(s) semantico(s)"
      end
    else
      puts "Erro sintático na linha #{tax.line} - '#{tax.tokenValue}' "
    end
  else
    puts "Erro léxico na linha #{lex.line}: '#{lex.tokenValue}'"
  end

  gets.chomp()
end
