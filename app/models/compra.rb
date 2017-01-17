class Compra < ApplicationRecord

  belongs_to :arquivo

  validates :nome_comprador, presence: true
  validates :descricao, presence: true
  validates :preco_unitario, presence: true
  validates :quantidade, presence: true
  validates :endereco, presence: true
  validates :nome_fornecedor, presence: true
end

