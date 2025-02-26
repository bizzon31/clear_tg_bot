require 'active_record'
require 'sqlite3'

# Подключение к SQLite3 базе данных
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'mydatabase.db'
)

# TODO: Вынести в деректорию модели
# Определение моделей и схемы базы данных
class User < ActiveRecord::Base
  has_many :orders
end

class Product < ActiveRecord::Base
  has_many :order_items
end

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
end

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
end

# TODO: Вынести в Rakefile в миграцию
# Создание таблиц в базе данных
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :username, null: false
    t.string :email, null: false
    t.string :password_hash, null: false
    t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
  end

  create_table :products, force: true do |t|
    t.string :name, null: false
    t.text :description
    t.decimal :price, precision: 10, scale: 2, null: false
    t.integer :stock, default: 0
    t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
  end

  create_table :orders, force: true do |t|
    t.references :user, null: false, foreign_key: true
    t.decimal :total_amount, precision: 10, scale: 2, null: false
    t.string :status, default: 'в обработке'
    t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
  end

  create_table :order_items, force: true do |t|
    t.references :order, null: false, foreign_key: true
    t.references :product, null: false, foreign_key: true
    t.integer :quantity, null: false
    t.decimal :price, precision: 10, scale: 2, null: false
  end
end

puts "База данных и таблицы успешно созданы!"