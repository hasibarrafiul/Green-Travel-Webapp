/*********************************************************************************
    Template Name: Porta - Free Bootstrap4 Minimal Portfolio Template
    Template URI: https://demo.curlyarts.com/porta/
    Description: Porta is a Bootstrap4 minimal portfolio template by CurlyArts, absolutely free for download !
    Author: CurlyArts
    Author URI: https://curlyarts.com/
    Version: 1.0

    Note: This is scripts js, all custom scripts included here

**********************************************************************************/
/*===============================================================================*/

(function ($) {
    'use strict';

    /* Button Effect */
    function buttonEffect() {
        $('<b></b>').appendTo('.cr-btn');
        $('.cr-btn')
            .on('mouseenter', function (e) {
                var parentOffset = $(this).offset(),
                    relX = e.pageX - parentOffset.left,
                    relY = e.pageY - parentOffset.top;
                $(this).find('b').css({
                    top: relY,
                    left: relX
                });
            })
            .on('mouseout', function (e) {
                var parentOffset = $(this).offset(),
                    relX = e.pageX - parentOffset.left,
                    relY = e.pageY - parentOffset.top;
                $(this).find('b').css({
                    top: relY,
                    left: relX
                });
            });
        $('[href="#"]').click(function () {
            return false;
        });
    }
    buttonEffect();
    

    /* Sticky Header */
    $(window).on('scroll', function () {
        var scrollPos = $(this).scrollTop();
        if (scrollPos > 300) {
            $('.sticky-header').addClass('is-sticky');
        } else {
            $('.sticky-header').removeClass('is-sticky');
        }
    });
    

    // Contact Form Message Popup
    function contactFormPopup() {
        var trigger = $('#contact-form [type="submit"]'),
            container = $('.cr-contact-message-modal');

        trigger.on('click', function () {
            container.addClass('is-visible');
        });

        $('<button><i class="icofont icofont-close"></i></button>').appendTo(container).on('click', function () {
            container.removeClass('is-visible');
        });
    }
    contactFormPopup();


})(jQuery);