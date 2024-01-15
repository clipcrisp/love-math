WinX = 800 
WinY = 800
NumbOfLines = 11
SegmentDistance = (WinX - 100) / (NumbOfLines - 1) 
PointOffsetFromLine = 10
ClosestLine = 0
DrawTempCircle = false
Circles = {}

function love.load()
    love.window.setMode(WinX, WinY)
    love.window.setVSync( 0 )
    for i = 1, NumbOfLines do Circles[i] = false end
end

function love.update(dt)
end

function love.draw()
    drawNumberLine()

    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.mousepressed(x,y,button)
    if IsCircleSetable(x, y) then    
        -- Maybe have a global var for button with a function that will set it to false when it is checked?
        if button == 1 then
            if Circles[ClosestLine + 1] == false then
                Circles[ClosestLine + 1] = true
            else
                Circles[ClosestLine + 1] = false
            end
        end
    end
end

function love.mousemoved(x, y)
    ClosestLine = RoundInt((x - 50) / SegmentDistance)

    IsCircleSetable(x, y)    
end

function drawNumberLine ()
    love.graphics.setLineWidth( 4 )
    love.graphics.line(
        50, WinY/2,  WinX-50, WinY/2
    )

    love.graphics.setLineWidth( 2 )
    local y_top = WinY / 2 - PointOffsetFromLine 
    local y_bottom = WinY / 2 + PointOffsetFromLine 

    for i = 1, NumbOfLines do
        local x_pos = (50 + (i - 1) * SegmentDistance)
        love.graphics.line(
            x_pos, y_top,   x_pos, y_bottom
        )
    end

    if DrawTempCircle == true then
        love.graphics.setColor(1,1,1,0.25)
        love.graphics.circle(
            "fill",
            50 + (ClosestLine * SegmentDistance),
            (WinY / 2) - (PointOffsetFromLine + 20),
            10,
            100
        )
        love.graphics.setColor(1,1,1,1)
    end

    for i, x in pairs(Circles) do
        if x == true then
            love.graphics.circle(
                "fill",
                50 + ((i - 1) * SegmentDistance),
                (WinY / 2) - (PointOffsetFromLine + 20),
                10,
                100
            )
        end
    end
end

function RoundInt(x)
    local xIsNegative = false
    if x < 0 then xIsNegative = true end
    local numb = math.abs(x)
    if numb > (math.floor(numb) + 0.5) then
        if xIsNegative then return math.ceil(numb) * -1 end
        return math.ceil(numb)
    else
        if xIsNegative then return math.floor(numb) * -1 end
        return math.floor(numb)
    end
end

function IsCircleSetable(x, y)
    if not (y > (WinY / 2 + 50) or y < (WinY / 2 - 50)) then
        DrawTempCircle = true
        return true
    else 
        DrawTempCircle = false
        return false
    end
end