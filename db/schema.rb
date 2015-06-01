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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150531165702) do

  create_table "troubles", force: :cascade do |t|
    t.text     "question",         limit: 65535, null: false
    t.string   "encrypt_question", limit: 255,   null: false
    t.text     "answers",          limit: 65535, null: false
    t.string   "correct",          limit: 255,   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "troubles", ["encrypt_question"], name: "index_troubles_on_encrypt_question", using: :btree

end
