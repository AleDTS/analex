class Analex

  @@letters =
      ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","W","Y","Z",
       "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","w","y","z","_"]
  @@numbers = ["0","1","2","3","4","5","6","7","8","9"]
  @@special_meaning = ["+","-","*","/","=","<",">","[","]",".",",","(",")",":","^",";"]
  @@second = [".", "=", ">","/"]
  @@blank = ["\n","\t"," "]

  # Palavras reservadas
  @@reserved = ["const","if","then","else","of","while","do","begin","end","read","write","var","array","function",
                "procedure","program","true","false","char","integer","boolean"]
  # Operadores
  @@operators = ["+","-","*","/",":=","=","<>","<","<=",">",">=",".", "^","and","or","not","div","mod","in"]
  # Delimitadores
  @@delimiters = [",",";",":","(",")","[","]",".."]

  # Tabela de simbolos
  @@symbol_table = Array.new

  @@line = 0
  @@file = String.new

  def initialize(name)
    # name.to_s
    @name = name
    @@file = IO.read(@name)
    if @@file[-1] != "\n"
      @@file << "\n"
    end
  end

  def symbol_table
    @@symbol_table
  end

  def printTable
    @@symbol_table.each do |element|
      puts "#{element[0]} -#{element[1]} - #{element[3]}"
    end
  end

  def line
    @@line
  end

  def tokenValue
    @@symbol_table[-1][0]
  end

  def lexicalAnalysis

    # Variavel de estado do automato
    state = 0
    @@file.each_line do |element|
      # Lexema
      lexeme = String.new
      @@line += 1
      for character in element.downcase.split("")      # Percorre o input todo
        # puts "#{character}, #{state}"
        case state                                # Verifica em que estado o automato está
          when 0 # Estado inicial do automato
            if @@numbers.include? character
              lexeme << character
              state = 1
            elsif @@letters.include? character
              lexeme << character
              state = 2
            elsif @@special_meaning.include? character
              lexeme << character
              state = 3
            elsif "{" == character
              state = 4
            elsif "'" == character
              state = 5
            elsif !(@@blank.include? character)
              @@symbol_table << [character, nil, nil, @@line,nil,nil]
              return false
            end
          when 1  # Estado que le numeros
            if @@numbers.include? character
              lexeme << character
            elsif !(@@numbers.include? character) and character != "."
              if (lexeme.to_i).abs <= 4294967295
                @@symbol_table << [lexeme, "NUMBER", lexeme.to_i, @@line,nil,nil]
              else  # OverFlow inteiro
                @@symbol_table << [lexeme, nil, nil, @@line,nil,nil]
                return false
              end
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@special_meaning.include? character
                state = 3
              else
                state = 0
              end
            elsif character == "."
              lexeme << character
              state = 11
            end
          when 11
            if @@numbers.include? character
              lexeme << character
              state = 12
            else # Real inválido
              @@symbol_table << [lexeme, nil, nil, @@line,nil,nil]
              return false
              # lexeme = String.new
              # # puts "#{@@symbol_table.last}"
              # if @@special_meaning.include? character
              #   state = 3
              # else
              #   state = 0
              # end
            end
          when 12
            if @@numbers.include? character
              lexeme << character
            elsif  (lexeme.to_f).abs <= (3.4*(10**38))
              @@symbol_table << [lexeme, "NUMBER", lexeme.to_f, @@line,nil,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@special_meaning.include? character
                state = 3
              else
                state = 0
              end
            else
              @@symbol_tabel = [lexeme, nil, nil, @@line,nil]
              return false
              # lexeme = String.new
              # # puts "#{@@symbol_table.last}"
              # state = 0
            end
          when 2 # Estado q le palavras reservadas e identificadores
            if (@@letters.include? character or @@numbers.include? character)
              lexeme << character
            elsif  @@reserved.include? lexeme
              @@symbol_table << [lexeme, lexeme, nil, @@line,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@special_meaning.include? character
                state = 3
              else
                state = 0
              end
            elsif !(@@reserved.include? lexeme)
              @@symbol_table << [lexeme, "IDENTIFIER", nil, @@line,nil,nil]
              lexeme = String.new
              # puts "#{@@symbol_table.last}"
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@special_meaning.include? character
                state = 3
              else
                state = 0
              end
            elsif !(@@operators.include? lexeme)
              @@symbol_table << [lexeme, lexeme, nil, @@line,nil,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(blank.include? character)
                lexeme << character
              end
              if @@special_meaning.include? character
                state = 3
              else
                state = 0
              end
            end
          when 3 # Estado que le simbolos operadores e delimitadores
            if @@special_meaning.include? character and @@second.include? character
              lexeme << character
            elsif @@operators.include? lexeme
              @@symbol_table << [lexeme, lexeme, nil, @@line,nil,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@numbers.include? character
                state = 1
              elsif @@letters.include? character
                state = 2
              elsif !(@@special_meaning.include? character)
                state = 0
              end
            elsif @@delimiters.include? lexeme
              @@symbol_table << [lexeme, lexeme, nil, @@line,nil,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              if !(@@blank.include? character)
                lexeme << character
              end
              if @@numbers.include? character
                state = 1
              elsif @@letters.include? character
                state = 2
              elsif character == "'"
                state = 5
              elsif !(@@special_meaning.include? character)
                state = 0
              end
            elsif lexeme == "//"
              lexeme = String.new
              state = 34
            else
              @@symbol_table << [lexeme, nil, nil, @@line,nil,nil]
              return false
              # # puts "#{@@symbol_table.last}"
              # lexeme = String.new
              # if !(@@blank.include? character) and character != "'"
              #   lexeme << character
              # end
              # if !(@@special_meaning.include? character)
              #   state = 0
              # end
            end
          when 34
            if character == "\n"
              state = 0
            end
          when 4 # Estado que le (e ignora) comentarios
            if character == "}"
              state = 0
            end
          when 5 # Estado que le strings
            if character == "'"
              @@symbol_table << [lexeme, "STRING", nil, @@line,nil,nil]
              # puts "#{@@symbol_table.last}"
              lexeme = String.new
              state = 0
            else
              lexeme << character
            end
        end
      end
    end
    # printTable
    true
  end
end
