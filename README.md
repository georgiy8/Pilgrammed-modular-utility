# Pilgrammed Modular Utility

A modular Roblox GUI library built for executor environments.

---

# Create Window

```lua
local Window = GUI:CreateWindow({
    Title = "Pilgrammed Utility",
    Width = 650,
    Height = 420
})
```

| Option | Type | Default |
|---------|------|----------|
| Title | string | "Pilgrammed Utility" |
| Width | number | 650 |
| Height | number | 420 |

---

# Create Tab

```lua
local Main = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})
```

| Option | Type |
|---------|------|
| Name | string |
| Icon | string |

---

# Create Section

```lua
local General = Main:CreateSection({
    Name = "General"
})
```

| Option | Type |
|---------|------|
| Name | string |

---

# Label

Displays text.

```lua
General:AddLabel({
    Text = "Hello World"
})
```

Options

| Name | Type | Default |
|------|------|----------|
| Text | string | "Label" |

---

# Button

Creates a clickable button.

```lua
General:AddButton({
    Text = "Print",
    Callback = function()
        print("Hello")
    end
})
```

Options

| Name | Type |
|------|------|
| Text | string |
| Callback | function |

---

# Toggle

Creates an ON/OFF switch.

```lua
General:AddToggle({
    Text = "God Mode",
    Default = false,
    Callback = function(Value)
        print(Value)
    end
})
```

Options

| Name | Type |
|------|------|
| Text | string |
| Default | boolean |
| Callback | function |

---

# Slider

Numeric slider.

```lua
General:AddSlider({
    Text = "WalkSpeed",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        print(Value)
    end
})
```

Options

| Name | Type |
|------|------|
| Text | string |
| Min | number |
| Max | number |
| Default | number |
| Callback | function |

---

# Dropdown

Selection list.

```lua
General:AddDropdown({
    Text = "Weapon",
    Options = {
        "Sword",
        "Bow",
        "Gun"
    },
    Callback = function(Value)
        print(Value)
    end
})
```

Options

| Name | Type |
|------|------|
| Text | string |
| Options | table |
| Callback | function |

---

# Textbox

Text input.

```lua
General:AddTextbox({
    Placeholder = "Type here...",
    Callback = function(Text)
        print(Text)
    end
})
```

Options

| Name | Type |
|------|------|
| Placeholder | string |
| Callback | function |

---

# Keybind

Keyboard shortcut.

```lua
General:AddKeybind({
    Text = "Fly",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("Pressed")
    end
})
```

Options

| Name | Type |
|------|------|
| Text | string |
| Default | Enum.KeyCode |
| Callback | function |

---

# Separator

Horizontal separator.

```lua
General:AddSeparator()
```

No settings required.

---

# Image

Displays an image.

Using getcustomasset:

```lua
General:AddImage({
    Image = getcustomasset("assets/logo.png"),
    Height = 220
})
```

Options

| Name | Type | Default |
|------|------|----------|
| Image | string | "" |
| Height | number | 160 |
| ScaleType | Enum.ScaleType | Fit |
| Transparency | number | 0 |
| BackgroundTransparency | number | 1 |
| BackgroundColor | Color3 | White |

---

# Widget Methods

Every widget returns an object.

Example:

```lua
local Label = General:AddLabel({
    Text = "Loading..."
})

Label:SetText("Finished")
```

Image example:

```lua
local Image = General:AddImage({
    Image = getcustomasset("assets/logo.png")
})

Image:SetImage(getcustomasset("assets/banner.png"))

Image:SetHeight(300)

Image:SetVisible(false)
```

---

# Window Methods

```lua
Window:SetTitle("New Title")

Window:SetSize(800,500)

Window:Show()

Window:Hide()

Window:ToggleMinimize()

Window:ToggleFullscreen()

Window:Close()

Window:Destroy()
```

---

# Tab Methods

```lua
Tab:Select()

Tab:Destroy()

Tab:GetSection("General")
```

---

# Section Methods

```lua
Section:Clear()

Section:Destroy()
```

---

# Assets

Potassium supports custom assets.

Place files inside:

```
assets/
```

Example:

```
assets/
├── logo.png
├── banner.png
├── click.mp3
└── open.wav
```

Image:

```lua
General:AddImage({
    Image = getcustomasset("assets/logo.png")
})
```

Sound:

```lua
local Sound = Instance.new("Sound")
Sound.SoundId = getcustomasset("assets/click.mp3")
Sound:Play()
```

---

# Project Structure

```
gui/
    core.lua
    init.lua

    widgets/
        label.lua
        button.lua
        toggle.lua
        slider.lua
        dropdown.lua
        textbox.lua
        keybind.lua
        separator.lua
        image.lua

    services/
        drag.lua
        resize.lua

modules/
    main.lua
    fishing.lua
    mining.lua

assets/
    logo.png
    banner.png
    click.mp3
```
