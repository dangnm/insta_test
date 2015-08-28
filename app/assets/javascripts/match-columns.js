// Init namespace

if (typeof CustomLib == "undefined") {
  CustomLib = {}
}

if (typeof CustomLib.responsive == "undefined") {
  CustomLib.responsive = {}
}

// Constructor
CustomLib.responsive.MatchColumns = function MatchColumns(dom) {
  _this = this;
  // Public attributes
  this.dom = dom;

  // Init
  _this.resizeListener();
}

// Instance methods

CustomLib.responsive.MatchColumns.prototype.resizeListener = function($row) {
  var _this = this;
  var event_code = 'resize.customlib.responsive.match_columns';

  $(window).off(event_code);
  $(window).on(event_code, function(event) { 
    _this.update();
  });
}

CustomLib.responsive.MatchColumns.prototype.getColumns = function($row) {
  var col_classes = ['xs', 'ms', 'sm', 'md', 'lg'];
  var $columns = $();
  for(var col_class_i=0; col_class_i<col_classes.length; col_class_i++){
    for(var cell_size_i=1; cell_size_i<=12; cell_size_i++){
      var column_class = 'col-' + col_classes[col_class_i] + '-' + cell_size_i;
      $.merge($columns, $row.find('> .' + column_class));
    }
  }
  return $columns;
}

CustomLib.responsive.MatchColumns.prototype.bindColumns = function($columns) { 
  var _this = this;
  $columns.each(function(){
    $column = $(this);
    $column.on('DOMSubtreeModified', function(){
      $columns.each(function(){
        _this.matchHeights($columns);
      });
    });
  });
}

CustomLib.responsive.MatchColumns.prototype.matchHeights = function($columns) { 
  var largest_height = 0;
  $columns.each(function(){
    $column = $(this);
    $column.css('height', '');
    var height = $column.height();
    if (height > largest_height) largest_height = height;
  });
  $columns.each(function(){
    $column = $(this);
    $column.height(largest_height);
  });
}

CustomLib.responsive.MatchColumns.prototype.update = function($row) { 
  var _this = this;
  $(_this.dom).filter('[data-match-columns="true"]').hide();
  $(_this.dom).waitForImages().done(function() {
    $(_this.dom).filter('[data-match-columns="true"]').show();
    $(_this.dom).filter('[data-match-columns="true"]').each(function(){
      var $row = $(this);
      $columns = _this.getColumns($row);
      _this.matchHeights($columns);
      _this.bindColumns($columns);
    });
  });
}


// $(document).ready(function() {
//     (function(){
//       function getColumns($row){
//         var col_classes = ['xs', 'ms', 'sm', 'md', 'lg'];
//         var $columns = $();
//         for(var col_class_i=0; col_class_i<col_classes.length; col_class_i++){
//           for(var cell_size_i=1; cell_size_i<=12; cell_size_i++){
//             var column_class = 'col-' + col_classes[col_class_i] + '-' + cell_size_i;
//             $.merge($columns, $row.find('> .' + column_class));
//           }
//         }
//         return $columns;
//       }
//       function bindColumns($columns){
//         $columns.each(function(){
//           $column = $(this);
//           $column.on('DOMSubtreeModified', function(){
//             $columns.each(function(){
//               matchHeights($columns);
//             });
//           });
//         });
//       }
//       function matchHeights($columns){
//         var largest_height = 0;
//         $columns.each(function(){
//           $column = $(this);
//           $column.css('height', '');
//           var height = $column.height();
//           if (height > largest_height) largest_height = height;
//         });
//         $columns.each(function(){
//           $column = $(this);
//           $column.height(largest_height);
//         });
//       }

//       $('[data-match-columns="true"]').each(function(){
//         var $row = $(this);
//         $columns = getColumns($row);
//         matchHeights($columns);
//         bindColumns($columns);
//       });
//     })();
// });
