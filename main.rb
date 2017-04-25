class Lexi
  # Palavras do analisador
  letters = "ABCDEFGHIJKLMNOPQRSTUVXWYZabcdefghijklmnopqrstuvxwyz"
  numbers = "0123456789"
  comment = ["{","}","|","//"]
  end_string = ["\n"," ",";"]
  special = ["+","-","*","/",",",".","=","<","<=",">",">=",":",";","[","]",":=","..."]
  reserved = ["const","div","or","and","not","if","then","else","of","while","do","begin","end","read","write","var","array","function","procedure","program","true","false","char","integer","boolean"]
  lexema = String.new
  puts "Entre com o texto a ser analisada:"
  input = gets
  state = 0

  for character in input.chars                #Percorre o input todo
    puts "#{character}, #{state},#{lexema}"
    case state   # Verifica em que estado o automato está
      when 0 then
        if letters.include? character
          lexema << character
          state = 1
        elsif numbers.include? character
          lexema << character
          state = 2
        elsif comment.include? character
          lexema << character
          state = 3
        end
      when 1 then
        if (letters.include? character or numbers.include? character) and !(end_string.include? character)
          lexema << character
        elsif end_string.include? character
          if reserved.include? lexema     #Verifica se o lexema esta nas palavras reservadas
            puts "Palavra reservada"
          elsif special.include? lexema
            puts "Simbolos Reservados"
          else
            puts "Identificador"
          end
        end
      when 2 then
        if numbers.include? character and !(end_string.include? character)
          lexema << character
        elsif end_string.include? character
          if (lexama.to_i).abs <= 4294967295             #Verifica se o tamanho do inteiro é compativel com o Pascal
            puts "Inteiro Válido"
          else
            puts "OverFlow Inteiro"
          end
        elsif character == "."              #Se verdadeiro então se trata de um número real
          lexema << character
          state = 3
        end
      when 3 then
        if numbers.include? character and !(end_string.include? character)
          lexema << character
          state = 4
        else
          "Error: Verifique sua entrada"
        end
      when 4 then
        if end_string.include? character
          if lexema.to_f <= 3.4*(10**38)
            puts "Real Válido"
          else
            puts "OverFlow Real"
          end
        end
      else
        printf
    end
  end

end