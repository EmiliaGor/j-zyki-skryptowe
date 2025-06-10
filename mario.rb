require 'ruby2d'

# Define a square shape.
@square = Square.new(x: 20, y: 600, size: 25, color: 'blue')

# Define the initial speed (and direction).
@x_speed = 0
@y_speed = 0
@gravity = 0.2
set title: "Merio"
set width: 1000
set height: 750
Rectangle.new(
  x: 0, y: 700,
  width: 500, height: 50,
  color: 'teal',
  z: 20
)
yel = Rectangle.new(
  x: 175, y: 625,
  width: 50, height: 75,
  color: 'yellow',
  z: 100
)
Rectangle.new(
  x: 550, y: 700,
  width: 450, height: 50,
  color: 'teal',
  z: 20
)
Line.new(
  x1: 900, y1: 0,
  x2: 900, y2: 750,
  width: 5,
  color: 'red',
  z: 10
)

lb = false
rb = false
tick = 0
update do
  rb=false
  lb=false
  @square.y += @y_speed
  @square.x += @x_speed
  if @x_speed != 0
    @x_speed = @x_speed/1.05
  end
  if @square.y > 672 and (@square.x<500 or @square.x>550)
    @y_speed = 0
  else
    @y_speed += @gravity
  end
  if @square.y>710
    Text.new('Game over')
        tick += 1
        if tick == 120
            close
        end
  end
  if @square.x>900
    Text.new('you won!')
        tick += 1
        if tick == 120
            close
        end
    end

  if @square.x > (yel.x - yel.width/2) and @square.y >(yel.y - yel.height/2+15)and @square.x < (yel.x + yel.width)#and @square.x < yel.x + yel.width
    rb = true
    lb = true
    @x_speed = 0
  end
if @square.x > (yel.x - yel.width/2) and @square.y > (yel.y-yel.height/2)+10 and @square.y < (yel.y-yel.height/2)+12 and @square.x  < (yel.x + yel.width)
    @y_speed = 0
end
# print(@square.y)
# print ("a")
    
  end
    on :key do |event|
        if event.key == 'a' and !lb
            @x_speed = -2
        elsif event.key == 'd' and !rb
            @x_speed = 2
        elsif event.key == 'x' 
            close
        end
        if event.key == 'w'
            if @y_speed == 0 and @square.y<710
                @y_speed = -6
            end
        end

end

show