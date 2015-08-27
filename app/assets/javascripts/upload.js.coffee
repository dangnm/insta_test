# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(() ->
  $('#photo_uploader').fileupload
    dataType: 'script'
    add: (e, data) ->
      reader = new FileReader
      reader.onload = (e) ->
        $('#photo_uploader').find('.preview').find('img').attr 'src', e.target.result
        return
      reader.readAsDataURL data.files[0]

      $('#photo_uploader').find('.file-preview').find('.name').text(data.files[0].name)

      $('#photo_uploader').find('.submit').off('click').on 'click', ->
        types = /(\.|\/)(jpeg|jpg|png)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          data.submit()
        else
          alert("#{file.name} is not a gif, jpg or png image file")
        return
    progress: (e, data) ->
      return
    replaceFileInput: true
  return
)