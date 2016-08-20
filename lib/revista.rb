class Revista


  @id = 0

  class << self
    attr_reader :id
    def id
      @id += 1
    end  
  end
  
  attr_reader :titulo, :id

  def initialize(titulo)
    @id = self.class.id
    @titulo = titulo
  end

  def titulo_formatado
    titulo_upcase = @titulo.upcase
    "Titulo: #{titulo_upcase}"
  end
end
