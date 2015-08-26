# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(() ->
  $('#photo_uploader').fileupload
    dataType: 'script'
    add: (e, data) ->
      $('#photo_uploader').find('.submit').off('click').on 'click', ->
        types = /(\.|\/)(gif|jpeg|jpg|png)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          data.submit()
        else
          alert("#{file.name} is not a gif, jpg or png image file")
        return
    progress: (e, data) ->
      return
  return
)