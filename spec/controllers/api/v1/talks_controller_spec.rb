require 'rails_helper'

RSpec.describe Api::V1::TalksController, type: :controller do

  describe "POST #create_message" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and existing talk" do

      before do
        request.headers.merge!(@auth_headers)
        @talk = create(:talk, user: @user)
      end

      it "The talk have a message associated" do
        post :create_message, params: {id: @talk.id, body: FFaker::Lorem.word}
        @talk.reload
        expect(@talk.messages.count).to eql(1)
      end

      it "the last message from conversation have the right body" do
        body = FFaker::Lorem.word
        post :create_message, params: {id: @talk.id, body: body}
        @talk.reload
        expect(@talk.messages.last.body).to eql(body)
      end
    end

    context "with valid params and without talk" do

      before do
        request.headers.merge!(@auth_headers)
        @property = create(:property)
      end

      it "A talk are created" do
        post :create_message, params: {property_id: @property.id, body: FFaker::Lorem.word}
        expect(Talk.all.count).to eql(1)
      end

      it "the last message from conversation have the right body" do
        body = FFaker::Lorem.word
        post :create_message, params: {property_id: @property.id, body: body}
        expect(Talk.last.messages.last.body).to eql(body)
      end
    end
  end

  describe "GET #messages" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with invalid user" do

      before do
        request.headers.merge!(@auth_headers)
        @user2 = create(:user)
        @talk = create(:talk, user: @user2)
        create(:message, talk: @talk)
      end

      it "will receive status 401" do
        get :messages, id: @talk.id
        expect(response.status).to eql(401)
      end
    end

    context "with valid params and 10 messages" do

      before do
        request.headers.merge!(@auth_headers)
        @talk = create(:talk, user: @user)
        10.times do
          create(:message, talk: @talk)
        end
      end

      it "will receive 10 messages" do
        get :messages, id: @talk.id
        expect(JSON.parse(response.body)['talk']['messages'].count).to eql(10)
      end

      it "The last message is the first created" do
        get :messages, id: @talk.id
        expect(JSON.parse(response.body)['talk']['messages'].last['id']).to eql(Message.first.id)
      end

      it "The message comes with User" do
        get :messages, id: @talk.id
        message = JSON.parse(response.body)['talk']['messages'][0]
        expect(message['user']['id'].present?).to eql(true)
      end
    end

    context "with valid params and a reservation associated" do

      before do
        request.headers.merge!(@auth_headers)
        @reservation = create(:reservation)
        @talk = create(:talk, user: @user, reservation: @reservation)
        @message = create(:message, talk: @talk)
      end

      it "will return the right reservation" do
        get :messages, id: @talk.id
        reservation = JSON.parse(response.body)['talk']['reservation']
        expect(reservation['id']).to eql(@reservation.id)
      end
    end

    context "with valid params and zero reservation associated" do

      before do
        request.headers.merge!(@auth_headers)
        @talk = create(:talk, user: @user, reservation: nil)
        @message = create(:message, talk: @talk)
      end

      it "will return the right reservation" do
        get :messages, id: @talk.id
        reservation = JSON.parse(response.body)['talk']['reservation']
        expect(reservation).to eql(nil)
      end
    end
  end


  describe "GET #index" do
    before do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and 10 talks" do

      before do
        request.headers.merge!(@auth_headers)
        10.times do
          create(:talk, user: @user)
        end
      end

      it "will receive 8 elements in first page" do
        get :index, page: 1
        expect(JSON.parse(response.body).count).to eql(8)
      end

      it "will receive 2 elements in second page" do
        get :index, page: 2
        expect(JSON.parse(response.body).count).to eql(2)
      end

    end

    context "with valid params and 4 talks where the user is client" do

      before do
        request.headers.merge!(@auth_headers)
        @talk1 = create(:talk, user: @user)
        @talk2 = create(:talk, user: @user)
        @talk3 = create(:talk, user: @user)
        @talk4 = create(:talk, user: @user)
      end

      it "receive 4 talks" do
        get :index
        expect(JSON.parse(response.body).count).to eql(4)
      end

      # Nesta parte nós testamos para ver se as mensagens estão vindo na ordem certa
      # Ou seja, se o primeiro talk da lista é a que tem a mensagem com a data mais recente
      # E assim sucessivamente até a última que tem a data mais antiga
      it "The results come in the right order (based in last message date)" do
        # O terceiro talk vai ser o mais antigo
        create(:message, talk: @talk3)
        # O segundo talk o segundo mais antigo
        create(:message, talk: @talk2)
        # O primeiro o segundo mais Novo
        create(:message, talk: @talk1)
        # O quarto o mais Novo
        create(:message, talk: @talk4)

        get :index

        expect(JSON.parse(response.body)[0]['talk']['id']).to eql(@talk4.id)
        expect(JSON.parse(response.body)[1]['talk']['id']).to eql(@talk1.id)
        expect(JSON.parse(response.body)[2]['talk']['id']).to eql(@talk2.id)
        expect(JSON.parse(response.body)[3]['talk']['id']).to eql(@talk3.id)
      end

    end

    context "with valid params and 4 where the user is client in 2 and property in 2" do

      before do
        request.headers.merge!(@auth_headers)
        @talk1 = create(:talk, user: @user)
        @talk2 = create(:talk, user: @user)

        @property = create(:property, user: @user)

        @talk3 = create(:talk, property: @property)
        @talk4 = create(:talk, property: @property)
      end

      it "receive 4 talks" do
        get :index
        expect(JSON.parse(response.body).count).to eql(4)
      end

      # Nesta parte nós testamos para ver se as mensagens estão vindo na ordem certa
      # Ou seja, se o primeiro talk da lista é a que tem a mensagem com a data mais recente
      # E assim sucessivamente até a última que tem a data mais antiga
      it "The results come in the right order (based in last message date)" do
        # O terceiro talk vai ser o mais antigo
        create(:message, talk: @talk3)
        # O segundo talk o segundo mais antigo
        create(:message, talk: @talk2)
        # O primeiro o segundo mais Novo
        create(:message, talk: @talk1)
        # O quarto o mais Novo
        create(:message, talk: @talk4)

        get :index

        expect(JSON.parse(response.body)[0]['talk']['id']).to eql(@talk4.id)
        expect(JSON.parse(response.body)[1]['talk']['id']).to eql(@talk1.id)
        expect(JSON.parse(response.body)[2]['talk']['id']).to eql(@talk2.id)
        expect(JSON.parse(response.body)[3]['talk']['id']).to eql(@talk3.id)
      end

    end
  end
end
