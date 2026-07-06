--========================================================--
-- Pilgrammed GUI Library
-- Button Widget
--========================================================--

local Button = {}

------------------------------------------------------------
-- Create Button
------------------------------------------------------------

function Button.Create(Parent, Settings)

    Settings = Settings or {}

    local Text = Settings.Text or "Button"

    local Callback = Settings.Callback or function()

    end

    --------------------------------------------------------

    local Object = {}

    --------------------------------------------------------

    local Instance = Instance.new("TextButton")

    Instance.Parent = Parent

    Instance.Size = UDim2.new(1,0,0,30)

    Instance.BackgroundColor3 = Color3.fromRGB(60,60,60)

    Instance.BorderSizePixel = 0

    Instance.AutoButtonColor = false

    Instance.Font = Enum.Font.Gotham

    Instance.Text = Text

    Instance.TextColor3 = Color3.new(1,1,1)

    Instance.TextSize = 14

    Instance.ClipsDescendants = true

    Instance.new("UICorner", Instance).CornerRadius = UDim.new(0,4)

    --------------------------------------------------------
    -- Hover
    --------------------------------------------------------

    Instance.MouseEnter:Connect(function()

        Instance.BackgroundColor3 = Color3.fromRGB(72,72,72)

    end)

    Instance.MouseLeave:Connect(function()

        Instance.BackgroundColor3 = Color3.fromRGB(60,60,60)

    end)

    --------------------------------------------------------
    -- Click
    --------------------------------------------------------

    Instance.MouseButton1Click:Connect(function()

        local Success, Error = pcall(Callback)

        if not Success then

            warn("[Button] ".. tostring(Error))

        end

    end)

    --------------------------------------------------------

    Object.Instance = Instance

    ------------------------------------------------------------
    -- API
    ------------------------------------------------------------

    function Object:SetText(NewText)

        Instance.Text = NewText

    end

    function Object:GetText()

        return Instance.Text

    end

    function Object:SetCallback(NewCallback)

        Callback = NewCallback

    end

    function Object:SetVisible(State)

        Instance.Visible = State

    end

    function Object:Destroy()

        Instance:Destroy()

    end

    --------------------------------------------------------

    return Object

end

------------------------------------------------------------

return Button
