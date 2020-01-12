require "gameplayer"
require "game"

class MessagesController < ApplicationController
  before_action :set_room
  def index
    @message = Message.new
    @messages = @room.messages.includes(:user).where( 'show_user_id is null or show_user_id = ?' , current_user.id )
  end

  def create
    puts message_params
    @message = @room.messages.new(message_params)
    success = @message.save
    if success then
      notice = 'メッセージが送信されました'
      if @message.text.start_with?("@start") then
        if @room.users.length >= 4 then
          players = @room.users.map{|user| Gameplayer.new(user.id, user.name)}
          $game = Game.new(players)
          $game.start
          @room.users.each do |user|
            if user.id == $game.parent.id then
              text = "あなたは親です\n\n正解は" + $game.answerWord + 'です'
            elsif user.id == $game.wolf.id then
              text = "あなたは狼です\n\n正解は" + $game.answerWord + 'です'
            else
              text = "あなたは子です。"
            end
            message = @room.messages.new(params.require(:message).permit(:text).merge(text: text, user_id: current_user.id,show_user_id: user.id))
            message.save
          end
          
          notice = '闇のゲームを開始する。'
        else
          notice = '最低4人からスタート出来ます'
        end
      end
      if @message.text.start_with?('@answer ') then
        if $game == nil then
          notice = 'ゲームが開始されていません'
        else
          answer = @message.text.gsub(/^@answer /,'')
          if answer ==  $game.answerWord then
            notice = 'あたりです。正解は' + $game.answerWord + 'でした'
          else
            notice = 'ハズレです'
          end
        end
      end
      if @message.text.start_with?('@wolf ') then
        if $game == nil then
          notice = 'ゲームが開始されていません'
        else
          wolf = @message.text.gsub(/^@wolf /,'')
          if wolf ==  $game.wolf.name then
            notice = '狼が特定されました。狼は' +  $game.wolf.name + 'でした'
          else
            notice = 'ハズレです'
          end
        end
      end
      respond_to do |format|
        format.html {redirect_to room_messages_path(@room), notice: notice}
        format.json 
      end
      
    else
      @messages = @room.messages.includes(:user)
      flash.now[:alert] = '無言は死を意味する'
      render :index
    end
  end
  

  private
  def message_params
      params.require(:message).permit(:text).merge(user_id: current_user.id)
  end
  def set_room
    @room = Room.find(params[:room_id])
  end
end
