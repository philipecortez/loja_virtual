require File.expand_path('lib/midia')
require File.expand_path('lib/dvd')
require File.expand_path('lib/livro')
require File.expand_path('lib/biblioteca')
require File.expand_path('lib/relatorio')
require File.expand_path('lib/banco_de_arquivos')

web_design_responsivo = Livro.new "Tarcio Zemel", "452565", 189, 69.9, :web_design
teste_e_design = Livro.new "Mauricio Aniche", "123454", 247, 69.9, :testes
p teste_e_design.valor
p teste_e_design.titulo
windows = DVD.new "Windows 7 for Dummies", 98.9, :sistemas_operacionais
p windows.valor
p windows.titulo
p teste_e_design.valor_com_desconto
p windows.valor_com_desconto
p teste_e_design.valor_formatado
biblioteca = Biblioteca.new
biblioteca.adiciona teste_e_design
biblioteca.adiciona web_design_responsivo

p biblioteca.inject(0) { |tot, livro| tot += livro.valor}
#teste_e_design = Livro.new "Mauricio Aniche", "123454", 247, 69.9, :testes

#BancoDeArquivos.new.salvar(teste_e_design)

#relatorio = Relatorio.new(biblioteca)
#p relatorio.total
