$(document).ready(function(){

  var counter = 2;

  $("#addButton").click(function () {

if(counter>2){
  return false;
}

var newCommentBoxDiv = $(document.createElement('div'))
  .attr("id", 'CommentBoxDiv' + counter);

newCommentBoxDiv.after().html('<input type="text" name="text" id="comment_field" />' + 
  '<input type="submit" value="Submit" class="comment_buttons" />' +
  '<input type="button" value="Cancel" class="comment_buttons" id="removeButton" />');

newCommentBoxDiv.appendTo("#CommentBoxesGroup");


$("#removeButton").click(function () {
  if(counter==1){
    return false;
  }

  counter--;

    $("#CommentBoxDiv" + counter).remove();

  });


counter++;
   });
});