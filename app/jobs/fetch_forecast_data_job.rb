class FetchForecastDataJob < ApplicationJob
  queue_as :default

  def perform
    forecast_service = ForecastService.new
    forecast_service.historical_forecast
  end
end
