
# Подключить модели
# require 'active_record'
# require 'sqlite3'
require './models/user.rb'
require './lib/message_sender'

class Car < ActiveRecord::Base; end

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user
  attr_reader :logger

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @logger = AppConfigurator.new.get_logger

    # Записывает нового пользователя чата в БД
    @user = User.find_or_create_by(user_id: message.from.id, username: message.from.username)
  end

  def respond 
    on /^\/start/ do
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end
    
    on /^\/bot/ do
      # Обработка задания боту
      logger.debug "test: #{message.text}"
      # post_cars
    end
  end
  
  private

  def on regex, &block
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def answer_with_greeting_message
    answer_with_message 'greeting_message'
    # puts "greeting_message"
  end

  def answer_with_farewell_message
    answer_with_message 'farewell_message'
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  # ## Тест с постом всех данных из db cars
  def post_cars
    cars = Car.all
    cars.each {|car| 
      answer_with_message ("#{car.name}: #{car.price}")
    }
  end

end

