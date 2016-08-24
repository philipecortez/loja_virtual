require File.expand_path 'lib/formatador_moeda'

class Livro < Midia

  include FormatadorMoeda
  
  formata_moeda :valor, :valor_com_desconto
  attr_reader :categoria, :autor

  def initialize(titulo, autor, isbn = "1", numero_de_paginas, valor, categoria)
    super()
    @titulo = titulo
    @autor = autor
    @isbn = isbn
    @numero_de_paginas = numero_de_paginas
    @valor = valor
    @categoria = categoria
  end

  def to_s
    "Autor: #{@autor} \n Isbn: #{@isbn} \n Numero de Paginas: #{@numero_de_paginas}, Categoria: #{@categoria}"
  end

  def eql?(outro_livro)
    @isbn == outro_livro.isbn
  end

  def hash
    @isbn.hash
  end
end
