class Api::V1::ReservationMailer < ApplicationMailer

  def new_reservation(reservation)
    @reservation = reservation
    mail(to: @reservation.property.user.email, subject: 'Você tem um novo pedido de reserva \o/')
  end

  def cancel_reservation(reservation)
    @reservation = reservation
    mail(to: @reservation.property.user.email, subject: 'Um pedido de reserva foi cancelado :(')
  end
end
