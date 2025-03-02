# 20.02.25.
# Класс настраивает приложение на работу

require 'dotenv'
require './lib/database_connector'


class AppConfigurator 
  def configure
    setup_database
  end

  def get_logger
    Logger.new(STDOUT, Logger::DEBUG)
  end

  def get_token
    ENV['TELEGRAM_BOT_TOKEN']
  end

  private

  # Подключение к БД
  def setup_database
    DatabaseConnector.establish_connection
  end
end