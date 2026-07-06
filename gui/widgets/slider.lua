--========================================================--
-- Pilgrammed GUI Library
-- Slider Widget
--========================================================--

local UserInputService = game:GetService("UserInputService")

local Slider = {}

------------------------------------------------------------
-- Create Slider
------------------------------------------------------------

function Slider.Create(Parent, Settings)

    Settings = Settings or {}

    local Text = Settings.Text or "Slider"

    local Min = Settings.Min or 0

    local Max = Settings.Max or 100

    local Increment = Settings.Increment or 1

    local Value = Settings.Default or Min

    local Callback = Settings.Callback or function()

    end

    --------------------------------------------------------

    Value = math.clamp(Value, Min, Max)

    local Object = {}

    local Dragging = false

    --------------------------------------------------------
    -- Main
    --------------------------------------------------------

    local Frame = Instance.new("Frame")

    Frame.Parent = Parent

    Frame.Size = UDim2.new(1,0,0,52)

    Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)

    Frame.BorderSizePixel = 0

    Instance.new("UICorner",Frame).CornerRadius = UDim.new(0,4)

    --------------------------------------------------------
    -- Title
    --------------------------------------------------------

    local Label = Instance.new("TextLabel")

    Label.Parent = Frame

    Label.BackgroundTransparency = 1

    Label.Position = UDim2.fromOffset(10,4)

    Label.Size = UDim2.new(1,-60,0,18)

    Label.Font = Enum.Font.Gotham

    Label.Text = Text

    Label.TextColor3 = Color3.new(1,1,1)

    Label.TextSize = 14

    Label.TextXAlignment = Enum.TextXAlignment.Left

    --------------------------------------------------------
    -- Value Label
    --------------------------------------------------------

    local ValueLabel = Instance.new("TextLabel")

    ValueLabel.Parent = Frame

    ValueLabel.BackgroundTransparency = 1

    ValueLabel.Position = UDim2.new(1,-55,0,4)

    ValueLabel.Size = UDim2.new(0,45,0,18)

    ValueLabel.Font = Enum.Font.GothamBold

    ValueLabel.TextColor3 = Color3.new(1,1,1)

    ValueLabel.TextSize = 13

    --------------------------------------------------------
    -- Bar
    --------------------------------------------------------

    local Bar = Instance.new("Frame")

    Bar.Parent = Frame

    Bar.Position = UDim2.fromOffset(10,30)

    Bar.Size = UDim2.new(1,-20,0,8)

    Bar.BackgroundColor3 = Color3.fromRGB(35,35,35)

    Bar.BorderSizePixel = 0

    Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

    --------------------------------------------------------
    -- Fill
    --------------------------------------------------------

    local Fill = Instance.new("Frame")

    Fill.Parent = Bar

    Fill.Size = UDim2.new()

    Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)

    Fill.BorderSizePixel = 0

    Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

    --------------------------------------------------------
    -- Update
    --------------------------------------------------------

    local function UpdateVisual()

        local Alpha = (Value - Min) / (Max - Min)

        Fill.Size = UDim2.new(Alpha,0,1,0)

        ValueLabel.Text = tostring(Value)

    end

    local function SetValue(NewValue)

        NewValue = math.clamp(NewValue, Min, Max)

        NewValue = math.floor(NewValue / Increment + 0.5) * Increment

        if NewValue ~= Value then

            Value = NewValue

            UpdateVisual()

            pcall(function()

                Callback(Value)

            end)

        end

    end

    UpdateVisual()

    --------------------------------------------------------
    -- Drag
    --------------------------------------------------------

    Bar.InputBegan:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then

            Dragging = true

        end

    end)

    UserInputService.InputEnded:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then

            Dragging = false

        end

    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then

            return

        end

        if Input.UserInputType ~= Enum.UserInputType.MouseMovement then

            return

        end

        local Alpha = (Input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X

        Alpha = math.clamp(Alpha,0,1)

        SetValue(Min + ((Max-Min) * Alpha))

    end)

    --------------------------------------------------------
    -- API
    --------------------------------------------------------

    Object.Instance = Frame

    function Object:GetValue()

        return Value

    end

    function Object:SetValue(NewValue)

        SetValue(NewValue)

    end

    function Object:SetRange(NewMin, NewMax)

        Min = NewMin

        Max = NewMax

        SetValue(Value)

    end

    function Object:SetText(NewText)

        Label.Text = NewText

    end

    function Object:SetVisible(State)

        Frame.Visible = State

    end

    function Object:SetCallback(NewCallback)

        Callback = NewCallback

    end

    function Object:Destroy()

        Frame:Destroy()

    end

    return Object

end

------------------------------------------------------------

return Slider
