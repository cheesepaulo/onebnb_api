json.array! @talks do |talk|
  json.talk do
    json.extract! talk, :id, :created_at , :updated_at

    # Mostra a data da última mensagem trocada
    json.date talk.messages.last.created_at if talk.messages.count >= 1

    # Mostra as informações do User
    json.user do
      # Filtra para mostrar as informações do outro User da Conversa
      @user = (current_api_v1_user == talk.property.user) ? talk.user : talk.property.user
      json.extract! @user, :id, :name, :photo
    end

    # Mostra as informações da reserva caso existam
    if talk.reservation
      json.reservation do
        json.extract! talk.reservation, :id, :status
        # Devolve a quantidade de dias da reserva
        json.interval talk.reservation.interval_of_days
        # Devolve o preço baseado na quantidade de dias e no preço diario da Propriedade
        # TODO: Mudar no futuro para que use o preço que for gerado quando o reserva for aceita
        json.price (talk.reservation.interval_of_days * talk.property.price)
      end
    end
  end
end
