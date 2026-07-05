--========================================================--
-- Pilgrammed GUI Library
-- Section Widget
--========================================================--

local Section = {}

------------------------------------------------------------
-- Create Section
------------------------------------------------------------

function Section.Create(Parent, Settings)

    Settings = Settings or {}

    local Name = Settings.Name or "Section"

    --------------------------------------------------------

    local Frame = Instance.new("Frame")

    Frame.Name = Name

    Frame.Parent = Parent

    Frame.Size = UDim2.new(1, -10, 0, 0)

    Frame.AutomaticSize = Enum.AutomaticSize.Y

    Frame.BackgroundColor3 = Color3.fromRGB(45,45,45)

    Frame.BorderSizePixel = 0

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,6)

    --------------------------------------------------------

    local Padding = Instance.new("UIPadding")

    Padding.Parent = Frame

    Padding.PaddingLeft = UDim.new(0,8)
    Padding.PaddingRight = UDim.new(0,8)
    Padding.PaddingTop = UDim.new(0,8)
    Padding.PaddingBottom = UDim.new(0,8)

    --------------------------------------------------------

    local Layout = Instance.new("UIListLayout")

    Layout.Parent = Frame

    Layout.Padding = UDim.new(0,6)

    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    --------------------------------------------------------

    local Title = Instance.new("TextLabel")

    Title.Parent = Frame

    Title.BackgroundTransparency = 1

    Title.Size = UDim2.new(1,0,0,22)

    Title.Font = Enum.Font.GothamBold

    Title.Text = Name

    Title.TextColor3 = Color3.new(1,1,1)

    Title.TextSize = 15

    Title.TextXAlignment = Enum.TextXAlignment.Left

    --------------------------------------------------------

    return {

        Frame = Frame,

        Container = Frame

    }

end

------------------------------------------------------------

return Section
