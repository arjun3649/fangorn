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

ActiveRecord::Schema[8.0].define(version: 2025_02_13_210844) do
  create_schema "audit"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "uuid-ossp"

  create_table "auth_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "value", limit: 255, null: false
    t.datetime "expires_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "expired"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "more_data", default: {}, null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
    t.index ["value"], name: "index_auth_tokens_on_value", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "slug", limit: 100, null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_properties", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "property_id", null: false
    t.string "value", null: false
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "more_data", default: {}, null: false
    t.index ["item_id"], name: "index_item_properties_on_item_id"
    t.index ["property_id"], name: "index_item_properties_on_property_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "primary_category", limit: 100, null: false
    t.string "slug", limit: 1024, null: false
    t.string "name", limit: 1024, null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "more_data", default: {}, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "primary_category"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by"
    t.datetime "deleted_at", precision: nil
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "primary_category"
    t.text "description"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "more_data", default: {}, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "products_id", null: false
    t.string "slug", limit: 1024
    t.string "name", limit: 1024
    t.string "variation_criteria", limit: 1024
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "created_by"
    t.datetime "deleted_at", precision: nil
    t.index ["products_id"], name: "index_variants_on_products_id"
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "variants", "products", column: "products_id"
end
