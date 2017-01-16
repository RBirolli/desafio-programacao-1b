# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170115142423) do

  create_table "arquivos", force: :cascade do |t|
    t.datetime "data_upload"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "nome_arq"
    t.decimal  "receita_bruta"
  end

  create_table "compras", force: :cascade do |t|
    t.string   "nome_comprador",  limit: 50
    t.string   "descricao",       limit: 50
    t.decimal  "preco_unitario"
    t.integer  "quantidade"
    t.string   "endereco",        limit: 50
    t.string   "nome_fornecedor", limit: 50
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "arquivo_id"
    t.index ["arquivo_id"], name: "index_compras_on_arquivo_id"
  end

end
