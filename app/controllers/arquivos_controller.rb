class ArquivosController < ApplicationController
before_action :txt_files_list, only: [:new, :edit]
before_action :find_arquivo, only: [:show, :update]

  def index
    # Identificar todos os arquivos ja importados e exibir
    @arquivos = Arquivo.all
  end

  def new
    # Exibir todos os arquivos txt contidos no diretorio
  end

  def edit
    # Cria o registro de identificacao do arquivo
    arquivo = Arquivo.new
    arquivo.nome_arq = @file_array[params[:id].to_i]
    arquivo.data_upload = Time.now
    arquivo.receita_bruta = 0
    # Salvar os dados do arquivo
    if arquivo.save
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

      # Atualiza a receita bruta
      arquivo.save

      # Exibir lista de arquivos importados
      redirect_to root_path, notice: 'Arquivo importado com sucesso.'
    else
      # Ocorreu erro, voltar para a pagina de solicitacao
      render :new
    end
  end

  def show
    # Exibe todas as compras do arquivo solicitado
    @arquivo = Arquivo.find(params[:id].to_i)
    @compras = @arquivo.compras
  end

  def update
    # Salvar a observacao digitada
byebug
    @arquivo.observacao = params[:format]
    @arquivo.save
    redirect_to root_path, notice: 'Arquivo importado com sucesso.'
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

end
