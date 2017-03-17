require 'rails_helper'

RSpec.describe Property, type: :model do
  describe Reservation, '.is_available?' do
    before do
      @property = create(:property)

      @busy_period1 = {checkin_date: Date.today + 1.day, checkout_date: Date.today + 2.day}
      @busy_period2 = {checkin_date: Date.today + 5.day, checkout_date: Date.today + 6.day}

      @reservation1 = create(:reservation, property: @property, checkin_date: @busy_period1[:checkin_date], checkout_date: @busy_period1[:checkout_date], status: :active)
      @reservation2 = create(:reservation, property: @property, checkin_date: @busy_period2[:checkin_date], checkout_date: @busy_period2[:checkin_date], status: :active)
    end

    it "Return true with checkin_date and checkout_date in free period" do
      @free_period  = {checkin_date: Date.today + 3.day, checkout_date: Date.today + 4.day}

      avaibility = @property.is_available? @free_period[:checkin_date], @free_period[:checkout_date]
      expect(avaibility).to eq(true)
    end

    it "Return false with checkin_date and checkout_date in busy period" do
      @busy_period3  = {checkin_date: Date.today + 2.day, checkout_date: Date.today + 5.day}

      avaibility = @property.is_available? @busy_period3[:checkin_date], @busy_period3[:checkout_date]
      expect(avaibility).to eq(false)
    end

    it "Return true with checkin_date and checkout_date in busy period of a canceled reservation" do
      @busy_period3  = {checkin_date: Date.today + 10.day, checkout_date: Date.today + 12.day}
      @reservation3 = create(:reservation, property: @property, checkin_date: @busy_period3[:checkin_date], checkout_date: @busy_period3[:checkin_date], status: :canceled)

      avaibility = @property.is_available? @busy_period3[:checkin_date], @busy_period3[:checkout_date]
      expect(avaibility).to eq(true)
    end
  end
end
