// Removes border radius css on post when commented
function removePostRadius() {
  posts = document.querySelectorAll('.full_posts');
  var postNumber = 1;

  posts.forEach(function(post) {
    comments = post.querySelector('#post_comments');
    if (comments != null && 
        comments.querySelectorAll('#user_comment').length > 0) {
      for ( var i in document.styleSheets ) {
        if ( document.styleSheets[i].title && 
             document.styleSheets[i].title == "wall_posts" ) {

          var newRule = "#friends_post" + postNumber +
                        " {border-bottom-right-radius: 0px; border-bottom-left-radius: 0px}"

          document.styleSheets[i].insertRule(newRule);
        }
      }
    }
  postNumber++;
  })
}