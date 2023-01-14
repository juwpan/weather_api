class ForecastService
  API_KEY = ENV['API_KEY_ACCUWEATHER'].freeze
  require 'net/http'
  require 'json'

  def historical_forecast
    url = "http://dataservice.accuweather.com/currentconditions/v1/24/historical/24?apikey=#{API_KEY}&language=ru-ru"
    uri = URI(url)
    response ||= Net::HTTP.get(uri)
    store_historical_forecast(JSON.parse(response))
  end

  private

  def store_historical_forecast(response)
    response.each do |data|
      temp = data['Temperature']['Metric']['Value']
      time_stamp = data['EpochTime']

      Forecast
        .find_or_create_by(epoch_time: Time.at(time_stamp), temperature: temp)
        .update(temperature: temp, epoch_time: Time.at(time_stamp), created_at: Time.now)
    end
  end
end
