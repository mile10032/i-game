$(function(){
  function buildHTML(message){
    var html =
      `<div class="chat__content__message" data-message-id=${message.id}>
        <div class="chat__content__message__user-name">
          ${message.user_name}
        </div>
        <div class="chat__content__message__text">
          <p class="chat__content__message__text__bun">
            ${message.text}
          </p>
        </div>
      </div>`
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.chat__content').append(html);
      $('.chat__content').animate({scrollTop: $('.chat__content')[0].scrollHeight}, 'fast');
      $('form')[0].reset();
    })
    return false
  })
  var reloadMessages = function() {
    last_message_id = $('.chat__content:last').data("message-id");
    $.ajax({
      url: "api/messages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      var insertHTML = '';
      $.each(messages, function(i, message) {
        insertHTML += buildHTML(message)
      });
      $('.chat__content').append(insertHTML);
      $('.chat__content').animate({scrollTop: $('.chat__content')[0].scrollHeight}, 'fast');
    })
    .fail(function() {
      console.log('error');
    });
  };
  setInterval(reloadMessages, 3000);
})