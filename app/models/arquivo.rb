class Arquivo < ApplicationRecord
  has_many :compras, dependent: :delete_all

  validates :nome_arq, uniqueness: true
end
