$(document).ready(function () {
  // Target the form by its ID
  $('#bet-form').on('submit', function (e) {
    e.preventDefault(); // Prevent the default form submission

    // Serialize the form data
    var formData = $(this).serialize();

    // Send an AJAX request to the server
    $.ajax({
      type: 'POST', // Use the appropriate HTTP method
      url: $(this).attr('action'), // Get the form's action URL
      data: formData,
      success: function (response) {
        // Handle the response, e.g., show a success message
        console.log("bet submitted successfully")
        startAnimation()
      },
      error: function (error) {
        // Handle errors, e.g., show an error message
      },
    });
  });
});
