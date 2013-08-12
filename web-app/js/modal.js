var modal = (function(){

    var method = {},
        $modal,
        $overlay,
        $content,
        $close;

    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    method.center = function(){
        var top, left;
        top = Math.max($(window).height() - $modal.height(), 0) / 2;
        left = Math.max($(window).width() - $modal.width(), 0) / 2;
        $modal.css({
            top:top + $(window).scrollTop(),
            left:left + $(window).scrollLeft()
        });
    }
    method.open = function(settings){
        $.ajax({
            url: settings.url,
            success: function(data) {
                $content.empty().append(data);
                $modal.append($content);
                method.center();
                $modal.append($close);
            }
        });

        $modal.css({
            width: settings.width || 'auto',
            height: settings.height || 'auto'
        });

        $(window).bind('resize.modal', method.center);

        $overlay.show();
        $modal.show();
    }
    method.close = function(){
        $modal.hide();
        $overlay.hide();
        $content.empty();
        $(window).unbind('resize.modal');
    }

    $close.click(function(event){
        event.preventDefault();
        method.close();
    })

    $modal.hide();
    $overlay.hide();

    $(document).ready(function(){
        $('body').append($overlay, $modal);
    })
}());

$(document).ready(function(){
    $('a#ajax-create').click(function(event){
        event.preventDefault();
        modal.open({url: '/csv-app/contact/createModal'});
    })

    $('a#ajax-edit').click(function(event){
        var link = $(this).attr('href');
        event.preventDefault();
        modal.open({url: link});
    })
})
