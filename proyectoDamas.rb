
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
    attr_accessor :cadena, :gen
    def initialize(cadena)
        @cadena = []
    end

    def add(gen)
        @cadena.push(gen)
        
    end
        

    def verError
        @cadena
        
    end
end

#Funcion que crea un pool inicial de cromosomas
def crearPool(tamanoMatriz)
    pool=Propuesta.new([])
    for i in (0..tamanoMatriz-1)
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
def reinasEnConflicto(poolDeCromosomas)
    fitness=Cromosoma.new([])
    for i in (0..poolDeCromosomas.tamano-1)
        cromosoma=poolDeCromosomas.obtenerCromosoma(i)
        paresEnConflicto=auxReinasEnConflicto(cromosoma, i)
        fitness.add(paresEnConflicto)
        #puts "tengo esto cromosams #{cromosoma}"
    end
    puts "tengo este fitness #{fitness.verError}"
end

#funcion auxiliar para calcular las reinas en conflicto
def auxReinasEnConflicto(arreglo, contador)
    grupoReinas=[]
    columnas=[]
    parMalPosicionado=0
    for i in (0..arreglo.length-1)
        col=arreglo[i]
        row=i
        grupoReinas.push([row, col])
        columnas.push(col)
        #puts "#{arreglo}"
        #puts "#{grupoReinas}"
    end
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
        puts parMalPosicionado
    end
    columnas.sort
=begin
    for i in (0..grupoReinas.length)
        if (columnas[i]=columnas[i+1])
            parMalPosicionado=parMalPosicionado+1
        end
    end
=end
    return parMalPosicionado  
end


def ejecutar
    puts "hola, porfavor introduce el numero de la matriz"
    valorMatriz=gets.chomp.to_i
    poolNuevo=crearPool(valorMatriz)
    reinasEnConflicto(poolNuevo)
end

ejecutar






