/*********************************************************************************
	Template Name: Porta - Free Bootstrap4 Minimal Portfolio Template
	Template URI: https://demo.curlyarts.com/porta/
	Description: Porta is a Bootstrap4 minimal portfolio template by CurlyArts, absolutely free for download !
	Author: CurlyArts
	Author URI: https://curlyarts.com/
	Version: 1.0

	Note: This is active js

**********************************************************************************/
/*===============================================================================*/

(function ($) {
	'use strict';


	/* Scroll Up Activation */
	$.scrollUp({
		scrollText: '<i class="icofont icofont-rounded-up"></i>',
		easingType: 'linear',
		scrollSpeed: 900,
		animation: 'slide'
	});



	/* Portfolio Active */
	var isotopFilter = $('.portfolio-filters');
	var isotopGrid = $('.portfolios:not(.portfolios-slider-active)');
	var isotopGridItemSelector = $('.portfolio-single');
	var isotopGridItem = '.portfolio-single';

	isotopFilter.find('button:first-child').addClass('active');

	//Images Loaded
	isotopGrid.imagesLoaded(function () {
		/*-- init Isotope --*/
		var initial_items = isotopGrid.data('show');
		var next_items = isotopGrid.data('load');
		var loadMoreBtn = $('.load-more-toggle');

		var $grid = isotopGrid.isotope({
			itemSelector: isotopGridItem,
			layoutMode: 'masonry',
		});

		/*-- Isotop Filter Menu --*/
		isotopFilter.on('click', 'button', function () {
			var filterValue = $(this).attr('data-filter');

			isotopFilter.find('button').removeClass('is-checked');
			$(this).addClass('is-checked');

			// use filterFn if matches value
			$grid.isotope({
				filter: filterValue
			});
		});

		/*-- Update Filter Counts --*/
		function updateFilterCounts() {
			// get filtered item elements
			var itemElems = $grid.isotope('getFilteredItemElements');

			if (isotopGridItemSelector.hasClass('hidden')) {
				isotopGridItemSelector.removeClass('hidden');
			}

			var index = 0;

			$(itemElems).each(function () {
				if (index >= initial_items) {
					$(this).addClass('hidden');
				}
				index++;
			});

			$grid.isotope('layout');
		}

		/*-- Function that Show items when page is loaded --*/
		function showNextItems(pagination) {
			var itemsMax = $('.hidden').length;
			var itemsCount = 0;

			$('.hidden').each(function () {
				if (itemsCount < pagination) {
					$(this).removeClass('hidden');
					itemsCount++;
				}
			});

			if (itemsCount >= itemsMax) {
				loadMoreBtn.hide();
			}

			$grid.isotope('layout');
		}

		/*-- Function that hides items when page is loaded --*/
		function hideItems(pagination) {
			var itemsMax = $(isotopGridItem).length;
			var itemsCount = 0;

			$(isotopGridItem).each(function () {
				if (itemsCount >= pagination) {
					$(this).addClass('hidden');
				}
				itemsCount++;
			});

			if (itemsCount < itemsMax || initial_items >= itemsMax) {
				loadMoreBtn.hide();
			}

			$grid.isotope('layout');
		}

		/*-- Function that Load items when Button is Click --*/
		loadMoreBtn.on('click', function (e) {
			e.preventDefault();
			showNextItems(next_items);
		});

		hideItems(initial_items);
	});



	// Portfolio popup with zoom button
	$('.portfolios-zoom-button-holder').lightGallery({
		selector: '.portfolio-zoom-trigger',
		thumbnail: false
	});


	// Single Portfolio Gallery Slider Active
	$('.pg-portfolio-images').slick({
		dots: false,
		infinite: true,
		speed: 300,
		autoplay: false,
		arrows: true,
		prevArrow: '<span class="cr-slider-nav cr-slider-nav-left"><i class="icofont icofont-simple-left"></i></span>',
		nextArrow: '<span class="cr-slider-nav cr-slider-nav-right"><i class="icofont icofont-simple-right"></i></span>',
	});

	
	// Portfolio Details Image Popup
	$('.pg-portfolio-images').lightGallery({
		selector: 'a',
		thumbnail: true
	});

	
	/* CounterUp Active */
	$('.counter-active').counterUp({
		delay: 10,
		time: 1000
	});


	/* Mobile Menu */
	$('.header-style nav.menu').meanmenu({
		meanMenuClose: '<i class="icofont icofont-close"></i>',
		meanMenuCloseSize: '18px',
		meanScreenWidth: '991',
		meanExpandableChildren: true,
		meanMenuContainer: '.mobile-menu',
		onePage: true
	});
	
})(jQuery);