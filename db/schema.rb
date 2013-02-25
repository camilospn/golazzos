# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130225030332) do

  create_table "bets", :force => true do |t|
    t.integer  "monto"
    t.integer  "golesLocal"
    t.integer  "golesVisitante"
    t.integer  "partido_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "bets", ["partido_id"], :name => "index_bets_on_partido_id"
  add_index "bets", ["user_id"], :name => "index_bets_on_user_id"

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_uid"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "used",          :default => false
    t.decimal  "demora"
  end

  create_table "partidos", :force => true do |t|
    t.string   "local"
    t.string   "visitante"
    t.string   "logolocal"
    t.string   "logovisitante"
    t.datetime "diapartido"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "resultadoLocal"
    t.integer  "resultadoVisitante"
    t.boolean  "terminado"
    t.boolean  "cerrado"
    t.boolean  "repartido"
  end

  create_table "tokenreferidos", :force => true do |t|
    t.string   "tokenr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "pezzos",             :default => 0
    t.boolean  "administrator",      :default => false
    t.integer  "invitation_id"
    t.integer  "invitation_number",  :default => 0
    t.integer  "visits_number",      :default => 0
    t.integer  "pezzos_que_apuesta", :default => 10000
    t.integer  "post_on_fb",         :default => 0
    t.integer  "bets_number",        :default => 0
    t.integer  "age"
    t.string   "email"
  end

end
