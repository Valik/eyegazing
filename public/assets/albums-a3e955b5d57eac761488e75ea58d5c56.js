(function(){$(document).ready(function(){return $(".albums #upload_form input#photo_form_file").change(function(){var o,t,n;return t=$(this).closest("form"),n=new FormData,o=$(this),$.each(o[0].files,function(o,t){return n.append("photo_form[file][]",t)}),t.submit(function(e){return e.preventDefault(),window.throbber.appendTo(t[0]).start(),$.ajax(t.prop("action"),{asynchronous:!0,type:"POST",dataType:"json",data:n,contentType:!1,processData:!1,cache:!1,success:function(n){return o.val(""),$.each(n.photos,function(o,t){var n;return 0===$(".albums .photos-row").length&&$(".albums .content h1.title").after("<div class='photos-row'></div>"),n=$(".albums .photos-row").last(),n.children().length<4?n.append("<div class='photo-container'><div class='photo'><div class='photo-inner-container'><a class='fancybox' rel='gallery1' href='"+t.full+"'><img src='"+t.thumb+"' alt=''/></div></div></div></div>"):n.after("<div class='photos-row'></div>").next().append("<div class='photo-container'><div class='photo'><div class='photo-inner-container'><a class='fancybox' rel='gallery1' href='"+t.full+"'><img src='"+t.thumb+"' alt=''/></div></div></div></div>")}),t.find("canvas").remove()}})}),t.submit(),t.unbind()}),$(".albums .form-video").on("submit",function(){return window.throbber.appendTo($(this)[0]).start()}).on("ajax:success",function(o,t){var n;return $(this).find("canvas").remove(),window.flash_show(t),$(this).find("input").val(""),0===$(".albums .photos-row").length&&$(".albums .content h1.title").after("<div class='photos-row'></div>"),n=$(".albums .photos-row").last(),n.children().length<4?n.append("<div class='photo-container video-container'><div class='photo'><div class='photo-inner-container'><img alt='' src='"+t.video.thumb+"'/> <div class='play'> <div class='triangle'/> </div> <div class='video' data-link='"+t.video.link+"'/></div></div></div></div>"):n.after("<div class='photos-row'></div>").next().append("<div class='photo-container video-container'><div class='photo'><div class='photo-inner-container'><img alt='' src='"+t.video.thumb+"'/> <div class='play'> <div class='triangle'/> </div> <div class='video' data-link='"+t.video.link+"'/></div></div></div></div>")}),$(".albums .photo-container > a.delete").on("ajax:success",function(o,t){switch(t.status){case"photo-deleted":case"video-deleted":return $(this).parent().remove(),window.flash_show(t);case"error":return window.flash_show(t)}}),$(".albums .videos .photo-container .photo").on("click",function(){return $("body").prepend("<div id='overlay'/><div class='embed-video'>"+$(this).find(".video").data("link")+"</div>"),$("#overlay").on("click",function(){return $(".embed-video").remove(),$(this).remove()})}),$(".albums .photo-container > a.photo-update").on("click",function(){var o,t;return t=$(this).data(),$(".albums > .content > .photos").children(".edit-inline-form")[0]||$(".albums > .content > .photos").prepend("<div class='edit-inline-form'> <input class='string optional' id='photo_name' maxlength='255' name='photo[name]' placeholder='\u0417\u0430\u0433\u043e\u043b\u043e\u0432\u043e\u043a...' size='255' type='text'> <input id='photo_commit' name='commit' remote='true' type='submit' value='\u0421\u043e\u0445\u0440\u0430\u043d\u0438\u0442\u044c'> <a>\u0417\u0430\u043a\u0440\u044b\u0442\u044c</a> </div>"),o=$(".albums > .content > .photos > .edit-inline-form"),o.find("input#photo_name").val(t.name),o.find("input#photo_commit").on("click",function(){return $.ajax("/photos/"+t.id,{dataType:"json",type:"PATCH",data:{name:o.find("input#photo_name").val()},success:function(t){var n;return"success"===t.status&&(n=$(".albums > .content > .photos .photo-"+t.id),n.children(".title").text(t.name)),window.flash_show(t),o.remove()}})}),o.children("a").on("click",function(){return o.remove()})})})}).call(this);