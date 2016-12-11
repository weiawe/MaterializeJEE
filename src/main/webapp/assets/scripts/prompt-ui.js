var Message = {
		info:function(options){
			var defaults = { message : '', time : undefined, callBack : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			if(!isEmpty(options.time) && options.time>0){
				var c = '<span><i class="mdi-action-info-outline"></i> '+options.message+'</span>';
				Materialize.toast(c,options.time*1000,'deep-purple',options.callBack);
			}else{
				var c = '<span><i class="mdi-action-info-outline"></i> '+options.message+'</span><a class="btn-flat yellow-text data-localize info-close" data-localize="sys.close" style="padding-right: 0px;margin-right: 0px;padding-left: 0px;"></a>';
				Materialize.toast(c,undefined,'deep-purple',options.callBack);
			}
			getLocalize($(".data-localize"));
			
			$(".info-close").on('click',function(){
				$(this).parent().remove();
				var func = options.callBack;
				func();
			});
		},
		notice:function(options){
			var defaults = { message : '', time : undefined, callBack : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			if(!isEmpty(options.time) && options.time>0){
				var c = '<span><i class="mdi-social-notifications"></i> '+options.message+'</span>';
				Materialize.toast(c,options.time*1000,'light-blue',options.callBack);
			}else{
				var c = '<span><i class="mdi-social-notifications"></i> '+options.message+'</span><a class="btn-flat yellow-text data-localize notice-close" data-localize="sys.close" style="padding-right: 0px;margin-right: 0px;padding-left: 0px;"></a>';
				Materialize.toast(c,undefined,'light-blue',options.callBack);
			}
			getLocalize($(".data-localize"));
			
			$(".notice-close").on('click',function(){
				$(this).parent().remove();
				var func = options.callBack;
				func();
			});
		},
		success:function(options){
			var defaults = { message : '', time : undefined, callBack : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			if(!isEmpty(options.time) && options.time>0){
				var c = '<span><i class="mdi-navigation-check"></i> '+options.message+'</span>';
				Materialize.toast(c,options.time*1000,'green',options.callBack);
			}else{
				var c = '<span><i class="mdi-navigation-check"></i> '+options.message+'</span><a class="btn-flat yellow-text data-localize success-close" data-localize="sys.close" style="padding-right: 0px;margin-right: 0px;padding-left: 0px;"></a>';
				Materialize.toast(c,undefined,'green',options.callBack);
			}
			getLocalize($(".data-localize"));
			
			$(".success-close").on('click',function(){
				$(this).parent().remove();
				var func = options.callBack;
				func();
			});
			
		},
		danger:function(options){
			var defaults = { message : '', time : undefined, callBack : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			if(!isEmpty(options.time) && options.time>0){
				var c = '<span><i class="mdi-alert-error"></i> '+options.message+'</span>';
				Materialize.toast(c,options.time*1000,'red',options.callBack);
			}else{
				var c = '<span><i class="mdi-alert-error"></i> '+options.message+'</span><a class="btn-flat yellow-text data-localize danger-close" data-localize="sys.close" style="padding-right: 0px;margin-right: 0px;padding-left: 0px;"></a>';
				Materialize.toast(c,undefined,'red',options.callBack);
			}
			getLocalize($(".data-localize"));
			
			$(".danger-close").on('click',function(){
				$(this).parent().remove();
				var func = options.callBack;
				func();
			});
		},
		warn:function(options){
			var defaults = { message : '', time : undefined, callBack : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			if(!isEmpty(options.time) && options.time>0){
				var c = '<span><i class="mdi-alert-warning"></i> '+options.message+'</span>';
				Materialize.toast(c,options.time*1000,'orange',options.callBack);
			}else{
				var c = '<span><i class="mdi-alert-warning"></i> '+options.message+'</span><a class="btn-flat yellow-text data-localize warn-close" data-localize="sys.close" style="padding-right: 0px;margin-right: 0px;padding-left: 0px;"></a>';
				Materialize.toast(c,undefined,'orange',options.callBack);
			}
			getLocalize($(".data-localize"));
			
			$(".warn-close").on('click',function(){
				$(this).parent().remove();
				var func = options.callBack;
				func();
			});
		},
		custom:function(message,className,html){
			var c = '<span>'+message+'</span>';
			if(!isEmpty(html)){
				c+=html;
			}
			Materialize.toast(c,undefined,className);
			getLocalize($(".data-localize"));
		}
}

var Alert = {
		simple:function(options){
			var defaults = { title : "提示", message : '', className : "cyan" };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			var h='<div id="card-alert" class="modal card '+options.className+'">'
				+'<div class="card-content white-text">'
				+'<span class="card-title white-text darken-1"><i class="mdi-social-notifications"></i>  '+options.title+'</span>'
				+'<p>'+options.message+'</p>'
				+'</div>'
				+'<button type="button" class="close modal-close white-text" data-dismiss="alert" aria-label="Close">'
				+'<span aria-hidden="true">×</span>'
				+'</button>'
				+'</div>';
			$("body").append(h);
			$('#card-alert').openModal();
			getLocalize($(".data-localize"));
		},
		simpleConfirm:function(options){
			var defaults = { title : "提示", message : '', className : "cyan", confirmAction : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			
			var h='<div id="card-alert" class="modal card '+options.className+'">'
				+'<div class="card-content white-text">'
				+'<span class="card-title white-text darken-1"><i class="mdi-social-notifications"></i>  '+options.title+'</span>'
				+'<p>'+options.message+'</p>'
				+'</div>'
				+'<div class="card-action '+options.className+' darken-2">'
				+'<a id="card-alert-confirm" class="btn-flat waves-effect green white-text"><i class="mdi-navigation-check left"></i> <span class="data-localize" data-localize="sys.confirm"></span></a>'
				+'<a class="btn-flat waves-effect red accent-2 white-text modal-close"><i class="mdi-content-clear left"></i> <span class="data-localize" data-localize="sys.close"></span></a>'
            	+'</div>'
            	+'<button type="button" class="close modal-close white-text" data-dismiss="alert" aria-label="Close">'
            	+'<span aria-hidden="true">×</span>'
            	+'</button>'
            	+'</div>';
			$("body").append(h);
			$('#card-alert').openModal();
			getLocalize($(".data-localize"));
			
			$('#card-alert-confirm').on('click',function(){
				var func = options.confirmAction;
				if(func()){
					$(".modal-close").click();
				}
			});
		},
		sweetConfirm:function(options){
			//var types = ['success', 'error', 'warning', 'info'];
			var defaults = { title : "提示", 
							 message : '', 
							 type : 'info', 
							 showCancelButton : true, 
							 confirmButtonColor : "#DD6B55", 
							 confirmButtonText: "确认",
							 closeOnConfirm: false,
							 confirmAction : function(){return true} };
		   	if(!options) {
		   		options = {};
		  	}
		  	options = $.extend({}, defaults, options);
			swal({title: options.title,
	              text: options.message,   
	              type: options.type,    
	              showCancelButton: options.showCancelButton,   
	              confirmButtonColor: options.confirmButtonColor,   
	              confirmButtonText: options.confirmButtonText,   
	              closeOnConfirm: options.closeOnConfirm }, 
	              function(){
	            	  var func = options.confirmAction;
	            	  if(func()){
	            		  swal("操作成功", '', "success"); 
	            	  }else{
	            		  swal("操作失败", '', "error"); 
	            	  }
	              });
		},
		AjaxConfirm:function(options){
			var defaults = { title : "提示", 
					 		 message : '', 
					 		 type : 'info', 
					 		 showCancelButton : true, 
					 		 closeOnConfirm: false,
					 		 showLoaderOnConfirm: true,
					 		 ajaxOptions:{
					 			 url : '',
					 			 data : {},
					 			 type: 'POST',
					 			 async : false,
					 			 cache : false,
					 			 global : false,
					 			 timeout : 30 * 1000,
					 			 dataType : 'json',
					 			 successCallBack:function(){return true}
					 		 }};
		  	if(!options) {
		  		options = {};
		 	}
		 	options = $.extend({}, defaults, options);
			swal({title: options.title,   
                  text: options.message,   
                  type: options.type,   
                  showCancelButton: options.showCancelButton,   
                  closeOnConfirm: options.closeOnConfirm,   
                  showLoaderOnConfirm: options.showLoaderOnConfirm }, 
                  function(){   
                		$.ajax({
                			url : options.ajaxOptions.url,
                			data : options.ajaxOptions.data,
                			async : options.ajaxOptions.async,
                			cache : options.ajaxOptions.cache,
                			global : options.ajaxOptions.global,
                			timeout : options.ajaxOptions.timeout,
                			dataType : options.ajaxOptions.dataType,
                			success : function(data, status, request) {
                				if(data.status==1){
                					var func = options.ajaxOptions.successCallBack;
                					if(func()){
                						swal("操作成功！");
                					}
                				}else{
                					var info = data.info;
                					swal((isEmpty(info)?"操作失败！":info));
                				}
                			},
                			error : function(XMLHttpRequest, status, thrownError) {
            					if(status == "timeout"){
            						swal("请求超时！");
            					}
            					swal("操作失败！");
            				}
                		});
           });
		}
}