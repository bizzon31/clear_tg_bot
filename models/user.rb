require 'active_record'

class User < ActiveRecord::Base
  has_many :orders

  after_initialize do |u|
    puts "About to create user: #{u.username}"
  end
end