class Arquivo < ApplicationRecord
  has_many :compras, dependent: :destroy

end
