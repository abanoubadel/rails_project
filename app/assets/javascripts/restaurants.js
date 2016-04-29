//= require tag-it.min
$(function () {


    if (typeof tags === 'undefined') {
        tags = []
    }
    $("#myTags").tagit({
        availableTags: tags,
        beforeTagAdded: function (event, ui) {
            if (tags.indexOf(ui.tagLabel) > -1) {
                $(".basket").append($("<input name='users[]' type='hidden' value='" + ui.tagLabel + "'>"))
                $("#tag_err").html("")

            } else {
                $("#tag_err").html(ui.tagLabel + " isn't in your frindes or groups")
                $("#myTags").tagit("removeTagByLabel", ui.tagLabel);
            }
        }
    });


    $('#res_tab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
////////////////////////////////////////////////////////////////////
    var i = 0;
    var basket = $('.basket');
    var table = $("#order_tabel");

    //The function that is triggered once delete button is pressed
    $(".basket").delegate('a.delete', "click", function () {
       var $li= $(this).closest("li");
        data_id = $li.data('id');
        changeBtn(false, data_id);
        $li.remove();
        return false
    });
    table.delegate('button', 'click', function () {
        var $el = $(this);
        var row = $el.parents('tr');
        if (changeBtn($el)) {
            addBasket(basket, row)
        } else {
            basket.find('li[data-id=' + row.data('id')+']').remove();
        }

    })


    function addBasket(basket, $ele) {
        var data_id = $ele.data('id');
        var price = $ele.data('price');
        var data_name = $ele.data('name');

        basket.find("ul").append('<li data-id="' + data_id + '">'
            + '<span class="name">' + data_name + '</span>'
            + '<input name="data[' + data_id + ']" class="count" value="1" type="text">'
            + '<a href="#" class="delete">&#10005;</a>');
        i++;
    }

    function changeBtn($el, data_id) {

        if ($el == false) {
            $el= table.find('tr[data-id='+data_id+']').find('button')
        }
        if ($el.text().trim() == "order") {
            $el.find('span').text(" remove");
            $el.addClass("btn-danger");
            $el.removeClass("btn-default");
            return true;
        } else {
            $el.find('span').text(" order");
            $el.removeClass("btn-danger");
            $el.addClass("btn-default");
            return false;
        }
    }
});
