--[[
    Script hasil reconstruct dari Dumped.json
    Game: Roblox (Dead by Daylight-like / "Violence District")
    UI Library: KezodX Linoria (Violence District v2.4.0)
    Discord: https://discord.gg/panduhub
    Total Proto Functions: 636
--]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============================================================
-- EXECUTOR FUNCTIONS
-- ============================================================
local getgenv = getgenv or (function() return _G end)
local getgc = getgc
local getinfo = getinfo
local getupvalues = getupvalues
local getrawmetatable = getrawmetatable
local setreadonly = setreadonly
local newcclosure = newcclosure
local firesignal = firesignal
local checkcaller = checkcaller
local getcallingscript = getcallingscript
local islclosure = islclosure
local setnamecallmethod = setnamecallmethod
local getnamecallmethod = getnamecallmethod
local setupvalue = setupvalue
local mouse2click = mouse2click
local mouse2press = mouse2press
local mouse2release = mouse2release
local setfpscap = setfpscap
local loadstring = loadstring

-- ============================================================
-- URLS & EXTERNAL RESOURCES
-- ============================================================
-- URL: "https://games.roblox.com/v1/games/"
-- URL: "https://pastebin.com/raw/JWr0bW8u"
-- URL: "https://pastefy.app/2MD1ZoBY/raw"
-- URL: "https://pastefy.app/5zsm8N7G/raw"
-- URL: "https://pastefy.app/cjJ9sNKl/raw"
-- URL: "https://pastefy.app/nJrAelfC/raw"
-- URL: "https://pastefy.app/tz2VGaIN/raw"
-- URL: "https://pastefy.app/wa3v2Vgm/raw"
-- URL: "https://raw.githubusercontent.com/GrexXMeng/Mengs/main/Invisibility"
-- URL: "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
-- URL: "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/Library.lua"
-- URL: "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/SaveManager.lua"
-- URL: "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/ThemeManager.lua"

-- ============================================================
-- ASSET IDs
-- ============================================================
-- Asset: "rbxassetid://"
-- Asset: "rbxassetid://106225491596534"
-- Asset: "rbxassetid://114593021219597"
-- Asset: "rbxassetid://115490787020749"
-- Asset: "rbxassetid://120101930689931"
-- Asset: "rbxassetid://121099446613414"
-- Asset: "rbxassetid://121773684313913"
-- Asset: "rbxassetid://123004139176580"
-- Asset: "rbxassetid://123552803041504"
-- Asset: "rbxassetid://129064643026442"
-- Asset: "rbxassetid://130415594909401"
-- Asset: "rbxassetid://13321848320"
-- Asset: "rbxassetid://135265751184744"
-- Asset: "rbxassetid://137195203725366"
-- Asset: "rbxassetid://137322894494527"
-- Asset: "rbxassetid://137859761110514"
-- Asset: "rbxassetid://140625405103474"
-- Asset: "rbxassetid://148840371"
-- Asset: "rbxassetid://189854234"
-- Asset: "rbxassetid://74216458932348"
-- Asset: "rbxassetid://74705617908505"
-- Asset: "rbxassetid://75586690784894"
-- Asset: "rbxassetid://80552139463944"
-- Asset: "rbxassetid://82600868380136"
-- Asset: "rbxassetid://83229063951016"
-- Asset: "rbxassetid://85355610204255"
-- Asset: "rbxassetid://87899327891544"
-- Asset: "rbxassetid://902843398"
-- Asset: "rbxassetid://902942096"
-- Asset: "rbxassetid://92960319113695"
-- Asset: "rbxassetid://94380161420025"
-- Asset: "rbxassetid://94749073728335"
-- Asset: "rbxassetid://96328361165090"

-- ============================================================
-- FORMAT STRINGS & PATTERNS
-- ============================================================
-- Format: "#%02X%02X%02X"
-- Format: "%d%%"
-- Format: "%d+"
-- Format: "%s+$"
-- Format: "<font color='#FFFFFF'>%s</font>"
-- Format: "<font color='#FFFFFF'>%s</font> <font color='%s'>%s</font>"
-- Format: "<font color='#FFFFFF'>%s</font> <font color='%s'>[%dm]</font>"
-- Format: "Atur akurasi prediksi (0% = tanpa prediksi, 100% = full prediksi)"
-- Format: "DONE 100%"
-- Format: "Hooked %d"
-- Format: "Pandu | %s fps | %s ms"
-- Format: "Players: %d/%d"
-- Format: "[^%.]+"
-- Format: "^%s+"
-- Format: "^(.+)%s+(%d+)$"
-- Format: "rbxthumb://type=Asset&id=%s&w=420&h=420"
-- Pattern: "%s+$"
-- Pattern: "[^%.]+"
-- Pattern: "^%s+"
-- Pattern: "^(.+)%s+(%d+)$"
-- Pattern: "^HookESP_"
-- Pattern: "^scp"

-- ============================================================
-- GLOBAL STATE VARIABLES
-- ============================================================
AIM_Auto = nil
AIM_TargetPart = nil
AbsolutePosition = nil
AbsoluteSize = nil
Aim_Silent = nil
Aim_SilentVeil = nil
Aim_SilentVeilV2 = nil
Ambient = nil
AntiAutoParryEnabled = nil
AntiBlind = nil
ApplyFullBright = nil
ApplyNoFog = nil
ApplyNoShadow = nil
Attach = nil
AttachParrySensor = nil
Attached = nil
AutoCurrentGenModel = nil
AutoCurrentPoint = nil
AutoPalletDistance = nil
AutoPalletEnabled = nil
AutoPalletSafety = nil
AutoParry = nil
AutoParryKey = nil
AutoRepairThread = nil
BypassButton = nil
BypassGateEnabled = nil
BypassGenEnabled = nil
BypassGenMode = nil
BypassLeap = nil
BypassUI = nil
CFrame = nil
CameraMaxZoomDistance = nil
CameraMode = nil
Character = nil
CharacterAdded = nil
ClearAllESP = nil
ClearESP = nil
ClearHookESP = nil
ClockTime = nil
Color = nil
Colors = nil
ConfigData = nil
Connection = nil
Cooldown = nil
CreateHookESP = nil
CreateKillerPerksGUI = nil
CreateModernESP = nil
CreateSpectatorUI = nil
Description = nil
DisableInfiniteLunge = nil
Distance = nil
DoMultiRepairPlain = nil
DropPallet = nil
ESP_Distance = nil
ESP_Gate = nil
ESP_Generator = nil
ESP_GeneratorName = nil
ESP_Hook = nil
ESP_ItemIcon = nil
ESP_Killer = nil
ESP_KillerWarn = nil
ESP_Master = nil
ESP_Name = nil
ESP_Outline = nil
ESP_Pallet = nil
ESP_Player = nil
ESP_SCP = nil
ESP_Window = nil
EmoteEnabled = nil
EnableInfiniteLunge = nil
EnableJitter = nil
EnableUnlimitedVault = nil
Enabled = nil
ExecuteParry = nil
FOVEnabled = nil
FPSCapSlider = nil
FPSCapToggle = nil
FieldOfView = nil
FindNearestPallet = nil
FireAbyssalSkill = nil
Flash_Silent = nil
Flash_YOffset = nil
FleeCooldown = nil
FleeDistance = nil
FleeKiller = nil
FleeKillerEnabled = nil
FlowState = nil
FogColor = nil
ForceRefreshMap = nil
From = nil
FullBright = nil
GateClientModule = nil
Gates = nil
Generators = nil
GetAllGenerators = nil
GetDistance = nil
GetGeneratorPoints = nil
GetKillerRoot = nil
GetKillerUI = nil
GetNearestKiller = nil
GetRole = nil
GetSCPs = nil
GetSuckedEnabled = nil
GetSuckedToggle = nil
GlobalShadows = nil
GodMode = nil
Gui = nil
GuiVisible = nil
Head = nil
Heartbeat = nil
HeartbeatConnection = nil
HitSoundCooldown = nil
HitSoundEnabled = nil
HitSoundId = nil
HitSoundLastTime = nil
HitSoundVolume = nil
Hooks = nil
Ignored_Skills_List = nil
Image = nil
InfFrenzy = nil
InfLakeMistJason = nil
InfPursuitJason = nil
InputBegan = nil
InputChanged = nil
Instance = nil
InstantTPGate = nil
Invis_Gacor = nil
IsActive = nil
IsDowned = nil
IsKiller = nil
IsSafeToDropPallet = nil
IsSafeToParry = nil
IsSurvivor = nil
KILLER_FlaskLaser = nil
KILLER_InfFrenzy = nil
KILLER_InfLakeMist = nil
KILLER_InfPursuit = nil
KILLER_SilentAimFlask = nil
KeyboardEnabled = nil
KillerPerksToggle = nil
Killer_3rdPerson = nil
Killer_Aimbot_Enabled = nil
Killer_Aimbot_MaxDist = nil
Killer_Aimbot_Smoothness = nil
Killer_Bypass = nil
Killer_BypassCarry = nil
Killer_InfAbyssal = nil
LastFireTime = nil
LeapBypass = nil
LerpSmoothness = nil
ListenToParryResult = nil
LocalTransparencyModifier = nil
LockAim = nil
MapPredictUI = nil
MaxJitterStuds = nil
MaxPlayers = nil
MinPlayers = nil
Misc_FakeName = nil
MoonwalkButton = nil
MoonwalkButtonVisible = nil
MoonwalkEnabled = nil
MoonwalkPCToggle = nil
MoonwalkUI = nil
MouseBehavior = nil
MouseButton1Click = nil
MouseButton1Down = nil
MouseButton1Up = nil
MouseIconEnabled = nil
NEX_StartCureFlaskLaser = nil
NEX_StartJasonLakeMistBypass = nil
NEX_StartJasonPursuitBypass = nil
NEX_StartJeffCooldownBypass = nil
NEX_StopJasonLakeMistBypass = nil
NEX_StopJasonPursuitBypass = nil
NEX_StopJeffCooldownBypass = nil
NEX_UpdateCureFlaskLaser = nil
Name = nil
NoFog = nil
NoShadow = nil
NoSlowdownEnabled = nil
OffsetX = nil
OffsetY = nil
OutdoorAmbient = nil
Pallets = nil
Parent = nil
Pistol_BlockKnocked = nil
PlayEmote = nil
PlayHitSound = nil
PlayRepairAnim = nil
PlayerGui = nil
Position = nil
PredictionEfficiency = nil
ProcessedGens = nil
ReapplyPerformance = nil
RecreateBypassButton = nil
RecreateMoonwalkButton = nil
Remotes = nil
RenderStepped = nil
RepairAnimTrack = nil
ResetAllTransparency = nil
ResetCharacterTransparency = nil
Results = nil
SCPs = nil
SPEAR_Gravity = nil
SPEAR_MaxDist = nil
SPEAR_Speed = nil
ScanMap = nil
SelectedAnim = nil
SelectedSound = nil
SelfHeal = nil
ServerHop = nil
SetCharacterTransparency = nil
SetMoonwalkButtonVisible = nil
SetWorldTransparency = nil
SetupHookDetection = nil
SharedTargetDropdown = nil
Size = nil
SkillCheck = nil
SkillCheckMode = nil
SkillHeartbeat = nil
SpearSmart_enable = nil
SpectatorGui = nil
SpectatorLabel = nil
SpeedAmount = nil
SpeedEnabled = nil
SpeedInputConnection = nil
SpeedInputEnabled = nil
SpeedInputValue = nil
Stalk = nil
StalkRange = nil
StartAutoPallet = nil
StartAutoRepairLoop = nil
StartInfiniteAbyssal = nil
StartNextKiller = nil
StartSpectatorInfo = nil
StartWatermark = nil
Stepped = nil
StopAutoPallet = nil
StopEmote = nil
StopInfiniteAbyssal = nil
StopNextKiller = nil
StopRepairAnim = nil
StopSpectatorInfo = nil
StopWatermark = nil
Style = nil
Surv_Aimbot_Enabled = nil
Surv_Aimbot_MaxDist = nil
Surv_Aimbot_Predict = nil
Surv_Aimbot_Radius = nil
Surv_Aimbot_ShowFOV = nil
Surv_Aimbot_Smoothness = nil
Surv_AutoCrouch = nil
Surv_AutoParry = nil
Surv_CrouchV = nil
Surv_InstanSkillCheck = nil
Surv_ParryAggressive = nil
Surv_ParryCircle = nil
Surv_ParryFace = nil
Surv_ParryRadius = nil
Surv_ParrySafety = nil
Surv_PerfectVault = nil
Surv_Perks = nil
SusR6Enabled = nil
SusR6Toggle = nil
TargetFOV = nil
Team = nil
TeleportToPart = nil
Text = nil
Texture = nil
Thickness = nil
Time = nil
TimeOfDayValue = nil
ToggleMoonwalk = nil
TouchEnabled = nil
Transparency = nil
Trigger = nil
TriggerCrouch = nil
TryAttach = nil
UpdateHookData = nil
UpdateHookESP = nil
UpdateMoonwalkStatus = nil
UpdateMoonwalkVisibility = nil
UpdatePlayerESP = nil
UpdatePlayerList = nil
UpdateSCPESP = nil
UpdateSpectatorCount = nil
UpdateStaticESP = nil
UserInputState = nil
Veil_FOV = nil
Veil_LeadMultiplier = nil
Veil_ShowFOV = nil
Velocity = nil
ViewportSize = nil
VisibilityConnection = nil
Visible = nil
WatermarkConnection = nil
WatermarkEnabled = nil
Windows = nil
bill = nil
buildMapGui = nil
cleanMapGui = nil
clearLaser = nil
createTargetSelectorUI = nil
currentSound = nil
currentTarget = nil
currentTrack = nil
destroyTargetSelectorUI = nil
detectMap = nil
disableSpoofer = nil
doShoot = nil
duration = nil
enableSpoofer = nil
extractAssetId = nil
fill = nil
gateIndex = nil
genIndex = nil
getBestAimbotTarget = nil
getClosestSurvivor = nil
getGunObject = nil
getItemIcon = nil
getKillerTargetForFlash = nil
getNearestGenPoint = nil
getTargetPartObject = nil
getTargetPosition = nil
hookIndex = nil
internal = nil
isGeneratorPromptVisible = nil
lastTime = nil
lockedAimbotTarget = nil
lockedTarget = nil
oldGateCanUse = nil
oldGateNew = nil
palletIndex = nil
pcall = nil
refreshPalletCache = nil
setBypassGate = nil
setupFlowstateCharacter = nil
setupMobileButton = nil
setupSpearInterceptor = nil
silentAimPredict = nil
startConnection = nil
startProcessedGensWatcher = nil
startSpeedInputMode = nil
startTime = nil
stateManager = nil
stopConnection = nil
stopSpeedInputMode = nil
suckedAnimTrack = nil
suckedAttachmentLoop = nil
susAnimTrack = nil
susCoroutine = nil
table = nil
tapMobileParryButton = nil
toggleMinimize = nil
updateButtons = nil
updateImage = nil
updateLaser = nil
waitForRepairing = nil
watchPallet = nil
windowIndex = nil

-- ============================================================
-- STRING CONSTANTS (all extracted from dump)
-- ============================================================
-- Roblox Property Names:
-- PROP: "AKTIF"
-- PROP: "Ability"
-- PROP: "Abysswalker"
-- PROP: "AccentColor"
-- PROP: "Action"
-- PROP: "ActionButton"
-- PROP: "Active"
-- PROP: "AddButton"
-- PROP: "AddCheckbox"
-- PROP: "AddColorPicker"
-- PROP: "AddDivider"
-- PROP: "AddDraggableLabel"
-- PROP: "AddDropdown"
-- PROP: "AddInput"
-- PROP: "AddKeyPicker"
-- PROP: "AddLabel"
-- PROP: "AddLeftGroupbox"
-- PROP: "AddRightGroupbox"
-- PROP: "AddSlider"
-- PROP: "AddTab"
-- PROP: "AddToggle"
-- PROP: "AdjustSpeed"
-- PROP: "AdjustWeight"
-- PROP: "Adornee"
-- PROP: "AimFlask"
-- PROP: "Aktif"
-- PROP: "AllowKiller"
-- PROP: "AlwaysOnTop"
-- PROP: "AncestryChanged"
-- PROP: "AnchorPoint"
-- PROP: "Anchored"
-- PROP: "Angles"
-- PROP: "Animation"
-- PROP: "AnimationId"
-- PROP: "AnimationPlayed"
-- PROP: "AnimationPriority"
-- PROP: "Animator"
-- PROP: "AntiAutoParry"
-- PROP: "AntiBlindToggle"
-- PROP: "AntiLooping"
-- PROP: "Applause"
-- PROP: "ApplyToTab"
-- PROP: "AssemblyLinearVelocity"
-- PROP: "Atmosphere"
-- PROP: "AutoButtonColor"
-- PROP: "AutoFireInterval"
-- PROP: "AutoPallet"
-- PROP: "AutoPalletDist"
-- PROP: "AutoPalletKey"
-- PROP: "AutoParryAdornment"
-- PROP: "AutoParryCircleESP"
-- PROP: "AutoParryCustomGui"
-- PROP: "AutoRepairEnabled"
-- PROP: "AutoRotate"
-- PROP: "AutoRunEnabled"
-- PROP: "AutoRunMobile"
-- PROP: "AutoRunMobileEnabled"
-- PROP: "AutoRunPC"
-- PROP: "AutoShow"
-- PROP: "AutoStalk"
-- PROP: "AutomaticSize"
-- PROP: "AwardLog"
-- PROP: "Backflip"
-- PROP: "BackgroundColor"
-- PROP: "BackgroundColor3"
-- PROP: "BackgroundTransparency"
-- PROP: "Badge"
-- PROP: "BasePart"
-- PROP: "BillboardGui"
-- PROP: "BindToClose"
-- PROP: "Bldg_Addon_RooftopUnit_A"
-- PROP: "BlockPalletEnabled"
-- PROP: "BlockPeluruToggle"
-- PROP: "Blocked"
-- PROP: "BorderSizePixel"
-- PROP: "Bottom"
-- PROP: "BoxHandleAdornment"
-- PROP: "Brightness"
-- PROP: "BuildConfigSection"
-- PROP: "BypassCarryCustomGui"
-- PROP: "BypassGate"
-- PROP: "BypassGen"
-- PROP: "BypassGenButton"
-- PROP: "BypassGenModeSelect"
-- PROP: "BypassGenUI"
-- PROP: "BypassLeapCooldown"
-- PROP: "Callback"
-- PROP: "CameraFOV"
-- PROP: "CameraMinZoomDistance"
-- PROP: "CanCollide"
-- PROP: "CanTouch"
-- PROP: "CanUse"
-- PROP: "CastShadow"
-- PROP: "Center"
-- PROP: "Changed"
-- PROP: "CharacterRemoving"
-- PROP: "Check"
-- PROP: "CheckInterractable"
-- PROP: "ChildAdded"
-- PROP: "ChildRemoved"
-- PROP: "Circle"
-- PROP: "ClassName"
-- PROP: "Classic"
-- PROP: "Close"
-- PROP: "CollectionService"
-- PROP: "Color3"
-- PROP: "Color_Gate"
-- PROP: "Color_Generator"
-- PROP: "Color_Hook"
-- PROP: "Color_Killer"
-- PROP: "Color_Pallet"
-- PROP: "Color_Player"
-- PROP: "Color_SCP"
-- PROP: "Color_Window"
-- PROP: "Connect"
-- PROP: "Connected"
-- PROP: "Controls"
-- PROP: "CoreGui"
-- PROP: "CornerRadius"
-- PROP: "CorpseCreated0492"
-- PROP: "Create"
-- PROP: "CreateWindow"
-- PROP: "Crosshair"
-- PROP: "CrosshairColor"
-- PROP: "CrosshairEnabled"
-- PROP: "CrosshairPosX"
-- PROP: "CrosshairPosY"
-- PROP: "CrosshairSize"
-- PROP: "CrosshairThickness"
-- PROP: "CrosshairUI"
-- PROP: "Crouching"
-- PROP: "Crouchingserver"
-- PROP: "CurrentCamera"
-- PROP: "CustomBypassCarryToggle"
-- PROP: "CustomInvisToggle"
-- PROP: "CustomParryToggle"
-- PROP: "CylinderHandleAdornment"
-- PROP: "DIMATIKAN"
-- PROP: "Deactivatefromclient"
-- PROP: "Decal"
-- PROP: "Default"
-- PROP: "Density"
-- PROP: "DescendantAdded"
-- PROP: "Destroy"
-- PROP: "DisableUnlimitedVault"
-- PROP: "Disabled"
-- PROP: "Disconnect"
-- PROP: "DisplayName"
-- PROP: "DisplayOrder"
-- PROP: "Drawing"
-- PROP: "Dumbster"
-- PROP: "EmoteSelect"
-- PROP: "EmperorGun"
-- PROP: "EnableCompacting"
-- PROP: "EnableSidebarResize"
-- PROP: "EndScreen"
-- PROP: "Enum"
-- PROP: "EquippedItem"
-- PROP: "Error"
-- PROP: "Exclude"
-- PROP: "ExitLever"
-- PROP: "Exploits"
-- PROP: "FOVCircleGui_Standalone"
-- PROP: "FOVValue"
-- PROP: "FPSCapKey"
-- PROP: "Failed"
-- PROP: "FakeNameKey"
-- PROP: "Fall"
-- PROP: "FillColor"
-- PROP: "FillDirection"
-- PROP: "FillTransparency"
-- PROP: "Filled"
-- PROP: "FilterDescendantsInstances"
-- PROP: "FilterType"
-- PROP: "FindFirstAncestorWhichIsA"
-- PROP: "FindFirstChild"
-- PROP: "FindFirstChildOfClass"
-- PROP: "FindFirstChildWhichIsA"
-- PROP: "Fire"
-- PROP: "FireServer"
-- PROP: "FlashAim"
-- PROP: "FlashAimOffset"
-- PROP: "Flashlight"
-- PROP: "FlaskSilentAimLaser"
-- PROP: "FlowStateKey"
-- PROP: "Flowstate"
-- PROP: "FogEnd"
-- PROP: "FogStart"
-- PROP: "Font"
-- PROP: "FontColor"
-- PROP: "Footer"
-- PROP: "ForceCheckbox"
-- PROP: "Frame"
-- PROP: "Frenzy"
-- PROP: "Func"
-- PROP: "GE_Text"
-- PROP: "Gate"
-- PROP: "GateClient"
-- PROP: "GateEH"
-- PROP: "Generator"
-- PROP: "GeneratorDone"
-- PROP: "GeneratorPoint"
-- PROP: "GeneratorRepair"
-- PROP: "GetAttribute"
-- PROP: "GetAttributeChangedSignal"
-- PROP: "GetAttributes"
-- PROP: "GetChildren"
-- PROP: "GetDescendants"
-- PROP: "GetGuiInset"
-- PROP: "GetInstanceAddedSignal"
-- PROP: "GetMouse"
-- PROP: "GetPlayers"
-- PROP: "GetPropertyChangedSignal"
-- PROP: "GetService"
-- PROP: "GetTagged"
-- PROP: "GetValue"
-- PROP: "Ghoul"
-- PROP: "Glare"
-- PROP: "Goal"
-- PROP: "GotBlinded"
-- PROP: "Gotham"
-- PROP: "GothamBlack"
-- PROP: "GothamBold"
-- PROP: "GothamMedium"
-- PROP: "GothamSemibold"
-- PROP: "Gravity"
-- PROP: "Griddy"
-- PROP: "GuiButton"
-- PROP: "GuiObject"
-- PROP: "GuiService"
-- PROP: "Haze"
-- PROP: "HealEvent"
-- PROP: "Healing"
-- PROP: "Health"
-- PROP: "Height"
-- PROP: "Highlight"
-- PROP: "HitSoundToggle"
-- PROP: "Holder"
-- PROP: "Hook"
-- PROP: "HookCount"
-- PROP: "HookEH"
-- PROP: "HookESP"
-- PROP: "HookESP_"
-- PROP: "HookPoint"
-- PROP: "HooksMeat"
-- PROP: "Horizontal"
-- PROP: "HorizontalAlignment"
-- PROP: "HttpGet"
-- PROP: "HttpService"
-- PROP: "Humanoid"
-- PROP: "HumanoidRootPart"
-- PROP: "Icon"
-- PROP: "IconSize"
-- PROP: "IgnoreGuiInset"
-- PROP: "IgnoreSkills"
-- PROP: "IgnoreThemeSettings"
-- PROP: "ImageButton"
-- PROP: "ImageColor3"
-- PROP: "ImageLabel"
-- PROP: "Immobile"
-- PROP: "InfFrenzyKey"
-- PROP: "InfLakeMistJasonKey"
-- PROP: "InfPursuitJasonKey"
-- PROP: "InfiniteLunge"
-- PROP: "InfiniteLungeKey"
-- PROP: "InfinityZoom"
-- PROP: "InnerRadius"
-- PROP: "InputEnded"
-- PROP: "Instant"
-- PROP: "InstantTPGateKey"
-- PROP: "InvisCustomGui"
-- PROP: "Invisibility"
-- PROP: "Invisible"
-- PROP: "InvokeServer"
-- PROP: "IsCarried"
-- PROP: "IsCarrying"
-- PROP: "IsHooked"
-- PROP: "IsLoaded"
-- PROP: "IsPlaying"
-- PROP: "IsRepairing"
-- PROP: "IsRunning"
-- PROP: "IsStunned"
-- PROP: "ItemESPs"
-- PROP: "Items"
-- PROP: "JSONDecode"
-- PROP: "Jason"
-- PROP: "JobId"
-- PROP: "KE_Text"
-- PROP: "KeyCode"
-- PROP: "Key_TPGen"
-- PROP: "Keybind"
-- PROP: "Keyboard"
-- PROP: "Killer"
-- PROP: "KillerChance"
-- PROP: "KillerPerks"
-- PROP: "KillerPerksText"
-- PROP: "KillerThirdPerson"
-- PROP: "KillerWarn"
-- PROP: "Killer_BypassKey"
-- PROP: "Killers"
-- PROP: "KingScourgeStart"
-- PROP: "Knocked"
-- PROP: "KorlessHead"
-- PROP: "Kyoufuu"
-- PROP: "LakeMist"
-- PROP: "LargeBoulder01"
-- PROP: "Laser"
-- PROP: "LaserToggle"
-- PROP: "LastCrosshairStyle"
-- PROP: "LayoutOrder"
-- PROP: "Left"
-- PROP: "LeftControl"
-- PROP: "LeftGate"
-- PROP: "LeftHand"
-- PROP: "LeftLowerArm"
-- PROP: "LeftShift"
-- PROP: "LeftUpperArm"
-- PROP: "Legit"
-- PROP: "Lerp"
-- PROP: "Level"
-- PROP: "Library"
-- PROP: "Lighting"
-- PROP: "Line"
-- PROP: "LoadAnimation"
-- PROP: "LoadAutoloadConfig"
-- PROP: "Loaded"
-- PROP: "LocalPlayer"
-- PROP: "LocalScript"
-- PROP: "LockCenter"
-- PROP: "LockFirstPerson"
-- PROP: "LookVector"
-- PROP: "Looped"
-- PROP: "MOON"
-- PROP: "Magnitude"
-- PROP: "Main"
-- PROP: "MainBox"
-- PROP: "MainColor"
-- PROP: "MainFrame"
-- PROP: "MapName"
-- PROP: "MapPredictEnabled"
-- PROP: "MapStatus"
-- PROP: "MarketplaceService"
-- PROP: "Material"
-- PROP: "MaxHealth"
-- PROP: "MaxPlayersInput"
-- PROP: "Mechanics"
-- PROP: "MengHub"
-- PROP: "MenuKeybind"
-- PROP: "MeshId"
-- PROP: "MeshPart"
-- PROP: "MinPlayersInput"
-- PROP: "Minimize"
-- PROP: "Mode"
-- PROP: "Model"
-- PROP: "Modules"
-- PROP: "Moonwalk"
-- PROP: "MoonwalkLabel"
-- PROP: "MoonwalkPCKey"
-- PROP: "MoonwalkToggle"
-- PROP: "MouseButton1"
-- PROP: "MouseButton2"
-- PROP: "MouseButton2Click"
-- PROP: "MouseMovement"
-- PROP: "Move"
-- PROP: "MoveDirection"
-- PROP: "Multi"
-- PROP: "NEX_CureFlaskLaserPart"
-- PROP: "NEX_CureFlaskLaserThread"
-- PROP: "NEX_JeffCooldownBypassThread"
-- PROP: "NEX_KillerPerksGui"
-- PROP: "NONAKTIF"
-- PROP: "Neon"
-- PROP: "Network"
-- PROP: "NextKillerDisplay"
-- PROP: "NextKillerIndicator"
-- PROP: "NextKillerToggle"
-- PROP: "NextMapToggle"
-- PROP: "NoFall"
-- PROP: "NoSlowdown"
-- PROP: "NoSlowdownKey"
-- PROP: "NoUI"
-- PROP: "Nonaktif"
-- PROP: "None"
-- PROP: "Normal"
-- PROP: "Notify"
-- PROP: "NotifySide"
-- PROP: "NumberSequence"
-- PROP: "NumberSequenceKeypoint"
-- PROP: "Numeric"
-- PROP: "Offset"
-- PROP: "OnClick"
-- PROP: "OnClientEvent"
-- PROP: "OnTeleport"
-- PROP: "OnePlays"
-- PROP: "Options"
-- PROP: "OriginalImage"
-- PROP: "OriginalText"
-- PROP: "OutlineColor"
-- PROP: "OutlineTransparency"
-- PROP: "PANDU"
-- PROP: "PAimVeil"
-- PROP: "PE_Text"
-- PROP: "Padding"
-- PROP: "PaddingLeft"
-- PROP: "PaddingRight"
-- PROP: "Pallet"
-- PROP: "PalletDropEvent"
-- PROP: "PalletEH"
-- PROP: "PalletPoint"
-- PROP: "PalletPointSlide"
-- PROP: "PalletPointSlideInUse"
-- PROP: "PalletSlideCompleteEvent"
-- PROP: "PalletSlideEvent"
-- PROP: "Pandu"
-- PROP: "Panel"
-- PROP: "ParryAggressive"
-- PROP: "ParryCircle"
-- PROP: "ParryCooldown"
-- PROP: "ParryCooldownThread"
-- PROP: "ParryCooldownTime"
-- PROP: "ParryFace"
-- PROP: "ParryRadius"
-- PROP: "Part"
-- PROP: "Part0"
-- PROP: "Part1"
-- PROP: "PerfectVaultKey"
-- PROP: "Pistol_FOV"
-- PROP: "Pistol_FOVMode"
-- PROP: "Pistol_ShowFOV"
-- PROP: "Pistol_Target"
-- PROP: "PlaceId"
-- PROP: "Placeholder"
-- PROP: "Play"
-- PROP: "PlayOnRemove"
-- PROP: "Player"
-- PROP: "PlayerAdded"
-- PROP: "PlayerDropdown"
-- PROP: "Players"
-- PROP: "Plus"
-- PROP: "PowerDoneDeactivating"
-- PROP: "Predict"
-- PROP: "PredictEfficiency"
-- PROP: "PredictJitter"
-- PROP: "PredictJitterAmount"
-- PROP: "PredictLerp"
-- PROP: "Premium"
-- PROP: "PrimaryPart"
-- PROP: "PrimaryPartPallet"
-- PROP: "Priority"
-- PROP: "ProgressRepair"
-- PROP: "Pursuit"
-- PROP: "Radius"
-- PROP: "Random"
-- PROP: "RandomMode_IsNormal"
-- PROP: "Raycast"
-- PROP: "RaycastFilterType"
-- PROP: "RaycastParams"
-- PROP: "RemoteEvent"
-- PROP: "RemoveTag"
-- PROP: "RepairEvent"
-- PROP: "RepairProgress"
-- PROP: "ReplicatedStorage"
-- PROP: "ResetOnSpawn"
-- PROP: "RichText"
-- PROP: "Right"
-- PROP: "RightAlt"
-- PROP: "RightGate"
-- PROP: "RightHand"
-- PROP: "RightLowerArm"
-- PROP: "RightShift"
-- PROP: "RightUpperArm"
-- PROP: "RightVector"
-- PROP: "Rooftop"
-- PROP: "Root"
-- PROP: "Rotation"
-- PROP: "Rounding"
-- PROP: "RunService"
-- PROP: "SCPEH"
-- PROP: "Scale"
-- PROP: "Scheme"
-- PROP: "ScreenGui"
-- PROP: "SelectedKiller"
-- PROP: "SelfHealKey"
-- PROP: "SendKeyEvent"
-- PROP: "SendMouseButtonEvent"
-- PROP: "SendTouchEvent"
-- PROP: "ServerStatsItem"
-- PROP: "SetAttribute"
-- PROP: "SetFolder"
-- PROP: "SetIgnoreIndexes"
-- PROP: "SetLibrary"
-- PROP: "SetText"
-- PROP: "SetValue"
-- PROP: "SetValues"
-- PROP: "SetVisible"
-- PROP: "Setup"
-- PROP: "SetupNextKillerIndicator"
-- PROP: "SetupPlayer"
-- PROP: "Show"
-- PROP: "ShowStun"
-- PROP: "ShowToggleFrameInKeybinds"
-- PROP: "Sibling"
-- PROP: "SidebarCompacted"
-- PROP: "SilentAim"
-- PROP: "SilentAimVeil"
-- PROP: "SilentAimVeilKey"
-- PROP: "SilentAimVeilV2"
-- PROP: "Skill"
-- PROP: "SkillCheckKey"
-- PROP: "SkillCheckModeDropdown"
-- PROP: "SkillCheckPromptGui"
-- PROP: "SkillCheckResultEvent"
-- PROP: "SkillFrequency"
-- PROP: "SkillSpeed"
-- PROP: "SortOrder"
-- PROP: "Sound"
-- PROP: "SoundId"
-- PROP: "Space"
-- PROP: "Spearthrow"
-- PROP: "Spectator"
-- PROP: "SpectatorCounter"
-- PROP: "SpectatorToggle"
-- PROP: "Speed"
-- PROP: "SpeedBoost"
-- PROP: "SpeedInputMode"
-- PROP: "SpooferConns"
-- PROP: "Sprinting"
-- PROP: "Stalker"
-- PROP: "StartStalking"
-- PROP: "Stats"
-- PROP: "Stop"
-- PROP: "StopAutoRepair"
-- PROP: "StudsOffset"
-- PROP: "StudsOffsetWorldSpace"
-- PROP: "StunUI"
-- PROP: "Surv_PerksKey"
-- PROP: "Surv_SkillFrequency"
-- PROP: "Surv_SkillSpeed"
-- PROP: "Surv_VaultSlider"
-- PROP: "Surv_VaultSpeed"
-- PROP: "Survivor"
-- PROP: "SurvivorAnimationsController"
-- PROP: "Survivors"
-- PROP: "SyncToggleState"
-- PROP: "Target"
-- PROP: "Teleport"
-- PROP: "TeleportService"
-- PROP: "TeleportState"
-- PROP: "TeleportToGenerator"
-- PROP: "TeleportToPlaceInstance"
-- PROP: "TextBox"
-- PROP: "TextButton"
-- PROP: "TextColor3"
-- PROP: "TextLabel"
-- PROP: "TextScaled"
-- PROP: "TextSize"
-- PROP: "TextStrokeTransparency"
-- PROP: "TextWrapped"
-- PROP: "TextXAlignment"
-- PROP: "TextYAlignment"
-- PROP: "TextureID"
-- PROP: "ThirdPersonConn"
-- PROP: "ThrowFlask"
-- PROP: "TimeLength"
-- PROP: "TimeOfDay"
-- PROP: "Title"
-- PROP: "ToFLaser"
-- PROP: "ToFTargetSelector"
-- PROP: "Toggle"
-- PROP: "ToggleKeybind"
-- PROP: "Toggles"
-- PROP: "Tooltip"
-- PROP: "Torso"
-- PROP: "Touch"
-- PROP: "TweenInfo"
-- PROP: "TweenService"
-- PROP: "UDim"
-- PROP: "UDim2"
-- PROP: "UICorner"
-- PROP: "UIGradient"
-- PROP: "UIListLayout"
-- PROP: "UIPadding"
-- PROP: "UIStroke"
-- PROP: "Unit"
-- PROP: "Unknown"
-- PROP: "UnlimitedVault"
-- PROP: "UnlimitedVaultConn"
-- PROP: "UnlimitedVaultKey"
-- PROP: "Unload"
-- PROP: "UpperTorso"
-- PROP: "UserId"
-- PROP: "UserInputService"
-- PROP: "UserInputType"
-- PROP: "VD_VeilTarget"
-- PROP: "Value"
-- PROP: "Values"
-- PROP: "VaultCompleteEvent"
-- PROP: "VaultEvent"
-- PROP: "VaultPointInUse"
-- PROP: "VaultTrigger"
-- PROP: "Vector2"
-- PROP: "Vector3"
-- PROP: "Veil"
-- PROP: "VeilFOV"
-- PROP: "VeilShowFOV"
-- PROP: "VeilTracker"
-- PROP: "Veil_SpearGravity"
-- PROP: "Veil_SpearSpeed"
-- PROP: "VerticalAlignment"
-- PROP: "VirtualInputManager"
-- PROP: "Visibility"
-- PROP: "Volume"
-- PROP: "Vulnerable"
-- PROP: "Wait"
-- PROP: "WaitForChild"
-- PROP: "WalkSpeed"
-- PROP: "WallCheckToggle"
-- PROP: "Wallcheck"
-- PROP: "WarCry"
-- PROP: "WarnText"
-- PROP: "Watermark"
-- PROP: "WatermarkToggle"
-- PROP: "WeldConstraint"
-- PROP: "Window"
-- PROP: "WindowEH"
-- PROP: "Workspace"
-- PROP: "WorldToViewportPoint"
-- PROP: "ZIndex"
-- PROP: "ZIndexBehavior"
-- PROP: "Zombie"

-- Lua/Executor Functions:
-- FUNC: "abs"
-- FUNC: "abyss"
-- FUNC: "action"
-- FUNC: "activeColor"
-- FUNC: "activeTxt"
-- FUNC: "applySpooferToObj"
-- FUNC: "attack"
-- FUNC: "autoReconnect"
-- FUNC: "boolean"
-- FUNC: "busy"
-- FUNC: "busyTime"
-- FUNC: "camera"
-- FUNC: "cancel"
-- FUNC: "characterspeed"
-- FUNC: "check"
-- FUNC: "checkcaller"
-- FUNC: "clamp"
-- FUNC: "clear"
-- FUNC: "clock"
-- FUNC: "color"
-- FUNC: "concat"
-- FUNC: "coroutine"
-- FUNC: "corrupt"
-- FUNC: "created"
-- FUNC: "crosshair"
-- FUNC: "currentCooldown"
-- FUNC: "data"
-- FUNC: "debug"
-- FUNC: "defer"
-- FUNC: "delay"
-- FUNC: "disable"
-- FUNC: "disabled"
-- FUNC: "display"
-- FUNC: "distance"
-- FUNC: "enable"
-- FUNC: "enabled"
-- FUNC: "endscreen"
-- FUNC: "executeSilentAimFire"
-- FUNC: "eye"
-- FUNC: "face"
-- FUNC: "find"
-- FUNC: "fininshline"
-- FUNC: "fireServer"
-- FUNC: "firesignal"
-- FUNC: "floor"
-- FUNC: "fly"
-- FUNC: "format"
-- FUNC: "fromOffset"
-- FUNC: "fromRGB"
-- FUNC: "fromScale"
-- FUNC: "function"
-- FUNC: "game"
-- FUNC: "gate"
-- FUNC: "gateDuration"
-- FUNC: "gateRemote"
-- FUNC: "gatherGates"
-- FUNC: "generator"
-- FUNC: "getPistolTarget"
-- FUNC: "getcallingscript"
-- FUNC: "getgc"
-- FUNC: "getgenv"
-- FUNC: "getinfo"
-- FUNC: "getnamecallmethod"
-- FUNC: "getrawmetatable"
-- FUNC: "getupvalues"
-- FUNC: "gmatch"
-- FUNC: "gsub"
-- FUNC: "gun"
-- FUNC: "head"
-- FUNC: "hook"
-- FUNC: "house"
-- FUNC: "huge"
-- FUNC: "humanoid"
-- FUNC: "humanoidrootpart"
-- FUNC: "icon"
-- FUNC: "info"
-- FUNC: "insert"
-- FUNC: "ipairs"
-- FUNC: "isAimbotHolding"
-- FUNC: "isAimingFlash"
-- FUNC: "isBuffering"
-- FUNC: "isCarrying"
-- FUNC: "isChargingPistol"
-- FUNC: "isHealing"
-- FUNC: "isRepairing"
-- FUNC: "isSilenced"
-- FUNC: "isSliding"
-- FUNC: "isTargetVisible"
-- FUNC: "isUnhooking"
-- FUNC: "isVaulting"
-- FUNC: "isWeapon"
-- FUNC: "islclosure"
-- FUNC: "keyboard"
-- FUNC: "kickcount"
-- FUNC: "killer"
-- FUNC: "kingscourge"
-- FUNC: "lastUse"
-- FUNC: "loadstring"
-- FUNC: "lookAt"
-- FUNC: "lower"
-- FUNC: "lungeboost"
-- FUNC: "map"
-- FUNC: "match"
-- FUNC: "math"
-- FUNC: "max"
-- FUNC: "maxPlayers"
-- FUNC: "min"
-- FUNC: "model"
-- FUNC: "mouse2click"
-- FUNC: "mouse2press"
-- FUNC: "mouse2release"
-- FUNC: "move2"
-- FUNC: "name"
-- FUNC: "new"
-- FUNC: "newcclosure"
-- FUNC: "next"
-- FUNC: "nextPageCursor"
-- FUNC: "notif"
-- FUNC: "offsetY"
-- FUNC: "pairs"
-- FUNC: "parry"
-- FUNC: "parryResult"
-- FUNC: "part"
-- FUNC: "pcprompts"
-- FUNC: "phone"
-- FUNC: "playM2Animation"
-- FUNC: "playing"
-- FUNC: "pos"
-- FUNC: "print"
-- FUNC: "rad"
-- FUNC: "random"
-- FUNC: "rawget"
-- FUNC: "rawset"
-- FUNC: "require"
-- FUNC: "server"
-- FUNC: "setMoonwalk"
-- FUNC: "setfpscap"
-- FUNC: "setnamecallmethod"
-- FUNC: "setreadonly"
-- FUNC: "settings"
-- FUNC: "setupvalue"
-- FUNC: "sin"
-- FUNC: "skull"
-- FUNC: "smile"
-- FUNC: "sort"
-- FUNC: "spawn"
-- FUNC: "spearmode"
-- FUNC: "special"
-- FUNC: "spectatorEnabled"
-- FUNC: "speedboost"
-- FUNC: "sprint"
-- FUNC: "sqrt"
-- FUNC: "string"
-- FUNC: "sub"
-- FUNC: "subtext"
-- FUNC: "sun"
-- FUNC: "swords"
-- FUNC: "target"
-- FUNC: "task"
-- FUNC: "tick"
-- FUNC: "time"
-- FUNC: "timer"
-- FUNC: "tonumber"
-- FUNC: "torso"
-- FUNC: "tostring"
-- FUNC: "tryActivate"
-- FUNC: "type"
-- FUNC: "typeof"
-- FUNC: "unpack"
-- FUNC: "updateText"
-- FUNC: "user"
-- FUNC: "users"
-- FUNC: "vaultspeed"
-- FUNC: "vel"
-- FUNC: "vfx"
-- FUNC: "wait"
-- FUNC: "warn"
-- FUNC: "window"
-- FUNC: "workspace"
-- FUNC: "wrap"
-- FUNC: "zero"

-- UI Labels (Indonesian):
-- LABEL: " FPS"
-- LABEL: " lvl "
-- LABEL: " player)"
-- LABEL: " studs"
-- LABEL: "24 Hour Cinderella"
-- LABEL: "AKTIF - Laser merah"
-- LABEL: "AKTIF - Peluru TIDAK akan keluar"
-- LABEL: "AKTIF - Sound akan diputar saat stun"
-- LABEL: "AKTIF - WalkSpeed dikunci"
-- LABEL: "Abaikan skill tertentu"
-- LABEL: "Abyssal Basic"
-- LABEL: "Abyssal S1"
-- LABEL: "Abyssal lunge"
-- LABEL: "Aggressive Mode"
-- LABEL: "Aim Lock"
-- LABEL: "Aim Lock Hidden"
-- LABEL: "Aim Lock Toggle"
-- LABEL: "Aim Lock berhasil dimuat!"
-- LABEL: "Aimbot Smoothness"
-- LABEL: "Aimbot Survivor"
-- LABEL: "Akses Ditolak"
-- LABEL: "Aktif - Immune dari flashlight"
-- LABEL: "Aktifkan Emote"
-- LABEL: "Aktifkan pembatas FPS"
-- LABEL: "Aktifkan speed boost dengan kecepatan di atas"
-- LABEL: "Anti Auto Parry"
-- LABEL: "Anti Blind"
-- LABEL: "Anti Blind (Flashlight)"
-- LABEL: "Anti Knockdown"
-- LABEL: "Anti Looping"
-- LABEL: "Anti Slow Vault"
-- LABEL: "Apply Korless"
-- LABEL: "Arm Swing"
-- LABEL: "Atur akurasi prediksi (0% = tanpa prediksi, 100% = full prediksi)"
-- LABEL: "Atur frekuensi munculnya skill check"
-- LABEL: "Atur jarak pandang kamera"
-- LABEL: "Atur kecepatan putaran skill check (1-30, 10 = Normal)"
-- LABEL: "Atur kelancaran tracking target (10 = cepat, 100 = lambat)"
-- LABEL: "Atur posisi bidikan (0 = Badan, 1.5 = Kepala, 8 = Atas Kepala)"
-- LABEL: "Atur waktu di game"
-- LABEL: "Auto Crouch (Dodge S1)"
-- LABEL: "Auto Dodge Veil"
-- LABEL: "Auto Dodge Veil: "
-- LABEL: "Auto Drop Pallet"
-- LABEL: "Auto Pallet"
-- LABEL: "Auto Pallet Key"
-- LABEL: "Auto Parry"
-- LABEL: "Auto Parry GUI"
-- LABEL: "Auto Parry Key"
-- LABEL: "Auto Predict"
-- LABEL: "Auto Repair"
-- LABEL: "Auto Run Mobile"
-- LABEL: "Auto Run [Mobile]"
-- LABEL: "Auto Run [PC]"
-- LABEL: "Auto Skill Check"
-- LABEL: "Auto Stalk"
-- LABEL: "BLOODBATH! Club"
-- LABEL: "BYPASS [OFF]"
-- LABEL: "BYPASS [ON]"
-- LABEL: "Berhasil Dimuat!"
-- LABEL: "Besar efek acak (0 = mati, 5 = maksimal)"
-- LABEL: "Bikin map jadi terang biar lebih jelas"
-- LABEL: "Block Aim (TOF)"
-- LABEL: "Block Peluru"
-- LABEL: "Block Vault & Pallets"
-- LABEL: "Block aim Knocked"
-- LABEL: "Button disembunyikan"
-- LABEL: "Button muncul! Tekan untuk aktif"
-- LABEL: "Bypass Carry"
-- LABEL: "Bypass Carry GUI"
-- LABEL: "Bypass Carry Key"
-- LABEL: "Bypass Carry skill unlock"
-- LABEL: "Bypass Exite Gate"
-- LABEL: "CARRY [OFF]"
-- LABEL: "California Girls"
-- LABEL: "Camera FOV"
-- LABEL: "Camera Setting"
-- LABEL: "Camera Settings"
-- LABEL: "Cegah drop pallet saat down/carry/hook (biar aman)"
-- LABEL: "Christmas Spirit"
-- LABEL: "Counter Auto Parry"
-- LABEL: "Crosshair Color"
-- LABEL: "DONE 100%"
-- LABEL: "Daftar player di-refresh!"
-- LABEL: "Data Ping"
-- LABEL: "Di Ew Player"
-- LABEL: "Display dimatikan"
-- LABEL: "Distory Gui"
-- LABEL: "Drop All Pallet"
-- LABEL: "ESP Maps"
-- LABEL: "ESP Players"
-- LABEL: "ESP Range Circle"
-- LABEL: "ESP Tracker Target"
-- LABEL: "Efficiency: "
-- LABEL: "Enable Aimbot"
-- LABEL: "Enable Crosshair"
-- LABEL: "Enable Esp"
-- LABEL: "Enable FPS + Ping Display"
-- LABEL: "Enable FPS Cap"
-- LABEL: "Enable Hit Sound Effect"
-- LABEL: "Enable Jitter"
-- LABEL: "Enable Laser"
-- LABEL: "Enable Laser Effect"
-- LABEL: "Enable Spectator Counter"
-- LABEL: "Enable Speed Boost"
-- LABEL: "Enable Speed Boost (Input Mode)"
-- LABEL: "Esp Distance"
-- LABEL: "Esp Item Icon"
-- LABEL: "Esp Name"
-- LABEL: "Ew Player"
-- LABEL: "Exit Gate"
-- LABEL: "FOV Circle Radius"
-- LABEL: "FOV Value"
-- LABEL: "FPS Cap"
-- LABEL: "FPS Limit"
-- LABEL: "Face Sensitivity"
-- LABEL: "Fake Generator"
-- LABEL: "Fake Generator GUI"
-- LABEL: "Fake Parry"
-- LABEL: "Fake Parry GUI"
-- LABEL: "Fast vault"
-- LABEL: "Firelink Shrine"
-- LABEL: "Fitur ini khusus Killer!"
-- LABEL: "Flash Head Offset (Y)"
-- LABEL: "Flask Laser"
-- LABEL: "Flee Distance"
-- LABEL: "Flee Killer"
-- LABEL: "Floating Rest"
-- LABEL: "Flowstate No CD"
-- LABEL: "Fly GUI"
-- LABEL: "Fly GUI Dimuat"
-- LABEL: "Fly GUI terbuka"
-- LABEL: "Frenzy tanpa cooldown / unlimited"
-- LABEL: "Friday Night"
-- LABEL: "Full Bright"
-- LABEL: "Full Bright aktif!"
-- LABEL: "Full Bright dimatikan"
-- LABEL: "Function tidak ditemukan."
-- LABEL: "GUI Fake Generator berhasil dimuat!"
-- LABEL: "GUI Fake Parry berhasil dimuat!"
-- LABEL: "GUI Mask Selector berhasil dimuat!"
-- LABEL: "GUI Moonwalk berhasil dimuat!"
-- LABEL: "Ga bisa mati (semi god)"
-- LABEL: "Ga deket generator manapun!"
-- LABEL: "Gagal load Invisibility:"
-- LABEL: "Gagal load script!"
-- LABEL: "Gagal load. Coba lagi."
-- LABEL: "Gagal memuat Aim Lock!"
-- LABEL: "Gagal memuat Fake Generator!"
-- LABEL: "Gagal memuat Fake Parry GUI!"
-- LABEL: "Gagal memuat Mask Selector!"
-- LABEL: "Gagal memuat Moonwalk!"
-- LABEL: "Gagal memuat Tools Jerk"
-- LABEL: "Gate Color"
-- LABEL: "Gate bypass aktif!"
-- LABEL: "Gate bypass dimatikan!"
-- LABEL: "Gen Boost (Multi-Repair)"
-- LABEL: "Gen Name & Progress"
-- LABEL: "Generator "
-- LABEL: "Generator Color"
-- LABEL: "Generator tidak ditemukan!"
-- LABEL: "Get Sucked"
-- LABEL: "Gui Destroyed"
-- LABEL: "Gui Loaded"
-- LABEL: "Hapus kabut biar map lebih jelas"
-- LABEL: "Hidden Basic"
-- LABEL: "Hidden S1"
-- LABEL: "Hidden lunge"
-- LABEL: "Hide Name"
-- LABEL: "Hide Name Key"
-- LABEL: "Hilangkan slowdown saat menyerang (Killer Only)"
-- LABEL: "Hit Sound"
-- LABEL: "Hook Color"
-- LABEL: "Hook ESP"
-- LABEL: "Hooked %d"
-- LABEL: "Hop Server"
-- LABEL: "INVIS [OFF]"
-- LABEL: "INVIS [ON]"
-- LABEL: "Infinite Frenzy"
-- LABEL: "Infinite Frenzy (Jeff)"
-- LABEL: "Infinite Frenzy Key"
-- LABEL: "Infinite Lake Mist"
-- LABEL: "Infinite Lake Mist (Jason)"
-- LABEL: "Infinite Lake Mist Key"
-- LABEL: "Infinite Lunge"
-- LABEL: "Infinite Lunge Key"
-- LABEL: "Infinite Pursuit"
-- LABEL: "Infinite Pursuit (Jason)"
-- LABEL: "Infinite Pursuit Key"
-- LABEL: "Infinite corrupt Abyssal"
-- LABEL: "Infinity Zoom Out"
-- LABEL: "Info Player"
-- LABEL: "Instant TP Gate"
-- LABEL: "Instant TP Gate Key"
-- LABEL: "Invis GUI"
-- LABEL: "Invisibility GUI"
-- LABEL: "Invisibility [OP]"
-- LABEL: "Invisibility loaded"
-- LABEL: "Jarak maksimal parry bereaksi"
-- LABEL: "Jarak trigger teleport"
-- LABEL: "Jason Basic"
-- LABEL: "Jason lunge"
-- LABEL: "Jeff Basic"
-- LABEL: "Jeff Frenzy"
-- LABEL: "Jeff lunge"
-- LABEL: "Jitter Amount"
-- LABEL: "Jitter Amount: "
-- LABEL: "Jitter: "
-- LABEL: "Kabut berhasil dihilangkan!"
-- LABEL: "Kamu harus Survivor!"
-- LABEL: "Kecepatan diubah ke "
-- LABEL: "Keybind FPS Cap"
-- LABEL: "Keybind Flowstate No CD"
-- LABEL: "Keybind Moonwalk"
-- LABEL: "Keybind Open/Close UI"
-- LABEL: "Keybind Self Heal"
-- LABEL: "Keybind TP Gen"
-- LABEL: "Keybind Unlimited Vault"
-- LABEL: "Killer (K)"
-- LABEL: "Killer Color"
-- LABEL: "Killer Perks Display"
-- LABEL: "Killer Perks Info"
-- LABEL: "Killer Perks [<font color=\"rgb(255,80,80)\">"
-- LABEL: "Killer Stun Indicator"
-- LABEL: "Killer Warn"
-- LABEL: "Korless Morph Applied"
-- LABEL: "Lake Mist tanpa cooldown / unlimited"
-- LABEL: "Langsung parry tanpa peduli face direction"
-- LABEL: "Lead Multiplier"
-- LABEL: "Left Arm"
-- LABEL: "List player direfresh! ("
-- LABEL: "Lock Aim (Twist Of fate)"
-- LABEL: "Lock aim untuk item Pistol"
-- LABEL: "Lunge tanpa batas (Killer Only)"
-- LABEL: "Manual Repair"
-- LABEL: "Map not found"
-- LABEL: "Map: "
-- LABEL: "Map: Unknown"
-- LABEL: "Map: —"
-- LABEL: "Masih loading..."
-- LABEL: "Mask Selector"
-- LABEL: "Masked Alex"
-- LABEL: "Masked Basic"
-- LABEL: "Masked Cobra"
-- LABEL: "Masked Cobra lunge"
-- LABEL: "Masked Tony"
-- LABEL: "Masked lunge"
-- LABEL: "Masukkan angka kecepatan (contoh: 1.5, 2, 3)"
-- LABEL: "Matikan shadow"
-- LABEL: "Max Distance"
-- LABEL: "Max Players"
-- LABEL: "Mayers Basic"
-- LABEL: "Mayers lunge"
-- LABEL: "Melee Lock Distance"
-- LABEL: "Memainkan animasi random buat ngelabui auto parry"
-- LABEL: "Memperbaiki generator dengan cepat tanpa terdeteksi"
-- LABEL: "Memutar suara 'Ahhh' saat berhasil stun killer"
-- LABEL: "Menampilkan jumlah player yang sedang jadi Spectator"
-- LABEL: "Menampilkan perk killer yang sedang digunakan"
-- LABEL: "Menampilkan prediksi killer selanjutnya di layar"
-- LABEL: "Menampilkan prediksi map selanjutnya di detik 00.15"
-- LABEL: "Mencegah killer terkena blind dari senter survivor"
-- LABEL: "Mencegah perlambatan saat vault (perfect vault)"
-- LABEL: "Mengubah posisi kamera ke belakang karakter"
-- LABEL: "Menu bind"
-- LABEL: "Menu keybind"
-- LABEL: "Mercy Hospital Rooftop"
-- LABEL: "Min Players"
-- LABEL: "Mobile Friendly"
-- LABEL: "Mode Outline (Fill transparan)"
-- LABEL: "Moonwalk PC"
-- LABEL: "Moonwalk [PC]"
-- LABEL: "Moonwalk v old"
-- LABEL: "Mount Massive Asylum"
-- LABEL: "Muncul saat tombol flask di-hold"
-- LABEL: "Next Killer Display"
-- LABEL: "Next Killer: "
-- LABEL: "Next Killer: <font color='#888888'>Waiting...</font>"
-- LABEL: "Next Map Prediction"
-- LABEL: "No Fall Damage"
-- LABEL: "No Fog"
-- LABEL: "No Fog dimatikan"
-- LABEL: "No Server"
-- LABEL: "No Shadow"
-- LABEL: "No Slowdown"
-- LABEL: "No Slowdown Keybind"
-- LABEL: "No Slowdown killer"
-- LABEL: "Nonaktif - Peluru normal kembali"
-- LABEL: "Not Ready Yet!"
-- LABEL: "ON (No Double)"
-- LABEL: "Open Mask Selector GUI"
-- LABEL: "Otomatis jongkok saat Abyssal menggunakan S1"
-- LABEL: "PARRY [OFF]"
-- LABEL: "PARRY [ON]"
-- LABEL: "Pallet Color"
-- LABEL: "Pandu Hub"
-- LABEL: "Pandu | %s fps | %s ms"
-- LABEL: "Parry Radius"
-- LABEL: "Parrying Dagger"
-- LABEL: "Pilih Emote"
-- LABEL: "Pilih Player"
-- LABEL: "Pilih Target (Shared)"
-- LABEL: "Pilih pemain terlebih dulu!"
-- LABEL: "Pilih target dulu!"
-- LABEL: "Player Color"
-- LABEL: "Player Emote"
-- LABEL: "Players: %d/%d"
-- LABEL: "Position X"
-- LABEL: "Position Y"
-- LABEL: "Predict Aim Offset"
-- LABEL: "Predict Aim ToF"
-- LABEL: "Predict Efficiency"
-- LABEL: "Predict Smoothness"
-- LABEL: "Pursuit tanpa cooldown / unlimited"
-- LABEL: "Refresh Count"
-- LABEL: "Refresh Map"
-- LABEL: "Refresh Player"
-- LABEL: "Refresh Target List"
-- LABEL: "Rejoin Server"
-- LABEL: "Reset ke 60 FPS"
-- LABEL: "Reset to 60 FPS"
-- LABEL: "Right Arm"
-- LABEL: "Right Leg"
-- LABEL: "SCP / Zombie"
-- LABEL: "SCP Color"
-- LABEL: "SCP-173 Room"
-- LABEL: "SCP-205 Room"
-- LABEL: "Safety Pallet"
-- LABEL: "Safety Parry"
-- LABEL: "Self Heal"
-- LABEL: "Self Heal: DISABLED"
-- LABEL: "Self Heal: ENABLED (Tanpa Animasi)"
-- LABEL: "Semakin tinggi, semakin agresif prediksi gerakan target"
-- LABEL: "Sensitivitas arah pandang (1-10)"
-- LABEL: "Server Found"
-- LABEL: "Server Tools"
-- LABEL: "Shadow berhasil dihapus!"
-- LABEL: "Shadow dikembalikan normal"
-- LABEL: "Show FOV Circle"
-- LABEL: "Show Hook Count"
-- LABEL: "Show Moonwalk Button"
-- LABEL: "Show Veil FOV"
-- LABEL: "Silent Aim (Pistol)"
-- LABEL: "Silent Aim (Veil Spear)"
-- LABEL: "Silent Aim (flash)"
-- LABEL: "Silent Aim Flask"
-- LABEL: "Silent Aim Flask (Cure)"
-- LABEL: "Silent Aim Twist Of Fate"
-- LABEL: "Silent Veil V1"
-- LABEL: "Silent Veil V2"
-- LABEL: "Site 68"
-- LABEL: "Skill Check Frequency"
-- LABEL: "Skill Check Mode"
-- LABEL: "Skill Check Speed"
-- LABEL: "Skill Hidden No CD"
-- LABEL: "Skip Endscreen"
-- LABEL: "Smoothness: "
-- LABEL: "Spear Gravity"
-- LABEL: "Spear Speed"
-- LABEL: "Spectator Info"
-- LABEL: "Speed Boost Value"
-- LABEL: "Speed Boost aktif! ("
-- LABEL: "Speed Boost dimatikan"
-- LABEL: "Speed Input"
-- LABEL: "Speed Value (Input Mode)"
-- LABEL: "Sreamer Mode"
-- LABEL: "Status: Lobby"
-- LABEL: "Status: Setting up..."
-- LABEL: "Status: —"
-- LABEL: "Stun Indicator"
-- LABEL: "Survivors (J)"
-- LABEL: "Sus R6"
-- LABEL: "TARGET MODE TWIST OF FATE"
-- LABEL: "TP Gate (Loop)"
-- LABEL: "TP Generator"
-- LABEL: "TP Hook (Loop)"
-- LABEL: "TP Pallet (Loop)"
-- LABEL: "TP Window (Loop)"
-- LABEL: "TP ke player yang di pilih"
-- LABEL: "Tambahkan efek acak pada prediksi"
-- LABEL: "Tampilkan FPS dan Ping"
-- LABEL: "Tampilkan button Moonwalk di layar (pencet button untuk aktif)"
-- LABEL: "Tampilkan jumlah hook di ATAS kepala survivor"
-- LABEL: "Tampilkan radius jarak parry di karakter"
-- LABEL: "Target Mode"
-- LABEL: "Teleport Maps"
-- LABEL: "Teleport Players"
-- LABEL: "Teleport ke Generator"
-- LABEL: "Teleport ke gate secara instan tanpa delay"
-- LABEL: "Teleport ke player yang dipilih"
-- LABEL: "Teleport saat killer terlalu dekat"
-- LABEL: "Tembus gate tanpa collision"
-- LABEL: "The Bay Harbor"
-- LABEL: "Third Person (Killer)"
-- LABEL: "Time Of Day"
-- LABEL: "Toggle Anti Slow Vault"
-- LABEL: "Toggle Skill Check"
-- LABEL: "Toggle Vault Speed"
-- LABEL: "Tools Jerk"
-- LABEL: "Tools Jerk berhasil dimuat!"
-- LABEL: "Trigger Distance"
-- LABEL: "Troll Player"
-- LABEL: "Try Again"
-- LABEL: "Twist of Fate"
-- LABEL: "UI Settings"
-- LABEL: "Unlimited Vault"
-- LABEL: "Unload script"
-- LABEL: "Valdelobos Village"
-- LABEL: "Vault Speed"
-- LABEL: "Vault/ lompat jendela tanpa batas (tanpa cooldown)"
-- LABEL: "Veil Aim Key"
-- LABEL: "Veil FOV Radius"
-- LABEL: "Veil lunge"
-- LABEL: "Violence District v2.4.0 | https://discord.gg/panduhub"
-- LABEL: "White Armored Car"
-- LABEL: "Window / Vault"
-- LABEL: "Window Color"
-- LABEL: "Woodview Cabin"
-- LABEL: "World Effects"
-- LABEL: "Zombie (L)"
-- LABEL: "Zoom Out tanpa batas"
-- LABEL: "[SpearInterceptor]: Executor tidak support getrawmetatable atau setreadonly."
-- LABEL: "auto predict aim: "
-- LABEL: "cure Basic"
-- LABEL: "cure lunge"
-- LABEL: "fininshline not found"
-- LABEL: "instan escape"
-- LABEL: "left arm"
-- LABEL: "left leg"
-- LABEL: "misal: 0.05"
-- LABEL: "random shakes"
-- LABEL: "right arm"
-- LABEL: "right leg"
-- LABEL: "water pump"
-- LABEL: "⚡ STUNNED"
-- LABEL: "✅ AKTIF (999x)"
-- LABEL: "✅ Aktif"
-- LABEL: "✅ Aktif!"
-- LABEL: "✅ Display aktif di pojok atas"
-- LABEL: "✅ Moonwalk aktif (via main RenderStepped)"
-- LABEL: "✅ Moonwalk button created!"
-- LABEL: "✅ Speed Input aktif (via main RenderStepped)"
-- LABEL: "✅ Stun Indicator AKTIF - Auto re-apply aktif!"
-- LABEL: "✅ Stun re-setup untuk killer ganti team: "
-- LABEL: "✅ Stun setup untuk killer baru: "
-- LABEL: "❌ Nonaktif"
-- LABEL: "❌ Stun Indicator dimatikan"
-- LABEL: "🌙 OFF"
-- LABEL: "🔄 Map changed (childCount) - Rescanned!"
-- LABEL: "🔄 Stun re-applied for: "
-- LABEL: "🔄 Stun re-setup setelah respawn"

-- Special Strings & Symbols:
-- SPECIAL: "!"
-- SPECIAL: "!!"
-- SPECIAL: "#%02X%02X%02X"
-- SPECIAL: "&"
-- SPECIAL: "&amp;"
-- SPECIAL: "&cursor="
-- SPECIAL: "&gt;"
-- SPECIAL: "&lt;"
-- SPECIAL: ")"
-- SPECIAL: "+"
-- SPECIAL: "-mob"
-- SPECIAL: "/servers/Public?sortOrder=Asc&limit=100"
-- SPECIAL: "0"
-- SPECIAL: "0.01"
-- SPECIAL: "0.1"
-- SPECIAL: "1"
-- SPECIAL: "105374834496520"
-- SPECIAL: "106871536134254"
-- SPECIAL: "110355011987939"
-- SPECIAL: "111920872708571"
-- SPECIAL: "113255068724446"
-- SPECIAL: "115244153053858"
-- SPECIAL: "117042998468241"
-- SPECIAL: "118907603246885"
-- SPECIAL: "121216847022485"
-- SPECIAL: "122812055447896"
-- SPECIAL: "129784271201071"
-- SPECIAL: "130593238885843"
-- SPECIAL: "132817836308238"
-- SPECIAL: "133963973694098"
-- SPECIAL: "135002183282873"
-- SPECIAL: "138720291317243"
-- SPECIAL: "139369275981139"
-- SPECIAL: "6"
-- SPECIAL: "74968262036854"
-- SPECIAL: "78432063483146"
-- SPECIAL: "80411309607666"
-- SPECIAL: "82666958311998"
-- SPECIAL: "86266790353635"
-- SPECIAL: "93136435416899"
-- SPECIAL: "94380161420025"
-- SPECIAL: "95836365038528"
-- SPECIAL: "98163597193511"
-- SPECIAL: "<"
-- SPECIAL: "</font>"
-- SPECIAL: "</font>]"
-- SPECIAL: ">"
-- SPECIAL: "AKTIF!"
-- SPECIAL: "Aktif!"
-- SPECIAL: "B"
-- SPECIAL: "Berhasil!"
-- SPECIAL: "G"
-- SPECIAL: "Gui-mob"
-- SPECIAL: "I"
-- SPECIAL: "J"
-- SPECIAL: "K"
-- SPECIAL: "L"
-- SPECIAL: "LeftGate-end"
-- SPECIAL: "LeftGate-end2"
-- SPECIAL: "Loading..."
-- SPECIAL: "NONAKTIF!"
-- SPECIAL: "Nonaktif!"
-- SPECIAL: "Pandu/FullFeature"
-- SPECIAL: "Q"
-- SPECIAL: "R"
-- SPECIAL: "Ready!"
-- SPECIAL: "RightGate-end"
-- SPECIAL: "RightGate-end2"
-- SPECIAL: "Scanning..."
-- SPECIAL: "Skillcheck-gen"
-- SPECIAL: "Skillcheck-player"
-- SPECIAL: "Slasher-mob"
-- SPECIAL: "Survivor-mob"
-- SPECIAL: "Survivor-mob.Controls.crouch.icon"
-- SPECIAL: "X"
-- SPECIAL: "Y"
-- SPECIAL: "Z"
-- SPECIAL: "[^%.]+"
-- SPECIAL: "_G"
-- SPECIAL: "__namecall"
-- SPECIAL: "_isFacingStraightEnough"
-- SPECIAL: "_lastMapChildCount"
-- SPECIAL: "_onVaultAnimation"
-- SPECIAL: "_statusConn"
-- SPECIAL: "arrow-right"
-- SPECIAL: "map-pin"
-- SPECIAL: "shield-alert"
-- SPECIAL: "−"

-- ============================================================
-- CALLBACK FUNCTIONS (PROTO2 .. PROTO637)
-- ============================================================

local function PROTO2(val)
	Surv_Aimbot_Enabled = val
end

local function PROTO3(val)
	obj:GetDescendants()
	local _insert = obj.insert
	local _SpooferConns = obj.SpooferConns
	local _applySpooferToObj = obj.applySpooferToObj
	local _DescendantAdded = obj.DescendantAdded
	obj:Connect()
	local _cb = PROTO4
	local _Misc_FakeName = obj.Misc_FakeName
	obj:FindFirstChild()
	obj.PlayerGui = val
	local _applySpooferToObj = obj.applySpooferToObj
	local _ipairs = obj.ipairs
end

local function PROTO4(val)
	local _defer = obj.defer
	local _cb = PROTO5
end

local function PROTO5(val)
	local _applySpooferToObj = obj.applySpooferToObj
end

local function PROTO6(val)
	obj.ImageButton = val
	obj.TextButton = val
	obj:Connect()
	local _updateImage = obj.updateImage
	local _cb = PROTO7
	local _updateText = obj.updateText
	local _updateText = obj.updateText
	local _cb = PROTO8
	local _r = updateImage
	local _updateImage = obj.updateImage
	obj:GetPropertyChangedSignal()
	obj.Image = val
	obj:IsA()
	obj.ImageLabel = val
	local _insert = obj.insert
	local _SpooferConns = obj.SpooferConns
	local _insert = obj.insert
	local _SpooferConns = obj.SpooferConns
	obj.Text = val
	obj.TextBox = val
	local _updateText = obj.updateText
	local _table = obj.table
	obj:IsA()
	obj.TextLabel = val
end

local function PROTO7(val)
	Text = val
	local _find = obj.find
	local _Name = obj.Name
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	local _DisplayName = obj.DisplayName
	local _gsub = obj.gsub
	local _DisplayName = obj.DisplayName
	obj.PANDU = val
	local Misc_FakeName
	obj:SetAttribute()
	obj.OriginalText = val
	local Text
	obj:GetAttribute()
	obj.OriginalText = val
	local _Name = obj.Name
	obj.PANDU = val
	local _string = obj.string
end

local function PROTO8(val)
	local _string = obj.string
	local _tostring = obj.tostring
	obj:SetAttribute()
	obj.OriginalImage = val
	obj:GetAttribute()
	local Misc_FakeName
	obj:GetPlayers()
	local _UserId = obj.UserId
	local Image
	local _ipairs = obj.ipairs
	-- compare: "rbxassetid://94380161420025"
end

local function PROTO9(val)
	local _doShoot = obj.doShoot
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton2 = obj.MouseButton2
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	-- literal: "MouseButton1"
end

local function PROTO10(val)
	obj:Unload()
end

local function PROTO11(val)
	-- compare: "None"
	obj:FindFirstChild()
end

local function PROTO12(val)
	local oldGateNew
	local GateClientModule
	local oldGateCanUse
	obj.CanUse = val
	oldGateCanUse = val
	obj.new = val
end

local function PROTO13(val)
	local _Name = obj.Name
	obj:GetAttribute()
	obj.HookCount = val
	local _Team = obj.Team
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Survivors()
	local _pairs = obj.pairs
	obj:GetPlayers()
end

local function PROTO14(val)
	obj.Name = val
	obj.Parent = val
	obj.Size = val
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _TextYAlignment = obj.TextYAlignment
	local _Center = obj.Center
	obj.TextYAlignment = val
	obj.Parent = val
	local _UDim2 = obj.UDim2
	obj.TextColor3 = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.BillboardGui = val
	local _format = obj.format
	-- str: "Hooked %d"
	obj.Text = val
	local _Enum = obj.Enum
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	local _Enum = obj.Enum
	obj["Thickness"] = 2
	obj.Parent = val
	obj.StudsOffset = val
	local _Instance = obj.Instance
	local _TextXAlignment = obj.TextXAlignment
	obj.TextXAlignment = val
	local _Enum = obj.Enum
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _Name = obj.Name
	obj:FindFirstChild()
	obj.TextColor3 = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj:Destroy()
	obj.Color = val
	obj["TextSize"] = 11
	obj["TextScaled"] = true
	local _string = obj.string
	obj["AlwaysOnTop"] = true
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _new = obj.new
	obj.TextLabel = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
end

local function PROTO15(val)
	local _ScanMap = obj.ScanMap
	local _Name = obj.Name
	obj:Map()
end

local function PROTO16(val)
	obj:GetPropertyChangedSignal()
	obj.Team = val
	obj:Connect()
	local _cb = PROTO17
end

local function PROTO17(val)
	local Character
	local _task = obj.task
	local _wait = obj.wait
	local _print = obj.print
	local _task = obj.task
	local _wait = obj.wait
	local _IsKiller = obj.IsKiller
	local Name
	-- str: "✅ Stun re-setup untuk killer ganti team: "
end

local function PROTO18(val)
	Surv_ParryFace = val
end

local function PROTO19(val)
	local _r = MoonwalkEnabled
	obj:Notify()
	obj["Title"] = "Moonwalk PC"
	obj["Description"] = "AKTIF"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Moonwalk PC"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
end

local function PROTO20(val)
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _LeftShift = obj.LeftShift
	local _getgenv = obj.getgenv
	obj.AutoRunEnabled = val
	obj:SendKeyEvent()
	obj:GetMouse()
	local _task = obj.task
	local _spawn = obj.spawn
end

local function PROTO21(val)
	obj:GetMouse()
	local _task = obj.task
	local _wait = obj.wait
	local _getgenv = obj.getgenv
	local _AutoRunEnabled = obj.AutoRunEnabled
	obj:SendKeyEvent()
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _LeftShift = obj.LeftShift
end

local function PROTO22(val)
	obj["Title"] = "Moonwalk"
	obj["Description"] = "Button disembunyikan"
	obj:Notify()
	obj["Title"] = "Moonwalk"
	obj["Description"] = "Button muncul! Tekan untuk aktif"
	obj["Time"] = 3
	obj:Notify()
end

local function PROTO23(val)
	obj:GetAttribute()
	obj.HumanoidRootPart = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:GetAttribute()
	obj.isVaulting = val
	local _cb = PROTO24
	local Character
	local _Health = obj.Health
	local _MaxHealth = obj.MaxHealth
	obj:FindFirstChild()
	obj:FindFirstChild()
	local Team
	local _Name = obj.Name
	-- compare: "Killer"
	obj:GetAttribute()
	obj.isRepairing = val
	obj:GetAttribute()
	obj.isHealing = val
	local _task = obj.task
	local _wait = obj.wait
	obj:GetAttribute()
	obj.isUnhooking = val
end

local function PROTO24(val)
	obj:FindFirstChild()
	obj.Remotes = val
	obj:FindFirstChild()
	obj.Healing = val
	local _HealEvent = obj.HealEvent
	obj:FireServer()
end

local function PROTO25(val)
	obj.Description = val
	obj["Time"] = 2
	obj.Title = val
	local Surv_AutoParry
	obj.Nonaktif = val
	local _Library = obj.Library
	obj:Notify()
	local _cb = PROTO26
	local _pcall = obj.pcall
	local _cb = PROTO27
	IsActive = val
	obj.Aktif = val
	Surv_AutoParry = val
end

local function PROTO26(val)
	local _Toggles = obj.Toggles
	local _Toggles = obj.Toggles
	local _AutoParryKey = obj.AutoParryKey
	obj:SetValue()
	local Surv_AutoParry
	local _Toggles = obj.Toggles
	local _AutoParryKey = obj.AutoParryKey
end

local function PROTO27(val)
	local _Toggles = obj.Toggles
	local _Toggles = obj.Toggles
	local _AutoParry = obj.AutoParry
	local _Toggles = obj.Toggles
	local _AutoParry = obj.AutoParry
	obj:SetValue()
	local Surv_AutoParry
end

local function PROTO28(val)
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	-- str: "_statusConn"
	obj:Disconnect()
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "Frame"
	obj.Parent = val
	local _UDim2 = obj.UDim2
	local _fromOffset = obj.fromOffset
	obj.Parent = val
	Gui = val
	local Heartbeat
	obj:Connect()
	local _cb = PROTO29
	-- str: "_statusConn"
	obj.BackgroundColor3 = val
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj["Name"] = "AutoParryCustomGui"
	obj["IgnoreGuiInset"] = true
	local _Enum = obj.Enum
	local _ZIndexBehavior = obj.ZIndexBehavior
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	obj.Size = val
	local _UDim2 = obj.UDim2
	obj.Parent = val
	local _Instance = obj.Instance
	local _UDim = obj.UDim
	local _new = obj.new
	local _UDim = obj.UDim
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	local _new = obj.new
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj["Active"] = true
	obj["BorderSizePixel"] = 0
	obj.Size = val
	obj["Text"] = "PARRY [OFF]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _fromScale = obj.fromScale
	local Gui
	obj:Destroy()
	Gui = val
	local _fromRGB = obj.fromRGB
	local _cb = PROTO30
	local _InputBegan = obj.InputBegan
	obj:Connect()
	local _cb = PROTO31
	local _Sibling = obj.Sibling
	obj.ZIndexBehavior = val
	obj["TextSize"] = 12
	local _Color3 = obj.Color3
	obj["Name"] = "UIStroke"
	obj.Parent = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextButton = val
	obj["Name"] = "ActionButton"
	local _UDim2 = obj.UDim2
	obj.CornerRadius = val
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.2
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Position = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj["BorderSizePixel"] = 0
	obj.CornerRadius = val
	local _InputEnded = obj.InputEnded
	obj:Connect()
	local _cb = PROTO33
	local InputChanged
	obj:Connect()
	local _cb = PROTO34
	-- str: "_statusConn"
end

local function PROTO29(val)
	local IsActive
	local Surv_AutoParry
	-- str: "_statusConn"
	obj:Disconnect()
	-- str: "_statusConn"
	local Gui
	-- str: "_statusConn"
	IsActive = val
	local _Parent = obj.Parent
end

local function PROTO30(val)
	local _Scale = obj.Scale
	-- str: "X"
	local _Offset = obj.Offset
	-- str: "X"
	-- str: "Y"
	Position = val
	-- str: "Y"
	local _math = obj.math
	local _abs = obj.abs
	-- str: "X"
	-- str: "Y"
	local _Scale = obj.Scale
	-- str: "Y"
	local _Offset = obj.Offset
	local _UDim2 = obj.UDim2
	local _new = obj.new
	-- str: "X"
end

local function PROTO31(val)
	local _Touch = obj.Touch
	local _task = obj.task
	local _cancel = obj.cancel
	local _Position = obj.Position
	local Position
	local _delay = obj.delay
	local _cb = PROTO32
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
end

local function PROTO32(val)
	-- (no semantic content extracted)
end

local function PROTO33(val)
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _Touch = obj.Touch
	local _task = obj.task
	local _cancel = obj.cancel
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
end

local function PROTO34(val)
	local _Touch = obj.Touch
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseMovement = obj.MouseMovement
end

local function PROTO35(val)
	SPEAR_Gravity = val
end

local function PROTO36(val)
	local Heartbeat
	obj:Connect()
	local _cb = PROTO37
end

local function PROTO37(val)
	obj:Lerp()
	local _updateLaser = obj.updateLaser
	local _getTargetPosition = obj.getTargetPosition
	local _lookAt = obj.lookAt
	local CFrame
	local _Position = obj.Position
	CFrame = val
	local _pcall = obj.pcall
	local LockAim
end

local function PROTO38(val)
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetAttribute()
	obj.IsCarried = val
	obj.CFrame = val
	local Character
	local _Position = obj.Position
	-- str: "Y"
	-- str: "Z"
end

local function PROTO39(val)
	local _clearLaser = obj.clearLaser
	obj:Disconnect()
end

local function PROTO40(val)
	obj.Description = val
	obj["Time"] = 2
	local Killer_Bypass
	obj:SetValue()
	Killer_BypassCarry = val
	obj:Notify()
	obj["Title"] = "Bypass Carry"
	-- str: "Aktif!"
	-- str: "Nonaktif!"
end

local function PROTO41(val)
	obj:GetPlayers()
	local _TryAttach = obj.TryAttach
	local _task = obj.task
	local _wait = obj.wait
	local _pairs = obj.pairs
end

local function PROTO42(val)
	-- (no semantic content extracted)
end

local function PROTO43(val)
	-- str: "Shadow berhasil dihapus!"
	local _r = NoShadow
	local _ApplyNoShadow = obj.ApplyNoShadow
	-- str: "Shadow dikembalikan normal"
	obj:Notify()
	obj["Title"] = "No Shadow"
	obj.Description = val
	obj["Time"] = 3
end

local function PROTO44(val)
	local _r = MoonwalkEnabled
	local MoonwalkPCToggle
	obj:Notify()
	obj["Title"] = "Moonwalk PC"
	obj:SetValue()
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	obj["Title"] = "Moonwalk PC"
	local Description
	obj["Time"] = 2
end

local function PROTO45(val)
	obj["Description"] = "Gui Loaded"
	obj["Time"] = 2
	obj["Title"] = "Bypass Carry GUI"
	obj["Description"] = "Gui Destroyed"
	obj["Time"] = 2
	local Killer_BypassCarry
	local Gui
	obj["Enabled"] = true
	obj:Notify()
	local _pcall = obj.pcall
	local _cb = PROTO46
end

local function PROTO46(val)
	local Killer_Bypass
	obj:SetValue()
end

local function PROTO47(val)
	local _print = obj.print
	-- str: "✅ Stun Indicator AKTIF - Auto re-apply aktif!"
	-- str: "❌ Stun Indicator dimatikan"
	local _task = obj.task
	local _wait = obj.wait
	local _print = obj.print
	obj:Notify()
	obj["Title"] = "Stun Indicator"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	local _pairs = obj.pairs
	obj:Notify()
	obj["Title"] = "Stun Indicator"
	obj["Description"] = "Aktif"
	local _pairs = obj.pairs
	obj["Time"] = 3
end

local function PROTO48(val)
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	local _pcall = obj.pcall
	local _NEX_StopJeffCooldownBypass = obj.NEX_StopJeffCooldownBypass
	KILLER_InfFrenzy = val
	obj["Description"] = "AKTIF"
	obj["Time"] = 2
	local _pcall = obj.pcall
	local _NEX_StartJeffCooldownBypass = obj.NEX_StartJeffCooldownBypass
	obj:Notify()
	obj["Title"] = "Infinite Frenzy"
	obj:Notify()
	obj["Title"] = "Infinite Frenzy"
end

local function PROTO49(val)
	obj:Notify()
	local _setBypassGate = obj.setBypassGate
	obj:Notify()
	obj["Title"] = "Bypass Exite Gate"
	obj["Description"] = "Gate bypass aktif!"
	obj["Time"] = 3
	obj["Title"] = "Bypass Exite Gate"
	obj["Description"] = "Gate bypass dimatikan!"
	obj["Time"] = 3
end

local function PROTO50(val)
	local _ScanMap = obj.ScanMap
	ESP_GeneratorName = val
	local ESP_Master
end

local function PROTO51(val)
	local Aim_SilentVeil
	local Aim_SilentVeilV2
end

local function PROTO52(val)
	Surv_ParrySafety = val
end

local function PROTO53(val)
	CameraMode = val
	local _ResetAllTransparency = obj.ResetAllTransparency
	local Character
	local Team
	obj:Notify()
	obj["Title"] = "Akses Ditolak"
	obj["Description"] = "Fitur ini khusus Killer!"
	obj["Time"] = 3
	Killer_3rdPerson = val
	local RenderStepped
	obj:Connect()
	local _cb = PROTO54
	local _Enum = obj.Enum
	local _CameraMode = obj.CameraMode
	local _LockFirstPerson = obj.LockFirstPerson
	local _ThirdPersonConn = obj.ThirdPersonConn
	obj:Disconnect()
	local _ResetCharacterTransparency = obj.ResetCharacterTransparency
	local _ThirdPersonConn = obj.ThirdPersonConn
	local _ThirdPersonConn = obj.ThirdPersonConn
	obj:Disconnect()
	local _Enum = obj.Enum
	local _CameraMode = obj.CameraMode
	local _Classic = obj.Classic
	CameraMode = val
	local _Enum = obj.Enum
	local _CameraMode = obj.CameraMode
	local _Classic = obj.Classic
end

local function PROTO54(val)
	local Killer_3rdPerson
	local Team
	-- compare: "Killer"
	obj:Disconnect()
	local _Enum = obj.Enum
	local _CameraMode = obj.CameraMode
	local _Classic = obj.Classic
	CameraMode = val
	local _SetWorldTransparency = obj.SetWorldTransparency
	local _ThirdPersonConn = obj.ThirdPersonConn
	local Character
end

local function PROTO55(val)
	obj:Connect()
	local _cb = PROTO56
	obj:RemoveTag()
	-- str: "_G"
	local _UnlimitedVaultConn = obj.UnlimitedVaultConn
	-- str: "_G"
	obj["Time"] = 3
	-- str: "_G"
	local _UnlimitedVaultConn = obj.UnlimitedVaultConn
	local _ipairs = obj.ipairs
	obj:GetTagged()
	obj.Blocked = val
	obj:GetInstanceAddedSignal()
	obj.Blocked = val
	obj["Title"] = "Unlimited Vault"
	obj["Description"] = "Aktif"
	obj.UnlimitedVaultConn = val
	obj:Notify()
	obj.Blocked = val
end

local function PROTO56(val)
	obj.Blocked = val
	obj:RemoveTag()
end

local function PROTO57(val)
	-- str: "_G"
	local _UnlimitedVaultConn = obj.UnlimitedVaultConn
	-- str: "_G"
	local _UnlimitedVaultConn = obj.UnlimitedVaultConn
	obj:Disconnect()
	-- str: "_G"
	obj.UnlimitedVaultConn = val
	obj:Notify()
	obj["Title"] = "Unlimited Vault"
	obj["Time"] = 2
end

local function PROTO58(val)
	local _StopRepairAnim = obj.StopRepairAnim
	local _AutoCurrentPoint = obj.AutoCurrentPoint
	local _r = AutoCurrentPoint
	local _pcall = obj.pcall
	local _cb = PROTO59
end

local function PROTO59(val)
	obj:FireServer()
end

local function PROTO60(val)
	local _r = AutoCurrentGenModel
	local _AutoRepairThread = obj.AutoRepairThread
	local _StopAutoRepair = obj.StopAutoRepair
	local _task = obj.task
	local _task = obj.task
	local _cancel = obj.cancel
	local _AutoRepairThread = obj.AutoRepairThread
	local _r = AutoRepairThread
	local _cb = PROTO61
	local _AutoRepairThread = obj.AutoRepairThread
end

local function PROTO61(val)
	local _ProcessedGens = obj.ProcessedGens
	local _AutoCurrentGenModel = obj.AutoCurrentGenModel
	local _r = AutoCurrentGenModel
	local _BypassGenEnabled = obj.BypassGenEnabled
	local _task = obj.task
	local _wait = obj.wait
	local _AutoCurrentPoint = obj.AutoCurrentPoint
	local Character
	local _Magnitude = obj.Magnitude
	obj:FindFirstChild()
	local _pairs = obj.pairs
	local _GetGeneratorPoints = obj.GetGeneratorPoints
	local _pairs = obj.pairs
	local _GetAllGenerators = obj.GetAllGenerators
	local _cb = PROTO62
	local _r = LastFireTime
	local _AutoFireInterval = obj.AutoFireInterval
	local _Position = obj.Position
	local _Position = obj.Position
	local _task = obj.task
	local _wait = obj.wait
	local _AutoCurrentGenModel = obj.AutoCurrentGenModel
	local _AutoRepairEnabled = obj.AutoRepairEnabled
	local _PlayRepairAnim = obj.PlayRepairAnim
	local _pcall = obj.pcall
	local _r = AutoCurrentPoint
	local _StopAutoRepair = obj.StopAutoRepair
end

local function PROTO62(val)
	obj:FireServer()
end

local function PROTO63(val)
	obj.IsRepairing = val
	local _tick = obj.tick
	local _task = obj.task
	local _wait = obj.wait
	local _tick = obj.tick
end

local function PROTO64(val)
	local _task = obj.task
	local _wait = obj.wait
	local _ScanMap = obj.ScanMap
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO65
end

local function PROTO65(val)
	local _UpdateSCPESP = obj.UpdateSCPESP
	local _UpdateStaticESP = obj.UpdateStaticESP
	local _ClearAllESP = obj.ClearAllESP
	local _task = obj.task
	local _wait = obj.wait
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO66(val)
	-- (no semantic content extracted)
end

local function PROTO67(val)
	local _r = BypassGenMode
end

local function PROTO68(val)
	local _Enum = obj.Enum
	local _MouseBehavior = obj.MouseBehavior
	local _LockCenter = obj.LockCenter
	obj:Disconnect()
	local _MouseBehavior = obj.MouseBehavior
	local _Default = obj.Default
	obj:Disconnect()
	local RenderStepped
	obj:Connect()
	local _cb = PROTO69
	MouseBehavior = val
	MouseBehavior = val
	local _KeyCode = obj.KeyCode
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _RightAlt = obj.RightAlt
end

local function PROTO69(val)
	local MouseBehavior
	local _Enum = obj.Enum
	local _MouseBehavior = obj.MouseBehavior
	local _Enum = obj.Enum
	local _MouseBehavior = obj.MouseBehavior
	local _Default = obj.Default
	MouseBehavior = val
	local MouseIconEnabled
	local _Default = obj.Default
end

local function PROTO70(val)
	local _r = FleeDistance
end

local function PROTO71(val)
	local _DisableUnlimitedVault = obj.DisableUnlimitedVault
	local _EnableUnlimitedVault = obj.EnableUnlimitedVault
end

local function PROTO72(val)
	local _workspace = obj.workspace
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Part = val
	local _new = obj.new
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _Enum = obj.Enum
	local _Material = obj.Material
	local _Neon = obj.Neon
	local _Magnitude = obj.Magnitude
	local _Vector3 = obj.Vector3
end

local function PROTO73(val)
	obj:Destroy()
end

local function PROTO74(val)
	local _UpdateSpectatorCount = obj.UpdateSpectatorCount
	local _spectatorEnabled = obj.spectatorEnabled
end

local function PROTO75(val)
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	-- str: "X"
	local ViewportSize
	local Veil_ShowFOV
	-- str: "busy"
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO76
	obj:Normal()
	-- str: "X"
	-- str: "Y"
	To = val
	local _Vector2 = obj.Vector2
	local _CFrame = obj.CFrame
	obj:Lerp()
	local _CFrame = obj.CFrame
	Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local Surv_Aimbot_Radius
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _math = obj.math
	local _sin = obj.sin
	local _lookAt = obj.lookAt
	local _CFrame = obj.CFrame
	local _Position = obj.Position
	-- str: "X"
	-- str: "Y"
	local _Rotation = obj.Rotation
	obj.Rotation = val
	local _getClosestSurvivor = obj.getClosestSurvivor
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	Parent = val
	local _new = obj.new
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	local _Position = obj.Position
	-- str: "Y"
	-- str: "Z"
	local _CFrame = obj.CFrame
	obj:Lerp()
	local _new = obj.new
	-- str: "X"
	-- str: "Y"
	Position = val
	local Killer_Aimbot_Smoothness
	CFrame = val
	local _CFrame = obj.CFrame
	obj:FindFirstChild()
	obj.Line = val
	obj:FindFirstChild()
	local _Angles = obj.Angles
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local Flash_YOffset
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	local _r = lockedAimbotTarget
	obj:Lerp()
	local Surv_Aimbot_Smoothness
	CFrame = val
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _CFrame = obj.CFrame
	local _lookAt = obj.lookAt
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _GetRole = obj.GetRole
	obj:Killer()
	local _Magnitude = obj.Magnitude
	Parent = val
	obj.Humanoid = val
	local _Position = obj.Position
	local CFrame
	local _lockedAimbotTarget = obj.lockedAimbotTarget
	local Surv_Aimbot_Enabled
	Visible = val
	local _isAimingFlash = obj.isAimingFlash
	-- str: "Y"
	Position = val
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	local Veil_FOV
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Surv_Aimbot_Predict
	local _Parent = obj.Parent
	local _Unit = obj.Unit
	obj.Goal = val
	local _CFrame = obj.CFrame
	local _lookAt = obj.lookAt
	local _Position = obj.Position
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local _isAimbotHolding = obj.isAimbotHolding
	local _tick = obj.tick
	obj.CFrame = val
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	local _r = lockedAimbotTarget
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _math = obj.math
	local _rad = obj.rad
	Color = val
	local Flash_Silent
	local _lockedAimbotTarget = obj.lockedAimbotTarget
	local _Position = obj.Position
	local _GetDistance = obj.GetDistance
	obj:Lerp()
	obj.CFrame = val
	local Killer_Aimbot_Enabled
	local _IsDowned = obj.IsDowned
	-- str: "X"
	-- str: "Z"
	local _lockedAimbotTarget = obj.lockedAimbotTarget
	obj:FindFirstChild()
	obj.SkillCheckPromptGui = val
	obj:FindFirstChild()
	obj.Check = val
	obj:Move()
	obj:WorldToViewportPoint()
	local _Position = obj.Position
	local _GetRole = obj.GetRole
	obj:Survivor()
	obj.CFrame = val
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	obj.CFrame = val
	-- str: "Z"
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local Character
	-- str: "busy"
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO77
	local _Parent = obj.Parent
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _Visible = obj.Visible
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local Surv_Aimbot_ShowFOV
	obj:Lerp()
	From = val
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local SkillCheckMode
	obj:Instant()
	local _Unit = obj.Unit
	local _new = obj.new
	-- str: "X"
	local _Position = obj.Position
	-- str: "Y"
	-- str: "Z"
	local _CFrame = obj.CFrame
	local _CFrame = obj.CFrame
	local _new = obj.new
	obj:FindFirstChild()
	obj.Humanoid = val
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	local Killer_Aimbot_MaxDist
	local _Rotation = obj.Rotation
	local _Rotation = obj.Rotation
	local _Position = obj.Position
	-- str: "Y"
	-- str: "Z"
	local _CFrame = obj.CFrame
	obj:Lerp()
	local _getKillerTargetForFlash = obj.getKillerTargetForFlash
	Size = val
	local _Vector2 = obj.Vector2
	local _new = obj.new
	-- str: "X"
	-- str: "Y"
	local _CFrame = obj.CFrame
	local _LookVector = obj.LookVector
	local _CFrame = obj.CFrame
	obj:Survivor()
	local _Parent = obj.Parent
	Parent = val
	local _Position = obj.Position
	obj.CFrame = val
	local SkillCheck
	local _CFrame = obj.CFrame
	obj:GetAttribute()
	obj.spearmode = val
	local _Health = obj.Health
	local _busy = obj.busy
	local _Position = obj.Position
	local _GetDistance = obj.GetDistance
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	Color = val
	-- str: "X"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChildOfClass()
	local _RightVector = obj.RightVector
	-- str: "Y"
	local _GetRole = obj.GetRole
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	local _r = lockedAimbotTarget
end

local function PROTO76(val)
	local _task = obj.task
	local _wait = obj.wait
	-- str: "busy"
end

local function PROTO77(val)
	local _task = obj.task
	local _wait = obj.wait
	-- str: "busy"
end

local function PROTO78(val)
	local Colors
	obj.Gate = val
end

local function PROTO79(val)
	PredictionEfficiency = val
	obj:Notify()
	-- str: "%"
end

local function PROTO80(val)
	local ESP_Killer
	obj["Name"] = "KillerWarn"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj:FindFirstChild()
	obj.WarnText = val
	local _GothamBlack = obj.GothamBlack
	obj.Font = val
	obj.Parent = val
	obj:Destroy()
	local _Character = obj.Character
	obj.Name = val
	local _Character = obj.Character
	obj.Parent = val
	obj:FindFirstChild()
	obj.KillerWarn = val
	obj.StudsOffset = val
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	obj.PE_Text = val
	local _Position = obj.Position
	local _Position = obj.Position
	local _Character = obj.Character
	obj.Size = val
	obj["AlwaysOnTop"] = true
	local _Vector3 = obj.Vector3
	local Colors
	local _Player = obj.Player
	obj["Text"] = "!"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _pairs = obj.pairs
	obj:GetPlayers()
	local _new = obj.new
	obj.Highlight = val
	local ESP_KillerWarn
	local Character
	obj:FindFirstChild()
	obj.KillerWarn = val
	local _math = obj.math
	local _huge = obj.huge
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	local ESP_ItemIcon
	obj:GetAttribute()
	obj:Destroy()
	local _Character = obj.Character
	obj:Destroy()
	local _IsKiller = obj.IsKiller
	local _Killer = obj.Killer
	local _Character = obj.Character
	obj:FindFirstChild()
	obj["TextStrokeTransparency"] = 0
	local _Enum = obj.Enum
	local _Font = obj.Font
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _Magnitude = obj.Magnitude
	local ESP_Player
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["TextScaled"] = true
	obj.TextColor3 = val
	local _Name = obj.Name
	obj.name = val
	local ESP_Distance
	obj.FillColor = val
	obj.OutlineColor = val
	local ESP_Outline
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_Name
	obj.KE_Text = val
	local _math = obj.math
	local _floor = obj.floor
	local _Position = obj.Position
	obj.distance = val
	obj.color = val
	obj.icon = val
	obj["Name"] = "WarnText"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.BillboardGui = val
	obj.KEH = val
	local ESP_Master
	local _getItemIcon = obj.getItemIcon
	obj["Text"] = "!!"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _GetRole = obj.GetRole
	obj:Survivor()
	obj.PEH = val
	local _Character = obj.Character
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Head = val
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO81(val)
	local _Parent = obj.Parent
	obj.FillColor = val
	obj.OutlineColor = val
	local ESP_Outline
	local _PrimaryPart = obj.PrimaryPart
	obj.Humanoid = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local ESP_Master
	obj:FindFirstChild()
	obj.SCPEH = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_SCP
	local _ipairs = obj.ipairs
	local SCPs
	local _WalkSpeed = obj.WalkSpeed
	local Colors
	local _SCP = obj.SCP
	obj:FindFirstChild()
	obj.SCPEH = val
	local _Health = obj.Health
	obj["Name"] = "SCPEH"
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Highlight = val
	obj:FindFirstChild()
	obj.Torso = val
	local _ClearESP = obj.ClearESP
	obj.SCP = val
	obj:Destroy()
end

local function PROTO82(val)
	local _r = GodMode
end

local function PROTO83(val)
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	Ambient = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	OutdoorAmbient = val
	local _FullBright = obj.FullBright
	local _TimeOfDayValue = obj.TimeOfDayValue
	ClockTime = val
end

local function PROTO84(val)
	FogColor = val
	local _Color3 = obj.Color3
	obj.Atmosphere = val
	local _NoFog = obj.NoFog
	local _fromRGB = obj.fromRGB
	obj["Density"] = 0
	obj["Offset"] = 0
	obj["Glare"] = 0
	obj["Haze"] = 0
end

local function PROTO85(val)
	GlobalShadows = val
end

local function PROTO86(val)
	obj["Description"] = "Gagal memuat Mask Selector!"
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "GUI Mask Selector berhasil dimuat!"
	obj["Time"] = 3
	local _pcall = obj.pcall
	local _cb = PROTO87
	obj["Title"] = "Mask Selector"
end

local function PROTO87(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://pastefy.app/nJrAelfC/raw"
end

local function PROTO88(val)
	obj:GetAttribute()
	obj.IsHooked = val
	obj:GetAttribute()
	obj.Knocked = val
end

local function PROTO89(val)
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local Character
	local _huge = obj.huge
	obj:FindFirstChild()
end

local function PROTO90(val)
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO91(val)
	GateClientModule = val
	local _require = obj.require
	local _game = obj.game
	obj:GetService()
	obj.ReplicatedStorage = val
	local _Modules = obj.Modules
end

local function PROTO92(val)
	local _typeof = obj.typeof
	obj:table()
	local _rawget = obj.rawget
	obj.gateDuration = val
	local _rawset = obj.rawset
	obj.gateDuration = val
	local _getgc = obj.getgc
	local _rawget = obj.rawget
	obj.gateRemote = val
end

local function PROTO93(val)
	local GateClientModule
	local _CanUse = obj.CanUse
	oldGateCanUse = val
	local _cb = PROTO94
	local _new = obj.new
	oldGateNew = val
	local oldGateNew
	local oldGateCanUse
	local _cb = PROTO95
end

local function PROTO94(val)
	local _lastUse = obj.lastUse
	local _currentCooldown = obj.currentCooldown
	local _isBuffering = obj.isBuffering
	local _os = obj.os
	local _clock = obj.clock
	local oldGateCanUse
	local InstantTPGate
	local _isSilenced = obj.isSilenced
end

local function PROTO95(val)
	local oldGateNew
	local InstantTPGate
	obj["gateDuration"] = 0
end

local function PROTO96(val)
	Thickness = val
end

local function PROTO97(val)
	obj:GetAttribute()
	obj.Sprinting = val
	local Character
	obj:GetAttribute()
end

local function PROTO98(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO99
end

local function PROTO99(val)
	local _getgenv = obj.getgenv
	local _AutoRunMobileEnabled = obj.AutoRunMobileEnabled
	local _task = obj.task
end

local function PROTO100(val)
	local _getgenv = obj.getgenv
end

local function PROTO101(val)
	obj.Nonaktif = val
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Gagal load. Coba lagi."
	obj["Time"] = 3
	local _cb = PROTO102
	local _Library = obj.Library
	obj:Notify()
	obj.Aktif = val
	local _task = obj.task
	local _wait = obj.wait
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Invisibility"
	local IsActive
	obj:Notify()
	obj["Title"] = "Invisibility"
	local _pcall = obj.pcall
	local _cb = PROTO103
	obj["Time"] = 2
	obj["Title"] = "Invisibility"
	obj["Description"] = "Loading..."
	obj["Time"] = 2
	IsActive = val
	local _pcall = obj.pcall
	local _cb = PROTO104
	obj["Description"] = "Masih loading..."
	obj["Time"] = 2
	local _pcall = obj.pcall
end

local function PROTO102(val)
	local _Invis_Gacor = obj.Invis_Gacor
	obj:SetValue()
	local IsActive
	local _Toggles = obj.Toggles
	local _Invis_Gacor = obj.Invis_Gacor
	local _Toggles = obj.Toggles
end

local function PROTO103(val)
	local _disable = obj.disable
end

local function PROTO104(val)
	local _enable = obj.enable
end

local function PROTO105(val)
	local Gui
	obj:Destroy()
	Gui = val
	obj["Name"] = "InvisCustomGui"
	obj["IgnoreGuiInset"] = true
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.CornerRadius = val
	local _cb = PROTO106
	local _InputBegan = obj.InputBegan
	obj:Connect()
	obj.Position = val
	obj:Connect()
	local _cb = PROTO107
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _new = obj.new
	local _new = obj.new
	obj.UIStroke = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _cb = PROTO108
	local _InputEnded = obj.InputEnded
	obj:Connect()
	obj.TextColor3 = val
	obj["Name"] = "ActionButton"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Size = val
	obj["Text"] = "INVIS [OFF]"
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj["Active"] = true
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["TextSize"] = 12
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Parent = val
	Gui = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	local _Enum = obj.Enum
	local _ZIndexBehavior = obj.ZIndexBehavior
	local _Sibling = obj.Sibling
	obj.ZIndexBehavior = val
	obj["Name"] = "UIStroke"
	obj.Parent = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj["Transparency"] = 0.2
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "Frame"
	obj.Parent = val
	local _UDim2 = obj.UDim2
	local _fromOffset = obj.fromOffset
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _fromScale = obj.fromScale
	local _cb = PROTO110
	local InputChanged
	local _new = obj.new
	obj.TextButton = val
	obj.Color = val
end

local function PROTO106(val)
	Position = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	-- str: "X"
	local _math = obj.math
	local _abs = obj.abs
	-- str: "Y"
	local _Position = obj.Position
	local _Scale = obj.Scale
	-- str: "X"
	local _Offset = obj.Offset
	-- str: "X"
	-- str: "Y"
	local _Scale = obj.Scale
	-- str: "Y"
	local _Offset = obj.Offset
	-- str: "Y"
	local _math = obj.math
	local _abs = obj.abs
	-- str: "X"
end

local function PROTO107(val)
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseMovement = obj.MouseMovement
end

local function PROTO108(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _Position = obj.Position
	local Position
	local _delay = obj.delay
	local _cb = PROTO109
	local _task = obj.task
	local _cancel = obj.cancel
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
end

local function PROTO109(val)
	-- (no semantic content extracted)
end

local function PROTO110(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _task = obj.task
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
end

local function PROTO111(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO112(val)
	Color = val
end

local function PROTO113(val)
	local _new = obj.new
	obj.CylinderHandleAdornment = val
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj["Name"] = "AutoParryCircleESP"
	local _MaxHealth = obj.MaxHealth
	obj.Health = val
	local Character
	local ESP_Generator
	local _UpdateStaticESP = obj.UpdateStaticESP
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj.CFrame = val
	obj.Parent = val
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj["ZIndex"] = 0
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _Parent = obj.Parent
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj:Destroy()
	local _CFrame = obj.CFrame
	local _SpeedInputValue = obj.SpeedInputValue
	local _CFrame = obj.CFrame
	local _SpeedAmount = obj.SpeedAmount
	local _UpdateSCPESP = obj.UpdateSCPESP
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj:Destroy()
	local _TargetFOV = obj.TargetFOV
	FieldOfView = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local ESP_Name
	local Surv_ParryRadius
	obj.Radius = val
	local _FleeKillerEnabled = obj.FleeKillerEnabled
	local _UpdatePlayerESP = obj.UpdatePlayerESP
	local _GodMode = obj.GodMode
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _new = obj.new
	local _FleeKiller = obj.FleeKiller
	local _Health = obj.Health
	local _MaxHealth = obj.MaxHealth
	local ESP_KillerWarn
	local _WalkSpeed = obj.WalkSpeed
	local Surv_ParryAggressive
	local ESP_Killer
	local Surv_ParryCircle
	obj.Color3 = val
	obj["WalkSpeed"] = 16
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj["Height"] = 0.05
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _SpeedInputEnabled = obj.SpeedInputEnabled
	local ESP_ItemIcon
	local _MoveDirection = obj.MoveDirection
	local _Magnitude = obj.Magnitude
	local ESP_Gate
	local _SpeedEnabled = obj.SpeedEnabled
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local ESP_Window
	local ESP_Pallet
	local _GetRole = obj.GetRole
	obj:Killer()
	local _MoveDirection = obj.MoveDirection
	local _Magnitude = obj.Magnitude
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _NoSlowdownEnabled = obj.NoSlowdownEnabled
	local _Angles = obj.Angles
	local _math = obj.math
	local _rad = obj.rad
	obj.CFrame = val
	local _ParryCooldown = obj.ParryCooldown
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _math = obj.math
	local _max = obj.max
	obj.CFrame = val
	local _AutoParryAdornment = obj.AutoParryAdornment
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["Transparency"] = 0.3
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj.Adornee = val
	local _AutoParryAdornment = obj.AutoParryAdornment
	local ESP_Player
	obj.InnerRadius = val
	local _AutoParryAdornment = obj.AutoParryAdornment
	obj.Color3 = val
	local _FOVEnabled = obj.FOVEnabled
	obj.Color3 = val
	local ESP_Hook
	local ESP_SCP
	local _CFrame = obj.CFrame
end

local function PROTO114(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO115(val)
	Surv_AutoCrouch = val
end

local function PROTO116(val)
	local _ClearESP = obj.ClearESP
	ESP_Generator = val
	local ESP_Master
end

local function PROTO117(val)
	obj:Stop()
	obj:Notify()
	obj["Title"] = "Sus R6"
	obj["Description"] = "Pilih target dulu!"
	obj["Time"] = 3
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Animation = val
	obj["AnimationId"] = "rbxassetid://189854234"
	obj:LoadAnimation()
	local _r = susAnimTrack
	local _susAnimTrack = obj.susAnimTrack
	obj:Play()
	local Character
	local _r = susCoroutine
	local SusR6Toggle
	obj:SetValue()
	obj:FindFirstChildOfClass()
	local _coroutine = obj.coroutine
	local _wrap = obj.wrap
	local _cb = PROTO118
	local _r = susAnimTrack
	local _r = susCoroutine
	local _susAnimTrack = obj.susAnimTrack
	local _r = SusR6Enabled
end

local function PROTO118(val)
	local _TweenInfo = obj.TweenInfo
	obj.CFrame = val
	obj:Play()
	obj:Create()
	local _TweenInfo = obj.TweenInfo
	local _new = obj.new
	obj.CFrame = val
	obj:Play()
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _Character = obj.Character
	local _CFrame = obj.CFrame
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _CFrame = obj.CFrame
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _Character = obj.Character
	obj:FindFirstChild()
	local _task = obj.task
	local _wait = obj.wait
	local _SusR6Enabled = obj.SusR6Enabled
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO119(val)
	local _print = obj.print
	-- str: "🔄 Stun re-setup setelah respawn"
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO120(val)
	local _Character = obj.Character
	local _Character = obj.Character
	obj.HumanoidRootPart = val
	local _IsKiller = obj.IsKiller
	local _print = obj.print
	local _Name = obj.Name
	-- str: "🔄 Stun re-applied for: "
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	obj:FindFirstChild()
	obj.StunUI = val
	local _Character = obj.Character
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO121(val)
	Enabled = val
end

local function PROTO122(val)
	local _StopSpectatorInfo = obj.StopSpectatorInfo
	local _StartSpectatorInfo = obj.StartSpectatorInfo
end

local function PROTO123(val)
	local _setfpscap = obj.setfpscap
	local _setfpscap = obj.setfpscap
	local FPSCapToggle
	obj:SetValue()
end

local function PROTO124(val)
	local _autoReconnect = obj.autoReconnect
	obj:Teleport()
	local _game = obj.game
	local _Failed = obj.Failed
	local _Enum = obj.Enum
	local _TeleportState = obj.TeleportState
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO125(val)
	Killer_Aimbot_Enabled = val
end

local function PROTO126(val)
	local _r = AutoPalletSafety
end

local function PROTO127(val)
	local _palletIndex = obj.palletIndex
	local Pallets
	obj:FindFirstChild()
	obj.PrimaryPartPallet = val
	local _TeleportToPart = obj.TeleportToPart
	local _ScanMap = obj.ScanMap
	local _palletIndex = obj.palletIndex
	local _r = palletIndex
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	local _palletIndex = obj.palletIndex
end

local function PROTO128(val)
	-- (no semantic content extracted)
end

local function PROTO129(val)
	obj["ZIndex"] = 11
	local _BypassButton = obj.BypassButton
	obj.Parent = val
	local _BypassButton = obj.BypassButton
	obj.BackgroundColor3 = val
	local _BypassButton = obj.BypassButton
	obj["BackgroundTransparency"] = 0.15
	local _BypassButton = obj.BypassButton
	obj["AutoButtonColor"] = true
	local _BypassButton = obj.BypassButton
	local _BypassButton = obj.BypassButton
	obj["ZIndex"] = 10
	local _BypassButton = obj.BypassButton
	obj:Destroy()
	obj.ImageButton = val
	local _r = BypassButton
	local _BypassButton = obj.BypassButton
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj.Visible = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	local TouchEnabled
	obj.Size = val
	local _BypassButton = obj.BypassButton
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _BypassUI = obj.BypassUI
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj:FindFirstChild()
	obj.BypassGenUI = val
	obj.CornerRadius = val
	local _BypassButton = obj.BypassButton
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextLabel = val
	local _new = obj.new
	local KeyboardEnabled
	obj["IgnoreGuiInset"] = true
	local _BypassUI = obj.BypassUI
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextColor3 = val
	obj["TextScaled"] = true
	local _Enum = obj.Enum
	obj.Position = val
	local _BypassButton = obj.BypassButton
	local _Vector2 = obj.Vector2
	local _new = obj.new
	obj["Name"] = "BypassGenButton"
	local _BypassButton = obj.BypassButton
	local _new = obj.new
	local _r = BypassUI
	local _BypassUI = obj.BypassUI
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.4
	local _BypassButton = obj.BypassButton
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	local _BypassButton = obj.BypassButton
	local _fromRGB = obj.fromRGB
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "GEN"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["Name"] = "BypassGenUI"
	local _BypassUI = obj.BypassUI
	local _BypassUI = obj.BypassUI
end

local function PROTO130(val)
	local _pcall = obj.pcall
	local _cb = PROTO131
	local _cb = PROTO132
	local _task = obj.task
	local _wait = obj.wait
	local _ProcessedGens = obj.ProcessedGens
	local _GetGeneratorPoints = obj.GetGeneratorPoints
	local _StartAutoRepairLoop = obj.StartAutoRepairLoop
	local _ProcessedGens = obj.ProcessedGens
	local Character
	local _CFrame = obj.CFrame
	local _cb = PROTO133
	local _pcall = obj.pcall
	local _Parent = obj.Parent
	local _ProcessedGens = obj.ProcessedGens
	-- namecall: "Manual Repair"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _BypassGenMode = obj.BypassGenMode
	-- namecall: "Auto Repair"
end

local function PROTO131(val)
	-- (no semantic content extracted)
end

local function PROTO132(val)
	CFrame = val
	local Parent
end

local function PROTO133(val)
	local _cb = PROTO134
	local _waitForRepairing = obj.waitForRepairing
	local _wait = obj.wait
	local _pcall = obj.pcall
	local _wait = obj.wait
	local _pcall = obj.pcall
	local _cb = PROTO135
	local _waitForRepairing = obj.waitForRepairing
	CFrame = val
	local _task = obj.task
	local _wait = obj.wait
	CFrame = val
	local _task = obj.task
	local _pcall = obj.pcall
	local _cb = PROTO136
	local _task = obj.task
	local _wait = obj.wait
	local _Parent = obj.Parent
end

local function PROTO134(val)
	obj:FireServer()
end

local function PROTO135(val)
	obj:FireServer()
end

local function PROTO136(val)
	obj:FireServer()
end

local function PROTO137(val)
	local _pcall = obj.pcall
	local _cb = PROTO138
	local _ParryCooldown = obj.ParryCooldown
end

local function PROTO138(val)
	obj:FindFirstChild()
	obj.Items = val
	local _task = obj.task
	local _game = obj.game
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:FindFirstChild()
	obj.Remotes = val
	obj:FireServer()
	obj:FindFirstChild()
	obj.parry = val
	obj:FindFirstChild()
	-- str: "Parrying Dagger"
end

local function PROTO139(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO140
end

local function PROTO140(val)
	local _OnClientEvent = obj.OnClientEvent
	obj:Connect()
	local _cb = PROTO141
	obj:WaitForChild()
	obj.Remotes = val
	obj:WaitForChild()
	obj:WaitForChild()
	local _game = obj.game
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:WaitForChild()
	-- str: "Parrying Dagger"
end

local function PROTO141(val)
	local _task = obj.task
	local _ParryCooldownThread = obj.ParryCooldownThread
	local _task = obj.task
	local _delay = obj.delay
	local _cb = PROTO142
	local _ParryCooldownThread = obj.ParryCooldownThread
	local _tonumber = obj.tonumber
end

local function PROTO142(val)
	-- (no semantic content extracted)
end

local function PROTO143(val)
	obj:Notify()
	local _pcall = obj.pcall
	local _cb = PROTO144
	obj:IsA()
	obj.BasePart = val
	local _Name = obj.Name
	obj:PalletPointSlide()
	local _Name = obj.Name
	obj:PalletPointSlideInUse()
	local _game = obj.game
	obj:GetService()
	obj.ReplicatedStorage = val
	local _Remotes = obj.Remotes
	local _Window = obj.Window
	local _VaultCompleteEvent = obj.VaultCompleteEvent
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO145
	local _Name = obj.Name
	obj:VaultPointInUse()
	-- str: "_G"
	obj.BlockPalletEnabled = val
	obj["Title"] = "Anti Looping"
	obj["Description"] = "✅ Aktif!"
	obj["Time"] = 2
	obj:GetService()
	obj.ReplicatedStorage = val
	local _Remotes = obj.Remotes
	local _Pallet = obj.Pallet
	local _pairs = obj.pairs
	obj:GetDescendants()
	local _pairs = obj.pairs
	obj:GetDescendants()
	obj.ReplicatedStorage = val
	local _Remotes = obj.Remotes
	local _Pallet = obj.Pallet
	local _PalletSlideEvent = obj.PalletSlideEvent
	local _pcall = obj.pcall
	local _cb = PROTO150
	local _Remotes = obj.Remotes
	local _Window = obj.Window
	local _VaultEvent = obj.VaultEvent
	local _game = obj.game
	obj:GetService()
	obj:FindFirstChild()
	obj.Map = val
	local _pcall = obj.pcall
	local _cb = PROTO151
	local _pcall = obj.pcall
	local _cb = PROTO152
	local _Name = obj.Name
	obj:VaultTrigger()
	local _game = obj.game
	obj:GetService()
	obj.ReplicatedStorage = val
	local _PalletSlideCompleteEvent = obj.PalletSlideCompleteEvent
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
end

local function PROTO144(val)
	obj:FireServer()
	local Parent
end

local function PROTO145(val)
	obj:Disconnect()
	-- str: "_G"
	local _BlockPalletEnabled = obj.BlockPalletEnabled
	local _task = obj.task
	local _wait = obj.wait
	local _watchPallet = obj.watchPallet
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	local _cb = PROTO146
	local _r = watchPallet
	local _pairs = obj.pairs
	local _pairs = obj.pairs
	local _DescendantAdded = obj.DescendantAdded
	obj:Connect()
	local _cb = PROTO149
	local _table = obj.table
	local _insert = obj.insert
	obj:GetDescendants()
end

local function PROTO146(val)
	local _table = obj.table
	local _insert = obj.insert
	obj:GetPropertyChangedSignal()
	obj.Name = val
	obj:Connect()
	obj:IsA()
	local _Name = obj.Name
	obj:PalletPoint()
end

local function PROTO147(val)
	local Name
	obj:PalletPointSlide()
	local _task = obj.task
	local _wait = obj.wait
	local _pcall = obj.pcall
	-- str: "_G"
	local _BlockPalletEnabled = obj.BlockPalletEnabled
end

local function PROTO148(val)
	obj:FireServer()
end

local function PROTO149(val)
	local _watchPallet = obj.watchPallet
end

local function PROTO150(val)
	obj:FireServer()
	local Parent
end

local function PROTO151(val)
	obj:FireServer()
end

local function PROTO152(val)
	obj:FireServer()
end

local function PROTO153(val)
	local _CreateKillerPerksGUI = obj.CreateKillerPerksGUI
	local _pcall = obj.pcall
	local _cb = PROTO154
end

local function PROTO154(val)
	obj:Destroy()
end

local function PROTO155(val)
	-- str: "Y"
	local _Magnitude = obj.Magnitude
	obj:Killer()
	local _IsKiller = obj.IsKiller
	obj:Killer()
	local _Health = obj.Health
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.Humanoid = val
	local Surv_Aimbot_MaxDist
	obj:Survivor()
	obj:WorldToViewportPoint()
	obj:Survivor()
	local _pairs = obj.pairs
	obj:GetPlayers()
	local ViewportSize
	-- str: "Y"
	local _new = obj.new
	-- str: "X"
	local _GetRole = obj.GetRole
	local Killer_Aimbot_MaxDist
	local Surv_Aimbot_Radius
	local _math = obj.math
	local _huge = obj.huge
	local _IsKiller = obj.IsKiller
	local _Character = obj.Character
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	local _Character = obj.Character
	local _IsDowned = obj.IsDowned
	local _Character = obj.Character
	local Killer_Aimbot_Enabled
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Surv_Aimbot_Enabled
	local _Vector2 = obj.Vector2
	local _new = obj.new
	-- str: "X"
end

local function PROTO156(val)
	MaxJitterStuds = val
	obj:Notify()
	-- str: " studs"
end

local function PROTO157(val)
	obj["Title"] = "Invis GUI"
	obj["Description"] = "Gui Loaded"
	obj["Time"] = 2
	obj:Notify()
	local _pcall = obj.pcall
	local _cb = PROTO158
	local _pcall = obj.pcall
	local _cb = PROTO159
	local Gui
	obj["Enabled"] = true
	obj:Notify()
	obj["Title"] = "Invis GUI"
	obj["Description"] = "Gui Destroyed"
	obj["Time"] = 2
end

local function PROTO158(val)
	local _disable = obj.disable
end

local function PROTO159(val)
	local Invis_Gacor
	obj:SetValue()
end

local function PROTO160(val)
	Style = val
	-- str: "created"
end

local function PROTO161(val)
	OffsetY = val
end

local function PROTO162(val)
	local _Team = obj.Team
	local _Team = obj.Team
end

local function PROTO163(val)
	local _Team = obj.Team
	local _Team = obj.Team
	local _Name = obj.Name
end

local function PROTO164(val)
	local _StopNextKiller = obj.StopNextKiller
	local _StartNextKiller = obj.StartNextKiller
end

local function PROTO165(val)
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Killer()
	obj:FindFirstChild()
	local _Character = obj.Character
	obj.HumanoidRootPart = val
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _Character = obj.Character
	local _math = obj.math
	local _huge = obj.huge
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	local _math = obj.math
	local _huge = obj.huge
	local Character
end

local function PROTO166(val)
	local _FleeDistance = obj.FleeDistance
	local Character
	local _Position = obj.Position
	local _Position = obj.Position
	local _Unit = obj.Unit
	local _new = obj.new
	obj.CFrame = val
	local _tick = obj.tick
	local _r = FleeCooldown
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _FleeKillerEnabled = obj.FleeKillerEnabled
	local _tick = obj.tick
	local _FleeCooldown = obj.FleeCooldown
	local _Character = obj.Character
	local _GetNearestKiller = obj.GetNearestKiller
	obj:FindFirstChild()
	local _Position = obj.Position
	local _CFrame = obj.CFrame
end

local function PROTO167(val)
	local _ForceRefreshMap = obj.ForceRefreshMap
end

local function PROTO168(val)
	LerpSmoothness = val
	obj:Notify()
end

local function PROTO169(val)
	local _r = stateManager
end

local function PROTO170(val)
	local _MoonwalkEnabled = obj.MoonwalkEnabled
	obj.BackgroundColor3 = val
	local _MoonwalkButton = obj.MoonwalkButton
	obj["BackgroundTransparency"] = 0.1
	local _MoonwalkButton = obj.MoonwalkButton
	obj["ZIndex"] = 10
	obj["ZIndex"] = 10
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["Text"] = "MOON"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj.BackgroundColor3 = val
	local _MoonwalkButton = obj.MoonwalkButton
	obj["BackgroundTransparency"] = 0.15
	local _MoonwalkButton = obj.MoonwalkButton
	obj.TextColor3 = val
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkButton = obj.MoonwalkButton
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _MoonwalkButton = obj.MoonwalkButton
	obj:FindFirstChild()
	obj.MoonwalkLabel = val
end

local function PROTO171(val)
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Moonwalk"
	local _UpdateMoonwalkStatus = obj.UpdateMoonwalkStatus
	local _MoonwalkEnabled = obj.MoonwalkEnabled
	local _MoonwalkEnabled = obj.MoonwalkEnabled
	local _r = MoonwalkEnabled
	local _MoonwalkEnabled = obj.MoonwalkEnabled
	obj["Description"] = "OFF"
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Moonwalk"
	obj["Time"] = 2
end

local function PROTO172(val)
	obj:Notify()
	obj["Title"] = "No Slowdown"
	obj["Description"] = "AKTIF - WalkSpeed dikunci"
	local _r = NoSlowdownEnabled
	obj:Notify()
	obj["Title"] = "No Slowdown"
	obj["Description"] = "DIMATIKAN"
	obj["Time"] = 2
end

local function PROTO173(val)
	local InfFrenzy
	obj:SetValue()
	local _pcall = obj.pcall
	local _NEX_StartJeffCooldownBypass = obj.NEX_StartJeffCooldownBypass
	local _pcall = obj.pcall
	local _NEX_StopJeffCooldownBypass = obj.NEX_StopJeffCooldownBypass
	KILLER_InfFrenzy = val
end

local function PROTO174(val)
	local _setfpscap = obj.setfpscap
	obj:Notify()
	obj["Title"] = "FPS Cap"
	-- str: " FPS"
	obj["Time"] = 1
end

local function PROTO175(val)
	obj:Disconnect()
	local Character
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
end

local function PROTO176(val)
	obj:FindFirstChildOfClass()
	local Character
	local _print = obj.print
	-- str: "✅ Moonwalk aktif (via main RenderStepped)"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO177(val)
	local Colors
	obj.Hook = val
end

local function PROTO178(val)
	obj.Position = val
	local _Vector2 = obj.Vector2
	local _new = obj.new
	obj.AnchorPoint = val
	local _Color3 = obj.Color3
	obj["Name"] = "Text"
	local _Enum = obj.Enum
	local _AutomaticSize = obj.AutomaticSize
	local _subtext = obj.subtext
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamMedium = obj.GothamMedium
	obj.Font = val
	obj["TextSize"] = 10
	obj["ZIndex"] = 3
	obj["LayoutOrder"] = 2
	obj["RichText"] = true
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	local _icon = obj.icon
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIGradient = val
	obj["Rotation"] = 90
	local _NumberSequence = obj.NumberSequence
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _Center = obj.Center
	local _Enum = obj.Enum
	obj.Size = val
	obj["ZIndex"] = 3
	obj["LayoutOrder"] = 1
	local _subtext = obj.subtext
	obj.Text = val
	local _offsetY = obj.offsetY
	local _Line = obj.Line
	local _color = obj.color
	obj.BackgroundColor3 = val
	local _Box = obj.Box
	obj:FindFirstChild()
	obj.Icon = val
	local _icon = obj.icon
	local _new = obj.new
	local _LayoutOrder = obj.LayoutOrder
	obj.SortOrder = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIGradient = val
	local _fromRGB = obj.fromRGB
	obj.Transparency = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIPadding = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.ImageLabel = val
	obj["BorderSizePixel"] = 0
	obj["ZIndex"] = 2
	obj.Parent = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0
	local _new = obj.new
	obj.AnchorPoint = val
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
	obj["BorderSizePixel"] = 0
	obj["ZIndex"] = 1
	obj.Parent = val
	local _Instance = obj.Instance
	obj.Parent = val
	local _Box = obj.Box
	local _Text = obj.Text
	local _string = obj.string
	local _string = obj.string
	local _format = obj.format
	-- str: "#%02X%02X%02X"
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _TextYAlignment = obj.TextYAlignment
	local _Center = obj.Center
	obj.TextYAlignment = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "Line"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Name = val
	obj.Parent = val
	obj["AlwaysOnTop"] = true
	local _UDim2 = obj.UDim2
	-- str: "<font color='#FFFFFF'>%s</font> <font color='%s'>[%dm]</font>"
	local _name = obj.name
	local _distance = obj.distance
	obj.Text = val
	obj.StudsOffset = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "Box"
	local _Enum = obj.Enum
	local _Center = obj.Center
	local _VerticalAlignment = obj.VerticalAlignment
	local _Center = obj.Center
	obj.VerticalAlignment = val
	local _NumberSequence = obj.NumberSequence
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	obj["Name"] = "Icon"
	local _UDim2 = obj.UDim2
	obj.PaddingLeft = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _Text = obj.Text
	local _string = obj.string
	local _format = obj.format
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	local _color = obj.color
	-- str: "R"
	local _new = obj.new
	obj.Transparency = val
	obj.Text = val
	local _Box = obj.Box
	local _Text = obj.Text
	local _string = obj.string
	local _format = obj.format
	-- str: "<font color='#FFFFFF'>%s</font>"
	local _name = obj.name
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIListLayout = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.BillboardGui = val
	local _new = obj.new
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.HorizontalAlignment = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Padding = val
	local _Enum = obj.Enum
	local _SortOrder = obj.SortOrder
	-- str: "B"
	-- str: "X"
	obj.AutomaticSize = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _icon = obj.icon
	obj.Image = val
	obj["Visible"] = true
	local _Enum = obj.Enum
	local _AutomaticSize = obj.AutomaticSize
	-- str: "X"
	obj.AutomaticSize = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _color = obj.color
	-- str: "G"
	local _color = obj.color
	local _format = obj.format
	-- str: "<font color='#FFFFFF'>%s</font> <font color='%s'>%s</font>"
	local _name = obj.name
	local _Enum = obj.Enum
	local _FillDirection = obj.FillDirection
	local _Horizontal = obj.Horizontal
	obj.FillDirection = val
	local _Enum = obj.Enum
	obj:FindFirstChild()
	obj.Position = val
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
end

local function PROTO179(val)
	local _Parent = obj.Parent
	obj:Generator()
	obj:SCP()
	obj:Pallet()
	local _Parent = obj.Parent
	local _PalletEH = obj.PalletEH
	obj:Destroy()
	local _Character = obj.Character
	local _model = obj.model
	local _GE_Text = obj.GE_Text
	obj:Destroy()
	obj:FindFirstChild()
	obj.PalletEH = val
	local _Character = obj.Character
	local _PEH = obj.PEH
	obj:Destroy()
	local _pairs = obj.pairs
	local SCPs
	local _Character = obj.Character
	local _KE_Text = obj.KE_Text
	obj:Destroy()
	obj:Gate()
	local _pairs = obj.pairs
	obj:GetPlayers()
	local _pairs = obj.pairs
	local Windows
	obj:FindFirstChild()
	obj.HookEH = val
	local _KEH = obj.KEH
	obj:Destroy()
	local _HookEH = obj.HookEH
	obj:Destroy()
	local _Parent = obj.Parent
	obj:FindFirstChild()
	obj.GateEH = val
	obj:Hook()
	obj:Killer()
	local _Character = obj.Character
	obj:FindFirstChild()
	local _model = obj.model
	obj:FindFirstChild()
	obj.GE_Text = val
	obj:Window()
	local _GEH = obj.GEH
	obj:Destroy()
	local _model = obj.model
	obj:FindFirstChild()
	obj.GEH = val
	local _Character = obj.Character
	local _PE_Text = obj.PE_Text
	obj:Destroy()
	local _SCPEH = obj.SCPEH
	obj:Destroy()
	local _pairs = obj.pairs
	local Hooks
	local _model = obj.model
	local _Parent = obj.Parent
	obj:Player()
	obj:FindFirstChild()
	local _WindowEH = obj.WindowEH
	obj:Destroy()
	local _pairs = obj.pairs
	local Generators
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.PEH = val
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.KE_Text = val
	local _pairs = obj.pairs
	local Pallets
	obj:GetPlayers()
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.KEH = val
	local _GateEH = obj.GateEH
	obj:Destroy()
	obj:FindFirstChild()
	local _Parent = obj.Parent
	local _Character = obj.Character
	local _pairs = obj.pairs
	local Gates
end

local function PROTO180(val)
	local _Team = obj.Team
	local Attach
	local _Character = obj.Character
	local _Character = obj.Character
	local _Name = obj.Name
	obj:Killer()
end

local function PROTO181(val)
	OffsetX = val
end

local function PROTO182(val)
	local _ClearESP = obj.ClearESP
	obj.Killer = val
	local _ScanMap = obj.ScanMap
	ESP_Killer = val
	local ESP_Master
end

local function PROTO183(val)
	local Gui
	obj:FindFirstChild()
	obj.Frame = val
	obj.Color = val
	obj.BackgroundColor3 = val
	obj.Color = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	local _Color3 = obj.Color3
	obj.ActionButton = val
	obj:FindFirstChild()
	local _fromRGB = obj.fromRGB
	local _Color3 = obj.Color3
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	obj["Text"] = "BYPASS [OFF]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _fromRGB = obj.fromRGB
	local _fromRGB = obj.fromRGB
end

local function PROTO184(val)
	local _ClearESP = obj.ClearESP
	obj.Window = val
	local _ScanMap = obj.ScanMap
	ESP_Window = val
	local ESP_Master
end

local function PROTO185(val)
	Misc_FakeName = val
	local _enableSpoofer = obj.enableSpoofer
	local _disableSpoofer = obj.disableSpoofer
end

local function PROTO186(val)
	obj:Connect()
	obj:WaitForChild()
	obj.Animator = val
	local _cb = PROTO187
	local _AnimationPlayed = obj.AnimationPlayed
	local _cb = PROTO188
	obj:WaitForChild()
	obj.Humanoid = val
	obj:Connect()
	local _cb = PROTO190
	obj:FindFirstChild()
	obj.Humanoid = val
	obj:FindFirstChildOfClass()
	obj.Animator = val
end

local function PROTO187(val)
	-- (no semantic content extracted)
end

local function PROTO188(val)
	local _IsSafeToParry = obj.IsSafeToParry
	local Surv_ParryRadius
	local Surv_AutoCrouch
	local _ExecuteParry = obj.ExecuteParry
	local _Animation = obj.Animation
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _LookVector = obj.LookVector
	-- str: "X"
	local Character
	local _IsDowned = obj.IsDowned
	local Surv_ParryAggressive
	local _IsDowned = obj.IsDowned
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _CFrame = obj.CFrame
	obj:Dot()
	local Surv_ParryFace
	local _Vector3 = obj.Vector3
	local _Position = obj.Position
	local _Position = obj.Position
	-- str: "Z"
	local _Magnitude = obj.Magnitude
	local _TriggerCrouch = obj.TriggerCrouch
	obj:FindFirstChild()
	local Ignored_Skills_List
	-- str: "match"
	-- str: "%d+"
	local _os = obj.os
	local _clock = obj.clock
	local _CFrame = obj.CFrame
	local _LookVector = obj.LookVector
	-- str: "Z"
	local _Unit = obj.Unit
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	-- namecall: "80411309607666"
	local _ParryCooldown = obj.ParryCooldown
	-- str: "Z"
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _Position = obj.Position
	-- str: "X"
	-- str: "X"
	local _Position = obj.Position
	obj.HumanoidRootPart = val
	obj:Connect()
	local _cb = PROTO189
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _Animation = obj.Animation
	local _AnimationId = obj.AnimationId
	local Surv_AutoParry
end

local function PROTO189(val)
	local _IsDowned = obj.IsDowned
	local _os = obj.os
	local _clock = obj.clock
	local _ExecuteParry = obj.ExecuteParry
	obj:Disconnect()
	local _ParryCooldown = obj.ParryCooldown
	obj:Disconnect()
	local Position
	local _Magnitude = obj.Magnitude
end

local function PROTO190(val)
	obj:IsA()
	obj.Animator = val
	local _AttachParrySensor = obj.AttachParrySensor
end

local function PROTO191(val)
	local _Character = obj.Character
	local _IsKiller = obj.IsKiller
	local _Character = obj.Character
end

local function PROTO192(val)
	local _setreadonly = obj.setreadonly
	-- str: "__namecall"
	local _newcclosure = obj.newcclosure
	-- str: "__namecall"
	local _setreadonly = obj.setreadonly
	local _getrawmetatable = obj.getrawmetatable
	local _game = obj.game
	local _setreadonly = obj.setreadonly
	local _pcall = obj.pcall
	local _cb = PROTO195
	-- str: "[SpearInterceptor]: Executor tidak support getrawmetatable atau setreadonly."
	local _getrawmetatable = obj.getrawmetatable
end

local function PROTO193(val)
	local SpearSmart_enable
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	-- str: "Z"
	local _Magnitude = obj.Magnitude
	local _math = obj.math
	local _max = obj.max
	local _checkcaller = obj.checkcaller
	local _Parent = obj.Parent
	obj:FindFirstChildOfClass()
	local _math = obj.math
	obj:IsA()
	obj.Model = val
	local _getClosestSurvivor = obj.getClosestSurvivor
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local SPEAR_Speed
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _typeof = obj.typeof
	obj:Instance()
	obj:GetAttribute()
	obj.special = val
	local Aim_SilentVeilV2
	obj:FindFirstChild()
	obj.Head = val
	local _Position = obj.Position
	local _math = obj.math
	local _clamp = obj.clamp
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local Character
	local _workspace = obj.workspace
	local _Gravity = obj.Gravity
	local _MoveDirection = obj.MoveDirection
	local _Magnitude = obj.Magnitude
	local _Unit = obj.Unit
	local _Parent = obj.Parent
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _max = obj.max
	local AIM_Auto
	local _workspace = obj.workspace
	local _Gravity = obj.Gravity
	local _ClassName = obj.ClassName
	obj:RemoteEvent()
	local _AssemblyLinearVelocity = obj.AssemblyLinearVelocity
	local _WalkSpeed = obj.WalkSpeed
	obj:IsA()
	obj.BasePart = val
	local _Position = obj.Position
	local _getnamecallmethod = obj.getnamecallmethod
	local SPEAR_Gravity
	local Veil_LeadMultiplier
	local _Name = obj.Name
	obj:Spearthrow()
	local Aim_SilentVeil
	obj:FireServer()
	local _math = obj.math
	local _pcall = obj.pcall
	local _cb = PROTO194
end

local function PROTO194(val)
	obj:FireServer()
	obj:FireServer()
end

local function PROTO195(val)
	local Remotes
	local _Killers = obj.Killers
	local _Veil = obj.Veil
end

local function PROTO196(val)
	local SelfHeal
	obj:SetValue()
	obj:Notify()
	-- str: "Self Heal: ENABLED (Tanpa Animasi)"
	local _GetRole = obj.GetRole
	obj:Killer()
	obj:Notify()
	-- str: "Kamu harus Survivor!"
	obj:SetValue()
	obj:Notify()
	-- str: "Self Heal: DISABLED"
end

local function PROTO197(val)
	local _lockedAimbotTarget = obj.lockedAimbotTarget
	local Killer_Aimbot_Enabled
	-- str: "Y"
	-- str: "Y"
	-- str: "Y"
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	-- str: "Q"
	-- str: "Y"
	-- str: "Y"
	obj:Killer()
	-- str: "X"
	-- str: "X"
	-- str: "X"
	local _Controls = obj.Controls
	obj:FindFirstChild()
	obj.attack = val
	-- str: "X"
	obj:FindFirstChild()
	obj.Controls = val
	local _StartInfiniteAbyssal = obj.StartInfiniteAbyssal
	local _GetKillerUI = obj.GetKillerUI
	-- str: "Y"
	-- str: "Y"
	-- str: "Y"
	-- str: "X"
	-- str: "X"
	obj:FindFirstChild()
	obj.move2 = val
	local _KeyCode = obj.KeyCode
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	local _r = lockedAimbotTarget
	local _getBestAimbotTarget = obj.getBestAimbotTarget
	local _r = lockedAimbotTarget
	-- str: "X"
	-- str: "X"
	-- str: "X"
	local _Position = obj.Position
	local _AbsolutePosition = obj.AbsolutePosition
	local _AbsoluteSize = obj.AbsoluteSize
	-- str: "X"
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _Visible = obj.Visible
	local _GetRole = obj.GetRole
	local Killer_InfAbyssal
	local _StartInfiniteAbyssal = obj.StartInfiniteAbyssal
	local _MouseButton1 = obj.MouseButton1
	local _Position = obj.Position
	local _AbsolutePosition = obj.AbsolutePosition
	local _AbsoluteSize = obj.AbsoluteSize
	-- str: "Y"
	-- str: "Y"
	local _UserInputType = obj.UserInputType
	obj:FindFirstChild()
	obj.Controls = val
	obj:Killer()
	local _lockedAimbotTarget = obj.lockedAimbotTarget
end

local function PROTO198(val)
	Surv_ParryAggressive = val
end

local function PROTO199(val)
	obj["Time"] = 2
	Surv_PerfectVault = val
	obj:Notify()
	obj["Title"] = "Anti Slow Vault"
	obj["Description"] = "Off"
	obj["Time"] = 2
	obj["Title"] = "Anti Slow Vault"
	obj["Description"] = "On"
end

local function PROTO200(val)
	-- (no semantic content extracted)
end

local function PROTO201(val)
	obj["Gravity"] = 0
	local _spawn = obj.spawn
	local _cb = PROTO202
	local _task = obj.task
	local _wait = obj.wait
	local _r = suckedAnimTrack
	local _suckedAnimTrack = obj.suckedAnimTrack
	obj:Play()
	local _suckedAnimTrack = obj.suckedAnimTrack
	local _suckedAnimTrack = obj.suckedAnimTrack
	obj:Stop()
	local _suckedAttachmentLoop = obj.suckedAttachmentLoop
	obj:Disconnect()
	obj:Notify()
	obj["Title"] = "Get Sucked"
	obj["Description"] = "Pilih target dulu!"
	obj["Time"] = 3
	local _Character = obj.Character
	local _r = GetSuckedEnabled
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.Humanoid = val
	obj["AnimationId"] = "rbxassetid://148840371"
	obj:FindFirstChildOfClass()
	obj:LoadAnimation()
	local _workspace = obj.workspace
	obj.Gravity = val
	local _suckedAttachmentLoop = obj.suckedAttachmentLoop
	local GetSuckedToggle
	obj:SetValue()
	local _cb = PROTO203
	local _r = suckedAttachmentLoop
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Animation = val
	local _suckedAnimTrack = obj.suckedAnimTrack
	local _workspace = obj.workspace
	local _Gravity = obj.Gravity
	local _workspace = obj.workspace
	local _r = suckedAttachmentLoop
	local _r = suckedAnimTrack
	obj:AdjustSpeed()
	local Stepped
	obj:Connect()
end

local function PROTO202(val)
	CFrame = val
	local _task = obj.task
	local _wait = obj.wait
	local CFrame
	local _CFrame = obj.CFrame
	local _new = obj.new
	local Position
	-- str: "Y"
	local _GetSuckedEnabled = obj.GetSuckedEnabled
end

local function PROTO203(val)
	local _math = obj.math
	local _pi = obj.pi
	Velocity = val
	CFrame = val
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local CFrame
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _CFrame = obj.CFrame
	local _Angles = obj.Angles
end

local function PROTO204(val)
	-- str: "✅ Aktif"
	InstantTPGate = val
	obj["Time"] = 2
	obj["Title"] = "Instant TP Gate"
	-- str: "❌ Nonaktif"
end

local function PROTO205(val)
	local Colors
	obj.Pallet = val
end

local function PROTO206(val)
	local _EnableInfiniteLunge = obj.EnableInfiniteLunge
	local _DisableInfiniteLunge = obj.DisableInfiniteLunge
end

local function PROTO207(val)
	-- (no semantic content extracted)
end

local function PROTO208(val)
	local _ClearHookESP = obj.ClearHookESP
	obj.Gate = val
	local _ClearESP = obj.ClearESP
	local _ClearESP = obj.ClearESP
	obj.Player = val
	obj.Killer = val
	local _ClearESP = obj.ClearESP
	obj.Generator = val
	obj.SCP = val
	local _ClearESP = obj.ClearESP
	obj.Window = val
	local _ClearESP = obj.ClearESP
	obj.Pallet = val
	local _ClearESP = obj.ClearESP
	obj.Hook = val
end

local function PROTO209(val)
	local _pairs = obj.pairs
	obj:GetDescendants()
	local _warn = obj.warn
	-- str: "Map not found"
	local _table = obj.table
	local _insert = obj.insert
	local _Name = obj.Name
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
end

local function PROTO210(val)
	obj:FindFirstChild()
	-- str: "LeftGate-end2"
	obj:FindFirstChild()
	obj.Box = val
	obj["Transparency"] = 1
	obj["Transparency"] = 0
	obj:FindFirstChild()
	obj.LeftGate = val
	obj:FindFirstChild()
	local _pairs = obj.pairs
	local _r = BypassGateEnabled
	local _gatherGates = obj.gatherGates
	obj["CanCollide"] = true
	obj["Transparency"] = 1
	obj["CanCollide"] = true
	obj:FindFirstChild()
	-- str: "RightGate-end"
	obj["Transparency"] = 1
	obj["CanCollide"] = true
	obj.RightGate = val
	obj:FindFirstChild()
	-- str: "LeftGate-end"
	obj["Transparency"] = 1
	obj["Transparency"] = 0
	obj:FindFirstChild()
	-- str: "RightGate-end2"
end

local function PROTO211(val)
	local InfPursuitJason
	local _NEX_StartJasonPursuitBypass = obj.NEX_StartJasonPursuitBypass
	KILLER_InfPursuit = val
	obj:SetValue()
	local _NEX_StopJasonPursuitBypass = obj.NEX_StopJasonPursuitBypass
end

local function PROTO212(val)
	obj:FindFirstChildOfClass()
	obj.Atmosphere = val
	local _ApplyNoFog = obj.ApplyNoFog
	obj:Notify()
	obj["Title"] = "No Fog"
	obj["Description"] = "Kabut berhasil dihilangkan!"
	obj["Time"] = 3
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "No Fog"
	obj["Description"] = "No Fog dimatikan"
	obj["Density"] = 0.35
	local _r = NoFog
end

local function PROTO213(val)
	ESP_Name = val
	local _ClearAllESP = obj.ClearAllESP
	local _ScanMap = obj.ScanMap
end

local function PROTO214(val)
	obj:fireServer()
	local _unpack = obj.unpack
	local _getnamecallmethod = obj.getnamecallmethod
	-- compare: "FireServer"
end

local function PROTO215(val)
	obj:Disconnect()
	local Character
	local CharacterAdded
	obj:Connect()
	local _cb = PROTO216
	obj:SetAttribute()
	obj.Flowstate = val
end

local function PROTO216(val)
	local _setupFlowstateCharacter = obj.setupFlowstateCharacter
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO217(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO218(val)
	obj["Title"] = "Infinite Lunge"
	obj["Description"] = "✅ AKTIF (999x)"
	obj["Time"] = 3
	obj:SetAttribute()
	obj.lungeboost = val
	local _Library = obj.Library
	obj:Notify()
	local Character
end

local function PROTO219(val)
	local _Library = obj.Library
	obj["Title"] = "Infinite Lunge"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 3
	obj:SetAttribute()
	obj.lungeboost = val
	local Character
end

local function PROTO220(val)
	local _pcall = obj.pcall
	local _NEX_StartCureFlaskLaser = obj.NEX_StartCureFlaskLaser
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	obj.NEX_CureFlaskLaserThread = val
	obj:Disconnect()
	local _getgenv = obj.getgenv
	local _getgenv = obj.getgenv
	obj.NEX_CureFlaskLaserPart = val
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserThread = obj.NEX_CureFlaskLaserThread
	obj:Notify()
	obj["Title"] = "Flask Laser"
	obj["Description"] = "AKTIF - Laser merah"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Flask Laser"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	KILLER_FlaskLaser = val
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserThread = obj.NEX_CureFlaskLaserThread
	local _pcall = obj.pcall
	local _cb = PROTO221
end

local function PROTO221(val)
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	obj:Destroy()
end

local function PROTO222(val)
	obj.Description = val
	obj["Time"] = 2
	local _tonumber = obj.tonumber
	local _r = SpeedInputValue
	obj:Notify()
	obj["Title"] = "Speed"
end

local function PROTO223(val)
	Aim_SilentVeil = val
end

local function PROTO224(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO225(val)
	local _table = obj.table
	local _insert = obj.insert
	local _table = obj.table
	local _Enum = obj.Enum
	local _RaycastFilterType = obj.RaycastFilterType
	local _Exclude = obj.Exclude
	obj.FilterType = val
	local _Magnitude = obj.Magnitude
	local _table = obj.table
	local _insert = obj.insert
	local _Unit = obj.Unit
	local _RaycastParams = obj.RaycastParams
	local _new = obj.new
	local Character
	obj.FilterDescendantsInstances = val
	local _workspace = obj.workspace
	obj:Raycast()
end

local function PROTO226(val)
	local _r = SpeedEnabled
end

local function PROTO227(val)
	local _task = obj.task
	local _wait = obj.wait
	local _setMoonwalk = obj.setMoonwalk
	local _RecreateMoonwalkButton = obj.RecreateMoonwalkButton
	local _MoonwalkEnabled = obj.MoonwalkEnabled
end

local function PROTO228(val)
	local _pcall = obj.pcall
	local _cb = PROTO229
	local _pcall = obj.pcall
	local _cb = PROTO230
	obj:FindFirstChild()
	-- str: "Survivor-mob"
	obj:FindFirstChild()
	obj.PlayerGui = val
	local _firesignal = obj.firesignal
	obj.Controls = val
	local _Controls = obj.Controls
	obj:FindFirstChild()
	-- str: "Gui-mob"
	local _Visible = obj.Visible
end

local function PROTO229(val)
	local _mouse2click = obj.mouse2click
	local _wait = obj.wait
	local _mouse2release = obj.mouse2release
	local _mouse2press = obj.mouse2press
	obj:SendMouseButtonEvent()
	local _MouseButton2Click = obj.MouseButton2Click
	local _mouse2click = obj.mouse2click
	local _game = obj.game
	local _mouse2press = obj.mouse2press
	local _task = obj.task
	local _wait = obj.wait
	local _mouse2release = obj.mouse2release
	local _game = obj.game
	local _task = obj.task
end

local function PROTO230(val)
	local MouseButton1Up
	local _firesignal = obj.firesignal
	local MouseButton1Down
	local _task = obj.task
	local _wait = obj.wait
	local _firesignal = obj.firesignal
end

local function PROTO231(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton2 = obj.MouseButton2
end

local function PROTO232(val)
	obj:FindFirstChild()
	-- str: "Gui-mob"
	obj:FindFirstChild()
	-- str: "Survivor-mob"
	obj:FindFirstChildOfClass()
	obj.PlayerGui = val
	obj:FindFirstChild()
	obj.Controls = val
	local _ChildAdded = obj.ChildAdded
	obj:Connect()
	local _cb = PROTO233
	local _ChildAdded = obj.ChildAdded
	obj:Connect()
	local _InputBegan = obj.InputBegan
	obj:Connect()
	local _cb = PROTO235
	local _InputEnded = obj.InputEnded
	obj:Connect()
	local _cb = PROTO236
end

local function PROTO233(val)
	local _setupMobileButton = obj.setupMobileButton
	local _Name = obj.Name
	obj:Controls()
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO234(val)
	local _Name = obj.Name
	-- namecall: "Survivor-mob"
	local _setupMobileButton = obj.setupMobileButton
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO235(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _doShoot = obj.doShoot
end

local function PROTO236(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local doShoot
end

local function PROTO237(val)
	local _task = obj.task
	local _wait = obj.wait
	local _RecreateMoonwalkButton = obj.RecreateMoonwalkButton
	local _print = obj.print
	-- str: "✅ Moonwalk button created!"
end

local function PROTO238(val)
	local _game = obj.game
	local _PlaceId = obj.PlaceId
	local _game = obj.game
	local _JobId = obj.JobId
end

local function PROTO239(val)
	KILLER_SilentAimFlask = val
	obj:Notify()
	obj["Title"] = "Silent Aim Flask"
	obj.AKTIF = val
	obj.Description = val
	obj["Time"] = 2
	obj.NONAKTIF = val
end

local function PROTO240(val)
	Surv_Aimbot_Predict = val
	local _tonumber = obj.tonumber
end

local function PROTO241(val)
	local KeyboardEnabled
	local _r = AutoCurrentGenModel
	local _AutoRepairThread = obj.AutoRepairThread
	local _StopAutoRepair = obj.StopAutoRepair
	local _r = BypassGenEnabled
	local _BypassButton = obj.BypassButton
	obj.Visible = val
	local _task = obj.task
	local _cancel = obj.cancel
	local _AutoRepairThread = obj.AutoRepairThread
	local _r = AutoRepairThread
	local TouchEnabled
end

local function PROTO242(val)
	local _pcall = obj.pcall
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Title"] = "Aim Lock"
	obj["Description"] = "Aim Lock berhasil dimuat!"
	obj["Time"] = 3
end

local function PROTO243(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://pastefy.app/2MD1ZoBY/raw"
end

local function PROTO244(val)
	local FlowState
	obj:SetValue()
end

local function PROTO245(val)
	local _destroyTargetSelectorUI = obj.destroyTargetSelectorUI
	local _stopConnection = obj.stopConnection
	local _createTargetSelectorUI = obj.createTargetSelectorUI
	local _startConnection = obj.startConnection
end

local function PROTO246(val)
	local _KillerWarn = obj.KillerWarn
	obj:Destroy()
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	ESP_KillerWarn = val
	obj:FindFirstChild()
	obj.KillerWarn = val
end

local function PROTO247(val)
	-- (no semantic content extracted)
end

local function PROTO248(val)
	local _pcall = obj.pcall
	local _cb = PROTO249
	local _task = obj.task
	local _wait = obj.wait
	local _ScanMap = obj.ScanMap
end

local function PROTO249(val)
	-- (no semantic content extracted)
end

local function PROTO250(val)
	local Colors
	obj.Window = val
end

local function PROTO251(val)
	LockAim = val
end

local function PROTO252(val)
	local _HeartbeatConnection = obj.HeartbeatConnection
	local Surv_InstanSkillCheck
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO253
	local _ReapplyPerformance = obj.ReapplyPerformance
	local _task = obj.task
	local _task = obj.task
	local _wait = obj.wait
	obj:Disconnect()
	local ESP_Master
	local _HeartbeatConnection = obj.HeartbeatConnection
	obj:Disconnect()
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO254
	local _wait = obj.wait
	local _ScanMap = obj.ScanMap
end

local function PROTO253(val)
	local _task = obj.task
	local _wait = obj.wait
	local _ForceRefreshMap = obj.ForceRefreshMap
end

local function PROTO254(val)
	obj["Disabled"] = true
	obj["Disabled"] = true
	local Character
	obj:WaitForChild()
	-- str: "Skillcheck-gen"
	obj:WaitForChild()
	-- str: "Skillcheck-player"
end

local function PROTO255(val)
	obj:Notify()
	obj["Title"] = "Anti Blind"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Anti Blind"
	obj["Description"] = "Aktif - Immune dari flashlight"
	obj["Time"] = 3
	AntiBlind = val
end

local function PROTO256(val)
	local _pcall = obj.pcall
	local _cb = PROTO257
	local _Value = obj.Value
	local _GetRole = obj.GetRole
	-- compare: "Killer"
	local _string = obj.string
	local _find = obj.find
	local _string = obj.string
	local _lower = obj.lower
	local _tostring = obj.tostring
	obj.abyss = val
	obj:GetAttribute()
	obj.SelectedKiller = val
	obj:FindFirstChild()
	obj.SelectedKiller = val
end

local function PROTO257(val)
	local _Killers = obj.Killers
	local _Abysswalker = obj.Abysswalker
	local _corrupt = obj.corrupt
	obj:FireServer()
	local _game = obj.game
	local _Remotes = obj.Remotes
end

local function PROTO258(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO259
end

local function PROTO259(val)
	local _FireAbyssalSkill = obj.FireAbyssalSkill
	local _task = obj.task
	local _wait = obj.wait
	local _GetRole = obj.GetRole
	obj:Killer()
	local Killer_InfAbyssal
end

local function PROTO260(val)
	local _UpdateHookData = obj.UpdateHookData
	obj:Notify()
	local _ClearHookESP = obj.ClearHookESP
	obj:Notify()
	obj["Title"] = "Hook ESP"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	obj["Title"] = "Hook ESP"
	obj["Description"] = "Aktif"
	obj["Time"] = 2
end

local function PROTO261(val)
	Surv_Aimbot_Smoothness = val
end

local function PROTO262(val)
	local _r = AutoPalletDistance
end

local function PROTO263(val)
	obj:FindFirstChild()
	obj.Items = val
	obj:FindFirstChild()
	-- str: "Twist of Fate"
	obj.Fire = val
	obj:FindFirstChild()
end

local function PROTO264(val)
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Moonwalk!"
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Moonwalk"
	local _pcall = obj.pcall
	local _cb = PROTO265
end

local function PROTO265(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	-- str: "https://pastebin.com/raw/JWr0bW8u"
end

local function PROTO266(val)
	Surv_ParryCircle = val
end

local function PROTO267(val)
	-- (no semantic content extracted)
end

local function PROTO268(val)
	obj:Notify()
	local FPSCapSlider
	obj:SetValue()
	obj["Title"] = "FPS Cap"
	obj["Description"] = "Reset ke 60 FPS"
	obj["Time"] = 2
end

local function PROTO269(val)
	local _MoonwalkButton = obj.MoonwalkButton
	obj.Parent = val
	local _Instance = obj.Instance
	local _Instance = obj.Instance
	obj.ScreenGui = val
	local _r = MoonwalkUI
	local _MoonwalkUI = obj.MoonwalkUI
	obj["Name"] = "MoonwalkUI"
	local _MoonwalkUI = obj.MoonwalkUI
	local _MoonwalkUI = obj.MoonwalkUI
	obj["IgnoreGuiInset"] = true
	local _MoonwalkUI = obj.MoonwalkUI
	local _new = obj.new
	obj.TextLabel = val
	local _fromRGB = obj.fromRGB
	obj["TextScaled"] = true
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj.TextColor3 = val
	obj.Size = val
	local _MoonwalkButton = obj.MoonwalkButton
	local _UDim2 = obj.UDim2
	local _UpdateMoonwalkStatus = obj.UpdateMoonwalkStatus
	obj["Name"] = "MoonwalkLabel"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _MoonwalkUI = obj.MoonwalkUI
	local _Instance = obj.Instance
	local _new = obj.new
	obj.CornerRadius = val
	local _MoonwalkButton = obj.MoonwalkButton
	obj.Parent = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.4
	obj["ZIndex"] = 11
	local _MoonwalkButton = obj.MoonwalkButton
	obj.Parent = val
	local _MoonwalkButton = obj.MoonwalkButton
	local _MouseButton1Click = obj.MouseButton1Click
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _new = obj.new
	local _MoonwalkButton = obj.MoonwalkButton
	local _UDim2 = obj.UDim2
	local _Vector2 = obj.Vector2
	obj.AnchorPoint = val
	local _MoonwalkButton = obj.MoonwalkButton
	local _Color3 = obj.Color3
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Position = val
	local _MoonwalkButton = obj.MoonwalkButton
	local _fromRGB = obj.fromRGB
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkButtonVisible = obj.MoonwalkButtonVisible
	obj.Visible = val
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ImageButton = val
	local _r = MoonwalkButton
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkButton = obj.MoonwalkButton
	obj.BackgroundColor3 = val
	local _MoonwalkButton = obj.MoonwalkButton
	obj["BackgroundTransparency"] = 0.15
	local _MoonwalkButton = obj.MoonwalkButton
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "🌙 OFF"
	local _Color3 = obj.Color3
	local _new = obj.new
	obj.UIStroke = val
	obj:Destroy()
	obj:Connect()
	local _cb = PROTO270
	obj:FindFirstChild()
	obj.MoonwalkUI = val
end

local function PROTO270(val)
	local _ToggleMoonwalk = obj.ToggleMoonwalk
end

local function PROTO271(val)
	Surv_ParryRadius = val
end

local function PROTO272(val)
	local Killer_BypassCarry
	local _pcall = obj.pcall
	local _cb = PROTO273
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Bypass Carry"
	Killer_BypassCarry = val
	obj.Nonaktif = val
	obj.Description = val
	obj["Time"] = 2
	obj.Aktif = val
	IsActive = val
end

local function PROTO273(val)
	local _Toggles = obj.Toggles
	obj:SetValue()
	local _Toggles = obj.Toggles
	local Killer_BypassCarry
	local _Toggles = obj.Toggles
	local _Killer_Bypass = obj.Killer_Bypass
end

local function PROTO274(val)
	obj.Size = val
	obj["Text"] = "CARRY [OFF]"
	local _Color3 = obj.Color3
	local _new = obj.new
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	-- str: "_statusConn"
	obj:Disconnect()
	obj["Name"] = "Frame"
	obj.Parent = val
	local _UDim2 = obj.UDim2
	obj.BackgroundColor3 = val
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj["TextSize"] = 12
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _new = obj.new
	obj.TextButton = val
	obj["Name"] = "ActionButton"
	obj["Active"] = true
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _fromRGB = obj.fromRGB
	-- str: "_statusConn"
	local _cb = PROTO275
	local _InputBegan = obj.InputBegan
	obj:Connect()
	local _cb = PROTO276
	local _InputEnded = obj.InputEnded
	obj:Connect()
	local _cb = PROTO278
	local InputChanged
	obj:Connect()
	local _cb = PROTO279
	local _fromOffset = obj.fromOffset
	obj.Size = val
	local _new = obj.new
	obj.ScreenGui = val
	obj["Name"] = "BypassCarryCustomGui"
	obj.Position = val
	local _Color3 = obj.Color3
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Color = val
	obj.CornerRadius = val
	obj["Thickness"] = 1.5
	local _Instance = obj.Instance
	local Heartbeat
	obj:Connect()
	local _cb = PROTO280
	-- str: "_statusConn"
	Gui = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	obj["Name"] = "UIStroke"
	obj.Parent = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	local _Instance = obj.Instance
	local _UDim = obj.UDim
	local _new = obj.new
	local Gui
	obj:Destroy()
	Gui = val
	obj["IgnoreGuiInset"] = true
	local _Enum = obj.Enum
	local _ZIndexBehavior = obj.ZIndexBehavior
	local _Sibling = obj.Sibling
	obj.ZIndexBehavior = val
	obj.Parent = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _fromRGB = obj.fromRGB
end

local function PROTO275(val)
	local _math = obj.math
	local _abs = obj.abs
	-- str: "Y"
	local _Scale = obj.Scale
	-- str: "Y"
	local _Offset = obj.Offset
	-- str: "Y"
	Position = val
	local _math = obj.math
	local _abs = obj.abs
	-- str: "X"
	local _UDim2 = obj.UDim2
	-- str: "X"
	local _Scale = obj.Scale
	-- str: "X"
	local _Offset = obj.Offset
	-- str: "X"
	-- str: "Y"
end

local function PROTO276(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _task = obj.task
	local _delay = obj.delay
	local _cb = PROTO277
	local _task = obj.task
	local _cancel = obj.cancel
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _Position = obj.Position
	local Position
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
end

local function PROTO277(val)
	-- (no semantic content extracted)
end

local function PROTO278(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _task = obj.task
	local _cancel = obj.cancel
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
end

local function PROTO279(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseMovement = obj.MouseMovement
end

local function PROTO280(val)
	local IsActive
	local Killer_BypassCarry
	-- str: "_statusConn"
	-- str: "_statusConn"
	obj:Disconnect()
	local Gui
	local _Parent = obj.Parent
	-- str: "_statusConn"
end

local function PROTO281(val)
	obj["Title"] = "Fake Parry"
	obj["Description"] = "GUI Fake Parry berhasil dimuat!"
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Fake Parry GUI!"
	obj["Time"] = 3
	obj:Notify()
	local _pcall = obj.pcall
	local _cb = PROTO282
end

local function PROTO282(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://pastefy.app/tz2VGaIN/raw"
end

local function PROTO283(val)
	local _pcall = obj.pcall
	local _cb = PROTO284
	obj:FindFirstChild()
	obj.PalletDropEvent = val
	obj:FindFirstChild()
	obj.Pallet = val
	local _refreshPalletCache = obj.refreshPalletCache
	local _ipairs = obj.ipairs
	obj:FindFirstChild()
	obj.Remotes = val
	local _cb = PROTO285
	local _r = refreshPalletCache
end

local function PROTO284(val)
	obj:FireServer()
end

local function PROTO285(val)
	obj:FindFirstChild()
	obj.Map = val
	obj:IsA()
	obj.BasePart = val
	local _ipairs = obj.ipairs
	obj:GetDescendants()
	local _insert = obj.insert
	local _Name = obj.Name
	obj:PalletPoint()
	local _workspace = obj.workspace
	obj:FindFirstAncestorWhichIsA()
	obj.Model = val
end

local function PROTO286(val)
	-- namecall: "Friday Night"
	local _r = SelectedSound
	obj:Griddy()
	obj:Backflip()
	obj:WarCry()
	local _r = SelectedSound
	local _r = SelectedSound
	-- namecall: "Floating Rest"
	-- namecall: "24 Hour Cinderella"
	obj:Applause()
	-- namecall: "Arm Swing"
	obj:OnePlays()
	obj:Kyoufuu()
	local _EmoteEnabled = obj.EmoteEnabled
	local _PlayEmote = obj.PlayEmote
	-- namecall: "Christmas Spirit"
	obj:Vulnerable()
end

local function PROTO287(val)
	ESP_Pallet = val
	local ESP_Master
	local _ClearESP = obj.ClearESP
	obj.Pallet = val
end

local function PROTO288(val)
	obj:GetAttributeChangedSignal()
	obj.Flowstate = val
	obj:Connect()
	obj:SetAttribute()
	obj.Flowstate = val
	local _cb = PROTO289
	obj:Disconnect()
end

local function PROTO289(val)
	obj:SetAttribute()
	obj.Flowstate = val
	local _task = obj.task
	obj:GetAttribute()
	obj.Flowstate = val
end

local function PROTO290(val)
	Surv_AutoParry = val
end

local function PROTO291(val)
	Surv_Aimbot_ShowFOV = val
end

local function PROTO292(val)
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj["TextSize"] = 11
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _cb = PROTO293
	local InputChanged
	obj:Connect()
	local _cb = PROTO294
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _Main = obj.Main
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _InputBegan = obj.InputBegan
	obj:Connect()
	local _cb = PROTO295
	local _InputEnded = obj.InputEnded
	obj:Connect()
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _cb = PROTO296
	local _r = toggleMinimize
	local _MouseButton1Click = obj.MouseButton1Click
	obj:Connect()
	local _toggleMinimize = obj.toggleMinimize
	local _ipairs = obj.ipairs
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	local _new = obj.new
	obj.Padding = val
	local _cb = PROTO297
	local _r = updateButtons
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _fromRGB = obj.fromRGB
	obj.CornerRadius = val
	local _MouseButton1Click = obj.MouseButton1Click
	obj:Connect()
	local _cb = PROTO298
	local _InputEnded = obj.InputEnded
	obj:Connect()
	local _new = obj.new
	local _new = obj.new
	obj.Color = val
	obj["Thickness"] = 0.8
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Size = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextButton = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	local _Parent = obj.Parent
	obj.TextColor3 = val
	local _Enum = obj.Enum
	local _Font = obj.Font
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Horizontal = obj.Horizontal
	obj.FillDirection = val
	local _Enum = obj.Enum
	local _SortOrder = obj.SortOrder
	local _LayoutOrder = obj.LayoutOrder
	obj.SortOrder = val
	local _UDim = obj.UDim
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	local _display = obj.display
	obj.LayoutOrder = val
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _new = obj.new
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIListLayout = val
	local _Enum = obj.Enum
	local _FillDirection = obj.FillDirection
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj["TextSize"] = 9
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	local _Center = obj.Center
	obj.TextXAlignment = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextButton = val
	local _UDim2 = obj.UDim2
	obj.Size = val
	obj["BorderSizePixel"] = 0
	local _Enum = obj.Enum
	obj.TextXAlignment = val
	local _Enum = obj.Enum
	local _TextYAlignment = obj.TextYAlignment
	local _Center = obj.Center
	obj.TextYAlignment = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj["Active"] = true
	obj.Parent = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Size = val
	obj.Position = val
	local _Color3 = obj.Color3
	local _updateButtons = obj.updateButtons
	obj.Position = val
	local _Color3 = obj.Color3
	obj["Text"] = "TARGET MODE TWIST OF FATE"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _UDim = obj.UDim
	local _new = obj.new
	obj:FindFirstChild()
	obj.ToFTargetSelector = val
	obj.Position = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Position = val
	obj.Frame = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	obj.Font = val
	obj["TextSize"] = 14
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	local _Center = obj.Center
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "−"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local InputBegan
	obj:Connect()
	local _cb = PROTO299
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _UDim2 = obj.UDim2
	obj:Destroy()
	obj.TextColor3 = val
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _cb = PROTO300
	local _internal = obj.internal
	obj:Disconnect()
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj["Name"] = "ToFTargetSelector"
	obj["IgnoreGuiInset"] = true
	obj.Parent = val
	local _new = obj.new
end

local function PROTO293(val)
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
end

local function PROTO294(val)
	-- str: "X"
	local _Scale = obj.Scale
	-- str: "X"
	local _Offset = obj.Offset
	-- str: "Y"
	local _Position = obj.Position
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseMovement = obj.MouseMovement
	-- str: "X"
	-- str: "Y"
	local _Scale = obj.Scale
	-- str: "Y"
	local _Offset = obj.Offset
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
end

local function PROTO295(val)
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _Position = obj.Position
	local Position
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _Touch = obj.Touch
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
end

local function PROTO296(val)
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UDim2 = obj.UDim2
	Size = val
	Size = val
	local _new = obj.new
end

local function PROTO297(val)
	local _activeColor = obj.activeColor
	obj.BackgroundColor3 = val
	local _activeTxt = obj.activeTxt
	obj.TextColor3 = val
	local _internal = obj.internal
	local _internal = obj.internal
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	local _ipairs = obj.ipairs
end

local function PROTO298(val)
	local _updateButtons = obj.updateButtons
end

local function PROTO299(val)
	obj["Title"] = "Target Mode"
	obj["Description"] = "Killer"
	obj["Time"] = 1
	local _Keyboard = obj.Keyboard
	obj["Title"] = "Target Mode"
	obj["Description"] = "Survivors"
	local _activeTxt = obj.activeTxt
	obj["Title"] = "Target Mode"
	obj["Description"] = "Zombie"
	obj["Time"] = 1
	-- str: "L"
	local _pairs = obj.pairs
	obj.Zombie = val
	obj:Notify()
	local _KeyCode = obj.KeyCode
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	-- str: "J"
	obj.Survivors = val
	obj:Notify()
	-- str: "K"
	local _KeyCode = obj.KeyCode
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _ipairs = obj.ipairs
	obj.Killer = val
	obj:Notify()
	obj.TextColor3 = val
	local _KeyCode = obj.KeyCode
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _Parent = obj.Parent
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _activeColor = obj.activeColor
	local _internal = obj.internal
	obj["Time"] = 1
	obj.BackgroundColor3 = val
end

local function PROTO300(val)
	local internal
	local _updateButtons = obj.updateButtons
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
end

local function PROTO301(val)
	obj:Disconnect()
end

local function PROTO302(val)
	local _data = obj.data
	local _game = obj.game
	local _PlaceId = obj.PlaceId
	obj:Notify()
	obj["Title"] = "No Server"
	local _id = obj.id
	obj.Description = val
	obj["Time"] = 3
	local _task = obj.task
	local _wait = obj.wait
	local _playing = obj.playing
	local _maxPlayers = obj.maxPlayers
	-- str: "/servers/Public?sortOrder=Asc&limit=100"
	-- str: "https://games.roblox.com/v1/games/"
	local _pcall = obj.pcall
	local _nextPageCursor = obj.nextPageCursor
	local _ipairs = obj.ipairs
	local _data = obj.data
	-- str: "&cursor="
	-- str: "Players: %d/%d"
	local _playing = obj.playing
	local _maxPlayers = obj.maxPlayers
	local _table = obj.table
	local _insert = obj.insert
	local _playing = obj.playing
	local _MinPlayers = obj.MinPlayers
	obj:Notify()
	obj["Title"] = "Server Found"
	local _string = obj.string
	local _format = obj.format
	local _cb = PROTO303
	local _id = obj.id
	local _game = obj.game
	local _JobId = obj.JobId
	obj["Description"] = "Try Again"
	obj["Time"] = 3
	local _playing = obj.playing
	local _MaxPlayers = obj.MaxPlayers
	local _math = obj.math
	local _random = obj.random
	obj:TeleportToPlaceInstance()
end

local function PROTO303(val)
	obj:JSONDecode()
	local _game = obj.game
	obj:HttpGet()
end

local function PROTO304(val)
	obj.Description = val
	obj["Time"] = 2
	obj.NONAKTIF = val
	-- str: "AKTIF!"
	obj["Title"] = "Anti Auto Parry"
	local _r = AntiAutoParryEnabled
	obj:Notify()
end

local function PROTO305(val)
	obj:GetAttributeChangedSignal()
	obj.HookCount = val
	obj:Connect()
	local _cb = PROTO306
	local _pairs = obj.pairs
	obj:GetPlayers()
end

local function PROTO306(val)
	local Name
	obj:GetAttribute()
	local _UpdateHookESP = obj.UpdateHookESP
	obj.HookCount = val
end

local function PROTO307(val)
	obj:Notify()
	local SharedTargetDropdown
	obj:SetValues()
	obj["Description"] = "Daftar player di-refresh!"
	obj["Time"] = 2
end

local function PROTO308(val)
	local Hooks
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	obj:FindFirstChild()
	obj.HookPoint = val
	local _hookIndex = obj.hookIndex
	local _r = hookIndex
	local _TeleportToPart = obj.TeleportToPart
	local _ScanMap = obj.ScanMap
	local _hookIndex = obj.hookIndex
end

local function PROTO309(val)
	local _gateIndex = obj.gateIndex
	local Gates
	local _gateIndex = obj.gateIndex
	local _r = gateIndex
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	local _gateIndex = obj.gateIndex
	local _TeleportToPart = obj.TeleportToPart
	local _ScanMap = obj.ScanMap
end

local function PROTO310(val)
	local _ScanMap = obj.ScanMap
	ESP_Player = val
	local ESP_Master
	local _ClearESP = obj.ClearESP
	obj.Player = val
end

local function PROTO311(val)
	ESP_Master = val
	local _ForceRefreshMap = obj.ForceRefreshMap
	local _ClearAllESP = obj.ClearAllESP
end

local function PROTO312(val)
	local _ServerHop = obj.ServerHop
end

local function PROTO313(val)
	ESP_Distance = val
	local ESP_Master
end

local function PROTO314(val)
	local _EnableInfiniteLunge = obj.EnableInfiniteLunge
	local _DisableInfiniteLunge = obj.DisableInfiniteLunge
end

local function PROTO315(val)
	obj:Notify()
	obj["Title"] = "Silent Veil V2"
	-- str: "ON (No Double)"
	obj.OFF = val
	obj.Description = val
	obj["Time"] = 2
	Aim_SilentVeilV2 = val
end

local function PROTO316(val)
	SpearSmart_enable = val
end

local function PROTO317(val)
	obj:Lerp()
	local LerpSmoothness
	obj.pos = val
	obj.vel = val
	local _Position = obj.Position
	local _tick = obj.tick
	obj.time = val
	local _tick = obj.tick
	local _time = obj.time
	local _Vector3 = obj.Vector3
	local _zero = obj.zero
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.time = val
	local _Velocity = obj.Velocity
	local _pos = obj.pos
	local _vel = obj.vel
	obj.pos = val
	local _Velocity = obj.Velocity
	obj.vel = val
	local _tick = obj.tick
end

local function PROTO318(val)
	obj:Dot()
	obj:Dot()
	local _math = obj.math
	local _abs = obj.abs
	obj:Dot()
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local EnableJitter
	local _math = obj.math
	local _sqrt = obj.sqrt
	local _math = obj.math
	local _abs = obj.abs
	local _math = obj.math
	local _random = obj.random
	local MaxJitterStuds
	local _math = obj.math
	local _random = obj.random
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local PredictionEfficiency
	local _random = obj.random
end

local function PROTO319(val)
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Survivors()
	local _GetSCPs = obj.GetSCPs
	local _math = obj.math
	local _huge = obj.huge
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	local _Team = obj.Team
	local _Name = obj.Name
	local _math = obj.math
	local _huge = obj.huge
	obj:GetPlayers()
	local _CFrame = obj.CFrame
	local _LookVector = obj.LookVector
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.Torso = val
	local _Team = obj.Team
	local _Parent = obj.Parent
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.Torso = val
	local _Character = obj.Character
	local _Position = obj.Position
	local _CFrame = obj.CFrame
	local _Position = obj.Position
	local _Unit = obj.Unit
	obj:Dot()
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	-- str: "Y"
	local _cb = PROTO320
	obj:Killer()
	local _Team = obj.Team
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	local _getGunObject = obj.getGunObject
	local Character
	local _Position = obj.Position
	obj:GetAttribute()
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.IsCarried = val
	obj:Survivors()
	local _Unit = obj.Unit
	obj:Dot()
	local _Parent = obj.Parent
	obj:Zombie()
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _math = obj.math
	local _huge = obj.huge
	-- str: "Z"
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	local _CFrame = obj.CFrame
	local _LookVector = obj.LookVector
	local _ipairs = obj.ipairs
	local _Character = obj.Character
	local _Position = obj.Position
	local _CFrame = obj.CFrame
	local _Position = obj.Position
	local _Character = obj.Character
	local _CFrame = obj.CFrame
	local _LookVector = obj.LookVector
	local _ipairs = obj.ipairs
	local _pcall = obj.pcall
	local _cb = PROTO322
	local _ipairs = obj.ipairs
	obj:GetPlayers()
end

local function PROTO320(val)
	local _silentAimPredict = obj.silentAimPredict
	local _cb = PROTO321
	local _Magnitude = obj.Magnitude
	local _isTargetVisible = obj.isTargetVisible
	local _Unit = obj.Unit
	local _Unit = obj.Unit
	local _pcall = obj.pcall
end

local function PROTO321(val)
	local Position
	local _Position = obj.Position
	obj:FindFirstChildOfClass()
	obj.BasePart = val
	obj:IsA()
	obj.BasePart = val
end

local function PROTO322(val)
	obj:IsA()
	obj.BasePart = val
	obj:FindFirstChildOfClass()
	obj.BasePart = val
	local _Position = obj.Position
	local Position
	obj:FindFirstChildOfClass()
end

local function PROTO323(val)
	Flash_Silent = val
end

local function PROTO324(val)
	Killer_Aimbot_MaxDist = val
end

local function PROTO325(val)
	local _pcall = obj.pcall
	local _cb = PROTO326
	obj:IsA()
	local Character
	local _pairs = obj.pairs
	obj:GetChildren()
	obj.BasePart = val
	obj:GetDescendants()
end

local function PROTO326(val)
	-- (no semantic content extracted)
end

local function PROTO327(val)
	obj:GetChildren()
	local _pairs = obj.pairs
	obj:GetDescendants()
	local Character
	obj:IsA()
	local _pcall = obj.pcall
	local _cb = PROTO328
	obj:IsA()
	obj.Decal = val
	local _pairs = obj.pairs
end

local function PROTO328(val)
	LocalTransparencyModifier = val
	Transparency = val
end

local function PROTO329(val)
	obj:WaitForChild()
	obj.PlayerGui = val
	obj:Destroy()
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
end

local function PROTO330(val)
	local _SetupNextKillerIndicator = obj.SetupNextKillerIndicator
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO331
end

local function PROTO331(val)
	obj.UICorner = val
	local _fromRGB = obj.fromRGB
	obj.Position = val
	local _Vector2 = obj.Vector2
	local _new = obj.new
	obj.CornerRadius = val
	obj.Parent = val
	obj["Thickness"] = 1
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Parent = val
	obj:FindFirstChild()
	obj.NextKillerDisplay = val
	obj.Text = val
	obj.TextColor3 = val
	obj["Text"] = "Next Killer: <font color='#888888'>Waiting...</font>"
	obj["TextSize"] = 11
	obj["RichText"] = true
	obj.Parent = val
	local _Instance = obj.Instance
	local _Enum = obj.Enum
	local _GothamMedium = obj.GothamMedium
	obj.Font = val
	obj.AnchorPoint = val
	obj["BackgroundTransparency"] = 0.15
	local _Color3 = obj.Color3
	obj.Color = val
	obj["Transparency"] = 0.3
	local _table = obj.table
	local _sort = obj.sort
	local _cb = PROTO332
	local _Instance = obj.Instance
	obj.TextLabel = val
	obj["Name"] = "NextKillerDisplay"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.BackgroundColor3 = val
	local _Color3 = obj.Color3
	obj:GetPlayers()
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	local _task = obj.task
	local _wait = obj.wait
	local _Name = obj.Name
	-- str: "<font color='#ff5555'>KAMU</font>"
end

local function PROTO332(val)
	obj:GetAttribute()
	obj.KillerChance = val
	obj.AllowKiller = val
	obj:GetAttribute()
	obj.KillerChance = val
	obj:GetAttribute()
end

local function PROTO333(val)
	obj:Destroy()
end

local function PROTO334(val)
	local _pairs = obj.pairs
	obj:GetDescendants()
	local _pcall = obj.pcall
	local _cb = PROTO335
	obj:IsA()
	obj.BasePart = val
	local _isWeapon = obj.isWeapon
	local _Name = obj.Name
	obj:IsA()
	obj.Decal = val
	obj:IsA()
	obj.BasePart = val
	local _cb = PROTO336
	obj:IsA()
	obj.Decal = val
	obj:IsA()
	obj.BasePart = val
	obj:GetDescendants()
	local _Name = obj.Name
	obj:Hat()
	local _pcall = obj.pcall
	local _cb = PROTO337
	obj.BasePart = val
	local _pairs = obj.pairs
	obj:GetChildren()
end

local function PROTO335(val)
	Transparency = val
	LocalTransparencyModifier = val
end

local function PROTO336(val)
	Transparency = val
	LocalTransparencyModifier = val
end

local function PROTO337(val)
	LocalTransparencyModifier = val
	Transparency = val
end

local function PROTO338(val)
	local _Name = obj.Name
	obj:Hat()
	local _pcall = obj.pcall
	local _cb = PROTO339
	obj:IsA()
	obj.Decal = val
	obj:IsA()
	obj.BasePart = val
	obj:IsA()
	obj.BasePart = val
	obj:IsA()
	obj.Decal = val
	local _isWeapon = obj.isWeapon
	local _pcall = obj.pcall
	local _cb = PROTO340
	local _pairs = obj.pairs
	obj:GetDescendants()
	local _isWeapon = obj.isWeapon
	obj:IsA()
	obj.BasePart = val
	obj:GetDescendants()
	local _pairs = obj.pairs
	local _Name = obj.Name
	obj:IsA()
	obj.BasePart = val
	local _pcall = obj.pcall
	local _cb = PROTO341
	local _SetCharacterTransparency = obj.SetCharacterTransparency
	local Character
	local _pairs = obj.pairs
	obj:GetChildren()
end

local function PROTO339(val)
	-- (no semantic content extracted)
end

local function PROTO340(val)
	-- (no semantic content extracted)
end

local function PROTO341(val)
	-- (no semantic content extracted)
end

local function PROTO342(val)
	local _Character = obj.Character
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _Character = obj.Character
	obj:FindFirstChild()
	local _Position = obj.Position
	local _Position = obj.Position
	local _math = obj.math
	local _huge = obj.huge
	local Character
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	local _IsKiller = obj.IsKiller
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _IsDowned = obj.IsDowned
	local _Character = obj.Character
	local _Magnitude = obj.Magnitude
	local _Health = obj.Health
	local _Character = obj.Character
end

local function PROTO343(val)
	obj:FindFirstChild()
	-- str: "Left Arm"
	obj:IsA()
	obj.LocalScript = val
	local _Position = obj.Position
	local _pairs = obj.pairs
	local _game = obj.game
	obj:FindFirstChild()
	obj.LeftHand = val
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	local _Vector3 = obj.Vector3
	local _new = obj.new
	obj.NEX_CureFlaskLaserPart = val
	obj.Color = val
	obj["Transparency"] = 0
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	obj["Transparency"] = 1
	obj.CFrame = val
	obj["Transparency"] = 0
	local _game = obj.game
	obj:GetService()
	obj.Players = val
	obj.Size = val
	local _CFrame = obj.CFrame
	local _new = obj.new
	local _new = obj.new
	obj.Part = val
	obj["Name"] = "FlaskSilentAimLaser"
	obj["Anchored"] = true
	local _Position = obj.Position
	local _pairs = obj.pairs
	obj:GetChildren()
	obj:GetService()
	obj.Players = val
	local _LocalPlayer = obj.LocalPlayer
	local _Enum = obj.Enum
	local _Material = obj.Material
	local _Neon = obj.Neon
	local _Magnitude = obj.Magnitude
	local _Character = obj.Character
	local _Character = obj.Character
	obj:GetAttribute()
	obj.IsKiller = val
	obj:GetAttribute()
	obj.action = val
	local _Character = obj.Character
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	obj:GetService()
	obj.Players = val
	obj:GetPlayers()
	local _workspace = obj.workspace
	obj.Parent = val
	local _getgenv = obj.getgenv
	local _math = obj.math
	local _huge = obj.huge
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _LocalPlayer = obj.LocalPlayer
	local _Character = obj.Character
	obj.Material = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
end

local function PROTO344(val)
	Veil_ShowFOV = val
end

local function PROTO345(val)
	-- (no semantic content extracted)
end

local function PROTO346(val)
	local _tick = obj.tick
	local lastTime
	local _RightVector = obj.RightVector
	local Cooldown
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Character
	local _CFrame = obj.CFrame
	local _Position = obj.Position
	obj.CFrame = val
	local _math = obj.math
	local Distance
	local _new = obj.new
	local _Position = obj.Position
	local _CFrame = obj.CFrame
end

local function PROTO347(val)
	local Attached
	local _AncestryChanged = obj.AncestryChanged
	obj:Connect()
	local _cb = PROTO348
	obj:WaitForChild()
	obj.Animator = val
	obj:Connect()
	local _cb = PROTO349
	local _AnimationPlayed = obj.AnimationPlayed
	obj:Connect()
	local _cb = PROTO350
	obj:WaitForChild()
	obj.Humanoid = val
	obj:FindFirstChildOfClass()
	obj.Animator = val
end

local function PROTO348(val)
	local Attached
	obj:Disconnect()
end

local function PROTO349(val)
	local Attached
	local Attach
	obj:Disconnect()
	obj:IsA()
	obj.Animator = val
end

local function PROTO350(val)
	obj:Dot()
	local _Unit = obj.Unit
	local Character
	local _Animation = obj.Animation
	local _AnimationId = obj.AnimationId
	local _Animation = obj.Animation
	local _Magnitude = obj.Magnitude
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
	local _Position = obj.Position
	-- str: "X"
	local Surv_CrouchV
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _CFrame = obj.CFrame
	-- str: "X"
	obj:FindFirstChild()
	-- str: "match"
	-- str: "%d+"
	-- compare: "86266790353635"
	-- compare: "93136435416899"
	local Trigger
	local _Position = obj.Position
	-- str: "Z"
	local _Position = obj.Position
	-- str: "Z"
	local _Magnitude = obj.Magnitude
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _CFrame = obj.CFrame
	-- str: "Z"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO351(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _Team = obj.Team
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Survivors()
	local _Character = obj.Character
	local _ipairs = obj.ipairs
	obj:GetPlayers()
end

local function PROTO352(val)
	obj:GetAttribute()
	obj.isHealing = val
	obj:GetAttribute()
	obj.IsHooked = val
	local _AutoPalletSafety = obj.AutoPalletSafety
	obj:GetAttribute()
	obj.isVaulting = val
	obj:GetAttribute()
	obj.isRepairing = val
	obj:GetAttribute()
	obj.isUnhooking = val
	obj:GetAttribute()
	obj.isCarrying = val
	obj:GetAttribute()
	obj.isSliding = val
	obj:FindFirstChild()
	obj.CheckInterractable = val
	local _Health = obj.Health
	obj:GetAttribute()
	obj.IsCarried = val
	obj:GetAttribute()
	obj.Knocked = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
end

local function PROTO353(val)
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _Parent = obj.Parent
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	obj:FindFirstChild()
	obj.PrimaryPartPallet = val
	local _pcall = obj.pcall
	obj:PROTO354()
	obj:FindFirstChild()
	obj.PalletPoint = val
	local _AutoPalletDistance = obj.AutoPalletDistance
	local _ipairs = obj.ipairs
	local Pallets
	obj:FindFirstChild()
	obj.PalletPointSlide = val
end

local function PROTO354(val)
	local Position
end

local function PROTO355(val)
	local _Pallet = obj.Pallet
	obj:FindFirstChild()
	obj.PalletDropEvent = val
	obj:FindFirstChild()
	local _pcall = obj.pcall
	local _cb = PROTO356
	obj:FindFirstChild()
	obj.PalletPoint = val
	obj:FindFirstChild()
	obj.PalletPointSlide = val
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
end

local function PROTO356(val)
	obj:FireServer()
end

local function PROTO357(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO358
end

local function PROTO358(val)
	local _AutoPalletEnabled = obj.AutoPalletEnabled
	local _pcall = obj.pcall
	local _cb = PROTO359
	local _task = obj.task
	local _wait = obj.wait
	local _GetRole = obj.GetRole
	-- compare: "Survivor"
end

local function PROTO359(val)
	local Character
	local _FindNearestPallet = obj.FindNearestPallet
	local _Health = obj.Health
	local _DropPallet = obj.DropPallet
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _AutoPalletDistance = obj.AutoPalletDistance
	local _Position = obj.Position
	local _Position = obj.Position
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _IsSafeToDropPallet = obj.IsSafeToDropPallet
	local _GetKillerRoot = obj.GetKillerRoot
end

local function PROTO360(val)
	local _task = obj.task
	local _cancel = obj.cancel
end

local function PROTO361(val)
	obj.HumanoidRootPart = val
	local _CFrame = obj.CFrame
	obj.CFrame = val
	obj:Notify()
	local _CFrame = obj.CFrame
	obj.CFrame = val
	obj:IsA()
	obj.BasePart = val
	local _new = obj.new
	obj["Title"] = "Teleport"
	obj["Description"] = "Berhasil!"
	obj["Time"] = 1
	obj:IsA()
	obj.Model = val
	local Character
	obj.BasePart = val
end

local function PROTO362(val)
	local _ClearESP = obj.ClearESP
	ESP_SCP = val
	local ESP_Master
	local _ScanMap = obj.ScanMap
end

local function PROTO363(val)
	local _r = silentAimPredict
	obj:Notify()
	obj.enabled = val
	obj.disabled = val
	-- str: "auto predict aim: "
end

local function PROTO364(val)
	local _Character = obj.Character
	local _Character = obj.Character
	local _IsKiller = obj.IsKiller
	local _ipairs = obj.ipairs
	obj:GetPlayers()
end

local function PROTO365(val)
	obj:Connect()
	local _cb = PROTO366
	local _task = obj.task
	local _IsKiller = obj.IsKiller
	local _Character = obj.Character
	local _wait = obj.wait
	local _Character = obj.Character
end

local function PROTO366(val)
	local _task = obj.task
	local _wait = obj.wait
	local _IsKiller = obj.IsKiller
	local _print = obj.print
	local Name
	-- str: "✅ Stun setup untuk killer baru: "
end

local function PROTO367(val)
	local _math = obj.math
	local _floor = obj.floor
	local _tonumber = obj.tonumber
	local _r = MinPlayers
	local _math = obj.math
	local _clamp = obj.clamp
end

local function PROTO368(val)
	local _Parent = obj.Parent
	obj:IsA()
	obj:FindFirstChild()
	obj.icon = val
	local _Parent = obj.Parent
	obj:IsA()
	local _Parent = obj.Parent
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	obj.PlayerGui = val
	obj:IsA()
	obj:FindFirstChild()
	-- str: "Survivor-mob"
	local _Parent = obj.Parent
	obj:IsA()
	obj.GuiButton = val
	local _Parent = obj.Parent
	local _Parent = obj.Parent
	obj:FindFirstChild()
	obj.sprint = val
end

local function PROTO369(val)
	local _pcall = obj.pcall
end

local function PROTO370(val)
	-- str: "X"
	local AbsolutePosition
	local AbsoluteSize
	local _firesignal = obj.firesignal
	local MouseButton1Click
	local MouseButton1Down
	local _task = obj.task
	local _wait = obj.wait
	local _firesignal = obj.firesignal
	local MouseButton1Up
	obj:GetGuiInset()
	-- str: "X"
	-- str: "X"
	obj:SendTouchEvent()
	local _wait = obj.wait
	obj:SendTouchEvent()
	-- str: "Y"
	-- str: "Y"
	-- str: "Y"
	local _task = obj.task
	local _type = obj.type
	local _firesignal = obj.firesignal
	obj:function()
end

local function PROTO371(val)
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _MoveDirection = obj.MoveDirection
	local _Magnitude = obj.Magnitude
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	-- str: "Z"
	local _Magnitude = obj.Magnitude
	local _Vector3 = obj.Vector3
	local _new = obj.new
	-- str: "X"
end

local function PROTO372(val)
	local Character
	obj:GetAttribute()
	obj.Crouchingserver = val
	obj:GetAttribute()
	obj.Crouching = val
end

local function PROTO373(val)
	local _r = FleeKillerEnabled
end

local function PROTO374(val)
	local _tostring = obj.tostring
	-- str: "match"
	-- str: "%d+"
end

local function PROTO375(val)
	obj:FindFirstChild()
	local _pcall = obj.pcall
	local _cb = PROTO376
	-- str: "rbxthumb://type=Asset&id=%s&w=420&h=420"
	-- str: "format"
end

local function PROTO376(val)
	local Texture
	local Image
end

local function PROTO377(val)
	obj.Visible = val
	local _r = MoonwalkButtonVisible
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkEnabled = obj.MoonwalkEnabled
	local _UpdateMoonwalkStatus = obj.UpdateMoonwalkStatus
end

local function PROTO378(val)
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkButton = obj.MoonwalkButton
	local _MoonwalkEnabled = obj.MoonwalkEnabled
end

local function PROTO379(val)
	local _pcall = obj.pcall
	local _cb = PROTO380
end

local function PROTO380(val)
	obj:GetAttribute()
	obj.Frenzy = val
	obj:FindFirstChild()
	local Character
	obj:SetAttribute()
	obj.Frenzy = val
	obj:FindFirstChild()
	obj.Remotes = val
	obj:FireServer()
	local Remotes
	obj:FindFirstChild()
	obj.Killers = val
	local _Killers = obj.Killers
	obj:FindFirstChild()
	obj.Killer = val
end

local function PROTO381(val)
	local _task = obj.task
	local _cb = PROTO382
end

local function PROTO382(val)
	local _task = obj.task
	local _wait = obj.wait
	local KILLER_InfPursuit
	local _pcall = obj.pcall
	local _cb = PROTO383
end

local function PROTO383(val)
	obj:GetAttribute()
	obj.Pursuit = val
	obj:SetAttribute()
	obj.Pursuit = val
	local Character
end

local function PROTO384(val)
	local _NEX_StartJasonLakeMistBypass = obj.NEX_StartJasonLakeMistBypass
	obj["Time"] = 2
	KILLER_InfLakeMist = val
	obj:Notify()
	obj["Title"] = "Infinite Lake Mist"
	obj["Description"] = "AKTIF!"
	obj["Time"] = 2
	obj["Title"] = "Infinite Lake Mist"
	obj["Description"] = "NONAKTIF!"
end

local function PROTO385(val)
	obj:string()
	local _type = obj.type
	local _type = obj.type
	-- str: "string"
	local _pairs = obj.pairs
	Ignored_Skills_List = val
end

local function PROTO386(val)
	local _Generators = obj.Generators
	local _genIndex = obj.genIndex
	local _part = obj.part
	local Generators
	obj:Notify()
	obj["Title"] = "TP Generator"
	obj["Description"] = "Generator tidak ditemukan!"
	local _genIndex = obj.genIndex
	-- namecall: "Generator "
	obj.Description = val
	obj["Time"] = 2
	obj["Time"] = 1.2
	local _ScanMap = obj.ScanMap
	local _genIndex = obj.genIndex
	local _r = genIndex
	local _genIndex = obj.genIndex
	local _TeleportToPart = obj.TeleportToPart
	local _part = obj.part
	obj:Notify()
	obj["Title"] = "TP Generator"
end

local function PROTO387(val)
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	obj["Title"] = "Watermark"
	obj["Description"] = "AKTIF"
	local _r = WatermarkEnabled
	local _StopWatermark = obj.StopWatermark
	obj:Notify()
	obj["Title"] = "Watermark"
	obj["Time"] = 2
	local _StartWatermark = obj.StartWatermark
	obj:Notify()
end

local function PROTO388(val)
	local _task = obj.task
	local _wait = obj.wait
	local _StopWatermark = obj.StopWatermark
end

local function PROTO389(val)
	local _ApplyFullBright = obj.ApplyFullBright
	obj:Notify()
	obj["Title"] = "Full Bright"
	obj["Description"] = "Full Bright aktif!"
	obj["Time"] = 3
	OutdoorAmbient = val
	obj:Notify()
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	Ambient = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["Title"] = "Full Bright"
	obj["Description"] = "Full Bright dimatikan"
	obj["Time"] = 3
	local _r = FullBright
end

local function PROTO390(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO391(val)
	local _ConfigData = obj.ConfigData
	obj.Surv_SkillSpeed = val
end

local function PROTO392(val)
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _Health = obj.Health
	local _Character = obj.Character
	obj:GetPlayers()
	local _huge = obj.huge
	local _pairs = obj.pairs
	local StalkRange
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
end

local function PROTO393(val)
	obj:FindFirstChild()
	obj.UpperTorso = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.Torso = val
	local AIM_TargetPart
	obj:HumanoidRootPart()
	obj:FindFirstChild()
	obj.Head = val
	obj:FindFirstChild()
	-- compare: "Root"
	obj:Head()
end

local function PROTO394(val)
	local _Character = obj.Character
	obj:WorldToViewportPoint()
	local _Position = obj.Position
	local _Character = obj.Character
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _getTargetPartObject = obj.getTargetPartObject
	local _ViewportSize = obj.ViewportSize
	-- str: "X"
	local Veil_FOV
	local _workspace = obj.workspace
	local _CurrentCamera = obj.CurrentCamera
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Survivors()
	local _Vector2 = obj.Vector2
	local _new = obj.new
	-- str: "X"
	local _Health = obj.Health
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local Character
	local _ViewportSize = obj.ViewportSize
	-- str: "Y"
	obj:GetPlayers()
	-- str: "Y"
	local _Magnitude = obj.Magnitude
	local SPEAR_MaxDist
	obj:FindFirstChild()
end

local function PROTO395(val)
	Misc_FakeName = val
	local _enableSpoofer = obj.enableSpoofer
	local _disableSpoofer = obj.disableSpoofer
end

local function PROTO396(val)
	Flash_YOffset = val
end

local function PROTO397(val)
	Veil_FOV = val
end

local function PROTO398(val)
	local Colors
	obj.Player = val
end

local function PROTO399(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO400
end

local function PROTO400(val)
	local _game = obj.game
	obj:GetService()
	obj:WaitForChild()
	obj.Remotes = val
	obj:WaitForChild()
	obj.KingScourgeStart = val
	obj:WaitForChild()
	obj:Connect()
	local _cb = PROTO401
	obj:WaitForChild()
	obj.KillerPerks = val
end

local function PROTO401(val)
	local SkillCheckMode
	obj:Random()
end

local function PROTO402(val)
	local _pairs = obj.pairs
	-- str: "Ga deket generator manapun!"
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _GetAllGenerators = obj.GetAllGenerators
	local Character
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local _DoMultiRepairPlain = obj.DoMultiRepairPlain
	local _huge = obj.huge
	local _pairs = obj.pairs
	local _BypassGenEnabled = obj.BypassGenEnabled
end

local function PROTO403(val)
	local _pcall = obj.pcall
	local _cb = PROTO404
	local _Visible = obj.Visible
end

local function PROTO404(val)
	local PlayerGui
	local _pcprompts = obj.pcprompts
	local _Frame = obj.Frame
	local _GeneratorRepair = obj.GeneratorRepair
end

local function PROTO405(val)
	obj.FieldOfView = val
	local _CurrentCamera = obj.CurrentCamera
	local _r = TargetFOV
	local FOVEnabled
end

local function PROTO406(val)
	local _UpdateSCPESP = obj.UpdateSCPESP
	local ESP_Master
	local _pcall = obj.pcall
	local _UpdatePlayerESP = obj.UpdatePlayerESP
	local _pcall = obj.pcall
	local _AutoPalletEnabled = obj.AutoPalletEnabled
	local _task = obj.task
	local _wait = obj.wait
	local _pcall = obj.pcall
	local _UpdateStaticESP = obj.UpdateStaticESP
end

local function PROTO407(val)
	obj:GetChildren()
	local _getgenv = obj.getgenv
	-- str: "_lastMapChildCount"
	local _getgenv = obj.getgenv
	-- str: "_lastMapChildCount"
	local _tick = obj.tick
	-- str: "_lastMapChildCount"
	-- str: "_lastMapChildCount"
	local _task = obj.task
	local _spawn = obj.spawn
	local _getgenv = obj.getgenv
	-- str: "_lastMapChildCount"
	obj:FindFirstChild()
end

local function PROTO408(val)
	-- str: "🔄 Map changed (childCount) - Rescanned!"
	local _task = obj.task
	local _wait = obj.wait
	local _ScanMap = obj.ScanMap
end

local function PROTO409(val)
	local _task = obj.task
	local _wait = obj.wait
	local _ApplyFullBright = obj.ApplyFullBright
	local _ApplyNoFog = obj.ApplyNoFog
	local _ApplyNoShadow = obj.ApplyNoShadow
end

local function PROTO410(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO411
	LeapBypass = val
end

local function PROTO411(val)
	local _debug = obj.debug
	local _getinfo = obj.getinfo
	local _name = obj.name
	obj:tryActivate()
	local _pairs = obj.pairs
	local _debug = obj.debug
	local _getupvalues = obj.getupvalues
	local _task = obj.task
	local _wait = obj.wait
	local _pairs = obj.pairs
	local _getgc = obj.getgc
	local BypassLeap
	obj:function()
	local _pairs = obj.pairs
	local _type = obj.type
	obj:boolean()
	local _islclosure = obj.islclosure
	local _debug = obj.debug
	local _setupvalue = obj.setupvalue
	local _type = obj.type
	local _name = obj.name
	obj:playM2Animation()
	local _warn = obj.warn
	-- str: "Function tidak ditemukan."
end

local function PROTO412(val)
	local _currentTrack = obj.currentTrack
	local _currentSound = obj.currentSound
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Sound = val
	local _currentSound = obj.currentSound
	obj:Destroy()
	local _SelectedAnim = obj.SelectedAnim
	obj.AnimationId = val
	obj:LoadAnimation()
	local _r = currentTrack
	local _currentTrack = obj.currentTrack
	obj["Looped"] = true
	local _currentTrack = obj.currentTrack
	obj:Play()
	obj.Parent = val
	local _currentSound = obj.currentSound
	obj:Play()
	local Character
	local _SelectedSound = obj.SelectedSound
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Animation = val
	local _currentSound = obj.currentSound
	local _currentSound = obj.currentSound
	local _SelectedSound = obj.SelectedSound
	obj.SoundId = val
	local _currentSound = obj.currentSound
	obj["Looped"] = true
	local _currentSound = obj.currentSound
	obj["Volume"] = 2
	obj:Stop()
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _SelectedAnim = obj.SelectedAnim
end

local function PROTO413(val)
	local _currentTrack = obj.currentTrack
	obj:Stop()
	local _currentSound = obj.currentSound
	local _currentTrack = obj.currentTrack
	local _currentSound = obj.currentSound
	obj:Destroy()
end

local function PROTO414(val)
	local _print = obj.print
	-- str: "✅ Speed Input aktif (via main RenderStepped)"
end

local function PROTO415(val)
	obj:IsA()
	obj.ImageButton = val
	obj:IsA()
	obj.TextBox = val
	obj.Image = val
	obj:SetAttribute()
	obj.OriginalImage = val
	obj:GetAttribute()
	obj.OriginalText = val
	obj:IsA()
	obj.TextButton = val
	local _Connected = obj.Connected
	obj:Disconnect()
	obj:IsA()
	obj.ImageLabel = val
	obj:FindFirstChild()
	obj.PlayerGui = val
	local _ipairs = obj.ipairs
	obj:GetDescendants()
	obj:GetAttribute()
	obj.OriginalImage = val
	local _ipairs = obj.ipairs
	obj:SetAttribute()
	obj.OriginalText = val
	obj:IsA()
	obj.TextLabel = val
	local _clear = obj.clear
	local _SpooferConns = obj.SpooferConns
end

local function PROTO416(val)
	obj:GetAttribute()
	obj.isHealing = val
	obj:GetAttribute()
	obj.isVaulting = val
	obj:GetAttribute()
	obj.isSliding = val
	obj:GetAttribute()
	obj:FindFirstChild()
	obj.CheckInterractable = val
	local Surv_ParrySafety
	obj:GetAttribute()
	obj.isUnhooking = val
end

local function PROTO417(val)
	local _pcall = obj.pcall
	local _cb = PROTO418
end

local function PROTO418(val)
	obj.PlayerGui = val
	local _Parent = obj.Parent
	local TouchEnabled
	obj:IsA()
	local _string = obj.string
	local _gmatch = obj.gmatch
	local _type = obj.type
	local _firesignal = obj.firesignal
	obj:function()
	local _LeftControl = obj.LeftControl
	local _game = obj.game
	local _Visible = obj.Visible
	local _Enum = obj.Enum
	local _LeftControl = obj.LeftControl
	obj:IsA()
	obj.GuiButton = val
	local _firesignal = obj.firesignal
	local _MouseButton1Click = obj.MouseButton1Click
	local _task = obj.task
	obj:SendKeyEvent()
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	-- str: "Survivor-mob.Controls.crouch.icon"
	-- str: "[^%.]+"
	local _KeyCode = obj.KeyCode
	local _LeftControl = obj.LeftControl
	local _game = obj.game
	local _game = obj.game
	obj:FindFirstChild()
	obj:SendKeyEvent()
	obj:SendKeyEvent()
	local _Enum = obj.Enum
	local _wait = obj.wait
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	local _LeftControl = obj.LeftControl
	local _game = obj.game
	local _MouseButton1Click = obj.MouseButton1Click
	local _task = obj.task
	obj:SendKeyEvent()
end

local function PROTO419(val)
	obj:Survivors()
	obj.Unknown = val
	obj.Spectator = val
	local Team
	local _Name = obj.Name
	obj:Killer()
	obj.Killer = val
end

local function PROTO420(val)
	local Gui
	local _task = obj.task
	local _wait = obj.wait
	local GuiVisible
	obj["Enabled"] = true
	local Surv_AutoParry
end

local function PROTO421(val)
	local _Character = obj.Character
	local TryAttach
	local _CharacterAdded = obj.CharacterAdded
	obj:Connect()
	local _cb = PROTO422
	obj:GetPropertyChangedSignal()
	obj.Team = val
	obj:Connect()
	local _cb = PROTO423
end

local function PROTO422(val)
	local TryAttach
end

local function PROTO423(val)
	local TryAttach
end

local function PROTO424(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO425
	obj:Notify()
	obj["Title"] = "Spectator Info"
	obj["Description"] = "✅ Display aktif di pojok atas"
	obj["Time"] = 3
	local _spectatorEnabled = obj.spectatorEnabled
end

local function PROTO425(val)
	local _UpdateSpectatorCount = obj.UpdateSpectatorCount
	local _task = obj.task
	local _wait = obj.wait
	local _spectatorEnabled = obj.spectatorEnabled
end

local function PROTO426(val)
	obj["Title"] = "Spectator Info"
	obj["Description"] = "Display dimatikan"
	obj["Time"] = 2
	local _SpectatorGui = obj.SpectatorGui
	obj:Notify()
	local _r = SpectatorLabel
	local _SpectatorGui = obj.SpectatorGui
	obj:Destroy()
	local _r = SpectatorGui
end

local function PROTO427(val)
	HitSoundEnabled = val
	obj:Notify()
	obj["Title"] = "Hit Sound"
	obj:Notify()
	obj["Title"] = "Hit Sound"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	obj["Time"] = 3
end

local function PROTO428(val)
	SkillCheckMode = val
end

local function PROTO429(val)
	local _delay = obj.delay
	local _cb = PROTO430
	obj:table()
	obj:Pursuit()
	-- compare: "FireServer"
	obj.Players = val
	obj:GetPlayers()
	obj:FireServer()
	local _Character = obj.Character
	local _checkcaller = obj.checkcaller
	local KILLER_SilentAimFlask
	local KILLER_InfPursuit
	local _pcall = obj.pcall
	local _cb = PROTO432
	local _Character = obj.Character
	obj:FireServer()
	local _pcall = obj.pcall
	local _cb = PROTO433
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local KILLER_InfLakeMist
	local KILLER_InfFrenzy
	obj:GetAttribute()
	local _math = obj.math
	local _unpack = obj.unpack
	local _typeof = obj.typeof
	obj:Vector3()
	local Team
	local _Name = obj.Name
	-- namecall: "Twist of Fate"
	local _Character = obj.Character
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	obj:GetAttribute()
	obj:IsCarrying()
	obj:FireServer()
	local _Name = obj.Name
	obj:AwardLog()
	local _Name = obj.Name
	local AntiBlind
	local _Parent = obj.Parent
	local _Character = obj.Character
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	local Enabled
	local _getcallingscript = obj.getcallingscript
	local _pairs = obj.pairs
	local _game = obj.game
	obj:GetService()
	local Killer_BypassCarry
	-- compare: "Deactivatefromclient"
	local _checkcaller = obj.checkcaller
	local _huge = obj.huge
	local _game = obj.game
	obj:GetService()
	obj.Players = val
	local _LocalPlayer = obj.LocalPlayer
	local _Unit = obj.Unit
	obj:InvokeServer()
	obj:GetAttributes()
	local _Name = obj.Name
	obj:Fire()
	obj:LakeMist()
	local _Character = obj.Character
	obj:GetAttribute()
	obj.IsKiller = val
	local _setnamecallmethod = obj.setnamecallmethod
	obj:FireServer()
	local _type = obj.type
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _pcall = obj.pcall
	local _cb = PROTO434
	local _getcallingscript = obj.getcallingscript
	local _getnamecallmethod = obj.getnamecallmethod
	local _pcall = obj.pcall
	local _cb = PROTO435
	local _Name = obj.Name
	obj:AwardLog()
	obj["LakeMist"] = 0
	obj:LakeMist()
	local _Character = obj.Character
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _Position = obj.Position
	obj:ThrowFlask()
	obj:PowerDoneDeactivating()
	local _Magnitude = obj.Magnitude
end

local function PROTO430(val)
	local _pcall = obj.pcall
	local _cb = PROTO431
end

local function PROTO431(val)
	obj:SetAttribute()
	obj.action = val
	obj.game = val
	obj:GetService()
	obj.Players = val
	local _LocalPlayer = obj.LocalPlayer
	local _Character = obj.Character
	obj.action = val
end

local function PROTO432(val)
	local Name
end

local function PROTO433(val)
	local Name
end

local function PROTO434(val)
	local Name
end

local function PROTO435(val)
	local Name
end

local function PROTO436(val)
	BypassLeap = val
end

local function PROTO437(val)
	local Colors
	obj.Generator = val
end

local function PROTO438(val)
	local _Heartbeat = obj.Heartbeat
	obj:Connect()
	local _r = WatermarkConnection
	local _game = obj.game
	obj:GetService()
	obj.RunService = val
	local _WatermarkConnection = obj.WatermarkConnection
	local _WatermarkConnection = obj.WatermarkConnection
	obj:Disconnect()
	local _r = WatermarkConnection
end

local function PROTO439(val)
	local _math = obj.math
	local _floor = obj.floor
	local _game = obj.game
	local _tick = obj.tick
	local _WatermarkConnection = obj.WatermarkConnection
	obj:SetVisible()
	obj:SetVisible()
	local _tick = obj.tick
	obj:GetService()
	obj.Stats = val
	local _Network = obj.Network
	local _ServerStatsItem = obj.ServerStatsItem
	-- str: "Data Ping"
	obj:GetValue()
	local _WatermarkEnabled = obj.WatermarkEnabled
	obj:SetText()
	-- str: "Pandu | %s fps | %s ms"
	-- str: "format"
	local _math = obj.math
	local _floor = obj.floor
	local _WatermarkConnection = obj.WatermarkConnection
	obj:Disconnect()
	local _r = WatermarkConnection
end

local function PROTO440(val)
	local _WatermarkConnection = obj.WatermarkConnection
	obj:Disconnect()
	local _r = WatermarkConnection
	obj:SetVisible()
	local _WatermarkConnection = obj.WatermarkConnection
end

local function PROTO441(val)
	local _Font = obj.Font
	local _GothamMedium = obj.GothamMedium
	obj.Font = val
	local _SpectatorLabel = obj.SpectatorLabel
	obj["Text"] = "0"
	local _SpectatorLabel = obj.SpectatorLabel
	local _Horizontal = obj.Horizontal
	obj.FillDirection = val
	local _Enum = obj.Enum
	obj["TextSize"] = 13
	local _SpectatorLabel = obj.SpectatorLabel
	local _AutomaticSize = obj.AutomaticSize
	local _SpectatorGui = obj.SpectatorGui
	local _VerticalAlignment = obj.VerticalAlignment
	local _Center = obj.Center
	obj.VerticalAlignment = val
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
	local _NumberSequenceKeypoint = obj.NumberSequenceKeypoint
	local _new = obj.new
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Image"] = "rbxassetid://13321848320"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Padding = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ImageLabel = val
	obj.AnchorPoint = val
	local _UDim2 = obj.UDim2
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIGradient = val
	obj.BackgroundColor3 = val
	local _SpectatorGui = obj.SpectatorGui
	obj:Destroy()
	-- str: "X"
	obj.AutomaticSize = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	local _r = SpectatorGui
	local _SpectatorGui = obj.SpectatorGui
	local _NumberSequence = obj.NumberSequence
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _HorizontalAlignment = obj.HorizontalAlignment
	local _Center = obj.Center
	obj.HorizontalAlignment = val
	obj.Transparency = val
	obj.Parent = val
	local _Instance = obj.Instance
	obj.CornerRadius = val
	local _new = obj.new
	obj.UIListLayout = val
	local _Enum = obj.Enum
	local _new = obj.new
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "MainBox"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Size = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["BackgroundTransparency"] = 0.25
	obj["BorderSizePixel"] = 0
	local _SpectatorGui = obj.SpectatorGui
	obj.Parent = val
	local _SpectatorLabel = obj.SpectatorLabel
	obj["BackgroundTransparency"] = 1
	local _SpectatorLabel = obj.SpectatorLabel
	local _Enum = obj.Enum
	obj["Name"] = "SpectatorCounter"
	local _SpectatorGui = obj.SpectatorGui
	local _UDim2 = obj.UDim2
	obj.TextColor3 = val
	local _SpectatorLabel = obj.SpectatorLabel
	obj:WaitForChild()
	obj.PlayerGui = val
end

local function PROTO442(val)
	obj.Size = val
	local _spectatorEnabled = obj.spectatorEnabled
	local _Team = obj.Team
	obj:Spectator()
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _SpectatorLabel = obj.SpectatorLabel
	local _SpectatorGui = obj.SpectatorGui
	obj:FindFirstChild()
	obj.MainBox = val
	local _SpectatorGui = obj.SpectatorGui
	obj.Text = val
	local _Team = obj.Team
	local _SpectatorLabel = obj.SpectatorLabel
	local _tostring = obj.tostring
end

local function PROTO443(val)
	SkillCheck = val
end

local function PROTO444(val)
	local _AnimationPlayed = obj.AnimationPlayed
	obj:Connect()
	local _cb = PROTO445
	local Character
	obj.Animator = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
end

local function PROTO445(val)
	obj:Stop()
	local _Animation = obj.Animation
	local _AnimationId = obj.AnimationId
	-- str: "find"
	-- str: "95836365038528"
	local _Animation = obj.Animation
end

local function PROTO446(val)
	local _pcall = obj.pcall
	local _cb = PROTO447
end

local function PROTO447(val)
	obj:Disconnect()
end

local function PROTO448(val)
	local _math = obj.math
	local _huge = obj.huge
	CameraMaxZoomDistance = val
end

local function PROTO449(val)
	obj:Notify()
	obj["Description"] = "Korless Morph Applied"
	obj["Time"] = 3
end

local function PROTO450(val)
	-- (no semantic content extracted)
end

local function PROTO451(val)
	-- (no semantic content extracted)
end

local function PROTO452(val)
	local _game = obj.game
	obj:BindToClose()
	local _cb = PROTO453
end

local function PROTO453(val)
	obj:Disconnect()
end

local function PROTO454(val)
	-- str: "_isFacingStraightEnough"
	local _cb = PROTO455
	-- str: "_isFacingStraightEnough"
	-- str: "_onVaultAnimation"
	local _cb = PROTO456
	-- str: "_onVaultAnimation"
	local _game = obj.game
	obj:IsLoaded()
	local _task = obj.task
	local _wait = obj.wait
	local _game = obj.game
	local _Loaded = obj.Loaded
	local _pcall = obj.pcall
	local _cb = PROTO457
end

local function PROTO455(val)
	obj["characterspeed"] = 20
	local Surv_PerfectVault
end

local function PROTO456(val)
	local Surv_PerfectVault
end

local function PROTO457(val)
	obj:WaitForChild()
	obj.Survivors = val
	obj:WaitForChild()
	local _require = obj.require
	obj:WaitForChild()
	obj.Modules = val
end

local function PROTO458(val)
	local _PlayEmote = obj.PlayEmote
	local _StopEmote = obj.StopEmote
	local _r = EmoteEnabled
end

local function PROTO459(val)
	obj:Notify()
	obj["Title"] = "Auto Run Mobile"
	obj:Notify()
	local _getgenv = obj.getgenv
	obj.AutoRunMobileEnabled = val
	obj["Description"] = "OFF"
	obj["Time"] = 2
	obj["Title"] = "Auto Run Mobile"
	obj["Description"] = "ON"
	obj["Time"] = 2
end

local function PROTO460(val)
	local _task = obj.task
	local _wait = obj.wait
	local _setupMobileButton = obj.setupMobileButton
	local _clearLaser = obj.clearLaser
	local _stopConnection = obj.stopConnection
	local _createTargetSelectorUI = obj.createTargetSelectorUI
end

local function PROTO461(val)
	local _task = obj.task
	local _wait = obj.wait
	local _createTargetSelectorUI = obj.createTargetSelectorUI
	local _Name = obj.Name
	obj:ToFTargetSelector()
end

local function PROTO462(val)
	obj:FindFirstChild()
	obj.Bottom = val
	local _ScanMap = obj.ScanMap
	local Windows
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	local _windowIndex = obj.windowIndex
	local _r = windowIndex
	local _windowIndex = obj.windowIndex
end

local function PROTO463(val)
	-- (no semantic content extracted)
end

local function PROTO464(val)
	local _r = AutoPalletEnabled
	local _StartAutoPallet = obj.StartAutoPallet
	obj:Notify()
	obj["Title"] = "Auto Pallet"
	obj:Notify()
	obj["Time"] = 2
	obj["Title"] = "Auto Pallet"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
end

local function PROTO465(val)
	local _setfpscap = obj.setfpscap
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO466(val)
	obj.Parent = val
	obj["AlwaysOnTop"] = true
	obj["ZIndex"] = 5
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	obj.FillColor = val
	local Colors
	local _Pallet = obj.Pallet
	obj.OutlineColor = val
	local ESP_Outline
	obj.Parent = val
	local _pairs = obj.pairs
	local Pallets
	obj["Name"] = "GateEH"
	obj.Parent = val
	obj:FindFirstChild()
	obj.GE_Text = val
	local _Parent = obj.Parent
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	obj:FindFirstChild()
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Highlight = val
	local _Parent = obj.Parent
	obj["Name"] = "GEH"
	local ESP_Pallet
	obj["Name"] = "PalletEH"
	local ESP_Window
	local _Generator = obj.Generator
	local _Gate = obj.Gate
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Highlight = val
	local _ipairs = obj.ipairs
	local Hooks
	obj.Adornee = val
	local _Size = obj.Size
	obj.Size = val
	local _Window = obj.Window
	local _math = obj.math
	local _floor = obj.floor
	obj:GetAttribute()
	obj.Parent = val
	obj:Destroy()
	local _GeneratorDone = obj.GeneratorDone
	obj.Transparency = val
	obj["Name"] = "WindowEH"
	obj.Parent = val
	local _CreateModernESP = obj.CreateModernESP
	obj.GE_Text = val
	obj.Adornee = val
	local _Gate = obj.Gate
	obj.FillColor = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local _model = obj.model
	local _ipairs = obj.ipairs
	local Windows
	obj.OutlineColor = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Highlight = val
	local ESP_Gate
	obj["name"] = "GEN"
	obj.subtext = val
	obj.color = val
	obj.icon = val
	local _Parent = obj.Parent
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Highlight = val
	obj.Color3 = val
	obj:FindFirstChild()
	obj.WindowEH = val
	obj:FindFirstChild()
	local _ipairs = obj.ipairs
	local Gates
	obj.FillColor = val
	obj.OutlineColor = val
	local _pairs = obj.pairs
	local Generators
	local ESP_Hook
	obj["Name"] = "HookEH"
	local _Instance = obj.Instance
	local _new = obj.new
	obj.BoxHandleAdornment = val
	local _string = obj.string
	-- str: "%d%%"
	local ESP_Master
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_GeneratorName
	obj:FindFirstChild()
	obj.HookEH = val
	local _Hook = obj.Hook
	obj.FillColor = val
	-- str: "DONE 100%"
	local ESP_Generator
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.PalletEH = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local _Parent = obj.Parent
	obj.Adornee = val
	local _Pallet = obj.Pallet
	obj.RepairProgress = val
end

local function PROTO467(val)
	pcall = val
	local _cb = PROTO468
	local _ClearAllESP = obj.ClearAllESP
	local _task = obj.task
	local _wait = obj.wait
	local _UpdatePlayerESP = obj.UpdatePlayerESP
	local _UpdateSCPESP = obj.UpdateSCPESP
	local _ScanMap = obj.ScanMap
end

local function PROTO468(val)
	local Pallets
	local Generators
	local _Library = obj.Library
	local _Notify = obj.Notify
	local _Library = obj.Library
end

local function PROTO469(val)
	local Heartbeat
	obj:Connect()
	local _cb = PROTO470
	Stalk = val
	local Stalk
end

local function PROTO470(val)
	obj:FindFirstChild()
	obj.Remotes = val
	local _cb = PROTO471
	local Enabled
	obj:FindFirstChild()
	obj.StartStalking = val
	local _Character = obj.Character
	local Remotes
	obj:FindFirstChild()
	obj.Killers = val
	local _Stalker = obj.Stalker
	local _Killers = obj.Killers
	obj:FindFirstChild()
	obj.Stalker = val
end

local function PROTO471(val)
	obj:FireServer()
end

local function PROTO472(val)
	local Stalk
	obj:Disconnect()
	Stalk = val
end

local function PROTO473(val)
	obj:fininshline()
	local _warn = obj.warn
	-- str: "fininshline not found"
	local _new = obj.new
	obj:IsA()
	obj.BasePart = val
	local _ipairs = obj.ipairs
	local _workspace = obj.workspace
	obj:GetDescendants()
	obj.CFrame = val
	local _string = obj.string
	local _Name = obj.Name
end

local function PROTO474(val)
	local InstantTPGate
	obj:SetValue()
	InstantTPGate = val
end

local function PROTO475(val)
	local _RepairAnimTrack = obj.RepairAnimTrack
	local _RepairAnimTrack = obj.RepairAnimTrack
	local _r = RepairAnimTrack
	local _pcall = obj.pcall
	local _cb = PROTO476
end

local function PROTO476(val)
	local _RepairAnimTrack = obj.RepairAnimTrack
	obj:Stop()
end

local function PROTO477(val)
	local _cb = PROTO478
end

local function PROTO478(val)
	local _Name = obj.Name
	-- str: "find"
	obj.GeneratorPoint = val
	local _table = obj.table
	local _insert = obj.insert
	obj:IsA()
	obj.BasePart = val
	local _pairs = obj.pairs
	obj:GetChildren()
end

local function PROTO479(val)
	local _StartAutoPallet = obj.StartAutoPallet
	local _r = AutoPalletEnabled
end

local function PROTO480(val)
	local _task = obj.task
	local _wait = obj.wait
	local _ClearHookESP = obj.ClearHookESP
	local _UpdateHookData = obj.UpdateHookData
	local _UpdateHookESP = obj.UpdateHookESP
end

local function PROTO481(val)
	HitSoundLastTime = val
	local _cb = PROTO482
	local HitSoundCooldown
	local _tick = obj.tick
	local HitSoundLastTime
	local HitSoundEnabled
end

local function PROTO482(val)
	local HitSoundVolume
	local _workspace = obj.workspace
	obj.Sound = val
	local HitSoundId
	obj.SoundId = val
	local _workspace = obj.workspace
	local _task = obj.task
	local _TimeLength = obj.TimeLength
	local _cb = PROTO483
	local _CurrentCamera = obj.CurrentCamera
	obj.Parent = val
	obj:Play()
end

local function PROTO483(val)
	local Parent
end

local function PROTO484(val)
	local Colors
	obj.Killer = val
end

local function PROTO485(val)
	local Gui
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Color = val
	obj.UIStroke = val
	obj["Text"] = "PARRY [ON]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _fromRGB = obj.fromRGB
	obj["Text"] = "PARRY [OFF]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj:FindFirstChild()
	obj.Frame = val
	obj.TextColor3 = val
	local _fromRGB = obj.fromRGB
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	obj:FindFirstChild()
	obj.ActionButton = val
	obj:FindFirstChild()
	obj.BackgroundColor3 = val
	obj.Color = val
end

local function PROTO486(val)
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.check = val
	obj:FindFirstChild()
	obj.action = val
	obj:FindFirstChild()
	-- str: "Survivor-mob"
end

local function PROTO487(val)
	obj:IsA()
	obj.GuiObject = val
	obj:IsA()
	obj.GuiObject = val
	local _type = obj.type
	local _firesignal = obj.firesignal
	obj:function()
	local _pcall = obj.pcall
	local _pcall = obj.pcall
	local _cb = PROTO489
	local _Visible = obj.Visible
	local _pcall = obj.pcall
	local _cb = PROTO490
end

local function PROTO488(val)
	local _game = obj.game
	local _task = obj.task
	local _Enum = obj.Enum
	local _KeyCode = obj.KeyCode
	obj:SendKeyEvent()
	local _Enum = obj.Enum
	local _game = obj.game
	obj:SendKeyEvent()
	local _KeyCode = obj.KeyCode
	local _Space = obj.Space
end

local function PROTO489(val)
	local AbsolutePosition
	local AbsoluteSize
	-- str: "Y"
	local _wait = obj.wait
	local _random = obj.random
	obj:SendTouchEvent()
	obj:SendTouchEvent()
	-- str: "X"
	-- str: "Y"
	-- str: "X"
	-- str: "X"
	-- str: "X"
	-- str: "Y"
	-- str: "Y"
	obj:GetGuiInset()
	local _math = obj.math
	-- str: "X"
	-- str: "X"
	-- str: "Y"
	-- str: "Y"
end

local function PROTO490(val)
	local _firesignal = obj.firesignal
	local MouseButton1Down
	local _task = obj.task
	local _wait = obj.wait
	local MouseButton1Up
end

local function PROTO491(val)
	local Heartbeat
	obj:Connect()
	local _cb = PROTO492
	obj:Disconnect()
	SkillHeartbeat = val
end

local function PROTO492(val)
	local _Visible = obj.Visible
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO493
	-- str: "busy"
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO494
	-- str: "busy"
	local _tick = obj.tick
	local _RandomMode_IsNormal = obj.RandomMode_IsNormal
	local _RandomMode_IsNormal = obj.RandomMode_IsNormal
	local SkillCheckMode
	local _Rotation = obj.Rotation
	local _Rotation = obj.Rotation
	obj:FindFirstChild()
	obj.SkillCheckPromptGui = val
	obj:FindFirstChild()
	obj.Line = val
	obj:FindFirstChild()
	obj.Goal = val
	local SkillCheck
	obj:FindFirstChild()
	local _busy = obj.busy
end

local function PROTO493(val)
	local _wait = obj.wait
	-- str: "busy"
end

local function PROTO494(val)
	local _task = obj.task
	local _wait = obj.wait
	-- str: "busy"
end

local function PROTO495(val)
	Surv_Aimbot_MaxDist = val
end

local function PROTO496(val)
	obj:Destroy()
	-- str: "created"
end

local function PROTO497(val)
	local Enabled
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local Thickness
	local Color
	obj.Color = val
	obj.Parent = val
	local Style
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	obj.Color = val
	local Size
	obj.CornerRadius = val
	obj.AnchorPoint = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.BackgroundColor3 = val
	obj:Dot()
	local _UDim = obj.UDim
	local _new = obj.new
	local _created = obj.created
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj["BackgroundTransparency"] = 1
	obj:Plus()
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.CornerRadius = val
	local OffsetY
	obj:Plus()
	-- str: "created"
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Thickness = val
	obj.Parent = val
	local _Instance = obj.Instance
	obj.Position = val
	obj:FindFirstChildOfClass()
	obj.UIStroke = val
	local _cb = PROTO498
	local _UDim2 = obj.UDim2
	local _LastCrosshairStyle = obj.LastCrosshairStyle
	obj["BorderSizePixel"] = 0
	local _new = obj.new
	obj:Dot()
	local _new = obj.new
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	local _Vector2 = obj.Vector2
	local _new = obj.new
	obj.ScreenGui = val
	local _new = obj.new
	local OffsetX
	obj.Size = val
	obj.Position = val
	local _Instance = obj.Instance
	obj.Size = val
	obj.Position = val
	obj.Size = val
	obj.Position = val
	obj.BackgroundColor3 = val
	obj.Size = val
	obj.Position = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj:Circle()
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.AnchorPoint = val
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Thickness = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.UICorner = val
	obj:Circle()
	obj.BackgroundColor3 = val
	obj.Size = val
	obj.Position = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
end

local function PROTO498(val)
	obj.Position = val
	obj.Parent = val
	local Color
	obj["BorderSizePixel"] = 0
	local _Vector2 = obj.Vector2
	local _new = obj.new
	obj.AnchorPoint = val
	obj.Size = val
	local _Instance = obj.Instance
end

local function PROTO499(val)
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	local _table = obj.table
	local _insert = obj.insert
	local Generators
	obj.model = val
	obj.part = val
	local _ipairs = obj.ipairs
	obj:gate()
	local _string = obj.string
	local _Name = obj.Name
	obj:window()
	local _table = obj.table
	local _clear = obj.clear
	obj:GetDescendants()
	local _ipairs = obj.ipairs
	local _table = obj.table
	local _clear = obj.clear
	obj:IsA()
	local _Parent = obj.Parent
	local _table = obj.table
	local _insert = obj.insert
	local Gates
	local _task = obj.task
	local _wait = obj.wait
	local _workspace = obj.workspace
	obj:GetDescendants()
	local _tick = obj.tick
	local _table = obj.table
	local _insert = obj.insert
	local Windows
	local _table = obj.table
	local _clear = obj.clear
	local _match = obj.match
	local _string = obj.string
	local _lower = obj.lower
	local _Name = obj.Name
	-- str: "^scp"
	local _table = obj.table
	local _insert = obj.insert
	local SCPs
	local _tick = obj.tick
	local _table = obj.table
	local _find = obj.find
	local Pallets
	local _table = obj.table
	local _clear = obj.clear
	local _table = obj.table
	local _clear = obj.clear
	obj.Model = val
	local _workspace = obj.workspace
	local _table = obj.table
	local _find = obj.find
	obj:generator()
	obj:FindFirstChild()
	local _table = obj.table
	local _insert = obj.insert
	local Hooks
	local _Name = obj.Name
	obj:PrimaryPartPallet()
	obj:FindFirstChild()
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	local _task = obj.task
	local _wait = obj.wait
	local _table = obj.table
	local _clear = obj.clear
	obj:IsA()
	obj.Model = val
	obj:hook()
	local _table = obj.table
end

local function PROTO500(val)
	local _ClearESP = obj.ClearESP
	obj.Hook = val
	ESP_Hook = val
	local ESP_Master
end

local function PROTO501(val)
	local _r = SpeedAmount
end

local function PROTO502(val)
	local _Name = obj.Name
	obj:GetAttribute()
	local _pairs = obj.pairs
	obj:GetPlayers()
	local _CreateHookESP = obj.CreateHookESP
	local _Character = obj.Character
	local _Character = obj.Character
	local _IsKiller = obj.IsKiller
end

local function PROTO503(val)
	local _pairs = obj.pairs
	obj:GetChildren()
	obj:Destroy()
	local _pairs = obj.pairs
	obj:GetPlayers()
	local _Name = obj.Name
	-- str: "^HookESP_"
end

local function PROTO504(val)
	local Character
	Surv_Perks = val
	obj:SetAttribute()
	local _GetRole = obj.GetRole
	-- compare: "Killer"
end

local function PROTO505(val)
	obj:Notify()
	obj["Title"] = "Fly"
	obj["Description"] = "Fly GUI Dimuat"
	obj["Title"] = "Fly"
	obj["Description"] = "Fly GUI terbuka"
	obj["Time"] = 3
	obj:Notify()
	local _loadstring = obj.loadstring
	obj:HttpGet()
	-- str: "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
	obj["Time"] = 3
	local _pairs = obj.pairs
	local _game = obj.game
	local _Name = obj.Name
	-- str: "lower"
	-- str: "find"
	obj.fly = val
	local _CoreGui = obj.CoreGui
	obj:GetChildren()
end

local function PROTO506(val)
	SPEAR_Speed = val
end

local function PROTO507(val)
	obj:FindFirstChild()
	obj.EmperorGun = val
	obj:FindFirstChild()
	obj.gun = val
	local Character
	obj:FindFirstChild()
	-- str: "Twist of Fate"
	obj:FindFirstChild()
	-- str: "Right Arm"
end

local function PROTO508(val)
	obj["Description"] = "AKTIF!"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Infinite Pursuit"
	obj:Notify()
	obj["Title"] = "Infinite Pursuit"
	obj["Description"] = "NONAKTIF!"
	obj["Time"] = 2
end

local function PROTO509(val)
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	local _pcall = obj.pcall
	local _cb = PROTO510
	local _tick = obj.tick
end

local function PROTO510(val)
	local _pairs = obj.pairs
	obj:GetDescendants()
	obj:GetAttribute()
	obj.ProgressRepair = val
	local table
	obj:GetAttribute()
	obj.RepairProgress = val
	obj:IsA()
	obj.Model = val
	local _Name = obj.Name
	-- compare: "Generator"
end

local function PROTO511(val)
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChildOfClass()
	obj.Animator = val
	local Character
	local _RepairAnimTrack = obj.RepairAnimTrack
	local _RepairAnimTrack = obj.RepairAnimTrack
	local _IsPlaying = obj.IsPlaying
	local _pcall = obj.pcall
	local _cb = PROTO512
end

local function PROTO512(val)
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Animation = val
	obj["AnimationId"] = "rbxassetid://92960319113695"
	obj.Priority = val
	local _RepairAnimTrack = obj.RepairAnimTrack
	obj:Play()
	obj:LoadAnimation()
	local _r = RepairAnimTrack
	local _RepairAnimTrack = obj.RepairAnimTrack
	local _Enum = obj.Enum
	local _AnimationPriority = obj.AnimationPriority
	local _Action = obj.Action
end

local function PROTO513(val)
	local _EnableUnlimitedVault = obj.EnableUnlimitedVault
	local _DisableUnlimitedVault = obj.DisableUnlimitedVault
end

local function PROTO514(val)
	local _pcall = obj.pcall
	local _cb = PROTO515
	obj:Notify()
	obj["Title"] = "Fake Generator"
	obj["Description"] = "GUI Fake Generator berhasil dimuat!"
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Fake Generator!"
	obj["Time"] = 3
end

local function PROTO515(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://pastefy.app/cjJ9sNKl/raw"
end

local function PROTO516(val)
	local _pairs = obj.pairs
	local _Name = obj.Name
	obj:GetPlayers()
	local _sort = obj.sort
	local _table = obj.table
	local _insert = obj.insert
end

local function PROTO517(val)
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Nonaktif!"
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Not Ready Yet!"
	obj["Title"] = "Invisibility"
	obj["Description"] = "Aktif!"
	obj["Time"] = 2
	obj["Time"] = 2
	obj:Notify()
	local _pcall = obj.pcall
	local _cb = PROTO518
	local _task = obj.task
	local _wait = obj.wait
	obj["Time"] = 2
	local _cb = PROTO519
end

local function PROTO518(val)
	local _enable = obj.enable
end

local function PROTO519(val)
	local _disable = obj.disable
end

local function PROTO520(val)
	-- (no semantic content extracted)
end

local function PROTO521(val)
	local _getPistolTarget = obj.getPistolTarget
	local _AbsoluteSize = obj.AbsoluteSize
	-- str: "X"
	local _MouseButton2 = obj.MouseButton2
	-- str: "X"
	-- str: "X"
	-- str: "X"
	-- str: "X"
	-- str: "X"
	-- str: "X"
	-- str: "Y"
	-- str: "Y"
	-- str: "Y"
	local Aim_Silent
	obj:FindFirstChild()
	obj.PlayerGui = val
	-- str: "Y"
	-- str: "Y"
	-- str: "Y"
	local _r = lockedTarget
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	-- str: "Gui-mob"
	obj:GetAttribute()
	obj.spearmode = val
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	-- str: "Survivor-mob"
	local _isChargingPistol = obj.isChargingPistol
	-- str: "Y"
	-- str: "Y"
	local _Visible = obj.Visible
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	obj:FindFirstChild()
	-- str: "Slasher-mob"
	local Flash_Silent
	obj:FindFirstChild()
	local _getPistolTarget = obj.getPistolTarget
	obj:FindFirstChild()
	obj.Controls = val
	local _r = lockedTarget
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	-- str: "Y"
	-- str: "Y"
	obj:FindFirstChild()
	obj.attack = val
	local _Position = obj.Position
	local _AbsolutePosition = obj.AbsolutePosition
	local _AbsoluteSize = obj.AbsoluteSize
	-- str: "X"
	-- str: "X"
	-- str: "X"
end

local function PROTO522(val)
	obj:Notify()
	-- str: "Self Heal: DISABLED"
	local _GetRole = obj.GetRole
	obj:Notify()
	-- str: "Kamu harus Survivor!"
	local SelfHeal
	obj:SetValue()
	-- str: "Self Heal: ENABLED (Tanpa Animasi)"
	obj:Killer()
end

local function PROTO523(val)
	local _task = obj.task
	local _wait = obj.wait
	obj:SetAttribute()
	obj.lungeboost = val
end

local function PROTO524(val)
	local InfLakeMistJason
	KILLER_InfLakeMist = val
	local _NEX_StartJasonLakeMistBypass = obj.NEX_StartJasonLakeMistBypass
	local _NEX_StopJasonLakeMistBypass = obj.NEX_StopJasonLakeMistBypass
end

local function PROTO525(val)
	Enabled = val
end

local function PROTO526(val)
	Killer_InfAbyssal = val
end

local function PROTO527(val)
	obj.OFF = val
	obj["Title"] = "Pandu Hub"
	obj.Description = val
	obj["Time"] = 2
	obj:Notify()
end

local function PROTO528(val)
	local _pairs = obj.pairs
	obj:GetChildren()
	local _string = obj.string
	local _sub = obj.sub
	local _Name = obj.Name
	-- namecall: "-mob"
	obj:FindFirstChild()
	obj.PlayerGui = val
	local _Name = obj.Name
	-- compare: "Survivor-mob"
end

local function PROTO529(val)
	Veil_LeadMultiplier = val
end

local function PROTO530(val)
	local _Character = obj.Character
	obj:GetPlayers()
	local _Name = obj.Name
	local _table = obj.table
	local _table = obj.table
	local _insert = obj.insert
	local _pairs = obj.pairs
end

local function PROTO531(val)
	local Character
	local _math = obj.math
	local _huge = obj.huge
	local _pairs = obj.pairs
	local _GetAllGenerators = obj.GetAllGenerators
	local _Position = obj.Position
	local _Position = obj.Position
	local _pairs = obj.pairs
	local _Magnitude = obj.Magnitude
end

local function PROTO532(val)
	local _getNearestGenPoint = obj.getNearestGenPoint
	local _DoMultiRepairPlain = obj.DoMultiRepairPlain
	local _MouseButton1 = obj.MouseButton1
	local _isGeneratorPromptVisible = obj.isGeneratorPromptVisible
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _Parent = obj.Parent
	local _BypassGenEnabled = obj.BypassGenEnabled
end

local function PROTO533(val)
	local _task = obj.task
	local _cb = PROTO534
end

local function PROTO534(val)
	local _Position = obj.Position
	local _Position = obj.Position
	local _Magnitude = obj.Magnitude
	local Character
	local _ProcessedGens = obj.ProcessedGens
	local _task = obj.task
	local _pairs = obj.pairs
	local _GetGeneratorPoints = obj.GetGeneratorPoints
	local _pairs = obj.pairs
	local _Parent = obj.Parent
	obj.HumanoidRootPart = val
end

local function PROTO535(val)
	local _SpeedInputConnection = obj.SpeedInputConnection
	obj:Disconnect()
	local _SpeedInputConnection = obj.SpeedInputConnection
	local _SpeedInputConnection = obj.SpeedInputConnection
end

local function PROTO536(val)
	Aim_SilentVeil = val
end

local function PROTO537(val)
	obj["FieldOfView"] = 70
	local _CurrentCamera = obj.CurrentCamera
	local _TargetFOV = obj.TargetFOV
	obj.FieldOfView = val
	local _r = FOVEnabled
	local _workspace = obj.workspace
end

local function PROTO538(val)
	local _Unit = obj.Unit
	local _executeSilentAimFire = obj.executeSilentAimFire
	local _math = obj.math
	local _max = obj.max
	local _MouseButton1 = obj.MouseButton1
	local _Position = obj.Position
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton2 = obj.MouseButton2
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetAttribute()
	obj.special = val
	local _workspace = obj.workspace
	local _Gravity = obj.Gravity
	local Veil_LeadMultiplier
	obj:FindFirstChild()
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local Character
	local _r = lockedTarget
	local _isAimingFlash = obj.isAimingFlash
	local _MoveDirection = obj.MoveDirection
	local _Magnitude = obj.Magnitude
	local SPEAR_Gravity
	local _isAimingFlash = obj.isAimingFlash
	local SpearSmart_enable
	obj:IsA()
	obj.Model = val
	local SPEAR_Speed
	local _Position = obj.Position
	local CFrame
	local _LookVector = obj.LookVector
	local _isChargingPistol = obj.isChargingPistol
	local AIM_Auto
	local _Position = obj.Position
	local _Vector3 = obj.Vector3
	local _new = obj.new
	local _Parent = obj.Parent
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local _AssemblyLinearVelocity = obj.AssemblyLinearVelocity
	local Aim_SilentVeil
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _r = lockedTarget
	local _getClosestSurvivor = obj.getClosestSurvivor
	local _new = obj.new
	-- str: "X"
	-- str: "Z"
	local _Magnitude = obj.Magnitude
	obj:IsA()
	obj.BasePart = val
	local _task = obj.task
	local _delay = obj.delay
	local _cb = PROTO539
	local _new = obj.new
	local _pcall = obj.pcall
	local _cb = PROTO540
	local _Vector3 = obj.Vector3
	local _Unit = obj.Unit
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _clamp = obj.clamp
	local _math = obj.math
	local _clamp = obj.clamp
	local _Parent = obj.Parent
	local _isChargingPistol = obj.isChargingPistol
	local _MoveDirection = obj.MoveDirection
	local _WalkSpeed = obj.WalkSpeed
end

local function PROTO539(val)
	-- (no semantic content extracted)
end

local function PROTO540(val)
	local Remotes
	local _Killers = obj.Killers
	local _Veil = obj.Veil
	local _Spearthrow = obj.Spearthrow
	obj:FireServer()
end

local function PROTO541(val)
	obj["Description"] = "Distory Gui"
	obj:SetValue()
	local AutoParryKey
	obj:SetValue()
	obj:Notify()
	obj["Title"] = "Auto Parry GUI"
	local Gui
	local AutoParry
	obj:Notify()
	obj["Title"] = "Auto Parry GUI"
	obj["Description"] = "Gui Loaded"
	obj["Time"] = 2
	local Surv_AutoParry
	obj["Enabled"] = true
end

local function PROTO542(val)
	local _game = obj.game
	local _Players = obj.Players
	local _LocalPlayer = obj.LocalPlayer
	local Connection
	obj:Disconnect()
	local _CharacterAdded = obj.CharacterAdded
	obj:Connect()
	Connection = val
end

local function PROTO543(val)
	local _task = obj.task
	local Character
	local _cb = PROTO544
	local _task = obj.task
	local _wait = obj.wait
	obj:FindFirstChild()
	obj:FindFirstChild()
	-- str: "Right Leg"
end

local function PROTO544(val)
	obj["MeshId"] = "rbxassetid://902942096"
	obj["TextureID"] = "rbxassetid://902843398"
	-- str: "Right Leg"
	local _new = obj.new
	obj.WeldConstraint = val
	local Head
	obj["Transparency"] = 1
	obj:FindFirstChild()
	obj.face = val
	obj:Destroy()
	-- str: "Right Leg"
	obj.Part0 = val
	obj.Part1 = val
	obj.Parent = val
	-- str: "Right Leg"
	local _new = obj.new
	obj.MeshPart = val
	obj["Name"] = "KorlessHead"
	obj.Size = val
	local _new = obj.new
	local _CFrame = obj.CFrame
	obj.CFrame = val
end

local function PROTO545(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO546(val)
	local _cb = PROTO547
	local _task = obj.task
end

local function PROTO547(val)
	-- str: "_G"
	local _MengHub = obj.MengHub
	local _pcall = obj.pcall
	local _cb = PROTO548
	local _pcall = obj.pcall
	local _cb = PROTO549
	local _task = obj.task
	local _wait = obj.wait
	-- str: "_G"
	local _MengHub = obj.MengHub
	local _print = obj.print
	-- str: "Invisibility loaded"
	local _warn = obj.warn
	-- str: "Gagal load Invisibility:"
	local _tostring = obj.tostring
	local _pcall = obj.pcall
	local _cb = PROTO550
	-- str: "_G"
	local _MengHub = obj.MengHub
	local _Invisible = obj.Invisible
end

local function PROTO548(val)
	obj["Time"] = 2
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Ready!"
	local _Library = obj.Library
end

local function PROTO549(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://raw.githubusercontent.com/GrexXMeng/Mengs/main/Invisibility"
end

local function PROTO550(val)
	local _Library = obj.Library
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Gagal load script!"
	obj["Time"] = 3
	local _Library = obj.Library
end

local function PROTO551(val)
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO552(val)
	obj.BackgroundColor3 = val
	obj.TextColor3 = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["Text"] = "INVIS [ON]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj:FindFirstChild()
	obj.Frame = val
	obj.BackgroundColor3 = val
	local _fromRGB = obj.fromRGB
	obj.Color = val
	local Gui
	obj.ActionButton = val
	obj:FindFirstChild()
	obj.TextColor3 = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Color = val
	local _fromRGB = obj.fromRGB
	obj["Text"] = "INVIS [OFF]"
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
end

local function PROTO553(val)
	obj["Title"] = "Speed Input"
	obj["Description"] = "Speed Boost dimatikan"
	local _r = SpeedInputEnabled
	obj.Description = val
	obj["Time"] = 3
	local _stopSpeedInputMode = obj.stopSpeedInputMode
	obj:Notify()
	obj["Title"] = "Speed Input"
	local _startSpeedInputMode = obj.startSpeedInputMode
	local _SpeedInputValue = obj.SpeedInputValue
	-- str: ")"
end

local function PROTO554(val)
	local _pcall = obj.pcall
end

local function PROTO555(val)
	local Remotes
	obj:FindFirstChild()
	obj.Killers = val
	obj:FindFirstChild()
	obj.Deactivatefromclient = val
	obj:GetAttribute()
	obj.Pursuit = val
	obj:SetAttribute()
	obj.Pursuit = val
	local _Killers = obj.Killers
	obj:FindFirstChild()
	obj.Jason = val
	obj:FireServer()
	local Character
	obj:FindFirstChild()
	obj.Remotes = val
end

local function PROTO556(val)
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO557
end

local function PROTO557(val)
	local KILLER_InfLakeMist
	local _pcall = obj.pcall
	local _cb = PROTO558
	local _task = obj.task
	local _wait = obj.wait
end

local function PROTO558(val)
	obj:SetAttribute()
	obj:GetAttribute()
	obj.speedboost = val
	obj:SetAttribute()
	obj.speedboost = val
	local Character
	obj:GetAttribute()
	obj.LakeMist = val
end

local function PROTO559(val)
	local _pcall = obj.pcall
	local _cb = PROTO560
	local _cancel = obj.cancel
end

local function PROTO560(val)
	obj.LakeMist = val
	obj:SetAttribute()
	obj.speedboost = val
end

local function PROTO561(val)
	local _ipairs = obj.ipairs
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	-- str: "rbxassetid://"
	obj.AnimationId = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:Stop()
	local _Team = obj.Team
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _new = obj.new
	obj.Animation = val
	local _Character = obj.Character
	local _Instance = obj.Instance
	obj:FindFirstChildOfClass()
	obj.Animator = val
	obj:LoadAnimation()
	obj:Play()
	obj:AdjustWeight()
	local _task = obj.task
	local _wait = obj.wait
	obj:Destroy()
	local _task = obj.task
	local _wait = obj.wait
	local _AntiAutoParryEnabled = obj.AntiAutoParryEnabled
	local _math = obj.math
	local _random = obj.random
	local _Magnitude = obj.Magnitude
	local _Team = obj.Team
	local _Name = obj.Name
	obj:Survivors()
	local Character
	local _Position = obj.Position
end

local function PROTO562(val)
	local _pcall = obj.pcall
	local _cb = PROTO563
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Aim Lock!"
	obj:Notify()
	obj["Title"] = "Aim Lock"
	obj["Description"] = "Aim Lock berhasil dimuat!"
	obj["Time"] = 3
	obj:Notify()
end

local function PROTO563(val)
	local _loadstring = obj.loadstring
	obj:HttpGet()
	-- str: "https://pastefy.app/5zsm8N7G/raw"
end

local function PROTO564(val)
	Pistol_BlockKnocked = val
end

local function PROTO565(val)
	local _RenderStepped = obj.RenderStepped
	obj:Connect()
	local _cb = PROTO566
	obj.NEX_CureFlaskLaserThread = val
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserThread = obj.NEX_CureFlaskLaserThread
	local _getgenv = obj.getgenv
	local _game = obj.game
	obj.RunService = val
end

local function PROTO566(val)
	obj:Disconnect()
	local _getgenv = obj.getgenv
	local KILLER_FlaskLaser
	local _pcall = obj.pcall
	local _NEX_UpdateCureFlaskLaser = obj.NEX_UpdateCureFlaskLaser
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserThread = obj.NEX_CureFlaskLaserThread
	obj.NEX_CureFlaskLaserThread = val
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
	obj.NEX_CureFlaskLaserPart = val
	local _pcall = obj.pcall
	local _cb = PROTO567
	local _getgenv = obj.getgenv
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserThread = obj.NEX_CureFlaskLaserThread
end

local function PROTO567(val)
	obj:Destroy()
	local _getgenv = obj.getgenv
	local _NEX_CureFlaskLaserPart = obj.NEX_CureFlaskLaserPart
end

local function PROTO568(val)
	local _getgenv = obj.getgenv
	local _NEX_JeffCooldownBypassThread = obj.NEX_JeffCooldownBypassThread
	local _getgenv = obj.getgenv
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO569
	obj.NEX_JeffCooldownBypassThread = val
end

local function PROTO569(val)
	local KILLER_InfFrenzy
	local _wait = obj.wait
	local _cb = PROTO570
	local _task = obj.task
	local _getgenv = obj.getgenv
	obj.NEX_JeffCooldownBypassThread = val
end

local function PROTO570(val)
	obj.Frenzy = val
	obj:GetAttribute()
	obj.Frenzy = val
	local Character
end

local function PROTO571(val)
	local _r = lockedAimbotTarget
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _Touch = obj.Touch
	local _r = lockedAimbotTarget
	local _StopInfiniteAbyssal = obj.StopInfiniteAbyssal
	local _KeyCode = obj.KeyCode
	local _KeyCode = obj.KeyCode
	-- str: "Q"
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _MouseButton1 = obj.MouseButton1
	local _StopInfiniteAbyssal = obj.StopInfiniteAbyssal
end

local function PROTO572(val)
	local Pistol_BlockKnocked
	local Character
	local _getTargetPosition = obj.getTargetPosition
	local _Unit = obj.Unit
	local _pcall = obj.pcall
	local _cb = PROTO573
	local _IsDowned = obj.IsDowned
end

local function PROTO573(val)
	obj:FireServer()
end

local function PROTO574(val)
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Block Peluru"
	obj["Description"] = "Nonaktif - Peluru normal kembali"
	Enabled = val
	obj["Title"] = "Block Peluru"
	obj["Description"] = "AKTIF - Peluru TIDAK akan keluar"
	obj["Time"] = 4
end

local function PROTO575(val)
	local _r = NoSlowdownEnabled
end

local function PROTO576(val)
	obj.MapPredictEnabled = val
	local _game = obj.game
	obj:GetService()
	obj.CoreGui = val
	local _cleanMapGui = obj.cleanMapGui
	local _cb = PROTO577
	local _r = cleanMapGui
	local _cb = PROTO578
	local _r = buildMapGui
	local _cb = PROTO579
	local _r = detectMap
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO580
	local _getgenv = obj.getgenv
end

local function PROTO577(val)
	local MapPredictUI
	obj:Destroy()
	obj:FindFirstChild()
	obj.MapPredictUI = val
end

local function PROTO578(val)
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.2
	obj["Name"] = "MapName"
	local _new = obj.new
	obj.UICorner = val
	obj["ZIndex"] = 2
	local _new = obj.new
	obj.UICorner = val
	obj.TextColor3 = val
	obj.TextXAlignment = val
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["BorderSizePixel"] = 0
	obj["Text"] = "MAP"
	local _Enum = obj.Enum
	obj["BackgroundTransparency"] = 1
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	obj.Position = val
	obj["Text"] = "Status: —"
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _Gotham = obj.Gotham
	obj.Font = val
	obj["TextSize"] = 9.5
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _TextXAlignment = obj.TextXAlignment
	local _Right = obj.Right
	local _Instance = obj.Instance
	obj.TextLabel = val
	obj["Name"] = "MapStatus"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.TextColor3 = val
	obj["Name"] = "MainFrame"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj["TextSize"] = 8
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	obj["TextSize"] = 11.5
	local _Color3 = obj.Color3
	obj.Position = val
	local _Vector2 = obj.Vector2
	local _new = obj.new
	local Instance
	local _new = obj.new
	obj.ScreenGui = val
	obj["Name"] = "MapPredictUI"
	obj["IgnoreGuiInset"] = true
	local _Right = obj.Right
	obj.TextXAlignment = val
	obj["RichText"] = true
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Position = val
	obj["Text"] = "Scanning..."
	local _Enum = obj.Enum
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.35
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj["BackgroundTransparency"] = 1
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _UDim2 = obj.UDim2
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.TextLabel = val
	obj["Name"] = "Badge"
	obj["Transparency"] = 0.4
	local _Instance = obj.Instance
	local _new = obj.new
	obj:FindFirstChild()
	obj.MapPredictUI = val
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Position = val
	local _Color3 = obj.Color3
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _fromRGB = obj.fromRGB
	local MapPredictUI
	local _new = obj.new
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.AnchorPoint = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
end

local function PROTO579(val)
	-- str: "Site 68"
	obj.LargeBoulder01 = val
	obj:FindFirstChild()
	obj.HooksMeat = val
	-- str: "Firelink Shrine"
	-- str: "SCP-173 Room"
	obj:FindFirstChild()
	-- str: "White Armored Car"
	-- str: "Valdelobos Village"
	-- str: "Mount Massive Asylum"
	-- str: "Woodview Cabin"
	obj:FindFirstChild()
	obj.Rooftop = val
	-- str: "BLOODBATH! Club"
	obj:FindFirstChild()
	obj.Gate = val
	obj:FindFirstChild()
	-- str: "random shakes"
	-- str: "Mercy Hospital Rooftop"
	obj:FindFirstChild()
	obj.vfx = val
	obj:FindFirstChild()
	obj.Dumbster = val
	obj:FindFirstChild()
	obj.Bldg_Addon_RooftopUnit_A = val
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	obj:FindFirstChild()
	-- str: "water pump"
	obj:FindFirstChild()
	-- str: "SCP-205 Room"
	-- str: "The Bay Harbor"
end

local function PROTO580(val)
	local _detectMap = obj.detectMap
	obj.MainFrame = val
	local _pcall = obj.pcall
	local _cb = PROTO581
	obj.Enabled = val
	local _MapName = obj.MapName
	obj["Text"] = "Map: Unknown"
	local _MapStatus = obj.MapStatus
	local _MapName = obj.MapName
	obj.TextColor3 = val
	obj.TextColor3 = val
	obj["Text"] = "Status: Lobby"
	local _MapStatus = obj.MapStatus
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	local _buildMapGui = obj.buildMapGui
	obj:FindFirstChild()
	local _getgenv = obj.getgenv
	local _MapPredictEnabled = obj.MapPredictEnabled
	local _MapName = obj.MapName
	obj["Text"] = "Map: —"
	local _MapStatus = obj.MapStatus
	obj["Text"] = "Status: Lobby"
	local _MapName = obj.MapName
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _cleanMapGui = obj.cleanMapGui
	local _MapStatus = obj.MapStatus
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Unknown = val
	obj.TextColor3 = val
	local _MapStatus = obj.MapStatus
	obj["Text"] = "Status: Setting up..."
	local _MapStatus = obj.MapStatus
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _task = obj.task
	local _wait = obj.wait
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	obj.Text = val
	local _MapStatus = obj.MapStatus
	obj["Text"] = "Status: Lobby"
	local _MapStatus = obj.MapStatus
end

local function PROTO581(val)
	local Team
	local _Name = obj.Name
end

local function PROTO582(val)
	local _Instance = obj.Instance
	local _new = obj.new
	obj.ScreenGui = val
	obj["Name"] = "NEX_KillerPerksGui"
	obj["Name"] = "Holder"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamSemibold = obj.GothamSemibold
	obj.Font = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	local _Enum = obj.Enum
	obj.Color = val
	obj["Thickness"] = 1
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.15
	obj["BorderSizePixel"] = 0
	obj.Minimize = val
	obj.Size = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	obj.Frame = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _new = obj.new
	obj.Frame = val
	obj["Name"] = "Panel"
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _Font = obj.Font
	local _GothamMedium = obj.GothamMedium
	obj.Font = val
	obj["Active"] = true
	obj.Parent = val
	local _Instance = obj.Instance
	local _pcall = obj.pcall
	local _cb = PROTO583
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _Instance = obj.Instance
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	obj["IgnoreGuiInset"] = true
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj.TextColor3 = val
	local _InputBegan = obj.InputBegan
	obj:Connect()
	local _cb = PROTO584
	local _UDim = obj.UDim
	local _new = obj.new
	obj.TextXAlignment = val
	local _Enum = obj.Enum
	local _TextYAlignment = obj.TextYAlignment
	local _Top = obj.Top
	obj.TextYAlignment = val
	obj:GetService()
	obj.UserInputService = val
	local _game = obj.game
	obj:GetService()
	obj.CoreGui = val
	local _game = obj.game
	obj:GetService()
	obj.Workspace = val
	local _LocalPlayer = obj.LocalPlayer
	local _cb = PROTO586
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj["Transparency"] = 0.3
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Parent = val
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO588
	obj.Close = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj["TextSize"] = 11
	obj.TextLabel = val
	local _UDim2 = obj.UDim2
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	local _new = obj.new
	obj.Size = val
	local _new = obj.new
	obj.TextLabel = val
	obj["Name"] = "KillerPerksText"
	local _game = obj.game
	obj:GetService()
	obj.Players = val
	local _game = obj.game
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Size = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.UIStroke = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _InputChanged = obj.InputChanged
	obj:Connect()
	local _cb = PROTO589
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	local _Left = obj.Left
	obj.TextXAlignment = val
	obj.Parent = val
	local _cb = PROTO590
	local _cb = PROTO591
	local _MouseButton1Click = obj.MouseButton1Click
	obj:Connect()
	local _cb = PROTO592
	local _Enum = obj.Enum
	local _TextXAlignment = obj.TextXAlignment
	local _Left = obj.Left
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj["TextSize"] = 11
	obj.Parent = val
	local _MouseButton1Click = obj.MouseButton1Click
	obj:Connect()
	local _cb = PROTO594
	local _cb = PROTO595
	local _cb = PROTO596
	local _cb = PROTO597
	local _cb = PROTO599
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	local _new = obj.new
end

local function PROTO583(val)
	obj:Destroy()
end

local function PROTO584(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _MouseButton1 = obj.MouseButton1
	local _UserInputType = obj.UserInputType
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _Position = obj.Position
	local Position
	obj:Connect()
	local _cb = PROTO585
end

local function PROTO585(val)
	local UserInputState
	local _Enum = obj.Enum
	local _UserInputState = obj.UserInputState
	local _End = obj.End
end

local function PROTO586(val)
	obj:WaitForChild()
	obj.PlayerGui = val
	local _pcall = obj.pcall
	local _cb = PROTO587
end

local function PROTO587(val)
	-- (no semantic content extracted)
end

local function PROTO588(val)
	Size = val
	local _math = obj.math
	local _max = obj.max
	Text = val
	local _math = obj.math
	local _max = obj.max
	local _task = obj.task
	local _wait = obj.wait
	local _math = obj.math
	local _min = obj.min
	local _UDim2 = obj.UDim2
	local _new = obj.new
end

local function PROTO589(val)
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
	local _Touch = obj.Touch
	local _MouseMovement = obj.MouseMovement
	local _new = obj.new
	-- str: "X"
	local _Scale = obj.Scale
	-- str: "X"
	local _Offset = obj.Offset
	-- str: "X"
	-- str: "Y"
	local _Scale = obj.Scale
	-- str: "Y"
	local _Offset = obj.Offset
	-- str: "Y"
	Position = val
	local _Position = obj.Position
	local _UDim2 = obj.UDim2
	local _UserInputType = obj.UserInputType
	local _Enum = obj.Enum
	local _UserInputType = obj.UserInputType
end

local function PROTO590(val)
	local _UDim = obj.UDim
	obj.CornerRadius = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _Color3 = obj.Color3
	local _new = obj.new
	obj.Position = val
	obj.Text = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.TextColor3 = val
	obj["TextSize"] = 9
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamMedium = obj.GothamMedium
	obj.Font = val
	obj.TextButton = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
end

local function PROTO591(val)
	obj.Minimize = val
	obj.Show = val
	Size = val
	local _UDim2 = obj.UDim2
	Text = val
	Visible = val
	local _new = obj.new
end

local function PROTO592(val)
	obj:SetValue()
	local KillerPerksToggle
	local _cb = PROTO593
end

local function PROTO593(val)
	obj:Destroy()
end

local function PROTO594(val)
	local _tostring = obj.tostring
	-- str: "gsub"
	-- str: ">"
	-- str: "gsub"
	-- str: "gsub"
	-- str: "<"
	-- str: "&lt;"
	-- str: "&gt;"
	-- str: "&"
	-- str: "&amp;"
end

local function PROTO595(val)
	obj["right arm"] = true
	obj["left leg"] = true
	obj["right leg"] = true
	-- str: "lower"
	-- str: "gsub"
	-- str: "%s+$"
	-- str: "match"
	-- str: "^(.+)%s+(%d+)$"
	obj["head"] = true
	obj["humanoid"] = true
	obj["humanoidrootpart"] = true
	obj["left arm"] = true
	-- str: "gsub"
	-- str: "^%s+"
	local _tostring = obj.tostring
end

local function PROTO596(val)
	local _Team = obj.Team
	local _Name = obj.Name
	local _Team = obj.Team
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	-- str: "lower"
	-- str: "find"
	obj.killer = val
end

local function PROTO597(val)
	obj.Name = val
	obj.Level = val
	obj:FindFirstChild()
	local _DisplayName = obj.DisplayName
	local _Name = obj.Name
	local _ipairs = obj.ipairs
	local _table = obj.table
	local _sort = obj.sort
	local _cb = PROTO598
	local _Character = obj.Character
	obj:FindFirstChild()
	local _Name = obj.Name
	local _insert = obj.insert
end

local function PROTO598(val)
	local _tostring = obj.tostring
	local _Name = obj.Name
	local _tostring = obj.tostring
	local _Name = obj.Name
end

local function PROTO599(val)
	obj.Unknown = val
	local _table = obj.table
	local _concat = obj.concat
	local _table = obj.table
	local _insert = obj.insert
	local _math = obj.math
	local _min = obj.min
	-- str: "</font>"
	-- str: "<font color=\"rgb(200,200,200)\">- "
	local _tostring = obj.tostring
	local _Level = obj.Level
	-- str: " lvl "
	local _DisplayName = obj.DisplayName
	local _Level = obj.Level
	local _table = obj.table
	local _insert = obj.insert
	-- str: "<font color=\"rgb(200,200,200)\">- Waiting for perk data...</font>"
	local _Name = obj.Name
	local _DisplayName = obj.DisplayName
	local _Name = obj.Name
	local _ipairs = obj.ipairs
	obj:GetPlayers()
	-- str: "</font>]"
end

local function PROTO600(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _UDim = obj.UDim
	local _new = obj.new
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local _fromRGB = obj.fromRGB
	obj:FindFirstChild()
	obj.StunUI = val
	obj.CornerRadius = val
	obj.bill = val
	obj.fill = val
	obj.timer = val
	obj["duration"] = 2.2
	obj["startTime"] = 0
	local _fromRGB = obj.fromRGB
	obj.Position = val
	local _cb = PROTO601
	obj:GetAttributeChangedSignal()
	obj.IsStunned = val
	obj:Connect()
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.3
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _UDim = obj.UDim
	local _new = obj.new
	obj.Position = val
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	local _Instance = obj.Instance
	local _new = obj.new
	obj.UICorner = val
	local _Instance = obj.Instance
	obj.BillboardGui = val
	obj.Parent = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.TextLabel = val
	obj.TextColor3 = val
	obj["TextScaled"] = true
	local _Enum = obj.Enum
	local _Font = obj.Font
	local _GothamBold = obj.GothamBold
	obj.Font = val
	local _UDim2 = obj.UDim2
	obj.Size = val
	local _Vector3 = obj.Vector3
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj["Name"] = "StunUI"
	obj.Adornee = val
	obj["AlwaysOnTop"] = true
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	local _Instance = obj.Instance
	local _new = obj.new
	obj.Frame = val
	obj:Destroy()
	local _cb = PROTO603
	obj:GetAttributeChangedSignal()
	obj.Immobile = val
	obj:Connect()
	local _cb = PROTO604
	obj.StudsOffsetWorldSpace = val
	local _new = obj.new
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	local Heartbeat
	obj:Connect()
	local _cb = PROTO605
	obj.Size = val
	local _UDim2 = obj.UDim2
	local _new = obj.new
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "⚡ STUNNED"
	local _Color3 = obj.Color3
	local _UDim2 = obj.UDim2
	local _new = obj.new
end

local function PROTO601(val)
	local _task = obj.task
	local _cancel = obj.cancel
	local _timer = obj.timer
	local _bill = obj.bill
	obj["Enabled"] = true
	obj["duration"] = 2.2
	local _tick = obj.tick
	obj.timer = val
	local HitSoundEnabled
	obj.startTime = val
	local _timer = obj.timer
	local _task = obj.task
	local _spawn = obj.spawn
	local _cb = PROTO602
	local _PlayHitSound = obj.PlayHitSound
end

local function PROTO602(val)
	local fill
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local duration
	local _task = obj.task
	local _wait = obj.wait
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local bill
	obj.Size = val
	obj.BackgroundColor3 = val
	obj.BackgroundColor3 = val
	obj.BackgroundColor3 = val
	local _tick = obj.tick
	local startTime
	local _Color3 = obj.Color3
	local _fromRGB = obj.fromRGB
	local _UDim2 = obj.UDim2
	local _Enabled = obj.Enabled
end

local function PROTO603(val)
	obj:GetAttribute()
	obj.IsStunned = val
end

local function PROTO604(val)
	obj:GetAttribute()
	obj.Immobile = val
end

local function PROTO605(val)
	local _bill = obj.bill
	local _Enabled = obj.Enabled
	obj:Disconnect()
	obj:GetAttribute()
	obj.IsStunned = val
	local Parent
	obj:GetAttribute()
	obj.Immobile = val
	obj:Disconnect()
end

local function PROTO606(val)
	local _bill = obj.bill
	obj:Destroy()
	local _bill = obj.bill
	local _task = obj.task
	local _cancel = obj.cancel
	local _timer = obj.timer
	local _timer = obj.timer
end

local function PROTO607(val)
	EnableJitter = val
	obj:Notify()
	obj.OFF = val
end

local function PROTO608(val)
	local _clearLaser = obj.clearLaser
end

local function PROTO609(val)
	obj:Connect()
	local _cb = PROTO610
	obj:GetAttributeChangedSignal()
	obj.HookCount = val
end

local function PROTO610(val)
	local Name
	obj:GetAttribute()
	obj.HookCount = val
	local _UpdateHookESP = obj.UpdateHookESP
end

local function PROTO611(val)
	local _task = obj.task
	local _wait = obj.wait
	local _SetupHookDetection = obj.SetupHookDetection
end

local function PROTO612(val)
	obj:Notify()
	obj["Title"] = "Teleport"
	local _UpdatePlayerList = obj.UpdatePlayerList
	obj:SetValues()
	obj.Description = val
	obj["Time"] = 3
	-- str: " player)"
end

local function PROTO613(val)
	local _Character = obj.Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _HumanoidRootPart = obj.HumanoidRootPart
	local _CFrame = obj.CFrame
	local _Vector3 = obj.Vector3
	local _new = obj.new
	obj.CFrame = val
	local Character
	obj:FindFirstChild()
	local _Character = obj.Character
	obj:FindFirstChild()
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "Pilih pemain terlebih dulu!"
	obj["Time"] = 3
end

local function PROTO614(val)
	local _task = obj.task
	local _wait = obj.wait
	obj:RemoveTag()
	obj.Blocked = val
	local _ipairs = obj.ipairs
	obj:GetTagged()
	obj.Blocked = val
end

local function PROTO615(val)
	obj["Title"] = "Anti Slow Vault"
	obj["Description"] = "Off"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Anti Slow Vault"
	obj["Description"] = "On"
	Time = val
	Surv_PerfectVault = val
	obj:Notify()
end

local function PROTO616(val)
	ESP_ItemIcon = val
	local ESP_Master
	local _UpdatePlayerESP = obj.UpdatePlayerESP
end

local function PROTO617(val)
	-- (no semantic content extracted)
end

local function PROTO618(val)
	-- (no semantic content extracted)
end

local function PROTO619(val)
	obj["Title"] = "FPS Cap"
	-- str: " FPS"
	obj["Title"] = "FPS Cap"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	local _setfpscap = obj.setfpscap
	obj:Notify()
	obj.Description = val
	obj["Time"] = 2
	local _setfpscap = obj.setfpscap
end

local function PROTO620(val)
	local _MinPlayers = obj.MinPlayers
	local _r = MaxPlayers
	local _math = obj.math
	local _clamp = obj.clamp
	local _math = obj.math
	local _floor = obj.floor
end

local function PROTO621(val)
	local _task = obj.task
	local _wait = obj.wait
	local _pcall = obj.pcall
	local _cb = PROTO622
end

local function PROTO622(val)
	local _ipairs = obj.ipairs
	obj:GetDescendants()
	local Results
	local _Frame = obj.Frame
	local _Close = obj.Close
	obj:IsA()
	obj.LocalScript = val
	obj:Destroy()
	obj:FindFirstChild()
	obj.endscreen = val
	local _workspace = obj.workspace
	obj:FindFirstChild()
	obj.Map = val
	local _Visible = obj.Visible
	local _cb = PROTO623
	local _Visible = obj.Visible
end

local function PROTO623(val)
	local _firesignal = obj.firesignal
	local MouseButton1Click
end

local function PROTO624(val)
	obj["Title"] = "Tools Jerk"
	obj["Description"] = "Tools Jerk berhasil dimuat!"
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Tools Jerk"
	obj["Time"] = 3
	local _pcall = obj.pcall
	local _cb = PROTO625
	obj:Notify()
end

local function PROTO625(val)
	local _loadstring = obj.loadstring
	local _game = obj.game
	obj:HttpGet()
	-- str: "https://pastefy.app/wa3v2Vgm/raw"
end

local function PROTO626(val)
	local _CharacterAdded = obj.CharacterAdded
	obj:Connect()
	local _cb = PROTO627
	obj:GetPropertyChangedSignal()
	obj:Connect()
	local _cb = PROTO628
	local _Character = obj.Character
end

local function PROTO627(val)
	local _TryAttach = obj.TryAttach
end

local function PROTO628(val)
	local _TryAttach = obj.TryAttach
end

local function PROTO629(val)
	local _r = TimeOfDayValue
	local _FullBright = obj.FullBright
	ClockTime = val
end

local function PROTO630(val)
	Killer_BypassCarry = val
	IsActive = val
end

local function PROTO631(val)
	Surv_AutoParry = val
end

local function PROTO632(val)
	Size = val
end

local function PROTO633(val)
	local _ScanMap = obj.ScanMap
	obj.Gate = val
	ESP_Gate = val
	local ESP_Master
end

local function PROTO634(val)
	Surv_Aimbot_Radius = val
end

local function PROTO635(val)
	local _table = obj.table
	local _insert = obj.insert
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _next = obj.next
	obj:IsA()
	obj.Model = val
	obj.Map = val
	local _pairs = obj.pairs
	obj:GetDescendants()
	local _tick = obj.tick
	local _workspace = obj.workspace
	obj:FindFirstChild()
	local _tick = obj.tick
	obj.CorpseCreated0492 = val
	obj:GetAttributes()
	obj:GetAttribute()
end

local function PROTO636(val)
	local Colors
	obj.SCP = val
end

local function PROTO637(val)
	local _TeleportToGenerator = obj.TeleportToGenerator
end


-- ============================================================
-- REMAINING SPECIAL STRINGS (RichText Labels)
-- ============================================================
-- RICHTEXT: [[<font color="rgb(200,200,200)">- ]]
-- RICHTEXT: [[<font color="rgb(200,200,200)">- Waiting for perk data...</font>]]
-- RICHTEXT: [[Killer Perks [<font color="rgb(255,80,80)">]]
-- ============================================================
-- MAIN SCRIPT (UI Builder + Init)
-- ============================================================
local function main()

	-- Load UI Library
	local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/Library.lua"))()
	local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/SaveManager.lua"))()
	local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/ThemeManager.lua"))()

	local Window = Library:CreateWindow({
		Title = "Pandu Hub",
		Footer = "Violence District v2.4.0 | https://discord.gg/panduhub",
		Icon = "94380161420025",
	})

	obj:AddColorPicker({Tooltip = "Jarak trigger teleport", Default = 40, Min = 15, Max = 80})
	obj:AddCheckbox({Text = "Enable Aimbot", Callback = "Enable Aimbot", OnChanged1 = PROTO2})
	obj:Connect({Callback = PROTO3})
	obj:AddSlider({Callback = PROTO9})
	obj:Connect({Pistol_FOV = 150})
	obj:AddRightGroupbox({Killer_Aimbot_MaxDist = 12, Killer_Aimbot_Smoothness = 0.5, Callback = "VD"})
	obj:AddButton({ShowToggleFrameInKeybinds = 1})
	obj:AddSlider({Default = "None", Color = "CreateHookESP", Callback = "None", OnChanged1 = PROTO10, OnChanged2 = PROTO11, OnChanged3 = PROTO12, OnChanged4 = PROTO13, OnChanged5 = PROTO14})
	obj:AddInput({Callback = PROTO15})
	obj:Connect({Default = "1"})
	obj:Connect({Callback = PROTO16})
	obj:Connect()
	obj:AddToggle({Text = "Moonwalk [PC]", Default = "Colors", Rounding = 0, Callback = "spawn", OnChanged1 = PROTO18, OnChanged2 = PROTO19})
	obj:Connect({Default = "None", Callback = PROTO20})
	obj:AddRightGroupbox({GateClientModule = "CharacterAdded"})
	obj:AddToggle()
	obj:AddToggle({Tooltip = "Tampilkan button Moonwalk di layar (pencet button untuk aktif)", Callback = PROTO22, OnChanged1 = PROTO23, OnChanged2 = PROTO25, OnChanged3 = PROTO28})
	obj:AddToggle({Callback = PROTO35})
	obj:AddToggle({Text = "Full Bright", SyncToggleState = 1, Callback = "Full Bright", OnChanged1 = PROTO36, OnChanged2 = PROTO39, OnChanged3 = PROTO40})
	obj:AddToggle({Text = "Skill Hidden No CD", 105374834496520 = "Masked lunge", 138720291317243 = "Masked Tony", 106871536134254 = "Masked Alex", 130593238885843 = "Masked Cobra", 115244153053858 = "Masked Cobra lunge", 74968262036854 = "Hidden Basic", Rounding = 1, Callback = PROTO41, OnChanged1 = PROTO42})
	obj:AddDivider({Callback = PROTO43})
	obj:AddToggle({internal = "Zombie", display = "Zombie (L)"})
	obj:AddKeyPicker({Text = "Killer Stun Indicator", Default = "None", Mode = "Toggle", Callback = PROTO44, OnChanged1 = PROTO45, OnChanged2 = PROTO47, OnChanged3 = PROTO48})
	obj:AddToggle({Tooltip = "Tembus gate tanpa collision", Text = "Gen Name & Progress", Name = "FOVCircleGui_Standalone", Parent = "new", Default = 1, IgnoreGuiInset = 1, Callback = "Gen Name & Progress", OnChanged1 = PROTO49, OnChanged2 = PROTO50, OnChanged3 = PROTO52})
	obj:AddSlider({Text = "Third Person (Killer)", Tooltip = "Mengubah posisi kamera ke belakang karakter", Callback = PROTO53})
	obj:AddTab({Text = "Position Y", Default = 0, Min = -100, Max = 100, Rounding = 0, Callback = PROTO55, OnChanged1 = PROTO57, OnChanged2 = PROTO58, OnChanged3 = PROTO60, OnChanged4 = PROTO63})
	obj:AddTab()
	obj:AddRightGroupbox()
	obj:Connect()
	obj:WaitForChild({Callback = PROTO64, OnChanged1 = PROTO66})
	obj:Connect({Default = "Manual Repair", Callback = "Manual Repair", OnChanged1 = PROTO67})
	obj:AddLeftGroupbox({Text = "Unlimited Vault", Tooltip = "Vault/ lompat jendela tanpa batas (tanpa cooldown)", Rounding = 0, Callback = "Unlimited Vault", OnChanged1 = PROTO68, OnChanged2 = PROTO70, OnChanged3 = PROTO71})
	obj:AddSlider()
	obj:AddRightGroupbox({Text = "Time Of Day", Callback = PROTO72, OnChanged1 = PROTO73, OnChanged2 = PROTO74})
	obj:HttpGet()
	obj:Connect()
	obj:AddSlider({Title = "Gate Color", Max = 100, Rounding = 0, Callback = "Gate Color", OnChanged1 = PROTO75, OnChanged2 = PROTO78, OnChanged3 = PROTO79})
	obj:Connect({113255068724446 = "Hidden lunge", 98163597193511 = "Hidden S1", 80411309607666 = "Abyssal S1", BackgroundColor = "Hidden S1", Style = "Dot", Text = "Open Mask Selector GUI", Tooltip = "Ga bisa mati (semi god)", Func = "Open Mask Selector GUI", SkillCheckMode = "Legit", Default = 2, Min = 1, Max = 5, OffsetX = 0, OffsetY = 0, Rounding = 0, Callback = "Legit", OnChanged1 = PROTO80, OnChanged2 = PROTO81, OnChanged3 = PROTO82, OnChanged4 = PROTO83, OnChanged5 = PROTO84, OnChanged6 = PROTO85, OnChanged7 = PROTO86, OnChanged8 = PROTO88, OnChanged9 = PROTO89, OnChanged10 = PROTO90, OnChanged11 = PROTO91, OnChanged12 = PROTO92, OnChanged13 = PROTO93, OnChanged14 = PROTO96})
	obj:AddDropdown({Text = "Aktifkan Emote", Title = "Crosshair Color", Veil_ShowFOV = 1, Transparency = 0, Callback = "Crosshair Color", OnChanged1 = PROTO97, OnChanged2 = PROTO98, OnChanged3 = PROTO100, OnChanged4 = PROTO101, OnChanged5 = PROTO105, OnChanged6 = PROTO111, OnChanged7 = PROTO112})
	obj:GetService({CornerRadius = "new", Min = 1, Max = 4000, Default = 60, Callback = PROTO113})
	obj:SetFolder()
	obj:SetFolder()
	obj:Connect()
	obj:AddToggle({Callback = PROTO114})
	obj:AddSlider({133963973694098 = "Mayers Basic", Default = "None", Callback = "None"})
	obj:AddToggle()
	obj:AddToggle({Text = "Generator", Disabled = 1, Callback = "Generator", OnChanged1 = PROTO115, OnChanged2 = PROTO116, OnChanged3 = PROTO117})
	obj:AddToggle({Text = "Enable Crosshair", Callback = "Enable Crosshair", OnChanged1 = PROTO119, OnChanged2 = PROTO120, OnChanged3 = PROTO121})
	obj:AddSlider({Text = "Keybind FPS Cap", Tooltip = "Menampilkan jumlah player yang sedang jadi Spectator", Callback = "Keybind FPS Cap", OnChanged1 = PROTO122, OnChanged2 = PROTO123})
	obj:Connect({Text = "FPS Limit"})
	obj:AddLeftGroupbox({Callback = PROTO124})
	obj:AddToggle()
	obj:AddSlider({Text = "Enable Aimbot", Callback = "Enable Aimbot", OnChanged1 = PROTO125})
	obj:AddSlider({Default = 1, Callback = PROTO126})
	obj:AddButton()
	obj:AddButton({Text = "TP Pallet (Loop)", Func = "TP Pallet (Loop)", Callback = PROTO127})
	obj:Connect({Rounding = 0, Callback = PROTO128, OnChanged1 = PROTO129, OnChanged2 = PROTO130})
	obj:AddRightGroupbox({Disabled = 1, Keybind = 1, Callback = PROTO137, OnChanged1 = PROTO139, OnChanged2 = PROTO143})
	obj:AddButton({Text = "Jitter Amount", Tooltip = "Besar efek acak (0 = mati, 5 = maksimal)", Default = "0.1", Placeholder = "0.1", Numeric = 1})
	obj:WaitForChild({Text = "Refresh Count", Tooltip = "Menampilkan perk killer yang sedang digunakan", Callback = "Menampilkan perk killer yang sedang digunakan", OnChanged1 = PROTO153})
	obj:AddKeyPicker({Text = "Parry Radius", Tooltip = "Jarak maksimal parry bereaksi", Transparency = 0.6, Min = 0, Max = 50, Rounding = 1, Disabled = 1, Callback = "Parry Radius", OnChanged1 = PROTO155, OnChanged2 = PROTO156, OnChanged3 = PROTO157, OnChanged4 = PROTO160, OnChanged5 = PROTO161})
	obj:AddToggle({Default = "None", Text = "Toggle Anti Slow Vault", Mode = "Toggle"})
	obj:AddToggle({Text = "Show Veil FOV", Callback = PROTO162, OnChanged1 = PROTO163})
	obj:AddButton()
	obj:AddToggle()
	obj:AddToggle({Text = "Next Killer Display", Tooltip = "Menampilkan prediksi killer selanjutnya di layar", Callback = "Next Killer Display", OnChanged1 = PROTO164})
	obj:AddButton({Text = "Next Map Prediction", Default = "0.01", Placeholder = "misal: 0.05", Callback = PROTO165, OnChanged1 = PROTO166})
	obj:AddKeyPicker({Text = "Refresh Map", Func = "Refresh Map", Callback = PROTO167})
	obj:AddToggle()
	obj:AddKeyPicker({Rounding = 0, Callback = "ToggleMoonwalk", OnChanged1 = PROTO168, OnChanged2 = PROTO169, OnChanged3 = PROTO170, OnChanged4 = PROTO171, OnChanged5 = PROTO172})
	obj:AddToggle({Text = "Infinite Frenzy Key", Mode = "Toggle", Callback = "Infinite Frenzy Key", OnChanged1 = PROTO173})
	obj:AddCheckbox({Text = "Infinite Pursuit (Jason)", Default = "Hook", Title = "Hook Color", ShowToggleFrameInKeybinds = 1, Callback = "Hook", OnChanged1 = PROTO174, OnChanged2 = PROTO175, OnChanged3 = PROTO176, OnChanged4 = PROTO177})
	obj:AddColorPicker({Attach = "CreateModernESP", Text = "Killer", Rounding = 0, Callback = "Killer", OnChanged1 = PROTO178, OnChanged2 = PROTO179, OnChanged3 = PROTO180, OnChanged4 = PROTO181, OnChanged5 = PROTO182})
	obj:AddColorPicker({Text = "Auto Run [PC]", Callback = PROTO183, OnChanged1 = PROTO184})
	obj:AddCheckbox({Text = "ESP Tracker Target"})
	obj:AddToggle()
	obj:AddToggle({Text = "Hide Name Key", Mode = "Toggle", Callback = PROTO185, OnChanged1 = PROTO186, OnChanged2 = PROTO191, OnChanged3 = PROTO192})
	obj:AddToggle({Text = "No Slowdown killer", Tooltip = "Hilangkan slowdown saat menyerang (Killer Only)"})
	obj:AddSlider()
	obj:AddSlider({Text = "Keybind Self Heal", Mode = "Toggle", SyncToggleState = 1, Callback = PROTO196})
	obj:Connect({Text = "Size"})
	obj:AddLabel({Callback = PROTO197})
	obj:AddTab({Text = "Aggressive Mode", Tooltip = "Langsung parry tanpa peduli face direction", Callback = "Aggressive Mode", OnChanged1 = PROTO198})
	obj:AddKeyPicker({Surv_ParryCircle = 1, SyncToggleState = 1, Callback = PROTO199})
	obj:AddKeyPicker({Tooltip = "TP ke player yang di pilih", Callback = "TP ke player yang di pilih", OnChanged1 = PROTO200})
	obj:AddKeyPicker({Text = "Ew Player", Tooltip = "Teleport ke gate secara instan tanpa delay", Default = "Pallet", Title = "Pallet Color", Callback = "Pallet", OnChanged1 = PROTO201, OnChanged2 = PROTO204, OnChanged3 = PROTO205, OnChanged4 = PROTO206})
	obj:AddKeyPicker({Callback = PROTO207})
	obj:GetPlayers({Default = "None", Text = "Auto Pallet Key"})
	obj:AddToggle()
	obj:AddButton({Text = "Instant TP Gate"})
	obj:AddToggle({Text = "No Fog", Mode = "Toggle", Tooltip = "Hapus kabut biar map lebih jelas", Callback = "No Fog", OnChanged1 = PROTO208, OnChanged2 = PROTO209, OnChanged3 = PROTO210, OnChanged4 = PROTO211, OnChanged5 = PROTO212})
	obj:AddToggle({Text = "Silent Veil V1", Surv_SkillFrequency = 10, Surv_SkillSpeed = 1, Disabled = 1})
	obj:GetService({Text = "Esp Name", Callback = PROTO213, OnChanged1 = PROTO214})
	obj:HttpGet({Text = "Enable Hit Sound Effect", Tooltip = "Memutar suara 'Ahhh' saat berhasil stun killer", Surv_Aimbot_ShowFOV = 1, Surv_Aimbot_Radius = 150, Callback = PROTO215, OnChanged1 = PROTO217})
	obj:AddToggle({Default = "", Text = "Pilih Player", Callback = PROTO218, OnChanged1 = PROTO219})
	obj:AddRightGroupbox({Text = "Enable Laser", Tooltip = "Muncul saat tombol flask di-hold", Callback = "Enable Laser", OnChanged1 = PROTO220})
	obj:AddToggle({Callback = PROTO222})
	obj:AddToggle({Text = "Block aim Knocked", Callback = "Block aim Knocked", OnChanged1 = PROTO223})
	obj:FindFirstChild()
	obj:Destroy()
	obj:AddCheckbox({Default = "I", Mode = "Toggle", Text = "Auto Dodge Veil", Disabled = 1, Thickness = 1.5, Callback = PROTO224, OnChanged1 = PROTO225})
	obj:AddButton()
	obj:AddToggle()
	obj:Connect({Text = "Auto Parry GUI", ParryCooldownTime = 60, FillTransparency = 0.5, OutlineTransparency = 0, Callback = PROTO226})
	obj:Connect({Callback = PROTO227, OnChanged1 = PROTO228})
	obj:AddButton({Func = "spawn", Callback = PROTO231, OnChanged1 = PROTO232, OnChanged2 = PROTO237})
	obj:AddRightGroupbox({Text = "Rejoin Server", Disabled = 1, Callback = PROTO238, OnChanged1 = PROTO239, OnChanged2 = PROTO240})
	obj:AddToggle()
	obj:AddToggle({Text = "Infinity Zoom Out"})
	obj:AddButton({Text = "Bypass Carry skill unlock", Disabled = 1, Callback = "Bypass Carry skill unlock", OnChanged1 = PROTO241})
	obj:AddCheckbox({Text = "Keybind Flowstate No CD", Default = "None", Callback = PROTO242})
	obj:AddRightGroupbox({Text = "Killer Warn", Tooltip = "Otomatis jongkok saat Abyssal menggunakan S1", Size = "fromOffset", Mode = "Toggle", Player = "Auto Crouch (Dodge S1)", Default = 103, Max = 200, Rounding = 0, CornerRadius = 20, Disabled = 1, Thickness = 2.5, Callback = "Esp", OnChanged1 = PROTO244, OnChanged2 = PROTO245, OnChanged3 = PROTO246, OnChanged4 = PROTO247, OnChanged5 = PROTO248})
	obj:AddColorPicker()
	obj:AddSlider({Default = 15, Min = 5, Max = 25})
	obj:AddCheckbox({Text = "Counter Auto Parry", Default = "Counter Auto Parry", Title = "Window Color", Callback = "Window", OnChanged1 = PROTO250})
	obj:AddToggle({Text = "Lock Aim (Twist Of fate)", Tooltip = "Lock aim untuk item Pistol", Callback = "Lock Aim (Twist Of fate)", OnChanged1 = PROTO251})
	obj:Connect()
	obj:GetPlayers({Callback = PROTO252})
	obj:AddButton()
	obj:AddLeftGroupbox()
	obj:AddToggle()
	obj:IgnoreThemeSettings({Text = "Block Vault & Pallets"})
	obj:AddToggle({Callback = PROTO255})
	obj:AddSlider()
	obj:AddDraggableLabel({Text = "Spear Speed", Min = 50, Max = 200})
	obj:AddLabel()
	obj:AddKeyPicker({Callback = "FireAbyssalSkill", OnChanged1 = PROTO256, OnChanged2 = PROTO258})
	obj:AddKeyPicker({Default = "None"})
	obj:AddCheckbox({Default = "None", Text = "Bypass Carry Key", Mode = "Toggle", Callback = PROTO260})
	obj:AddInput({Text = "Esp Distance", Min = 1, Max = 10, Default = 5, Rounding = 1, Callback = PROTO261})
	obj:HttpGet({Text = "Predict Aim Offset"})
	obj:AddSlider({Text = "ESP Range Circle", Attached = "Moonwalk v old", Tooltip = "Tampilkan radius jarak parry di karakter", Min = 8, Max = 30, Rounding = 0, lastTime = 0, Cooldown = 0.1, Distance = 6, Default = 1, Callback = "ESP Range Circle", OnChanged1 = PROTO262, OnChanged2 = PROTO263, OnChanged3 = PROTO264, OnChanged4 = PROTO266})
	obj:AddLeftGroupbox({Callback = PROTO267})
	obj:AddCheckbox({Text = "Reset to 60 FPS", Callback = PROTO268})
	obj:AddLeftGroupbox({Text = "Fly GUI", Tooltip = "Sensitivitas arah pandang (1-10)", LeftLowerArm = 1, RightLowerArm = 1, LeftUpperArm = 1, RightUpperArm = 1, Default = 12, Min = -10, Max = 30, Rounding = 0, Callback = PROTO269, OnChanged1 = PROTO271, OnChanged2 = PROTO272, OnChanged3 = PROTO274, OnChanged4 = PROTO281})
	obj:AddButton()
	obj:AddToggle({Text = "Drop All Pallet", Func = "Drop All Pallet", Disabled = 1, Callback = PROTO283})
	obj:GetService({Text = "Pilih Emote", Values = "Auto Drop Pallet", Default = "Friday Night", Callback = PROTO286})
	obj:GetService()
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Pallet", Callback = "setupFlowstateCharacter", OnChanged1 = PROTO287, OnChanged2 = PROTO288, OnChanged3 = PROTO290})
	obj:AddSlider({Default = 1, Callback = PROTO291, OnChanged1 = PROTO292, OnChanged2 = PROTO301})
	obj:AddLeftGroupbox({Text = "FOV Circle Radius", Func = "FOV Circle Radius"})
	obj:AddTab({Default = "VD", Text = "Abaikan skill tertentu", Tooltip = "Abaikan skill tertentu", Multi = 1})
	obj:LoadAutoloadConfig({Callback = PROTO302})
	obj:AddToggle({Tooltip = "Memainkan animasi random buat ngelabui auto parry", Disabled = 1, Callback = "Memainkan animasi random buat ngelabui auto parry", OnChanged1 = PROTO304})
	obj:AddButton({Text = "Anti Blind (Flashlight)", Tooltip = "Mencegah killer terkena blind dari senter survivor", Callback = PROTO305})
	obj:AddTab({Text = "Refresh Target List", Callback = PROTO307})
	obj:AddButton({Text = "TP Hook (Loop)", Func = "TP Hook (Loop)", Callback = PROTO308})
	obj:AddSlider({Text = "Toggle Vault Speed", Func = "TP Gate (Loop)", Callback = PROTO309, OnChanged1 = PROTO310})
	obj:AddToggle()
	obj:AddToggle({Min = 1, Max = 10, Default = 5})
	obj:AddCheckbox({Text = "Enable Esp", BackgroundTransparency = 1, Callback = "Enable Esp", OnChanged1 = PROTO311})
	obj:AddButton({Text = "Enable Speed Boost (Input Mode)", Tooltip = "Aktifkan speed boost dengan kecepatan di atas", Thickness = 2.5, Radius = 30})
	obj:AddButton({Text = "Hop Server", Callback = PROTO312})
	obj:AddCheckbox({Text = "No Shadow", Tooltip = "Matikan shadow", Callback = PROTO313})
	obj:AddToggle({Text = "Infinite Lunge Key", Default = "F9", Mode = "Toggle", Disabled = 1, Callback = "F9", OnChanged1 = PROTO314, OnChanged2 = PROTO315})
	obj:AddToggle({Text = "Safety Parry", Callback = PROTO316, OnChanged1 = PROTO317, OnChanged2 = PROTO318, OnChanged3 = PROTO319})
	obj:AddSlider({Text = "Silent Aim (flash)", Disabled = 1, Callback = "Silent Aim (flash)", OnChanged1 = PROTO323})
	obj:FindFirstChild({Callback = PROTO324})
	obj:AddRightGroupbox({Visibility = "SetWorldTransparency", Callback = PROTO325, OnChanged1 = PROTO327, OnChanged2 = PROTO329, OnChanged3 = PROTO330, OnChanged4 = PROTO333})
	obj:SetIgnoreIndexes({Text = "Gen Boost (Multi-Repair)", Tooltip = "Memperbaiki generator dengan cepat tanpa terdeteksi"})
	obj:AddLeftGroupbox({Callback = PROTO334, OnChanged1 = PROTO338})
	obj:AddToggle({Surv_ParryRadius = 15, Surv_ParryFace = 0.7, Surv_VaultSpeed = 13, Callback = PROTO342, OnChanged1 = PROTO343})
	obj:AddSlider({Default = 1, Callback = PROTO344})
	obj:Connect({Text = "Mode Outline (Fill transparan)", Tooltip = "Lunge tanpa batas (Killer Only)", internal = "Killer", display = "Killer (K)", Default = 150, Min = 50, Callback = PROTO345, OnChanged1 = PROTO346, OnChanged2 = PROTO347, OnChanged3 = PROTO351, OnChanged4 = PROTO352, OnChanged5 = PROTO355, OnChanged6 = PROTO357, OnChanged7 = PROTO360})
	obj:AddRightGroupbox({Callback = PROTO361})
	obj:AddColorPicker({Callback = PROTO362})
	obj:AddRightGroupbox({Text = "Predict Aim ToF", Premium = 1, Callback = "Predict Aim ToF", OnChanged1 = PROTO363})
	obj:Connect({Callback = PROTO364})
	obj:AddInput({Text = "Min Players", Numeric = 1, Callback = "Min Players", OnChanged1 = PROTO365, OnChanged2 = PROTO367})
	obj:Connect({Default = "None", Mode = "Toggle", Pistol_Target = "Survivor", Tooltip = "Teleport saat killer terlalu dekat", SyncToggleState = 1, Flash_YOffset = 1.5, Callback = "Flee Killer", OnChanged1 = PROTO368, OnChanged2 = PROTO369, OnChanged3 = PROTO371, OnChanged4 = PROTO372, OnChanged5 = PROTO373})
	obj:AddToggle({Text = "Silent Aim Flask (Cure)", Default = "RightShift", NoUI = 1, Callback = PROTO374, OnChanged1 = PROTO375, OnChanged2 = PROTO377, OnChanged3 = PROTO378, OnChanged4 = PROTO379, OnChanged5 = PROTO381})
	obj:AddButton({Text = "Silent Veil V2", Tooltip = "Lake Mist tanpa cooldown / unlimited", ESP_GeneratorName = 1, Callback = PROTO384, OnChanged1 = PROTO385, OnChanged2 = PROTO386})
	obj:Connect({Tooltip = "Bikin map jadi terang biar lebih jelas", Callback = "Bikin map jadi terang biar lebih jelas", OnChanged1 = PROTO387, OnChanged2 = PROTO388, OnChanged3 = PROTO389, OnChanged4 = PROTO390})
	obj:FindFirstChild({Rounding = 1, Callback = PROTO391, OnChanged1 = PROTO392, OnChanged2 = PROTO393, OnChanged3 = PROTO394, OnChanged4 = PROTO395})
	obj:AddToggle({Min = 1, Max = 15, Rounding = 1, Callback = PROTO396})
	obj:AddTab({AutoShow = 1})
	obj:AddSlider({Title = "Player Color", Max = 500, Rounding = 0, Callback = "Player Color", OnChanged1 = PROTO397, OnChanged2 = PROTO398, OnChanged3 = PROTO399})
	obj:AddToggle({Text = "Predict Efficiency", Tooltip = "Atur akurasi prediksi (0% = tanpa prediksi, 100% = full prediksi)", Default = 85, Min = 0, Callback = PROTO402, OnChanged1 = PROTO403})
	obj:Connect({Default = 90, Min = 60, Max = 120, Rounding = 0, Callback = PROTO405, OnChanged1 = PROTO406})
	obj:AddToggle({Text = "Spear Gravity", Min = 0, Callback = PROTO407, OnChanged1 = PROTO409, OnChanged2 = PROTO410, OnChanged3 = PROTO412, OnChanged4 = PROTO413, OnChanged5 = PROTO414})
	obj:Connect({Callback = PROTO415, OnChanged1 = PROTO416, OnChanged2 = PROTO417, OnChanged3 = PROTO419})
	obj:AddToggle({Callback = PROTO420})
	obj:AddColorPicker()
	obj:AddToggle({Callback = PROTO424, OnChanged1 = PROTO426})
	obj:AddToggle({Callback = "StopSpectatorInfo", OnChanged1 = PROTO427})
	obj:AddToggle({Text = "Killer Perks Display", Callback = "Killer Perks Display"})
	obj:AddSlider({Text = "Skill Check Mode", Default = 1, Callback = "Skill Check Mode", OnChanged1 = PROTO428})
	obj:SetLibrary({Text = "Skill Check Frequency", Tooltip = "Atur frekuensi munculnya skill check", Default = 10, Min = 1, Max = 50})
	obj:AddToggle({Callback = PROTO429, OnChanged1 = PROTO436})
	obj:AddCheckbox({Text = "Infinite Frenzy (Jeff)", Tooltip = "Frenzy tanpa cooldown / unlimited", Default = "Frenzy tanpa cooldown / unlimited", Title = "Generator Color", Callback = "Generator", OnChanged1 = PROTO437})
	obj:AddCheckbox({Callback = PROTO438, OnChanged1 = PROTO440, OnChanged2 = PROTO441, OnChanged3 = PROTO442})
	obj:AddKeyPicker({Text = "Speed Boost Value", Default = 0.02, Min = 0.01, Callback = PROTO443})
	obj:AddKeyPicker()
	obj:AddToggle({Default = "None", Text = "Instant TP Gate Key", Mode = "Toggle", Tooltip = "Zoom Out tanpa batas", Callback = "Zoom Out tanpa batas", OnChanged1 = PROTO444, OnChanged2 = PROTO446, OnChanged3 = PROTO448})
	obj:WaitForChild()
	obj:AddButton({Text = "Apply Korless", Callback = "Apply Korless", OnChanged1 = PROTO449})
	obj:AddToggle({Text = "instan escape", AnchorPoint = "new", BackgroundTransparency = 1, Callback = PROTO450})
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Enable FPS + Ping Display", NotifySide = "Right", EnableSidebarResize = 1, EnableCompacting = 1, SidebarCompacted = 1})
	obj:AddDropdown({Mode = "Toggle"})
	obj:GetService({Text = "TP Generator", Callback = PROTO451})
	obj:GetService()
	obj:GetService()
	obj:AddRightGroupbox()
	obj:ApplyToTab()
	obj:AddSlider()
	obj:AddToggle({Text = "Face Sensitivity", Default = "None", Callback = PROTO452})
	obj:AddDropdown({Text = "Di Ew Player", Callback = "spawn", OnChanged1 = PROTO454, OnChanged2 = PROTO458})
	obj:AddCheckbox({Callback = "fromRGB"})
	obj:Notify({Tooltip = "Atur waktu di game", Default = 14, Min = 0, Callback = PROTO459})
	obj:Connect({Title = "Pandu Hub", Description = "Berhasil Dimuat!", Time = 3, Callback = PROTO460})
	obj:AddInput({Text = "Vault Speed", Func = "TP Window (Loop)", SPEAR_Gravity = "Gravity", AIM_TargetPart = "Torso", 82666958311998 = "Jeff Frenzy", 78432063483146 = "Abyssal Basic", 118907603246885 = "Abyssal lunge", Veil_FOV = 150, SPEAR_Speed = 165, SPEAR_MaxDist = 200, Veil_LeadMultiplier = 1.4, Min = 10, Max = 20, Default = 13, Rounding = 1, Callback = PROTO461, OnChanged1 = PROTO462, OnChanged2 = PROTO463})
	obj:AddKeyPicker({Callback = PROTO464})
	obj:SetLibrary()
	obj:Connect()
	obj:AddLeftGroupbox({Callback = PROTO465})
	obj:AddDropdown()
	obj:FindFirstChild({Callback = PROTO466, OnChanged1 = PROTO467})
	obj:AddToggle()
	obj:AddRightGroupbox({Text = "No Fall Damage", Callback = PROTO469, OnChanged1 = PROTO472, OnChanged2 = PROTO473})
	obj:AddToggle()
	obj:AddCheckbox({Mode = "Toggle", Callback = "GetGeneratorPoints", OnChanged1 = PROTO474, OnChanged2 = PROTO475, OnChanged3 = PROTO477, OnChanged4 = PROTO479})
	obj:GetService()
	obj:GetService()
	obj:AddCheckbox({Text = "Show Moonwalk Button", display = "Survivors (J)", Max = 1000, Default = 300, Rounding = 0, Callback = "PlayHitSound", OnChanged1 = PROTO480, OnChanged2 = PROTO481})
	obj:AddRightGroupbox({Title = "Killer Color", Tooltip = "Atur kecepatan putaran skill check (1-30, 10 = Normal)", Default = 10, Min = 1, Max = 30, Callback = PROTO484})
	obj:AddToggle()
	obj:GetService({Callback = PROTO485})
	obj:AddSlider({Callback = PROTO486, OnChanged1 = PROTO487, OnChanged2 = PROTO491, OnChanged3 = PROTO495})
	obj:WaitForChild({Text = "Aimbot Smoothness", Callback = PROTO496, OnChanged1 = PROTO497, OnChanged2 = PROTO499})
	obj:AddToggle({Text = "Hook", Callback = "Hook", OnChanged1 = PROTO500})
	obj:AddColorPicker({Text = "Enable FPS Cap"})
	obj:AddKeyPicker({VD = "Colors", Max = 3, Rounding = 2, Callback = PROTO501})
	obj:AddKeyPicker({Default = "None", Name = "VD_VeilTarget"})
	obj:AddKeyPicker({Default = "None", Gui = "None", Text = "Fast vault", Callback = "Fast vault", OnChanged1 = PROTO502, OnChanged2 = PROTO503, OnChanged3 = PROTO504})
	obj:AddColorPicker()
	obj:AddToggle()
	obj:GetService({Text = "Hide Name", Color = "Hide Name", Size = 8, Thickness = 2})
	obj:AddRightGroupbox({Callback = PROTO505})
	obj:AddLeftGroupbox({117042998468241 = "Mayers lunge", 135002183282873 = "cure lunge", 121216847022485 = "cure Basic", 132817836308238 = "Jeff Basic", 129784271201071 = "Jeff lunge", HitSoundId = "rbxassetid://106225491596534", Tooltip = "Pursuit tanpa cooldown / unlimited", Text = "Fake Generator GUI", Mode = "Toggle", Func = "Fake Generator GUI", Default = 165, Rounding = 0, PredictionEfficiency = 0.85, LerpSmoothness = 0.4, MaxJitterStuds = 0, HitSoundVolume = 1, HitSoundCooldown = 0.3, HitSoundLastTime = 0, Callback = "Keybind Unlimited Vault", OnChanged1 = PROTO506, OnChanged2 = PROTO507, OnChanged3 = PROTO508, OnChanged4 = PROTO509, OnChanged5 = PROTO511, OnChanged6 = PROTO513, OnChanged7 = PROTO514})
	obj:AddDropdown({Callback = PROTO516})
	obj:AddToggle({Text = "Position X", Values = "Pilih Target (Shared)", Default = 0, Min = -100, Max = 100})
	obj:AddButton({Text = "Invisibility [OP]", Disabled = 1, Callback = PROTO517, OnChanged1 = PROTO520})
	obj:AddToggle()
	obj:Connect()
	obj:AddKeyPicker({Callback = PROTO521, OnChanged1 = PROTO522})
	obj:WaitForChild()
	obj:WaitForChild()
	obj:WaitForChild()
	obj:AddKeyPicker({Callback = PROTO523})
	obj:AddToggle({Default = "None", Text = "Auto Stalk", Mode = "Toggle", Callback = "Auto Stalk", OnChanged1 = PROTO524, OnChanged2 = PROTO525})
	obj:AddCheckbox({Text = "Infinite corrupt Abyssal", Callback = "Infinite corrupt Abyssal", OnChanged1 = PROTO526, OnChanged2 = PROTO527})
	obj:AddDropdown({Default = 1.4, Rounding = 1, Callback = PROTO528, OnChanged1 = PROTO529, OnChanged2 = PROTO530})
	obj:AddSlider()
	obj:AddToggle()
	obj:AddColorPicker({Text = "Silent Aim Twist Of Fate"})
	obj:CreateWindow()
	obj:Connect({Title = "Pandu Hub", Footer = "Violence District v2.4.0 | https://discord.gg/panduhub", Icon = "94380161420025", Callback = PROTO531})
	obj:AddToggle({Text = "Show Hook Count", Tooltip = "Tampilkan jumlah hook di ATAS kepala survivor", Callback = PROTO532, OnChanged1 = PROTO533, OnChanged2 = PROTO535})
	obj:AddToggle({Text = "Veil Aim Key", Mode = "Toggle", Callback = PROTO536})
	obj:AddCheckbox()
	obj:AddToggle()
	obj:AddSlider({Text = "Camera FOV", Tooltip = "Atur jarak pandang kamera", Callback = "Camera FOV", OnChanged1 = PROTO537})
	obj:Connect({Text = "Melee Lock Distance", Color = "FOV Value", Transparency = 0.7, Min = 5})
	obj:GetService({Callback = PROTO538})
	obj:AddCheckbox({Default = 40, Min = 10, Max = 100})
	obj:AddDropdown()
	obj:AddCheckbox({Callback = PROTO541})
	obj:AddToggle()
	obj:AddButton({Text = "Safety Pallet", Tooltip = "Cegah drop pallet saat down/carry/hook (biar aman)", Callback = PROTO542})
	obj:AddSlider()
	obj:GetService({Text = "Toggle Skill Check", Default = "None", SyncToggleState = 1, Callback = PROTO546, OnChanged1 = PROTO551, OnChanged2 = PROTO552, OnChanged3 = PROTO553, OnChanged4 = PROTO554, OnChanged5 = PROTO556, OnChanged6 = PROTO559, OnChanged7 = PROTO561, OnChanged8 = PROTO562})
	obj:GetService()
	obj:AddSlider()
	obj:AddDivider({Text = "Menu keybind", Tooltip = "Atur kelancaran tracking target (10 = cepat, 100 = lambat)", ToggleKeybind = "Menu keybind", Callback = PROTO564})
	obj:AddButton()
	obj:Connect({Text = "Fake Parry GUI", Callback = PROTO565, OnChanged1 = PROTO568})
	obj:AddToggle({Callback = "fromRGB", OnChanged1 = PROTO571})
	obj:FindFirstChild()
	obj:AddToggle()
	obj:AddToggle({Callback = PROTO572, OnChanged1 = PROTO574})
	obj:Connect({Default = "None", Text = "Enable Laser Effect", Mode = "Toggle", Tooltip = "Tambahkan efek acak pada prediksi", StalkRange = 150, Callback = "Enable Laser Effect", OnChanged1 = PROTO575, OnChanged2 = PROTO576, OnChanged3 = PROTO582, OnChanged4 = PROTO600, OnChanged5 = PROTO606, OnChanged6 = PROTO607, OnChanged7 = PROTO608})
	obj:Connect({Surv_Aimbot_MaxDist = 300, Surv_Aimbot_Smoothness = 0.5, Surv_Aimbot_Predict = 0.01})
	obj:AddButton({Callback = PROTO609, OnChanged1 = PROTO611})
	obj:AddButton({Text = "Refresh Player", Func = "Refresh Player", Callback = PROTO612})
	obj:Connect({Text = "Teleport ke player yang dipilih", Func = "Teleport ke player yang dipilih", Callback = PROTO613})
	obj:AddToggle({Callback = PROTO614})
	obj:AddCheckbox({Text = "Esp Item Icon", Tooltip = "Mencegah perlambatan saat vault (perfect vault)", Callback = PROTO615, OnChanged1 = PROTO616, OnChanged2 = PROTO617})
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Wallcheck", 139369275981139 = "Jason Basic", 110355011987939 = "Jason lunge", 111920872708571 = "Masked Basic", Tooltip = "Aktifkan pembatas FPS", Callback = "Aktifkan pembatas FPS", OnChanged1 = PROTO618, OnChanged2 = PROTO619})
	obj:BuildConfigSection({Default = "None", Text = "Max Players", Numeric = 1, Thickness = 1.5, Callback = "6", OnChanged1 = PROTO620, OnChanged2 = PROTO621})
	obj:Wait()
	obj:AddButton()
	obj:Connect({Text = "Tools Jerk", Func = "Tools Jerk", Max = 24, Rounding = 0, Callback = PROTO624, OnChanged1 = PROTO626, OnChanged2 = PROTO629})
	obj:IsLoaded()
	obj:AddSlider({Callback = PROTO630})
	obj:AddSlider({Text = "Exit Gate", Mode = "Toggle", Min = 2, Max = 30, Default = 8, Rounding = 0, Left Arm = 1, Right Arm = 1, LeftHand = 1, RightHand = 1, Callback = PROTO631, OnChanged1 = PROTO632, OnChanged2 = PROTO633, OnChanged3 = PROTO634})
	obj:AddToggle({Text = "Trigger Distance", Min = 50, Default = 10})
	obj:OnClick({internal = "Survivors", Default = "GetSCPs", Title = "SCP Color", Callback = PROTO635, OnChanged1 = PROTO636})
	obj:Finalize({Callback = PROTO637})

end

main()