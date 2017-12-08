$(document).ready(function(){

  var counter = 2;

  $("#addButton").click(function () {

if(counter>10){
          alert("Only 10 commentboxes allow");
          return false;
}

var newCommentBoxDiv = $(document.createElement('div'))
     .attr("id", 'CommentBoxDiv' + counter);

newCommentBoxDiv.after().html('<label>Commentbox #'+ counter + ' : </label>' +
      '<input type="text" name="text" />' + 
      '<input type="submit" value="Submit" />' +
      '<input type="button" value="cancel" id="removeButton" />');

newCommentBoxDiv.appendTo("#CommentBoxesGroup");


$("#removeButton").click(function () {
  if(counter==1){
          alert("No more commentbox to remove");
          return false;
       }

  counter--;

        $("#CommentBoxDiv" + counter).remove();

     });


counter++;
   });
});