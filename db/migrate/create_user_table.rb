class CreateUserTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users, force: true do |t|
      t.string :user_id, null: false
      t.string :username, null: false
      t.string :email, null: true
      t.string :phone, null: true
      t.string :password_hash, null: true
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end

# CreateUserTable.new.change