Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  
  get :health, to: proc { [200, {}, ["OK"]] }
  
  get "/weather/current", to: "forecasts#current"
  get "/weather/historical", to: "forecasts#historical"
  get "/weather/historical/max", to: "forecasts#max"
  get "/weather/historical/min", to: "forecasts#min"
  get "/weather/historical/avg", to: "forecasts#avg"
  get "/weather/by_time", to: "forecasts#by_time"
end
