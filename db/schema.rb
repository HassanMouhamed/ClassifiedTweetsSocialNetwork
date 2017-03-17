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

ActiveRecord::Schema.define(version: 20160611191747) do

  create_table "comments", force: :cascade do |t|
    t.integer "post_id", limit: 4,          null: false
    t.integer "user_id", limit: 4,          null: false
    t.text    "body",    limit: 4294967295, null: false
  end

  add_index "comments", ["id"], name: "id", unique: true, using: :btree
  add_index "comments", ["post_id"], name: "fk_post_idx", using: :btree
  add_index "comments", ["user_id"], name: "fk_writer_idx", using: :btree

  create_table "friendships", id: false, force: :cascade do |t|
    t.integer "first_user_id",  limit: 4, null: false
    t.integer "second_user_id", limit: 4, null: false
  end

  add_index "friendships", ["second_user_id"], name: "fk_second_user_idx", using: :btree

  create_table "likes", id: false, force: :cascade do |t|
    t.integer "post_id", limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
  end

  add_index "likes", ["user_id"], name: "fk_user2", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer "maker_id", limit: 4,                 null: false
    t.integer "action",   limit: 4,                 null: false
    t.integer "post_id",  limit: 4,                 null: false
    t.boolean "seen",               default: false
    t.integer "user_id",  limit: 4,                 null: false
  end

  add_index "notifications", ["id"], name: "id", unique: true, using: :btree
  add_index "notifications", ["maker_id"], name: "fk_maker", using: :btree
  add_index "notifications", ["post_id"], name: "fk_post_notif", using: :btree
  add_index "notifications", ["user_id"], name: "fk_user_notif", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "likes",              limit: 4,          default: 0
    t.text     "caption",            limit: 4294967295,             null: false
    t.string   "image",              limit: 100
    t.boolean  "is_public",                                         null: false
    t.integer  "user_id",            limit: 4,                      null: false
    t.integer  "post_category",      limit: 4,                      null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "posts", ["user_id"], name: "user_id_idx", using: :btree

  create_table "requests", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4,                 null: false
    t.integer "sender_id", limit: 4,                 null: false
    t.boolean "seen",                default: false
  end

  add_index "requests", ["sender_id"], name: "fk_sender_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                   limit: 45,    null: false
    t.string   "last_name",                    limit: 45,    null: false
    t.string   "password_digest",              limit: 100
    t.string   "email",                        limit: 45,    null: false
    t.string   "phone_number",                 limit: 15
    t.string   "gender",                       limit: 6,     null: false
    t.date     "birth_date",                                 null: false
    t.string   "profile_picture",              limit: 100
    t.string   "hometown",                     limit: 100
    t.string   "marital_status",               limit: 10
    t.text     "about_me",                     limit: 65535
    t.string   "profile_picture_file_name",    limit: 255
    t.string   "profile_picture_content_type", limit: 255
    t.integer  "profile_picture_file_size",    limit: 4
    t.datetime "profile_picture_updated_at"
  end

  add_index "users", ["email"], name: "email_UNIQUE", unique: true, using: :btree

  add_foreign_key "comments", "posts", name: "fk_post_comment", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comments", "users", name: "fk_writer_comment", on_update: :cascade, on_delete: :cascade
  add_foreign_key "friendships", "users", column: "first_user_id", name: "fk_first_user", on_update: :cascade, on_delete: :cascade
  add_foreign_key "friendships", "users", column: "second_user_id", name: "fk_second_user", on_update: :cascade, on_delete: :cascade
  add_foreign_key "likes", "posts", name: "fk_post2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "likes", "users", name: "fk_user2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notifications", "posts", name: "fk_post_notif", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notifications", "users", column: "maker_id", name: "fk_maker", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notifications", "users", name: "fk_user_notif", on_update: :cascade, on_delete: :cascade
  add_foreign_key "posts", "users", name: "fk_poster", on_update: :cascade, on_delete: :cascade
  add_foreign_key "requests", "users", column: "sender_id", name: "fk_sender", on_update: :cascade, on_delete: :cascade
  add_foreign_key "requests", "users", name: "fk_receiver", on_update: :cascade, on_delete: :cascade
end
