
class ArquivosController < ApplicationController
  before_action :valida_id
  before_action :txt_files_list, only: [:new, :edit]
  before_action :find_arquivo, only: [:show, :destroy]
  before_action :identifica_mobile
  before_action :bloqueia_mobile, only: [:new, :edit, :destroy]

  def index
    # Identificar todos os arquivos ja importados e exibir
    @arquivos = Arquivo.all
  end

  def new
    # Exibir todos os arquivos txt contidos no diretorio
  end

  def edit
    # Valida e cria o registro de identificacao do arquivo
    if validar_arquivo.nil? == true
      redirect_to new_arquivo_path, :notice => "Arquivo '#{@file_array[params[:id].to_i]}' ja foi importado ."
    else
      # Processa os dados de compra
      processar_compras(@arquivo)

      # Atualiza a receita bruta
      @arquivo.save

      # Atualizar a lista de arquivos importados
      redirect_to root_path, notice: "Arquivo: '#{@arquivo.nome_arq}' importado com sucesso."
    end
  end

  def show
    # Exibe todas as compras do arquivo solicitado
    @arquivo = Arquivo.find(params[:id].to_i)
    @compras = @arquivo.compras
  end

  def destroy
    # Exclui o arquivo e os respectivos registros de compras
    @arquivo.compras.delete_all
    @arquivo.delete
    redirect_to root_path, notice: "Arquivo: '#{@arquivo.nome_arq}' deletado com sucesso."
  end

  private

  def txt_files_list
  # identificar todos os arquivos txt contidos no diretorio
    @file_array = Dir.glob('*.txt')
  end

  def find_arquivo
    @arquivo = Arquivo.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def arquivo_params
    params.require(:arquivo).permit(:id)
  end

  def validar_arquivo
    # Verifica se o arquivo ja foi importado
    if Arquivo.find_by(nome_arq: @file_array[params[:id].to_i]).nil?
      # Ainda nao, criar um novo objeto
      @arquivo = Arquivo.new(nome_arq: @file_array[params[:id].to_i], data_upload: Time.now, receita_bruta: 0)
      # Salvar os dados do arquivo
      @arquivo.save
    end
  end

  def processar_compras(arquivo)
    # Abre o arquivo solicitado
    File.readlines(arquivo.nome_arq).each_with_index do |line, i|
      # Descartar a primeira linha
      if i > 0
        # Efetua o parse dos dados da compra
        parse_result = line.split("\t")
        compra = arquivo.compras.new
        compra.nome_comprador = parse_result[0]
        compra.descricao = parse_result[1]
        compra.preco_unitario = parse_result[2].to_f
        compra.quantidade = parse_result[3].to_i
        compra.endereco = parse_result[4]
        compra.nome_fornecedor = parse_result[5]

        # Salva os dados na base de dados
        compra.save

        # Totalizar o valor da venda
        arquivo.receita_bruta += (compra.preco_unitario * compra.quantidade)
      end
    end
  end

  def identifica_mobile
    # Verifica se o dispositivo conectado eh mobile
    request.user_agent.downcase.match(/mac os|windows/) ? @eh_mobile = false : @eh_mobile = true
  end

  def bloqueia_mobile
    # Bloqueia acesso indevido via celular
    redirect_to root_path if @eh_mobile
  end

  def valida_id
    # Verifica se o ID informado eh numerico
    if params[:id].nil? == false
      redirect_to ('/404') if params[:id].to_i.to_s != params[:id]
    end
  end
end
