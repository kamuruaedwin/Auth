
$(document).ready(function() {
  $('#message-form').on('ajax:success', function(event) {
    // Handle success, e.g., update the messages container
    var response = event.detail[0];
    $('#messages-container').append(response.message_html);

    // Scroll to the bottom
    var messagesContainer = document.getElementById('messages-container');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;

    // Clear the text area
    $('#message-form textarea').val('');
  });

  $('#message-form').on('ajax:error', function(event) {
    // Handle error
    console.error('Failed to post message');
  });
});




  // setting scroll bar to bottom
  var messagesContainer = document.getElementById('messages-container');
  // Set the scrollTop property to make it start at the bottom
  messagesContainer.scrollTop = messagesContainer.scrollHeight;


// switching content of the chat-container card

  function changeContent(buttonId) {
    // Clear existing content in #cardBody
    $('#cardBody').empty();

    // Check which button is clicked
    if (buttonId === 'button1') {
      // Load the content of the table into the card body
      var tableContent = $('#bettable-container').html();
      $('#cardBody').html(tableContent);
    } else if (buttonId === 'button2') {
      // Update the card body with content for Button 2
      var messagesContent = $('#messages-container').html();
      $('#cardBody').html(messagesContent);
    }
  }

  // Set the default content to be the content of Button 1
  $(document).ready(function () {
    changeContent('button1');
  });
// end of content swtching