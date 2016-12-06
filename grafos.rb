require 'matrix'

def menu
  ['-----------------------------------------------',
   'Ingrese una opcion',
   '1) Calcular cantidad de caminos de largo n - 1',
   '2) Calcular si el grafo es conexo',
   '-----------------------------------------------']
    .join "\n"
end

def caminos(matriz)
  puts 'Ingrese n'

  n = readline.strip.to_i

  potencias = n.times.map { matriz }.inject(1, :*)
  c = (Matrix.identity(matriz.row_count) + potencias)

  c.row_vectors.map(&:to_a).each do |a|
    puts a.to_s
  end
end

def conexo?(matriz)
  vertices = matriz.each.inject(0, :+)
  potencias = (vertices).times.map { |i| matriz**(i + 1) }.inject(:+)
  c = (Matrix.identity(matriz.row_count) + potencias)

  if c.all? { |coef| coef > 0 }
    puts 'El grafo es conexo'
  else
    puts 'El grafo no es conexo'
  end
end

def main
  begin
    puts 'Ingrese numero de filas y columnas'
    puts 'Ejemplo: 3 4 == 3 filas 4 columnas'

    filas, columnas = readline.strip.split(' ').map(&:to_i)

    matriz = Matrix.build(filas, columnas) do |fila, columna|
      STDOUT.write "valor (#{fila + 1}, #{columna + 1}): "
      readline.strip.to_i
    end

    loop do
      puts ''
      puts menu
      puts ''

      opcion = readline.strip.to_i

      case opcion
      when 1
        caminos matriz
      when 2
        conexo? matriz
      else
        puts "Opcion #{opcion} desonocida"
      end
    end

  rescue ExceptionForMatrix::ErrDimensionMismatch
    puts 'Esta matriz no se puede multiplicar'
  end
end

main
