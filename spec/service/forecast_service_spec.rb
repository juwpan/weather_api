require 'rails_helper'
require 'support/factory_bot'
require 'vcr'

RSpec.describe ForecastService do
  let(:forecast_service) { ForecastService.new }

  describe "#historical_forecast" do
    before(:each) do
      VCR.use_cassette("historical_forecast") do
        @forecast = forecast_service.historical_forecast
      end
    end

  # Проверяет является ли переменная эксемпляром класса Array после вызова метода
  # historical_forecast
    it "returns an array of forecast data" do
      expect(@forecast).to be_an(Array)
    end

  # Проверка сохранилось ли БД данные если сохранился хотя 
  # бы 1 эксемпляр то тест выдаёт true
    it "saves the forecast data to the database" do
      expect(Forecast.count).to be > 0
    end
  
  # Проходит по массиву данных записывая тепературу и время 
  # затем проверяет полученный результат находя в БД соответствующие поля
    it "saves the correct temperature and epoch_time to the database" do
      @forecast.each do |data|
        temp = data['Temperature']['Metric']['Value']
        time_stamp = data['EpochTime']

        forecast = Forecast.find_by(epoch_time: Time.at(time_stamp))

        expect(forecast.temperature).to eq(temp)
        expect(forecast.epoch_time).to eq(Time.at(time_stamp))
      end
    end
  end
end