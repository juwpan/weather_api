class FillBdJob < ApplicationJob
  queue_as :default

  def perform
    if Forecast.count == 0
      forecast_service = ForecastService.new
      forecast_service.historical_forecast
    else
      puts "BD already filled"
    end
  end
end
