require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe Reservation, '.evaluated' do
    before do
      @user = create(:user)
      @property = create(:property)
      @comment = FFaker::Lorem.paragraph
    end

    it "Create Valid Comment" do
      reservation = create(:reservation, property: @property, evaluation: false, user: @user)
      reservation.evaluate @comment, 5
      expect(Comment.last.body).to eq(@comment)
    end

    it "Create Valid Rating" do
      reservation = create(:reservation, property: @property, evaluation: false, user: @user)
      reservation.evaluate @comment, 1
      reservation = create(:reservation, property: @property, evaluation: false, user: @user)
      reservation.evaluate @comment, 2
      reservation = create(:reservation, property: @property, evaluation: false, user: @user)
      reservation.evaluate @comment, 3

      @property.reload

      # Rating 1 + 2 + 3 / 3 = 2
      expect(@property.get_rating).to eq(2)
    end
  end
end
