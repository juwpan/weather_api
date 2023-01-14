class Forecast < ApplicationRecord
  scope :sorted, -> { order(epoch_time: :desc) }
  scope :historical, -> { sorted.limit(24) }

  def self.by_time(timestamp)
    all_date = Forecast.pluck(:epoch_time)

    all_date.each do |time|
      time_difference = (time.to_i - timestamp.to_i).abs
      
      if time_difference <= 30.minutes.to_i
        return time
      elsif time_difference > 24.hours.to_i
        raise ActiveRecord::RecordNotFound, "No data for this timestamp"
      end
    end
  end
end
