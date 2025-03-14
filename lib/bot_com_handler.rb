# 02.03.25. 
# Обработчик команд бота /bot
  # Получить команду => 
  # Дастать данные из бд => 
  # Сформировать документ xlsx =>
  # Отправить
require 'faraday'

class BotComHandler

  def initialize(option)
    @text = option[:message].text
    @chat = option[:message].chat
    @bot = option[:bot] 
    clear
    # test_process
  end
  
  def clear
    text = @text.split(' ')             # Разбить на массив
    text.shift                         # Убрать команду боту
    text.each { |w| puts w.downcase } # Получить массив команды
  end

  # ## Тест получение данных с бд  и обработка 
  def test_process
    # users = User.all
    # puts users[0].user_id

    cars = Car.all
    cars.each do |car|
      puts car.name
    end
    
  # тест Отправки сообщением файда xlsx
    file_path = 'ruby.xlsx'
    # @bot.api.send_message(chat_id: @chat.id, text: 'text')
    @bot.api.send_document(chat_id: @chat.id, document: Faraday::UploadIO.new(file_path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'))
  end
end