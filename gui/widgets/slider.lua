--========================================================--
-- Pilgrammed GUI Library
-- Slider Widget
--========================================================--

local UserInputService = game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

------------------------------------------------------------
-- Create
------------------------------------------------------------

function Slider.Create(Parent, Settings)

    Settings = Settings or {}

    local self = setmetatable({}, Slider)

    self.Min = Settings.Min or 0
    self.Max = Settings.Max or 100
    self.Increment = Settings.Increment or 1
    self.Value = Settings.Default or self.Min

    self.Text = Settings.Text or "Slider"

    self.Callback = Settings.Callback or function() end

    self.Value = math.clamp(self.Value, self.Min, self.Max)

    --------------------------------------------------------
    -- Main
    --------------------------------------------------------

    local Frame = Instance.new("Frame")
    Frame.Name = "Slider"
    Frame.Parent = Parent
    Frame.Size = UDim2.new(1,-10,0,56)
    Frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Frame.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,6)
    Corner.Parent = Frame

    --------------------------------------------------------
    -- Title
    --------------------------------------------------------

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0,10,0,6)
    Label.Size = UDim2.new(1,-70,0,18)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Text = self.Text

    --------------------------------------------------------
    -- Value
    --------------------------------------------------------

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Frame
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.AnchorPoint = Vector2.new(1,0)
    ValueLabel.Position = UDim2.new(1,-10,0,6)
    ValueLabel.Size = UDim2.new(0,50,0,18)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 14
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.TextColor3 = Color3.new(1,1,1)

    --------------------------------------------------------
    -- Bar
    --------------------------------------------------------

    local Bar = Instance.new("Frame")
    Bar.Parent = Frame
    Bar.Position = UDim2.new(0,10,0,34)
    Bar.Size = UDim2.new(1,-20,0,8)
    Bar.BorderSizePixel = 0
    Bar.BackgroundColor3 = Color3.fromRGB(35,35,35)

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1,0)
    BarCorner.Parent = Bar

    --------------------------------------------------------
    -- Fill
    --------------------------------------------------------

    local Fill = Instance.new("Frame")
    Fill.Parent = Bar
    Fill.Size = UDim2.new(0,0,1,0)
    Fill.BorderSizePixel = 0
    Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1,0)
    FillCorner.Parent = Fill

    --------------------------------------------------------
    -- Knob
    --------------------------------------------------------

    local Knob = Instance.new("Frame")
    Knob.Parent = Bar
    Knob.Size = UDim2.fromOffset(14,14)
    Knob.AnchorPoint = Vector2.new(0.5,0.5)
    Knob.Position = UDim2.new(0,0,0.5,0)
    Knob.BorderSizePixel = 0
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1,0)
    KnobCorner.Parent = Knob

    --------------------------------------------------------
    -- Internal
    --------------------------------------------------------

    self.Instance = Frame
    self.Label = Label
    self.ValueLabel = ValueLabel
    self.Bar = Bar
    self.Fill = Fill
    self.Knob = Knob

    local Dragging = false

    local function UpdateVisual()

        local Alpha = (self.Value - self.Min) / (self.Max - self.Min)

        Fill.Size = UDim2.new(Alpha,0,1,0)

        Knob.Position = UDim2.new(Alpha,0,0.5,0)

        ValueLabel.Text = tostring(self.Value)

    end

    local function SetValue(NewValue)

        NewValue = math.clamp(NewValue,self.Min,self.Max)

        NewValue = math.floor(NewValue/self.Increment+0.5)*self.Increment

        if NewValue == self.Value then
            return
        end

        self.Value = NewValue

        UpdateVisual()

        pcall(function()
            self.Callback(self.Value)
        end)

    end

    self._UpdateVisual = UpdateVisual
    self._SetValue = SetValue

    UpdateVisual()

        --------------------------------------------------------
    -- Mouse
    --------------------------------------------------------

    local function UpdateFromMouse(MouseX)

        local Alpha = (MouseX - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X

        Alpha = math.clamp(Alpha,0,1)

        SetValue(self.Min + ((self.Max - self.Min) * Alpha))

    end

    Bar.InputBegan:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then

            Dragging = true

            UpdateFromMouse(Input.Position.X)

        end

    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        UpdateFromMouse(Input.Position.X)

    end)

    UserInputService.InputEnded:Connect(function(Input)

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then

            Dragging = false

        end

    end)

    --------------------------------------------------------
    -- API
    --------------------------------------------------------

    function self:GetValue()

        return self.Value

    end

    function self:SetValue(Value)

        SetValue(Value)

    end

    function self:SetRange(Min, Max)

        self.Min = Min
        self.Max = Max

        SetValue(self.Value)

    end

    function self:SetMin(Value)

        self.Min = Value

        SetValue(self.Value)

    end

    function self:SetMax(Value)

        self.Max = Value

        SetValue(self.Value)

    end

    function self:SetIncrement(Value)

        self.Increment = math.max(Value,1)

        SetValue(self.Value)

    end

    function self:SetText(Text)

        self.Text = Text

        Label.Text = Text

    end

    function self:SetVisible(State)

        Frame.Visible = State

    end

    function self:SetEnabled(State)

        Bar.Active = State

        Knob.Visible = State

    end

    function self:SetCallback(Callback)

        self.Callback = Callback or function() end

    end

    function self:SetFillColor(Color)

        Fill.BackgroundColor3 = Color

    end

    function self:SetBarColor(Color)

        Bar.BackgroundColor3 = Color

    end

    function self:SetKnobColor(Color)

        Knob.BackgroundColor3 = Color

    end

    function self:SetTextColor(Color)

        Label.TextColor3 = Color

    end

    function self:SetValueColor(Color)

        ValueLabel.TextColor3 = Color

    end

    function self:Destroy()

        Frame:Destroy()

    end

    return self

end

------------------------------------------------------------

return Slider
