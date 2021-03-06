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

ActiveRecord::Schema.define(version: 20140504035928) do

  create_table "encrypted_messages", force: true do |t|
    t.string   "type",                      null: false
    t.string   "plaintext_description"
    t.date     "delete_at",                 null: false
    t.text     "encrypted_body"
    t.text     "encrypted_structured_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "encrypted_messages", ["delete_at"], name: "index_encrypted_messages_on_delete_at"
  add_index "encrypted_messages", ["type"], name: "index_encrypted_messages_on_type"

end
