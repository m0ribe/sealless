$(function(){
  $('.Approve').hide();
  $('button').click(function(){
    $('#Request').removeClass("Active");
    $('#Approve').removeClass("Active");
    
    // クリックしたタブにactiveクラスを追加
    $(this).addClass("Active");
    $('.Request').hide();
    $('.Approve').hide();
    var tab = $(this).attr('id');
    const str = ('.' + tab);
    $(str).show();
    // クリックしたタブに対応するshowクラスを追加する
    // $(".content").removeClass("show").eq(index).addClass("show");
  })
})