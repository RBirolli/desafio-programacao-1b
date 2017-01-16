class CreateCompras < ActiveRecord::Migration[5.0]
  def change
    create_table :compras do |t|
      t.string :nome_comprador, limit: 50
      t.string :descricao, limit: 50
      t.decimal :preco_unitario
      t.integer :quantidade
      t.string :endereco, limit: 50
      t.string :nome_fornecedor, limit: 50

      t.timestamps
    end
  end
end
