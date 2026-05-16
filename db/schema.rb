# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_16_120009) do
  create_table "order_pizzas", force: :cascade do |t|
    t.text "add", default: "[]"
    t.datetime "created_at", null: false
    t.text "order_id", null: false
    t.integer "pizza_id", null: false
    t.text "remove", default: "[]"
    t.text "size", null: false
    t.float "size_multiplier", default: 1.0, null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_pizzas_on_order_id"
    t.index ["pizza_id"], name: "index_order_pizzas_on_pizza_id"
  end

  create_table "orders", id: :text, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "discount"
    t.integer "price"
    t.text "promotions", default: "[]"
    t.text "state", default: "open"
    t.datetime "updated_at", null: false
  end

  create_table "pizzas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "name"
    t.integer "price"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_pizzas", "orders"
  add_foreign_key "order_pizzas", "pizzas"
end
