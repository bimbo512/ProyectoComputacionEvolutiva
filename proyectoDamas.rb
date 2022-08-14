
# encoding: utf-8
# Programa: proyectoDamas.rb
# Autor: Juan Felipe Alvarado, Santiago Castaño
# Email: alvarado.juan@correounivalle.edu.co 
# Fecha creación: 2022-08-12 12:27
# Fecha última modificación: 
# Versión: 0.1
# Tiempo dedicado:

require 'matrix'

#Creación de la Propuesta inicial de un pool de cromosomas
class Propuesta
    attr_accessor :arreglo, :tamano, :elemento
    def initialize(arreglo)
        @arreglo = []
    end
    def tamano
        @tamano = @arreglo.length
    end
    def arreglo
        @arreglo
    end
    def agregarElemento(elemento)
        @arreglo.push(elemento)
    end
    def obtenerCromosoma(i)
        @arreglo[i]
    end
end

#creacion objeto Cromosoma
class Cromosoma
    attr_accessor :cadena, :aptitud, :gen
    def initialize(cadena, aptitud)
        @cadena = cadena
        @aptitud = aptitud
    end
    def add(x)
        @cadena.push(x)    
    end
    def verCromosoma
        @cadena 
    end 
    def verAptitud
        @aptitud 
    end
    def modificarAptitud(x)
        @aptitud=x
    end
    def verGen(x)
        @cadena[x] 
    end
end

#Funcion que crea un pool inicial de cromosomas
def crearPool(tamanoMatriz, numeroCromosomas)
    pool=Propuesta.new([])
    for i in (0..numeroCromosomas-1)
        jugada=[]
        for j in (0..tamanoMatriz-1)
            jugada.push(rand(tamanoMatriz))
        end
        pool.agregarElemento(jugada)
    end
    puts "tengo este pool #{pool.arreglo}"
    return pool
end

#función que revisa las reinas que chocan entre si de cada cromosoma del pool
def reinasEnConflicto(poolDeCromosomas, cantidadGenes)
    arregloCromosomas=[]
    #fitness=Cromosoma.new([])
    for i in (0..poolDeCromosomas.tamano-1)
        cromosoma=poolDeCromosomas.obtenerCromosoma(i)
        #puts "#{cromosoma}"
        objetoCromosoma=Cromosoma.new([], 0)
        for j in (0..cantidadGenes-1)
            objetoCromosoma.add(cromosoma[j])
            #puts "#{arregloCromosomas[i].verAptitud}"
            #paresEnConflicto=auxReinasEnConflicto(cromosoma, i)
            #puts "tengo esto cromosams #{cromosoma}"
        end
        arregloCromosomas.push(objetoCromosoma)
    end
    for i in (0..poolDeCromosomas.tamano-1)
        #puts "entré #{i} veces"
        #puts arregloCromosomas[i].verCromosoma
        reinasMalUbicadas=auxReinasEnConflicto(arregloCromosomas[i].verCromosoma,i)
        puts "El valor de la función fitness del siguiente cromosoma es: #{reinasMalUbicadas}"
        arregloCromosomas[i].modificarAptitud(reinasMalUbicadas)
        puts "El cromosoma correspondiente es: #{arregloCromosomas[i].verCromosoma}"
        #for j in (0..cantidadGenes-1)
            #revisarCromosoma=arregloCromosomas[i].verCromosoma
            #reinasMalUbicadas=auxReinasEnConflicto(arregloCromosomas[i].verCromosoma,j)
            #puts arregloCromosomas[i].verCromosoma
            #puts "los genes #{reinasMalUbicadas}"
        #end
    end
    
    #puts "cromosoma #{arregloCromosomas[0].verCromosoma}"
    #puts "tengo este fitness #{arregloCromosomas[0].verGen(1)}"
    return arregloCromosomas
end

#funcion auxiliar para calcular las reinas en conflicto
def auxReinasEnConflicto(arreglo, contador)
    grupoReinas=[]
    columnas=[]
    parMalPosicionado=0
    #a=arreglo.length
    #puts a-1
    for i in (0..arreglo.length-1)
        col=arreglo[i]
        #puts "este es el arreglo que entre #{arreglo}"
        #puts col
        #puts col
        row=i
        #puts row
        grupoReinas.push([row, col])
        columnas.push(col)
    end
    #puts "este es el nuevo arreglo con el que trabajo #{grupoReinas}"
    #puts arreglo
    for i in (0..grupoReinas.length-1)
        fila1=grupoReinas[contador][0]
        #puts fila1
        columna1=grupoReinas[contador][1]
        fila2=grupoReinas[i][0]
        columna2=grupoReinas[i][1]
        if (fila1-columna1==fila2-columna2||fila1+columna1==fila2+columna2)
            parMalPosicionado=parMalPosicionado+1
        elsif (fila1-columna1==fila2-columna2&&fila1+columna1==fila2+columna2)
            parMalPosicionado=parMalPosicionado+1
        elsif (columna1-columna2==fila1-fila2||columna1-columna2==fila2-fila1)
            parMalPosicionado=parMalPosicionado+1
        elsif (columna1-columna2==fila1-fila2&&columna1-columna2==fila2-fila1)
        end
        #puts parMalPosicionado
    end
    columnas.sort
=begin
    for i in (0..grupoReinas.length)
        if (columnas[i]=columnas[i+1])
            parMalPosicionado=parMalPosicionado+1
        end
    end
=end
    #fitness=(1.0-parMalPosicionado/100.0)*100-10
    return parMalPosicionado
end

#funcion que organiza los cromosomas según su aptitud
def organizarCromosomas(cromosomasParaOrganizar)
    arregloOrdenado=cromosomasParaOrganizar.sort! {|a,b| a.verAptitud <=> b.verAptitud}
    #cromosomasParaOrganizar.sort_by {|cromosomasParaOrganizar.verAptitud|}

    for i in (0..cromosomasParaOrganizar.length-1)
        puts "el arreglo de objetos después de ordenarlos es: #{arregloOrdenado[i].verCromosoma}"
    end
    return arregloOrdenado
    

end


def ejecutar
    puts "hola, porfavor introduce el tamaño del tablero cuadrado"
    valorMatriz=gets.chomp.to_i
    puts "hola, porfavor introduce el numero de cromosomas del pool inicial"
    numCromosomas=gets.chomp.to_i
    poolNuevo=crearPool(valorMatriz, numCromosomas)
    prueba=reinasEnConflicto(poolNuevo, valorMatriz)
    organizarCromosomas(prueba)
    
end

ejecutar






