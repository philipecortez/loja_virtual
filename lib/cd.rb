class CD < Midia

  def initialize(titulo, valor, categoria)
    super()
    @titulo = titulo
    @valor = valor
    @categoria = categoria
  end

  def to_s
    %Q{ Titulo: #{@titulo}  \n Valor: #{@valor} }
  end
  
end
