require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Forecasts', type: :request do
  describe 'GET' do
    let!(:temp) { create(:forecast) }
    let!(:temp_two) { create(:forecast, temperature: 25, epoch_time: 'Tue, 15 Feb 2022 15:35:00 GMT') }
    let!(:tem_three) { create(:forecast, temperature: 15) }

    it 'returns the current temperature' do
      expect(get('/weather/current')).to eq(200)
      expect(temp.temperature).to eq(17)
    end

    it 'returns the historical temperature' do
      expect(get('/weather/historical')).to eq(200)
      expect(temp.temperature).to eq(17)
      expect(temp_two.temperature).to eq(25)
      expect(tem_three.temperature).to eq(15)
    end

    it 'returns the historical max temperature' do
      get('/weather/historical/max')
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).to_i).to eq(25)
    end

    it 'returns the historical min temperature' do
      get('/weather/historical/min')
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).to_i).to eq(15)
    end

    it 'returns the historical avg temperature' do
      get('/weather/historical/avg')
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).to_i).to eq(19)
    end

    it 'returns the historical avg temperature' do
      get('/weather/historical/avg')
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).to_i).to eq(19)
    end

    it 'returns always ok' do
      get ('/health')
      expect(response).to have_http_status(200)
      expect(response.body).to eq("OK")
    end

    context 'when timestamp is found in existing data' do
      it 'returns the nearest time' do
        get('/weather/by_time')
        expect(response).to have_http_status(200)
        near_time = Forecast.by_time(temp_two.epoch_time.to_i)
        expect(near_time).to eq(temp.epoch_time)
      end
    end

    context 'when timestamp is not found in existing data' do
      let(:not_found) { create(:forecast, epoch_time: 'Sun, 13 Feb 2022 15:05:00 GMT') }
      
      it 'raises ActiveRecord::RecordNotFound' do
        expect{ Forecast.by_time(not_found.epoch_time.to_i) }.to raise_error(ActiveRecord::RecordNotFound, 'No data for this timestamp')
      end
    end
  end
end
