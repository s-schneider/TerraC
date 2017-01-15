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

ActiveRecord::Schema.define(version: 20170115133006) do

  create_table "articles", force: :cascade do |t|
    t.string   "article_producer"
    t.string   "article_name"
    t.string   "article_color"
    t.string   "article_size"
    t.text     "article_description"
    t.string   "article_receipt"
    t.datetime "article_purchasedate"
    t.string   "article_flaw"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "receipt_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "customer_name"
    t.string   "customer_street"
    t.string   "customer_town"
    t.string   "customer_phone"
    t.string   "customer_email"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "customer_notes"
    t.string   "customer_surname"
    t.string   "customer_mobile"
    t.string   "customer_club"
    t.string   "customer_newsletter"
    t.string   "customer_fax"
    t.string   "customer_group"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.string   "receipt_number"
    t.string   "receipt_type"
    t.string   "receipt_person"
    t.date     "receipt_date"
    t.text     "receipt_notes"
    t.integer  "customer_id"
    t.string   "producer"
    t.string   "article"
    t.string   "article_color"
    t.string   "article_size"
    t.integer  "type_id"
    t.date     "order_date"
    t.date     "order_receiving"
    t.date     "purchase_date"
    t.string   "article_flaw"
    t.string   "receipt_true"
    t.date     "customer_notice"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "article_quantity"
    t.integer  "user_id"
    t.integer  "state"
    t.string   "status"
    t.integer  "supplier_id"
  end

  create_table "rtypes", force: :cascade do |t|
    t.string   "type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.text     "delilver_cond"
    t.text     "payment_cond"
    t.text     "reorder_cond"
    t.text     "preorder_cond"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "order_id"
    t.integer  "service_id"
    t.integer  "internal_id"
    t.integer  "external_id"
    t.date     "preorder_date"
    t.string   "website"
    t.string   "b2b"
    t.string   "repair_condition"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
