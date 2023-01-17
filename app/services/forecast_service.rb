class ForecastService
  API_KEY = ENV['API_KEY_ACCUWEATHER'].freeze
  CITY_LOCAL = '24'
  require 'net/http'
  require 'json'

  # Читае Информацию с сайта API и передает в метод store_historical_forecast
  # в виде json Ruby объекта
  # Возвращает запись в модель или обновление Модели
  def historical_forecast
    url = "http://dataservice.accuweather.com/currentconditions/v1/#{CITY_LOCAL}/historical/#{CITY_LOCAL}?apikey=#{API_KEY}&language=ru-ru"
    uri = URI(url)
    response ||= Net::HTTP.get(uri)
    save_historical_forecast(JSON.parse(response))
  end

  private

  # Из полученного массива выбирает температуру и дату записывая их в Модель сответсвуешего поля
  # если дата найдена просто обновляет если нет создаёт новый файл
  def save_historical_forecast(response)
    response.each do |data|
      temp = data['Temperature']['Metric']['Value']
      time_stamp = data['EpochTime']

      Forecast
        .find_or_create_by(epoch_time: Time.at(time_stamp), temperature: temp)
        .update(temperature: temp, epoch_time: Time.at(time_stamp), created_at: Time.now)
    end
  end
end
