# 20.02.25.
# Класс настраивает приложение на работу

require './lib/database_connector'


class AppConfigurator 
  def configure
    setup_database
  end

  def get_logger
    Logger.new(STDOUT, Logger::DEBUG)
  end

  private

  def setup_database
    DatabaseConnector.establish_connection
  end
end