class CreateArquivos < ActiveRecord::Migration[5.0]
  def change
    create_table :arquivos do |t|
      t.datetime :data_upload

      t.timestamps
    end
  end
end
