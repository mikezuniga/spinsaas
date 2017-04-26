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

ActiveRecord::Schema.define(version: 20170418201231) do

  create_table "appmen", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "stackmetadata", limit: 65535
    t.string   "stackid"
    t.text     "details",       limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_appmen_on_user_id", using: :btree
  end

  create_table "appmen_clouds", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "appman_id"
    t.integer "cloud_id"
    t.index ["appman_id"], name: "index_appmen_clouds_on_appman_id", using: :btree
    t.index ["cloud_id"], name: "index_appmen_clouds_on_cloud_id", using: :btree
  end

  create_table "clouds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "apikey"
    t.string   "secretkey"
    t.string   "endpoint"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clouds_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "oauth_token"
    t.string   "oauth_refresh_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
