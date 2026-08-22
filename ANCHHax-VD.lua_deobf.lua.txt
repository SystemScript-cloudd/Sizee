-- [[ ts is generated @ dsc.gg/6vms ]]

local Env = getfenv();
local h = {};
local v1 = {...};
local r1 = true;
local r2 = string.gmatch;
local function r3(...)
    error("Tamper Detected!");
    return; 
end;
local r4 = false;
local v2 = pcall(function(...)
    r4 = true;
    return; 
end);
local v3 = v2;
if v2 then
    v3 = r4;
end;
local v4 = 1;
local r5 = math.random;
local v5 = table.concat;
local v6 = table;
local function v7(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end;
if v6 then
    U = table.unpack;
end;
local r6 = v6 or unpack;
local r7 = r5(3, 65);
local v8 = {
    pcall(function(...)
        return "9RN6Qpb" / (16321660 - "ngPFYupA" ^ 5918893); 
    end)
};
local v9 = v8[2];
local r8 = tonumber(r2(tostring(v9), ":(%d*):")());
for y = 1, r7 do
    r9 = y;
    r10 = math.random(1, 100);
    r11 = r5(0, 255);
    r12 = r5(1, r10);
    r13 = r5(1, 2) == 1;
    r14 = v9.gsub(v9, ":(%d*):", ":" .. tostring(r5(0, 10000)) .. ":");
    S = {
        pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "0tVuHXAt" / (5444724 - "bMy" ^ 3329612); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for K = 1, r10 do
                v1[K] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end)
    };
    if r13 then
        r1 = r1 and (pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "0tVuHXAt" / (5444724 - "bMy" ^ 3329612); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for K = 1, r10 do
                v1[K] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end) == false and S[2] == r14);
    end; 
