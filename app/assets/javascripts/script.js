document.addEventListener("turbolinks:load", function() {
  
  //TOPモーダル
  $('#push').click(function() {
    $('.secret').fadeIn(2500);
  });

  $('#back').click(function() {
    $('.secret').fadeOut(2500);
  });
  
  // FAQのアコーディオン
  $('.faq-list-item').click(function() {
    var $answer = $(this).find('.answer');
    if($answer.hasClass('open')) { 
      $answer.removeClass('open');
      $answer.slideUp();
      $(this).find('span').text('＋');
    } else {
      $answer.addClass('open'); 
　　　$answer.slideDown();
      $(this).find('span').text('ー');
    }
  });
});