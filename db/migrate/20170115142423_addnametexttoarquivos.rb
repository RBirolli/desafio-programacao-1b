class Addnametexttoarquivos < ActiveRecord::Migration[5.0]
  def change
    add_column :arquivos, :nome_arq, :string
    add_column :arquivos, :receita_bruta, :decimal
  end
end
