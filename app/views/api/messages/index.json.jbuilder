json.array! @messages do |message|
  json.text message.text
  json.user_name message.user.name
  json.id message.id
end