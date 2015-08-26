jQuery ->
  new window.CarrierWaveCropper()

class window.CarrierWaveCropper
  constructor: ->
    $('#photo_data_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 200, 200]
      onSelect: @update
      onChange: @update
      bgColor: 'transparent'
      bgOpacity: .4

  update: (coords) =>
    $('#photo_data_crop_x').val(coords.x)
    $('#photo_data_crop_y').val(coords.y)
    $('#photo_data_crop_w').val(coords.w)
    $('#photo_data_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#photo_data_previewbox').css
      width: Math.round(100/coords.w * $('#photo_data_cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#photo_data_cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
