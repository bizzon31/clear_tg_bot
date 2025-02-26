#!/usr/bin/env ruby

# Перед подключение создать БД rake db:create и
# провести меграцию
require 'telegram/bot'
require './lib/app_cofigurator.rb'
require './lib/message_responder'

Dotenv.load 

# Конфигурация БД и Логов
config = AppConfigurator.new
config.configure

token = config.get_token
logger = config.get_logger

logger.debug 'Starting telegram bot'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = {bot: bot, message: message}

    logger.debug "@#{message.from.username}: #{message.text}" 
    
    # Оброботка сообщений 
    MessageResponder.new(options)
  end
end