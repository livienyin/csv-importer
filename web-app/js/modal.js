var modal = (function(){

    var method = {},
        $modal,
        $overlay,
        $content,
        $close;

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
            }
        });

        $modal.css({
            width: settings.width || 'auto',
            height: settings.height || 'auto'
        });

        $(window).bind('resize.modal', method.center);

        $modal.show();
        $overlay.show();

    }
    method.close = function(){
        console.log("hit close method");
        $modal.hide();
        $overlay.hide();
        $content.empty();
        $(window).unbind('resize.modal');
    }

    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    $modal.hide();
    $overlay.hide();
    $modal.append($overlay, $close);

    $(document).ready(function(){
        $('body').append($overlay, $modal);
    })

    $close.click(function(event){
        event.preventDefault();
        method.close();
    })

    return method;
}());

$(document).ready(function(){
    $('a#ajax-create').click(function(event){
        event.preventDefault();
        modal.open({url: '/csv-app/contact/createForm'});
    })
})
