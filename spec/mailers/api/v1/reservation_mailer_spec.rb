require "rails_helper"

RSpec.describe Api::V1::ReservationMailer, type: :mailer do
  describe 'new_reservation' do
    before do
      @reservation = create(:reservation)
      @mail = Api::V1::ReservationMailer.new_reservation(@reservation).deliver_now
    end

    it 'Property Owner is the target' do
      expect(@mail.to).to eq([@reservation.property.user.email])
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq('Você tem um novo pedido de reserva \o/')
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['noreply@onebnb.com'])
    end

    it 'assigns user profile url' do
      expect(@mail.body.encoded).to match("profile/#{@reservation.user.id}")
    end
  end

  describe 'cancel_reservation' do
    before do
      @reservation = create(:reservation)
      @mail = Api::V1::ReservationMailer.cancel_reservation(@reservation).deliver_now
    end

    it 'Property Owner is the target' do
      expect(@mail.to).to eq([@reservation.property.user.email])
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq('Um pedido de reserva foi cancelado :(')
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['noreply@onebnb.com'])
    end

    it 'assigns property name' do
      expect(@mail.body.encoded).to match(@reservation.property.name)
    end
  end
end
