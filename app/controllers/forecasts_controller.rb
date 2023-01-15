class ForecastsController < ApplicationController
  # Текущая температура
  def current
    forecast = Forecast.sorted.first.temperature
    render json: forecast
  end

  # Почасовая температура за 24 часа
  def historical
    forecast = Forecast.historical.pluck(:temperature, :epoch_time)
    render json: forecast.map { |temp, data| "Температура: #{temp} (дата: #{data})" }.join("\n")
  end

  # Максимальная темперетура за 24 часа
  def max
    forecast = Forecast.historical.maximum(:temperature)
    render json: forecast
  end

  # Минимальная темперетура за 24 часа
  def min
    forecast = Forecast.historical.minimum(:temperature)
    render json: forecast
  end

  # Средняя темперетура за 24 часа
  def avg
    forecast = Forecast.historical.average(:temperature).round(1)
    render json: forecast
  end

  # Найти температуру ближайшую к переданному timestamp
  # (например 1621823790 должен отдать температуру за 2021-05-24 08:00.
  # Из имеющихся данных, если такого времени нет вернуть 404)
  def by_time
    time = Forecast.last.epoch_time
    forecast = Forecast.by_time(time)
    render json: forecast
  end

  # Статус бекенда (Можно всегда отвечать OK)
  def health
    "ok"
  end
end
