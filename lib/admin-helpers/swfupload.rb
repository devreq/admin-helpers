module AdminHelpers::Swfupload
  def swfupload_control
    %{
      <div id="swfupload_control" class="swfupload">
        <input type="button" id="swfupload_button"></input>
      </div>    
    }.html_safe
  end
  
  def swfupload_script(upload_url, *args)
    options = args.extract_options!
    update_id = options.delete(:update_id)
    update_url = options.delete(:update_url)
    
    options.stringify_keys!
    options = options.reverse_merge({
      'upload_url' => upload_url,
      'file_size_limit' => '10240',
      'file_types' => '*.*',
      'file_types_description' => 'Все файлы',
      'file_upload_limit' => '0',
      'flash_url' => '/swfupload.swf',
      'button_image_url' => '/images/swfupload.png',
      'button_width' => '61',
      'button_height' => '22',
      'button_placeholder_id' => "swfupload_button"
    });
    
    options_s = options.to_json
    
    %{
      <div id="loading" class="loading" style="display: none;">
        <div class="progress"><p><b>Загрузка</b></p><div class="-files"</div></div>
      </div>

      <script type="text/javascript">
        $(function() {
          $('#swfupload_control')
            .swfupload(#{options_s})
            .bind('fileQueued', function(event, file) {  
              var size = Math.round(file.size / (1024 * 1024));
              var listitem='<div id="'+file.id+'">' +
              '<p class="name">' + file.name + ' (' + size +' MB)' +
              '<p class="bar"><span style="width: 0%;"></span></p>' +
              '<p><a href="#" class="-cancel">Отмена</a></p>' +
              '</div>';
              $('#loading').show();
              $('#loading .-files').append(listitem);  

              $('#'+file.id+' .-cancel').bind('click', function(){ //Remove from queue on cancel click  
                var swfu = $.swfupload.getInstance('#swfupload_control');  
                swfu.cancelUpload(file.id);  
                $('#'+file.id).slideUp('fast');  
              });
              // start the upload since it's queued  
              $(this).swfupload('startUpload'); 
            }) 
            .bind('fileQueueError', function(event, file, errorCode, message){ 
              alert('Size of the file '+file.name+' is greater than limit'); 
            }) 
            .bind('uploadStart', function(event, file){
              $('#loading #'+file.id).find('a.-cancel').hide(); 
            }) 
            .bind('uploadProgress', function(event, file, bytesLoaded){ 
              var percentage = Math.round((bytesLoaded/file.size)*100); 
              $('#loading #' + file.id).find('p.bar span').css('width', percentage + '%'); 
            }) 
            .bind('uploadSuccess', function(event, file, serverData){ 
              var item = $('#loading #'+file.id+' p.bar').replaceWith('<p class="processing">Обработка...</p>');      
              $('##{update_id}').html(serverData);
            }) 
            .bind('uploadComplete', function(event, file){ 
              // upload has completed, try the next one in the queue 
              $(this).swfupload('startUpload');  
              var stats = $(this).data('__swfu').getStats();
              if (stats.files_queued == 0) {
                $('#loading .-files').html('');
                $('#loading').hide();
              }
            });
        });  
      </script>    
    }.html_safe
  end
end