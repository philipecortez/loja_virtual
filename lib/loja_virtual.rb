require File.expand_path('lib/document_not_found')
require File.expand_path('lib/formatador_moeda')
require File.expand_path('lib/midia')
require File.expand_path('lib/dvd')
require File.expand_path('lib/livro')
require File.expand_path('lib/biblioteca')
require File.expand_path('lib/relatorio')
require File.expand_path('lib/revista')
require File.expand_path('lib/banco_de_arquivos')

# =================================================================================
web_design_responsivo = Livro.new "Tarcio Zemel", "452565", 189, 69.9, :web_design
teste_e_design = Livro.new "Mauricio Aniche", "123454", 247, 69.9, :testes

p teste_e_design.valor
p teste_e_design.titulo

# =================================================================================

windows = DVD.new "Windows 7 for Dummies", 98.9, :sistemas_operacionais

p windows.valor
p windows.titulo
p teste_e_design.valor_com_desconto
p windows.valor_com_desconto
p teste_e_design.valor_formatado

class << windows
  def desconto_formatado
    "Desconto: #{@desconto * 100}%"
  end
end

puts windows.desconto_formatado
# =================================================================================



biblioteca = Biblioteca.new
biblioteca.adiciona teste_e_design
biblioteca.adiciona web_design_responsivo

p biblioteca.inject(0) { |tot, livro| tot += livro.valor}
#teste_e_design = Livro.new "Mauricio Aniche", "123454", 247, 69.9, :testes

#BancoDeArquivos.new.salvar(teste_e_design)

#relatorio = Relatorio.new(biblioteca)
#p relatorio.total

# =================================================================================
20.times {print "="}

# mundo_net = Revista.new("mundo Net")
mundo_j = Revista.new(titulo: "Mundo j", valor: 20.5)
mundo_j.save
puts ""
# puts mundo_net.titulo_formatado
# puts mundo_net.id
# puts ""
# puts mundo_j.titulo_formatado
puts mundo_j.id
# mundo_j.save

revista = Revista.find(5)
puts revista.inspect
revista.destroy
# =================================================================================

puts windows.valor_formatado
puts windows.valor_com_desconto_formatado