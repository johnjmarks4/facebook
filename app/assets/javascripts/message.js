$(document).on('mouseenter', '.divbutton', function () {
    $(this).find(":button").show();
}).on('mouseleave', '.divbutton', function () {
    $(this).find(":button").hide();
}).on('click', ':button', function() {
    $(this).parent().remove();
});