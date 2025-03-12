# 02.03.25. 
# Обработчик команд бота /bot

class BotComHandler
  def initialize(text)
    @text = text.split(' ')
    puts "connect BotComHandler #{@text}"
  end
end