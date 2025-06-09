function love.load()
    Grid_x_count = 10
    Grid_y_count = 18
    PieceType = 1
    PieceRotation = 1
    PieceX = 3
    PieceY = 0
    Timer = 0
    love.window.setMode( 301, 541)
    love.graphics.setBackgroundColor(30, 30, 30)
    Inert = {}
    for y = 1, Grid_y_count do
        Inert[y] = {}
        for x = 1, Grid_x_count do
            Inert[y][x] = ' '
        end
    end

    PieceStructures = {
    {
        {
            {' ', ' ', ' ', ' '},
            {'i', 'i', 'i', 'i'},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 'i', ' ', ' '},
            {' ', 'i', ' ', ' '},
            {' ', 'i', ' ', ' '},
            {' ', 'i', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {' ', 'o', 'o', ' '},
            {' ', 'o', 'o', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {'j', 'j', 'j', ' '},
            {' ', ' ', 'j', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 'j', ' ', ' '},
            {' ', 'j', ' ', ' '},
            {'j', 'j', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {'j', ' ', ' ', ' '},
            {'j', 'j', 'j', ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 'j', 'j', ' '},
            {' ', 'j', ' ', ' '},
            {' ', 'j', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {'l', 'l', 'l', ' '},
            {'l', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 'l', ' ', ' '},
            {' ', 'l', ' ', ' '},
            {' ', 'l', 'l', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', ' ', 'l', ' '},
            {'l', 'l', 'l', ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {'l', 'l', ' ', ' '},
            {' ', 'l', ' ', ' '},
            {' ', 'l', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {'t', 't', 't', ' '},
            {' ', 't', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 't', ' ', ' '},
            {' ', 't', 't', ' '},
            {' ', 't', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 't', ' ', ' '},
            {'t', 't', 't', ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 't', ' ', ' '},
            {'t', 't', ' ', ' '},
            {' ', 't', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {' ', 's', 's', ' '},
            {'s', 's', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {'s', ' ', ' ', ' '},
            {'s', 's', ' ', ' '},
            {' ', 's', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {'z', 'z', ' ', ' '},
            {' ', 'z', 'z', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', 'z', ' ', ' '},
            {'z', 'z', ' ', ' '},
            {'z', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
}
end

function love.draw()
    local function drawBlock(block, x, y)
        local colors = {
            [' '] = {.10, .10, .10},
            i = {.47, .76, .94},
            j = {.93, .91, .42},
            l = {.49, .85, .76},
            o = {.92, .69, .47},
            s = {.83, .54, .93},
            t = {.97, .58, .77},
            z = {.66, .83, .46},
        }
        local color = colors[block]
        love.graphics.setColor(color)

        local blockSize = 30
        local blockDrawSize = blockSize - 1
        love.graphics.rectangle(
            'fill',
            (x - 1) * blockSize+1,
            (y - 1) * blockSize+1,
            blockDrawSize,
            blockDrawSize
        )
    end
    for y = 1, 18 do
        for x = 1, 10 do
            drawBlock(Inert[y][x], x, y)
        end
    end
    for y = 1, 4 do
        for x = 1, 4 do
            local block = PieceStructures[PieceType][PieceRotation][y][x]
            if block ~= ' ' then
                drawBlock(block, x + PieceX, y + PieceY)
            end
        end
    end
end

function love.keypressed(key)
    if key == 'x' then
        local testRotation =PieceRotation + 1
        if testRotation > #PieceStructures[PieceType] then
            testRotation = 1
        end

        if CanPieceMove(PieceX, PieceY, testRotation) then
            PieceRotation = testRotation
        end

    elseif key == 'z' then
        local testRotation = PieceRotation - 1
        if testRotation < 1 then
            testRotation = #PieceStructures[PieceType]
        end

        if CanPieceMove(PieceX, PieceY, testRotation) then
            PieceRotation = testRotation
        end

    elseif key == 'left' then
        local testX = PieceX - 1

        if CanPieceMove(testX, PieceY, PieceRotation) then
            PieceX = testX
        end

    elseif key == 'right' then
        local testX = PieceX + 1

        if CanPieceMove(testX, PieceY, PieceRotation) then
            PieceX = testX
        end
    elseif key == 'c' then
        while CanPieceMove(PieceX, PieceY + 1, PieceRotation) do
            PieceY = PieceY + 1
            timer = 0.5
        end
    end
end

function CanPieceMove(testX, testY, testRotation)
    for y = 1, 4 do
            for x = 1, 4 do
                if PieceStructures[PieceType][testRotation][y][x] ~= ' '
                and ((testX + x) < 1 
                or((testX + x) > 10)
                or ((testY + y) > 18)
                or (Inert[testY + y][testX + x] ~= ' '))
                then
                    return false
                end
            end
        end

    return true
end

function love.update(dt)
    Timer = Timer + dt
    if Timer >= 0.5 then
        Timer = 0
        local testY = PieceY + 1
        if CanPieceMove(PieceX, testY, PieceRotation) then
            PieceY = testY
        else
            for y = 1, 4 do
                for x = 1, 4 do
                    local block =
                        PieceStructures[PieceType][PieceRotation][y][x]
                    if block ~= ' ' then
                        Inert[PieceY + y][PieceX + x] = block
                    end
                end
            end
            for y = 1, 18 do
                local complete = true
                for x = 1, 10 do
                    if Inert[y][x] == ' ' then
                        complete = false
                        break
                    end
                end
                
                if complete then
                   for removeY = y, 2, -1 do
                        for removeX = 1, 10 do
                            Inert[removeY][removeX] =
                            Inert[removeY - 1][removeX]
                        end
                    end

                    for removeX = 1, 10 do
                        Inert[1][removeX] = ' '
                    end
                end
            end
            PieceX = 3
            PieceY = 0
            PieceType = love.math.random(7)
            PieceRotation = 1
            if not CanPieceMove(PieceX, PieceY, PieceRotation) then
                love.load()
            end
            
        end

    end
end