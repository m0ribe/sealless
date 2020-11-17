$(function(){
  $('.Form__Document').hide();
  $('button').click(function(){
    $('#Admission').removeClass("Active");
    $('#Document').removeClass("Active");
    
    // クリックしたタブにactiveクラスを追加
    $(this).addClass("Active");
    $('.Form__Admission').hide();
    $('.Form__Document').hide();
    var tab = $(this).attr('id');
    const str = ('.Form__' + tab);
    $(str).show();
    // クリックしたタブに対応するshowクラスを追加する
    // $(".content").removeClass("show").eq(index).addClass("show");
  })
})