
class Anasem
    @@table = Array.new # Tabela de simbolos

    def initialize(table)
        @@table = table
    end

    # Retorna tabela de todas variaveis
    def varTable
        @@table.select { |t| t[5] == 'var' and t[4] == nil }
    end

    # Retorna tabela das variaveis declaradas no inicio do programa
    def declaredTable
        @@table.select { |t| t[4] == true }
    end

    # Retorna tabela das variaveis nao declaradas no meio do programa
    def isntDeclared
        varTable.reject { |t|
            declaredTable.map {|row| row[0]}.include? t[0]
        }
    end

    def semanticAnalisis
        nDeclared = isntDeclared
        if nDeclared.empty?
            return true
        else
            nDeclared.each { |var|
                puts "Variavel '#{var[0]}' na linha #{var[3]} nao foi declarada."
            }
        end
        false
    end
end
