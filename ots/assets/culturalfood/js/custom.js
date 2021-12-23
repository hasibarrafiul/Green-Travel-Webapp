/******************************************
    Version: 1.0
/****************************************** */

(function($) {
    "use strict";
	
	
	
	// Smooth scrolling using jQuery easing
	  $('a.js-scroll-trigger[href*="#"]:not([href="#"])').click(function() {
		if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
		  var target = $(this.hash);
		  target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
		  if (target.length) {
			$('html, body').animate({
			  scrollTop: (target.offset().top - 54)
			}, 1000, "easeInOutExpo");
			return false;
		  }
		}
	  });
	
    // Closes responsive menu when a scroll trigger link is clicked
	  $('.js-scroll-trigger').click(function() {
		$('.navbar-collapse').collapse('hide');
	  });

	// Activate scrollspy to add active class to navbar items on scroll
	  $('body').scrollspy({
		target: '#mainNav',
		offset: 56
	  });

	// Collapse Navbar
	  var navbarCollapse = function() {
		if ($("#mainNav").offset().top > 100) {
		  $("#mainNav").addClass("navbar-shrink");
		} else {
		  $("#mainNav").removeClass("navbar-shrink");
		}
	  };
	// Collapse now if page is not at top
	  navbarCollapse();
	  // Collapse the navbar when page is scrolled
	  $(window).scroll(navbarCollapse);

	// Hide navbar when modals trigger
	  $('.portfolio-modal').on('show.bs.modal', function(e) {
		$(".navbar").addClass("d-none");
	  })
	  $('.portfolio-modal').on('hidden.bs.modal', function(e) {
		$(".navbar").removeClass("d-none");
	  });
	  
    // Scroll to top  		
	if ($('#scroll-to-top').length) {
		var scrollTrigger = 100, // px
			backToTop = function () {
				var scrollTop = $(window).scrollTop();
				if (scrollTop > scrollTrigger) {
					$('#scroll-to-top').addClass('show');
				} else {
					$('#scroll-to-top').removeClass('show');
				}
			};
		backToTop();
		$(window).on('scroll', function () {
			backToTop();
		});
		$('#scroll-to-top').on('click', function (e) {
			e.preventDefault();
			$('html,body').animate({
				scrollTop: 0
			}, 700);
		});
	}
	
	
	// Banner 
	
    $('.heading').height( $(window).height() );
	$('.parallaxie').parallaxie();
	
    // LOADER
    $(window).load(function() {
        $("#preloader").on(500).fadeOut();
        $(".preloader").on(600).fadeOut("slow");
    });
	
	

	// Gallery Filter
        var Container = $('.container');
        Container.imagesLoaded(function () {
            var portfolio = $('.gallery-menu');
            portfolio.on('click', 'button', function () {
                $(this).addClass('active').siblings().removeClass('active');
                var filterValue = $(this).attr('data-filter');
                $grid.isotope({
                    filter: filterValue
                });
            });
            var $grid = $('.gallery-list').isotope({
                itemSelector: '.gallery-grid'
            });

        });
	
    // FUN FACTS   

    function count($this) {
        var current = parseInt($this.html(), 10);
        current = current + 50; /* Where 50 is increment */
        $this.html(++current);
        if (current > $this.data('count')) {
            $this.html($this.data('count'));
        } else {
            setTimeout(function() {
                count($this)
            }, 30);
        }
    }
    $(".stat_count, .stat_count_download").each(function() {
        $(this).data('count', parseInt($(this).html(), 10));
        $(this).html('0');
        count($(this));
    });

    // CONTACT
    jQuery(document).ready(function() {
        $('#contactform').submit(function() {
            var action = $(this).attr('action');
            $("#message").slideUp(750, function() {
                $('#message').hide();
                $('#submit')
                    .after('<img src="images/ajax-loader.gif" class="loader" />')
                    .attr('disabled', 'disabled');
                $.post(action, {
                        first_name: $('#first_name').val(),
                        last_name: $('#last_name').val(),
                        email: $('#email').val(),
                        phone: $('#phone').val(),
                        select_service: $('#select_service').val(),
                        select_price: $('#select_price').val(),
                        comments: $('#comments').val(),
                        verify: $('#verify').val()
                    },
                    function(data) {
                        document.getElementById('message').innerHTML = data;
                        $('#message').slideDown('slow');
                        $('#contactform img.loader').fadeOut('slow', function() {
                            $(this).remove()
                        });
                        $('#submit').removeAttr('disabled');
                        if (data.match('success') != null) $('#contactform').slideUp('slow');
                    }
                );
            });
            return false;
        });
    });
	
	
	//Main-Slider		
	$(window).on('load', function() {
		$('.slider-new-2').owlCarousel({
			items: 1,
			navText:['<i class="fa fa-chevron-left"></i>','<i class="fa fa-chevron-right"></i>'],
			nav:true,
			loop: true,
			dots: false,
			autoplay: true,
			autoplayTimeout: 4000,
			animateOut: 'fadeOut',
			responsiveRefreshRate: 0,
			onInitialized: function(event) {
			  centerSlideImages(event);
			},
			onResized: function(event) {
			  centerSlideImages(event);
			},
		});
	});
	
	$('.slider-new-2').on("translate.owl.carousel", function (e) {
		$(".slider-content h2").removeClass("animated fadeInUp").css("opacity", "0");
		$(".slider-content p").removeClass("animated zoomIn").css("opacity", "0");
		$(".slider-content .btn-slider").removeClass("animated fadeInDown").css("opacity", "0");
	});
	$('.slider-new-2').on("translated.owl.carousel", function (e) {
		$(".slider-content h2").addClass("animated fadeInUp").css("opacity", "1");
		$(".slider-content p").addClass("animated zoomIn").css("opacity", "1");
		$(".slider-content .btn-slider").addClass("animated fadeInDown").css("opacity", "1");
	});
	
	
	//count		
	function count($this) {
        var current = parseInt($this.html(), 10);
        current = current + 50; /* Where 50 is increment */
        $this.html(++current);
        if (current > $this.data('count')) {
            $this.html($this.data('count'));
        } else {
            setTimeout(function() {
                count($this)
            }, 30);
        }
    }
    $(".counter-number, .stat_count_download").each(function() {
        $(this).data('count', parseInt($(this).html(), 10));
        $(this).html('0');
        count($(this));
    });

	//NiceScroll	
	$("body").niceScroll({
		cursorcolor:		"#8dbd55",
		cursorwidth: 		"12px",
		cursorborder: 		"0px solid #000",
		scrollspeed: 		80,
		autohidemode: 		true,
		background: 		'#ddd',
		hidecursordelay: 	400,
		cursorfixedheight: 	false,
		cursorminheight: 	200,
		enablekeyboard: 	true,
		horizrailenabled: 	true,
		bouncescroll: 		false,
		smoothscroll: 		true,
		iframeautoresize: 	true,
		touchbehavior: 		false,
		zindex: 9999
	});
	
	

})(jQuery);