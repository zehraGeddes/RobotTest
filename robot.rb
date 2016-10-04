$placeX = $placeY = -1
$coordinat1 = $coordinat2 = []
$placeD = ""
$points = {
  'A' => [0, 0],
  'B' => [1, 0],
  'C' => [1, 1],
  'D' => [0, 1]
}
$direction = {
  "north" => {"coordinat1" => "D", "coordinat2" => "C", "moveX" => 0, "moveY" => 1, "maxPoint" => 5, "f" => 1 },
  "west"  => {"coordinat1" => "A", "coordinat2" => "D", "moveX" => -1, "moveY" => 0, "maxPoint" => 0, "f" => 0 },
  "south" => {"coordinat1" => "B", "coordinat2" => "A", "moveX" => 0, "moveY" => -1, "maxPoint" => 0, "f" => 1},
  "east"  => {"coordinat1" => "C", "coordinat2" => "B", "moveX" => 1, "moveY" => 0, "maxPoint" => 5, "f" =>  0}
}
class Robot

  def prompt_conversation
    print "> "
  end

  def get_origin(c, c_value)
    until ( !c_value.nil? && Array(0..4).include?(c_value) && (c_value.is_a? Integer))
      prompt_conversation
      puts "Enter "+c+" position"
      c_value = gets.chomp.to_i
    end
    return c_value
  end

  def get_originDirection(d_value)
    puts "Choose direction, NORTH, WEST, SOUTH or EAST"
    d_value = gets.chomp.downcase
    until ( $direction.keys.include?(d_value) )
      if !d_value.nil?
        prompt_conversation
        puts "Invalid input"
      end
      d_value = gets.chomp.downcase
    end
    $placeD = d_value
  end

  def getCoordinats(d)
    # Get the facing direction points
    $coordinat1 = [
      $placeX + ($points[$direction[d]['coordinat1']][0]).to_i,
      $placeY + ($points[$direction[d]['coordinat1']][1]).to_i,
    ]

    $coordinat2 = [
      $placeX + ($points[$direction[d]['coordinat2']][0]).to_i,
      $placeY + ($points[$direction[d]['coordinat2']][1]).to_i,
    ]
  end

  def placeRobot
    puts "Please enter coordinates between 0 to 4."
    $placeX = get_origin("X", nil)
    $placeY = get_origin("Y", nil)
    get_originDirection($placeD)
    getCoordinats($placeD)
  end

  def promptPlace
    puts "Please place the robot first"
    return false
    commands
  end

  def moveRobot
      $moveCoordinat1 = [$coordinat1[0] + $direction[$placeD]['moveX'] , $coordinat1[1] + $direction[$placeD]['moveY']]
      $moveCoordinat2 = [$coordinat2[0] + $direction[$placeD]['moveX'] , $coordinat2[1] + $direction[$placeD]['moveY']]

      if(($moveCoordinat1[$direction[$placeD]['f']] >= 0) && ($moveCoordinat1[$direction[$placeD]['f']] <= 5) )
        $coordinat1 = $moveCoordinat1;
        $coordinat2 = $moveCoordinat2;

        $placeX += $direction[$placeD]['moveX'];
        $placeY += $direction[$placeD]['moveY'];
      else
        puts "Robot cannot move"
      end
  end

  def getIndex
    return ($direction.keys).index($placeD);
  end

  def dKeys
    return $direction.keys
  end

  def leftRobot
    indexD = getIndex
    $placeD = (indexD + 1 == dKeys.size) ? dKeys[0] : dKeys[indexD + 1];
    getCoordinats($placeD);
  end

  def rightRobot
    indexD = getIndex
    $placeD = (indexD-1 == -1) ? dKeys[(dKeys).size - 1] : dKeys[indexD -1];
    getCoordinats($placeD);
  end

  def reportRobot
    puts "#{$placeX}, #{$placeY}, #{$placeD}"
  end

  def isPlaced
    if (Array(0..4).include?($placeX) && Array(0..4).include?($placeY))
      return true
    end
  end

  def commands
    puts "You can control the robot by entering PLACE, MOVE, LEFT, RIGHT and REPORT commands"

    case gets.chomp.upcase
      when "PLACE" then placeRobot
      when "MOVE" then (if isPlaced then moveRobot end)
      when "LEFT" then (if isPlaced then leftRobot end)
      when "RIGHT" then (if isPlaced then rightRobot end)
      when "REPORT" then (if isPlaced then reportRobot end)
    end

    commands
  end

  def init
    prompt_conversation
    puts "Hi! Welcome to the Robot Test."

    puts "First you need to PLACE the robot."

    commands
  end

end
object = Robot.new
object.init
