$(document).ready(function() {
  $("tbody").on("click", ".event-details", function() {
    var eventItem = $(this);
    var eventId = eventItem.data('id');

    $.ajax({
      type: "get",
      url: "/render_details/?event_id=" + eventId,
      success: function(response){
        $("#event").replaceWith(response);
        $(".table-container").replaceWith(response);
      }
    });
  });
});
