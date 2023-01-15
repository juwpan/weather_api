require 'rails_helper'
require 'support/factory_bot'

RSpec.describe Forecast, type: :model do
  describe '.by_time' do
    let!(:time_one) { create(:forecast) }
    let!(:time_two) { create(:forecast, epoch_time: 'Tue, 15 Feb 2022 17:45:00 GMT') }
    let!(:not_found) { create(:forecast, epoch_time: 'Sun, 13 Feb 2022 15:05:00 GMT') }

    context 'when difference <= 30 minutes' do
      it 'returns the nearest time' do
        near_time = Forecast.by_time(time_one.epoch_time.to_i + 20.minutes.to_i)
        expect(near_time).to eq(time_one.epoch_time)
      end
    end

    context 'when difference == 30 minutes' do
      it 'returns the nearest time' do
        near_time = Forecast.by_time(time_one.epoch_time.to_i - 30.minutes.to_i)
        expect(near_time).to eq(time_one.epoch_time)
      end
    end

    context 'when difference > 24 hours' do

      it 'returns RecordNotFound, "No data for this timestamp' do
        expect{ Forecast.by_time(not_found.epoch_time.to_i) }.to raise_error(ActiveRecord::RecordNotFound, "No data for this timestamp")
      end
    end
  end
end
