$(function () {
    $(".pagination a").live("click", function () {
        //$(".pagination a").html("...");
        $.get(this.href, null, null, "script");
        return false;
    });
});
