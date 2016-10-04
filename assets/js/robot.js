$(document).ready(function(){

  var points = {
    'A' : [0, 0],
    'B' : [1, 0],
    'C' : [1, 1],
    'D' : [0, 1]
  };

  var maxX = 5;
  var maxY = 5;

  var placeX,placeY,placeF,coordinat1,coordinat2, report;

  var direction = {
    "north" : {"coordinat1": "D", "coordinat2": "C", "moveX": 0, "moveY": 1, "maxPoint": 5, "f": 1 },
    "west"  : {"coordinat1": "A", "coordinat2": "D", "moveX": -1, "moveY": 0, "maxPoint": 0, "f": 0 },
    "south" : {"coordinat1": "B", "coordinat2": "A", "moveX": 0, "moveY": -1, "maxPoint": 0, "f": 1},
    "east"  : {"coordinat1": "C", "coordinat2": "B", "moveX": 1, "moveY": 0, "maxPoint": 5, "f":  0}
  };

  var keys = Object.keys(direction);

  $('#place-form').submit(function(e){
    e.preventDefault();
    // Get the form data
    var formArray = $(this).serializeArray();
    placeX = parseInt(formArray[0]['value']);
    placeY = parseInt(formArray[1]['value']);
    placeF = formArray[2]['value'];

    if(placeX > maxX || placeY > maxY) return false;

    getCoordinats(placeF);

    // Make buttons clickable
    $('.directionalButton').each(function(){
      $(this).prop("disabled", false);
    });
    alert("Robot Placed");

  });
  // Move Button
  $('#move').click(function(){
    moveCoordinat1 = [parseInt(coordinat1[0]) + direction[placeF]['moveX'] , parseInt(coordinat1[1]) + direction[placeF]['moveY']];
    moveCoordinat2 = [parseInt(coordinat2[0]) + direction[placeF]['moveX'] , parseInt(coordinat2[1]) + direction[placeF]['moveY']];

    if((moveCoordinat1[direction[placeF]['f']] >= 0) && (moveCoordinat1[direction[placeF]['f']] <= 5) ){
      alert('Robot Moved');
      coordinat1 = moveCoordinat1;
      coordinat2 = moveCoordinat2;

      placeX += direction[placeF]['moveX'];
      placeY += direction[placeF]['moveY'];
    }else{
      alert('Robot can not move');
      return false;
    }
  });

  // Directions of the Robot
  $('#right').click(function(){
    var indexF = keys.indexOf(placeF);
    placeF = (indexF-1 == -1) ? keys[keys.length - 1] : keys[indexF -1];
    getCoordinats(placeF);
  });

  $('#left').click(function(){
    var indexF = keys.indexOf(placeF);
    placeF = (indexF + 1 == keys.length) ? keys[0] : keys[indexF + 1];
    getCoordinats(placeF);
  });

  // Display the Report
  $('#report').click(function(){
    $('#report-board').html(placeX+', '+placeY+', '+placeF);
  });

  function getCoordinats(placeF){
    // Get the facing direction points
    coordinat1 = [
      placeX + parseInt(points[direction[placeF]['coordinat1']][0]),
      placeY + parseInt(points[direction[placeF]['coordinat1']][1])
    ];

    coordinat2 = [
      placeX + parseInt(points[direction[placeF]['coordinat2']][0]),
      placeY + parseInt(points[direction[placeF]['coordinat2']][1])
    ];
  }

});