end;
r1 = r1 and 0 == 0;
if r1 then
    r17 = math.floor;
    v8 = {};
    r18 = 0;
    r19 = 2;
    r20 = {};
    v6 = 0;
    for G = 1, 256 do
        v8[G] = G; 
    end;
    v9 = #v8 == 0;
    G = table.remove(v8, math.random(1, #v8));
    r20[G] = string.char(G - 1);
    if #v8 == 0 then
        r21 = {};
        r23 = {};
        r16 = setmetatable({}, {
            ["__index"] = r23,
            ["__metatable"] = nil
        });
        v4 = game;
        r24 = loadstring(v4.HttpGet(v4, "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))();
        K = game;
        r25 = K.GetService(K, "Players");
        v4 = game;
        r26 = v4.GetService(v4, "RunService");
        v2 = game;
        v2.GetService(v2, "TweenService");
        v2 = game;
        r27 = v2.GetService(v2, "Workspace");
        U = game;
        U.GetService(U, "Teams");
        U = game;
        r28 = U.GetService(U, "ReplicatedStorage");
        v6 = game;
        r29 = v6.GetService(v6, "Lighting");
        r30 = r25.LocalPlayer;
        r31 = 100;
        r32 = "Skillcheck-gen";
        r33 = false;
        r34 = false;
        r35 = false;
        r36 = false;
        r37 = false;
        r38 = false;
        r39 = 0.5;
        r40 = r29.Ambient;
        r41 = r29.OutdoorAmbient;
        r42 = {};
        r43 = {};
        r49 = {};
        r52 = false;
        r53 = 200;
        r54 = "Head";
        r55 = true;
        r56 = false;
        local function r57(...)
            v1 = r27.CurrentCamera;
            Vector2.new(v1.ViewportSize.X / 2, v1.ViewportSize.Y / 2);
            W = r53;
            v2 = r25;
            R = v2[2];
            v2 = v2[1];
            for v4, U in ipairs(v2.GetPlayers(v2)) do
                v7 = v4;
                if U ~= r30 and U.Character then
                    if r55 and U.Team == r30.Team then
                        
                    else
                        v8 = r15;
                        v5 = U.Character;
                        l = v5.FindFirstChild(v5, r54);
                        if l then
                            v8 = {
                                v1.WorldToViewportPoint(v1, l.Position)
                            };
                            V = v1.WorldToViewportPoint(v1, l.Position);
                            if v8[2] then
                                v9 = (Vector2.new(v1.ViewportSize.X / 2, v1.ViewportSize[r16[r15(l, v6)]] / 2) - Vector2.new(V.X, V.Y)).Magnitude;
                                v5 = v9 < r53;
                                if v5 then
                                    v5 = (g - v8)[G];
                                    W = v9;
                                    K = U;
                                end;
                            end;
                        end;
                    end;
                else
                    
                end; 
            end;
            return nil; 
        end;
        r59 = false;
        local function Ww(...)
            v5 = r58;
            if v5 then
                v5 = r58;
                v5.Destroy(v5);
            end;
            v1 = Instance.new("Part");
            v1.Name = "FOVCircle";
            v1.Anchored = true;
            v1.CanCollide = false;
            v1.Transparency = .8;
            v1.Material = Enum.Material.Neon;
            v1.Color = Color3.fromRGB(255, 255, 255);
            v1.Size = Vector3.new(0.5, 0.5, 0.5);
            v1.Shape = Enum.PartType.Ball;
            v1.Parent = r27;
            r58 = v1;
            v3 = r26.Heartbeat;
            v3.Connect(v3, function(...)
                if r56 and (r58 and r30.Character) then
                    K = r53 / 10;
                    r58.Position = r30.Character.Head.Position + r27.CurrentCamera.CFrame.LookVector * K;
                    r58.Size = Vector3.new(K / 2, K / 2, K / 2);
                    r58.Transparency = .8;
                else
                    if r58 then
                        r58.Transparency = 1;
                    end;
                    return;
                end; 
            end);
            return; 
        end;
        Lw = r30;
        Lw.GetMouse(Lw);
        local function Lw(...)
            v1 = r57();
            if not v1 or not v1.Character then
                return false;
            end;
            v5 = v1.Character;
            r60 = v5.FindFirstChild(v5, r54);
            if not r60 then
                return false;
            end;
            K = r28;
            K = K.FindFirstChild(K, "Remotes") and K.FindFirstChild(K, "Items");
            if not K then
                return false;
            end;
            v2 = K.GetChildren;
            v4 = {
                v2(K)
            };
            W = v2[2];
            R = v2[3];
            for R, v7 in ipairs(Z("ipairs")) do
                v8 = "\x01\xa3-\x9d";
                v2 = R;
                r61 = v7.FindFirstChild(v7, r16[r15(v8, 17440901619641)]);
                if r61 then
                    v8 = {
                        pcall(function(...)
                            v5 = r61;
                            v5.FireServer(v5, r60.Position);
                            return; 
                        end)
                    };
                    v6 = v8[2];
                    if pcall(function(...)
                        v5 = r61;
                        v5.FireServer(v5, r60.Position);
                        return; 
                    end) then
                        v5 = r24;
                        v5.Notify(v5, {
                            ["Title"] = "Auto Fire",
                            ["Content"] = "Shot at " .. r57().Name
                        });
                        return true;
                    else
                        
                    end;
                end; 
            end;
            return false; 
        end;
        Hw = game;
        r62 = Hw.GetService(Hw, "VirtualInputManager");
        local function Mw(...)
            v1 = r57();
            if not v1 or not v1.Character then
                return;
            end;
            v5 = v1.Character;
            g = v5.FindFirstChild(v5, r54);
            if not g then
                return;
            end;
            K = r27.CurrentCamera;
            K.CFrame = CFrame.new(K.CFrame.Position, g.Position);
            task.wait(.05);
            v5 = r62;
            v5.SendMouseButtonEvent(v5, 0, 0, 0, true, game, 0);
            task.wait(.1);
            v5 = r62;
            v5.SendMouseButtonEvent(v5, 0, 0, 0, false, game, 0);
            v5 = r24;
            v5.Notify(v5, {
                ["Title"] = "Auto Fire",
                ["Content"] = "Shot at " .. v1.Name
            });
            return; 
        end;
        local function r63(arg1_2, arg2_2, ...)
            g = arg2_2;
            v1 = arg1_2;
            if type(g) == "string" then
                g = {
                    arg2_2
                };
            end;
            v2 = v1.GetChildren;
            R = v2[3];
            for R, v2 in v2[1], ipairs(v2(v1)) do
                v4 = R;
                V = r15;
                l = V[2];
                U = V[1];
                for v6, v8 in ipairs(g) do
                    V = v6;
                    if string.find(string.lower(v2.Name), string.lower(v8)) then
                        return v2;
                    else
                        
                    end; 
                end; 
            end;
            return nil; 
        end;
        local function r64(...)
            v1 = r28;
            K = "Remotes";
            g = v1.FindFirstChild(v1, K);
            if g then
                K = r28.Remotes;
                v5 = h[g];
                v3 = K.FindFirstChild(K, "Generator") and K.FindFirstChild(K, "RepairEvent");
            end;
            return g; 
        end;
        local function r65(arg1_3, ...)
            v1 = arg1_3;
            if not v1 or not v1.Team then
                return false;
            end;
            return string.find(string.lower(v1.Team.Name), "killer") ~= nil; 
        end;
        local function r66(...)
            W = r27;
            g = W[2];
            W = W[1];
            for K, v4 in ipairs(W.GetDescendants(W)) do
                R = K;
                if v4.Name == "Generator" and v4.IsA(v4, "Model") then
                    table.insert({}, v4);
                end; 
            end;
            return {}; 
        end;
        local function r67(arg1_4, ...)
            v1 = arg1_4;
            for g = 1, 4 do
                v2 = v1.FindFirstChild(v1, "GeneratorPoint" .. g);
                if v2 then
                    v3 = v2.IsA(v2, "BasePart");
                end;
                if v2 then
                    return v2;
                else
                    
                end; 
            end;
            g = v1.PrimaryPart;
            if g then
                return g;
            else
                v3 = v1.FindFirstChildWhichIsA(v1, "BasePart");
            end; 
        end;
        local function r68(arg1_5, arg2_5, arg3_5, arg4_5, ...)
            v1 = arg1_5;
            W = arg4_5;
            K = arg3_5;
            R = {};
            v4 = Instance.new("BoxHandleAdornment");
            v5 = "Size";
            v7 = W;
            v2 = v5;
            if W then
                v7 = Vector3.new(4, 6, 4);
            end;
            v3 = v7;
            v5 = v5;
            if v7 then
                v5 = r15;
                v4[v5] = v7;
                v4.AlwaysOnTop = true;
                v4.ZIndex = 5;
                v4.Transparency = 0.5;
                v3 = arg3_5;
                v4.Color3 = v3;
                v3 = arg1_5;
                v4.Adornee = v3;
                v4.Parent = v1;
                R.box = v4;
                v2 = Instance.new("BillboardGui");
                v2.Size = UDim2.new(0, 150, 0, 40);
                v2.StudsOffset = Vector3.new(0, 4.5, 0);
                v2.AlwaysOnTop = true;
                v2.Adornee = v1;
                v2.Parent = v1;
                v7 = Instance.new("TextLabel", v2);
                v7.Size = UDim2.new(1, 0, 1, 0);
                v7.BackgroundTransparency = 1;
                v7.TextColor3 = K;
                v7.TextSize = 12;
                v7.Font = Enum.Font.GothamBold;
                v3 = arg2_5;
                v7.Text = v3;
                v7.TextStrokeTransparency = 0.5;
                R.gui = v2;
                R.label = v7;
                return R;
            else
                v3 = Vector3.new(4, 4, 4);
            end; 
        end;
        cw = r24;
        r69 = cw.CreateWindow(cw, {
            ["Title"] = "ANCH Hax",
            ["Author"] = "by ANCH",
            ["Icon"] = "anchor",
            ["Folder"] = "ANCHHax",
            ["OpenButton"] = {
                ["Enabled"] = true,
                ["Draggable"] = false,
                ["OnlyIcon"] = false,
                ["CornerRadius"] = UDim.new(1, 0),
                ["StrokeThickness"] = 3,
                ["Title"] = "ANCH Hax",
                ["Color"] = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f"))
            }
        });
        g8 = r69;
        g8.Tag(g8, {
            ["Title"] = "V2.0",
            ["Color"] = Color3.fromHex("#18c426"),
            ["Border"] = true
        });
        g8 = r69;
        g8.DisableTopbarButtons(g8, {
            "Fullscreen"
        });
        g8 = r69;
        z8 = g8.Tab(g8, {
            ["Title"] = "Info",
            ["Desc"] = "Important Information & Updates",
            ["Icon"] = "solar:info-circle-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        z8.Section(z8, {
            ["Title"] = "Hello " .. r30.Name .. "!",
            ["TextSize"] = 20,
            ["FontWeight"] = Enum.FontWeight.SemiBold
        });
        z8.Section(z8, {
            ["Title"] = "\xe2\x9a\xa0\xef\xb8\x8f Development Notice:\n\nThis script is still under development!\nThere is a possibility it may get detected if used in public servers.\n\nNeed help or just wanna hang out?\nJoin our Discord server below!",
            ["TextSize"] = 18,
            ["TextTransparency"] = .35,
            ["FontWeight"] = Enum.FontWeight.SemiBold,
            ["Box"] = true,
            ["BoxBorder"] = true,
            ["Opened"] = true
        });
        r70 = "RbPdBpV4Mc";
        r71 = "https://discord.com/api/v10/invites/" .. r70 .. "?with_counts=true&with_expiration=true";
        Uw = {
            pcall(function(...)
                v5 = game;
                v3 = v5.GetService(v5, "HttpService");
                g = game;
                K = g.GetService(g, "HttpService");
                return v3.JSONDecode(v3, K.RequestAsync(K, {
                    ["Url"] = r71,
                    ["Method"] = "GET",
                    ["Headers"] = {
                        ["User-Agent"] = "ANCH-Hub/1.0",
                        ["Accept"] = "application/json"
                    }
                }).Body); 
            end)
        };
        rw = Uw[2];
        Vw = pcall(function(...)
            v5 = game;
            v3 = v5.GetService(v5, "HttpService");
            g = game;
            K = g.GetService(g, "HttpService");
            return v3.JSONDecode(v3, K.RequestAsync(K, {
                ["Url"] = r71,
                ["Method"] = "GET",
                ["Headers"] = {
                    ["User-Agent"] = "ANCH-Hub/1.0",
                    ["Accept"] = "application/json"
                }
            }).Body); 
        end);
        if Vw then
            if rw then
                Uw = Uw[2].guild;
            end;
            v5 = h[g];
            g8 = rw;
        end;
        v5 = h[g];
        if Vw then
            z8.Section(z8, {
                ["Title"] = "\xf0\x9f\x92\xac Join our Discord server!",
                ["TextSize"] = 20,
                ["FontWeight"] = Enum.FontWeight.SemiBold
            });
            z8.Space(z8);
            jw = v5;
            v5 = v5;
            z8.Paragraph(z8, {
                ["Title"] = tostring(rw.guild.name),
                ["Desc"] = tostring(rw.guild.description or "Official ANCH Hub Discord Server"),
                ["Image"] = "https://cdn.discordapp.com/icons/" .. rw.guild.id .. "/" .. rw.guild.icon .. ".png?size=1024",
                ["Thumbnail"] = rw.guild.banner and "https://cdn.discordapp.com/banners/" .. rw.guild.id .. "/" .. rw.guild.banner .. ".png?size=512" or nil,
                ["ImageSize"] = 48,
                ["Buttons"] = {
                    {
                        ["Title"] = "Copy link",
                        ["Icon"] = "link",
                        ["Callback"] = function(...)
                            v5 = setclipboard;
                            if v5 then
                                setclipboard("https://discord.gg/" .. r70);
                                v5 = r24;
                                v5.Notify(v5, {
                                    ["Title"] = "Discord Link Copied!",
                                    ["Content"] = "Link has been copied to clipboard."
                                });
                            else
                                v5 = r24;
                                v5.Notify(v5, {
                                    ["Title"] = "Clipboard Not Supported",
                                    ["Content"] = "Check console for link."
                                });
                                print("Discord: https://discord.gg/" .. r70);
                            end;
                            return; 
                        end
                    },
                    {
                        ["Title"] = "Open Discord",
                        ["Icon"] = "solar:chat-round-line-bold",
                        ["Callback"] = function(...)
                            v5 = r24;
                            v5.Notify(v5, {
                                ["Title"] = "Opening Discord",
                                ["Content"] = "Check your browser!"
                            });
                            if syn and syn.request then
                                syn.request({
                                    ["Url"] = "https://discord.gg/" .. r70,
                                    ["Method"] = "GET"
                                });
                            end;
                            return; 
                        end
                    }
                }
            });
            if rw.approximate_member_count then
                z8.Space(z8);
                v5 = v5;
                z8.Section(z8, {
                    ["Title"] = "\xf0\x9f\x91\xa5 Members: " .. tostring(rw.approximate_member_count) .. " | \xf0\x9f\x9f\xa2 Online: " .. tostring(rw.approximate_presence_count or "N/A"),
                    ["TextSize"] = 14,
                    ["TextTransparency"] = .4,
                    ["FontWeight"] = Enum.FontWeight.Regular
                });
            end;
        else
            z8.Section(z8, {
                ["Title"] = "\xf0\x9f\x92\xac Join our Discord server!",
                ["TextSize"] = 20,
                ["FontWeight"] = Enum.FontWeight.SemiBold
            });
            z8.Space(z8);
            z8.Button(z8, {
                ["Title"] = "Copy Discord Link",
                ["Color"] = Color3.fromHex("#5865F2"),
                ["Justify"] = "Center",
                ["Icon"] = "solar:chat-round-line-bold",
                ["IconAlign"] = "Left",
                ["Callback"] = function(...)
                    v5 = setclipboard;
                    if v5 then
                        setclipboard("https://discord.gg/" .. r70);
                        v5 = r24;
                        v5.Notify(v5, {
                            ["Title"] = "Discord Link Copied!",
                            ["Content"] = "Link has been copied to clipboard."
                        });
                    else
                        print("Discord: https://discord.gg/" .. r70);
                    end;
                    return; 
                end
            });
        end;
        z8.Space(z8, {
            ["Columns"] = 3
        });
        g8 = z8.Section(z8, {
            ["Title"] = "\xe2\x9a\xa0\xef\xb8\x8f Use at your own risk!"
        });
        g8.Space(g8);
        g8.Section(g8, {
            ["Title"] = "By using ANCH Hub, you acknowledge that:\n\n\xe2\x80\xa2 This script may be detected by anti-cheat systems\n\xe2\x80\xa2 Your account could potentially be banned\n\xe2\x80\xa2 The developer is not responsible for any consequences\n\xe2\x80\xa2 Always use in private servers when possible",
            ["TextSize"] = 15,
            ["TextTransparency"] = .4,
            ["FontWeight"] = Enum.FontWeight.Regular
        });
        Pw = z8.Section(z8, {
            ["Title"] = "\xf0\x9f\x91\xa4 Credits & Information"
        });
        Pw.Space(Pw);
        Pw.Section(Pw, {
            ["Title"] = "ANCH Hub - Violence District Script\n\nDeveloper: ANCH\nVersion: 2.0 (Stable Release)\nUI Library: Wind UI by Footagesus\nGame: Violence District (Roblox)\n\nLast Updated: " .. os.date("%B %d, %Y"),
            ["TextSize"] = 15,
            ["TextTransparency"] = .35,
            ["FontWeight"] = Enum.FontWeight.Regular
        });
        lw = z8.Section(z8, {
            ["Title"] = "\xe2\x9c\xa8 Features Overview"
        });
        lw.Space(lw);
        lw.Section(lw, {
            ["Title"] = "Current Features:\n\n\xf0\x9f\x8e\xaf Auto-Farm Generator (with killer detection)\n\xf0\x9f\x8e\x81 Auto-Farm Christmas Presents  \n\xf0\x9f\x94\xab Auto Aim System\n\xf0\x9f\x91\x81\xef\xb8\x8f ESP for Survivors, Killers & Generators\n\xf0\x9f\x8f\x83 Movement: NoClip, Blink Speed\n\xf0\x9f\x93\x8d Teleportation: Players & Generators\n\xf0\x9f\x94\x8d Unlimited Camera Zoom\n\xf0\x9f\x8c\x9f Full Bright Lighting\n\xf0\x9f\x8e\xa8 Body Lock / Target Lock",
            ["TextSize"] = 14,
            ["TextTransparency"] = .3,
            ["FontWeight"] = Enum.FontWeight.Regular
        });
        z8.Space(z8, {
            ["Columns"] = 2
        });
        z8.Button(z8, {
            ["Title"] = "Show Keybinds",
            ["Color"] = Color3.fromHex("#30d5ff"),
            ["Justify"] = "Center",
            ["Icon"] = "solar:keyboard-bold",
            ["IconAlign"] = "Left",
            ["Callback"] = function(...)
                v5 = r24;
                v5.Notify(v5, {
                    ["Title"] = "Keybinds",
                    ["Content"] = "RightShift or Insert = Toggle UI\nESC = Close UI"
                });
                return; 
            end
        });
        z8.Space(z8, {
            ["Columns"] = 1
        });
        z8.Button(z8, {
            ["Title"] = "Changelog",
            ["Color"] = Color3.fromHex("#a2ff30"),
            ["Justify"] = "Center",
            ["Icon"] = "solar:document-text-bold",
            ["IconAlign"] = "Left",
            ["Callback"] = function(...)
                v5 = r24;
                v5.Notify(v5, {
                    ["Title"] = "V2.0 Changelog",
                    ["Content"] = "All features stable & New UI Design."
                });
                return; 
            end
        });
        z8.Space(z8, {
            ["Columns"] = 1
        });
        z8.Button(z8, {
            ["Title"] = "Destroy UI",
            ["Color"] = Color3.fromHex("#ff4830"),
            ["Justify"] = "Center",
            ["Icon"] = "solar:trash-bin-trash-bold",
            ["IconAlign"] = "Left",
            ["Callback"] = function(...)
                v5 = r44;
                if v5 then
                    v5 = r44;
                    v5.Disconnect(v5);
                end;
                v5 = r45;
                if v5 then
                    v5 = r45;
                    v5.Disconnect(v5);
                end;
                v5 = r46;
                if v5 then
                    v5 = r46;
                    v5.Disconnect(v5);
                end;
                v5 = r58;
                if v5 then
                    v5 = r58;
                    v5.Destroy(v5);
                end;
                _G.NoSkill = false;
                r59 = false;
                r52 = false;
                v1 = r24;
                v1.Notify(v1, {
                    ["Title"] = "ANCH Hub",
                    ["Content"] = "UI destroyed. Thanks for using!"
                });
                task.wait(1);
                v1 = r69;
                v1.Destroy(v1);
                return; 
            end
        });
        g8 = r69;
        z8 = g8.Tab(g8, {
            ["Title"] = "General",
            ["Icon"] = "solar:home-2-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        z8.Toggle(z8, {
            ["Title"] = "NoClip",
            ["Desc"] = "Walk through walls",
            ["Callback"] = function(arg1_6, ...)
                if arg1_6 then
                    v5 = r26.Stepped;
                    r44 = v5.Connect(v5, function(...)
                        K = r15;
                        if r30.Character then
                            K = r30.Character;
                            g = K[3];
                            K = K[1];
                            for g, R in K, pairs(K.GetDescendants(K)) do
                                W = g;
                                if R.IsA(R, "BasePart") then
                                    R.CanCollide = false;
                                end; 
                            end;
                        end;
                        return; 
                    end);
                else
                    v5 = r44;
                    if v5 then
                        v5 = h[Zw];
                        v5.Disconnect(v5);
                    end;
                    return;
                end; 
            end
        });
        z8.Toggle(z8, {
            ["Title"] = "Flicker/Blink Speed",
            ["Desc"] = "Fast movement with blink effect",
            ["Callback"] = function(arg1_7, ...)
                v1 = arg1_7;
                r38 = v1;
                if v1 then
                    v3 = r26.Heartbeat;
                    r45 = v3.Connect(v3, function(...)
                        v1 = r30.Character;
                        v3 = v1;
                        v1 = v3 and v1.FindFirstChild(v1, "HumanoidRootPart");
                        if v1 then
                            v3 = v1.AssemblyLinearVelocity.Magnitude > .1;
                        end;
                        if v1 then
                            v1.CFrame = v1.CFrame + v1.CFrame.lookVector * r39;
                        end;
                        return; 
                    end);
                else
                    v3 = r45;
                    if v3 then
                        v3 = h[b];
                        v3.Disconnect(v3);
                    end;
                    return;
                end; 
            end
        });
        z8.Space(z8, {
            ["Columns"] = 2
        });
        z8.Section(z8, {
            ["Title"] = "Teleportation",
            ["TextSize"] = 20,
            ["FontWeight"] = Enum.FontWeight.SemiBold
        });
        z8.Space(z8);
        r50 = z8.Dropdown(z8, {
            ["Title"] = "Select Player Target",
            ["Values"] = {},
            ["Callback"] = function(arg1_8, ...)
                r47 = arg1_8;
                return; 
            end
        });
        z8.Button(z8, {
            ["Title"] = "Refresh Player List",
            ["Icon"] = "solar:refresh-bold",
            ["Callback"] = function(...)
                v1 = {};
                W = r25;
                K = W[3];
                W = W[1];
                for K, v4 in W, ipairs(W.GetPlayers(W)) do
                    R = K;
                    if v4 ~= r30 then
                        table.insert({}, v4.Name);
                    end; 
                end;
                v5 = r50;
                v5.Refresh(v5, v1);
                v5 = r51;
                if v5 then
                    v5 = r51;
                    v5.Refresh(v5, v1);
                end;
                v5 = r24;
                v5.Notify(v5, {
                    ["Title"] = "Player List",
                    ["Content"] = "Refreshed! Found " .. #v1 .. " players."
                });
                return; 
            end
        });
        z8.Button(z8, {
            ["Title"] = "TP to Selected Player",
            ["Icon"] = "solar:user-bold",
            ["Color"] = Color3.fromHex("#30d5ff"),
            ["Callback"] = function(...)
                v5 = r25;
                v1 = v5.FindFirstChild(v5, r47 or "");
                if v1 then
                    W = v1.Character;
                    if W then
                        W = v5.FindFirstChild(v5, K or "").Character;
                        g = W.FindFirstChild(W, "HumanoidRootPart");
                    end;
                    v5 = g;
                    v3 = W;
                end;
                if v1 then
                    r30.Character.HumanoidRootPart.CFrame = v1.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0);
                    v5 = r24;
                    v5.Notify(v5, {
                        ["Title"] = "Teleported",
                        ["Content"] = "Teleported to " .. v1.Name
                    });
                else
                    v5 = r24;
                    v5.Notify(v5, {
                        ["Title"] = "Error",
                        ["Content"] = "Player not found or invalid!"
                    });
                end;
                return; 
            end
        });
        z8.Space(z8, {
            ["Columns"] = 1
        });
        r72 = z8.Dropdown(z8, {
            ["Title"] = "Select Generator Target",
            ["Values"] = {},
            ["Callback"] = function(arg1_9, ...)
                r48 = arg1_9;
                return; 
            end
        });
        z8.Button(z8, {
            ["Title"] = "Refresh Generator List",
            ["Icon"] = "solar:refresh-bold",
            ["Callback"] = function(...)
                r49 = {};
                v1 = {};
                R = r66;
                v4 = {
                    R()
                };
                W = R[3];
                K = R[2];
                for W, v4 in ipairs(Z(v4)) do
                    v2 = "Generator " .. W;
                    r49[v2] = v4;
                    table.insert(v1, v2); 
                end;
                v3 = r72;
                v3.Refresh(v3, v1);
                v3 = r24;
                v3.Notify(v3, {
                    ["Title"] = "Generator List",
                    ["Content"] = "Found " .. #v1 .. " generators."
                });
                return; 
            end
        });
        z8.Button(z8, {
            ["Title"] = "TP to Selected Generator",
            ["Icon"] = "solar:electric-refueling-bold",
            ["Color"] = Color3.fromHex("#a2ff30"),
            ["Callback"] = function(...)
                if r48 and r49[r48] then
                    v5 = r67;
                    v1 = v5(r49[r48]);
                    if v1 then
                        r30.Character.HumanoidRootPart.CFrame = v1.CFrame * CFrame.new(0, 3, 3);
                        v5 = r24;
                        v5.Notify(v5, {
                            ["Title"] = "Teleported",
                            ["Content"] = "Teleported to " .. r48
                        });
                    end;
                else
                    v5 = r24;
                    v5.Notify(v5, {
                        ["Title"] = "Error",
                        ["Content"] = "Please select a generator first!"
                    });
                end;
                return; 
            end
        });
        Pw = r69;
        Vw = Pw.Tab(Pw, {
            ["Title"] = "Survivor",
            ["Icon"] = "solar:check-square-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        Vw.Toggle(Vw, {
            ["Title"] = "Auto-Farm Generator",
            ["Desc"] = "Auto teleport & complete generator",
            ["Callback"] = function(arg1_10, ...)
                v1 = arg1_10;
                r36 = v1;
                if v1 then
                    task.spawn(function(...)
                        while r36 do
                            v1 = r64();
                            K = {};
                            v5 = ipairs;
                            W = v4[2];
                            v4 = R();
                            for R, v7 in v5(r66()) do
                                l = ipairs;
                                if (v7.GetAttribute(v7, "RepairProgress") or 0) < 100 then
                                    table.insert({}, v7);
                                end; 
                            end;
                            v4 = #K > 0;
                            W = v4;
                            if v4 then
                                W = r64();
                            end;
                            v5 = v5;
                            if W then
                                W = K[math.random(1, #K)];
                                v4 = r67(W);
                                G = r15("\xdcY\xfe", 7215376452895);
                                r30.Character.HumanoidRootPart.CFrame = v4.CFrame * CFrame[r16[G]](0, 2, 3);
                                task.wait(0.5);
                                v1.FireServer(v1, v4, true);
                                R = not r36 or (W.GetAttribute(W, "RepairProgress") or 0) >= 100;
                                v5 = false;
                                task.wait(0.5);
                                v2 = ipairs;
                                v6 = r25;
                                U = v6[2];
                                v7 = v6[1];
                                for l, v6 in v2(v6.GetPlayers(v6)) do
                                    v2 = l;
                                    G = r65(v6);
                                    if G then
                                        y = v6.Character;
                                        if y then
                                            y = v6.Character;
                                            v9 = y.FindFirstChild(y, "HumanoidRootPart");
                                        end;
                                        v5 = R;
                                        V = y;
                                    end;
                                    v5 = R;
                                    if G then
                                        if (r30.Character.HumanoidRootPart.Position - v6.Character.HumanoidRootPart.Position).Magnitude < r31 then
                                            R = true;
                                        else
                                            
                                        end;
                                    end; 
                                end;
                                if false then
                                    
                                else
                                    v2 = not r36 or (W.GetAttribute(W, "RepairProgress") or 0) >= 100;
                                    v5 = not r36 or (W.GetAttribute(W, "RepairProgress") or 0) >= 100;
                                    if not r36 or (W.GetAttribute(W, "RepairProgress") or 0) >= 100 then
                                        v1.FireServer(v1, r67(W), false);
                                        task.wait(1.5);
                                    end;
                                end;
                            else
                                task.wait(2);
                            end; 
                        end;
                        return; 
                    end);
                end;
                return; 
            end
        });
        r73 = false;
        Vw.Toggle(Vw, {
            ["Title"] = "Auto-Farm Present",
            ["Desc"] = "Farm Gift \xe2\x86\x92 Teleport to Christmas Tree",
            ["Callback"] = function(arg1_11, ...)
                v1 = arg1_11;
                r73 = v1;
                if v1 then
                    v3 = r24;
                    v3.Notify(v3, {
                        ["Title"] = "Auto-Farm Present",
                        ["Content"] = "Started!"
                    });
                    task.spawn(function(...)
                        while r73 do
                            g = pcall(function(...)
                                v5 = r27;
                                v1 = v5.FindFirstChild(v5, "Map");
                                if not v1 then
                                    task.wait(3);
                                    return;
                                end;
                                g = r63(v1, {
                                    "chris",
                                    "christmas"
                                });
                                if not g then
                                    task.wait(3);
                                    return;
                                end;
                                K = r63(g, {
                                    "gift"
                                });
                                if not K then
                                    task.wait(3);
                                    return;
                                end;
                                W = {};
                                v7 = K.GetChildren;
                                v2 = {
                                    v7(K)
                                };
                                v4 = v7[3];
                                v2 = v7[1];
                                for v4, U in v2, ipairs(Z(v2)) do
                                    v7 = v4;
                                    if string.find(string.lower(U.Name), "gift") then
                                        l = U.FindFirstChild(U, "GiftHandle") or U.FindFirstChildWhichIsA(U, "BasePart");
                                        if l then
                                            table.insert({}, {
                                                ["model"] = U,
                                                ["handle"] = l
                                            });
                                        end;
                                    end; 
                                end;
                                if #W == 0 then
                                    v5 = r24;
                                    v5.Notify(v5, {
                                        ["Title"] = "Info",
                                        ["Content"] = "No gifts available, waiting..."
                                    });
                                    task.wait(3);
                                    return;
                                end;
                                v5 = W[1];
                                v2 = r30.Character;
                                if v2 then
                                    v2 = r30.Character;
                                    v4 = v2.FindFirstChild(v2, "HumanoidRootPart");
                                end;
                                if v2 then
                                    r30.Character.HumanoidRootPart.CFrame = v5.handle.CFrame * CFrame.new(0, 3, 0);
                                    task.wait(.8);
                                    v5 = r28;
                                    v4 = v5.FindFirstChild(v5, "Remotes");
                                    if v4 then
                                        v4 = v4.FindFirstChild(v4, "Events");
                                        if v4 then
                                            v4 = v5.FindFirstChild(v5, "Christmas");
                                            if v4 then
                                                U = "gift";
                                                v4 = v2.FindFirstChild(v2, U);
                                                if v4 then
                                                    v4.FireServer(v4, v5.model);
                                                    task.wait(.8);
                                                else
                                                    U = r24;
                                                    U.Notify(U, {
                                                        ["Title"] = "Error",
                                                        ["Content"] = "Gift remote not found!"
                                                    });
                                                end;
                                            end;
                                        end;
                                    end;
                                    l = r63(g, {
                                        "tree",
                                        "tute"
                                    });
                                    if l then
                                        v8 = y[1];
                                        v9 = y[2];
                                        for G, y in ipairs(l.GetChildren(l)) do
                                            V = G;
                                            B = y.FindFirstChild(y, "ChristmasTree");
                                            if B then
                                                v5 = r28;
                                                if B.FindFirstChild(B, "TreePine") or B.FindFirstChildWhichIsA(B, "BasePart") then
                                                    
                                                else
                                                    
                                                end;
                                            else
                                                v6 = y.FindFirstChildWhichIsA(y, "BasePart");
                                                if v6 then
                                                    
                                                else
                                                end;
                                            end; 
                                        end;
                                        if nil then
                                            r30.Character.HumanoidRootPart.CFrame = nil.CFrame * CFrame.new(0, 5, 3);
                                            task.wait(1.5);
                                        else
                                        end;
                                    else
                                    end;
                                    task.wait(2);
                                end;
                                return; 
                            end);
                            if not g then
                                v5 = r24;
                                v5.Notify(v5, {
                                    ["Title"] = "Critical Error",
                                    ["Content"] = tostring(K[2])
                                });
                                task.wait(3);
                            end; 
                        end;
                        return; 
                    end);
                else
                    v3 = r24;
                    v3.Notify(v3, {
                        ["Title"] = "Auto-Farm Present",
                        ["Content"] = "Stopped!"
                    });
                end;
                return; 
            end
        });
        Vw.Toggle(Vw, {
            ["Title"] = "No Skill Check",
            ["Desc"] = "Remove Generator & Healing Skill Check",
            ["Callback"] = function(arg1_12, ...)
                g = arg1_12;
                _G.NoSkill = g;
                task.spawn(function(...)
                    while _G.NoSkill do
                        v1 = r30;
                        v1 = v1.FindFirstChild(v1, "PlayerGui", true) and v1.FindFirstChild(v1, r32, true);
                        if v1 then
                            v1.Destroy(v1);
                        end;
                        task.wait(.1); 
                    end;
                    return; 
                end);
                return; 
            end
        });
        Pw = r69;
        Ow = Pw.Tab(Pw, {
            ["Title"] = "Killer",
            ["Icon"] = "solar:ghost-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        r51 = Ow.Dropdown(Ow, {
            ["Title"] = "Select Target",
            ["Values"] = {},
            ["Callback"] = function(arg1_13, ...)
                r47 = arg1_13;
                return; 
            end
        });
        Ow.Button(Ow, {
            ["Title"] = "Refresh Player List",
            ["Callback"] = function(...)
                v1 = {};
                W = r25;
                K = W[3];
                W = W[1];
                for K, v4 in W, ipairs(W.GetPlayers(W)) do
                    R = K;
                    if v4 ~= r30 then
                        table.insert({}, v4.Name);
                    end; 
                end;
                v5 = r51;
                v5.Refresh(v5, v1);
                v5 = r50;
                if v5 then
                    v5 = r50;
                    v5.Refresh(v5, v1);
                end;
                return; 
            end
        });
        Ow.Toggle(Ow, {
            ["Title"] = "Body Lock",
            ["Desc"] = "Select Target from Dropdown",
            ["Callback"] = function(arg1_14, ...)
                v1 = arg1_14;
                r37 = v1;
                if v1 then
                    v3 = r26.Heartbeat;
                    r46 = v3.Connect(v3, function(...)
                        v5 = r25;
                        v1 = v5.FindFirstChild(v5, r47 or "");
                        if v1 then
                            W = v1.Character;
                            if W then
                                W = v5.FindFirstChild(v5, K or "").Character;
                                g = W.FindFirstChild(W, "HumanoidRootPart");
                            end;
                            v5 = g;
                            v3 = W;
                        end;
                        if v1 then
                            r30.Character.HumanoidRootPart.CFrame = v1.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5);
                        end;
                        return; 
                    end);
                else
                    v3 = r46;
                    if v3 then
                        v3 = h[s];
                        v3.Disconnect(v3);
                    end;
                    return;
                end; 
            end
        });
        Uw = r69;
        Gw = Uw.Tab(Uw, {
            ["Title"] = "Visuals",
            ["Icon"] = "solar:eye-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        Gw.Toggle(Gw, {
            ["Title"] = "Survivor ESP",
            ["Desc"] = "Enable ESP to Survivor (Blue)",
            ["Callback"] = function(arg1_15, ...)
                r33 = arg1_15;
                return; 
            end
        });
        Gw.Toggle(Gw, {
            ["Title"] = "Killer ESP",
            ["Desc"] = "Enable ESP to Killer (Red)",
            ["Callback"] = function(arg1_16, ...)
                r34 = arg1_16;
                return; 
            end
        });
        Gw.Toggle(Gw, {
            ["Title"] = "Generator ESP",
            ["Desc"] = "Enable ESP to Generator",
            ["Callback"] = function(arg1_17, ...)
                v1 = arg1_17;
                r35 = v1;
                if not v1 then
                    v3 = pairs;
                    g = 34[1];
                    K = 34[2];
                    for W, v4 in v3(r43) do
                        R = W;
                        v3 = v4.box;
                        v3.Destroy(v3);
                        v3 = v4.gui;
                        v3.Destroy(v3); 
                    end;
                    r43 = {};
                end;
                return; 
            end
        });
        Gw.Toggle(Gw, {
            ["Title"] = "Unlimited Zoom",
            ["Desc"] = "Make your vision longer",
            ["Callback"] = function(arg1_18, ...)
                if arg1_18 then
                    r30.CameraMaxZoomDistance = 100;
                else
                    r30.CameraMaxZoomDistance = 30;
                end;
                return; 
            end
        });
        Gw.Toggle(Gw, {
            ["Title"] = "Full Bright",
            ["Desc"] = "Full Bright for Map",
            ["Callback"] = function(arg1_19, ...)
                v5 = r29;
                v1 = arg1_19;
                R = v5;
                K = v5;
                v5.Brightness = v1 and 2 or 1;
                if v1 then
                    R = Color3.new(1, 1, 1);
                end;
                v5 = v5;
                r29.Ambient = v1 or r40;
                if v1 then
                    R = Color3.new(1, 1, 1);
                end;
                v5 = v5;
                v5 = v5;
                r29.OutdoorAmbient = v1 or r41;
                return; 
            end
        });
        Uw = r26.Heartbeat;
        Uw.Connect(Uw, function(...)
            K = r25;
            W = {
                K.GetPlayers(K)
            };
            v1 = K[2];
            K = K[1];
            for g, R in ipairs(Z(W)) do
                W = g;
                v4 = R ~= r30 and R.Character;
                if v4 then
                    v5 = r65;
                    v4 = v5(R);
                    if v4 then
                        v7 = r34;
                    end;
                    l = not v4;
                    if l then
                        v7 = r33;
                    end;
                    v5 = v5;
                    v5 = v5;
                    if v4 or l then
                        U = r42;
                        v5 = not U[R];
                        if v5 then
                            U = v5(R);
                            v7 = U and Color3.new(1, 0, 0);
                            v5 = not v7;
                            if U then
                                r42[R] = r68(R.Character.HumanoidRootPart, R.Name, U and Color3.new(1, 0, 0), true);
                            else
                                v7 = Color3.new(0, 0.5, 1);
                            end;
                        else
                            v5 = r42[R].label;
                            if v4 then
                                G = " [KILLER]";
                            end;
                            v5 = v5;
                            v5 = v5;
                            v5.Text = R.Name .. (v4 or " [SURVIVOR]") .. "\n" .. math.floor((r30.Character.HumanoidRootPart.Position - R.Character.HumanoidRootPart.Position).Magnitude) .. "m";
                        end;
                    else
                        if r42[R] then
                            v5 = r42[R].box;
                            v5.Destroy(v5);
                            v5 = r42[R].gui;
                            v5.Destroy(v5);
                            r42[R] = nil;
                        end;
                    end;
                end; 
            end;
            if r35 then
                W = r66;
                R = {
                    W()
                };
                g = W[2];
                v1 = W[1];
                for K, R in ipairs(Z(R)) do
                    W = K;
                    v5 = r67;
                    v4 = v5(R);
                    if v4 then
                        v7 = (R.GetAttribute(R, "RepairProgress") or 0) < 100;
                    end;
                    v5 = v5;
                    if v4 then
                        if not r43[R] then
                            r43[R] = r68(v5(R), "Generator", Color3.new(0, 1, 0.5), false);
                        else
                            r43[R].label.Text = "Gen " .. K .. " [" .. math.floor(R.GetAttribute(R, l[V]) or 0) .. "%]\n" .. math.floor((r30.Character.HumanoidRootPart.Position - v5(R).Position).Magnitude) .. "m";
                        end;
                    else
                        if r43[R] then
                            v7 = r43[R].box;
                            v7.Destroy(v7);
                            v7 = r43[R].gui;
                            v7.Destroy(v7);
                            r43[R] = nil;
                        end;
                    end; 
                end;
            end;
            return; 
        end);
        Uw = r69;
        dw = Uw.Tab(Uw, {
            ["Title"] = "Settings",
            ["Icon"] = "solar:settings-bold",
            ["IconColor"] = Color3.fromRGB(255, 170, 50),
            ["IconShape"] = "Square",
            ["Border"] = true
        });
        dw.Button(dw, {
            ["Title"] = "Destroy UI",
            ["Desc"] = "Destroy UI & Turn Off all Feature",
            ["Callback"] = function(...)
                v5 = r44;
                if v5 then
                    v5 = r44;
                    v5.Disconnect(v5);
                end;
                v5 = r45;
                if v5 then
                    v5 = r45;
                    v5.Disconnect(v5);
                end;
                v5 = r46;
                if v5 then
                    v5 = r46;
                    v5.Disconnect(v5);
                end;
                v5 = r58;
                if v5 then
                    v5 = r58;
                    v5.Destroy(v5);
                end;
                _G.NoSkill = false;
                r59 = false;
                r52 = false;
                v1 = r24;
                v1.Notify(v1, {
                    ["Title"] = "ANCH Hax",
                    ["Content"] = "UI destroyed. Thanks for using!"
                });
                task.wait(1);
                v1 = r69;
                v1.Destroy(v1);
                return; 
            end
        });
        r74 = hookmetamethod(game, "__namecall", newcclosure(function(arg1_20, ...)
            v1 = arg1_20;
            g = {
                e(2, Z(C))
            };
            W = {
                Z(g)
            };
            if getnamecallmethod() == "FireServer" and (v1.Name == "Fire" and (v1.Parent and v1.Parent.Parent)) then
                if v1.Parent.Parent.Name == "Items" and r52 then
                    v5 = r57;
                    R = v5();
                    if R then
                        v3 = R.Character;
                    end;
                    if R then
                        v5 = R.Character;
                        v4 = v5.FindFirstChild(v5, r54);
                        if v4 then
                            if typeof(v5[1]) == "Vector3" then
                                v5[1] = v4.Position;
                            end;
                            v3 = v5[2] and typeof(v5[2]) == "Instance";
                            if v3 then
                                v3 = v4;
                                v5[2] = v3;
                            end;
                            v5 = r24;
                            v5.Notify(v5, {
                                ["Title"] = "Silent Aim",
                                ["Content"] = "Redirected to " .. v5().Name
                            });
                            return r74(arg1_20, unpack(v5));
                        end;
                    end;
                end;
            end;
            return r74(v1, Z(g)); 
        end));
        task.wait(0.5);
        Uw = r69;
        Uw.SelectTab(Uw, 1);
        Uw = r24;
        Uw.Notify(Uw, {
            ["Title"] = "ANCH Hax",
            ["Content"] = "JOIN ANCH COMMUNITY DISCORD!"
        });
        return;
    end;
end;
return (function(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end)();
