require 'active_record'
require 'sqlite3'

# Подключение к исходной базе данных
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/test.db'
)

# Определение модели для исходной таблицы
class SourceTable < ActiveRecord::Base
  self.table_name = 'Cars' # Замените на имя вашей таблицы
end

source_cars = SourceTable.all.to_a

# Подключение к целевой базе данных
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/clear_tg_bot.db'
  )
  
  # Определение модели для целевой таблицы
  class TargetTable < ActiveRecord::Base
    self.table_name = 'Cars' # Замените на имя вашей таблицы
  end
  
  # puts source_cars.length
# Создание таблицы в целевой базе данных, если она еще не существует
unless TargetTable.table_exists?
  ActiveRecord::Schema.define do
    create_table :cars do |t|
      # Определите столбцы таблицы, как в исходной таблице
      t.string :name
      t.string :price
      # Добавьте другие столбцы
    end
  end
end
# Перенос данных
source_cars.each do |record|
  # puts record.Name
  TargetTable.create(name: record.Name, price: record.Price) # Исключаем 'id', чтобы избежать конфликтов
end

puts "Данные успешно перенесены!"