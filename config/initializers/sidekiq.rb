require 'sidekiq-cron'

Sidekiq::Cron::Job.create(name: 'Forecast - every 20 minutes',
  cron: '* /20 * * *',
  klass: 'FetchForecastDataJob')
