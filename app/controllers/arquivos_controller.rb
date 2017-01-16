class ArquivosController < ApplicationController

  def index
    # IDENTIFICAR todos os arquivos ja importados e exibir
    @arquivos = Arquivo.all
  end

  def new
    # identificar todos os arquivos txt contidos no diretorio
    @file_array = Dir.glob('*.txt')
  end

  def arquivos
  end
end
