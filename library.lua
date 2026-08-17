-- Variables
    local cloneref = cloneref or function(Object)
        return Object
    end

    local ServiceCache = {};
    getgenv().Services = setmetatable({}, {__index = function(Self, Index)
        if not ServiceCache[Index] then
            ServiceCache[Index] = cloneref(game:GetService(Index));
        end;

        return ServiceCache[Index];
    end});

    local Keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }

    local Workspace = Services.Workspace
    local Camera = cloneref(Workspace.CurrentCamera)
    local LocalPlayer = cloneref(Services.Players.LocalPlayer)
    local GuiInset = Services.GuiService:GetGuiInset().Y
    local Mouse = cloneref(LocalPlayer:GetMouse())

    for _, Effect in Services.Lighting:GetChildren() do
        if Effect:IsA("BlurEffect") or Effect:IsA("DepthOfFieldEffect") then
            Effect:Destroy()
        end
    end
--

if getgenv().Library and getgenv().Library.Unload then
    getgenv().Library:Unload()
end

getgenv().Library = {
    Directory = "sonata",
    Folders = {
        "/Fonts",
        "/Configs",
        "/Themes",
		"/Hitsounds",
        "/Assets"
    },

    Flags = {};
    ConfigFlags = {};
    Connections = {};
    Threads = {};
    Notifications = {Notifs = {}};
    Keybinds = {};
    Mods = {};
    SearchIndex = {};
    Tabs = {};

    OpenElement = {};

    EasingStyle = Enum.EasingStyle.Quint;
    EasingDirection = Enum.EasingDirection.InOut;
    TweeningSpeed = .3;
    DraggingSpeed = .05;
    Tweening = false;
}; do
	local Library = getgenv().Library
	Library.__index = Library

    local HEADER_H = 54
    local SIDE_W = 128
    local BOTTOM_H = 44
    local CONTENT_PAD = 8

    for _,path in Library.Folders do
        makefolder(Library.Directory .. path)
    end

    if not isfile(Library.Directory.."/Autoload.txt") then
        writefile(Library.Directory.."/Autoload.txt", "")
    end

    if not isfile(Library.Directory.."/DefaultTheme.txt") then
        writefile(Library.Directory.."/DefaultTheme.txt", "")
    end

    local Flags = Library.Flags
    local ConfigFlags = Library.ConfigFlags
    local Notifications = Library.Notifications

    local Themes = {
        Preset = {
            ["Accent"] = Color3.fromRGB(107, 102, 162),
            ["Line"] = Color3.fromRGB(107, 102, 162),
            ["ElementBackground"] = Color3.fromHex("36363c"),
            ["SectionBackground"] = Color3.fromHex("28282e"),
            ["ElementOutline"] = Color3.fromHex("4c4c54"),
            ["Inline"] = Color3.fromHex("28282e"),
            ["Other"] = Color3.fromHex("323238"),
            ["TabButtons"] = Color3.fromRGB(107, 102, 162),
            ["Unselected"] = Color3.fromHex("b0b0b8"),
            ["UnselectedElement"] = Color3.fromHex("a8a8b0"),
            ["SelectedMultiTabText"] = Color3.fromHex("f0f0f4"),
            ["Element Text"] = Color3.fromHex("b0b0b8"),
            ["Inlines"] = Color3.fromHex("323238"),
            ["ListBackground"] = Color3.fromHex("1a1a1e"),
            ["TextColor"] = Color3.fromHex("ececf0"),
            ["Background"] = Color3.fromHex("16161a"),
            ["TopBar"] = Color3.fromHex("2e2e34"),
            ["BottomBar"] = Color3.fromHex("2e2e34"),
            ["SideBar"] = Color3.fromHex("222228"),
            ["Font"] = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        };
        Utility = {};
    }

    local Fonts = {
        Bold = Themes.Preset.Font;
        Elements = Themes.Preset.Font;
    }; do
        for Theme, Color in Themes.Preset do
            if Theme == "Font" or Theme == "font" then
                continue
            end

            Themes.Utility[Theme] = {
                BackgroundColor3 = {};
                TextColor3 = {};
                ImageColor3 = {};
                ScrollBarImageColor3 = {};
                Color = {};
            }
        end

        Library.GetContrastingText = function(self, Background)
            if typeof(Background) ~= "Color3" then
                return Color3.fromRGB(245, 245, 245)
            end

            local Luminance = (0.2126 * Background.R) + (0.7152 * Background.G) + (0.0722 * Background.B)
            if Luminance > 0.55 then
                return Color3.fromRGB(24, 24, 28)
            end

            return Color3.fromRGB(245, 245, 245)
        end

        Library.SyncWatermarkStyle = function(self)
            local Window = Library.Window
            if not (Window and Window.Items and Window.Items.Watermark and Window.Items.Watermark.Instance) then
                return
            end

            local Background = Themes.Preset.TopBar
            Window.Items.Watermark.Instance.BackgroundColor3 = Background

            if Window.Items.Title and Window.Items.Title.Instance then
                Window.Items.Title.Instance.TextColor3 = Library:GetContrastingText(Background)
            end
        end

        Library.Themify = function(self, Theme, Property)
            table.insert(Themes.Utility[Theme][Property], self.Instance)

            return self
        end

        Library.Refresh = function(self, Theme, Color)
            for Property, Data in Themes.Utility[Theme] do
                for _,Object in Data do
                    if (Property == "Color" or property == "Transparency") and not (Object:IsA("UIStroke") or Object:IsA("UIGradient")) then
                        continue
                    end

                    if (Object[Property] == Themes.Preset[Theme]) then
                        Object[Property] = Color
                    end
                end
            end

            Themes.Preset[Theme] = Color

            if Theme == "TopBar" and Library.SyncWatermarkStyle then
                Library:SyncWatermarkStyle()
            end
        end

        local function ThemePack(Accent, Content, Side, Chrome, Group, Outline)
            return {
                Accent = Accent;
                Line = Accent;
                Background = Content;
                SideBar = Side;
                TopBar = Chrome;
                BottomBar = Chrome;
                SectionBackground = Group;
                ElementBackground = Color3.fromRGB(
                    math.clamp(math.floor(Chrome.R * 255) + 8, 0, 255),
                    math.clamp(math.floor(Chrome.G * 255) + 8, 0, 255),
                    math.clamp(math.floor(Chrome.B * 255) + 8, 0, 255)
                );
                ElementOutline = Outline or Color3.fromRGB(72, 72, 80);
                Inline = Group;
                Other = Chrome;
                TabButtons = Accent;
                Inlines = Color3.fromRGB(
                    math.clamp(math.floor(Group.R * 255) + 6, 0, 255),
                    math.clamp(math.floor(Group.G * 255) + 6, 0, 255),
                    math.clamp(math.floor(Group.B * 255) + 6, 0, 255)
                );
                ListBackground = Color3.fromRGB(
                    math.clamp(math.floor(Content.R * 255) + 4, 0, 255),
                    math.clamp(math.floor(Content.G * 255) + 4, 0, 255),
                    math.clamp(math.floor(Content.B * 255) + 4, 0, 255)
                );
                TextColor = Color3.fromRGB(236, 236, 240);
                Unselected = Color3.fromRGB(176, 176, 184);
                UnselectedElement = Color3.fromRGB(168, 168, 176);
                SelectedMultiTabText = Color3.fromRGB(240, 240, 244);
                ["Element Text"] = Color3.fromRGB(176, 176, 184);
            }
        end

        local function SnapshotPreset()
            local Colors = {}
            for Key, Value in Themes.Preset do
                if Key ~= "Font" and typeof(Value) == "Color3" then
                    Colors[Key] = Value
                end
            end
            return Colors
        end

        Library.BuiltInThemes = {
            ["Sonata"] = SnapshotPreset();
            ["Neverlose"] = ThemePack(Color3.fromRGB(0, 168, 243), Color3.fromRGB(10, 12, 16), Color3.fromRGB(18, 22, 30), Color3.fromRGB(26, 32, 42), Color3.fromRGB(16, 20, 28), Color3.fromRGB(36, 48, 62));
            ["Primordial"] = ThemePack(Color3.fromRGB(255, 176, 198), Color3.fromRGB(14, 14, 18), Color3.fromRGB(26, 24, 34), Color3.fromRGB(34, 32, 44), Color3.fromRGB(22, 20, 30), Color3.fromRGB(86, 56, 72));
            ["Gamesense"] = ThemePack(Color3.fromRGB(163, 197, 71), Color3.fromRGB(12, 12, 12), Color3.fromRGB(17, 17, 17), Color3.fromRGB(24, 24, 24), Color3.fromRGB(18, 18, 18), Color3.fromRGB(40, 40, 40));
            ["Rifk7"] = ThemePack(Color3.fromRGB(255, 140, 36), Color3.fromRGB(12, 12, 14), Color3.fromRGB(22, 22, 24), Color3.fromRGB(32, 32, 34), Color3.fromRGB(20, 20, 22), Color3.fromRGB(58, 48, 36));
            ["Fatality"] = ThemePack(Color3.fromRGB(255, 92, 156), Color3.fromRGB(12, 10, 14), Color3.fromRGB(24, 18, 26), Color3.fromRGB(34, 26, 36), Color3.fromRGB(22, 16, 24), Color3.fromRGB(72, 40, 58));
            ["Onetap"] = ThemePack(Color3.fromRGB(240, 118, 30), Color3.fromRGB(14, 14, 16), Color3.fromRGB(24, 24, 26), Color3.fromRGB(34, 32, 32), Color3.fromRGB(22, 22, 22), Color3.fromRGB(70, 48, 30));
            ["Nixware"] = ThemePack(Color3.fromRGB(240, 196, 32), Color3.fromRGB(12, 12, 12), Color3.fromRGB(20, 20, 20), Color3.fromRGB(30, 30, 28), Color3.fromRGB(18, 18, 16), Color3.fromRGB(68, 60, 28));
            ["Aimware"] = ThemePack(Color3.fromRGB(200, 48, 48), Color3.fromRGB(14, 14, 16), Color3.fromRGB(22, 22, 24), Color3.fromRGB(32, 32, 36), Color3.fromRGB(20, 20, 22), Color3.fromRGB(70, 36, 36));
            ["Interwebz"] = ThemePack(Color3.fromRGB(56, 214, 196), Color3.fromRGB(10, 14, 16), Color3.fromRGB(16, 24, 28), Color3.fromRGB(24, 34, 38), Color3.fromRGB(16, 22, 26), Color3.fromRGB(36, 64, 62));
            ["Pandora"] = ThemePack(Color3.fromRGB(88, 164, 255), Color3.fromRGB(12, 14, 20), Color3.fromRGB(20, 24, 34), Color3.fromRGB(28, 34, 46), Color3.fromRGB(18, 22, 32), Color3.fromRGB(40, 56, 78));
            ["Lilac Mist"] = ThemePack(Color3.fromRGB(186, 176, 224), Color3.fromRGB(18, 18, 24), Color3.fromRGB(30, 30, 40), Color3.fromRGB(42, 42, 52), Color3.fromRGB(28, 28, 36), Color3.fromRGB(72, 68, 96));
            ["Soft Periwinkle"] = ThemePack(Color3.fromRGB(170, 182, 232), Color3.fromRGB(16, 18, 26), Color3.fromRGB(28, 32, 44), Color3.fromRGB(40, 44, 56), Color3.fromRGB(26, 28, 38), Color3.fromRGB(64, 72, 104));
            ["Blush Pink"] = ThemePack(Color3.fromRGB(240, 186, 206), Color3.fromRGB(20, 16, 20), Color3.fromRGB(34, 28, 34), Color3.fromRGB(46, 38, 46), Color3.fromRGB(30, 24, 30), Color3.fromRGB(96, 68, 84));
            ["Cotton Candy"] = ThemePack(Color3.fromRGB(255, 176, 214), Color3.fromRGB(18, 14, 22), Color3.fromRGB(32, 26, 38), Color3.fromRGB(44, 36, 50), Color3.fromRGB(28, 22, 34), Color3.fromRGB(104, 64, 92));
            ["Lavender Fog"] = ThemePack(Color3.fromRGB(206, 196, 236), Color3.fromRGB(18, 18, 26), Color3.fromRGB(30, 30, 42), Color3.fromRGB(42, 42, 54), Color3.fromRGB(28, 28, 38), Color3.fromRGB(80, 72, 110));
            ["Sky Pastel"] = ThemePack(Color3.fromRGB(176, 214, 240), Color3.fromRGB(14, 18, 24), Color3.fromRGB(26, 34, 44), Color3.fromRGB(36, 46, 56), Color3.fromRGB(24, 30, 40), Color3.fromRGB(64, 88, 112));
            ["Mint Cream"] = ThemePack(Color3.fromRGB(176, 224, 208), Color3.fromRGB(14, 20, 18), Color3.fromRGB(26, 36, 32), Color3.fromRGB(36, 48, 42), Color3.fromRGB(24, 32, 28), Color3.fromRGB(60, 96, 84));
            ["Peach Soft"] = ThemePack(Color3.fromRGB(255, 204, 186), Color3.fromRGB(20, 16, 14), Color3.fromRGB(36, 30, 26), Color3.fromRGB(48, 40, 34), Color3.fromRGB(32, 26, 22), Color3.fromRGB(108, 80, 64));
            ["Rose Quartz"] = ThemePack(Color3.fromRGB(232, 176, 196), Color3.fromRGB(18, 14, 18), Color3.fromRGB(34, 26, 32), Color3.fromRGB(46, 36, 42), Color3.fromRGB(30, 22, 28), Color3.fromRGB(100, 68, 84));
            ["Wisteria"] = ThemePack(Color3.fromRGB(198, 168, 228), Color3.fromRGB(16, 14, 22), Color3.fromRGB(30, 26, 40), Color3.fromRGB(42, 36, 52), Color3.fromRGB(26, 22, 34), Color3.fromRGB(84, 68, 112));
            ["Powder Blue"] = ThemePack(Color3.fromRGB(180, 200, 228), Color3.fromRGB(14, 16, 22), Color3.fromRGB(26, 32, 42), Color3.fromRGB(38, 44, 54), Color3.fromRGB(24, 28, 36), Color3.fromRGB(68, 84, 112));
            ["Mauve"] = ThemePack(Color3.fromRGB(214, 176, 210), Color3.fromRGB(18, 14, 20), Color3.fromRGB(34, 26, 36), Color3.fromRGB(46, 36, 48), Color3.fromRGB(30, 22, 32), Color3.fromRGB(96, 68, 100));
            ["Orchid Light"] = ThemePack(Color3.fromRGB(220, 186, 236), Color3.fromRGB(18, 14, 24), Color3.fromRGB(32, 26, 40), Color3.fromRGB(44, 36, 52), Color3.fromRGB(28, 22, 34), Color3.fromRGB(92, 70, 116));
            ["Seafoam"] = ThemePack(Color3.fromRGB(168, 220, 214), Color3.fromRGB(12, 18, 20), Color3.fromRGB(24, 34, 36), Color3.fromRGB(34, 46, 48), Color3.fromRGB(22, 30, 32), Color3.fromRGB(56, 96, 94));
            ["Ballet Pink"] = ThemePack(Color3.fromRGB(244, 198, 214), Color3.fromRGB(20, 16, 20), Color3.fromRGB(36, 28, 34), Color3.fromRGB(48, 38, 46), Color3.fromRGB(30, 24, 30), Color3.fromRGB(108, 72, 92));
            ["Ice Lilac"] = ThemePack(Color3.fromRGB(196, 204, 236), Color3.fromRGB(16, 18, 26), Color3.fromRGB(28, 32, 44), Color3.fromRGB(40, 44, 56), Color3.fromRGB(24, 28, 38), Color3.fromRGB(76, 80, 116));
            ["Cherry Blossom"] = ThemePack(Color3.fromRGB(255, 188, 206), Color3.fromRGB(20, 14, 18), Color3.fromRGB(36, 26, 32), Color3.fromRGB(48, 36, 44), Color3.fromRGB(30, 22, 28), Color3.fromRGB(112, 68, 88));
            ["Cloud Periwinkle"] = ThemePack(Color3.fromRGB(188, 198, 236), Color3.fromRGB(16, 18, 26), Color3.fromRGB(28, 32, 44), Color3.fromRGB(40, 46, 58), Color3.fromRGB(24, 28, 38), Color3.fromRGB(72, 80, 120));
        }

        Library.ApplyTheme = function(self, Colors)
            if type(Colors) ~= "table" then
                return
            end

            for Theme, Color in Colors do
                if Theme == "Font" then
                    continue
                end

                if type(Color) == "table" and Color.Color then
                    Color = Color.Color
                end

                if type(Color) == "string" then
                    local Ok, Parsed = pcall(Color3.fromHex, Color)
                    Color = Ok and Parsed or nil
                end

                if typeof(Color) ~= "Color3" then
                    continue
                end

                local Utility = Themes.Utility[Theme]
                local Old = Themes.Preset[Theme]

                if Utility and typeof(Old) == "Color3" then
                    for Property, Data in Utility do
                        for _, Object in Data do
                            if Property == "Color" and not (Object:IsA("UIStroke") or Object:IsA("UIGradient")) then
                                continue
                            end

                            pcall(function()
                                if Object[Property] == Old then
                                    Object[Property] = Color
                                end
                            end)
                        end
                    end
                end

                Themes.Preset[Theme] = Color
            end

            if Library.SyncWatermarkStyle then
                Library:SyncWatermarkStyle()
            end
        end

        Library.ApplyBuiltInTheme = function(self, Name)
            local Colors = Library.BuiltInThemes[Name]
            if not Colors then
                return
            end

            self:ApplyTheme(Colors)
        end

        Library.GetTheme = function(self)
            local Config = {}

            for Idx, Value in Themes.Preset do
                if Idx == "Font" or typeof(Value) ~= "Color3" then
                    continue
                end

                Config[Idx] = {Transparency = 0, Color = Value:ToHex()}
            end

            return Services.HttpService:JSONEncode(Config)
        end

        Library.LoadTheme = function(self, JSON)
            local Ok, Config = pcall(function()
                return Services.HttpService:JSONDecode(JSON)
            end)

            if Ok and type(Config) == "table" then
                self:ApplyTheme(Config)
            end
        end

        Library.SaveTheme = function(self, Config)
            if not Config or Config == "" then
                return
            end

            local Path = string.format("%s/%s/%s.son", Library.Directory, "Themes", Config)
            writefile(Path, self:GetTheme())
        end

        Library.DeleteTheme = function(self, Config)
            local Path = string.format("%s/%s/%s.son", Library.Directory, "Themes", Config)
            if isfile(Path) then
                delfile(Path)
            end

            Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)
            if isfile(Path) then
                delfile(Path)
            end
        end

        Library.ThemePath = function(self, Config)
            local Son = string.format("%s/%s/%s.son", Library.Directory, "Themes", Config)
            if isfile(Son) then
                return Son
            end

            local Cfg = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)
            if isfile(Cfg) then
                return Cfg
            end
        end

        Library.Clipboard = ""
        Library.ColorClipboard = ""

        Library.CopyText = function(self, Text)
            Text = tostring(Text or "")
            Library.Clipboard = Text

            pcall(function()
                if setclipboard then
                    setclipboard(Text)
                elseif toclipboard then
                    toclipboard(Text)
                elseif set_clipboard then
                    set_clipboard(Text)
                end
            end)

            return Text ~= ""
        end

        Library.PasteText = function(self)
            local Ok, Value = pcall(function()
                if getclipboard then
                    return getclipboard()
                elseif get_clipboard then
                    return get_clipboard()
                end
            end)

            if Ok and type(Value) == "string" and Value ~= "" then
                Library.Clipboard = Value
                return Value
            end

            if type(Library.Clipboard) == "string" and Library.Clipboard ~= "" then
                return Library.Clipboard
            end
        end

        Library.UpdateThemingList = function(self)
            local List = {}
            local Folder = Library.Directory .. "/Themes"

            if not isfolder(Folder) then
                makefolder(Folder)
            end

            for _, File in listfiles(Folder) do
                local Name = tostring(File):gsub("\\", "/")
                Name = Name:match("([^/]+)$") or Name
                Name = Name:gsub("%.son$", ""):gsub("%.[Cc]fg$", "")
                if Name ~= "" then
                    List[#List + 1] = Name
                end
            end

            table.sort(List)
            self.RefreshOptions(List)
        end
    end

    Library.GetTransparency = function(self, obj)
        if type(obj) == "table" then
            obj = rawget(obj, "Instance") or obj.Instance
        end

        if typeof(obj) ~= "Instance" then
            return nil
        end

        local ok, className = pcall(function()
            return obj.ClassName
        end)
        if not ok or type(className) ~= "string" then
            return nil
        end

        if className == "Frame" or className == "CanvasGroup" then
            return {"BackgroundTransparency"}
        elseif className == "TextLabel" or className == "TextButton" then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif className == "ImageLabel" or className == "ImageButton" then
            return { "BackgroundTransparency", "ImageTransparency" }
        elseif className == "ScrollingFrame" then
            return { "BackgroundTransparency", "ScrollBarImageTransparency" }
        elseif className == "TextBox" then
            return { "BackgroundTransparency" }
        elseif className == "UIStroke" then
            return { "Transparency" }
        elseif obj:IsA("BasePart") then
            return { "Transparency" }
        end

        return nil
    end

    Library.Tween = function(self, Properties, Info, Obj)
        local Instance = self.Instance or Obj

        local Tween = Services.TweenService:Create(Instance, Info or TweenInfo.new(Library.TweeningSpeed, Library.EasingStyle, Enum.EasingDirection.InOut, 0, false, 0), Properties)
        Tween:Play()

        return Tween
    end

    Library.AddGlow = function(self, Options)
        Options = Options or {}

        local Cfg = {
            Amount = Options.Amount or 5;
            DampingFactor = Options.DampingFactor or 0.4;
            Parent = self.Instance;
            Items = {};
        }

        local Items = Cfg.Items;

        for Outline = 0, Cfg.Amount do
            Items[tostring(Outline)] = Library:Create( "UIStroke", {
                Parent = self.Instance;
                Color = Themes.Preset.Accent;
                BorderOffset = UDim.new(0, Outline);
                Transparency = (Outline / (Cfg.Amount + Cfg.DampingFactor))
            }):Themify("Accent", "Color")

            Library:Create( "UIGradient", {
                Parent = Items[tostring(Outline)].Instance;
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, Cfg.DampingFactor),
                    NumberSequenceKeypoint.new(1, Cfg.DampingFactor)
                }
            })
        end

        table.insert(Library.Glows, Cfg)

        return self
    end

    Library.Fade = function(self, obj, prop, vis)
        if not (prop and obj) then
            return
        end

        local OldTransparency = obj[prop]
        obj[prop] = vis and 1 or OldTransparency

        local Animation = Library:Tween({[prop] = vis and OldTransparency or 1}, nil, obj)
        Library:Connect(Animation.Completed, function()
            if not vis then
                obj[prop] = OldTransparency
            end
        end)

        return Animation
    end

    Library.TweenDescendants = function(self, Bool, Path)
        Path = Path or {Tweening = false}

        if Path.Tweening == true then
            return
        end

        local Instance = self.Instance
        Path.Tweening = true

        if Bool then
            Instance.Visible = true
        end

        local Children = Instance:GetDescendants()
        table.insert(Children, Instance)

        local FadingAnimation;
        for _,obj in Children do
            if type(obj) == "table" and obj.Instance then
                obj = obj.Instance
            end

            local Index = Library:GetTransparency(obj)

            if not Index then
                continue
            end

            if type(Index) == "table" then
                for _,prop in Index do
                    FadingAnimation = Library:Fade(obj, prop, Bool)
                end
            else
                FadingAnimation = Library:Fade(obj, Index, Bool)
            end
        end

        Library:Connect(FadingAnimation.Completed, function()
            Path.Tweening = false
            Instance.Visible = Bool
        end)
    end

    Library.Resizify = function(self)
        local Instance = self.Instance

        local Resizing = Library:Create("TextButton", {
            Position = UDim2.new(1, -18, 1, -18);
            Size = UDim2.new(0, 12, 0, 12);
            BorderSizePixel = 0;
            Parent = Instance;
            BackgroundTransparency = 1;
            Text = ""
        })

        Library:Create( "UICorner", {
            Parent = Resizing.Instance;
            CornerRadius = UDim.new(1, 0)
        })

        local IsResizing = false
        local Size;
        local InputLost;
        local ParentSize = Instance.Size

        Resizing.Instance.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                IsResizing = true
                InputLost = input.Position
                Size = Instance.Size
            end
        end)

        Resizing.Instance.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                IsResizing = false
            end
        end)

        Library:Connect(Services.UserInputService.InputChanged, function(input, game_event)
            if IsResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                self:Tween({
                    Size = UDim2.new(
                        Size.X.Scale,
                        math.clamp(Size.X.Offset + (input.Position.X - InputLost.X), ParentSize.X.Offset, Camera.ViewportSize.X),
                        Size.Y.Scale,
                        math.clamp(Size.Y.Offset + (input.Position.Y - InputLost.Y), ParentSize.Y.Offset, Camera.ViewportSize.Y)
                    )
                }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
            end
        end)
    end

    Library.Hovering = function(self)
        local y_cond = self.Instance.AbsolutePosition.Y <= Mouse.Y and Mouse.Y <= self.Instance.AbsolutePosition.Y + self.Instance.AbsoluteSize.Y
        local x_cond = self.Instance.AbsolutePosition.X <= Mouse.X and Mouse.X <= self.Instance.AbsolutePosition.X + self.Instance.AbsoluteSize.X

        return (y_cond and x_cond)
    end

    Library.Draggify = function(self)
        local Instance = self.Instance

        local Dragging = false
        local IntialSize = Instance.Position
        local InitialPosition

        Instance.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                InitialPosition = Input.Position
                InitialSize = Instance.Position
            end
        end)

        Instance.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = false
            end
        end)

        Library:Connect(Services.UserInputService.InputChanged, function(Input, GameEvent)
            if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                local Horizontal = Camera.ViewportSize.X
                local Vertical = Camera.ViewportSize.Y

                local NewPosition = UDim2.new(
                    0,
                    InitialSize.X.Offset + (Input.Position.X - InitialPosition.X),
                    0,
                    InitialSize.Y.Offset + (Input.Position.Y - InitialPosition.Y)
                )

                self:Tween({Position = NewPosition}, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
            end
        end)

        return self
    end

    Library.ConvertToHex = function(self, Color)
        local r = math.floor(Color.R * 255)
        local g = math.floor(Color.G * 255)
        local b = math.floor(Color.B * 255)
        return string.format("#%02X%02X%02X", r, g, b)
    end

    Library.ConvertFromHex = function(self, Color)
        Color = Color:gsub("#", "")
        local r = tonumber(Color:sub(1, 2), 16) / 255
        local g = tonumber(Color:sub(3, 4), 16) / 255
        local b = tonumber(Color:sub(5, 6), 16) / 255
        return Color3.new(r, g, b)
    end

    Library.GroupRGB = function(self, String)
        local Values = {}

        for Value in string.gmatch(String, "[^,]+") do
            table.insert(Values, tonumber(Value))
        end

        if #Values == 4 then
            return unpack(Values)
        else
            return
        end
    end

    Library.ConvertEnum = function(self, enum)
        local EnumParts = {}

        for _, part in string.gmatch(tostring(enum), "[%w_]+") do
            table.insert(EnumParts, part)
        end

        local EnumTable = Enum

        for i = 2, #EnumParts do
            local Next = EnumTable[EnumParts[i]]
            if not Next then
                return nil
            end
            EnumTable = Next
        end

        return EnumTable
    end

    Library.Lerp = function(self, start, finish, t)
        t = t or 1 / 8

        return start * (1 - t) + finish * t
    end

    Library.Round = function(self, num, float)
        local Multiplier = 1 / (float or 1)
        return math.floor(num * Multiplier + 0.5) / Multiplier
    end

    Library.MeasureText = function(self, Text, TextSize)
        Text = Text or ""
        TextSize = TextSize or 14

        if Text == "" then
            return 0
        end

        return Services.TextService:GetTextSize(Text, TextSize, Enum.Font.GothamMedium, Vector2.new(10000, 50)).X
    end

    Library.ShouldSkipConfigFlag = function(self, Idx)
        Idx = tostring(Idx or "")

        if Idx == "" or Idx == "ignore" or Idx == "ConfigList" or Idx == "ConfigListFlag" or Idx == "config_Name_text" or Idx == "ThemeList" or Idx == "theme_Name_text" or Idx == "PresetTheme" or Idx == "HeaderConfig" then
            return true
        end

        if string.find(string.lower(Idx), "ignore", 1, true) then
            return true
        end

        if string.sub(Idx, -5) == "_MODE" or string.sub(Idx, -6) == "_Curve" then
            return true
        end

        return false
    end

    Library.GetConfigNames = function(self)
        local List = {}
        local Folder = Library.Directory .. "/Configs"

        if not isfolder(Folder) then
            makefolder(Folder)
        end

        for _, File in listfiles(Folder) do
            local Name = tostring(File):gsub("\\", "/")
            Name = Name:match("([^/]+)$") or Name
            Name = Name:gsub("%.son$", ""):gsub("%.[Cc]fg$", "")
            if Name ~= "" then
                List[#List + 1] = Name
            end
        end

        table.sort(List)
        return List
    end

    Library.UpdateConfigList = function(self)
        local List = Library:GetConfigNames()

        if self.RefreshOptions then
            self.RefreshOptions(List)
        end
    end

    Library.LoadConfigByName = function(self, Name, Silent)
        Name = tostring(Name or "")
        if Name == "" or Name == "Configs" or Name == "No configs" then
            return false
        end

        local Path = Library.Directory .. "/Configs/" .. Name .. ".son"
        if not isfile(Path) then
            if not Silent then
                Library:Notify({ Text = "Missing " .. Name .. ".son" })
            end
            return false
        end

        local Window = Library.Window
        if Window then
            Window.Tweening = true
        end

        Library.LoadingHeaderConfig = true
        local Data = readfile(Path)
        Library:LoadConfig(Data)
        Library.LoadingHeaderConfig = false
        Library.ActiveConfig = Name

        if Window then
            Window.Tweening = false
        end

        if not Silent then
            Library:Notify({ Text = "Loaded " .. Name })
        end

        return true
    end

    Library.Keypicker = function(self, properties)
        local Cfg = {
            Text = properties.Text or "Color",
            Flag = properties.Flag or properties.Name or "Colorpicker",
            Callback = properties.Callback or function() end,

            Color = properties.Color or Color3.fromRGB(1, 1, 1), -- Default to white color if not provided
            Alpha = properties.Alpha or properties.Transparency or 0,

            -- Other
            Open = false,
            Items = {};
            Tweening = false;
        }

        local DraggingSat = false
        local DraggingHue = false
        local DraggingAlpha = false

        local h, s, v = Cfg.Color:ToHSV()
        local a = Cfg.Alpha

        local OldHue = h;
        local OldAlpha = a;

        Flags[Cfg.Flag] = {Color = Cfg.Color, Transparency = Cfg.Alpha}

        local Items = Cfg.Items; do
            Items.Holder = self.Items.Holder
            if not Items.Holder then
                Items.Object = Library:Create( "Frame", {
                    Parent = self.Items.Elements.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, 18);
                    BorderSizePixel = 0
                })

                Items.Text = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Color3.fromRGB(252, 252, 252);
                    Text = Cfg.Text;
                    Parent = Items.Object.Instance;
                    AnchorPoint = Vector2.new(0, 0.5);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 0, 0.5, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2
                })

                Items.Holder = Library:Create( "Frame", {
                    Parent = Items.Object.Instance;
                    Position = UDim2.new(1, 1, 0, 0);
                    Size = UDim2.new(0, 0, 1, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = Items.Holder.Instance;
                    Padding = UDim.new(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            Items.ColorpickerObject = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(1, 0.5);
                Parent = Items.Holder.Instance;
                Position = UDim2.new(1, 0, 0.5, 0);
                Size = UDim2.new(0, 29, 0, 16);
                LayoutOrder = 0;
                BorderSizePixel = 0;
                ClipsDescendants = true;
                BackgroundColor3 = Themes.Preset["Accent"]
            }):Themify("Accent", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.ColorpickerObject.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Library:Create( "UIStroke", {
                Color = Color3.fromRGB(12, 12, 14);
                Thickness = 1;
                Transparency = 0.35;
                Parent = Items.ColorpickerObject.Instance
            })

            local Shine = Library:Create( "Frame", {
                Parent = Items.ColorpickerObject.Instance;
                Size = UDim2.new(1, 0, 1, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            })

            Library:Create( "UICorner", {
                Parent = Shine.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Library:Create( "UIGradient", {
                Parent = Shine.Instance;
                Rotation = 90;
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0.88),
                    NumberSequenceKeypoint.new(0.45, 0.97),
                    NumberSequenceKeypoint.new(1, 1)
                }
            })

            do -- Element clicker
                Items.Colorpicker = Library:Create( "TextButton", {
                    Parent = Library.Other.Instance;
                    Position = UDim2.new(0.04664722830057144, 0, 0.17076167464256287, 0);
                    Size = UDim2.new(0, 237, 0, 196);
                    BorderSizePixel = 0;
                    ClipsDescendants = true;
                    AutoButtonColor = false;
                    BackgroundColor3 = Themes.Preset["Background"]
                }):Themify("Background", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Parent = Items.Colorpicker.Instance;
                    Transparency = 0.5
                })

                Library:Create( "UICorner", {
                    Parent = Items.Colorpicker.Instance;
                    CornerRadius = UDim.new(0, 4)
                })

                Items.Colorpicker:AddShine()

                Items.Title = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Themes.Preset["TextColor"];
                    Text = "";
                    Visible = false;
                    Parent = Items.Colorpicker.Instance;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 8, 0, 8);
                    BorderSizePixel = 0;
                    ZIndex = 2
                }):Themify("TextColor", "TextColor3")

                Items.SatValBackground = Library:Create( "Frame", {
                    Parent = Items.Colorpicker.Instance;
                    Position = UDim2.new(0, 8, 0, 8);
                    Size = UDim2.new(1, -43, 1, -16);
                    BorderSizePixel = 0;
                    ClipsDescendants = true;
                    BackgroundColor3 = Color3.fromRGB(21, 255, 99)
                })

                Items.Saturation = Library:Create( "Frame", {
                    Parent = Items.SatValBackground.Instance;
                    Size = UDim2.new(1, 0, 1, 0);
                    ZIndex = 2;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    BorderSizePixel = 0
                })

                Library:Create( "UIGradient", {
                    Rotation = 270;
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1)
                };
                    Parent = Items.Saturation.Instance;
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                }
                })

                Library:Create( "UICorner", {
                    Parent = Items.Saturation.Instance;
                    CornerRadius = UDim.new(0, 4)
                })

                Items.Value = Library:Create( "Frame", {
                    Parent = Items.SatValBackground.Instance;
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UIGradient", {
                    Parent = Items.Value.Instance;
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1)
                }
                })

                Library:Create( "UICorner", {
                    Parent = Items.Value.Instance;
                    CornerRadius = UDim.new(0, 4)
                })

                Library:Create( "UICorner", {
                    Parent = Items.SatValBackground.Instance;
                    CornerRadius = UDim.new(0, 4)
                })

                Library:Create( "UIStroke", {
                    Color = Themes.Preset.ElementOutline;
                    Parent = Items.SatValBackground.Instance
                }):Themify("ElementOutline", "Color")

                Items.SatValPickerHolder = Library:Create( "Frame", {
                    Parent = Items.SatValBackground.Instance;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 3, 0, 3);
                    Size = UDim2.new(1, -6, 1, -6);
                    BorderSizePixel = 0
                })

                Items.SatValPicker = Library:Create( "Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Parent = Items.SatValPickerHolder.Instance;
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    Size = UDim2.new(0, 7, 0, 7);
                    ZIndex = 1000;
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })

                Library:Create( "UICorner", {
                    Parent = Items.SatValPicker.Instance;
                    CornerRadius = UDim.new(1, 5)
                })

                Items.Inline = Library:Create( "Frame", {
                    Parent = Items.SatValPicker.Instance;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    BackgroundTransparency = 0.3499999940395355;
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    Size = UDim2.new(1, -2, 1, -2);
                    ZIndex = 1001;
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.Inline.Instance;
                    CornerRadius = UDim.new(1, 0)
                })

                Items.Hue = Library:Create( "Frame", {
                    AnchorPoint = Vector2.new(1, 0);
                    Parent = Items.Colorpicker.Instance;
                    Position = UDim2.new(1, -8, 0, 8);
                    Size = UDim2.new(0, 18, 1, -16);
                    ClipsDescendants = true;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.Hue.Instance;
                    CornerRadius = UDim.new(0, 4)
                })

                Library:Create( "UIGradient", {
                    Rotation = 90;
                    Parent = Items.Hue.Instance;
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }
                })

                Library:Create( "UIStroke", {
                    Color = Themes.Preset.ElementOutline;
                    Parent = Items.Hue.Instance
                }):Themify("ElementOutline", "Color")

                Items.HuePickerHolder = Library:Create( "Frame", {
                    Parent = Items.Hue.Instance;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 0, 0, 3);
                    Size = UDim2.new(1, 0, 1, -6);
                    BorderSizePixel = 0
                })

                Items.HuePicker = Library:Create( "Frame", {
                    Parent = Items.HuePickerHolder.Instance;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    BackgroundTransparency = 0.3499999940395355;
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    Size = UDim2.new(1, 0, 0, 6);
                    ZIndex = 100;
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.HuePicker.Instance;
                    CornerRadius = UDim.new(0, 2)
                })

                Library:Create( "UIStroke", {
                    Parent = Items.HuePicker.Instance
                })

                Items.Alpha = Library:Create( "Frame", {
                    Visible = false;
                    AnchorPoint = Vector2.new(0, 1);
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    Parent = Items.Colorpicker.Instance;
                    Position = UDim2.new(0, 8, 1, -41);
                    Size = UDim2.new(1, -17, 0, 18);
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.Alpha.Instance;
                    CornerRadius = UDim.new(0, 5)
                })

                Items.AlphaIndicator = Library:Create( "ImageLabel", {
                    ScaleType = Enum.ScaleType.Tile;
                    ClipsDescendants = true;
                    Parent = Items.Alpha.Instance;
                    Rotation = 180;
                    Image = "rbxassetid://18274452449";
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    TileSize = UDim2.new(0, 6, 0, 6);
                    BorderSizePixel = 0
                })

                Items.AlphaIndicatorHolder = Library:Create( "Frame", {
                    Parent = Items.AlphaIndicator.Instance;
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.AlphaIndicatorHolder.Instance;
                    CornerRadius = UDim.new(0, 5)
                })

                Items.AlphaGradient = Library:Create( "UIGradient", {
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 255, 99)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 255, 99))
                };
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                };
                    Parent = Items.AlphaIndicatorHolder.Instance
                })

                Library:Create( "UICorner", {
                    Parent = Items.AlphaIndicator.Instance;
                    CornerRadius = UDim.new(0, 5)
                })

                Library:Create( "UIStroke", {
                    Color = Themes.Preset.ElementOutline;
                    Parent = Items.Alpha.Instance
                }):Themify("ElementOutline", "Color")

                Items.AlphaPickerHolder = Library:Create( "Frame", {
                    Parent = Items.Alpha.Instance;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 3, 0, 0);
                    Size = UDim2.new(1, -6, 1, 0);
                    BorderSizePixel = 0
                })

                Items.AlphaPicker = Library:Create( "Frame", {
                    Parent = Items.AlphaPickerHolder.Instance;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    BackgroundTransparency = 0.3499999940395355;
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    Size = UDim2.new(0, 6, 1, 0);
                    ZIndex = 100;
                    BorderSizePixel = 0
                })

                Library:Create( "UICorner", {
                    Parent = Items.AlphaPicker.Instance;
                    CornerRadius = UDim.new(0, 2)
                })

                Library:Create( "UIStroke", {
                    Parent = Items.AlphaPicker.Instance
                })

                Items.Elements = Library:Create( "Frame", {
                    Parent = Items.Colorpicker.Instance;
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 8, 1, -32);
                    Size = UDim2.new(1, -16, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                local Section = setmetatable({Items = Items}, Library)
                Items.RGB = Section:AddInput({Flag = "ignore", PlaceHolder = "Color", Callback = function(text)
                    if Cfg.Set then
                        local r, g, b, a = Library:GroupRGB(text)

                        if (r and g and b and a) then
                            Cfg.Set(Color3.fromRGB(r, g, b), 1 - a)
                        else
                            Cfg.Set(Color3.fromHSV(h, s, v), 1 - a)
                        end
                    end
                end})

                Library:Create( "UIListLayout", {
                    Parent = Items.Elements.Instance;
                    Padding = UDim.new(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            do -- Holder
                Items.Colorpicker:Reparent(Library.Elements.Instance)
            end
        end

        Cfg.SetVisible = function()
            if Cfg.Tweening == true then
                return
            end

            Cfg.Open = not Cfg.Open

            Items.Colorpicker.Instance.Position = UDim2.new(0, Items.ColorpickerObject.Instance.AbsolutePosition.X, 0, Items.ColorpickerObject.Instance.AbsolutePosition.Y + (Cfg.Open and 64 or 74))
            Items.Colorpicker:Tween({Position = UDim2.new(0, Items.ColorpickerObject.Instance.AbsolutePosition.X, 0, Items.ColorpickerObject.Instance.AbsolutePosition.Y + (Cfg.Open and 74 or 64))})
            Items.Colorpicker:TweenDescendants(Cfg.Open, Cfg)
        end

        Cfg.UpdateColor = function()
            local Mouse = Services.UserInputService:GetMouseLocation()
            local Offset = Vector2.new(Mouse.X, Mouse.Y - GuiInset)

            if DraggingSat then
                s = math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).X / Items.Saturation.Instance.AbsoluteSize.X, 0, 1)
                v = 1 - math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).Y / Items.Saturation.Instance.AbsoluteSize.Y, 0, 1)
            elseif DraggingHue then
                h = math.clamp((Offset - Items.Hue.Instance.AbsolutePosition).Y / Items.Hue.Instance.AbsoluteSize.Y, 0, 1)
            elseif DraggingAlpha then
                a = math.clamp((Offset - Items.Alpha.Instance.AbsolutePosition).X / Items.Alpha.Instance.AbsoluteSize.X, 0, 1)
            end

            Cfg.Set()
        end

        Cfg.Set = function(Color, Alpha)
            if type(Color) == "boolean" then
                return
            end

            if Color then
                h, s, v = Color:ToHSV()
            end

            if Alpha ~= nil then
                a = Alpha
            end

            local TweenInformation = TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
            local Flag = Flags[Cfg.Flag]

            Items.ColorpickerObject.Instance.BackgroundColor3 = Color3.fromHSV(h, s, v)
            Items.SatValBackground.Instance.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            Items.AlphaGradient.Instance.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromHSV(h, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
            }

            Items.SatValPicker:Tween({Position = UDim2.new(s, 0, 1 - v, 0)}, TweenInformation)
            Items.AlphaPicker:Tween({Position = UDim2.new(a, 0, 0.5, 0)}, TweenInformation)
            Items.HuePicker:Tween({Position = UDim2.new(0.5, 0, h, 0)}, TweenInformation)

            OldHue = h
            OldAlpha = a

            Color = Items.ColorpickerObject.Instance.BackgroundColor3 -- Overwriting to format<<

            if Items.RGB and not Items.RGB.Focused and Items.RGB.Items and Items.RGB.Items.Textbox then
                Items.RGB.Items.Textbox.Instance.Text = string.format("%s, %s, %s, %s", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255), Library:Round(1 - a, 0.01))
            end

            Flags[Cfg.Flag] = {
                Color = Color;
                Transparency = a
            }

            Cfg.Callback(Color, a)
        end

        Items.ColorpickerObject:OnClick(Cfg.SetVisible)
        Items.Colorpicker:OutsideClick(Cfg)

        do -- Right-click copy / paste
            Items.Context = Library:Create( "Frame", {
                Parent = Library.Other.Instance;
                Visible = false;
                Size = UDim2.new(0, 104, 0, 58);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.Context.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Parent = Items.Context.Instance
            }):Themify("ElementOutline", "Color")

            Library:Create( "UIListLayout", {
                Parent = Items.Context.Instance;
                Padding = UDim.new(0, 4);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, 4);
                PaddingBottom = UDim.new(0, 4);
                PaddingLeft = UDim.new(0, 4);
                PaddingRight = UDim.new(0, 4);
                Parent = Items.Context.Instance
            })

            local function MakeContextButton(Text, Order, Callback)
                local Button = Library:Create( "TextButton", {
                    Parent = Items.Context.Instance;
                    LayoutOrder = Order;
                    Size = UDim2.new(1, 0, 0, 22);
                    BorderSizePixel = 0;
                    AutoButtonColor = false;
                    Text = "";
                    BackgroundColor3 = Themes.Preset["Other"]
                }):Themify("Other", "BackgroundColor3")

                Library:Create( "UICorner", {
                    Parent = Button.Instance;
                    CornerRadius = UDim.new(0, 3)
                })

                local Label = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Themes.Preset["TextColor"];
                    Text = Text;
                    Parent = Button.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2
                }):Themify("TextColor", "TextColor3")
                Label.Instance.Text = Text

                Button:OnClick(function()
                    Callback()
                    Items.Context.Instance.Visible = false
                end)

                return Button
            end

            Cfg.CloseContext = function()
                Items.Context.Instance.Visible = false
            end

            Cfg.OpenContext = function()
                local Mouse = Services.UserInputService:GetMouseLocation()
                local Inset = Services.GuiService:GetGuiInset()
                Items.Context.Instance.Parent = Library.Elements.Instance
                Items.Context.Instance.Position = UDim2.fromOffset(Mouse.X + 6, Mouse.Y - Inset.Y + 6)
                Items.Context.Instance.Visible = true
            end

            MakeContextButton("Copy", 1, function()
                local Flag = Flags[Cfg.Flag]
                local Color = Items.ColorpickerObject.Instance.BackgroundColor3
                if Flag and typeof(Flag.Color) == "Color3" then
                    Color = Flag.Color
                elseif Flag and type(Flag.Color) == "string" then
                    local Ok, Parsed = pcall(Color3.fromHex, tostring(Flag.Color):gsub("#", ""))
                    if Ok and typeof(Parsed) == "Color3" then
                        Color = Parsed
                    end
                end

                if typeof(Color) == "Color3" then
                    local Hex = Library:ConvertToHex(Color)
                    Library.ColorClipboard = Hex
                    Library:CopyText(Hex)
                    Library:Notify({ Text = "Color copied" })
                end
            end)

            MakeContextButton("Paste", 2, function()
                local Payload = Library.ColorClipboard
                if not Payload or Payload == "" then
                    Payload = Library:PasteText()
                end

                if not Payload or Payload == "" then
                    Library:Notify({ Text = "Clipboard empty" })
                    return
                end

                Payload = string.gsub(Payload, "%s+", "")
                Payload = string.gsub(Payload, "^#", "")

                local Ok, Color = pcall(Color3.fromHex, Payload)
                if not (Ok and typeof(Color) == "Color3") then
                    Ok, Color = pcall(function()
                        return Library:ConvertFromHex(Payload)
                    end)
                end

                if Ok and typeof(Color) == "Color3" then
                    local Alpha = Flags[Cfg.Flag] and Flags[Cfg.Flag].Transparency or Cfg.Alpha or 0
                    Cfg.Set(Color, Alpha)
                    Library:Notify({ Text = "Color pasted" })
                else
                    Library:Notify({ Text = "Invalid color" })
                end
            end)

            Library:Connect(Items.ColorpickerObject.Instance.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Cfg.OpenContext()
                end
            end)

            Library:Connect(Services.UserInputService.InputBegan, function(Input)
                if not Items.Context.Instance.Visible then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    local AbsPos = Items.Context.Instance.AbsolutePosition
                    local AbsSize = Items.Context.Instance.AbsoluteSize
                    local Mouse = Services.UserInputService:GetMouseLocation()
                    local Inset = Services.GuiService:GetGuiInset()
                    local X = Mouse.X
                    local Y = Mouse.Y - Inset.Y

                    if X < AbsPos.X or X > AbsPos.X + AbsSize.X or Y < AbsPos.Y or Y > AbsPos.Y + AbsSize.Y then
                        Cfg.CloseContext()
                    end
                elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                    task.defer(function()
                        if Items.Context.Instance.Visible then
                            -- keep open if opened from this picker
                        end
                    end)
                end
            end)
        end

        Cfg.DisableDragging = function()
            DraggingSat = false
            DraggingHue = false
            DraggingAlpha = false
        end

        Items.Alpha:OnDrag(Cfg.UpdateColor, function(Dragging)
            if Dragging then
                DraggingAlpha = true
            else
                Cfg.DisableDragging()
            end
        end)

        Items.Hue:OnDrag(Cfg.UpdateColor, function(Dragging)
            if Dragging then
                DraggingHue = true
            else
                Cfg.DisableDragging()
            end
        end)

        Items.Saturation:OnDrag(Cfg.UpdateColor, function(Dragging)
            if Dragging then
                DraggingSat = true
            else
                Cfg.DisableDragging()
            end
        end)

        Cfg.Set(Cfg.Color, Cfg.Alpha)

        ConfigFlags[Cfg.Flag] = Cfg.Set

        if self.UpdateSection then
            self.UpdateSection(Items.Object.Instance or self.Items.Object.Instance)
        end

        return setmetatable(Cfg, Library)
    end

    Library.GetConfig = function(self)
        local Config = {}

        for Idx, Value in Flags do
            if Library:ShouldSkipConfigFlag(Idx) or not ConfigFlags[Idx] then
                continue
            end

            if type(Value) == "table" and Value.Key ~= nil then
                Config[Idx] = {
                    Active = Value.Active == true;
                    Mode = Value.Mode;
                    Key = Value.Key and tostring(Value.Key) or "NONE";
                }
            elseif type(Value) == "table" and Value.Color ~= nil then
                local Color = Value.Color
                Config[Idx] = {
                    Transparency = Value.Transparency;
                    Color = typeof(Color) == "Color3" and Color:ToHex() or Color;
                }
            elseif typeof(Value) == "EnumItem" then
                Config[Idx] = tostring(Value)
            elseif typeof(Value) ~= "Instance" and typeof(Value) ~= "userdata" then
                Config[Idx] = Value
            end
        end

        return Services.HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, JSON)
        local Ok, Config = pcall(function()
            return Services.HttpService:JSONDecode(JSON)
        end)

        if not Ok or type(Config) ~= "table" then
            return
        end

        for Idx, Value in Config do
            if Library:ShouldSkipConfigFlag(Idx) then
                continue
            end

            local Function = ConfigFlags[Idx]
            if not Function then
                continue
            end

            if type(Value) == "table" and Value.Color ~= nil then
                local Color = Value.Color
                if type(Color) == "string" then
                    local HexOk, HexColor = pcall(Color3.fromHex, Color)
                    if HexOk then
                        Color = HexColor
                    end
                end
                Function(Color, Value.Transparency)
            elseif type(Value) == "table" and Value.Key ~= nil then
                Function(Value, true)
            else
                Function(Value)
            end
        end
    end

    Library.DeleteConfig = function(self, Config)
        local Path = string.format("%s/%s/%s.son", Library.Directory, "Configs", Config)
        if isfile(Path) then
            delfile(Path)
        end
    end

    Library.SaveConfig = function(self, Config)
        if not Config or Config == "" then
            return
        end

        local Path = string.format("%s/%s/%s.son", Library.Directory, "Configs", Config)
        writefile(Path, self:GetConfig())
    end

    Library.AutoLoad = function(self)
        self.Window.Tweening = true
        local Name = readfile(Library.Directory.."/Autoload.txt")

        if Name ~= "" then
            local Path = Library.Directory .. "/Configs/" .. Name .. ".son"
            if isfile(Path) then
                Library.ActiveConfig = Name
                self:LoadConfig(readfile(Path))
            end
        end
        self.Window.Tweening = false
    end

    Library.Thread = function(self, Function)
        local Thread = coroutine.create(Function)

        coroutine.wrap(function()
            coroutine.resume(Thread)
        end)()

        table.insert(self.Threads, Thread)

        return Thread
    end

    Library.SafeCall = function(self, Function, ...)
        local Arguments = { ... }
        local Success, Result = pcall(Function, table.unpack(Arguments))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Signal, Callback)
        local ConnectionInfo = {
            Event = Signal,
            Callback = Callback,
            Connection;
        }

        Library:Thread(function()
            ConnectionInfo.Connection = Signal:Connect(Callback)
        end)

        table.insert(self.Connections, ConnectionInfo)

        return ConnectionInfo
    end

    Library.OnClick = function(self, Callback)
        local Connection = Library:Connect(self.Instance.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Callback()
            end
        end)

        return Connection
    end

    Library.OnHover = function(self, Callback1, Callback2)
        Callback2 = Callback2 or function() end

        Library:Connect(self.Instance.MouseEnter, function()
            Callback1()
        end)

        Library:Connect(self.Instance.MouseLeave, function()
            Callback2()
        end)
    end

    Library.OnDrag = function(self, Callback1, Callback2)
        local Dragging = false
        Callback2 = Callback2 or function() end

        self.Instance.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                Callback2(Dragging)
            end
        end)

        Library:Connect(Services.UserInputService.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = false
                Callback2(Dragging)
            end
        end)

        Library:Connect(Services.UserInputService.InputChanged, function(input)
            if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                Callback1(input)
            end
        end)
    end

    Library.Reparent = function(self, Parent)
        Parent = Parent or self.Instance.Parent

        local Connection = Library:Connect(self.Instance:GetPropertyChangedSignal("Visible"), function()
            local Visible = self.Instance.Visible

            self.Instance.Parent = Visible and Parent or Library.Other.Instance
        end)
    end

    Library.OutsideClick = function(self, Cfg, Ignore)
        local Connection = Library:Connect(Services.UserInputService.InputBegan, function(input)
            if self.Instance.Visible == false then
                return
            end

            local InputType = input.UserInputType

            if not (InputType == Enum.UserInputType.MouseButton1 or InputType == Enum.UserInputType.Touch) then
                return
            end

            if self:Hovering() then
                return
            end

            local function IsIgnored(Item)
                return Item and type(Item) == "table" and Item.Hovering and Item:Hovering()
            end

            if Ignore then
                if Ignore.Hovering then
                    if IsIgnored(Ignore) then
                        return
                    end
                else
                    for _, Item in Ignore do
                        if IsIgnored(Item) then
                            return
                        end
                    end
                end
            end

            Cfg.SetVisible(false)
        end)

        return Connection
    end

    Library.Disconnect = function(self, Name)
        self.Connection:Disconnect()
    end

    Library.Create = function(self, Class, Options)
        local Info = {
            Instance = Instance.new(Class);
            Properties = Options;
        }

        local Instance = Info.Instance

        for Property, Value in Info.Properties do
            Instance[Property] = Value
        end

        if Class == "TextButton" then
            Instance.AutoButtonColor = false
            Instance.Text = ""
        end

        if Class == "TextLabel" or Class == "TextBox" then
            Instance.FontFace = Themes.Preset.Font
            Instance.TextSize = 14
        end

        Instance.Name = "\0"

        return setmetatable(Info, Library)
    end

    Library.AddShine = function(self)
        local Radius = UDim.new(0, 4)
        local Existing = self.Instance:FindFirstChildOfClass("UICorner")
        if Existing then
            Radius = Existing.CornerRadius
        end

        local Shine = Library:Create( "Frame", {
            Parent = self.Instance;
            Size = UDim2.new(1, 0, 1, 0);
            BorderSizePixel = 0;
            ZIndex = (self.Instance.ZIndex or 1) + 1;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })

        Library:Create( "UICorner", {
            Parent = Shine.Instance;
            CornerRadius = Radius
        })

        Library:Create( "UIGradient", {
            Parent = Shine.Instance;
            Rotation = 90;
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.88),
                NumberSequenceKeypoint.new(0.18, 0.97),
                NumberSequenceKeypoint.new(1, 1)
            }
        })

        Library:Create( "Frame", {
            Parent = self.Instance;
            Position = UDim2.new(0, 2, 0, 1);
            Size = UDim2.new(1, -4, 0, 1);
            BorderSizePixel = 0;
            ZIndex = (self.Instance.ZIndex or 1) + 2;
            BackgroundTransparency = 0.82;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })

        return self
    end

    Library.SetFont = function(self, Name)
        local Aliases = {
            ["Segoe Ui"] = "BuilderSans";
            ["Segoe UI"] = "BuilderSans";
            ["Gotham"] = "GothamSSm";
        }

        local Family = Aliases[Name] or Name or "BuilderSans"
        local Face

        local Ok = pcall(function()
            Face = Font.fromName(Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        end)

        if not Ok or not Face then
            pcall(function()
                Face = Font.fromName(Family, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            end)
        end

        if not Face then
            Face = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        end

        Themes.Preset.Font = Face
        Fonts.Bold = Face
        Fonts.Elements = Face

        local Roots = {Library.Items, Library.Elements, Library.HUD, Library.Other}
        for _, Root in Roots do
            if not (Root and Root.Instance) then
                continue
            end

            for _, Object in Root.Instance:GetDescendants() do
                if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
                    Object.FontFace = Face
                end
            end
        end
    end

    Library.Unload = function(self)
        repeat task.wait() until #self.Notifications == 0

        for Index, Value in self.Connections do
            if Value.Connection then
                Value.Connection:Disconnect()
            end
        end

        for Index, Value in self.Threads do
            coroutine.close(Value)
        end

        local Items = {self.Items, self.Other, self.Elements, self.HUD}

        for _, Item in Items do
            if Item then
                Item.Instance:Destroy()
                Item = nil
            end
        end

        Library = nil
        getgenv().Library = nil
    end

    Library.KillBlur = function()
        for _, Effect in Services.Lighting:GetChildren() do
            if Effect:IsA("BlurEffect") or Effect:IsA("DepthOfFieldEffect") then
                pcall(function()
                    Effect.Enabled = false
                    if Effect:IsA("BlurEffect") then
                        Effect.Size = 0
                    end
                    Effect:Destroy()
                end)
            end
        end

        if Library.WorldBlur then
            pcall(function()
                if Library.WorldBlur.Instance then
                    Library.WorldBlur.Instance:Destroy()
                end
            end)
            Library.WorldBlur = nil
        end
    end

    Library.KillBlur()

    Library:Connect(Services.Lighting.ChildAdded, function(Child)
        local Window = Library.Window
        if not (Window and Window.Visible) then
            return
        end

        if Child:IsA("BlurEffect") or Child:IsA("DepthOfFieldEffect") then
            task.defer(function()
                pcall(function()
                    Child.Enabled = false
                    if Child:IsA("BlurEffect") then
                        Child.Size = 0
                    end
                    Child:Destroy()
                end)
            end)
        end
    end)

    Library:Connect(Services.RunService.Heartbeat, function()
        local Window = Library.Window
        if Window and Window.Visible then
            Library.KillBlur()
        end
    end)

    Library.Items = Library:Create( "ScreenGui" , {
        Parent = Services.CoreGui;
        Name = "\0";
        Enabled = true;
        ZIndexBehavior = Enum.ZIndexBehavior.Global;
        IgnoreGuiInset = true;
        DisplayOrder = 100;
    });

    Library.Other = Library:Create( "ScreenGui" , {
        Parent = Services.CoreGui;
        Name = "\0";
        Enabled = false;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        IgnoreGuiInset = true;
    });

    Library.Elements = Library:Create( "ScreenGui" , {
        Parent = Services.CoreGui;
        Name = "\0";
        Enabled = true;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        IgnoreGuiInset = true;
        DisplayOrder = 101;
    });

    Library.RegisterFeature = function(self, Data)
        if not Data or not Data.Name or Data.Name == "" then
            return
        end

        if Data.Flag and Library:ShouldSkipConfigFlag(Data.Flag) then
            return
        end

        table.insert(Library.SearchIndex, Data)
    end

    Library.RevealInstance = function(self, Target)
        if not Target or not Target.Parent then
            return
        end

        local Scroller
        local Current = Target
        while Current do
            if Current:IsA("ScrollingFrame") then
                Scroller = Current
                break
            end
            Current = Current.Parent
        end

        if not Scroller then
            return
        end

        local Relative = Target.AbsolutePosition.Y - Scroller.AbsolutePosition.Y + Scroller.CanvasPosition.Y
        local Goal = math.max(0, Relative - (Scroller.AbsoluteSize.Y * 0.3))
        Scroller.CanvasPosition = Vector2.new(0, Goal)
    end

    Library.ThrobInstance = function(self, Target, Kind)
    end

    Library.AttachFeature = function(self, Owner, Data)
        if not Owner or not Data or not Data.Name then
            return
        end

        local Page = Owner.Page or Owner
        local Tab = Owner.Tab or (Page and Page.Tab)
        local Kind = Data.Kind or "Feature"

        Library:RegisterFeature({
            Name = Data.Name;
            Flag = Data.Flag;
            Kind = Kind;
            Instance = Data.Instance;
            Path = string.format("%s / %s / %s",
                (Tab and Tab.Text) or "Menu",
                (Page and Page.Name) or "Page",
                Owner.Title or Owner.Text or Kind or "Section"
            );
            Navigate = function()
                if Library.Window and Library.Window.Items and Library.Window.Items.SearchResults then
                    Library.Window.Items.SearchResults.Instance.Visible = false
                end

                if Tab and Tab.OpenPage then
                    Tab.OpenPage()
                end

                task.wait(0.05)

                if Page and Page.OpenPage then
                    Page.OpenPage()
                end

                task.wait(0.1)
                Library:RevealInstance(Data.Instance)
            end
        })
    end

    Library.EnsureLogoAsset = function(self)
        local Folder = Library.Directory .. "/Assets"
        local Path = Folder .. "/logo.png"
        local Url = "https://files.catbox.moe/hudoej.png"

        if not isfolder(Folder) then
            makefolder(Folder)
        end

        if not isfile(Path) then
            local Body
            local RequestFn = (syn and syn.request) or http_request or request

            if RequestFn then
                local Ok, Response = pcall(RequestFn, {
                    Url = Url;
                    Method = "GET";
                })

                if Ok and Response then
                    Body = Response.Body or Response.body
                end
            end

            if type(Body) == "string" and #Body > 0 then
                writefile(Path, Body)
            end
        end

        if isfile(Path) and getcustomasset then
            local Ok, Asset = pcall(getcustomasset, Path)
            if Ok and Asset then
                return Asset
            end
        end
    end

    -- // Elements
    Library.CreateWindow = function(self, Data)
        Data = Data or {}
        local Self = self

        local ResolveImage = function(Image)
            if type(Image) ~= "string" or Image == "" then
                return "rbxassetid://98083086936965"
            end

            if string.find(Image, "rbxasset", 1, true) then
                return Image
            end

            if getcustomasset and isfile(Image) then
                return getcustomasset(Image)
            end

            return Image
        end

        local Cfg = {
            Title = Data.Title or "sonata";
            SubText = Data.SubText or "";
            Size = Data.Size or UDim2.fromOffset(960, 548);
            Image = ResolveImage(Data.Image or Data.Logo or "rbxassetid://98083086936965");
            IsMobile = Data.IsMobile or false;

            Position;
            Size;
            Items = {};
            Tweening = false;
            Tick = tick();
            Fps = 0;
            TabInfo;
            Visible = true;
        }

        local Items = Cfg.Items; do
            Items.Menu = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5);
                Parent = Library.Items.Instance;
                ClipsDescendants = true;
                Position = UDim2.new(0.5, 0, 0.5, 75);
                Size = Cfg.Size;
                Visible = true;
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["TopBar"]
            }):Themify("TopBar", "BackgroundColor3")

            Library:Create( "UIScale", {
                Parent = Items.Menu.Instance;
                Scale = 1
            })

            Items.Menu.Instance.Position = UDim2.fromOffset(Items.Menu.Instance.AbsolutePosition.X, Items.Menu.Instance.AbsolutePosition.Y)
            Items.Menu.Instance.AnchorPoint = Vector2.new(0, 0)

            Items.Menu:Draggify()
            Items.Menu:Resizify()

            Library:Create( "UICorner", {
                Parent = Items.Menu.Instance;
                CornerRadius = UDim.new(0, 12)
            })

            Library:Create( "UIStroke", {
                Parent = Items.Menu.Instance;
                Transparency = 0.5
            })

            Items.SideBar = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                Position = UDim2.new(0, 0, 0, HEADER_H);
                Size = UDim2.new(0, SIDE_W, 1, -(HEADER_H + BOTTOM_H));
                BorderSizePixel = 0;
                ClipsDescendants = true;
                BackgroundColor3 = Themes.Preset["SideBar"]
            }):Themify("SideBar", "BackgroundColor3")

            Items.TabButtonHolder = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                AnchorPoint = Vector2.new(0, 1);
                Position = UDim2.new(0, 0, 1, 0);
                Size = UDim2.new(1, 0, 0, BOTTOM_H);
                BorderSizePixel = 0;
                ZIndex = 50;
                BackgroundTransparency = 0;
                BackgroundColor3 = Themes.Preset["BottomBar"]
            }):Themify("BottomBar", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.TabButtonHolder.Instance;
                CornerRadius = UDim.new(0, 12)
            })

            Items.BottomLine = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                AnchorPoint = Vector2.new(0, 1);
                Position = UDim2.new(0, 0, 1, -BOTTOM_H);
                Size = UDim2.new(1, 0, 0, 1);
                BorderSizePixel = 0;
                ZIndex = 55;
                BackgroundColor3 = Themes.Preset["Line"]
            }):Themify("Line", "BackgroundColor3")

            Library:Create( "UIListLayout", {
                Parent = Items.TabButtonHolder.Instance;
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Center;
                Padding = UDim.new(0, 4);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Library:Create( "UIPadding", {
                Parent = Items.TabButtonHolder.Instance;
                PaddingLeft = UDim.new(0, 12);
                PaddingRight = UDim.new(0, 12)
            })

            Library:Create( "Frame", {
                Parent = Items.SideBar.Instance;
                Position = UDim2.new(1, 0, 0, 0);
                Size = UDim2.new(0, 1, 1, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Inline"]
            }):Themify("Inline", "BackgroundColor3")

            Items.Pages = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                BackgroundTransparency = 0;
                Position = UDim2.new(0, SIDE_W, 0, HEADER_H);
                Size = UDim2.new(1, -SIDE_W, 1, -(HEADER_H + BOTTOM_H));
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Background"]
            }):Themify("Background", "BackgroundColor3")

            Library:Create( "UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalFlex = Enum.UIFlexAlignment.Fill;
                Parent = Items.Pages.Instance;
                Padding = UDim.new(0, 10);
                SortOrder = Enum.SortOrder.LayoutOrder;
                VerticalFlex = Enum.UIFlexAlignment.Fill
            })

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, CONTENT_PAD);
                PaddingBottom = UDim.new(0, 16);
                Parent = Items.Pages.Instance;
                PaddingLeft = UDim.new(0, 17);
                PaddingRight = UDim.new(0, 16)
            })

            Items.Topbar = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                BackgroundTransparency = 0;
                Size = UDim2.new(1, 0, 0, HEADER_H);
                BorderSizePixel = 0;
                ZIndex = 6;
                BackgroundColor3 = Themes.Preset["TopBar"]
            }):Themify("TopBar", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.Topbar.Instance;
                CornerRadius = UDim.new(0, 12)
            })

            Library:Create( "Frame", {
                Parent = Items.Topbar.Instance;
                AnchorPoint = Vector2.new(0, 1);
                Position = UDim2.new(0, 0, 1, 0);
                Size = UDim2.new(1, 0, 0, 12);
                BorderSizePixel = 0;
                ZIndex = 6;
                BackgroundColor3 = Themes.Preset["TopBar"]
            }):Themify("TopBar", "BackgroundColor3")

            Items.Subtabs = Library:Create( "Frame", {
                Parent = Items.SideBar.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                BorderSizePixel = 0
            })

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, 10);
                PaddingBottom = UDim.new(0, 10);
                Parent = Items.Subtabs.Instance;
                PaddingRight = UDim.new(0, 10);
                PaddingLeft = UDim.new(0, 10)
            })

            Library:Create( "Frame", {
                Parent = Items.Topbar.Instance;
                AnchorPoint = Vector2.new(0, 1);
                Position = UDim2.new(0, 0, 1, 0);
                Size = UDim2.new(1, 0, 0, 1);
                BorderSizePixel = 0;
                ZIndex = 10;
                BackgroundColor3 = Themes.Preset["Line"]
            }):Themify("Line", "BackgroundColor3")

            Items.LogoHolder = Library:Create( "Frame", {
                Parent = Items.Topbar.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                BorderSizePixel = 0;
                ZIndex = 7
            })

            Items.Logo = Library:Create( "ImageLabel", {
                Visible = true;
                ImageColor3 = Color3.fromRGB(255, 255, 255);
                Parent = Items.LogoHolder.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                Image = Library:EnsureLogoAsset() or Cfg.Image;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 14, 0.5, 0);
                Size = UDim2.new(0, 26, 0, 26);
                ScaleType = Enum.ScaleType.Fit;
                BorderSizePixel = 0;
                ZIndex = 8
            })

            Items.TitleLabel = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Themes.Preset["TextColor"];
                Text = "sonata";
                TextSize = 16;
                Parent = Items.LogoHolder.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 48, 0.5, 0);
                BorderSizePixel = 0;
                ZIndex = 8
            }):Themify("TextColor", "TextColor3")
            Items.TitleLabel.Instance.TextSize = 22

            Items.SearchBar = Library:Create( "Frame", {
                Parent = Items.LogoHolder.Instance;
                AnchorPoint = Vector2.new(1, 0.5);
                Position = UDim2.new(1, -16, 0.5, 0);
                Size = UDim2.new(0, 196, 0, 28);
                BorderSizePixel = 0;
                ZIndex = 8;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.SearchBar.Instance;
                CornerRadius = UDim.new(0, 6)
            })

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Transparency = 0.35;
                Parent = Items.SearchBar.Instance
            }):Themify("ElementOutline", "Color")

            Items.SearchIcon = Library:Create( "ImageLabel", {
                Image = "rbxassetid://6031154871";
                ImageColor3 = Themes.Preset.Unselected;
                Parent = Items.SearchBar.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 8, 0.5, 0);
                Size = UDim2.new(0, 14, 0, 14);
                BorderSizePixel = 0;
                ZIndex = 9
            }):Themify("Unselected", "ImageColor3")

            Items.SearchBox = Library:Create( "TextBox", {
                FontFace = Themes.Preset.Font;
                Text = "";
                PlaceholderText = "Search";
                PlaceholderColor3 = Themes.Preset.Unselected;
                TextColor3 = Themes.Preset.TextColor;
                TextSize = 13;
                ClearTextOnFocus = false;
                Parent = Items.SearchBar.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 28, 0, 0);
                Size = UDim2.new(1, -36, 1, 0);
                TextXAlignment = Enum.TextXAlignment.Left;
                BorderSizePixel = 0;
                ZIndex = 9
            }):Themify("TextColor", "TextColor3")
            Items.SearchBox.Instance.PlaceholderText = "Search"
            Items.SearchBox.Instance.PlaceholderColor3 = Themes.Preset.Unselected
            Items.SearchBox.Instance.TextSize = 13

            Items.SearchResults = Library:Create( "Frame", {
                Parent = Items.Menu.Instance;
                Visible = false;
                Size = UDim2.new(0, 196, 0, 0);
                AutomaticSize = Enum.AutomaticSize.Y;
                BorderSizePixel = 0;
                ZIndex = 120;
                BackgroundColor3 = Themes.Preset["ListBackground"]
            }):Themify("ListBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.SearchResults.Instance;
                CornerRadius = UDim.new(0, 6)
            })

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Parent = Items.SearchResults.Instance
            }):Themify("ElementOutline", "Color")

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, 6);
                PaddingBottom = UDim.new(0, 6);
                PaddingLeft = UDim.new(0, 6);
                PaddingRight = UDim.new(0, 6);
                Parent = Items.SearchResults.Instance
            })

            Items.SearchScroll = Library:Create( "ScrollingFrame", {
                Parent = Items.SearchResults.Instance;
                Size = UDim2.new(1, 0, 0, 220);
                CanvasSize = UDim2.new(0, 0, 0, 0);
                AutomaticCanvasSize = Enum.AutomaticSize.Y;
                ScrollBarThickness = 2;
                BorderSizePixel = 0;
                BackgroundTransparency = 1;
                ZIndex = 121
            })

            Library:Create( "UIListLayout", {
                Parent = Items.SearchScroll.Instance;
                Padding = UDim.new(0, 2);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Cfg.CloseSearch = function()
                Items.SearchResults.Instance.Visible = false
            end

            Cfg.PositionSearch = function()
                local Bar = Items.SearchBar.Instance
                local Menu = Items.Menu.Instance
                local RelX = (Bar.AbsolutePosition.X - Menu.AbsolutePosition.X)
                local RelY = (Bar.AbsolutePosition.Y - Menu.AbsolutePosition.Y) + Bar.AbsoluteSize.Y + 6
                Items.SearchResults.Instance.Position = UDim2.fromOffset(RelX, RelY)
                Items.SearchResults.Instance.Size = UDim2.fromOffset(math.max(Bar.AbsoluteSize.X, 196), 0)
            end

            Cfg.RenderSearch = function(Query)
                Query = string.lower(string.gsub(tostring(Query or ""), "^%s+", ""))
                Query = string.gsub(Query, "%s+$", "")

                for _, Child in Items.SearchScroll.Instance:GetChildren() do
                    if Child:IsA("TextButton") or Child:IsA("TextLabel") or Child:IsA("Frame") then
                        Child:Destroy()
                    end
                end

                if Query == "" then
                    Cfg.CloseSearch()
                    return
                end

                local Matches = {}

                for _, Entry in Library.SearchIndex do
                    local Name = string.lower(tostring(Entry.Name or ""))
                    local Path = string.lower(tostring(Entry.Path or ""))
                    local Flag = string.lower(tostring(Entry.Flag or ""))

                    if string.find(Name, Query, 1, true) or string.find(Path, Query, 1, true) or string.find(Flag, Query, 1, true) then
                        Matches[#Matches + 1] = Entry
                    end
                end

                if #Matches == 0 then
                    local Empty = Library:Create( "TextLabel", {
                        FontFace = Themes.Preset.Font;
                        TextColor3 = Themes.Preset.Unselected;
                        Text = "No features found";
                        Parent = Items.SearchScroll.Instance;
                        Size = UDim2.new(1, 0, 0, 28);
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        ZIndex = 122
                    })
                    Empty.Instance.Text = "No features found"
                else
                    for Index, Entry in Matches do
                        if Index > 40 then
                            break
                        end

                        local Row = Library:Create( "TextButton", {
                            Parent = Items.SearchScroll.Instance;
                            Size = UDim2.new(1, 0, 0, 36);
                            BorderSizePixel = 0;
                            AutoButtonColor = false;
                            Text = "";
                            ZIndex = 122;
                            BackgroundColor3 = Themes.Preset["ElementBackground"]
                        }):Themify("ElementBackground", "BackgroundColor3")

                        Library:Create( "UICorner", {
                            Parent = Row.Instance;
                            CornerRadius = UDim.new(0, 4)
                        })

                        local Title = Library:Create( "TextLabel", {
                            FontFace = Themes.Preset.Font;
                            TextColor3 = Themes.Preset.TextColor;
                            Text = Entry.Name;
                            Parent = Row.Instance;
                            BackgroundTransparency = 1;
                            Position = UDim2.new(0, 8, 0, 2);
                            Size = UDim2.new(1, -16, 0, 16);
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            ZIndex = 123
                        })
                        Title.Instance.Text = Entry.Name

                        local Path = Library:Create( "TextLabel", {
                            FontFace = Themes.Preset.Font;
                            TextColor3 = Themes.Preset.Unselected;
                            Text = Entry.Path or Entry.Kind or "";
                            Parent = Row.Instance;
                            BackgroundTransparency = 1;
                            Position = UDim2.new(0, 8, 0, 18);
                            Size = UDim2.new(1, -16, 0, 14);
                            TextXAlignment = Enum.TextXAlignment.Left;
                            TextSize = 12;
                            BorderSizePixel = 0;
                            ZIndex = 123
                        })
                        Path.Instance.Text = Entry.Path or Entry.Kind or ""
                        Path.Instance.TextSize = 11

                        Row:OnClick(function()
                            Items.SearchBox.Instance.Text = Entry.Name
                            Cfg.CloseSearch()
                            if Entry.Navigate then
                                task.spawn(Entry.Navigate)
                            end
                        end)
                    end
                end

                Cfg.PositionSearch()
                Items.SearchResults.Instance.Visible = true
            end

            Items.SearchBox.Instance.Focused:Connect(function()
                local Text = Items.SearchBox.Instance.Text
                if Text ~= nil and Text ~= "" then
                    Cfg.RenderSearch(Text)
                else
                    Cfg.CloseSearch()
                end
            end)

            Items.SearchBox.Instance:GetPropertyChangedSignal("Text"):Connect(function()
                Cfg.RenderSearch(Items.SearchBox.Instance.Text)
            end)

            Items.SearchBox.Instance.FocusLost:Connect(function()
                task.delay(0.12, function()
                    if not Items.SearchBox.Instance:IsFocused() then
                        -- keep open until outside click if there is a query
                        if Items.SearchBox.Instance.Text == "" then
                            Cfg.CloseSearch()
                        end
                    end
                end)
            end)

            Items.SearchBar:OnClick(function()
                Items.SearchBox.Instance:CaptureFocus()
                if Items.SearchBox.Instance.Text ~= "" then
                    Cfg.RenderSearch(Items.SearchBox.Instance.Text)
                else
                    Cfg.CloseSearch()
                end
            end)

            Items.Menu.Instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                if Items.SearchResults.Instance.Visible then
                    Cfg.PositionSearch()
                end
            end)

            Items.Menu.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if Items.SearchResults.Instance.Visible then
                    Cfg.PositionSearch()
                end
            end)

            Library:Connect(Services.UserInputService.InputBegan, function(Input)
                if not Items.SearchResults.Instance.Visible then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    local Mouse = Services.UserInputService:GetMouseLocation()
                    local Inset = Services.GuiService:GetGuiInset()
                    local X, Y = Mouse.X, Mouse.Y - Inset.Y

                    local function Inside(Gui)
                        local Pos = Gui.AbsolutePosition
                        local Size = Gui.AbsoluteSize
                        return X >= Pos.X and X <= Pos.X + Size.X and Y >= Pos.Y and Y <= Pos.Y + Size.Y
                    end

                    if not Inside(Items.SearchResults.Instance) and not Inside(Items.SearchBar.Instance) then
                        Cfg.CloseSearch()
                    end
                end
            end)

            Cfg.SetLogo = function(Image)
                Image = ResolveImage(Image)
                Items.Logo.Instance.Visible = true
                Items.Logo.Instance.Size = UDim2.new(0, 26, 0, 26)
                Items.Logo.Instance.Image = Image
                Items.TitleLabel.Instance.Position = UDim2.new(0, 48, 0.5, 0)
                Cfg.Image = Image
            end

            Items.MobileFrame = Library:Create( "Frame", {
                Visible = false;
                Parent = Items.Menu.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 71);
                Size = UDim2.new(1, 0, 1, -71);
                ZIndex = 100;
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Background"]
            }):Themify("Background", "BackgroundColor3")

            Items.MobileFrame2 = Library:Create( "Frame", {
                Visible = false;
                Parent = Items.Menu.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 71, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 100;
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Background"]
            }):Themify("Background", "BackgroundColor3");

                        -- // keybind list top
            Items.KeybindList = Library:Create("Frame",{Visible = false; ZIndex = 999; Parent = Library.HUD.Instance; Size = UDim2.new(0, 200, 0, 31); Position = UDim2.new(0, 37, 0, 401); BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(20, 20, 22)})
            Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(23, 24, 27); Parent = Items.KeybindList.Instance})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 2); PaddingBottom = UDim.new(0, 2); Parent = Items.KeybindList.Instance; PaddingRight = UDim.new(0, 2); PaddingLeft = UDim.new(0, 2)})
            Items.UICorner = Library:Create("UICorner",{Parent = Items.KeybindList.Instance})
            Items.Titles = Library:Create("TextLabel",{LayoutOrder = 1; TextColor3 = Color3.fromRGB(245, 245, 245); Text = "Keybinds"; Parent = Items.KeybindList.Instance; AutomaticSize = Enum.AutomaticSize.XY; Position = UDim2.new(0, 0, 0, 3); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 6); Parent = Items.Titles.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 7)})
            Items.Filler = Library:Create("Frame",{Parent = Items.KeybindList.Instance; Position = UDim2.new(0, -3, 1, -14); Size = UDim2.new(1, 6, 0, 18); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(20, 20, 22)})
            Items.BottomFiller = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Filler.Instance; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(23, 24, 27)})
            Items.KeyboardIcon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset.Accent; Parent = Items.KeybindList.Instance; Size = UDim2.new(0, 18, 0, 18); AnchorPoint = Vector2.new(1, 0); Image = "rbxassetid://97239058232142"; BackgroundTransparency = 1; Position = UDim2.new(1, -5, 0, 5); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "ImageColor3")

            Items.KeybindList:Draggify()


            -- // Where the keybinds are parented
            Items.KeybindHolder = Library:Create("Frame",{ZIndex = 0; Parent = Items.KeybindList.Instance; Size = UDim2.new(0, 200, 0, 0); Position = UDim2.new(0, -2, 0, 18); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(15, 16, 18)})
            Items.UICorner = Library:Create("UICorner",{Parent = Items.KeybindHolder.Instance})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 18); PaddingBottom = UDim.new(0, 2); Parent = Items.KeybindHolder.Instance; PaddingRight = UDim.new(0, 2); PaddingLeft = UDim.new(0, 2)})
            Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(23, 24, 27); Parent = Items.KeybindHolder.Instance})


            -- // Modlist list top
            Items.ModList = Library:Create("Frame",{Visible = false; ZIndex = 999; Parent = Library.HUD.Instance; Size = UDim2.new(0, 200, 0, 31); Position = UDim2.new(0, 37 + 200 + 10, 0, 401); BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(20, 20, 22)})
            Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(23, 24, 27); Parent = Items.ModList.Instance})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 2); PaddingBottom = UDim.new(0, 2); Parent = Items.ModList.Instance; PaddingRight = UDim.new(0, 2); PaddingLeft = UDim.new(0, 2)})
            Items.UICorner = Library:Create("UICorner",{Parent = Items.ModList.Instance})
            Items.Titles = Library:Create("TextLabel",{LayoutOrder = 1; TextColor3 = Color3.fromRGB(245, 245, 245); Text = "Mods"; Parent = Items.ModList.Instance; AutomaticSize = Enum.AutomaticSize.XY; Position = UDim2.new(0, 0, 0, 3); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 6); Parent = Items.Titles.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 7)})
            Items.Filler = Library:Create("Frame",{Parent = Items.ModList.Instance; Position = UDim2.new(0, -3, 1, -14); Size = UDim2.new(1, 6, 0, 18); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(20, 20, 22)})
            Items.BottomFiller = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Filler.Instance; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(23, 24, 27)})
            Items.KeyboardIcon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset.Accent; Parent = Items.ModList.Instance; Size = UDim2.new(0, 18, 0, 18); AnchorPoint = Vector2.new(1, 0); Image = "rbxassetid://74208295465261"; BackgroundTransparency = 1; Position = UDim2.new(1, -5, 0, 5); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "ImageColor3")

            Items.ModList:Draggify()

            -- // Where the Mods are parented
            Items.ModHolder = Library:Create("Frame",{ZIndex = 0; Parent = Items.ModList.Instance; Size = UDim2.new(0, 200, 0, 0); Position = UDim2.new(0, -2, 0, 18); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(15, 16, 18)})
            Items.UICorner = Library:Create("UICorner",{Parent = Items.ModHolder.Instance})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 18); PaddingBottom = UDim.new(0, 2); Parent = Items.ModHolder.Instance; PaddingRight = UDim.new(0, 2); PaddingLeft = UDim.new(0, 2)})
            Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(23, 24, 27); Parent = Items.ModHolder.Instance})
        end

        Items.Menu.Instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            if Cfg.Visible or Cfg.Tweening then
                return
            end

            Cfg.Position = Items.Menu.Instance.AbsolutePosition
        end)

        Items.Menu.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            if not Cfg.Visible or Cfg.Tweening then
                return
            end

            local AbsoluteSize = Items.Menu.Instance.AbsoluteSize
            Cfg.Size = Vector2.new(AbsoluteSize.X, AbsoluteSize.Y)
        end)

        Items.Watermark = Library:Create("Frame", {
            Parent = Library.HUD.Instance;
            AnchorPoint = Vector2.new(0.5, 0);
            Position = UDim2.new(0.5, 0, 0, 14);
            BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY;
            Visible = true;
            ZIndex = 100;
            BackgroundColor3 = Themes.Preset.TopBar
        }):Themify("TopBar", "BackgroundColor3"):Draggify()

        Items.Title = Library:Create("TextLabel", {
            LayoutOrder = 1;
            TextColor3 = Library:GetContrastingText(Themes.Preset.TopBar);
            Text = "sonata.dev";
            FontFace = Themes.Preset.Font;
            TextSize = 13;
            Parent = Items.Watermark.Instance;
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })

        Library:Create("UIPadding", {
            PaddingTop = UDim.new(0, 6);
            PaddingBottom = UDim.new(0, 6);
            Parent = Items.Title.Instance;
            PaddingRight = UDim.new(0, 10);
            PaddingLeft = UDim.new(0, 10)
        })

        Library:Create("UIPadding", {
            PaddingTop = UDim.new(0, 2);
            PaddingBottom = UDim.new(0, 2);
            Parent = Items.Watermark.Instance;
            PaddingRight = UDim.new(0, 2);
            PaddingLeft = UDim.new(0, 2)
        })

        Library:Create("UICorner", {
            Parent = Items.Watermark.Instance;
            CornerRadius = UDim.new(0, 6)
        })

        Library:Create("UIStroke", {
            Color = Themes.Preset.ElementOutline;
            Transparency = 0.35;
            Parent = Items.Watermark.Instance
        }):Themify("ElementOutline", "Color")

        Library:SyncWatermarkStyle()

        local AbsoluteSize = Items.Menu.Instance.AbsoluteSize
        Cfg.Size = Vector2.new(AbsoluteSize.X, AbsoluteSize.Y)

        local Frames = 0
        local FPS = 0
        local LastTick = tick()
        Services.RunService.RenderStepped:Connect(function()
            Frames += 1
            local Tick = tick()

            if Tick - LastTick >= 1 then
                FPS = Frames
                Frames = 0
                LastTick = Tick
            end

            local Time = os.date("%I:%M %p")
            Time = string.gsub(Time, "^0", "")
            Items.Title.Instance.Text = string.format("sonata.dev | %s | %s | Build: developer", tostring(FPS), Time)
        end)

        function Cfg.SetVisible(Bool)
            if Bool == nil then
                Bool = not Cfg.Visible
            end

            if Cfg.Visible == Bool and Items.Menu.Instance.Visible == Bool then
                return
            end

            Cfg.Visible = Bool
            Library.KillBlur()

            if not Cfg.IsMobile then
                Items.Menu:TweenDescendants(Bool, Cfg)
                return
            end

            if not Cfg.Size then
                return
            end

            Items.MobileFrame:Tween({BackgroundTransparency = Bool and 1 or 0})
            Items.MobileFrame2:Tween({BackgroundTransparency = Bool and 1 or 0})
            Items.Menu:Tween({Size = Bool and UDim2.new(0, Cfg.Size.X, 0, Cfg.Size.Y) or UDim2.new(0, 70, 0, 70)})

            if not (Items.Subtabs.Instance.Visible and Bool) then
                Items.Subtabs:TweenDescendants(Bool, Cfg)
            end

            Cfg.Tweening = false

            if not (Items.SideBar.Instance.Visible and Bool) then
                Items.SideBar:TweenDescendants(Bool, Cfg)
            end
        end

        if Cfg.IsMobile then
            task.delay(Library.TweeningSpeed, function()
                Items.Menu:TweenDescendants(true, Cfg)
            end)

            Items.TitleLabel:OnClick(function()
                if Cfg.Tweening then
                    return
                end

                Cfg.Visible = not Cfg.Visible

                Cfg.SetVisible(Cfg.Visible)
            end)
        end

        Library.Window = setmetatable(Cfg, Library)
        Library.KillBlur()

        return Library.Window
    end

    Library.AddTab = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Name or Data.Title or "Tab";
            Icon = Data.Icon or "rbxassetid://108020878442937";
            Pages = Data.Pages or {"Page 1", "Page 2"};

            -- DO NOT TOUCH
            Sections = {};
            Enabled = false;
            Items = {};
            Tweening = false;
        }

        table.insert(Library.Tabs, Cfg)

        local Items = Cfg.Items; do
            do -- Button
                local TabWidth = math.max(72, (#Cfg.Text * 8) + 28)

                Items.Button = Library:Create( "TextButton", {
                    Parent = self.Items.TabButtonHolder.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0, TabWidth, 1, 0);
                    AutomaticSize = Enum.AutomaticSize.X;
                    ZIndex = 51;
                    BorderSizePixel = 0;
                    Text = "";
                    AutoButtonColor = false
                })

                Items.Icon = Library:Create( "ImageLabel", {
                    ImageColor3 = Themes.Preset["Unselected"];
                    Parent = Items.Button.Instance;
                    Visible = false;
                    Size = UDim2.new(0, 0, 0, 0);
                    Image = Cfg.Icon;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    ZIndex = 52
                }):Themify("Unselected", "ImageColor3")

                Items.Title = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Themes.Preset["Unselected"];
                    Text = Cfg.Text;
                    TextSize = 14;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    Parent = Items.Button.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                    BorderSizePixel = 0;
                    ZIndex = 52
                }):Themify("Unselected", "TextColor3")

                Items.Accent = Library:Create( "Frame", {
                    Parent = Items.Button.Instance;
                    AnchorPoint = Vector2.new(0.5, 1);
                    Position = UDim2.new(0.5, 0, 1, -6);
                    Size = UDim2.new(0, 0, 0, 2);
                    BorderSizePixel = 0;
                    ZIndex = 53;
                    BackgroundColor3 = Themes.Preset["Accent"]
                }):Themify("Accent", "BackgroundColor3")

                Items.Glow = Items.Accent
                Items.GlowImage = Items.Accent
                Items.Background = Items.Button
                Items.Filler = Items.Button
            end

            do -- Page
                Items.MainPage = Library:Create( "Frame", {
                    Parent = Library.Other.Instance; -- self.Items.Main.Instance
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, SIDE_W, 0, HEADER_H + CONTENT_PAD);
                    Size = UDim2.new(1, -SIDE_W, 1, -(HEADER_H + BOTTOM_H + CONTENT_PAD));
                    BorderSizePixel = 0;
                    ZIndex = 2
                })
            end

            do -- Subtabs
                Items.Holder = Library:Create( "Frame", {
                    Parent = Library.Other.Instance; -- self.Items.Subtabs.Instance
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    Visible = false;
                    BackgroundTransparency = 1
                })

                Library:Create( "UIListLayout", {
                    Parent = Items.Holder.Instance;
                    Padding = UDim.new(0, 2);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Vertical
                })
            end
        end

        for _,Page in Cfg.Pages do
            local PageData = {
               Items = {},
               Tweening = false,
               Tab = Cfg,
               Name = Page,
               Window = self,
            }

            local ButtonParent = Items.Holder
            local PageParent = Items.MainPage

            local MiscItems = PageData.Items; do
                -- // Button
                MiscItems.Button = Library:Create( "Frame", {
                    Parent = ButtonParent.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, 30);
                    BorderSizePixel = 0;
                    ZIndex = 5
                })

                MiscItems.Indicator = Library:Create( "Frame", {
                    Parent = MiscItems.Button.Instance;
                    AnchorPoint = Vector2.new(0, 0.5);
                    Position = UDim2.new(0, 0, 0.5, 0);
                    Size = UDim2.new(0, 0, 0, 14);
                    BorderSizePixel = 0;
                    BackgroundColor3 = Themes.Preset["Accent"]
                }):Themify("Accent", "BackgroundColor3")

                Library:Create( "UICorner", {
                    Parent = MiscItems.Indicator.Instance;
                    CornerRadius = UDim.new(1, 0)
                })

                MiscItems.Text = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    Parent = MiscItems.Button.Instance;
                    TextColor3 = Themes.Preset["Unselected"];
                    Text = Page;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    AnchorPoint = Vector2.new(0, 0.5);
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 12, 0.5, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2
                }):Themify("Unselected", "TextColor3"):Themify("TextColor", "TextColor3")

                MiscItems.Outline = Library:Create( "UIStroke", {
                    Color = Themes.Preset["Accent"];
                    Transparency = 1;
                    Parent = MiscItems.Button.Instance
                }):Themify("Accent", "Color")

                --// Page
                MiscItems.Page = Library:Create( "Frame", {
                    Parent = Library.Other.Instance; -- PageParent.Instance
                    BackgroundTransparency = 1;
                    Visible = false;
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 0);
                    PaddingBottom = UDim.new(0, 16);
                    Parent = MiscItems.Page.Instance;
                    PaddingLeft = UDim.new(0, 17);
                    PaddingRight = UDim.new(0, 16)
                })

                Library:Create( "UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = MiscItems.Page.Instance;
                    Padding = UDim.new(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })

                MiscItems.Left = Library:Create( "ScrollingFrame", {
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    Parent = MiscItems.Page.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0, 100, 0, 100);
                    BorderSizePixel = 0;
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 1);
                    PaddingBottom = UDim.new(0, 1);
                    Parent = MiscItems.Left.Instance;
                    PaddingRight = UDim.new(0, 1);
                    PaddingLeft = UDim.new(0, 1)
                })

                Library:Create( "UIListLayout", {
                    Parent = MiscItems.Left.Instance;
                    Padding = UDim.new(0, 15);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                MiscItems.Middle = Library:Create( "ScrollingFrame", {
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    Parent = MiscItems.Page.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0, 100, 0, 100);
                    CanvasSize = UDim2.new(0, 0, 0, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 1);
                    PaddingBottom = UDim.new(0, 1);
                    Parent = MiscItems.Middle.Instance;
                    PaddingRight = UDim.new(0, 1);
                    PaddingLeft = UDim.new(0, 1)
                })

                Library:Create( "UIListLayout", {
                    Parent = MiscItems.Middle.Instance;
                    Padding = UDim.new(0, 15);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                MiscItems.Right = Library:Create( "ScrollingFrame", {
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    Parent = MiscItems.Page.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0, 100, 0, 100);
                    CanvasSize = UDim2.new(0, 0, 0, 0);
                    BorderSizePixel = 0
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 1);
                    PaddingBottom = UDim.new(0, 1);
                    Parent = MiscItems.Right.Instance;
                    PaddingRight = UDim.new(0, 1);
                    PaddingLeft = UDim.new(0, 1)
                })

                Library:Create( "UIListLayout", {
                    Parent = MiscItems.Right.Instance;
                    Padding = UDim.new(0, 15);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            PageData.OpenPage = function()
                local OldTab = Cfg.TabInfo

                if OldTab == PageData then
                    return
                end

                if PageData.Tweening or (OldTab and OldTab.Tweening) then
                    return
                end

                if OldTab then
                    OldTab.Items.Text:Tween({TextColor3 = Themes.Preset.Unselected})
                    OldTab.Items.Indicator:Tween({Size = UDim2.new(0, 0, 0, 14)})
                    OldTab.Items.Page:TweenDescendants(false, OldTab)
                end

                MiscItems.Text:Tween({TextColor3 = Themes.Preset.TextColor})
                MiscItems.Indicator:Tween({Size = UDim2.new(0, 2, 0, 14)})
                MiscItems.Page.Instance.Size = UDim2.new(1, -40, 1, -40)
                MiscItems.Page:Tween({Size = UDim2.new(1, 0, 1, 0)})
                MiscItems.Page:TweenDescendants(true, PageData)

                Cfg.TabInfo = PageData
            end

            MiscItems.Button:OnClick(PageData.OpenPage)
            MiscItems.Page:Reparent(PageParent.Instance)

            if not Cfg.TabInfo then
                MiscItems.Indicator.Instance.Size = UDim2.new(0, 2, 0, 14)
                PageData.OpenPage()
            end

            Cfg.Sections[#Cfg.Sections + 1] = setmetatable(PageData, Library)
        end

        Cfg.OpenPage = function()
            local OldTab = self.TabInfo

            if OldTab == Cfg then
                return
            end

            if Cfg.Tweening or (OldTab and OldTab.Tweening) then
                return
            end

            if OldTab then
                OldTab.Items.Title:Tween({TextColor3 = Themes.Preset.Unselected})
                OldTab.Items.Accent:Tween({Size = UDim2.new(0, 0, 0, 2)})

                OldTab.Items.MainPage:TweenDescendants(false, self)
                self.Tweening = false
                OldTab.Items.Holder:TweenDescendants(false, self)
            end

            Items.Title:Tween({TextColor3 = Themes.Preset.Accent})
            Items.Accent:Tween({Size = UDim2.new(1, -20, 0, 2)})

            Items.MainPage.Instance.Position = UDim2.new(0, SIDE_W, 0, HEADER_H + CONTENT_PAD)
            Items.MainPage.Instance.Size = UDim2.new(1, -SIDE_W - 40, 1, -(HEADER_H + BOTTOM_H + CONTENT_PAD) - 40);
            Items.MainPage:Tween({Size = UDim2.new(1, -SIDE_W, 1, -(HEADER_H + BOTTOM_H + CONTENT_PAD))})

            Items.MainPage:TweenDescendants(true, Cfg)
            Cfg.Tweening = false
            Items.Holder:TweenDescendants(true, Cfg)

            self.TabInfo = Cfg
        end

        Items.Holder:Reparent(self.Items.Subtabs.Instance)
        Items.MainPage:Reparent(self.Items.Menu.Instance)
        Items.Button:OnClick(Cfg.OpenPage)

        Items.Accent.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            task.wait()

            if self.TabInfo == Cfg then
                Items.Title:Tween({TextColor3 = Themes.Preset.Accent})
            end
        end)

        if not self.TabInfo then
            Cfg.OpenPage()
        end

        return unpack(Cfg.Sections)
    end

    Library.AddSection = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Title = Data.Title or Data.Text or Data.Name or "Title";
            Side = Data.Side or "Left";
            Collasped = Data.Collapsed or false;
            Collapsed = Data.Collapsed or false;

            Items = {};
            Tweening = false;
            CachedSize = 0;
            Incrementing = false;
            Page = self;
            Tab = self.Tab;
            Window = self.Window or Library.Window;
        }

        if not self.SectionList then
            self.SectionList = {}
        end

        Cfg.LayoutOrder = (#self.SectionList + 1) * 10
        table.insert(self.SectionList, Cfg)

        local function GetColumn(Side)
            Side = Side or Cfg.Side
            if self.Items and self.Items[Side] then
                return self.Items[Side]
            end
        end

        local function GetScale()
            local Column = GetColumn(Cfg.Side)
            if Column and Column.Instance then
                return 1, 0
            end

            return 0, 200
        end

        local ScalingSize, OffsetSize = GetScale()

        local Items = Cfg.Items; do
            Items.Section = Library:Create( "Frame", {
                Parent = (GetColumn(Cfg.Side) and GetColumn(Cfg.Side).Instance) or Library.Other.Instance;
                Size = UDim2.new(ScalingSize, OffsetSize, 0, 0);
                Position = UDim2.new(0, 1, 0, 0);
                BorderSizePixel = 0;
                ClipsDescendants = true;
                LayoutOrder = Cfg.LayoutOrder;
                BackgroundColor3 = Themes.Preset["SectionBackground"]
            }):Themify("SectionBackground", "BackgroundColor3")

            Items.TitleLabel = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(255, 255, 255);
                Text = Cfg.Title;
                Parent = Items.Section.Instance;
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 12, 0, 10);
                BorderSizePixel = 0;
                ZIndex = 5
            })
            Items.TitleLabel.Instance.Text = Cfg.Title

            Items.Elements = Library:Create( "Frame", {
                Parent = Items.Section.Instance;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 12, 0, 43);
                Size = UDim2.new(1, -24, 0, 0);
                BorderSizePixel = 0;
                AutomaticSize = Enum.AutomaticSize.Y
            })

            Library:Create( "UIPadding", {
                PaddingBottom = UDim.new(0, 8);
                Parent = Items.Elements.Instance
            })

            Library:Create( "UIListLayout", {
                Parent = Items.Elements.Instance;
                Padding = UDim.new(0, 13);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Library:Create( "UICorner", {
                Parent = Items.Section.Instance;
                CornerRadius = UDim.new(0, 6)
            })

            Library:Create( "UIStroke", {
                Color = Themes.Preset["Inline"];
                Parent = Items.Section.Instance
            }):Themify("Inline", "Color")

            Items.TopBar = Library:Create( "TextButton", {
                Parent = Items.Section.Instance;
                Size = UDim2.new(1, 0, 0, 35);
                BorderSizePixel = 0;
                AutoButtonColor = false;
                Text = "";
                Active = true;
                ZIndex = 3;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Items.Filler1 = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(0, 1);
                Parent = Items.TopBar.Instance;
                Position = UDim2.new(0, 0, 1, 0);
                Size = UDim2.new(1, 0, 0, 6);
                BorderSizePixel = 0;
                ZIndex = 3;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.TopBar.Instance;
                CornerRadius = UDim.new(0, 6)
            })

            -- Accent line under the title bar (kept above fillers)
            Items.Filler2 = Library:Create( "Frame", {
                Parent = Items.Section.Instance;
                Position = UDim2.new(0, 0, 0, 34);
                Size = UDim2.new(1, 0, 0, 1);
                BorderSizePixel = 0;
                ZIndex = 7;
                BackgroundColor3 = Themes.Preset["Line"]
            }):Themify("Line", "BackgroundColor3")

            Items.Image = Library:Create( "ImageLabel", {
                Parent = Items.TopBar.Instance;
                Size = UDim2.new(0, 9, 0, 6);
                AnchorPoint = Vector2.new(1, 0.5);
                Image = "rbxassetid://75133155165707";
                BackgroundTransparency = 1;
                Position = UDim2.new(1, -11, 0.5, 0);
                Rotation = 0;
                BorderSizePixel = 0;
                ZIndex = 8;
                BackgroundColor3 = Themes.Preset.Other
            }):Themify("Other", "BackgroundColor3")
        end

        local Section = Items.Section.Instance

        Cfg.ApplySize = function()
            local Scale, Offset = GetScale()
            ScalingSize, OffsetSize = Scale, Offset
            local Height = Cfg.Collapsed and 35 or (Cfg.CachedSize + 40)
            Items.Section.Instance.Size = UDim2.new(Scale, Offset, 0, Height)
        end

        Cfg.Collapse = function(bool)
            if Cfg.Tweening then
                return
            end

            Cfg.Collapsed = bool

            local Scale, Offset = GetScale()
            ScalingSize, OffsetSize = Scale, Offset

            if bool then
                Items.Section:Tween({Size = UDim2.new(Scale, Offset, 0, 35)})
                Items.Filler1:Tween({BackgroundTransparency = 1})
                Items.Filler2:Tween({BackgroundTransparency = 1})
                Items.Image:Tween({Rotation = 180})

                Items.Elements:Tween({Position = UDim2.new(0, 12, 0, 23)})
                Items.Elements:TweenDescendants(false, Cfg)
            else
                Items.Section:Tween({Size = UDim2.new(Scale, Offset, 0, Cfg.CachedSize + 36)})
                Items.Filler1:Tween({BackgroundTransparency = 0})
                Items.Filler2:Tween({BackgroundTransparency = 0})
                Items.Image:Tween({Rotation = 0})

                Items.Elements:Tween({Position = UDim2.new(0, 12, 0, 43)})
                Items.Elements:TweenDescendants(true, Cfg)
            end
        end

        Items.Image:OnClick(function()
            if Cfg.Tweening or Library.DraggingSection then
                return
            end

            Cfg.Collapsed = not Cfg.Collapsed

            Cfg.Collapse(Cfg.Collapsed)
        end)

        Cfg.UpdateSection = function(Instance)
            task.spawn(function()
                if not Cfg.Collapsed then
                    Cfg.CachedSize += Instance.AbsoluteSize.Y + 13
                    local Scale, Offset = GetScale()
                    Items.Section:Tween({Size = UDim2.new(Scale, Offset, 0, Cfg.CachedSize + 40)})
                end
            end)
        end

        do -- Drag rearrange / column swap
            local DragState = {
                Active = false;
                Moved = false;
                Start = nil;
                Ghost = nil;
                Placeholder = nil;
                TargetSide = Cfg.Side;
                TargetOrder = Cfg.LayoutOrder;
                SwapWith = nil;
            }

            local function DestroyDragVisuals()
                if DragState.Ghost then
                    DragState.Ghost:Destroy()
                    DragState.Ghost = nil
                end

                if DragState.Placeholder then
                    DragState.Placeholder:Destroy()
                    DragState.Placeholder = nil
                end
            end

            local function ColumnHit(X, Y)
                local BestName, BestCol, BestDist = nil, nil, math.huge

                for _, Name in { "Left", "Middle", "Right" } do
                    local Col = self.Items and self.Items[Name]
                    if not (Col and Col.Instance) then
                        continue
                    end

                    local Pos = Col.Instance.AbsolutePosition
                    local Size = Col.Instance.AbsoluteSize
                    local Inside = X >= Pos.X and X <= Pos.X + Size.X and Y >= Pos.Y - 20 and Y <= Pos.Y + Size.Y + 20
                    local Dist = math.abs((Pos.X + Size.X * 0.5) - X)

                    if Inside then
                        return Name, Col
                    end

                    if Dist < BestDist then
                        BestDist = Dist
                        BestName = Name
                        BestCol = Col
                    end
                end

                return BestName, BestCol
            end

            local function FindSectionAt(Side, Y)
                for _, Other in self.SectionList do
                    if Other ~= Cfg and Other.Side == Side and Other.Items and Other.Items.Section then
                        local Inst = Other.Items.Section.Instance
                        if Inst.Visible and Inst.Parent then
                            local Pos = Inst.AbsolutePosition
                            local Size = Inst.AbsoluteSize
                            if Y >= Pos.Y and Y <= Pos.Y + Size.Y then
                                return Other
                            end
                        end
                    end
                end
            end

            local function ResolveInsertOrder(Column, Side, Y)
                local Orders = {}

                for _, Other in self.SectionList do
                    if Other ~= Cfg and Other.Side == Side and Other.Items and Other.Items.Section then
                        local Inst = Other.Items.Section.Instance
                        if Inst.Parent == Column.Instance then
                            table.insert(Orders, {
                                Mid = Inst.AbsolutePosition.Y + Inst.AbsoluteSize.Y * 0.5;
                                Order = Other.LayoutOrder or Inst.LayoutOrder or 0;
                            })
                        end
                    end
                end

                table.sort(Orders, function(A, B)
                    return A.Mid < B.Mid
                end)

                for Index, Entry in Orders do
                    if Y < Entry.Mid then
                        local Prev = Orders[Index - 1]
                        if Prev then
                            local Insert = math.floor((Prev.Order + Entry.Order) / 2)
                            if Insert <= Prev.Order then
                                Insert = Prev.Order + 1
                            end
                            return Insert
                        end
                        return Entry.Order - 5
                    end
                end

                if #Orders > 0 then
                    return Orders[#Orders].Order + 10
                end

                return Cfg.LayoutOrder or 10
            end

            local function EnsurePlaceholder(Mode, Column, Side, Order, SwapSection, Height)
                local Menu = (Cfg.Window and Cfg.Window.Items and Cfg.Window.Items.Menu and Cfg.Window.Items.Menu.Instance) or Library.Items.Instance

                if not DragState.Placeholder then
                    local Holder = Instance.new("CanvasGroup")
                    Holder.Name = "SonataDropPreview"
                    Holder.BorderSizePixel = 0
                    Holder.BackgroundColor3 = Color3.fromRGB(110, 110, 118)
                    Holder.BackgroundTransparency = 0.35
                    Holder.GroupTransparency = 0.2
                    Holder.ZIndex = 440

                    local Corner = Instance.new("UICorner")
                    Corner.CornerRadius = UDim.new(0, 6)
                    Corner.Parent = Holder

                    local Stroke = Instance.new("UIStroke")
                    Stroke.Color = Color3.fromRGB(180, 180, 188)
                    Stroke.Transparency = 0.45
                    Stroke.Thickness = 1
                    Stroke.Parent = Holder

                    local Soft = Instance.new("Frame")
                    Soft.BorderSizePixel = 0
                    Soft.BackgroundColor3 = Color3.fromRGB(160, 160, 168)
                    Soft.BackgroundTransparency = 0.7
                    Soft.Size = UDim2.new(1, 0, 1, 0)
                    Soft.Parent = Holder

                    local SoftCorner = Instance.new("UICorner")
                    SoftCorner.CornerRadius = UDim.new(0, 6)
                    SoftCorner.Parent = Soft

                    DragState.Placeholder = Holder
                end

                local Preview = DragState.Placeholder
                Preview.Visible = true

                if Mode == "Swap" and SwapSection and SwapSection.Items and SwapSection.Items.Section then
                    local Target = SwapSection.Items.Section.Instance
                    local Pos = Target.AbsolutePosition
                    local Size = Target.AbsoluteSize
                    Preview.Parent = Menu
                    Preview.Size = UDim2.fromOffset(Size.X, Size.Y)
                    Preview.Position = UDim2.fromOffset(Pos.X - Menu.AbsolutePosition.X, Pos.Y - Menu.AbsolutePosition.Y)
                    Preview.LayoutOrder = 0
                else
                    Preview.Parent = Column.Instance
                    Preview.Size = UDim2.new(1, 0, 0, math.max(Height or 80, 48))
                    Preview.Position = UDim2.new(0, 0, 0, 0)
                    Preview.LayoutOrder = Order or 10
                end
            end

            local function StartGhost()
                DestroyDragVisuals()

                local Abs = Section.AbsolutePosition
                local Size = Section.AbsoluteSize
                local Menu = (Cfg.Window and Cfg.Window.Items and Cfg.Window.Items.Menu and Cfg.Window.Items.Menu.Instance) or Library.Items.Instance

                local Ghost = Instance.new("Frame")
                Ghost.Name = "SonataSectionGhost"
                Ghost.BorderSizePixel = 0
                Ghost.BackgroundColor3 = Themes.Preset.SectionBackground
                Ghost.BackgroundTransparency = 0.12
                Ghost.Size = UDim2.fromOffset(Size.X, Size.Y)
                Ghost.Position = UDim2.fromOffset(Abs.X - Menu.AbsolutePosition.X, Abs.Y - Menu.AbsolutePosition.Y)
                Ghost.ZIndex = 450
                Ghost.Parent = Menu

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Ghost

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = Themes.Preset.Line
                Stroke.Thickness = 1.5
                Stroke.Parent = Ghost

                local Bar = Instance.new("Frame")
                Bar.BorderSizePixel = 0
                Bar.Size = UDim2.new(1, 0, 0, 35)
                Bar.BackgroundColor3 = Themes.Preset.ElementBackground
                Bar.Parent = Ghost

                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 6)
                BarCorner.Parent = Bar

                local Line = Instance.new("Frame")
                Line.BorderSizePixel = 0
                Line.Position = UDim2.new(0, 0, 0, 34)
                Line.Size = UDim2.new(1, 0, 0, 1)
                Line.BackgroundColor3 = Themes.Preset.Line
                Line.ZIndex = 2
                Line.Parent = Ghost

                local Title = Instance.new("TextLabel")
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.fromOffset(12, 8)
                Title.Size = UDim2.new(1, -24, 0, 18)
                Title.FontFace = Themes.Preset.Font
                Title.TextSize = 14
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Text = Cfg.Title
                Title.ZIndex = 3
                Title.Parent = Ghost

                DragState.Ghost = Ghost
                Section.Visible = false
            end

            local function TweenSeat(Inst, Side, Order, FromAbs, ToAbs)
                local Column = GetColumn(Side)
                if not Column then
                    return
                end

                local Menu = (Cfg.Window and Cfg.Window.Items and Cfg.Window.Items.Menu and Cfg.Window.Items.Menu.Instance) or Library.Items.Instance
                local Size = Inst.AbsoluteSize
                if Size.X < 2 or Size.Y < 2 then
                    Size = Vector2.new(Column.Instance.AbsoluteSize.X, math.max(80, Cfg.CachedSize + 40))
                end

                Inst.Visible = true
                Inst.Parent = Menu
                Inst.Size = UDim2.fromOffset(Size.X, Size.Y)
                Inst.ZIndex = 451

                if FromAbs then
                    Inst.Position = UDim2.fromOffset(FromAbs.X - Menu.AbsolutePosition.X, FromAbs.Y - Menu.AbsolutePosition.Y)
                end

                local Goal = UDim2.fromOffset(ToAbs.X - Menu.AbsolutePosition.X, ToAbs.Y - Menu.AbsolutePosition.Y)
                local Tw = Services.TweenService:Create(Inst, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Goal;
                })
                Tw:Play()
                Tw.Completed:Wait()

                Inst.Parent = Column.Instance
                Inst.LayoutOrder = Order
                Inst.Position = UDim2.new(0, 0, 0, 0)
                Inst.ZIndex = 1
            end

            local function FinishDrop()
                local Side = DragState.TargetSide or Cfg.Side
                local Column = GetColumn(Side)
                local Menu = (Cfg.Window and Cfg.Window.Items and Cfg.Window.Items.Menu and Cfg.Window.Items.Menu.Instance) or Library.Items.Instance
                local Ghost = DragState.Ghost
                local SwapWith = DragState.SwapWith

                if not Column then
                    Section.Visible = true
                    DestroyDragVisuals()
                    return
                end

                if SwapWith and SwapWith ~= Cfg and SwapWith.Items and SwapWith.Items.Section then
                    local Other = SwapWith
                    local OtherInst = Other.Items.Section.Instance
                    local MySide, MyOrder = Cfg.Side, Cfg.LayoutOrder
                    local TheirSide, TheirOrder = Other.Side, Other.LayoutOrder
                    local OtherFrom = OtherInst.AbsolutePosition
                    local MyFrom = Ghost and Ghost.AbsolutePosition or Section.AbsolutePosition
                    local MyTo = OtherFrom
                    local OtherTo = MyFrom

                    if DragState.Placeholder and DragState.Placeholder.Parent then
                        MyTo = DragState.Placeholder.AbsolutePosition
                    end

                    -- Approximate other destination as our old column top area
                    local MyOldColumn = GetColumn(MySide)
                    if MyOldColumn then
                        OtherTo = MyOldColumn.Instance.AbsolutePosition
                        -- Prefer previous absolute pos of dragged section's start
                        if Ghost then
                            -- keep OtherTo as original ghost start (our old slot)
                            OtherTo = Vector2.new(
                                (Ghost:GetAttribute("OriginX") or MyFrom.X),
                                (Ghost:GetAttribute("OriginY") or MyFrom.Y)
                            )
                        end
                    end

                    if Ghost then
                        local Ox = Ghost:GetAttribute("OriginX")
                        local Oy = Ghost:GetAttribute("OriginY")
                        if typeof(Ox) == "number" and typeof(Oy) == "number" then
                            OtherTo = Vector2.new(Ox, Oy)
                        end
                        Ghost:Destroy()
                        DragState.Ghost = nil
                    end

                    DestroyDragVisuals()

                    Cfg.Side = TheirSide
                    Cfg.LayoutOrder = TheirOrder
                    Other.Side = MySide
                    Other.LayoutOrder = MyOrder

                    task.spawn(function()
                        TweenSeat(OtherInst, Other.Side, Other.LayoutOrder, OtherFrom, OtherTo)
                        if Other.ApplySize then
                            Other.ApplySize()
                        end
                    end)

                    TweenSeat(Section, Cfg.Side, Cfg.LayoutOrder, MyFrom, MyTo)
                    Cfg.ApplySize()
                    Section.Visible = true
                    return
                end

                local Order = DragState.TargetOrder or Cfg.LayoutOrder
                local TargetPos = Column.Instance.AbsolutePosition
                if DragState.Placeholder and DragState.Placeholder.Parent then
                    TargetPos = DragState.Placeholder.AbsolutePosition
                end

                local From = Ghost and Ghost.AbsolutePosition or Section.AbsolutePosition
                if Ghost then
                    Ghost:Destroy()
                    DragState.Ghost = nil
                end

                DestroyDragVisuals()

                Cfg.Side = Side
                Cfg.LayoutOrder = Order
                TweenSeat(Section, Side, Order, From, TargetPos)
                Cfg.ApplySize()
                Section.Visible = true
            end

            Library:Connect(Items.TopBar.Instance.InputBegan, function(Input)
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end

                if Items.Image:Hovering() then
                    return
                end

                if Cfg.Tweening or Library.DraggingSection then
                    return
                end

                DragState.Active = true
                DragState.Moved = false
                DragState.Start = Input.Position
                DragState.TargetSide = Cfg.Side
                DragState.TargetOrder = Cfg.LayoutOrder
                DragState.SwapWith = nil
            end)

            Library:Connect(Services.UserInputService.InputChanged, function(Input)
                if not DragState.Active then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end

                local Delta = (Input.Position - DragState.Start).Magnitude
                if not DragState.Moved then
                    if Delta < 6 then
                        return
                    end

                    DragState.Moved = true
                    Library.DraggingSection = Cfg
                    local Origin = Section.AbsolutePosition
                    StartGhost()
                    if DragState.Ghost then
                        DragState.Ghost:SetAttribute("OriginX", Origin.X)
                        DragState.Ghost:SetAttribute("OriginY", Origin.Y)
                    end
                end

                local MousePos = Services.UserInputService:GetMouseLocation()
                local Inset = Services.GuiService:GetGuiInset()
                local X = MousePos.X
                local Y = MousePos.Y - Inset.Y
                local Menu = (Cfg.Window and Cfg.Window.Items and Cfg.Window.Items.Menu and Cfg.Window.Items.Menu.Instance) or Library.Items.Instance

                if DragState.Ghost then
                    local Size = DragState.Ghost.AbsoluteSize
                    DragState.Ghost.Position = UDim2.fromOffset(
                        X - Menu.AbsolutePosition.X - Size.X * 0.5,
                        Y - Menu.AbsolutePosition.Y - 18
                    )
                end

                local Side, Column = ColumnHit(X, Y)
                if not (Side and Column) then
                    return
                end

                DragState.TargetSide = Side
                local Height = math.max(Cfg.CachedSize + 40, 80)
                local Hit = FindSectionAt(Side, Y)

                if not Hit and Side ~= Cfg.Side then
                    local OnSide = {}
                    for _, Other in self.SectionList do
                        if Other ~= Cfg and Other.Side == Side then
                            table.insert(OnSide, Other)
                        end
                    end
                    if #OnSide == 1 then
                        Hit = OnSide[1]
                    end
                end

                if Hit and Hit.Side ~= Cfg.Side then
                    DragState.SwapWith = Hit
                    DragState.TargetOrder = Hit.LayoutOrder
                    EnsurePlaceholder("Swap", Column, Side, Hit.LayoutOrder, Hit, Height)
                else
                    DragState.SwapWith = nil
                    local Order = ResolveInsertOrder(Column, Side, Y)
                    DragState.TargetOrder = Order
                    EnsurePlaceholder("Insert", Column, Side, Order, nil, Height)
                end
            end)

            Library:Connect(Services.UserInputService.InputEnded, function(Input)
                if not DragState.Active then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end

                DragState.Active = false

                if DragState.Moved then
                    task.spawn(function()
                        FinishDrop()
                        Library.DraggingSection = nil
                        DragState.Moved = false
                        DragState.SwapWith = nil
                    end)
                else
                    DestroyDragVisuals()
                    Section.Visible = true
                    Library.DraggingSection = nil
                end
            end)
        end

        return setmetatable(Cfg, Library)
    end

    Library.AddToggle = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or "Toggle";
            Flag = Data.Flag or Data.Name or Data.Text or "Toggle";
            Enabled = Data.Default or false;
            Callback = Data.Callback or function() end;

            Items = {};
        }

        local Items = Cfg.Items; do
            Items.Object = Library:Create( "TextButton", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 18);
                BorderSizePixel = 0
            })

            Items.AccentChange = Library:Create( "TextButton", {
                Parent = Library.Other.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 18);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset.Accent
            }):Themify("Accent", "BackgroundColor3")

            Items.Text = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Themes.Preset["Unselected"];
                Text = Cfg.Text;
                Parent = Items.Object.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0.5, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            }):Themify("Unselected", "TextColor3"):Themify("TextColor", "TextColor3")

            Items.Holder = Library:Create( "Frame", {
                Parent = Items.Object.Instance;
                Position = UDim2.new(1, 0, 0, 0);
                Size = UDim2.new(0, 0, 1, 0);
                BorderSizePixel = 0
            })

            Library:Create( "UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                Parent = Items.Holder.Instance;
                Padding = UDim.new(0, 7);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Items.Toggle = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(1, 0);
                Parent = Items.Holder.Instance;
                Position = UDim2.new(1, 0, 0, 0);
                Size = UDim2.new(0, 16, 0, 16);
                LayoutOrder = 1;
                BorderSizePixel = 0;
                ClipsDescendants = true;
                BackgroundColor3 = Color3.fromRGB(28, 28, 32)
            })

            Library:Create( "UICorner", {
                Parent = Items.Toggle.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Items.Fill = Library:Create( "Frame", {
                Parent = Items.Toggle.Instance;
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                Size = UDim2.new(0, 0, 0, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset.Accent
            }):Themify("Accent", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.Fill.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Items.Toggle:AddShine()

            Items.CheckIcon = Library:Create( "ImageLabel", {
                Image = "rbxassetid://93898873302694";
                ImageColor3 = Color3.fromRGB(255, 255, 255);
                Parent = Items.Toggle.Instance;
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundTransparency = 1;
                Position = UDim2.new(0.5, 0, 0.5, 0);
                Size = UDim2.new(0, 11, 0, 11);
                ImageTransparency = 1;
                ScaleType = Enum.ScaleType.Fit;
                BorderSizePixel = 0;
                ZIndex = 6
            })

            Items.Check = Items.CheckIcon
            Items.Gradient = Items.Fill
            Items.Circle = Items.Fill
            Items.Stroke = Items.Toggle
        end

        Cfg.Set = function(bool)
            Cfg.Enabled = bool

            if bool then
                Items.Fill:Tween({Size = UDim2.new(1, 0, 1, 0)})
                Items.CheckIcon:Tween({ImageTransparency = 0})
                Items.Text:Tween({TextColor3 = Themes.Preset.TextColor})
            else
                Items.Fill:Tween({Size = UDim2.new(0, 0, 0, 0)})
                Items.CheckIcon:Tween({ImageTransparency = 1})
                Items.Text:Tween({TextColor3 = Themes.Preset.Unselected})
            end

            Flags[Cfg.Flag] = bool
            Cfg.Callback(bool)
        end

        Items.Object:OnClick(function()
            Cfg.Enabled = not Cfg.Enabled
            Cfg.Set(Cfg.Enabled)
        end)

        Items.AccentChange.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            if Cfg.Enabled then
                Items.Fill:Tween({BackgroundColor3 = Themes.Preset.Accent})
            end
        end)

        ConfigFlags[Cfg.Flag] = Cfg.Set
        Cfg.Set(Cfg.Enabled)

        self.UpdateSection(Items.Object.Instance)
        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Flag = Cfg.Flag;
            Kind = "Toggle";
            Instance = Items.Object.Instance;
        })

        Cfg.Page = self.Page or self
        Cfg.Tab = self.Tab
        return setmetatable(Cfg, Library)
    end

    Library.AddSlider = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or "Text",
            Suffix = Data.Suffix or "",
            Flag = Data.Flag or Data.Name or "Slider",
            Callback = Data.Callback or function() end,

            Min = Data.Min or 0,
            Max = Data.Max or 100,
            Intervals = Data.Decimal or Data.Rounding or 1,
            Value = Data.Default or 10,

            Dragging = false,
            Items = {}
        }

        local Items = Cfg.Items; do
            Items.Object = Library:Create( "TextButton", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 33);
                BorderSizePixel = 0;
                AutomaticSize = Enum.AutomaticSize.Y;
            })

            Items.Title = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(252, 252, 252);
                Text = Cfg.Text;
                Parent = Items.Object.Instance;
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            })

            Items.Value = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(252, 252, 252);
                Text = "50%";
                Parent = Items.Object.Instance;
                AnchorPoint = Vector2.new(1, 0);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(1, 0, 0, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            })

            Items.SliderDragger = Library:Create( "Frame", {
                Parent = Items.Object.Instance;
                Position = UDim2.new(0, 0, 0, 23);
                Size = UDim2.new(1, 0, 0, 6);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset.ElementBackground
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.SliderDragger.Instance;
                CornerRadius = UDim.new(1, 0)
            })

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Thickness = 1;
                Transparency = 0.2;
                Parent = Items.SliderDragger.Instance
            }):Themify("ElementOutline", "Color")

            Items.Accent = Library:Create( "Frame", {
                Parent = Items.SliderDragger.Instance;
                Size = UDim2.new(0.5, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
                ZIndex = 2;
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Accent"]
            }):Themify("Accent", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.Accent.Instance;
                CornerRadius = UDim.new(1, 0)
            })

            Items.Circle = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5);
                Parent = Items.Accent.Instance;
                Position = UDim2.new(1, 0, 0.5, 0);
                Size = UDim2.new(0, 6, 0, 14);
                ZIndex = 3;
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.fromRGB(196, 196, 202)
            })

            Library:Create( "UICorner", {
                Parent = Items.Circle.Instance;
                CornerRadius = UDim.new(1, 0)
            })

            Library:Create( "UIStroke", {
                Color = Color3.fromRGB(0, 0, 0);
                Thickness = 1;
                Transparency = 0.15;
                Parent = Items.Circle.Instance
            })
        end

        Cfg.Set = function(Value)
            Cfg.Value = math.clamp(Library:Round(Value, Cfg.Intervals), Cfg.Min, Cfg.Max)

            Items.Value.Instance.Text = tostring(Cfg.Value) .. Cfg.Suffix
            Items.Accent:Tween({Size = UDim2.new((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 1, 0)}, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

            Flags[Cfg.Flag] = Cfg.Value
            Cfg.Callback(Flags[Cfg.Flag])
        end

        Cfg.UpdateSlider = function(input)
            local Size = (input.Position.X - Items.SliderDragger.Instance.AbsolutePosition.X) / Items.SliderDragger.Instance.AbsoluteSize.X
            local Value = ((Cfg.Max - Cfg.Min) * Size) + Cfg.Min

            Cfg.Set(Value)
        end

        Cfg.Set(Cfg.Value);
        Items.SliderDragger:OnDrag(Cfg.UpdateSlider)
        self.UpdateSection(Items.Object.Instance)

        ConfigFlags[Cfg.Flag] = Cfg.Set
        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Flag = Cfg.Flag;
            Kind = "Slider";
            Instance = Items.Object.Instance;
        })
        return setmetatable(Cfg, Library)
    end

    Library.AddDropdown = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Title or Data.Name or nil;
            Flag = Data.Flag or Data.Text or Data.Title or Data.Name or "Dropdown";
            Options = Data.Options or Data.Values or {""};
            Callback = Data.Callback or function() end;
            Multi = Data.Multi or false;

            -- Ignore these
            Open = false;
            OptionInstances = {};
            MultiItems = {};
            Items = {};
            Tweening = false;
        } Cfg.Default = Data.Default or Cfg.Options[1] or "";

        local Items = Cfg.Items; do
            do -- Outline
                Items.Dropdown = Library:Create( "Frame", {
                    Parent = self.Items.Elements.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, Cfg.Text and 52 or 26);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BorderSizePixel = 0
                })

                if Cfg.Text then
                    Items.Text = Library:Create( "TextLabel", {
                        FontFace = Themes.Preset.Font;
                        TextColor3 = Color3.fromRGB(252, 252, 252);
                        Text = Cfg.Text;
                        Parent = Items.Dropdown.Instance;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        Position = UDim2.new(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        ZIndex = 5;
                        TextTransparency = 0;
                    }):Themify("TextColor", "TextColor3")
                    Items.Text.Instance.Text = Cfg.Text
                    Items.Text.Instance.TextTransparency = 0
                end

                Items.Outline = Library:Create( "Frame", {
                    Parent = Items.Dropdown.Instance;
                    Position = UDim2.new(0, 1, 0, Cfg.Text and 26 or 0);
                    Size = UDim2.new(1, -1, 0, 24);
                    BorderSizePixel = 0;
                    BackgroundColor3 = Themes.Preset["ElementBackground"]
                }):Themify("ElementBackground", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Color = Themes.Preset.ElementOutline;
                    Parent = Items.Outline.Instance
                }):Themify("ElementOutline", "Color")

                Library:Create( "UICorner", {
                    Parent = Items.Outline.Instance;
                    CornerRadius = UDim.new(0, 6)
                })

                Items.Rectangles = Library:Create( "ImageLabel", {
                    ImageColor3 = Themes.Preset.Unselected;
                    Parent = Items.Outline.Instance;
                    AnchorPoint = Vector2.new(1, 0.5);
                    Image = "rbxassetid://91221896066807"; -- lucide square-arrow-out-up-right
                    BackgroundTransparency = 1;
                    Position = UDim2.new(1, -8, 0.5, 0);
                    Size = UDim2.new(0, 12, 0, 12);
                    Rotation = 0;
                    ScaleType = Enum.ScaleType.Fit;
                    BorderSizePixel = 0
                }):Themify("Unselected", "ImageColor3")

                Items.Value = Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Color3.fromRGB(252, 252, 252);
                    Text = "Dropdown";
                    Parent = Items.Outline.Instance;
                    AnchorPoint = Vector2.new(0, 0.5);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 8, 0.5, -1);
                    BorderSizePixel = 0;
                    ZIndex = 2
                })
            end

            do -- Menu
                local OptionHeight = 26
                local OptionPadding = 2
                local MaxVisible = 7
                Cfg.OptionHeight = OptionHeight
                Cfg.OptionPadding = OptionPadding
                Cfg.MaxVisible = MaxVisible

                Items.DropdownHolder = Library:Create( "TextButton", {
                    Size = UDim2.new(0, 248, 0, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                    AnchorPoint = Vector2.new(0, 0);
                    BorderSizePixel = 0;
                    Visible = false;
                    ClipsDescendants = true;
                    AutoButtonColor = false;
                    Active = true;
                    Text = "";
                    ZIndex = 400;
                    Parent = Library.Items.Instance;
                    BackgroundColor3 = Themes.Preset["ElementBackground"]
                }):Themify("ElementBackground", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Color = Themes.Preset.ElementOutline;
                    Parent = Items.DropdownHolder.Instance
                }):Themify("ElementOutline", "Color")

                Library:Create( "UICorner", {
                    Parent = Items.DropdownHolder.Instance;
                    CornerRadius = UDim.new(0, 6)
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 4);
                    PaddingBottom = UDim.new(0, 4);
                    Parent = Items.DropdownHolder.Instance;
                    PaddingRight = UDim.new(0, 4);
                    PaddingLeft = UDim.new(0, 4)
                })

                Items.DropdownScroll = Library:Create( "ScrollingFrame", {
                    Parent = Items.DropdownHolder.Instance;
                    Size = UDim2.new(1, 0, 1, 0);
                    CanvasSize = UDim2.new(0, 0, 0, 0);
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    ScrollBarImageColor3 = Themes.Preset.Accent;
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Active = true;
                    ScrollingEnabled = true;
                    ZIndex = 401
                }):Themify("Accent", "ScrollBarImageColor3")

                Library:Create( "UIListLayout", {
                    Parent = Items.DropdownScroll.Instance;
                    Padding = UDim.new(0, OptionPadding);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end
        end

        Cfg.GetDropdownHeight = function(Count)
            Count = math.max(Count or #Cfg.OptionInstances, 0)
            local Visible = math.min(Count, Cfg.MaxVisible)
            if Visible <= 0 then
                Visible = 1
            end

            return (Visible * Cfg.OptionHeight) + (math.max(Visible - 1, 0) * Cfg.OptionPadding) + 8
        end

        Cfg.RenderOption = function(text)
            local DropdownItems = {}

            DropdownItems.Button = Library:Create( "TextButton", {
                Parent = Items.DropdownScroll.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, Cfg.OptionHeight);
                BorderSizePixel = 0;
                AutoButtonColor = false;
                Active = true;
                Text = "";
                ZIndex = 402;
                BackgroundColor3 = Themes.Preset["Accent"]
            }):Themify("Accent", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = DropdownItems.Button.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            DropdownItems.Text = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                Parent = DropdownItems.Button.Instance;
                TextColor3 = Themes.Preset["Unselected"];
                Text = text;
                TextTransparency = 0;
                Size = UDim2.new(1, -16, 1, 0);
                AnchorPoint = Vector2.new(0, 0.5);
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 8, 0.5, 0);
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Center;
                BorderSizePixel = 0;
                ZIndex = 403;
            }):Themify("Unselected", "TextColor3")
            DropdownItems.Text.Instance.Text = tostring(text)
            DropdownItems.Text.Instance.TextTransparency = 0
            DropdownItems.Text.Instance.Visible = true

            DropdownItems.Stroke = Library:Create( "UIStroke", {
                Color = Themes.Preset["Accent"];
                Transparency = 1;
                Parent = DropdownItems.Button.Instance
            }):Themify("Accent", "Color")

            DropdownItems.Selected = false
            DropdownItems.Hovered = false

            local HoverInfo = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            DropdownItems.Button:OnHover(function()
                DropdownItems.Hovered = true
                if not DropdownItems.Selected then
                    DropdownItems.Button:Tween({BackgroundTransparency = 0.82}, HoverInfo)
                end
                DropdownItems.Text:Tween({TextColor3 = Color3.fromRGB(255, 255, 255)}, HoverInfo)
            end, function()
                DropdownItems.Hovered = false

                if not DropdownItems.Selected then
                    DropdownItems.Button:Tween({BackgroundTransparency = 1}, HoverInfo)
                    DropdownItems.Text:Tween({TextColor3 = Themes.Preset.Unselected}, HoverInfo)
                end
            end)

            table.insert(Cfg.OptionInstances, DropdownItems)

            return DropdownItems
        end

        Cfg.PlaceDropdown = function()
            local Field = Items.Outline.Instance
            local Holder = Items.DropdownHolder.Instance
            local Menu = (Library.Window and Library.Window.Items and Library.Window.Items.Menu and Library.Window.Items.Menu.Instance) or Library.Items.Instance
            local Gap = 4

            -- Align exactly to the field (same X + width, directly under it)
            local RelX = Field.AbsolutePosition.X - Menu.AbsolutePosition.X
            local RelY = Field.AbsolutePosition.Y - Menu.AbsolutePosition.Y + Field.AbsoluteSize.Y + Gap
            local Width = Field.AbsoluteSize.X

            Holder.Parent = Menu
            Holder.AnchorPoint = Vector2.new(0, 0)
            Holder.ZIndex = 400
            Holder.Active = true
            Holder.Position = UDim2.fromOffset(RelX, RelY)
            Holder.BackgroundColor3 = Themes.Preset.ElementBackground

            return math.max(Width, 1)
        end

        Cfg.SetVisible = function(State)
            if Cfg.Tweening then
                return
            end

            local Next = if State == nil then not Cfg.Open else State and true or false
            if Cfg.Open == Next and Items.DropdownHolder.Instance.Visible == Next then
                return
            end

            if Next and Library.OpenDropdown and Library.OpenDropdown ~= Cfg and Library.OpenDropdown.SetVisible then
                Library.OpenDropdown.SetVisible(false)
            end

            Cfg.Open = Next
            if Next then
                Library.OpenDropdown = Cfg
            elseif Library.OpenDropdown == Cfg then
                Library.OpenDropdown = nil
            end

            local Height = Cfg.GetDropdownHeight(#Cfg.OptionInstances)
            local Width = Cfg.PlaceDropdown()
            local OpenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local CloseInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

            Items.DropdownHolder.Instance.ClipsDescendants = true

            if Items.DropdownScroll then
                Items.DropdownScroll.Instance.CanvasPosition = Vector2.new(0, 0)
            end

            Cfg.Tweening = true

            if Items.Rectangles then
                Items.Rectangles:Tween({Rotation = Cfg.Open and 90 or 0}, OpenInfo)
            end

            if Cfg.Open then
                -- Top edge locked under the field; height tweens downward
                Items.DropdownHolder.Instance.Size = UDim2.fromOffset(Width, 0)
                Items.DropdownHolder.Instance.Visible = true
                Cfg.PlaceDropdown()

                local Tw = Items.DropdownHolder:Tween({Size = UDim2.fromOffset(Width, Height)}, OpenInfo)
                if Tw then
                    Tw.Completed:Connect(function()
                        if Cfg.Open then
                            Cfg.PlaceDropdown()
                        end
                        Cfg.Tweening = false
                    end)
                else
                    Items.DropdownHolder.Instance.Size = UDim2.fromOffset(Width, Height)
                    Cfg.Tweening = false
                end
            else
                local Tw = Items.DropdownHolder:Tween({Size = UDim2.fromOffset(Width, 0)}, CloseInfo)
                if Tw then
                    Tw.Completed:Connect(function()
                        if not Cfg.Open then
                            Items.DropdownHolder.Instance.Visible = false
                            Items.DropdownHolder.Instance.Size = UDim2.fromOffset(Width, 0)
                        end
                        Cfg.Tweening = false
                    end)
                else
                    Items.DropdownHolder.Instance.Visible = false
                    Items.DropdownHolder.Instance.Size = UDim2.fromOffset(Width, 0)
                    Cfg.Tweening = false
                end
            end
        end

        Cfg.Set = function(Value)
            local Selected = {}
            local IsTable = type(Value) == "table"
            local SelectInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            for _,Option in Cfg.OptionInstances do
                local Text = Option.Text.Instance.Text
                local IsSelected = Text == Value or (IsTable and table.find(Value, Text))
                Option.Selected = IsSelected and true or false

                if IsSelected then
                    table.insert(Selected, Text)
                    Cfg.MultiItems = Selected

                    Option.Text:Tween({TextColor3 = Color3.fromRGB(255, 255, 255)}, SelectInfo)
                    Option.Button:Tween({BackgroundTransparency = 0.35}, SelectInfo)
                    Option.Stroke:Tween({Transparency = 0.25}, SelectInfo)
                else
                    Option.Text:Tween({TextColor3 = Option.Hovered and Color3.fromRGB(255, 255, 255) or Themes.Preset.Unselected}, SelectInfo)
                    Option.Button:Tween({BackgroundTransparency = 1}, SelectInfo)
                    Option.Stroke:Tween({Transparency = 1}, SelectInfo)
                end
            end

            local Display = IsTable and table.concat(Selected, ", ") or Selected[1] or ""
            if Display == "" then
                Display = "..."
            end

            Items.Value.Instance.Text = Display

            Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
            Cfg.Callback(Flags[Cfg.Flag])
        end

        Cfg.RefreshOptions = function(Options)
            for _,option in Cfg.OptionInstances do
                option.Button.Instance:Destroy()
            end

            Cfg.OptionInstances = {}

            for _,Option in Options do
                local Button = Cfg.RenderOption(Option)
                local Text = Button.Text.Instance.Text

                Button.Button:OnClick(function()
                    if Cfg.Multi then
                        local Selected = table.find(Cfg.MultiItems, Text)

                        if Selected then
                            table.remove(Cfg.MultiItems, Selected)
                        else
                            table.insert(Cfg.MultiItems, Text)
                        end

                        Cfg.Set(Cfg.MultiItems)
                    else
                        Cfg.Set(Text)
                        Cfg.SetVisible(false)
                    end
                end)
            end
        end

        Items.Outline:OnClick(function()
            Cfg.SetVisible()
        end)
        Items.DropdownHolder:OutsideClick(Cfg, Items.Outline)

        Cfg.RefreshOptions(Cfg.Options)
        Items.DropdownHolder.Instance.Visible = false
        Items.DropdownHolder.Instance.Size = UDim2.fromOffset(0, 0)
        Cfg.Open = false
        Cfg.Set(Cfg.Default)

        self.UpdateSection(Items.Dropdown.Instance)
        if Cfg.Text then
            Library:AttachFeature(self, {
                Name = Cfg.Text;
                Flag = Cfg.Flag;
                Kind = "Dropdown";
                Instance = Items.Dropdown.Instance;
            })
        end

        return setmetatable(Cfg, Library)
    end

    Library.AddKeyPicker = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Name or Data.Title or "Keybind";
            Flag = Data.Flag or Data.Text or Data.Name or Data.Title or "Flag";
            Callback = Data.Callback or function() end;
            ShowInList = if Data.ShowInList == nil then true else Data.ShowInList;

            Key = Data.Key or Data.Default or nil;
            Mode = Data.Mode or "Toggle";
            Active = Data.Active or false;

            Open = false;
            Tweening = false;
            Binding;

            Items = {};
            Debounce = false;
        }

        Flags[Cfg.Flag] = {
            Mode = Cfg.Mode,
            Key = Cfg.Key,
            Active = Cfg.Active,
            active = Cfg.Active;
        }

        local Items = Cfg.Items; do
            Items.Object = Library:Create( "Frame", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 16);
                BorderSizePixel = 0
            })

            Items.Title = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(252, 252, 252);
                Text = Cfg.Text;
                Parent = Items.Object.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0.5, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            })

            Items.Holder = Library:Create( "Frame", {
                Parent = Items.Object.Instance;
                Position = UDim2.new(1, 0, 0, 0);
                Size = UDim2.new(0, 0, 1, 0);
                BorderSizePixel = 0
            })

            Library:Create( "UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                Parent = Items.Holder.Instance;
                Padding = UDim.new(0, 13);
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Items.Holder2 = Library:Create( "Frame", {
                AnchorPoint = Vector2.new(1, 0);
                Parent = Items.Holder.Instance;
                Position = UDim2.new(1, 0, 0, 0);
                Size = UDim2.new(0, 34, 0, 16);
                BorderSizePixel = 0;
                AutomaticSize = Enum.AutomaticSize.X;
                BackgroundColor3 = Themes.Preset.Other
            }):Themify("Other", "BackgroundColor3")

            Library:Create( "UIStroke", {
                Color = Themes.Preset["Inline"];
                Parent = Items.Holder2.Instance
            }):Themify("Inline", "Color")

            Library:Create( "UIPadding", {
                Parent = Items.Holder2.Instance;
                PaddingRight = UDim.new(0, 8);
                PaddingLeft = UDim.new(0, 8)
            })

            Library:Create( "UICorner", {
                Parent = Items.Holder2.Instance;
                CornerRadius = UDim.new(0, 5)
            })

            Items.Value = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(252, 252, 252);
                Text = "RightShift";
                Parent = Items.Holder2.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0.5, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            })

            do -- Keybind holder
                local Section = Library:AddSection({Text = "Settings"})
                Items.Dropdown = Section:AddDropdown({Text = "Mode", Flag = Cfg.Flag.."_MODE", Options = {"Toggle", "Hold", "Always"}, Callback = function(Option)
                    if Cfg.Debounce then
                        return
                    end

                    if Cfg.Set then
                        Cfg.Set(Option)
                    end
                end})

                Items.Section = Section.Items.Section
                Items.Section.Instance.Parent = Library.Items.Instance
                Items.Section.Instance.Visible = false

                Items.Section:Reparent(Library.Elements.Instance)
            end
        end

        local KeybindListElement
        if Cfg.ShowInList then
            KeybindListElement = Library:AddHotKey({Key = Cfg.Key or "NONE", Name = Cfg.Text})
        end

        Cfg.SetMode = function(Mode)
            Cfg.Mode = Mode

            if Mode == "Always" then
                Cfg.Set(true)
            elseif Mode == "Hold" then
                Cfg.Set(false)
            end

            Flags[Cfg.Flag].Mode = Mode
        end

        Cfg.Set = function(input, IgnoreCallback)
            if type(input) == "boolean" then
                Cfg.Active = input

                if Cfg.Mode == "Always" then
                    Cfg.Active = true
                end
            elseif tostring(input):find("Enum") then
                input = input.Name == "Escape" and "NONE" or input

                Cfg.Key = input or "NONE"
            elseif table.find({"Toggle", "Hold", "Always"}, input) then
                if input == "Always" then
                    Cfg.Active = true
                end

                Cfg.Mode = input
                Cfg.SetMode(Cfg.Mode)
            elseif type(input) == "table" then
                input.Key = type(input.Key) == "string" and input.Key ~= "NONE" and Library:ConvertEnum(input.Key) or input.Key
                input.Key = input.Key == Enum.KeyCode.Escape and "NONE" or input.Key

                Cfg.Key = input.Key or "NONE"

                if input.Active ~= nil then
                    Cfg.Active = input.Active
                end

                Cfg.SetMode(input.Mode)
            end

            if not IgnoreCallback then
                Cfg.Callback(Cfg.Active)
            end

            local text = (tostring(Cfg.Key) ~= "Enums" and (Keys[Cfg.Key] or tostring(Cfg.Key):gsub("Enum.", "")) or nil)
            local __text = text and tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "") or ""

            Items.Value.Instance.Text = string.format("Key: %s", __text)

            Cfg.Debounce = true
            Items.Dropdown.Set(Cfg.Mode)
            Cfg.Debounce = false


            if KeybindListElement then
                KeybindListElement:ChangeKey(__text or "NONE")
                KeybindListElement:SetEnabled(Cfg.Active)
            end

            Flags[Cfg.Flag] = {
                Mode = Cfg.Mode,
                Key = Cfg.Key,
                Active = Cfg.Active;
                active = Cfg.Active;
            }
        end

        Cfg.NewKey = function()
            task.wait()

            if Cfg.Binding and Cfg.Binding.Connection then
                Cfg.Binding.Connection:Disconnect()
                Cfg.Binding = nil
            end

            Cfg.Listening = true
            local Token = tick()
            Cfg.ListenToken = Token

            task.spawn(function()
                local Count = 1
                while Cfg.Listening and Cfg.ListenToken == Token do
                    Items.Value.Instance.Text = string.rep(".", Count)
                    Count = (Count % 3) + 1
                    task.wait(0.32)
                end
            end)

            Cfg.Binding = Library:Connect(Services.UserInputService.InputBegan, function(keycode, game_event)
                if game_event then
                    return
                end

                Cfg.Listening = false
                Cfg.Set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)

                Cfg.Binding.Connection:Disconnect()
                Cfg.Binding = nil
            end)
        end

        Cfg.SetVisible = function(bool)
            if Cfg.Tweening then
                return
            end

            task.wait()

            local Size = Items.Section.Instance.AbsoluteSize
            local Position = Items.Holder2.Instance.AbsolutePosition

            Items.Section:TweenDescendants(bool, Cfg)
            Items.Section:Tween({Position = UDim2.fromOffset(Position.X + 1, Position.Y + 80)})
        end

        Items.Holder2:OnClick(Cfg.NewKey)

        Items.Dropdown.Items.DropdownHolder:OnClick(function()
            task.spawn(function()
                Cfg.Tweening = true
                task.wait()
                Cfg.Tweening = false
            end)
        end)

        Items.Section:OutsideClick(Cfg)

        Library:Connect(Items.Holder2.Instance.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                Cfg.Open = not Cfg.Open
                Cfg.SetVisible(Cfg.Open)
            end
        end)

        Library:Connect(Services.UserInputService.InputBegan, function(input, game_event)
            if game_event then
                return
            end

            local SelectedKey = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

            if SelectedKey == Cfg.Key or tostring(SelectedKey) == Cfg.Key then
                if Cfg.Mode == "Toggle" then
                    Cfg.Active = not Cfg.Active
                    Cfg.Set(Cfg.Active)
                elseif Cfg.Mode == "Hold" then
                    Cfg.Set(true)
                end
            end
        end)

        Library:Connect(Services.UserInputService.InputEnded, function(input, game_event)
            if game_event then
                return
            end

            local SelectedKey = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

            if SelectedKey == Cfg.Key or tostring(SelectedKey) == Cfg.Key then
                if Cfg.Mode == "Hold" then
                    Cfg.Set(false)
                end
            end
        end)

        Cfg.Set({Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key}, true)
        ConfigFlags[Cfg.Flag] = Cfg.Set

        self.UpdateSection(Items.Object.Instance)
        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Flag = Cfg.Flag;
            Kind = "Keybind";
            Instance = Items.Object.Instance;
        })

        return setmetatable(Cfg, Library)
    end

    Library.AddColorPicker = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Name or "Color",
            Flag = Data.Flag or Data.Name or self.Name or "Colorpicker",
            Callback = Data.Callback or function() end,

            Color = Data.Color or Data.Default or Color3.new(1, 1, 1),  -- Default to white color if not provided
            Alpha = Data.Alpha or Data.Transparency or 1,

            -- Other
            Open = false;
            Items = {};
        }

        local Picker = self:Keypicker(Cfg)

        local Items = Picker.Items; do
            Cfg.Items = Items
            Cfg.Set = Picker.Set
        end;

        Cfg.Set(Cfg.Color, Cfg.Alpha)
        ConfigFlags[Cfg.Flag] = Cfg.Set
        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Flag = Cfg.Flag;
            Kind = "Color";
            Instance = (Picker.Items.Object and Picker.Items.Object.Instance) or (Picker.Items.ColorpickerObject and Picker.Items.ColorpickerObject.Instance);
        })

        return setmetatable(Cfg, Library)
    end

    Library.AddButton = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or "Button";
            Callback = Data.Callback or function() end;

            Items = {}
        }

        local Items = Cfg.Items; do
            Items.ButtonHolder = self.Items and self.Items.ButtonHolder

            if not Items.ButtonHolder then
                Items.ButtonHolder = Library:Create( "Frame", {
                    Parent = self.Items.Elements.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, 24);
                    BorderSizePixel = 0
                })

                Library:Create( "UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = Items.ButtonHolder.Instance;
                    Padding = UDim.new(0, 13);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            Items.Outline = Library:Create( "TextButton", {
                Parent = Items.ButtonHolder.Instance;
                Position = UDim2.new(0, 1, 0, 0);
                Size = UDim2.new(1, -1, 0, 24);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Parent = Items.Outline.Instance
            }):Themify("ElementOutline", "Color")

            Library:Create( "UICorner", {
                Parent = Items.Outline.Instance;
                CornerRadius = UDim.new(0, 5)
            })

            Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(252, 252, 252);
                Text = Cfg.Text;
                Parent = Items.Outline.Instance;
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                BorderSizePixel = 0;
                Position = UDim2.new(0, 0, 0, -1);
                ZIndex = 2;
                BackgroundColor3 = Themes.Preset["Accent"]
            }):Themify("Accent", "BackgroundColor3")

            Items.Accent = Library:Create( "Frame", {
                Parent = Items.Outline.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["Accent"]
            }):Themify("Accent", "BackgroundColor3")

            Items.Stroke = Library:Create( "UIStroke", {
                Color = Themes.Preset["Accent"];
                Transparency = 1;
                Parent = Items.Accent.Instance
            }):Themify("Accent", "Color")

            Library:Create( "UIGradient", {
                Parent = Items.Accent.Instance;
                Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.59375),
                NumberSequenceKeypoint.new(1, 0)
            }
            })

            Library:Create( "UICorner", {
                Parent = Items.Accent.Instance;
                CornerRadius = UDim.new(0, 5)
            })
        end

        Cfg.Press = function()
            Items.Accent.Instance.BackgroundTransparency = 0
            Items.Accent:Tween({BackgroundTransparency = 1})

            Items.Stroke.Instance.Transparency = 0
            Items.Stroke:Tween({Transparency = 1})

            Cfg.Callback()
        end

        Items.Outline:OnClick(Cfg.Press)

        if self.UpdateSection then
            self.UpdateSection(Items.ButtonHolder.Instance)
        end

        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Kind = "Button";
            Instance = Items.Outline.Instance;
        })

        return setmetatable(Cfg, Library)
    end

    Library.AddLabel = function(self, Data)
        local Cfg = {
            Text = Data.Text or Data.Title or Data.Name or "Label";
            Items = {};
        }

        local Items = Cfg.Items; do
            Items.Object = Library:Create( "TextButton", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 18);
                BorderSizePixel = 0
            })

            Items.Text = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Themes.Preset["TextColor"];
                Text = Cfg.Text;
                Parent = Items.Object.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0.5, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            }):Themify("TextColor", "TextColor3")

            Cfg.ChangeText = function(Text)
                Items.Text.Instance.Text = Text
            end
        end

        self.UpdateSection(Items.Object.Instance)

        return setmetatable(Cfg, Library)
    end

    Library.AddList = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Title or Data.Name or "This is a list";
            Flag = Data.Flag or Data.Name or Data.Text or "";
            Options = Data.Options or {"CONTACT FOR BUG"};
            Callback = Data.Callback or function() end;
            Multi = Data.Multi or false;

            Size = Data.Size or 148;

            Items = {};
            OptionInstances = {};
            MultiItems = {};
        } Cfg.Default = Data.Default or Cfg.Options[1] or "";

        local Items = Cfg.Items; do
            Items.List = Library:Create( "Frame", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, Cfg.Size);
                BorderSizePixel = 0;
            });

            Items.Title = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(214, 214, 220);
                Text = Cfg.Text;
                Parent = Items.List.Instance;
                AutomaticSize = Enum.AutomaticSize.XY;
                BackgroundTransparency = 1;
                Position = UDim2.new(0, -1, 0, 0);
                BorderSizePixel = 0;
                ZIndex = 2
            })

            Items.Outline = Library:Create( "Frame", {
                Parent = Items.List.Instance;
                Position = UDim2.new(0, 0, 0, 22);
                Size = UDim2.new(1, 0, 1, -22);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["ListBackground"]
            }):Themify("ListBackground", "BackgroundColor3")

            Library:Create( "UICorner", {
                Parent = Items.Outline.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Items.Inline = Library:Create( "Frame", {
                Parent = Items.Outline.Instance;
                Position = UDim2.new(0, 2, 0, 2);
                Size = UDim2.new(1, -4, 1, -4);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["ListBackground"]
            }):Themify("ListBackground", "BackgroundColor3")

            Items.ScrollingFrame = Library:Create( "ScrollingFrame", {
                Active = true;
                AutomaticCanvasSize = Enum.AutomaticSize.Y;
                BorderSizePixel = 0;
                CanvasSize = UDim2.new(0, 0, 0, 0);
                ScrollingEnabled = true;
                ScrollBarImageColor3 = Color3.fromRGB(80, 80, 86);
                MidImage = "rbxassetid://102257413888451";
                ScrollBarThickness = 2;
                Parent = Items.Inline.Instance;
                Size = UDim2.new(1, -4, 1, -8);
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 4);
                BottomImage = "rbxassetid://102257413888451";
                TopImage = "rbxassetid://102257413888451"
            })

            Library:Create( "UIPadding", {
                PaddingLeft = UDim.new(0, 8);
                Parent = Items.ScrollingFrame.Instance;
            })

            Library:Create( "UIListLayout", {
                Parent = Items.ScrollingFrame.Instance;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Padding = UDim.new(0, 2);
            })

            Library:Create( "UICorner", {
                Parent = Items.Inline.Instance;
                CornerRadius = UDim.new(0, 3)
            })
        end

        Cfg.Set = function(value)
            local Selected = {}
            local IsTable = type(value) == "table"

            for _,option in Cfg.OptionInstances do
                if option.Instance.Text == value or (IsTable and table.find(value, option.Instance.Text)) then
                    table.insert(Selected, option.Instance.Text)
                    Cfg.MultiItems = Selected
                    option:Tween({TextColor3 = Themes.Preset.TextColor})
                    option.Instance.FontFace = Fonts.Bold
                    option.Instance.TextSize = 13
                else
                    option:Tween({TextColor3 = Themes.Preset.UnselectedElement})
                    option.Instance.FontFace = Fonts.Elements
                    option.Instance.TextSize = 13
                end
            end

            Flags[Cfg.Flag] = if IsTable then Selected else Selected[1]

            Cfg.Callback(Flags[Cfg.Flag])
        end

        Cfg.RenderOption = function(name)
            local Button = Library:Create( "TextButton", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Themes.Preset["Element Text"];
                Text = name;
                TextSize = 13;
                Parent = Items.ScrollingFrame.Instance;
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 0, 0, 0);
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                BorderSizePixel = 0;
            }):Themify("TextColor", "TextColor3"):Themify("Element Text", "TextColor3")
            Button.Instance.Text = name

            Button:OnHover(
                function()
                    if Flags[Cfg.Flag] == Button.Instance.Text or (type(Flags[Cfg.Flag]) == "table" and table.find(Flags[Cfg.Flag], Button.Instance.Text)) then
                        return
                    end

                    Button:Tween({TextColor3 = Themes.Preset.SelectedMultiTabText})
                end,
                function()
                    if Flags[Cfg.Flag] == Button.Instance.Text or (type(Flags[Cfg.Flag]) == "table" and table.find(Flags[Cfg.Flag], Button.Instance.Text)) then
                        return
                    end

                    Button:Tween({TextColor3 = Themes.Preset.UnselectedElement})
                end
            )

            table.insert(Cfg.OptionInstances, Button)

            return Button
        end

        Cfg.RefreshOptions = function(options)
            for _,option in Cfg.OptionInstances do
                option.Instance:Destroy()
            end

            Cfg.OptionInstances = {}

            for _,option in options do
                local Button = Cfg.RenderOption(option)

                Button:OnClick(function()
                    if Cfg.Multi then
                        local Selected = table.find(Cfg.MultiItems, Button.Instance.Text)

                        if Selected then
                            table.remove(Cfg.MultiItems, Selected)
                        else
                            table.insert(Cfg.MultiItems, Button.Instance.Text)
                        end

                        Cfg.Set(Cfg.MultiItems)
                    else
                        Cfg.Set(Button.Instance.Text)
                    end
                end)
            end
        end

        Flags[Cfg.Flag] = {}
        ConfigFlags[Cfg.Flag] = Cfg.Set
        Cfg.RefreshOptions(Cfg.Options)
        Cfg.Set(Cfg.Default)

        if self.UpdateSection then
            self.UpdateSection(Items.List.Instance)
        end

        Library:AttachFeature(self, {
            Name = Cfg.Text;
            Flag = Cfg.Flag;
            Kind = "List";
            Instance = Items.List.Instance;
        })

        return setmetatable(Cfg, Library)
    end

    Library.AddInput = function(self, Data)
        Data = Data or {}

        local Cfg = {
            Text = Data.Text or Data.Title or Data.Name or nil;
            PlaceHolder = Data.PlaceHolder or Data.PlaceHolderText or Data.Holder or Data.HolderText or "Input here...";
            Default = Data.Default or "";
            Flag = Data.Flag or Data.Name or "TextBox";
            Callback = Data.Callback or function() end;

            Items = {};
            Focused = false;
        }

        Flags[Cfg.Flag] = Cfg.Default

        local Items = Cfg.Items; do
            Items.Object = Library:Create( "Frame", {
                Parent = self.Items.Elements.Instance;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, Cfg.Text and 50 or 26);
                BorderSizePixel = 0
            })

            if Cfg.Text then
                Library:Create( "TextLabel", {
                    FontFace = Themes.Preset.Font;
                    TextColor3 = Color3.fromRGB(252, 252, 252);
                    Text = Cfg.Text;
                    Parent = Items.Object.Instance;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, -1, 0, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2
                })
            end

            Items.Outline = Library:Create( "Frame", {
                Parent = Items.Object.Instance;
                Position = UDim2.new(0, 1, 0, Cfg.Text and 26 or 0);
                Size = UDim2.new(1, -1, 0, 24);
                BorderSizePixel = 0;
                BackgroundColor3 = Themes.Preset["ElementBackground"]
            }):Themify("ElementBackground", "BackgroundColor3")

            Library:Create( "UIStroke", {
                Color = Themes.Preset.ElementOutline;
                Parent = Items.Outline.Instance
            }):Themify("ElementOutline", "Color")

            Library:Create( "UICorner", {
                Parent = Items.Outline.Instance;
                CornerRadius = UDim.new(0, 5)
            })

            Items.Outline.Instance.ClipsDescendants = false

            Items.Display = Library:Create( "TextLabel", {
                Parent = Items.Outline.Instance;
                FontFace = Themes.Preset.Font;
                Text = Cfg.Default ~= "" and Cfg.Default or Cfg.PlaceHolder;
                TextColor3 = Cfg.Default ~= "" and Themes.Preset.TextColor or Themes.Preset.Unselected;
                TextSize = 14;
                TextWrapped = false;
                Size = UDim2.new(1, -16, 1, 0);
                Position = UDim2.new(0, 8, 0, 0);
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Center;
                BorderSizePixel = 0;
                ZIndex = 2
            })

            Items.Textbox = Library:Create( "TextBox", {
                Parent = Items.Outline.Instance;
                FontFace = Themes.Preset.Font;
                Active = true;
                ClearTextOnFocus = false;
                Text = Cfg.Default;
                TextColor3 = Themes.Preset.TextColor;
                TextTransparency = 1;
                TextSize = 14;
                Size = UDim2.new(1, 0, 1, 0);
                Selectable = true;
                BorderSizePixel = 0;
                PlaceholderText = "";
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 3
            })

            Library:Create( "UIPadding", {
                PaddingLeft = UDim.new(0, 8);
                Parent = Items.Textbox.Instance
            })

            Items.Caret = Library:Create( "Frame", {
                Parent = Items.Outline.Instance;
                AnchorPoint = Vector2.new(0, 0.5);
                Position = UDim2.new(0, 8, 0.5, 0);
                Size = UDim2.new(0, 1, 0, 14);
                Visible = false;
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                ZIndex = 4;
                BackgroundColor3 = Themes.Preset.Accent
            }):Themify("Accent", "BackgroundColor3")
        end

        Cfg.UpdateCaret = function()
            local Box = Items.Textbox.Instance
            local Text = Box.Text

            if Text == "" then
                Items.Display.Instance.Text = Cfg.Focused and "" or Cfg.PlaceHolder
                Items.Display.Instance.TextColor3 = Themes.Preset.Unselected
            else
                Items.Display.Instance.Text = Text
                Items.Display.Instance.TextColor3 = Themes.Preset.TextColor
            end

            local Width = Items.Display.Instance.TextBounds.X
            if Text == "" then
                Width = 0
            elseif Width <= 0 then
                Width = Library:MeasureText(Text, Box.TextSize)
            end

            local MaxWidth = math.max(0, Items.Outline.Instance.AbsoluteSize.X - 14)
            Width = math.clamp(Width, 0, MaxWidth)

            Items.Caret.Instance.Visible = Cfg.Focused
            Items.Caret.Instance.BackgroundTransparency = Cfg.Focused and 0 or 1
            Items.Caret.Instance.BackgroundColor3 = Themes.Preset.Accent
            Items.Caret:Tween({
                Position = UDim2.new(0, 8 + Width, 0.5, 0);
            }, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        end

        Cfg.Set = function(Text)
            Flags[Cfg.Flag] = Text

            Items.Textbox.Instance.Text = Text
            Cfg.UpdateCaret()

            Cfg.Callback(Text)
        end

        Items.Textbox.Instance:GetPropertyChangedSignal("Text"):Connect(function()
            Cfg.UpdateCaret()
        end)

        Items.Textbox.Instance.Focused:Connect(function()
            Cfg.Focused = true;
            Items.Caret.Instance.Visible = true
            Items.Caret.Instance.BackgroundTransparency = 0
            Cfg.UpdateCaret()
        end)

        Items.Textbox.Instance.FocusLost:Connect(function()
            Cfg.Focused = false;
            Items.Caret.Instance.Visible = false
            Items.Caret.Instance.BackgroundTransparency = 1
            Cfg.Set(Items.Textbox.Instance.Text)
        end)

        Cfg.UpdateCaret()

        ConfigFlags[Cfg.Flag] = Cfg.Set

        if self.UpdateSection then
            self.UpdateSection(Items.Object.Instance)
        end

        Library:AttachFeature(self, {
            Name = Cfg.Text or Cfg.PlaceHolder or Cfg.Flag;
            Flag = Cfg.Flag;
            Kind = "Input";
            Instance = Items.Object.Instance;
        })

        return setmetatable(Cfg, Library)
    end

    Library.InitConfigs = function(self, Window)
        local Tab = Window:AddTab({
            Title = "Settings",
            Icon = "rbxassetid://117366234081415",
            Pages = {"General"},
        })

        local Configs = Tab:AddSection({
            Side = "Left",
            Title = "Configs"
        })

        local ConfigText = ""
        local AutoloadName = ""

        if isfile(Library.Directory .. "/Autoload.txt") then
            AutoloadName = readfile(Library.Directory .. "/Autoload.txt")
        end

        local ConfigNameInput
        local ConfigList = Configs:AddList({
            Text = "Saved configs",
            Flag = "ConfigList",
            Size = 168,
            Options = {},
            Callback = function(Option)
                if Option and ConfigNameInput and ConfigNameInput.Set then
                    ConfigText = Option
                    ConfigNameInput.Set(Option)
                end
            end
        })

        ConfigNameInput = Configs:AddInput({
            Text = "Config Name",
            Default = "",
            PlaceHolder = "Type config name here...",
            Flag = "config_Name_text",
            Callback = function(Text)
                ConfigText = Text
            end
        })

        local function ResolveConfigName()
            return ConfigText ~= "" and ConfigText or Flags.ConfigList
        end

        Configs:AddButton({Text = "Save", Callback = function()
            local Name = ResolveConfigName()
            if not Name or Name == "" then
                return
            end

            Library:SaveConfig(Name)
            ConfigList:UpdateConfigList()
            Library:Notify({ Text = "Saved " .. Name .. ".son" })
        end}):AddButton({Text = "Load", Callback = function()
            local Name = ResolveConfigName()
            if not Name or Name == "" then
                return
            end

            Library:LoadConfigByName(Name)
            ConfigList:UpdateConfigList()
        end})

        Configs:AddButton({Text = "Delete", Callback = function()
            local Name = ResolveConfigName()
            if not Name or Name == "" then
                return
            end

            Library:DeleteConfig(Name)
            if Library.ActiveConfig == Name then
                Library.ActiveConfig = ""
            end
            ConfigList:UpdateConfigList()
            Library:Notify({ Text = "Deleted " .. Name .. ".son" })
        end}):AddButton({Text = "Refresh", Callback = function()
            ConfigList:UpdateConfigList()
        end})

        local AutoloadLabel = Configs:AddLabel({
            Text = AutoloadName ~= "" and ("Current Config: " .. AutoloadName) or "Current Config: none"
        })

        Configs:AddButton({Text = "Set As Auto Load", Callback = function()
            local Name = ResolveConfigName()
            if not Name or Name == "" then
                return
            end

            writefile(Library.Directory .. "/Autoload.txt", Name)
            AutoloadLabel.ChangeText("Current Config: " .. Name)
        end})

        Configs:AddButton({Text = "Remove Auto Load", Callback = function()
            writefile(Library.Directory .. "/Autoload.txt", "")
            AutoloadLabel.ChangeText("Current Config: none")
        end})

        local Theme = Tab:AddSection({
            Side = "Middle",
            Title = "Theme"
        })

        local ThemePickers = {
            { Text = "Accent", Key = "Accent" };
            { Text = "line", Key = "Line" };
            { Text = "Groupbox", Key = "SectionBackground" };
            { Text = "Background", Key = "Background" };
            { Text = "Top Bar", Key = "TopBar" };
            { Text = "Bottom Bar", Key = "BottomBar" };
            { Text = "Sidebar", Key = "SideBar" };
            { Text = "Outlines", Key = "ElementOutline" };
            { Text = "Inline", Key = "Inline" };
            { Text = "Element Background", Key = "ElementBackground" };
            { Text = "Text", Key = "TextColor" };
            { Text = "Unselected", Key = "Unselected" };
            { Text = "List Background", Key = "ListBackground" };
            { Text = "Inlines", Key = "Inlines" };
            { Text = "Other", Key = "Other" };
        }

        local PresetNames = {
            "Sonata",
            "Lilac Mist",
            "Soft Periwinkle",
            "Blush Pink",
            "Cotton Candy",
            "Lavender Fog",
            "Sky Pastel",
            "Mint Cream",
            "Peach Soft",
            "Rose Quartz",
            "Wisteria",
            "Powder Blue",
            "Mauve",
            "Orchid Light",
            "Seafoam",
            "Ballet Pink",
            "Ice Lilac",
            "Cherry Blossom",
            "Cloud Periwinkle",
            "Neverlose",
            "Primordial",
            "Gamesense",
            "Rifk7",
            "Fatality",
            "Onetap",
            "Nixware",
            "Aimware",
            "Interwebz",
            "Pandora",
        }

        local function SyncThemePickers()
            Library.ApplyingTheme = true
            for _, Entry in ThemePickers do
                local Fn = ConfigFlags["Theme" .. Entry.Key]
                if Fn and Themes.Preset[Entry.Key] then
                    Fn(Themes.Preset[Entry.Key], 0)
                end
            end
            Library.ApplyingTheme = false
        end

        Theme:AddDropdown({
            Flag = "PresetTheme",
            Options = PresetNames,
            Default = "Sonata",
            Callback = function(Option)
                if Option and Library.BuiltInThemes[Option] then
                    Library:ApplyBuiltInTheme(Option)
                    SyncThemePickers()
                    Library:Notify({ Text = "Applied " .. Option })
                end
            end
        })

        local ThemeText = ""
        local DefaultThemeName = ""
        local DefaultLabel
        if isfile(Library.Directory .. "/DefaultTheme.txt") then
            DefaultThemeName = readfile(Library.Directory .. "/DefaultTheme.txt")
        end

        local ThemeNameInput
        local SavedThemes = Theme:AddList({
            Text = "Custom themes",
            Flag = "ThemeList",
            Size = 120,
            Options = {},
            Callback = function(Option)
                if Option and ThemeNameInput and ThemeNameInput.Set then
                    ThemeText = Option
                    ThemeNameInput.Set(Option)
                end
            end
        })

        ThemeNameInput = Theme:AddInput({
            Text = "Theme Name",
            Default = "",
            PlaceHolder = "Type theme name here...",
            Flag = "theme_Name_text",
            Callback = function(Text)
                ThemeText = Text
            end
        })

        local function ResolveThemeName()
            return ThemeText ~= "" and ThemeText or Flags.ThemeList
        end

        Theme:AddButton({Text = "Save", Callback = function()
            local Name = ResolveThemeName()
            if not Name or Name == "" then
                return
            end

            Library:SaveTheme(Name)
            SavedThemes:UpdateThemingList()
            Library:Notify({ Text = "Saved theme " .. Name .. ".son" })
        end}):AddButton({Text = "Load", Callback = function()
            local Name = ResolveThemeName()
            if not Name or Name == "" then
                return
            end

            local Path = Library:ThemePath(Name)
            if not Path then
                Library:Notify({ Text = "Missing theme " .. Name })
                return
            end

            Library:LoadTheme(readfile(Path))
            SyncThemePickers()
            Library:Notify({ Text = "Loaded theme " .. Name })
        end})

        Theme:AddButton({Text = "Set As Default", Callback = function()
            local Name = ResolveThemeName()
            if not Name or Name == "" then
                return
            end

            writefile(Library.Directory .. "/DefaultTheme.txt", Name)
            DefaultLabel.ChangeText("Default theme: " .. Name)
            Library:Notify({ Text = "Default theme set" })
        end}):AddButton({Text = "Export", Callback = function()
            if Library:CopyText(Library:GetTheme()) then
                Library:Notify({ Text = "Theme copied to clipboard" })
            else
                Library:Notify({ Text = "Clipboard unavailable" })
            end
        end})

        Theme:AddButton({Text = "Import", Callback = function()
            local Payload = Library:PasteText()
            if not Payload or Payload == "" then
                Library:Notify({ Text = "Clipboard is empty" })
                return
            end

            Library:LoadTheme(Payload)
            SyncThemePickers()
            Library:Notify({ Text = "Imported theme" })
        end}):AddButton({Text = "Refresh", Callback = function()
            SavedThemes:UpdateThemingList()
        end})

        DefaultLabel = Theme:AddLabel({
            Text = DefaultThemeName ~= "" and ("Default theme: " .. DefaultThemeName) or "Default theme: none"
        })

        for _, Entry in ThemePickers do
            Theme:AddColorPicker({
                Text = Entry.Text,
                Default = Themes.Preset[Entry.Key],
                Transparency = 0,
                Flag = "Theme" .. Entry.Key,
                Callback = function(Value)
                    if Library.ApplyingTheme then
                        return
                    end

                    Library:Refresh(Entry.Key, Value)
                end
            })
        end

        local Other = Tab:AddSection({
            Side = "Right",
            Title = "Interface"
        })

        local FontOptions = {
            "Inter",
            "Montserrat",
            "Segoe Ui",
            "GothamSSm",
            "SourceSans3",
            "SourceSans",
            "BuilderSans",
            "Roboto",
            "RobotoMono",
            "RobotoCondensed",
            "Nunito",
            "Oswald",
            "Ubuntu",
            "JosefinSans",
            "OpenSans",
            "Merriweather",
            "PlayfairDisplay",
            "Inconsolata",
            "TitilliumWeb",
            "Arimo",
            "HighwayGothic",
            "SpecialElite",
            "FredokaOne",
            "DenkOne",
            "Fondamento",
            "Bangers",
            "AmaticSC",
            "AccanthisADFStd",
            "PressStart2P",
            "IndieFlower",
            "Jura",
            "Kalam",
            "Zekton",
            "LuckiestGuy",
            "Michroma",
            "Parisienne",
            "Sarpanch",
            "Legacy",
            "Arial",
            "ArialBold",
            "Bodoni",
            "Cartoon",
            "Code",
            "Creepster",
            "Fantasy",
            "Gotham",
            "GothamBlack",
            "GothamBold",
            "GothamMedium",
            "Garamond",
            "SciFi",
            "Highway",
            "PermanentMarker",
        }

        Other:AddDropdown({
            Text = "UI Font",
            Flag = "UIFont",
            Options = FontOptions,
            Default = "BuilderSans",
            Callback = function(Option)
                if Option then
                    Library:SetFont(Option)
                end
            end
        })

        Other:AddKeyPicker({
            Text = "Menu bind",
            Flag = "MenuBind",
            Mode = "Toggle",
            Active = true,
            Default = Enum.KeyCode.RightShift,
            ShowInList = false,
            Callback = function(Value)
                Window.SetVisible(Value)
            end
        })

        local WatermarkToggle = Other:AddToggle({
            Text = "Watermark",
            Flag = "ShowWatermark",
            Default = true,
            Callback = function(Bool)
                self.Window.Items.Watermark.Instance.Visible = Bool
            end
        })

        SavedThemes:UpdateThemingList()
        ConfigList:UpdateConfigList()

        if DefaultThemeName ~= "" then
            local Path = Library:ThemePath(DefaultThemeName)
            if Path then
                Library:LoadTheme(readfile(Path))
                SyncThemePickers()
            elseif Library.BuiltInThemes[DefaultThemeName] then
                Library:ApplyBuiltInTheme(DefaultThemeName)
                SyncThemePickers()
            end
        end

        if isfile(Library.Directory .. "/Autoload.txt") then
            Library:AutoLoad()
        end
    end

    do -- Keybind lib
        local YOffset = 0
        local BiggestX = 0

        Library.AddHotKey = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Title or Data.Name or Data.Text or "Title";
                Lifetime = Data.Lifetime or 5;

                Items = {};
                Status = true;
                Fade = 2;
                Tick = tick();
                Index = #self.Keybinds + 1
            }

            local Items = Cfg.Items; do
                Items.Keybind = Library:Create("CanvasGroup",{Parent = self.Window.Items.KeybindHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 25); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Name = Library:Create("TextLabel",{LayoutOrder = 1; TextColor3 = Color3.fromRGB(245, 245, 245); Text = "Idfk"; Parent = Items.Keybind.Instance; AutomaticSize = Enum.AutomaticSize.XY; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 6); Parent = Items.Name.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 7)})
                Items.Key = Library:Create("TextLabel",{LayoutOrder = 1; Parent = Items.Keybind.Instance; TextColor3 = Color3.fromRGB(170, 170, 170); Text = "[X]"; AutomaticSize = Enum.AutomaticSize.XY; AnchorPoint = Vector2.new(1, 0); Position = UDim2.new(1, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Right; BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 6); Parent = Items.Key.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 7)})
            end

            function Cfg:ChangeKey(Key)
                if not Key then
                    return
                end

                Items.Key.Instance.Text = tostring("["..Key.."]")
            end

            function Cfg:ChangeName(Name)
                Items.Name.Instance.Text = tostring(Name)
            end

            function Cfg:SetEnabled(Bool)
                Cfg.Status = Bool
            end

            Cfg:ChangeKey(Cfg.Key)
            Cfg:ChangeName(Cfg.Text)

            self.Keybinds[Cfg.Index] = Cfg

            return setmetatable(Cfg, Library)
        end

        Library.LerpKeybinds = function(self)
            YOffset = 0
            BiggestX = 0

            local Tick = tick()
            for _,Object in self.Keybinds do
                Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)
                local Instance = Object.Items.Keybind.Instance

                local Offset = UDim2.new(0, 0, 0, 0) -- great pasting skills
                local Transparency = 1 - (1 * (Object.Fade / 255))

                Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                Object:SetKeypickerTransparency(Transparency)

                if Object.Status and BiggestX < Instance.AbsoluteSize.X then
                    BiggestX = math.max(BiggestX, Instance.AbsoluteSize.X)
                end

                YOffset += (Instance.AbsoluteSize.Y) * (Object.Fade / 255)
                self.Window.Items.KeybindHolder.Instance.Size = UDim2.new(0, 200, 0, YOffset + 22)
            end
        end

        Library.SetKeypickerTransparency = function(self, Num)
            self.Items.Keybind.Instance.GroupTransparency = Num
        end
    end

    do -- Notification Library
        Library.HUD = Library:Create( "ScreenGui" , {
            Parent = Services.CoreGui;
            Name = "\0";
            Enabled = true;
            IgnoreGuiInset = true;
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            DisplayOrder = 1000001;
        });

        local YOffset = 0
        local BiggestX = 0

        Library.Notify = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Title or Data.Name or Data.Text or "Title";
                Lifetime = Data.Lifetime or 4;
                Items = {};
            }

            if not Library.NotifHolder then
                Library.NotifHolder = Library:Create( "Frame", {
                    Parent = Library.HUD.Instance;
                    AnchorPoint = Vector2.new(1, 0);
                    Position = UDim2.new(1, -16, 0, 16);
                    Size = UDim2.new(0, 280, 1, -32);
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0
                })

                Library:Create( "UIListLayout", {
                    Parent = Library.NotifHolder.Instance;
                    Padding = UDim.new(0, 8);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    VerticalAlignment = Enum.VerticalAlignment.Top
                })
            end

            local Items = Cfg.Items
            Items.Notification = Library:Create( "CanvasGroup", {
                Parent = Library.NotifHolder.Instance;
                AutomaticSize = Enum.AutomaticSize.XY;
                GroupTransparency = 1;
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.fromRGB(38, 38, 44)
            })

            Library:Create( "UICorner", {
                Parent = Items.Notification.Instance;
                CornerRadius = UDim.new(0, 4)
            })

            Library:Create( "UIStroke", {
                Parent = Items.Notification.Instance;
                Color = Color3.fromRGB(70, 70, 78);
                Transparency = 0.35
            })

            Items.Notification:AddShine()

            Items.Title = Library:Create( "TextLabel", {
                FontFace = Themes.Preset.Font;
                TextColor3 = Color3.fromRGB(245, 245, 245);
                Text = Cfg.Text;
                Parent = Items.Notification.Instance;
                BackgroundTransparency = 1;
                AutomaticSize = Enum.AutomaticSize.XY;
                BorderSizePixel = 0
            })

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, 8);
                PaddingBottom = UDim.new(0, 8);
                PaddingLeft = UDim.new(0, 12);
                PaddingRight = UDim.new(0, 12);
                Parent = Items.Title.Instance
            })

            Library:Create( "UIPadding", {
                PaddingTop = UDim.new(0, 2);
                PaddingBottom = UDim.new(0, 2);
                PaddingLeft = UDim.new(0, 2);
                PaddingRight = UDim.new(0, 2);
                Parent = Items.Notification.Instance
            })

            Items.Notification:Tween({GroupTransparency = 0}, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

            task.delay(Cfg.Lifetime, function()
                if not (Items.Notification and Items.Notification.Instance and Items.Notification.Instance.Parent) then
                    return
                end

                local Tween = Items.Notification:Tween({GroupTransparency = 1}, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
                if Tween then
                    pcall(function()
                        Tween.Completed:Wait()
                    end)
                end

                if Items.Notification.Instance and Items.Notification.Instance.Parent then
                    Items.Notification.Instance:Destroy()
                end
            end)

            return Cfg
        end

        Library.LerpObjects = function(self)
        end

        Library.SetTransparency = function(self, Num)
            self.Items.Notification.Instance.GroupTransparency = Num
        end

        Library:Notify({ Text = 'Loaded!' })
    end

    do -- Mods lib
        local YOffset = 0
        local BiggestX = 0

        Library.AddMod = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Title or Data.Name or Data.Text or "Title";
                Lifetime = Data.Lifetime or 5;

                Items = {};
                Status = true;
                Fade = 2;
                Tick = tick();
                Index = #self.Mods + 1
            }

            local Items = Cfg.Items; do
                Items.Mod = Library:Create("CanvasGroup",{Parent = self.Window.Items.ModHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 25); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Name = Library:Create("TextLabel",{LayoutOrder = 1; Parent = Items.Mod.Instance; TextColor3 = Color3.fromRGB(170, 170, 170); Text = "[X]"; AutomaticSize = Enum.AutomaticSize.XY; AnchorPoint = Vector2.new(0, 0); Position = UDim2.new(0, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Right; BorderSizePixel = 0; ZIndex = 2; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 6); Parent = Items.Name.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 7)})
            end

            function Cfg:ChangeName(Name)
                Items.Name.Instance.Text = tostring(Name)
            end

            function Cfg:Destroy()
                Cfg.Status = false

                task.delay(1, function()
                    Items.Mod.Instance:Destroy()
                end)
            end

            Cfg:ChangeName(Cfg.Text)

            self.Mods[Cfg.Index] = Cfg

            return setmetatable(Cfg, Library)
        end

        Library.LerpMods = function(self)
            YOffset = 0
            BiggestX = 0

            local Tick = tick()
            for _,Object in self.Mods do
                Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)
                local Instance = Object.Items.Mod.Instance

                local Offset = UDim2.new(0, 0, 0, 0) -- great pasting skills
                local Transparency = 1 - (1 * (Object.Fade / 255))

                Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                Object:SetModTransparency(Transparency)

                if Object.Status and BiggestX < Instance.AbsoluteSize.X then
                    BiggestX = math.max(BiggestX, Instance.AbsoluteSize.X)
                end

                YOffset += (Instance.AbsoluteSize.Y) * (Object.Fade / 255)
                self.Window.Items.ModHolder.Instance.Size = UDim2.new(0, 200, 0, YOffset + 22)
            end
        end

        Library.SetModTransparency = function(self, Num)
            self.Items.Mod.Instance.GroupTransparency = Num
        end
    end

    Library:Connect(Services.RunService.Heartbeat, function()
        if not (Library.LerpObjects and Library.LerpMods) then
            return
        end

        Library:LerpObjects()
        Library:LerpKeybinds()
        Library:LerpMods()
    end)
end

return getgenv().Library
