class Addfkeytocompras < ActiveRecord::Migration[5.0]
  def change
    add_reference :compras, :arquivo, index: true, foreign_key: true
  end
end
