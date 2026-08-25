--[[
    Script hasil reconstruct dari Dumped.json
    Game: Roblox (Dead by Daylight-like)
    UI Library: Linoria/Violence District v2.4.0
--]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Global State Variables
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

-- Callback Functions

local function PROTO2(val)
	Surv_Aimbot_Enabled = val
end

local function PROTO3(val)
	obj:GetDescendants()
	obj:Connect()
	local _cb = PROTO4
	obj:FindFirstChild()
	obj.PlayerGui = val
end

local function PROTO4(val)
	local _cb = PROTO5
end

local function PROTO5(val)
	-- empty
end

local function PROTO6(val)
	obj.ImageButton = val
	obj.TextButton = val
	obj:Connect()
	local _cb = PROTO7
	local _cb = PROTO8
	obj:GetPropertyChangedSignal()
	obj.Image = val
	obj:IsA()
	obj.ImageLabel = val
	obj.Text = val
	obj.TextBox = val
	obj:IsA()
	obj.TextLabel = val
end

local function PROTO7(val)
	Text = val
	obj:GetPlayers()
	obj.PANDU = val
	local Misc_FakeName
	obj:SetAttribute()
	obj.OriginalText = val
	local Text
	obj:GetAttribute()
	obj.OriginalText = val
	obj.PANDU = val
end

local function PROTO8(val)
	obj:SetAttribute()
	obj.OriginalImage = val
	obj:GetAttribute()
	local Misc_FakeName
	obj:GetPlayers()
	local Image
end

local function PROTO9(val)
	-- empty
end

local function PROTO10(val)
	obj:Unload()
end

local function PROTO11(val)
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
	obj:GetAttribute()
	obj.HookCount = val
	obj:Survivors()
	obj:GetPlayers()
end

local function PROTO14(val)
	obj.Name = val
	obj.Parent = val
	obj.Size = val
	obj.UIStroke = val
	obj.TextYAlignment = val
	obj.Parent = val
	obj.TextColor3 = val
	obj.BillboardGui = val
	obj.Text = val
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Thickness"] = 2
	obj.Parent = val
	obj.StudsOffset = val
	obj.TextXAlignment = val
	obj:FindFirstChild()
	obj.TextColor3 = val
	obj:Destroy()
	obj.Color = val
	obj["TextSize"] = 11
	obj["TextScaled"] = true
	obj["AlwaysOnTop"] = true
	obj.TextLabel = val
	obj.TextColor3 = val
	obj.Font = val
end

local function PROTO15(val)
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
	local Name
end

local function PROTO18(val)
	Surv_ParryFace = val
end

local function PROTO19(val)
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
	obj.AutoRunEnabled = val
	obj:SendKeyEvent()
	obj:GetMouse()
end

local function PROTO21(val)
	obj:GetMouse()
	obj:SendKeyEvent()
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
	obj:FindFirstChild()
	obj:FindFirstChild()
	local Team
	obj:GetAttribute()
	obj.isRepairing = val
	obj:GetAttribute()
	obj.isHealing = val
	obj:GetAttribute()
	obj.isUnhooking = val
end

local function PROTO24(val)
	obj:FindFirstChild()
	obj.Remotes = val
	obj:FindFirstChild()
	obj.Healing = val
	obj:FireServer()
end

local function PROTO25(val)
	obj.Description = val
	obj["Time"] = 2
	obj.Title = val
	local Surv_AutoParry
	obj.Nonaktif = val
	obj:Notify()
	local _cb = PROTO26
	local _cb = PROTO27
	IsActive = val
	obj.Aktif = val
	Surv_AutoParry = val
end

local function PROTO26(val)
	obj:SetValue()
	local Surv_AutoParry
end

local function PROTO27(val)
	obj:SetValue()
	local Surv_AutoParry
end

local function PROTO28(val)
	obj.ScreenGui = val
	obj:Disconnect()
	obj.Frame = val
	obj["Name"] = "Frame"
	obj.Parent = val
	obj.Parent = val
	Gui = val
	local Heartbeat
	obj:Connect()
	local _cb = PROTO29
	obj.BackgroundColor3 = val
	obj["Name"] = "AutoParryCustomGui"
	obj["IgnoreGuiInset"] = true
	obj.UICorner = val
	obj.Size = val
	obj.Parent = val
	obj.UIStroke = val
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj["Active"] = true
	obj["BorderSizePixel"] = 0
	obj.Size = val
	obj["Text"] = "PARRY [OFF]"
	local Gui
	obj:Destroy()
	Gui = val
	local _cb = PROTO30
	obj:Connect()
	local _cb = PROTO31
	obj.ZIndexBehavior = val
	obj["TextSize"] = 12
	obj["Name"] = "UIStroke"
	obj.Parent = val
	obj.TextButton = val
	obj["Name"] = "ActionButton"
	obj.CornerRadius = val
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.2
	obj.Position = val
	obj.TextColor3 = val
	obj["BorderSizePixel"] = 0
	obj.CornerRadius = val
	obj:Connect()
	local _cb = PROTO33
	local InputChanged
	obj:Connect()
	local _cb = PROTO34
end

local function PROTO29(val)
	local IsActive
	local Surv_AutoParry
	obj:Disconnect()
	local Gui
	IsActive = val
end

local function PROTO30(val)
	Position = val
end

local function PROTO31(val)
	local Position
	local _cb = PROTO32
end

local function PROTO32(val)
	-- empty
end

local function PROTO33(val)
	-- empty
end

local function PROTO34(val)
	-- empty
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
	local CFrame
	CFrame = val
	local LockAim
end

local function PROTO38(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetAttribute()
	obj.IsCarried = val
	obj.CFrame = val
	local Character
end

local function PROTO39(val)
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
end

local function PROTO41(val)
	obj:GetPlayers()
end

local function PROTO42(val)
	-- empty
end

local function PROTO43(val)
	obj:Notify()
	obj["Title"] = "No Shadow"
	obj.Description = val
	obj["Time"] = 3
end

local function PROTO44(val)
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
	local _cb = PROTO46
end

local function PROTO46(val)
	local Killer_Bypass
	obj:SetValue()
end

local function PROTO47(val)
	obj:Notify()
	obj["Title"] = "Stun Indicator"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Stun Indicator"
	obj["Description"] = "Aktif"
	obj["Time"] = 3
end

local function PROTO48(val)
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	KILLER_InfFrenzy = val
	obj["Description"] = "AKTIF"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Infinite Frenzy"
	obj:Notify()
	obj["Title"] = "Infinite Frenzy"
end

local function PROTO49(val)
	obj:Notify()
	obj:Notify()
	obj["Title"] = "Bypass Exite Gate"
	obj["Description"] = "Gate bypass aktif!"
	obj["Time"] = 3
	obj["Title"] = "Bypass Exite Gate"
	obj["Description"] = "Gate bypass dimatikan!"
	obj["Time"] = 3
end

local function PROTO50(val)
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
	obj:Disconnect()
	obj:Disconnect()
	CameraMode = val
end

local function PROTO54(val)
	local Killer_3rdPerson
	local Team
	obj:Disconnect()
	CameraMode = val
	local Character
end

local function PROTO55(val)
	obj:Connect()
	local _cb = PROTO56
	obj:RemoveTag()
	obj["Time"] = 3
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
	obj:Disconnect()
	obj.UnlimitedVaultConn = val
	obj:Notify()
	obj["Title"] = "Unlimited Vault"
	obj["Time"] = 2
end

local function PROTO58(val)
	local _cb = PROTO59
end

local function PROTO59(val)
	obj:FireServer()
end

local function PROTO60(val)
	local _cb = PROTO61
end

local function PROTO61(val)
	local Character
	obj:FindFirstChild()
	local _cb = PROTO62
end

local function PROTO62(val)
	obj:FireServer()
end

local function PROTO63(val)
	obj.IsRepairing = val
end

local function PROTO64(val)
	local _cb = PROTO65
end

local function PROTO65(val)
	-- empty
end

local function PROTO66(val)
	-- empty
end

local function PROTO67(val)
	-- empty
end

local function PROTO68(val)
	obj:Disconnect()
	obj:Disconnect()
	local RenderStepped
	obj:Connect()
	local _cb = PROTO69
	MouseBehavior = val
	MouseBehavior = val
end

local function PROTO69(val)
	local MouseBehavior
	MouseBehavior = val
	local MouseIconEnabled
end

local function PROTO70(val)
	-- empty
end

local function PROTO71(val)
	-- empty
end

local function PROTO72(val)
	obj.Part = val
end

local function PROTO73(val)
	obj:Destroy()
end

local function PROTO74(val)
	-- empty
end

local function PROTO75(val)
	local ViewportSize
	local Veil_ShowFOV
	local _cb = PROTO76
	obj:Normal()
	To = val
	obj:Lerp()
	Size = val
	local Surv_Aimbot_Radius
	obj.Rotation = val
	Parent = val
	obj:Lerp()
	Position = val
	local Killer_Aimbot_Smoothness
	CFrame = val
	obj:FindFirstChild()
	obj.Line = val
	obj:FindFirstChild()
	local Flash_YOffset
	obj:Lerp()
	local Surv_Aimbot_Smoothness
	CFrame = val
	obj:Killer()
	Parent = val
	obj.Humanoid = val
	local CFrame
	local Surv_Aimbot_Enabled
	Visible = val
	Position = val
	local Veil_FOV
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Surv_Aimbot_Predict
	obj.Goal = val
	obj.CFrame = val
	Color = val
	local Flash_Silent
	obj:Lerp()
	obj.CFrame = val
	local Killer_Aimbot_Enabled
	obj:FindFirstChild()
	obj.SkillCheckPromptGui = val
	obj:FindFirstChild()
	obj.Check = val
	obj:Move()
	obj:WorldToViewportPoint()
	obj:Survivor()
	obj.CFrame = val
	obj.CFrame = val
	local Character
	local _cb = PROTO77
	local Surv_Aimbot_ShowFOV
	obj:Lerp()
	From = val
	local SkillCheckMode
	obj:Instant()
	obj:FindFirstChild()
	obj.Humanoid = val
	local Killer_Aimbot_MaxDist
	obj:Lerp()
	Size = val
	obj:Survivor()
	Parent = val
	obj.CFrame = val
	local SkillCheck
	obj:GetAttribute()
	obj.spearmode = val
	Color = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChildOfClass()
end

local function PROTO76(val)
	-- empty
end

local function PROTO77(val)
	-- empty
end

local function PROTO78(val)
	local Colors
	obj.Gate = val
end

local function PROTO79(val)
	PredictionEfficiency = val
	obj:Notify()
end

local function PROTO80(val)
	local ESP_Killer
	obj["Name"] = "KillerWarn"
	obj:FindFirstChild()
	obj.WarnText = val
	obj.Font = val
	obj.Parent = val
	obj:Destroy()
	obj.Name = val
	obj.Parent = val
	obj:FindFirstChild()
	obj.KillerWarn = val
	obj.StudsOffset = val
	obj.Parent = val
	obj.TextLabel = val
	obj.PE_Text = val
	obj.Size = val
	obj["AlwaysOnTop"] = true
	local Colors
	obj["Text"] = "!"
	obj:GetPlayers()
	obj.Highlight = val
	local ESP_KillerWarn
	local Character
	obj:FindFirstChild()
	obj.KillerWarn = val
	obj:GetPlayers()
	local ESP_ItemIcon
	obj:GetAttribute()
	obj:Destroy()
	obj:Destroy()
	obj:FindFirstChild()
	obj["TextStrokeTransparency"] = 0
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local ESP_Player
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["TextScaled"] = true
	obj.TextColor3 = val
	obj.name = val
	local ESP_Distance
	obj.FillColor = val
	obj.OutlineColor = val
	local ESP_Outline
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_Name
	obj.KE_Text = val
	obj.distance = val
	obj.color = val
	obj.icon = val
	obj["Name"] = "WarnText"
	obj.BillboardGui = val
	obj.KEH = val
	local ESP_Master
	obj["Text"] = "!!"
	obj:Survivor()
	obj.PEH = val
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Head = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO81(val)
	obj.FillColor = val
	obj.OutlineColor = val
	local ESP_Outline
	obj.Humanoid = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local ESP_Master
	obj:FindFirstChild()
	obj.SCPEH = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_SCP
	local SCPs
	local Colors
	obj:FindFirstChild()
	obj.SCPEH = val
	obj["Name"] = "SCPEH"
	obj.Parent = val
	obj.Highlight = val
	obj:FindFirstChild()
	obj.Torso = val
	obj.SCP = val
	obj:Destroy()
end

local function PROTO82(val)
	-- empty
end

local function PROTO83(val)
	Ambient = val
	OutdoorAmbient = val
	ClockTime = val
end

local function PROTO84(val)
	FogColor = val
	obj.Atmosphere = val
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
	local _cb = PROTO87
	obj["Title"] = "Mask Selector"
end

local function PROTO87(val)
	obj:HttpGet()
end

local function PROTO88(val)
	obj:GetAttribute()
	obj.IsHooked = val
	obj:GetAttribute()
	obj.Knocked = val
end

local function PROTO89(val)
	local Character
	obj:FindFirstChild()
end

local function PROTO90(val)
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO91(val)
	GateClientModule = val
	obj:GetService()
	obj.ReplicatedStorage = val
end

local function PROTO92(val)
	obj:table()
	obj.gateDuration = val
	obj.gateDuration = val
	obj.gateRemote = val
end

local function PROTO93(val)
	local GateClientModule
	oldGateCanUse = val
	local _cb = PROTO94
	oldGateNew = val
	local oldGateNew
	local oldGateCanUse
	local _cb = PROTO95
end

local function PROTO94(val)
	local oldGateCanUse
	local InstantTPGate
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
	local _cb = PROTO99
end

local function PROTO99(val)
	-- empty
end

local function PROTO100(val)
	-- empty
end

local function PROTO101(val)
	obj.Nonaktif = val
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Gagal load. Coba lagi."
	obj["Time"] = 3
	local _cb = PROTO102
	obj:Notify()
	obj.Aktif = val
	obj:Notify()
	obj["Title"] = "Invisibility"
	local IsActive
	obj:Notify()
	obj["Title"] = "Invisibility"
	local _cb = PROTO103
	obj["Time"] = 2
	obj["Title"] = "Invisibility"
	obj["Description"] = "Loading..."
	obj["Time"] = 2
	IsActive = val
	local _cb = PROTO104
	obj["Description"] = "Masih loading..."
	obj["Time"] = 2
end

local function PROTO102(val)
	obj:SetValue()
	local IsActive
end

local function PROTO103(val)
	-- empty
end

local function PROTO104(val)
	-- empty
end

local function PROTO105(val)
	local Gui
	obj:Destroy()
	Gui = val
	obj["Name"] = "InvisCustomGui"
	obj["IgnoreGuiInset"] = true
	obj.UICorner = val
	obj.CornerRadius = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	obj.CornerRadius = val
	local _cb = PROTO106
	obj:Connect()
	obj.Position = val
	obj:Connect()
	local _cb = PROTO107
	obj["BorderSizePixel"] = 0
	obj.UIStroke = val
	obj.UICorner = val
	local _cb = PROTO108
	obj:Connect()
	obj.TextColor3 = val
	obj["Name"] = "ActionButton"
	obj.Size = val
	obj["Text"] = "INVIS [OFF]"
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj["Active"] = true
	obj["TextSize"] = 12
	obj.Parent = val
	Gui = val
	obj.ScreenGui = val
	obj.ZIndexBehavior = val
	obj["Name"] = "UIStroke"
	obj.Parent = val
	obj.BackgroundColor3 = val
	obj.Font = val
	obj["Transparency"] = 0.2
	obj.Frame = val
	obj["Name"] = "Frame"
	obj.Parent = val
	obj.Size = val
	local _cb = PROTO110
	local InputChanged
	obj.TextButton = val
	obj.Color = val
end

local function PROTO106(val)
	Position = val
end

local function PROTO107(val)
	-- empty
end

local function PROTO108(val)
	local Position
	local _cb = PROTO109
end

local function PROTO109(val)
	-- empty
end

local function PROTO110(val)
	-- empty
end

local function PROTO111(val)
	-- empty
end

local function PROTO112(val)
	Color = val
end

local function PROTO113(val)
	obj.CylinderHandleAdornment = val
	obj["Name"] = "AutoParryCircleESP"
	obj.Health = val
	local Character
	local ESP_Generator
	obj.CFrame = val
	obj.Parent = val
	obj["ZIndex"] = 0
	obj:Destroy()
	obj:Destroy()
	FieldOfView = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local ESP_Name
	local Surv_ParryRadius
	obj.Radius = val
	local ESP_KillerWarn
	local Surv_ParryAggressive
	local ESP_Killer
	local Surv_ParryCircle
	obj.Color3 = val
	obj["WalkSpeed"] = 16
	obj["Height"] = 0.05
	local ESP_ItemIcon
	local ESP_Gate
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local ESP_Window
	local ESP_Pallet
	obj:Killer()
	obj.CFrame = val
	obj.CFrame = val
	obj["Transparency"] = 0.3
	obj.Adornee = val
	local ESP_Player
	obj.InnerRadius = val
	obj.Color3 = val
	obj.Color3 = val
	local ESP_Hook
	local ESP_SCP
end

local function PROTO114(val)
	-- empty
end

local function PROTO115(val)
	Surv_AutoCrouch = val
end

local function PROTO116(val)
	ESP_Generator = val
	local ESP_Master
end

local function PROTO117(val)
	obj:Stop()
	obj:Notify()
	obj["Title"] = "Sus R6"
	obj["Description"] = "Pilih target dulu!"
	obj["Time"] = 3
	obj.Animation = val
	obj["AnimationId"] = "rbxassetid://189854234"
	obj:LoadAnimation()
	obj:Play()
	local Character
	local SusR6Toggle
	obj:SetValue()
	obj:FindFirstChildOfClass()
	local _cb = PROTO118
end

local function PROTO118(val)
	obj.CFrame = val
	obj:Play()
	obj:Create()
	obj.CFrame = val
	obj:Play()
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
end

local function PROTO119(val)
	-- empty
end

local function PROTO120(val)
	obj.HumanoidRootPart = val
	obj:GetPlayers()
	obj:FindFirstChild()
	obj.StunUI = val
end

local function PROTO121(val)
	Enabled = val
end

local function PROTO122(val)
	-- empty
end

local function PROTO123(val)
	local FPSCapToggle
	obj:SetValue()
end

local function PROTO124(val)
	obj:Teleport()
end

local function PROTO125(val)
	Killer_Aimbot_Enabled = val
end

local function PROTO126(val)
	-- empty
end

local function PROTO127(val)
	local Pallets
	obj:FindFirstChild()
	obj.PrimaryPartPallet = val
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
end

local function PROTO128(val)
	-- empty
end

local function PROTO129(val)
	obj["ZIndex"] = 11
	obj.Parent = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.15
	obj["AutoButtonColor"] = true
	obj["ZIndex"] = 10
	obj:Destroy()
	obj.ImageButton = val
	obj.Font = val
	obj.Visible = val
	obj.ScreenGui = val
	local TouchEnabled
	obj.Size = val
	obj.Parent = val
	obj.UICorner = val
	obj:FindFirstChild()
	obj.BypassGenUI = val
	obj.CornerRadius = val
	obj.Parent = val
	obj.UIStroke = val
	obj.TextLabel = val
	local KeyboardEnabled
	obj["IgnoreGuiInset"] = true
	obj.Parent = val
	obj.TextColor3 = val
	obj["TextScaled"] = true
	obj.Position = val
	obj["Name"] = "BypassGenButton"
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.4
	obj.Parent = val
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "GEN"
	obj["Name"] = "BypassGenUI"
end

local function PROTO130(val)
	local _cb = PROTO131
	local _cb = PROTO132
	local Character
	local _cb = PROTO133
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO131(val)
	-- empty
end

local function PROTO132(val)
	CFrame = val
	local Parent
end

local function PROTO133(val)
	local _cb = PROTO134
	local _cb = PROTO135
	CFrame = val
	CFrame = val
	local _cb = PROTO136
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
	local _cb = PROTO138
end

local function PROTO138(val)
	obj:FindFirstChild()
	obj.Items = val
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:FindFirstChild()
	obj.Remotes = val
	obj:FireServer()
	obj:FindFirstChild()
	obj.parry = val
	obj:FindFirstChild()
end

local function PROTO139(val)
	local _cb = PROTO140
end

local function PROTO140(val)
	obj:Connect()
	local _cb = PROTO141
	obj:WaitForChild()
	obj.Remotes = val
	obj:WaitForChild()
	obj:WaitForChild()
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:WaitForChild()
end

local function PROTO141(val)
	local _cb = PROTO142
end

local function PROTO142(val)
	-- empty
end

local function PROTO143(val)
	obj:Notify()
	local _cb = PROTO144
	obj:IsA()
	obj.BasePart = val
	obj:PalletPointSlide()
	obj:PalletPointSlideInUse()
	obj:GetService()
	obj.ReplicatedStorage = val
	local _cb = PROTO145
	obj:VaultPointInUse()
	obj.BlockPalletEnabled = val
	obj["Title"] = "Anti Looping"
	obj["Description"] = "✅ Aktif!"
	obj["Time"] = 2
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:GetDescendants()
	obj:GetDescendants()
	obj.ReplicatedStorage = val
	local _cb = PROTO150
	obj:GetService()
	obj:FindFirstChild()
	obj.Map = val
	local _cb = PROTO151
	local _cb = PROTO152
	obj:VaultTrigger()
	obj:GetService()
	obj.ReplicatedStorage = val
	obj:FindFirstChild()
	obj.Map = val
end

local function PROTO144(val)
	obj:FireServer()
	local Parent
end

local function PROTO145(val)
	obj:Disconnect()
	obj:FindFirstChild()
	obj.Map = val
	local _cb = PROTO146
	obj:Connect()
	local _cb = PROTO149
	obj:GetDescendants()
end

local function PROTO146(val)
	obj:GetPropertyChangedSignal()
	obj.Name = val
	obj:Connect()
	obj:IsA()
	obj:PalletPoint()
end

local function PROTO147(val)
	local Name
	obj:PalletPointSlide()
end

local function PROTO148(val)
	obj:FireServer()
end

local function PROTO149(val)
	-- empty
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
	local _cb = PROTO154
end

local function PROTO154(val)
	obj:Destroy()
end

local function PROTO155(val)
	obj:Killer()
	obj:Killer()
	obj:FindFirstChild()
	obj.Humanoid = val
	local Surv_Aimbot_MaxDist
	obj:Survivor()
	obj:WorldToViewportPoint()
	obj:Survivor()
	obj:GetPlayers()
	local ViewportSize
	local Killer_Aimbot_MaxDist
	local Surv_Aimbot_Radius
	local Killer_Aimbot_Enabled
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Surv_Aimbot_Enabled
end

local function PROTO156(val)
	MaxJitterStuds = val
	obj:Notify()
end

local function PROTO157(val)
	obj["Title"] = "Invis GUI"
	obj["Description"] = "Gui Loaded"
	obj["Time"] = 2
	obj:Notify()
	local _cb = PROTO158
	local _cb = PROTO159
	local Gui
	obj["Enabled"] = true
	obj:Notify()
	obj["Title"] = "Invis GUI"
	obj["Description"] = "Gui Destroyed"
	obj["Time"] = 2
end

local function PROTO158(val)
	-- empty
end

local function PROTO159(val)
	local Invis_Gacor
	obj:SetValue()
end

local function PROTO160(val)
	Style = val
end

local function PROTO161(val)
	OffsetY = val
end

local function PROTO162(val)
	-- empty
end

local function PROTO163(val)
	-- empty
end

local function PROTO164(val)
	-- empty
end

local function PROTO165(val)
	obj:Killer()
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetPlayers()
	local Character
end

local function PROTO166(val)
	local Character
	obj.CFrame = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
end

local function PROTO167(val)
	-- empty
end

local function PROTO168(val)
	LerpSmoothness = val
	obj:Notify()
end

local function PROTO169(val)
	-- empty
end

local function PROTO170(val)
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj["ZIndex"] = 10
	obj["ZIndex"] = 10
	obj["Text"] = "MOON"
	obj.TextColor3 = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.15
	obj.TextColor3 = val
	obj:FindFirstChild()
	obj.MoonwalkLabel = val
end

local function PROTO171(val)
	obj:Notify()
	obj["Title"] = "Moonwalk"
	obj["Description"] = "OFF"
	obj:Notify()
	obj["Title"] = "Moonwalk"
	obj["Time"] = 2
end

local function PROTO172(val)
	obj:Notify()
	obj["Title"] = "No Slowdown"
	obj["Description"] = "AKTIF - WalkSpeed dikunci"
	obj:Notify()
	obj["Title"] = "No Slowdown"
	obj["Description"] = "DIMATIKAN"
	obj["Time"] = 2
end

local function PROTO173(val)
	local InfFrenzy
	obj:SetValue()
	KILLER_InfFrenzy = val
end

local function PROTO174(val)
	obj:Notify()
	obj["Title"] = "FPS Cap"
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
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO177(val)
	local Colors
	obj.Hook = val
end

local function PROTO178(val)
	obj.Position = val
	obj.AnchorPoint = val
	obj["Name"] = "Text"
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj.Font = val
	obj["TextSize"] = 10
	obj["ZIndex"] = 3
	obj["LayoutOrder"] = 2
	obj["RichText"] = true
	obj.CornerRadius = val
	obj.UIGradient = val
	obj["Rotation"] = 90
	obj.Size = val
	obj["ZIndex"] = 3
	obj["LayoutOrder"] = 1
	obj.Text = val
	obj.BackgroundColor3 = val
	obj:FindFirstChild()
	obj.Icon = val
	obj.SortOrder = val
	obj.UIGradient = val
	obj.Transparency = val
	obj.UIPadding = val
	obj.ImageLabel = val
	obj["BorderSizePixel"] = 0
	obj["ZIndex"] = 2
	obj.Parent = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0
	obj.AnchorPoint = val
	obj["BorderSizePixel"] = 0
	obj["ZIndex"] = 1
	obj.Parent = val
	obj.Parent = val
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj.TextYAlignment = val
	obj.Frame = val
	obj["Name"] = "Line"
	obj.Name = val
	obj.Parent = val
	obj["AlwaysOnTop"] = true
	obj.Text = val
	obj.StudsOffset = val
	obj.Frame = val
	obj["Name"] = "Box"
	obj.VerticalAlignment = val
	obj["Name"] = "Icon"
	obj.PaddingLeft = val
	obj.TextLabel = val
	obj.Transparency = val
	obj.Text = val
	obj.UIListLayout = val
	obj.UICorner = val
	obj.BillboardGui = val
	obj.Size = val
	obj.HorizontalAlignment = val
	obj.Padding = val
	obj.AutomaticSize = val
	obj.Image = val
	obj["Visible"] = true
	obj.AutomaticSize = val
	obj.FillDirection = val
	obj:FindFirstChild()
	obj.Position = val
end

local function PROTO179(val)
	obj:Generator()
	obj:SCP()
	obj:Pallet()
	obj:Destroy()
	obj:Destroy()
	obj:FindFirstChild()
	obj.PalletEH = val
	obj:Destroy()
	local SCPs
	obj:Destroy()
	obj:Gate()
	obj:GetPlayers()
	local Windows
	obj:FindFirstChild()
	obj.HookEH = val
	obj:Destroy()
	obj:Destroy()
	obj:FindFirstChild()
	obj.GateEH = val
	obj:Hook()
	obj:Killer()
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.GE_Text = val
	obj:Window()
	obj:Destroy()
	obj:FindFirstChild()
	obj.GEH = val
	obj:Destroy()
	obj:Destroy()
	local Hooks
	obj:Player()
	obj:FindFirstChild()
	obj:Destroy()
	local Generators
	obj:FindFirstChild()
	obj.PEH = val
	obj:FindFirstChild()
	obj.KE_Text = val
	local Pallets
	obj:GetPlayers()
	obj:FindFirstChild()
	obj.KEH = val
	obj:Destroy()
	obj:FindFirstChild()
	local Gates
end

local function PROTO180(val)
	local Attach
	obj:Killer()
end

local function PROTO181(val)
	OffsetX = val
end

local function PROTO182(val)
	obj.Killer = val
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
	obj.TextColor3 = val
	obj.ActionButton = val
	obj:FindFirstChild()
	obj.UIStroke = val
	obj.BackgroundColor3 = val
	obj["Text"] = "BYPASS [OFF]"
end

local function PROTO184(val)
	obj.Window = val
	ESP_Window = val
	local ESP_Master
end

local function PROTO185(val)
	Misc_FakeName = val
end

local function PROTO186(val)
	obj:Connect()
	obj:WaitForChild()
	obj.Animator = val
	local _cb = PROTO187
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
	-- empty
end

local function PROTO188(val)
	local Surv_ParryRadius
	local Surv_AutoCrouch
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Character
	local Surv_ParryAggressive
	obj:Dot()
	local Surv_ParryFace
	obj:FindFirstChild()
	local Ignored_Skills_List
	obj.HumanoidRootPart = val
	obj:Connect()
	local _cb = PROTO189
	local Surv_AutoParry
end

local function PROTO189(val)
	obj:Disconnect()
	obj:Disconnect()
	local Position
end

local function PROTO190(val)
	obj:IsA()
	obj.Animator = val
end

local function PROTO191(val)
	-- empty
end

local function PROTO192(val)
	local _cb = PROTO195
end

local function PROTO193(val)
	local SpearSmart_enable
	obj:FindFirstChildOfClass()
	obj:IsA()
	obj.Model = val
	local SPEAR_Speed
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:Instance()
	obj:GetAttribute()
	obj.special = val
	local Aim_SilentVeilV2
	obj:FindFirstChild()
	obj.Head = val
	local Character
	local AIM_Auto
	obj:RemoteEvent()
	obj:IsA()
	obj.BasePart = val
	local SPEAR_Gravity
	local Veil_LeadMultiplier
	obj:Spearthrow()
	local Aim_SilentVeil
	obj:FireServer()
	local _cb = PROTO194
end

local function PROTO194(val)
	obj:FireServer()
	obj:FireServer()
end

local function PROTO195(val)
	local Remotes
end

local function PROTO196(val)
	local SelfHeal
	obj:SetValue()
	obj:Notify()
	obj:Killer()
	obj:Notify()
	obj:SetValue()
	obj:Notify()
end

local function PROTO197(val)
	local Killer_Aimbot_Enabled
	obj:Killer()
	obj:FindFirstChild()
	obj.attack = val
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	obj.move2 = val
	local Killer_InfAbyssal
	obj:FindFirstChild()
	obj.Controls = val
	obj:Killer()
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
	-- empty
end

local function PROTO201(val)
	obj["Gravity"] = 0
	local _cb = PROTO202
	obj:Play()
	obj:Stop()
	obj:Disconnect()
	obj:Notify()
	obj["Title"] = "Get Sucked"
	obj["Description"] = "Pilih target dulu!"
	obj["Time"] = 3
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.Humanoid = val
	obj["AnimationId"] = "rbxassetid://148840371"
	obj:FindFirstChildOfClass()
	obj:LoadAnimation()
	obj.Gravity = val
	local GetSuckedToggle
	obj:SetValue()
	local _cb = PROTO203
	obj.Animation = val
	obj:AdjustSpeed()
	local Stepped
	obj:Connect()
end

local function PROTO202(val)
	CFrame = val
	local CFrame
	local Position
end

local function PROTO203(val)
	Velocity = val
	CFrame = val
	local CFrame
end

local function PROTO204(val)
	InstantTPGate = val
	obj["Time"] = 2
	obj["Title"] = "Instant TP Gate"
end

local function PROTO205(val)
	local Colors
	obj.Pallet = val
end

local function PROTO206(val)
	-- empty
end

local function PROTO207(val)
	-- empty
end

local function PROTO208(val)
	obj.Gate = val
	obj.Player = val
	obj.Killer = val
	obj.Generator = val
	obj.SCP = val
	obj.Window = val
	obj.Pallet = val
	obj.Hook = val
end

local function PROTO209(val)
	obj:GetDescendants()
	obj:FindFirstChild()
	obj.Map = val
end

local function PROTO210(val)
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Box = val
	obj["Transparency"] = 1
	obj["Transparency"] = 0
	obj:FindFirstChild()
	obj.LeftGate = val
	obj:FindFirstChild()
	obj["CanCollide"] = true
	obj["Transparency"] = 1
	obj["CanCollide"] = true
	obj:FindFirstChild()
	obj["Transparency"] = 1
	obj["CanCollide"] = true
	obj.RightGate = val
	obj:FindFirstChild()
	obj["Transparency"] = 1
	obj["Transparency"] = 0
	obj:FindFirstChild()
end

local function PROTO211(val)
	local InfPursuitJason
	KILLER_InfPursuit = val
	obj:SetValue()
end

local function PROTO212(val)
	obj:FindFirstChildOfClass()
	obj.Atmosphere = val
	obj:Notify()
	obj["Title"] = "No Fog"
	obj["Description"] = "Kabut berhasil dihilangkan!"
	obj["Time"] = 3
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "No Fog"
	obj["Description"] = "No Fog dimatikan"
	obj["Density"] = 0.35
end

local function PROTO213(val)
	ESP_Name = val
end

local function PROTO214(val)
	obj:fireServer()
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
	-- empty
end

local function PROTO217(val)
	-- empty
end

local function PROTO218(val)
	obj["Title"] = "Infinite Lunge"
	obj["Description"] = "✅ AKTIF (999x)"
	obj["Time"] = 3
	obj:SetAttribute()
	obj.lungeboost = val
	obj:Notify()
	local Character
end

local function PROTO219(val)
	obj["Title"] = "Infinite Lunge"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 3
	obj:SetAttribute()
	obj.lungeboost = val
	local Character
end

local function PROTO220(val)
	obj.NEX_CureFlaskLaserThread = val
	obj:Disconnect()
	obj.NEX_CureFlaskLaserPart = val
	obj:Notify()
	obj["Title"] = "Flask Laser"
	obj["Description"] = "AKTIF - Laser merah"
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Flask Laser"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	KILLER_FlaskLaser = val
	local _cb = PROTO221
end

local function PROTO221(val)
	obj:Destroy()
end

local function PROTO222(val)
	obj.Description = val
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Speed"
end

local function PROTO223(val)
	Aim_SilentVeil = val
end

local function PROTO224(val)
	-- empty
end

local function PROTO225(val)
	obj.FilterType = val
	local Character
	obj.FilterDescendantsInstances = val
	obj:Raycast()
end

local function PROTO226(val)
	-- empty
end

local function PROTO227(val)
	-- empty
end

local function PROTO228(val)
	local _cb = PROTO229
	local _cb = PROTO230
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.PlayerGui = val
	obj.Controls = val
	obj:FindFirstChild()
end

local function PROTO229(val)
	obj:SendMouseButtonEvent()
end

local function PROTO230(val)
	local MouseButton1Up
	local MouseButton1Down
end

local function PROTO231(val)
	-- empty
end

local function PROTO232(val)
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj:FindFirstChildOfClass()
	obj.PlayerGui = val
	obj:FindFirstChild()
	obj.Controls = val
	obj:Connect()
	local _cb = PROTO233
	obj:Connect()
	obj:Connect()
	local _cb = PROTO235
	obj:Connect()
	local _cb = PROTO236
end

local function PROTO233(val)
	obj:Controls()
end

local function PROTO234(val)
	-- empty
end

local function PROTO235(val)
	-- empty
end

local function PROTO236(val)
	local doShoot
end

local function PROTO237(val)
	-- empty
end

local function PROTO238(val)
	-- empty
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
end

local function PROTO241(val)
	local KeyboardEnabled
	obj.Visible = val
	local TouchEnabled
end

local function PROTO242(val)
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Error"
	obj["Title"] = "Aim Lock"
	obj["Description"] = "Aim Lock berhasil dimuat!"
	obj["Time"] = 3
end

local function PROTO243(val)
	obj:HttpGet()
end

local function PROTO244(val)
	local FlowState
	obj:SetValue()
end

local function PROTO245(val)
	-- empty
end

local function PROTO246(val)
	obj:Destroy()
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	ESP_KillerWarn = val
	obj:FindFirstChild()
	obj.KillerWarn = val
end

local function PROTO247(val)
	-- empty
end

local function PROTO248(val)
	local _cb = PROTO249
end

local function PROTO249(val)
	-- empty
end

local function PROTO250(val)
	local Colors
	obj.Window = val
end

local function PROTO251(val)
	LockAim = val
end

local function PROTO252(val)
	local Surv_InstanSkillCheck
	local _cb = PROTO253
	obj:Disconnect()
	local ESP_Master
	obj:Disconnect()
	local _cb = PROTO254
end

local function PROTO253(val)
	-- empty
end

local function PROTO254(val)
	obj["Disabled"] = true
	obj["Disabled"] = true
	local Character
	obj:WaitForChild()
	obj:WaitForChild()
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
	local _cb = PROTO257
	obj.abyss = val
	obj:GetAttribute()
	obj.SelectedKiller = val
	obj:FindFirstChild()
	obj.SelectedKiller = val
end

local function PROTO257(val)
	obj:FireServer()
end

local function PROTO258(val)
	local _cb = PROTO259
end

local function PROTO259(val)
	obj:Killer()
	local Killer_InfAbyssal
end

local function PROTO260(val)
	obj:Notify()
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
	-- empty
end

local function PROTO263(val)
	obj:FindFirstChild()
	obj.Items = val
	obj:FindFirstChild()
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
	local _cb = PROTO265
end

local function PROTO265(val)
	-- empty
end

local function PROTO266(val)
	Surv_ParryCircle = val
end

local function PROTO267(val)
	-- empty
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
	obj.Parent = val
	obj.ScreenGui = val
	obj["Name"] = "MoonwalkUI"
	obj["IgnoreGuiInset"] = true
	obj.TextLabel = val
	obj["TextScaled"] = true
	obj.Font = val
	obj.TextColor3 = val
	obj.Size = val
	obj["Name"] = "MoonwalkLabel"
	obj.CornerRadius = val
	obj.Parent = val
	obj["Thickness"] = 1.5
	obj["Transparency"] = 0.4
	obj["ZIndex"] = 11
	obj.Parent = val
	obj.AnchorPoint = val
	obj.UICorner = val
	obj.Position = val
	obj.Visible = val
	obj.Parent = val
	obj.ImageButton = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.15
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "🌙 OFF"
	obj.UIStroke = val
	obj:Destroy()
	obj:Connect()
	local _cb = PROTO270
	obj:FindFirstChild()
	obj.MoonwalkUI = val
end

local function PROTO270(val)
	-- empty
end

local function PROTO271(val)
	Surv_ParryRadius = val
end

local function PROTO272(val)
	local Killer_BypassCarry
	local _cb = PROTO273
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
	obj:SetValue()
	local Killer_BypassCarry
end

local function PROTO274(val)
	obj.Size = val
	obj["Text"] = "CARRY [OFF]"
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.1
	obj:Disconnect()
	obj["Name"] = "Frame"
	obj.Parent = val
	obj.BackgroundColor3 = val
	obj.Font = val
	obj["TextSize"] = 12
	obj.TextButton = val
	obj["Name"] = "ActionButton"
	obj["Active"] = true
	obj["BorderSizePixel"] = 0
	obj.UICorner = val
	local _cb = PROTO275
	obj:Connect()
	local _cb = PROTO276
	obj:Connect()
	local _cb = PROTO278
	local InputChanged
	obj:Connect()
	local _cb = PROTO279
	obj.Size = val
	obj.ScreenGui = val
	obj["Name"] = "BypassCarryCustomGui"
	obj.Position = val
	obj.Color = val
	obj.CornerRadius = val
	obj["Thickness"] = 1.5
	local Heartbeat
	obj:Connect()
	local _cb = PROTO280
	Gui = val
	obj.Frame = val
	obj.CornerRadius = val
	obj.UIStroke = val
	obj["Name"] = "UIStroke"
	obj.Parent = val
	obj.TextColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	local Gui
	obj:Destroy()
	Gui = val
	obj["IgnoreGuiInset"] = true
	obj.ZIndexBehavior = val
	obj.Parent = val
end

local function PROTO275(val)
	Position = val
end

local function PROTO276(val)
	local _cb = PROTO277
	local Position
end

local function PROTO277(val)
	-- empty
end

local function PROTO278(val)
	-- empty
end

local function PROTO279(val)
	-- empty
end

local function PROTO280(val)
	local IsActive
	local Killer_BypassCarry
	obj:Disconnect()
	local Gui
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
	local _cb = PROTO282
end

local function PROTO282(val)
	obj:HttpGet()
end

local function PROTO283(val)
	local _cb = PROTO284
	obj:FindFirstChild()
	obj.PalletDropEvent = val
	obj:FindFirstChild()
	obj.Pallet = val
	obj:FindFirstChild()
	obj.Remotes = val
	local _cb = PROTO285
end

local function PROTO284(val)
	obj:FireServer()
end

local function PROTO285(val)
	obj:FindFirstChild()
	obj.Map = val
	obj:IsA()
	obj.BasePart = val
	obj:GetDescendants()
	obj:PalletPoint()
	obj:FindFirstAncestorWhichIsA()
	obj.Model = val
end

local function PROTO286(val)
	obj:Griddy()
	obj:Backflip()
	obj:WarCry()
	obj:Applause()
	obj:OnePlays()
	obj:Kyoufuu()
	obj:Vulnerable()
end

local function PROTO287(val)
	ESP_Pallet = val
	local ESP_Master
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
	obj.Font = val
	obj["TextSize"] = 11
	obj.Size = val
	local _cb = PROTO293
	local InputChanged
	obj:Connect()
	local _cb = PROTO294
	obj.Frame = val
	obj.UIStroke = val
	obj:Connect()
	local _cb = PROTO295
	obj:Connect()
	obj.Parent = val
	obj.Frame = val
	local _cb = PROTO296
	obj:Connect()
	obj.BackgroundColor3 = val
	obj.Padding = val
	local _cb = PROTO297
	obj.Size = val
	obj.UICorner = val
	obj.CornerRadius = val
	obj:Connect()
	local _cb = PROTO298
	obj:Connect()
	obj.Color = val
	obj["Thickness"] = 0.8
	obj.Frame = val
	obj.Size = val
	obj.ScreenGui = val
	obj.Parent = val
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj.Parent = val
	obj.TextButton = val
	obj.CornerRadius = val
	obj.TextColor3 = val
	obj.Parent = val
	obj.TextLabel = val
	obj.FillDirection = val
	obj.SortOrder = val
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj.LayoutOrder = val
	obj.Parent = val
	obj.UICorner = val
	obj.Parent = val
	obj.UIListLayout = val
	obj.Font = val
	obj["TextSize"] = 9
	obj.TextXAlignment = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	obj.Frame = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.TextButton = val
	obj.Size = val
	obj["BorderSizePixel"] = 0
	obj.TextXAlignment = val
	obj.TextYAlignment = val
	obj["Active"] = true
	obj.Parent = val
	obj.Size = val
	obj.Position = val
	obj.Position = val
	obj["Text"] = "TARGET MODE TWIST OF FATE"
	obj:FindFirstChild()
	obj.ToFTargetSelector = val
	obj.Position = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	obj.Size = val
	obj.Position = val
	obj.Frame = val
	obj.Size = val
	obj.Font = val
	obj["TextSize"] = 14
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "−"
	local InputBegan
	obj:Connect()
	local _cb = PROTO299
	obj.Size = val
	obj.UICorner = val
	obj.CornerRadius = val
	obj.Frame = val
	obj:Destroy()
	obj.TextColor3 = val
	local _cb = PROTO300
	obj:Disconnect()
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj["Name"] = "ToFTargetSelector"
	obj["IgnoreGuiInset"] = true
	obj.Parent = val
end

local function PROTO293(val)
	-- empty
end

local function PROTO294(val)
	-- empty
end

local function PROTO295(val)
	local Position
end

local function PROTO296(val)
	Size = val
	Size = val
end

local function PROTO297(val)
	obj.BackgroundColor3 = val
	obj.TextColor3 = val
	obj.TextColor3 = val
	obj.BackgroundColor3 = val
end

local function PROTO298(val)
	-- empty
end

local function PROTO299(val)
	obj["Title"] = "Target Mode"
	obj["Description"] = "Killer"
	obj["Time"] = 1
	obj["Title"] = "Target Mode"
	obj["Description"] = "Survivors"
	obj["Title"] = "Target Mode"
	obj["Description"] = "Zombie"
	obj["Time"] = 1
	obj.Zombie = val
	obj:Notify()
	obj.Survivors = val
	obj:Notify()
	obj.Killer = val
	obj:Notify()
	obj.TextColor3 = val
	obj["Time"] = 1
	obj.BackgroundColor3 = val
end

local function PROTO300(val)
	local internal
end

local function PROTO301(val)
	obj:Disconnect()
end

local function PROTO302(val)
	obj:Notify()
	obj["Title"] = "No Server"
	obj.Description = val
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Server Found"
	local _cb = PROTO303
	obj["Description"] = "Try Again"
	obj["Time"] = 3
	obj:TeleportToPlaceInstance()
end

local function PROTO303(val)
	obj:JSONDecode()
	obj:HttpGet()
end

local function PROTO304(val)
	obj.Description = val
	obj["Time"] = 2
	obj.NONAKTIF = val
	obj["Title"] = "Anti Auto Parry"
	obj:Notify()
end

local function PROTO305(val)
	obj:GetAttributeChangedSignal()
	obj.HookCount = val
	obj:Connect()
	local _cb = PROTO306
	obj:GetPlayers()
end

local function PROTO306(val)
	local Name
	obj:GetAttribute()
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
end

local function PROTO309(val)
	local Gates
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
end

local function PROTO310(val)
	ESP_Player = val
	local ESP_Master
	obj.Player = val
end

local function PROTO311(val)
	ESP_Master = val
end

local function PROTO312(val)
	-- empty
end

local function PROTO313(val)
	ESP_Distance = val
	local ESP_Master
end

local function PROTO314(val)
	-- empty
end

local function PROTO315(val)
	obj:Notify()
	obj["Title"] = "Silent Veil V2"
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
	obj.time = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.time = val
	obj.pos = val
	obj.vel = val
end

local function PROTO318(val)
	obj:Dot()
	obj:Dot()
	obj:Dot()
	local EnableJitter
	local MaxJitterStuds
	local PredictionEfficiency
end

local function PROTO319(val)
	obj:Survivors()
	obj:GetPlayers()
	obj:FindFirstChild()
	obj.Torso = val
	obj:FindFirstChild()
	obj.Torso = val
	obj:Dot()
	local _cb = PROTO320
	obj:Killer()
	local Character
	obj:GetAttribute()
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.IsCarried = val
	obj:Survivors()
	obj:Dot()
	obj:Zombie()
	local _cb = PROTO322
	obj:GetPlayers()
end

local function PROTO320(val)
	local _cb = PROTO321
end

local function PROTO321(val)
	local Position
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
	local _cb = PROTO326
	obj:IsA()
	local Character
	obj:GetChildren()
	obj.BasePart = val
	obj:GetDescendants()
end

local function PROTO326(val)
	-- empty
end

local function PROTO327(val)
	obj:GetChildren()
	obj:GetDescendants()
	local Character
	obj:IsA()
	local _cb = PROTO328
	obj:IsA()
	obj.Decal = val
end

local function PROTO328(val)
	LocalTransparencyModifier = val
	Transparency = val
end

local function PROTO329(val)
	obj:WaitForChild()
	obj.PlayerGui = val
	obj:Destroy()
	obj.ScreenGui = val
end

local function PROTO330(val)
	local _cb = PROTO331
end

local function PROTO331(val)
	obj.UICorner = val
	obj.Position = val
	obj.CornerRadius = val
	obj.Parent = val
	obj["Thickness"] = 1
	obj.Parent = val
	obj:FindFirstChild()
	obj.NextKillerDisplay = val
	obj.Text = val
	obj.TextColor3 = val
	obj["Text"] = "Next Killer: <font color='#888888'>Waiting...</font>"
	obj["TextSize"] = 11
	obj["RichText"] = true
	obj.Parent = val
	obj.Font = val
	obj.AnchorPoint = val
	obj["BackgroundTransparency"] = 0.15
	obj.Color = val
	obj["Transparency"] = 0.3
	local _cb = PROTO332
	obj.TextLabel = val
	obj["Name"] = "NextKillerDisplay"
	obj.Size = val
	obj.BackgroundColor3 = val
	obj:GetPlayers()
	obj.UIStroke = val
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
	obj:GetDescendants()
	local _cb = PROTO335
	obj:IsA()
	obj.BasePart = val
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
	obj:Hat()
	local _cb = PROTO337
	obj.BasePart = val
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
	obj:Hat()
	local _cb = PROTO339
	obj:IsA()
	obj.Decal = val
	obj:IsA()
	obj.BasePart = val
	obj:IsA()
	obj.BasePart = val
	obj:IsA()
	obj.Decal = val
	local _cb = PROTO340
	obj:GetDescendants()
	obj:IsA()
	obj.BasePart = val
	obj:GetDescendants()
	obj:IsA()
	obj.BasePart = val
	local _cb = PROTO341
	local Character
	obj:GetChildren()
end

local function PROTO339(val)
	-- empty
end

local function PROTO340(val)
	-- empty
end

local function PROTO341(val)
	-- empty
end

local function PROTO342(val)
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChild()
	local Character
	obj:GetPlayers()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO343(val)
	obj:FindFirstChild()
	obj:IsA()
	obj.LocalScript = val
	obj:FindFirstChild()
	obj.LeftHand = val
	obj.NEX_CureFlaskLaserPart = val
	obj.Color = val
	obj["Transparency"] = 0
	obj["Transparency"] = 1
	obj.CFrame = val
	obj["Transparency"] = 0
	obj:GetService()
	obj.Players = val
	obj.Size = val
	obj.Part = val
	obj["Name"] = "FlaskSilentAimLaser"
	obj["Anchored"] = true
	obj:GetChildren()
	obj:GetService()
	obj.Players = val
	obj:GetAttribute()
	obj.IsKiller = val
	obj:GetAttribute()
	obj.action = val
	obj:GetService()
	obj.Players = val
	obj:GetPlayers()
	obj.Parent = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.Material = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO344(val)
	Veil_ShowFOV = val
end

local function PROTO345(val)
	-- empty
end

local function PROTO346(val)
	local lastTime
	local Cooldown
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Character
	obj.CFrame = val
	local Distance
end

local function PROTO347(val)
	local Attached
	obj:Connect()
	local _cb = PROTO348
	obj:WaitForChild()
	obj.Animator = val
	obj:Connect()
	local _cb = PROTO349
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
	local Character
	local Surv_CrouchV
	obj:FindFirstChild()
	local Trigger
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO351(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:Survivors()
	obj:GetPlayers()
end

local function PROTO352(val)
	obj:GetAttribute()
	obj.isHealing = val
	obj:GetAttribute()
	obj.IsHooked = val
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
	obj:GetAttribute()
	obj.IsCarried = val
	obj:GetAttribute()
	obj.Knocked = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
end

local function PROTO353(val)
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	obj:FindFirstChild()
	obj.PrimaryPartPallet = val
	obj:PROTO354()
	obj:FindFirstChild()
	obj.PalletPoint = val
	local Pallets
	obj:FindFirstChild()
	obj.PalletPointSlide = val
end

local function PROTO354(val)
	local Position
end

local function PROTO355(val)
	obj:FindFirstChild()
	obj.PalletDropEvent = val
	obj:FindFirstChild()
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
	local _cb = PROTO358
end

local function PROTO358(val)
	local _cb = PROTO359
end

local function PROTO359(val)
	local Character
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO360(val)
	-- empty
end

local function PROTO361(val)
	obj.HumanoidRootPart = val
	obj.CFrame = val
	obj:Notify()
	obj.CFrame = val
	obj:IsA()
	obj.BasePart = val
	obj["Title"] = "Teleport"
	obj["Description"] = "Berhasil!"
	obj["Time"] = 1
	obj:IsA()
	obj.Model = val
	local Character
	obj.BasePart = val
end

local function PROTO362(val)
	ESP_SCP = val
	local ESP_Master
end

local function PROTO363(val)
	obj:Notify()
	obj.enabled = val
	obj.disabled = val
end

local function PROTO364(val)
	obj:GetPlayers()
end

local function PROTO365(val)
	obj:Connect()
	local _cb = PROTO366
end

local function PROTO366(val)
	local Name
end

local function PROTO367(val)
	-- empty
end

local function PROTO368(val)
	obj:IsA()
	obj:FindFirstChild()
	obj.icon = val
	obj:IsA()
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	obj.PlayerGui = val
	obj:IsA()
	obj:FindFirstChild()
	obj:IsA()
	obj.GuiButton = val
	obj:FindFirstChild()
	obj.sprint = val
end

local function PROTO369(val)
	-- empty
end

local function PROTO370(val)
	local AbsolutePosition
	local AbsoluteSize
	local MouseButton1Click
	local MouseButton1Down
	local MouseButton1Up
	obj:GetGuiInset()
	obj:SendTouchEvent()
	obj:SendTouchEvent()
	obj:function()
end

local function PROTO371(val)
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local Character
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO372(val)
	local Character
	obj:GetAttribute()
	obj.Crouchingserver = val
	obj:GetAttribute()
	obj.Crouching = val
end

local function PROTO373(val)
	-- empty
end

local function PROTO374(val)
	-- empty
end

local function PROTO375(val)
	obj:FindFirstChild()
	local _cb = PROTO376
end

local function PROTO376(val)
	local Texture
	local Image
end

local function PROTO377(val)
	obj.Visible = val
end

local function PROTO378(val)
	-- empty
end

local function PROTO379(val)
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
	obj:FindFirstChild()
	obj.Killer = val
end

local function PROTO381(val)
	local _cb = PROTO382
end

local function PROTO382(val)
	local KILLER_InfPursuit
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
	Ignored_Skills_List = val
end

local function PROTO386(val)
	local Generators
	obj:Notify()
	obj["Title"] = "TP Generator"
	obj["Description"] = "Generator tidak ditemukan!"
	obj.Description = val
	obj["Time"] = 2
	obj["Time"] = 1.2
	obj:Notify()
	obj["Title"] = "TP Generator"
end

local function PROTO387(val)
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
	obj["Title"] = "Watermark"
	obj["Description"] = "AKTIF"
	obj:Notify()
	obj["Title"] = "Watermark"
	obj["Time"] = 2
	obj:Notify()
end

local function PROTO388(val)
	-- empty
end

local function PROTO389(val)
	obj:Notify()
	obj["Title"] = "Full Bright"
	obj["Description"] = "Full Bright aktif!"
	obj["Time"] = 3
	OutdoorAmbient = val
	obj:Notify()
	Ambient = val
	obj["Title"] = "Full Bright"
	obj["Description"] = "Full Bright dimatikan"
	obj["Time"] = 3
end

local function PROTO390(val)
	-- empty
end

local function PROTO391(val)
	obj.Surv_SkillSpeed = val
end

local function PROTO392(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetPlayers()
	local StalkRange
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
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
	obj:Head()
end

local function PROTO394(val)
	obj:WorldToViewportPoint()
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local Veil_FOV
	obj:Survivors()
	local Character
	obj:GetPlayers()
	local SPEAR_MaxDist
	obj:FindFirstChild()
end

local function PROTO395(val)
	Misc_FakeName = val
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
	local _cb = PROTO400
end

local function PROTO400(val)
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
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local Character
end

local function PROTO403(val)
	local _cb = PROTO404
end

local function PROTO404(val)
	local PlayerGui
end

local function PROTO405(val)
	obj.FieldOfView = val
	local FOVEnabled
end

local function PROTO406(val)
	local ESP_Master
end

local function PROTO407(val)
	obj:GetChildren()
	obj:FindFirstChild()
end

local function PROTO408(val)
	-- empty
end

local function PROTO409(val)
	-- empty
end

local function PROTO410(val)
	local _cb = PROTO411
	LeapBypass = val
end

local function PROTO411(val)
	obj:tryActivate()
	local BypassLeap
	obj:function()
	obj:boolean()
	obj:playM2Animation()
end

local function PROTO412(val)
	obj.Sound = val
	obj:Destroy()
	obj.AnimationId = val
	obj:LoadAnimation()
	obj["Looped"] = true
	obj:Play()
	obj.Parent = val
	obj:Play()
	local Character
	obj.Animation = val
	obj.SoundId = val
	obj["Looped"] = true
	obj["Volume"] = 2
	obj:Stop()
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO413(val)
	obj:Stop()
	obj:Destroy()
end

local function PROTO414(val)
	-- empty
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
	obj:Disconnect()
	obj:IsA()
	obj.ImageLabel = val
	obj:FindFirstChild()
	obj.PlayerGui = val
	obj:GetDescendants()
	obj:GetAttribute()
	obj.OriginalImage = val
	obj:SetAttribute()
	obj.OriginalText = val
	obj:IsA()
	obj.TextLabel = val
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
	local _cb = PROTO418
end

local function PROTO418(val)
	obj.PlayerGui = val
	local TouchEnabled
	obj:IsA()
	obj:function()
	obj:IsA()
	obj.GuiButton = val
	obj:SendKeyEvent()
	obj:FindFirstChild()
	obj:SendKeyEvent()
	obj:SendKeyEvent()
	obj:SendKeyEvent()
end

local function PROTO419(val)
	obj:Survivors()
	obj.Unknown = val
	obj.Spectator = val
	local Team
	obj:Killer()
	obj.Killer = val
end

local function PROTO420(val)
	local Gui
	local GuiVisible
	obj["Enabled"] = true
	local Surv_AutoParry
end

local function PROTO421(val)
	local TryAttach
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
	local _cb = PROTO425
	obj:Notify()
	obj["Title"] = "Spectator Info"
	obj["Description"] = "✅ Display aktif di pojok atas"
	obj["Time"] = 3
end

local function PROTO425(val)
	-- empty
end

local function PROTO426(val)
	obj["Title"] = "Spectator Info"
	obj["Description"] = "Display dimatikan"
	obj["Time"] = 2
	obj:Notify()
	obj:Destroy()
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
	local _cb = PROTO430
	obj:table()
	obj:Pursuit()
	obj.Players = val
	obj:GetPlayers()
	obj:FireServer()
	local KILLER_SilentAimFlask
	local KILLER_InfPursuit
	local _cb = PROTO432
	obj:FireServer()
	local _cb = PROTO433
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local KILLER_InfLakeMist
	local KILLER_InfFrenzy
	obj:GetAttribute()
	obj:Vector3()
	local Team
	obj:GetAttribute()
	obj:IsCarrying()
	obj:FireServer()
	obj:AwardLog()
	local AntiBlind
	local Enabled
	obj:GetService()
	local Killer_BypassCarry
	obj:GetService()
	obj.Players = val
	obj:InvokeServer()
	obj:GetAttributes()
	obj:Fire()
	obj:LakeMist()
	obj:GetAttribute()
	obj.IsKiller = val
	obj:FireServer()
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	local _cb = PROTO434
	local _cb = PROTO435
	obj:AwardLog()
	obj["LakeMist"] = 0
	obj:LakeMist()
	obj:ThrowFlask()
	obj:PowerDoneDeactivating()
end

local function PROTO430(val)
	local _cb = PROTO431
end

local function PROTO431(val)
	obj:SetAttribute()
	obj.action = val
	obj.game = val
	obj:GetService()
	obj.Players = val
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
	obj:Connect()
	obj:GetService()
	obj.RunService = val
	obj:Disconnect()
end

local function PROTO439(val)
	obj:SetVisible()
	obj:SetVisible()
	obj:GetService()
	obj.Stats = val
	obj:GetValue()
	obj:SetText()
	obj:Disconnect()
end

local function PROTO440(val)
	obj:Disconnect()
	obj:SetVisible()
end

local function PROTO441(val)
	obj.Font = val
	obj["Text"] = "0"
	obj.FillDirection = val
	obj["TextSize"] = 13
	obj.VerticalAlignment = val
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Image"] = "rbxassetid://13321848320"
	obj.Padding = val
	obj.ImageLabel = val
	obj.AnchorPoint = val
	obj.UIGradient = val
	obj.BackgroundColor3 = val
	obj:Destroy()
	obj.AutomaticSize = val
	obj.ScreenGui = val
	obj.TextLabel = val
	obj.UICorner = val
	obj.HorizontalAlignment = val
	obj.Transparency = val
	obj.Parent = val
	obj.CornerRadius = val
	obj.UIListLayout = val
	obj.Parent = val
	obj.Frame = val
	obj["Name"] = "MainBox"
	obj.Size = val
	obj["BackgroundTransparency"] = 0.25
	obj["BorderSizePixel"] = 0
	obj.Parent = val
	obj["BackgroundTransparency"] = 1
	obj["Name"] = "SpectatorCounter"
	obj.TextColor3 = val
	obj:WaitForChild()
	obj.PlayerGui = val
end

local function PROTO442(val)
	obj.Size = val
	obj:Spectator()
	obj:FindFirstChild()
	obj.MainBox = val
	obj.Text = val
end

local function PROTO443(val)
	SkillCheck = val
end

local function PROTO444(val)
	obj:Connect()
	local _cb = PROTO445
	local Character
	obj.Animator = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
end

local function PROTO445(val)
	obj:Stop()
end

local function PROTO446(val)
	local _cb = PROTO447
end

local function PROTO447(val)
	obj:Disconnect()
end

local function PROTO448(val)
	CameraMaxZoomDistance = val
end

local function PROTO449(val)
	obj:Notify()
	obj["Description"] = "Korless Morph Applied"
	obj["Time"] = 3
end

local function PROTO450(val)
	-- empty
end

local function PROTO451(val)
	-- empty
end

local function PROTO452(val)
	obj:BindToClose()
	local _cb = PROTO453
end

local function PROTO453(val)
	obj:Disconnect()
end

local function PROTO454(val)
	local _cb = PROTO455
	local _cb = PROTO456
	obj:IsLoaded()
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
	obj:WaitForChild()
	obj.Modules = val
end

local function PROTO458(val)
	-- empty
end

local function PROTO459(val)
	obj:Notify()
	obj["Title"] = "Auto Run Mobile"
	obj:Notify()
	obj.AutoRunMobileEnabled = val
	obj["Description"] = "OFF"
	obj["Time"] = 2
	obj["Title"] = "Auto Run Mobile"
	obj["Description"] = "ON"
	obj["Time"] = 2
end

local function PROTO460(val)
	-- empty
end

local function PROTO461(val)
	obj:ToFTargetSelector()
end

local function PROTO462(val)
	obj:FindFirstChild()
	obj.Bottom = val
	local Windows
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
end

local function PROTO463(val)
	-- empty
end

local function PROTO464(val)
	obj:Notify()
	obj["Title"] = "Auto Pallet"
	obj:Notify()
	obj["Time"] = 2
	obj["Title"] = "Auto Pallet"
	obj["Description"] = "NONAKTIF"
	obj["Time"] = 2
end

local function PROTO465(val)
	-- empty
end

local function PROTO466(val)
	obj.Parent = val
	obj["AlwaysOnTop"] = true
	obj["ZIndex"] = 5
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	obj.FillColor = val
	local Colors
	obj.OutlineColor = val
	local ESP_Outline
	obj.Parent = val
	local Pallets
	obj["Name"] = "GateEH"
	obj.Parent = val
	obj:FindFirstChild()
	obj.GE_Text = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	obj:FindFirstChild()
	obj.Highlight = val
	obj["Name"] = "GEH"
	local ESP_Pallet
	obj["Name"] = "PalletEH"
	local ESP_Window
	obj.Highlight = val
	local Hooks
	obj.Adornee = val
	obj.Size = val
	obj:GetAttribute()
	obj.Parent = val
	obj:Destroy()
	obj.Transparency = val
	obj["Name"] = "WindowEH"
	obj.Parent = val
	obj.GE_Text = val
	obj.Adornee = val
	obj.FillColor = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local Windows
	obj.OutlineColor = val
	obj.Highlight = val
	local ESP_Gate
	obj["name"] = "GEN"
	obj.subtext = val
	obj.color = val
	obj.icon = val
	obj.Highlight = val
	obj.Color3 = val
	obj:FindFirstChild()
	obj.WindowEH = val
	obj:FindFirstChild()
	local Gates
	obj.FillColor = val
	obj.OutlineColor = val
	local Generators
	local ESP_Hook
	obj["Name"] = "HookEH"
	obj.BoxHandleAdornment = val
	local ESP_Master
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	local ESP_GeneratorName
	obj:FindFirstChild()
	obj.HookEH = val
	obj.FillColor = val
	local ESP_Generator
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.PalletEH = val
	obj.FillTransparency = val
	obj["OutlineTransparency"] = 0
	obj.Adornee = val
	obj.RepairProgress = val
end

local function PROTO467(val)
	pcall = val
	local _cb = PROTO468
end

local function PROTO468(val)
	local Pallets
	local Generators
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
	local Remotes
	obj:FindFirstChild()
	obj.Killers = val
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
	obj:IsA()
	obj.BasePart = val
	obj:GetDescendants()
	obj.CFrame = val
end

local function PROTO474(val)
	local InstantTPGate
	obj:SetValue()
	InstantTPGate = val
end

local function PROTO475(val)
	local _cb = PROTO476
end

local function PROTO476(val)
	obj:Stop()
end

local function PROTO477(val)
	local _cb = PROTO478
end

local function PROTO478(val)
	obj.GeneratorPoint = val
	obj:IsA()
	obj.BasePart = val
	obj:GetChildren()
end

local function PROTO479(val)
	-- empty
end

local function PROTO480(val)
	-- empty
end

local function PROTO481(val)
	HitSoundLastTime = val
	local _cb = PROTO482
	local HitSoundCooldown
	local HitSoundLastTime
	local HitSoundEnabled
end

local function PROTO482(val)
	local HitSoundVolume
	obj.Sound = val
	local HitSoundId
	obj.SoundId = val
	local _cb = PROTO483
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
	obj.Color = val
	obj.UIStroke = val
	obj["Text"] = "PARRY [ON]"
	obj["Text"] = "PARRY [OFF]"
	obj.TextColor3 = val
	obj:FindFirstChild()
	obj.Frame = val
	obj.TextColor3 = val
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
end

local function PROTO487(val)
	obj:IsA()
	obj.GuiObject = val
	obj:IsA()
	obj.GuiObject = val
	obj:function()
	local _cb = PROTO489
	local _cb = PROTO490
end

local function PROTO488(val)
	obj:SendKeyEvent()
	obj:SendKeyEvent()
end

local function PROTO489(val)
	local AbsolutePosition
	local AbsoluteSize
	obj:SendTouchEvent()
	obj:SendTouchEvent()
	obj:GetGuiInset()
end

local function PROTO490(val)
	local MouseButton1Down
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
	local _cb = PROTO493
	local _cb = PROTO494
	local SkillCheckMode
	obj:FindFirstChild()
	obj.SkillCheckPromptGui = val
	obj:FindFirstChild()
	obj.Line = val
	obj:FindFirstChild()
	obj.Goal = val
	local SkillCheck
	obj:FindFirstChild()
end

local function PROTO493(val)
	-- empty
end

local function PROTO494(val)
	-- empty
end

local function PROTO495(val)
	Surv_Aimbot_MaxDist = val
end

local function PROTO496(val)
	obj:Destroy()
end

local function PROTO497(val)
	local Enabled
	obj.Size = val
	local Thickness
	local Color
	obj.Color = val
	obj.Parent = val
	local Style
	obj.UIStroke = val
	obj.Color = val
	local Size
	obj.CornerRadius = val
	obj.AnchorPoint = val
	obj.BackgroundColor3 = val
	obj:Dot()
	obj.Frame = val
	obj["BackgroundTransparency"] = 1
	obj:Plus()
	obj.CornerRadius = val
	local OffsetY
	obj:Plus()
	obj.Thickness = val
	obj.Parent = val
	obj.Position = val
	obj:FindFirstChildOfClass()
	obj.UIStroke = val
	local _cb = PROTO498
	obj["BorderSizePixel"] = 0
	obj:Dot()
	obj.UICorner = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.ScreenGui = val
	local OffsetX
	obj.Size = val
	obj.Position = val
	obj.Size = val
	obj.Position = val
	obj.Size = val
	obj.Position = val
	obj.BackgroundColor3 = val
	obj.Size = val
	obj.Position = val
	obj.Frame = val
	obj:Circle()
	obj.AnchorPoint = val
	obj.Thickness = val
	obj.UICorner = val
	obj:Circle()
	obj.BackgroundColor3 = val
	obj.Size = val
	obj.Position = val
end

local function PROTO498(val)
	obj.Position = val
	obj.Parent = val
	local Color
	obj["BorderSizePixel"] = 0
	obj.AnchorPoint = val
	obj.Size = val
end

local function PROTO499(val)
	obj:FindFirstChildWhichIsA()
	obj.BasePart = val
	local Generators
	obj.model = val
	obj.part = val
	obj:gate()
	obj:window()
	obj:GetDescendants()
	obj:IsA()
	local Gates
	obj:GetDescendants()
	local Windows
	local SCPs
	local Pallets
	obj.Model = val
	obj:generator()
	obj:FindFirstChild()
	local Hooks
	obj:PrimaryPartPallet()
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Map = val
	obj:IsA()
	obj.Model = val
	obj:hook()
end

local function PROTO500(val)
	obj.Hook = val
	ESP_Hook = val
	local ESP_Master
end

local function PROTO501(val)
	-- empty
end

local function PROTO502(val)
	obj:GetAttribute()
	obj:GetPlayers()
end

local function PROTO503(val)
	obj:GetChildren()
	obj:Destroy()
	obj:GetPlayers()
end

local function PROTO504(val)
	local Character
	Surv_Perks = val
	obj:SetAttribute()
end

local function PROTO505(val)
	obj:Notify()
	obj["Title"] = "Fly"
	obj["Description"] = "Fly GUI Dimuat"
	obj["Title"] = "Fly"
	obj["Description"] = "Fly GUI terbuka"
	obj["Time"] = 3
	obj:Notify()
	obj:HttpGet()
	obj["Time"] = 3
	obj.fly = val
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
	obj:FindFirstChild()
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
	obj:FindFirstChild()
	obj.Map = val
	local _cb = PROTO510
end

local function PROTO510(val)
	obj:GetDescendants()
	obj:GetAttribute()
	obj.ProgressRepair = val
	local table
	obj:GetAttribute()
	obj.RepairProgress = val
	obj:IsA()
	obj.Model = val
end

local function PROTO511(val)
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:FindFirstChildOfClass()
	obj.Animator = val
	local Character
	local _cb = PROTO512
end

local function PROTO512(val)
	obj.Animation = val
	obj["AnimationId"] = "rbxassetid://92960319113695"
	obj.Priority = val
	obj:Play()
	obj:LoadAnimation()
end

local function PROTO513(val)
	-- empty
end

local function PROTO514(val)
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
	obj:HttpGet()
end

local function PROTO516(val)
	obj:GetPlayers()
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
	local _cb = PROTO518
	obj["Time"] = 2
	local _cb = PROTO519
end

local function PROTO518(val)
	-- empty
end

local function PROTO519(val)
	-- empty
end

local function PROTO520(val)
	-- empty
end

local function PROTO521(val)
	local Aim_Silent
	obj:FindFirstChild()
	obj.PlayerGui = val
	obj:GetAttribute()
	obj.spearmode = val
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	obj:FindFirstChild()
	local Flash_Silent
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Controls = val
	obj:FindFirstChild()
	obj.attack = val
end

local function PROTO522(val)
	obj:Notify()
	obj:Notify()
	local SelfHeal
	obj:SetValue()
	obj:Killer()
end

local function PROTO523(val)
	obj:SetAttribute()
	obj.lungeboost = val
end

local function PROTO524(val)
	local InfLakeMistJason
	KILLER_InfLakeMist = val
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
	obj:GetChildren()
	obj:FindFirstChild()
	obj.PlayerGui = val
end

local function PROTO529(val)
	Veil_LeadMultiplier = val
end

local function PROTO530(val)
	obj:GetPlayers()
end

local function PROTO531(val)
	local Character
end

local function PROTO532(val)
	-- empty
end

local function PROTO533(val)
	local _cb = PROTO534
end

local function PROTO534(val)
	local Character
	obj.HumanoidRootPart = val
end

local function PROTO535(val)
	obj:Disconnect()
end

local function PROTO536(val)
	Aim_SilentVeil = val
end

local function PROTO537(val)
	obj["FieldOfView"] = 70
	obj.FieldOfView = val
end

local function PROTO538(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:GetAttribute()
	obj.special = val
	local Veil_LeadMultiplier
	obj:FindFirstChild()
	local Character
	local SPEAR_Gravity
	local SpearSmart_enable
	obj:IsA()
	obj.Model = val
	local SPEAR_Speed
	local CFrame
	local AIM_Auto
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	local Aim_SilentVeil
	obj:IsA()
	obj.BasePart = val
	local _cb = PROTO539
	local _cb = PROTO540
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
end

local function PROTO539(val)
	-- empty
end

local function PROTO540(val)
	local Remotes
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
	local Connection
	obj:Disconnect()
	obj:Connect()
	Connection = val
end

local function PROTO543(val)
	local Character
	local _cb = PROTO544
	obj:FindFirstChild()
	obj:FindFirstChild()
end

local function PROTO544(val)
	obj["MeshId"] = "rbxassetid://902942096"
	obj["TextureID"] = "rbxassetid://902843398"
	obj.WeldConstraint = val
	local Head
	obj["Transparency"] = 1
	obj:FindFirstChild()
	obj.face = val
	obj:Destroy()
	obj.Part0 = val
	obj.Part1 = val
	obj.Parent = val
	obj.MeshPart = val
	obj["Name"] = "KorlessHead"
	obj.Size = val
	obj.CFrame = val
end

local function PROTO545(val)
	-- empty
end

local function PROTO546(val)
	local _cb = PROTO547
end

local function PROTO547(val)
	local _cb = PROTO548
	local _cb = PROTO549
	local _cb = PROTO550
end

local function PROTO548(val)
	obj["Time"] = 2
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Ready!"
end

local function PROTO549(val)
	obj:HttpGet()
end

local function PROTO550(val)
	obj:Notify()
	obj["Title"] = "Invisibility"
	obj["Description"] = "Gagal load script!"
	obj["Time"] = 3
end

local function PROTO551(val)
	-- empty
end

local function PROTO552(val)
	obj.BackgroundColor3 = val
	obj.TextColor3 = val
	obj["Text"] = "INVIS [ON]"
	obj:FindFirstChild()
	obj.Frame = val
	obj.BackgroundColor3 = val
	obj.Color = val
	local Gui
	obj.ActionButton = val
	obj:FindFirstChild()
	obj.TextColor3 = val
	obj.Color = val
	obj["Text"] = "INVIS [OFF]"
end

local function PROTO553(val)
	obj["Title"] = "Speed Input"
	obj["Description"] = "Speed Boost dimatikan"
	obj.Description = val
	obj["Time"] = 3
	obj:Notify()
	obj["Title"] = "Speed Input"
end

local function PROTO554(val)
	-- empty
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
	obj:FindFirstChild()
	obj.Jason = val
	obj:FireServer()
	local Character
	obj:FindFirstChild()
	obj.Remotes = val
end

local function PROTO556(val)
	local _cb = PROTO557
end

local function PROTO557(val)
	local KILLER_InfLakeMist
	local _cb = PROTO558
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
	local _cb = PROTO560
end

local function PROTO560(val)
	obj.LakeMist = val
	obj:SetAttribute()
	obj.speedboost = val
end

local function PROTO561(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.AnimationId = val
	obj:FindFirstChildOfClass()
	obj.Humanoid = val
	obj:Stop()
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.Animation = val
	obj:FindFirstChildOfClass()
	obj.Animator = val
	obj:LoadAnimation()
	obj:Play()
	obj:AdjustWeight()
	obj:Destroy()
	obj:Survivors()
	local Character
end

local function PROTO562(val)
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
	obj:HttpGet()
end

local function PROTO564(val)
	Pistol_BlockKnocked = val
end

local function PROTO565(val)
	obj:Connect()
	local _cb = PROTO566
	obj.NEX_CureFlaskLaserThread = val
	obj.RunService = val
end

local function PROTO566(val)
	obj:Disconnect()
	local KILLER_FlaskLaser
	obj.NEX_CureFlaskLaserThread = val
	obj.NEX_CureFlaskLaserPart = val
	local _cb = PROTO567
end

local function PROTO567(val)
	obj:Destroy()
end

local function PROTO568(val)
	local _cb = PROTO569
	obj.NEX_JeffCooldownBypassThread = val
end

local function PROTO569(val)
	local KILLER_InfFrenzy
	local _cb = PROTO570
	obj.NEX_JeffCooldownBypassThread = val
end

local function PROTO570(val)
	obj.Frenzy = val
	obj:GetAttribute()
	obj.Frenzy = val
	local Character
end

local function PROTO571(val)
	-- empty
end

local function PROTO572(val)
	local Pistol_BlockKnocked
	local Character
	local _cb = PROTO573
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
	-- empty
end

local function PROTO576(val)
	obj.MapPredictEnabled = val
	obj:GetService()
	obj.CoreGui = val
	local _cb = PROTO577
	local _cb = PROTO578
	local _cb = PROTO579
	local _cb = PROTO580
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
	obj.UICorner = val
	obj["ZIndex"] = 2
	obj.UICorner = val
	obj.TextColor3 = val
	obj.TextXAlignment = val
	obj.Color = val
	obj["Thickness"] = 1.5
	obj["BorderSizePixel"] = 0
	obj["Text"] = "MAP"
	obj["BackgroundTransparency"] = 1
	obj.Position = val
	obj["Text"] = "Status: —"
	obj.Font = val
	obj["TextSize"] = 9.5
	obj.TextLabel = val
	obj["Name"] = "MapStatus"
	obj.TextColor3 = val
	obj["Name"] = "MainFrame"
	obj["TextSize"] = 8
	obj.Font = val
	obj["TextSize"] = 11.5
	obj.Position = val
	local Instance
	obj.ScreenGui = val
	obj["Name"] = "MapPredictUI"
	obj["IgnoreGuiInset"] = true
	obj.TextXAlignment = val
	obj["RichText"] = true
	obj.Size = val
	obj.Position = val
	obj["Text"] = "Scanning..."
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.35
	obj["BorderSizePixel"] = 0
	obj.TextColor3 = val
	obj["BackgroundTransparency"] = 1
	obj.Parent = val
	obj.Frame = val
	obj.Size = val
	obj.TextLabel = val
	obj["Name"] = "Badge"
	obj["Transparency"] = 0.4
	obj:FindFirstChild()
	obj.MapPredictUI = val
	obj.Font = val
	obj.Size = val
	obj.Position = val
	obj.CornerRadius = val
	obj.UIStroke = val
	local MapPredictUI
	obj.CornerRadius = val
	obj.TextLabel = val
	obj.Size = val
	obj.AnchorPoint = val
end

local function PROTO579(val)
	obj.LargeBoulder01 = val
	obj:FindFirstChild()
	obj.HooksMeat = val
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.Rooftop = val
	obj:FindFirstChild()
	obj.Gate = val
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj.vfx = val
	obj:FindFirstChild()
	obj.Dumbster = val
	obj:FindFirstChild()
	obj.Bldg_Addon_RooftopUnit_A = val
	obj:FindFirstChild()
	obj.Map = val
	obj:FindFirstChild()
	obj:FindFirstChild()
end

local function PROTO580(val)
	obj.MainFrame = val
	local _cb = PROTO581
	obj.Enabled = val
	obj["Text"] = "Map: Unknown"
	obj.TextColor3 = val
	obj.TextColor3 = val
	obj["Text"] = "Status: Lobby"
	obj.TextColor3 = val
	obj:FindFirstChild()
	obj["Text"] = "Map: —"
	obj["Text"] = "Status: Lobby"
	obj.Unknown = val
	obj.TextColor3 = val
	obj["Text"] = "Status: Setting up..."
	obj:FindFirstChild()
	obj.Map = val
	obj.Text = val
	obj["Text"] = "Status: Lobby"
end

local function PROTO581(val)
	local Team
end

local function PROTO582(val)
	obj.ScreenGui = val
	obj["Name"] = "NEX_KillerPerksGui"
	obj["Name"] = "Holder"
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj.Font = val
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj.Color = val
	obj["Thickness"] = 1
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.15
	obj["BorderSizePixel"] = 0
	obj.Minimize = val
	obj.Size = val
	obj.Parent = val
	obj.UICorner = val
	obj.Frame = val
	obj.Frame = val
	obj["Name"] = "Panel"
	obj.Font = val
	obj["Active"] = true
	obj.Parent = val
	local _cb = PROTO583
	obj.UICorner = val
	obj.CornerRadius = val
	obj.Size = val
	obj["IgnoreGuiInset"] = true
	obj.Frame = val
	obj.TextColor3 = val
	obj:Connect()
	local _cb = PROTO584
	obj.TextXAlignment = val
	obj.TextYAlignment = val
	obj:GetService()
	obj.UserInputService = val
	obj:GetService()
	obj.CoreGui = val
	obj:GetService()
	obj.Workspace = val
	local _cb = PROTO586
	obj.Position = val
	obj["BackgroundTransparency"] = 1
	obj["Transparency"] = 0.3
	obj.Parent = val
	obj.Parent = val
	local _cb = PROTO588
	obj.Close = val
	obj.TextColor3 = val
	obj["TextSize"] = 11
	obj.TextLabel = val
	obj.Size = val
	obj.Parent = val
	obj.Size = val
	obj.TextLabel = val
	obj["Name"] = "KillerPerksText"
	obj:GetService()
	obj.Players = val
	obj.CornerRadius = val
	obj.Size = val
	obj.UIStroke = val
	obj:Connect()
	local _cb = PROTO589
	obj.TextXAlignment = val
	obj.Parent = val
	local _cb = PROTO590
	local _cb = PROTO591
	obj:Connect()
	local _cb = PROTO592
	obj["TextSize"] = 11
	obj.Parent = val
	obj:Connect()
	local _cb = PROTO594
	local _cb = PROTO595
	local _cb = PROTO596
	local _cb = PROTO597
	local _cb = PROTO599
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
end

local function PROTO583(val)
	obj:Destroy()
end

local function PROTO584(val)
	local Position
	obj:Connect()
	local _cb = PROTO585
end

local function PROTO585(val)
	local UserInputState
end

local function PROTO586(val)
	obj:WaitForChild()
	obj.PlayerGui = val
	local _cb = PROTO587
end

local function PROTO587(val)
	-- empty
end

local function PROTO588(val)
	Size = val
	Text = val
end

local function PROTO589(val)
	Position = val
end

local function PROTO590(val)
	obj.CornerRadius = val
	obj.Size = val
	obj.Parent = val
	obj.UICorner = val
	obj.Position = val
	obj.Text = val
	obj.TextColor3 = val
	obj["TextSize"] = 9
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.Font = val
	obj.TextButton = val
end

local function PROTO591(val)
	obj.Minimize = val
	obj.Show = val
	Size = val
	Text = val
	Visible = val
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
	-- empty
end

local function PROTO595(val)
	obj["right arm"] = true
	obj["left leg"] = true
	obj["right leg"] = true
	obj["head"] = true
	obj["humanoid"] = true
	obj["humanoidrootpart"] = true
	obj["left arm"] = true
end

local function PROTO596(val)
	obj:GetPlayers()
	obj.killer = val
end

local function PROTO597(val)
	obj.Name = val
	obj.Level = val
	obj:FindFirstChild()
	local _cb = PROTO598
	obj:FindFirstChild()
end

local function PROTO598(val)
	-- empty
end

local function PROTO599(val)
	obj.Unknown = val
	obj:GetPlayers()
end

local function PROTO600(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:FindFirstChild()
	obj.StunUI = val
	obj.CornerRadius = val
	obj.bill = val
	obj.fill = val
	obj.timer = val
	obj["duration"] = 2.2
	obj["startTime"] = 0
	obj.Position = val
	local _cb = PROTO601
	obj:GetAttributeChangedSignal()
	obj.IsStunned = val
	obj:Connect()
	obj.BackgroundColor3 = val
	obj["BackgroundTransparency"] = 0.3
	obj["BorderSizePixel"] = 0
	obj.UICorner = val
	obj.Position = val
	obj.BackgroundColor3 = val
	obj["BorderSizePixel"] = 0
	obj.UICorner = val
	obj.BillboardGui = val
	obj.Parent = val
	obj.TextLabel = val
	obj.TextColor3 = val
	obj["TextScaled"] = true
	obj.Font = val
	obj.Size = val
	obj.Size = val
	obj["Name"] = "StunUI"
	obj.Adornee = val
	obj["AlwaysOnTop"] = true
	obj.Frame = val
	obj.Frame = val
	obj:Destroy()
	local _cb = PROTO603
	obj:GetAttributeChangedSignal()
	obj.Immobile = val
	obj:Connect()
	local _cb = PROTO604
	obj.StudsOffsetWorldSpace = val
	obj.Size = val
	local Heartbeat
	obj:Connect()
	local _cb = PROTO605
	obj.Size = val
	obj["BackgroundTransparency"] = 1
	obj["Text"] = "⚡ STUNNED"
end

local function PROTO601(val)
	obj["Enabled"] = true
	obj["duration"] = 2.2
	obj.timer = val
	local HitSoundEnabled
	obj.startTime = val
	local _cb = PROTO602
end

local function PROTO602(val)
	local fill
	local duration
	local bill
	obj.Size = val
	obj.BackgroundColor3 = val
	obj.BackgroundColor3 = val
	obj.BackgroundColor3 = val
	local startTime
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
	obj:Disconnect()
	obj:GetAttribute()
	obj.IsStunned = val
	local Parent
	obj:GetAttribute()
	obj.Immobile = val
	obj:Disconnect()
end

local function PROTO606(val)
	obj:Destroy()
end

local function PROTO607(val)
	EnableJitter = val
	obj:Notify()
	obj.OFF = val
end

local function PROTO608(val)
	-- empty
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
end

local function PROTO611(val)
	-- empty
end

local function PROTO612(val)
	obj:Notify()
	obj["Title"] = "Teleport"
	obj:SetValues()
	obj.Description = val
	obj["Time"] = 3
end

local function PROTO613(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj.CFrame = val
	local Character
	obj:FindFirstChild()
	obj:FindFirstChild()
	obj:Notify()
	obj["Title"] = "Error"
	obj["Description"] = "Pilih pemain terlebih dulu!"
	obj["Time"] = 3
end

local function PROTO614(val)
	obj:RemoveTag()
	obj.Blocked = val
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
end

local function PROTO617(val)
	-- empty
end

local function PROTO618(val)
	-- empty
end

local function PROTO619(val)
	obj["Title"] = "FPS Cap"
	obj["Title"] = "FPS Cap"
	obj["Description"] = "Nonaktif"
	obj["Time"] = 2
	obj:Notify()
	obj.Description = val
	obj["Time"] = 2
end

local function PROTO620(val)
	-- empty
end

local function PROTO621(val)
	local _cb = PROTO622
end

local function PROTO622(val)
	obj:GetDescendants()
	local Results
	obj:IsA()
	obj.LocalScript = val
	obj:Destroy()
	obj:FindFirstChild()
	obj.endscreen = val
	obj:FindFirstChild()
	obj.Map = val
	local _cb = PROTO623
end

local function PROTO623(val)
	local MouseButton1Click
end

local function PROTO624(val)
	obj["Title"] = "Tools Jerk"
	obj["Description"] = "Tools Jerk berhasil dimuat!"
	obj["Title"] = "Error"
	obj["Description"] = "Gagal memuat Tools Jerk"
	obj["Time"] = 3
	local _cb = PROTO625
	obj:Notify()
end

local function PROTO625(val)
	obj:HttpGet()
end

local function PROTO626(val)
	obj:Connect()
	local _cb = PROTO627
	obj:GetPropertyChangedSignal()
	obj:Connect()
	local _cb = PROTO628
end

local function PROTO627(val)
	-- empty
end

local function PROTO628(val)
	-- empty
end

local function PROTO629(val)
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
	obj.Gate = val
	ESP_Gate = val
	local ESP_Master
end

local function PROTO634(val)
	Surv_Aimbot_Radius = val
end

local function PROTO635(val)
	obj:FindFirstChild()
	obj.HumanoidRootPart = val
	obj:IsA()
	obj.Model = val
	obj.Map = val
	obj:GetDescendants()
	obj:FindFirstChild()
	obj.CorpseCreated0492 = val
	obj:GetAttributes()
	obj:GetAttribute()
end

local function PROTO636(val)
	local Colors
	obj.SCP = val
end

local function PROTO637(val)
	-- empty
end

-- Main Script
local function main()

	obj:AddColorPicker({Tooltip = "Jarak trigger teleport", Default = 40, Min = 15, Max = 80})
	obj:AddCheckbox({Text = "Enable Aimbot", OnChanged = PROTO2})
	obj:Connect({Callback = PROTO3})
	obj:AddSlider({Callback = PROTO9})
	obj:Connect({Pistol_FOV = 150})
	obj:AddRightGroupbox({Killer_Aimbot_MaxDist = 12, Killer_Aimbot_Smoothness = 0.5})
	obj:AddButton({ShowToggleFrameInKeybinds = true})
	obj:AddSlider({Default = "None", Color = "CreateHookESP", OnChanged = PROTO10, OnChanged = PROTO11, OnChanged = PROTO12, OnChanged = PROTO13, OnChanged = PROTO14})
	obj:AddInput({Callback = PROTO15})
	obj:Connect({Default = "1"})
	obj:Connect({Callback = PROTO16})
	obj:Connect()
	obj:AddToggle({Text = "Moonwalk [PC]", Default = "Colors", Rounding = 0, OnChanged = PROTO18, OnChanged = PROTO19})
	obj:Connect({Default = "None", Callback = PROTO20})
	obj:AddRightGroupbox({GateClientModule = "CharacterAdded"})
	obj:AddToggle()
	obj:AddToggle({Tooltip = "Tampilkan button Moonwalk di layar (pencet button untuk aktif)", Callback = PROTO22, OnChanged = PROTO23, OnChanged = PROTO25, OnChanged = PROTO28})
	obj:AddToggle({Callback = PROTO35})
	obj:AddToggle({Text = "Full Bright", SyncToggleState = true, OnChanged = PROTO36, OnChanged = PROTO39, OnChanged = PROTO40})
	obj:AddToggle({Text = "Skill Hidden No CD", [105374834496520] = "Masked lunge", [138720291317243] = "Masked Tony", [106871536134254] = "Masked Alex", [130593238885843] = "Masked Cobra", [115244153053858] = "Masked Cobra lunge", [74968262036854] = "Hidden Basic", Rounding = 1, Callback = PROTO41, OnChanged = PROTO42})
	obj:AddDivider({Callback = PROTO43})
	obj:AddToggle({internal = "Zombie", display = "Zombie (L)"})
	obj:AddKeyPicker({Text = "Killer Stun Indicator", Default = "None", Mode = "Toggle", Callback = PROTO44, OnChanged = PROTO45, OnChanged = PROTO47, OnChanged = PROTO48})
	obj:AddToggle({Tooltip = "Tembus gate tanpa collision", Text = "Gen Name & Progress", Name = "FOVCircleGui_Standalone", Parent = "new", Default = true, IgnoreGuiInset = true, OnChanged = PROTO49, OnChanged = PROTO50, OnChanged = PROTO52})
	obj:AddSlider({Text = "Third Person (Killer)", Tooltip = "Mengubah posisi kamera ke belakang karakter", Callback = PROTO53})
	obj:AddTab({Text = "Position Y", Default = 0, Min = -100, Max = 100, Rounding = 0, Callback = PROTO55, OnChanged = PROTO57, OnChanged = PROTO58, OnChanged = PROTO60, OnChanged = PROTO63})
	obj:AddTab()
	obj:AddRightGroupbox()
	obj:Connect()
	obj:WaitForChild({Callback = PROTO64, OnChanged = PROTO66})
	obj:Connect({Default = "Manual Repair", OnChanged = PROTO67})
	obj:AddLeftGroupbox({Text = "Unlimited Vault", Tooltip = "Vault/ lompat jendela tanpa batas (tanpa cooldown)", Rounding = 0, OnChanged = PROTO68, OnChanged = PROTO70, OnChanged = PROTO71})
	obj:AddSlider()
	obj:AddRightGroupbox({Text = "Time Of Day", Callback = PROTO72, OnChanged = PROTO73, OnChanged = PROTO74})
	obj:HttpGet()
	obj:Connect()
	obj:AddSlider({Title = "Gate Color", Max = 100, Rounding = 0, OnChanged = PROTO75, OnChanged = PROTO78, OnChanged = PROTO79})
	obj:Connect({[113255068724446] = "Hidden lunge", [98163597193511] = "Hidden S1", [80411309607666] = "Abyssal S1", BackgroundColor = "Hidden S1", Style = "Dot", Text = "Open Mask Selector GUI", Tooltip = "Ga bisa mati (semi god)", Func = "Open Mask Selector GUI", SkillCheckMode = "Legit", Default = 2, Min = 1, Max = 5, OffsetX = 0, OffsetY = 0, Rounding = 0, OnChanged = PROTO80, OnChanged = PROTO81, OnChanged = PROTO82, OnChanged = PROTO83, OnChanged = PROTO84, OnChanged = PROTO85, OnChanged = PROTO86, OnChanged = PROTO88, OnChanged = PROTO89, OnChanged = PROTO90, OnChanged = PROTO91, OnChanged = PROTO92, OnChanged = PROTO93, OnChanged = PROTO96})
	obj:AddDropdown({Text = "Aktifkan Emote", Title = "Crosshair Color", Veil_ShowFOV = true, Transparency = 0, OnChanged = PROTO97, OnChanged = PROTO98, OnChanged = PROTO100, OnChanged = PROTO101, OnChanged = PROTO105, OnChanged = PROTO111, OnChanged = PROTO112})
	obj:GetService({CornerRadius = "new", Min = 1, Max = 4000, Default = 60, Callback = PROTO113})
	obj:SetFolder()
	obj:SetFolder()
	obj:Connect()
	obj:AddToggle({Callback = PROTO114})
	obj:AddSlider({[133963973694098] = "Mayers Basic", Default = "None"})
	obj:AddToggle()
	obj:AddToggle({Text = "Generator", Disabled = true, OnChanged = PROTO115, OnChanged = PROTO116, OnChanged = PROTO117})
	obj:AddToggle({Text = "Enable Crosshair", OnChanged = PROTO119, OnChanged = PROTO120, OnChanged = PROTO121})
	obj:AddSlider({Text = "Keybind FPS Cap", Tooltip = "Menampilkan jumlah player yang sedang jadi Spectator", OnChanged = PROTO122, OnChanged = PROTO123})
	obj:Connect({Text = "FPS Limit"})
	obj:AddLeftGroupbox({Callback = PROTO124})
	obj:AddToggle()
	obj:AddSlider({Text = "Enable Aimbot", OnChanged = PROTO125})
	obj:AddSlider({Default = true, Callback = PROTO126})
	obj:AddButton()
	obj:AddButton({Text = "TP Pallet (Loop)", Func = "TP Pallet (Loop)", Callback = PROTO127})
	obj:Connect({Rounding = 0, Callback = PROTO128, OnChanged = PROTO129, OnChanged = PROTO130})
	obj:AddRightGroupbox({Disabled = true, Keybind = true, Callback = PROTO137, OnChanged = PROTO139, OnChanged = PROTO143})
	obj:AddButton({Text = "Jitter Amount", Tooltip = "Besar efek acak (0 = mati, 5 = maksimal)", Default = 0, Placeholder = "0.1", Numeric = true})
	obj:WaitForChild({Text = "Refresh Count", Tooltip = "Menampilkan perk killer yang sedang digunakan", OnChanged = PROTO153})
	obj:AddKeyPicker({Text = "Parry Radius", Tooltip = "Jarak maksimal parry bereaksi", Transparency = 0.6, Min = 0, Max = 50, Rounding = 1, Disabled = true, OnChanged = PROTO155, OnChanged = PROTO156, OnChanged = PROTO157, OnChanged = PROTO160, OnChanged = PROTO161})
	obj:AddToggle({Default = "None", Text = "Toggle Anti Slow Vault", Mode = "Toggle"})
	obj:AddToggle({Text = "Show Veil FOV", Callback = PROTO162, OnChanged = PROTO163})
	obj:AddButton()
	obj:AddToggle()
	obj:AddToggle({Text = "Next Killer Display", Tooltip = "Menampilkan prediksi killer selanjutnya di layar", OnChanged = PROTO164})
	obj:AddButton({Text = "Next Map Prediction", Default = "0.01", Placeholder = "misal: 0.05", Callback = PROTO165, OnChanged = PROTO166})
	obj:AddKeyPicker({Text = "Refresh Map", Func = "Refresh Map", Callback = PROTO167})
	obj:AddToggle()
	obj:AddKeyPicker({Rounding = 0, OnChanged = PROTO168, OnChanged = PROTO169, OnChanged = PROTO170, OnChanged = PROTO171, OnChanged = PROTO172})
	obj:AddToggle({Text = "Infinite Frenzy Key", Mode = "Toggle", OnChanged = PROTO173})
	obj:AddCheckbox({Text = "Infinite Pursuit (Jason)", Default = "Hook", Title = "Hook Color", ShowToggleFrameInKeybinds = true, OnChanged = PROTO174, OnChanged = PROTO175, OnChanged = PROTO176, OnChanged = PROTO177})
	obj:AddColorPicker({Attach = "CreateModernESP", Text = "Killer", Rounding = 0, OnChanged = PROTO178, OnChanged = PROTO179, OnChanged = PROTO180, OnChanged = PROTO181, OnChanged = PROTO182})
	obj:AddColorPicker({Text = "Auto Run [PC]", Callback = PROTO183, OnChanged = PROTO184})
	obj:AddCheckbox({Text = "ESP Tracker Target"})
	obj:AddToggle()
	obj:AddToggle({Text = "Hide Name Key", Mode = "Toggle", Callback = PROTO185, OnChanged = PROTO186, OnChanged = PROTO191, OnChanged = PROTO192})
	obj:AddToggle({Text = "No Slowdown killer", Tooltip = "Hilangkan slowdown saat menyerang (Killer Only)"})
	obj:AddSlider()
	obj:AddSlider({Text = "Keybind Self Heal", Mode = "Toggle", SyncToggleState = true, Callback = PROTO196})
	obj:Connect({Text = "Size"})
	obj:AddLabel({Callback = PROTO197})
	obj:AddTab({Text = "Aggressive Mode", Tooltip = "Langsung parry tanpa peduli face direction", OnChanged = PROTO198})
	obj:AddKeyPicker({Surv_ParryCircle = true, SyncToggleState = true, Callback = PROTO199})
	obj:AddKeyPicker({Tooltip = "TP ke player yang di pilih", OnChanged = PROTO200})
	obj:AddKeyPicker({Text = "Ew Player", Tooltip = "Teleport ke gate secara instan tanpa delay", Default = "Pallet", Title = "Pallet Color", OnChanged = PROTO201, OnChanged = PROTO204, OnChanged = PROTO205, OnChanged = PROTO206})
	obj:AddKeyPicker({Callback = PROTO207})
	obj:GetPlayers({Default = "None", Text = "Auto Pallet Key"})
	obj:AddToggle()
	obj:AddButton({Text = "Instant TP Gate"})
	obj:AddToggle({Text = "No Fog", Mode = "Toggle", Tooltip = "Hapus kabut biar map lebih jelas", OnChanged = PROTO208, OnChanged = PROTO209, OnChanged = PROTO210, OnChanged = PROTO211, OnChanged = PROTO212})
	obj:AddToggle({Text = "Silent Veil V1", Surv_SkillFrequency = 10, Surv_SkillSpeed = 1, Disabled = true})
	obj:GetService({Text = "Esp Name", Callback = PROTO213, OnChanged = PROTO214})
	obj:HttpGet({Text = "Enable Hit Sound Effect", Tooltip = "Memutar suara 'Ahhh' saat berhasil stun killer", Surv_Aimbot_ShowFOV = true, Surv_Aimbot_Radius = 150, Callback = PROTO215, OnChanged = PROTO217})
	obj:AddToggle({Default = "", Text = "Pilih Player", Callback = PROTO218, OnChanged = PROTO219})
	obj:AddRightGroupbox({Text = "Enable Laser", Tooltip = "Muncul saat tombol flask di-hold", OnChanged = PROTO220})
	obj:AddToggle({Callback = PROTO222})
	obj:AddToggle({Text = "Block aim Knocked", OnChanged = PROTO223})
	obj:FindFirstChild()
	obj:Destroy()
	obj:AddCheckbox({Default = "I", Mode = "Toggle", Text = "Auto Dodge Veil", Disabled = true, Thickness = 1.5, Callback = PROTO224, OnChanged = PROTO225})
	obj:AddButton()
	obj:AddToggle()
	obj:Connect({Text = "Auto Parry GUI", ParryCooldownTime = 60, FillTransparency = 0.5, OutlineTransparency = 0, Callback = PROTO226})
	obj:Connect({Callback = PROTO227, OnChanged = PROTO228})
	obj:AddButton({Func = "spawn", Callback = PROTO231, OnChanged = PROTO232, OnChanged = PROTO237})
	obj:AddRightGroupbox({Text = "Rejoin Server", Disabled = true, Callback = PROTO238, OnChanged = PROTO239, OnChanged = PROTO240})
	obj:AddToggle()
	obj:AddToggle({Text = "Infinity Zoom Out"})
	obj:AddButton({Text = "Bypass Carry skill unlock", Disabled = true, OnChanged = PROTO241})
	obj:AddCheckbox({Text = "Keybind Flowstate No CD", Default = "None", Callback = PROTO242})
	obj:AddRightGroupbox({Text = "Killer Warn", Tooltip = "Otomatis jongkok saat Abyssal menggunakan S1", Size = "fromOffset", Mode = "Toggle", Player = "Auto Crouch (Dodge S1)", Default = 103, Max = 200, Rounding = 0, CornerRadius = 20, Disabled = true, Thickness = 2.5, OnChanged = PROTO244, OnChanged = PROTO245, OnChanged = PROTO246, OnChanged = PROTO247, OnChanged = PROTO248})
	obj:AddColorPicker()
	obj:AddSlider({Default = 15, Min = 5, Max = 25})
	obj:AddCheckbox({Text = "Counter Auto Parry", Default = "Counter Auto Parry", Title = "Window Color", OnChanged = PROTO250})
	obj:AddToggle({Text = "Lock Aim (Twist Of fate)", Tooltip = "Lock aim untuk item Pistol", OnChanged = PROTO251})
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
	obj:AddKeyPicker({OnChanged = PROTO256, OnChanged = PROTO258})
	obj:AddKeyPicker({Default = "None"})
	obj:AddCheckbox({Default = "None", Text = "Bypass Carry Key", Mode = "Toggle", Callback = PROTO260})
	obj:AddInput({Text = "Esp Distance", Min = 1, Max = 10, Default = 5, Rounding = 1, Callback = PROTO261})
	obj:HttpGet({Text = "Predict Aim Offset"})
	obj:AddSlider({Text = "ESP Range Circle", Attached = "Moonwalk v old", Tooltip = "Tampilkan radius jarak parry di karakter", Min = 8, Max = 30, Rounding = 0, lastTime = 0, Cooldown = 0.1, Distance = 6, Default = true, OnChanged = PROTO262, OnChanged = PROTO263, OnChanged = PROTO264, OnChanged = PROTO266})
	obj:AddLeftGroupbox({Callback = PROTO267})
	obj:AddCheckbox({Text = "Reset to 60 FPS", Callback = PROTO268})
	obj:AddLeftGroupbox({Text = "Fly GUI", Tooltip = "Sensitivitas arah pandang (1-10)", LeftLowerArm = true, RightLowerArm = true, LeftUpperArm = true, RightUpperArm = true, Default = 12, Min = -10, Max = 30, Rounding = 0, Callback = PROTO269, OnChanged = PROTO271, OnChanged = PROTO272, OnChanged = PROTO274, OnChanged = PROTO281})
	obj:AddButton()
	obj:AddToggle({Text = "Drop All Pallet", Func = "Drop All Pallet", Disabled = true, Callback = PROTO283})
	obj:GetService({Text = "Pilih Emote", Values = "Auto Drop Pallet", Default = "Friday Night", Callback = PROTO286})
	obj:GetService()
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Pallet", OnChanged = PROTO287, OnChanged = PROTO288, OnChanged = PROTO290})
	obj:AddSlider({Default = true, Callback = PROTO291, OnChanged = PROTO292, OnChanged = PROTO301})
	obj:AddLeftGroupbox({Text = "FOV Circle Radius", Func = "FOV Circle Radius"})
	obj:AddTab({Default = "VD", Text = "Abaikan skill tertentu", Tooltip = "Abaikan skill tertentu", Multi = true})
	obj:LoadAutoloadConfig({Callback = PROTO302})
	obj:AddToggle({Tooltip = "Memainkan animasi random buat ngelabui auto parry", Disabled = true, OnChanged = PROTO304})
	obj:AddButton({Text = "Anti Blind (Flashlight)", Tooltip = "Mencegah killer terkena blind dari senter survivor", Callback = PROTO305})
	obj:AddTab({Text = "Refresh Target List", Callback = PROTO307})
	obj:AddButton({Text = "TP Hook (Loop)", Func = "TP Hook (Loop)", Callback = PROTO308})
	obj:AddSlider({Text = "Toggle Vault Speed", Func = "TP Gate (Loop)", Callback = PROTO309, OnChanged = PROTO310})
	obj:AddToggle()
	obj:AddToggle({Min = 1, Max = 10, Default = 5})
	obj:AddCheckbox({Text = "Enable Esp", BackgroundTransparency = 1, OnChanged = PROTO311})
	obj:AddButton({Text = "Enable Speed Boost (Input Mode)", Tooltip = "Aktifkan speed boost dengan kecepatan di atas", Thickness = 2.5, Radius = 30})
	obj:AddButton({Text = "Hop Server", Callback = PROTO312})
	obj:AddCheckbox({Text = "No Shadow", Tooltip = "Matikan shadow", Callback = PROTO313})
	obj:AddToggle({Text = "Infinite Lunge Key", Default = "F9", Mode = "Toggle", Disabled = true, OnChanged = PROTO314, OnChanged = PROTO315})
	obj:AddToggle({Text = "Safety Parry", Callback = PROTO316, OnChanged = PROTO317, OnChanged = PROTO318, OnChanged = PROTO319})
	obj:AddSlider({Text = "Silent Aim (flash)", Disabled = true, OnChanged = PROTO323})
	obj:FindFirstChild({Callback = PROTO324})
	obj:AddRightGroupbox({Visibility = "SetWorldTransparency", Callback = PROTO325, OnChanged = PROTO327, OnChanged = PROTO329, OnChanged = PROTO330, OnChanged = PROTO333})
	obj:SetIgnoreIndexes({Text = "Gen Boost (Multi-Repair)", Tooltip = "Memperbaiki generator dengan cepat tanpa terdeteksi"})
	obj:AddLeftGroupbox({Callback = PROTO334, OnChanged = PROTO338})
	obj:AddToggle({Surv_ParryRadius = 15, Surv_ParryFace = 0.7, Surv_VaultSpeed = 13, Callback = PROTO342, OnChanged = PROTO343})
	obj:AddSlider({Default = true, Callback = PROTO344})
	obj:Connect({Text = "Mode Outline (Fill transparan)", Tooltip = "Lunge tanpa batas (Killer Only)", internal = "Killer", display = "Killer (K)", Default = 150, Min = 50, Callback = PROTO345, OnChanged = PROTO346, OnChanged = PROTO347, OnChanged = PROTO351, OnChanged = PROTO352, OnChanged = PROTO355, OnChanged = PROTO357, OnChanged = PROTO360})
	obj:AddRightGroupbox({Callback = PROTO361})
	obj:AddColorPicker({Callback = PROTO362})
	obj:AddRightGroupbox({Text = "Predict Aim ToF", Premium = true, OnChanged = PROTO363})
	obj:Connect({Callback = PROTO364})
	obj:AddInput({Text = "Min Players", Numeric = true, OnChanged = PROTO365, OnChanged = PROTO367})
	obj:Connect({Default = "None", Mode = "Toggle", Pistol_Target = "Survivor", Tooltip = "Teleport saat killer terlalu dekat", SyncToggleState = true, Flash_YOffset = 1.5, OnChanged = PROTO368, OnChanged = PROTO369, OnChanged = PROTO371, OnChanged = PROTO372, OnChanged = PROTO373})
	obj:AddToggle({Text = "Silent Aim Flask (Cure)", Default = "RightShift", NoUI = true, Callback = PROTO374, OnChanged = PROTO375, OnChanged = PROTO377, OnChanged = PROTO378, OnChanged = PROTO379, OnChanged = PROTO381})
	obj:AddButton({Text = "Silent Veil V2", Tooltip = "Lake Mist tanpa cooldown / unlimited", ESP_GeneratorName = true, Callback = PROTO384, OnChanged = PROTO385, OnChanged = PROTO386})
	obj:Connect({Tooltip = "Bikin map jadi terang biar lebih jelas", OnChanged = PROTO387, OnChanged = PROTO388, OnChanged = PROTO389, OnChanged = PROTO390})
	obj:FindFirstChild({Rounding = 1, Callback = PROTO391, OnChanged = PROTO392, OnChanged = PROTO393, OnChanged = PROTO394, OnChanged = PROTO395})
	obj:AddToggle({Min = 1, Max = 15, Rounding = 1, Callback = PROTO396})
	obj:AddTab({AutoShow = true})
	obj:AddSlider({Title = "Player Color", Max = 500, Rounding = 0, OnChanged = PROTO397, OnChanged = PROTO398, OnChanged = PROTO399})
	obj:AddToggle({Text = "Predict Efficiency", Tooltip = "Atur akurasi prediksi (0% = tanpa prediksi, 100% = full prediksi)", Default = 85, Min = 0, Callback = PROTO402, OnChanged = PROTO403})
	obj:Connect({Default = 90, Min = 60, Max = 120, Rounding = 0, Callback = PROTO405, OnChanged = PROTO406})
	obj:AddToggle({Text = "Spear Gravity", Min = 0, Callback = PROTO407, OnChanged = PROTO409, OnChanged = PROTO410, OnChanged = PROTO412, OnChanged = PROTO413, OnChanged = PROTO414})
	obj:Connect({Callback = PROTO415, OnChanged = PROTO416, OnChanged = PROTO417, OnChanged = PROTO419})
	obj:AddToggle({Callback = PROTO420})
	obj:AddColorPicker()
	obj:AddToggle({Callback = PROTO424, OnChanged = PROTO426})
	obj:AddToggle({OnChanged = PROTO427})
	obj:AddToggle({Text = "Killer Perks Display"})
	obj:AddSlider({Text = "Skill Check Mode", Default = 1, OnChanged = PROTO428})
	obj:SetLibrary({Text = "Skill Check Frequency", Tooltip = "Atur frekuensi munculnya skill check", Default = 10, Min = 1, Max = 50})
	obj:AddToggle({Callback = PROTO429, OnChanged = PROTO436})
	obj:AddCheckbox({Text = "Infinite Frenzy (Jeff)", Tooltip = "Frenzy tanpa cooldown / unlimited", Default = "Frenzy tanpa cooldown / unlimited", Title = "Generator Color", OnChanged = PROTO437})
	obj:AddCheckbox({Callback = PROTO438, OnChanged = PROTO440, OnChanged = PROTO441, OnChanged = PROTO442})
	obj:AddKeyPicker({Text = "Speed Boost Value", Default = 0.02, Min = 0.01, Callback = PROTO443})
	obj:AddKeyPicker()
	obj:AddToggle({Default = "None", Text = "Instant TP Gate Key", Mode = "Toggle", Tooltip = "Zoom Out tanpa batas", OnChanged = PROTO444, OnChanged = PROTO446, OnChanged = PROTO448})
	obj:WaitForChild()
	obj:AddButton({Text = "Apply Korless", OnChanged = PROTO449})
	obj:AddToggle({Text = "instan escape", AnchorPoint = "new", BackgroundTransparency = 1, Callback = PROTO450})
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Enable FPS + Ping Display", NotifySide = "Right", EnableSidebarResize = true, EnableCompacting = true, SidebarCompacted = true})
	obj:AddDropdown({Mode = "Toggle"})
	obj:GetService({Text = "TP Generator", Callback = PROTO451})
	obj:GetService()
	obj:GetService()
	obj:AddRightGroupbox()
	obj:ApplyToTab()
	obj:AddSlider()
	obj:AddToggle({Text = "Face Sensitivity", Default = "None", Callback = PROTO452})
	obj:AddDropdown({Text = "Di Ew Player", OnChanged = PROTO454, OnChanged = PROTO458})
	obj:AddCheckbox({})
	obj:Notify({Tooltip = "Atur waktu di game", Default = 14, Min = 0, Callback = PROTO459})
	obj:Connect({Title = "Pandu Hub", Description = "Berhasil Dimuat!", Time = 3, Callback = PROTO460})
	obj:AddInput({Text = "Vault Speed", Func = "TP Window (Loop)", SPEAR_Gravity = "Gravity", AIM_TargetPart = "Torso", [82666958311998] = "Jeff Frenzy", [78432063483146] = "Abyssal Basic", [118907603246885] = "Abyssal lunge", Veil_FOV = 150, SPEAR_Speed = 165, SPEAR_MaxDist = 200, Veil_LeadMultiplier = 1.4, Min = 10, Max = 20, Default = 13, Rounding = 1, Callback = PROTO461, OnChanged = PROTO462, OnChanged = PROTO463})
	obj:AddKeyPicker({Callback = PROTO464})
	obj:SetLibrary()
	obj:Connect()
	obj:AddLeftGroupbox({Callback = PROTO465})
	obj:AddDropdown()
	obj:FindFirstChild({Callback = PROTO466, OnChanged = PROTO467})
	obj:AddToggle()
	obj:AddRightGroupbox({Text = "No Fall Damage", Callback = PROTO469, OnChanged = PROTO472, OnChanged = PROTO473})
	obj:AddToggle()
	obj:AddCheckbox({Mode = "Toggle", OnChanged = PROTO474, OnChanged = PROTO475, OnChanged = PROTO477, OnChanged = PROTO479})
	obj:GetService()
	obj:GetService()
	obj:AddCheckbox({Text = "Show Moonwalk Button", display = "Survivors (J)", Max = 1000, Default = 300, Rounding = 0, OnChanged = PROTO480, OnChanged = PROTO481})
	obj:AddRightGroupbox({Title = "Killer Color", Tooltip = "Atur kecepatan putaran skill check (1-30, 10 = Normal)", Default = 10, Min = 1, Max = 30, Callback = PROTO484})
	obj:AddToggle()
	obj:GetService({Callback = PROTO485})
	obj:AddSlider({Callback = PROTO486, OnChanged = PROTO487, OnChanged = PROTO491, OnChanged = PROTO495})
	obj:WaitForChild({Text = "Aimbot Smoothness", Callback = PROTO496, OnChanged = PROTO497, OnChanged = PROTO499})
	obj:AddToggle({Text = "Hook", OnChanged = PROTO500})
	obj:AddColorPicker({Text = "Enable FPS Cap"})
	obj:AddKeyPicker({VD = "Colors", Max = 3, Rounding = 2, Callback = PROTO501})
	obj:AddKeyPicker({Default = "None", Name = "VD_VeilTarget"})
	obj:AddKeyPicker({Default = "None", Gui = "None", Text = "Fast vault", OnChanged = PROTO502, OnChanged = PROTO503, OnChanged = PROTO504})
	obj:AddColorPicker()
	obj:AddToggle()
	obj:GetService({Text = "Hide Name", Color = "Hide Name", Size = 8, Thickness = 2})
	obj:AddRightGroupbox({Callback = PROTO505})
	obj:AddLeftGroupbox({[117042998468241] = "Mayers lunge", [135002183282873] = "cure lunge", [121216847022485] = "cure Basic", [132817836308238] = "Jeff Basic", [129784271201071] = "Jeff lunge", HitSoundId = "rbxassetid://106225491596534", Tooltip = "Pursuit tanpa cooldown / unlimited", Text = "Fake Generator GUI", Mode = "Toggle", Func = "Fake Generator GUI", Default = 165, Rounding = 0, PredictionEfficiency = 0.85, LerpSmoothness = 0.4, MaxJitterStuds = 0, HitSoundVolume = 1, HitSoundCooldown = 0.3, HitSoundLastTime = 0, OnChanged = PROTO506, OnChanged = PROTO507, OnChanged = PROTO508, OnChanged = PROTO509, OnChanged = PROTO511, OnChanged = PROTO513, OnChanged = PROTO514})
	obj:AddDropdown({Callback = PROTO516})
	obj:AddToggle({Text = "Position X", Values = "Pilih Target (Shared)", Default = 0, Min = -100, Max = 100})
	obj:AddButton({Text = "Invisibility [OP]", Disabled = true, Callback = PROTO517, OnChanged = PROTO520})
	obj:AddToggle()
	obj:Connect()
	obj:AddKeyPicker({Callback = PROTO521, OnChanged = PROTO522})
	obj:WaitForChild()
	obj:WaitForChild()
	obj:WaitForChild()
	obj:AddKeyPicker({Callback = PROTO523})
	obj:AddToggle({Default = "None", Text = "Auto Stalk", Mode = "Toggle", OnChanged = PROTO524, OnChanged = PROTO525})
	obj:AddCheckbox({Text = "Infinite corrupt Abyssal", OnChanged = PROTO526, OnChanged = PROTO527})
	obj:AddDropdown({Default = 1.4, Rounding = 1, Callback = PROTO528, OnChanged = PROTO529, OnChanged = PROTO530})
	obj:AddSlider()
	obj:AddToggle()
	obj:AddColorPicker({Text = "Silent Aim Twist Of Fate"})
	obj:CreateWindow()
	obj:Connect({Title = "Pandu Hub", Footer = "Violence District v2.4.0 | https://discord.gg/panduhub", Icon = "94380161420025", Callback = PROTO531})
	obj:AddToggle({Text = "Show Hook Count", Tooltip = "Tampilkan jumlah hook di ATAS kepala survivor", Callback = PROTO532, OnChanged = PROTO533, OnChanged = PROTO535})
	obj:AddToggle({Text = "Veil Aim Key", Mode = "Toggle", Callback = PROTO536})
	obj:AddCheckbox()
	obj:AddToggle()
	obj:AddSlider({Text = "Camera FOV", Tooltip = "Atur jarak pandang kamera", OnChanged = PROTO537})
	obj:Connect({Text = "Melee Lock Distance", Color = "FOV Value", Transparency = 0.7, Min = 5})
	obj:GetService({Callback = PROTO538})
	obj:AddCheckbox({Default = 40, Min = 10, Max = 100})
	obj:AddDropdown()
	obj:AddCheckbox({Callback = PROTO541})
	obj:AddToggle()
	obj:AddButton({Text = "Safety Pallet", Tooltip = "Cegah drop pallet saat down/carry/hook (biar aman)", Callback = PROTO542})
	obj:AddSlider()
	obj:GetService({Text = "Toggle Skill Check", Default = "None", SyncToggleState = true, Callback = PROTO546, OnChanged = PROTO551, OnChanged = PROTO552, OnChanged = PROTO553, OnChanged = PROTO554, OnChanged = PROTO556, OnChanged = PROTO559, OnChanged = PROTO561, OnChanged = PROTO562})
	obj:GetService()
	obj:AddSlider()
	obj:AddDivider({Text = "Menu keybind", Tooltip = "Atur kelancaran tracking target (10 = cepat, 100 = lambat)", ToggleKeybind = "Menu keybind", Callback = PROTO564})
	obj:AddButton()
	obj:Connect({Text = "Fake Parry GUI", Callback = PROTO565, OnChanged = PROTO568})
	obj:AddToggle({OnChanged = PROTO571})
	obj:FindFirstChild()
	obj:AddToggle()
	obj:AddToggle({Callback = PROTO572, OnChanged = PROTO574})
	obj:Connect({Default = true, Text = "Enable Laser Effect", Mode = "Toggle", Tooltip = "Tambahkan efek acak pada prediksi", StalkRange = 150, OnChanged = PROTO575, OnChanged = PROTO576, OnChanged = PROTO582, OnChanged = PROTO600, OnChanged = PROTO606, OnChanged = PROTO607, OnChanged = PROTO608})
	obj:Connect({Surv_Aimbot_MaxDist = 300, Surv_Aimbot_Smoothness = 0.5, Surv_Aimbot_Predict = 0.01})
	obj:AddButton({Callback = PROTO609, OnChanged = PROTO611})
	obj:AddButton({Text = "Refresh Player", Func = "Refresh Player", Callback = PROTO612})
	obj:Connect({Text = "Teleport ke player yang dipilih", Func = "Teleport ke player yang dipilih", Callback = PROTO613})
	obj:AddToggle({Callback = PROTO614})
	obj:AddCheckbox({Text = "Esp Item Icon", Tooltip = "Mencegah perlambatan saat vault (perfect vault)", Callback = PROTO615, OnChanged = PROTO616, OnChanged = PROTO617})
	obj:AddToggle()
	obj:AddKeyPicker({Text = "Wallcheck", [139369275981139] = "Jason Basic", [110355011987939] = "Jason lunge", [111920872708571] = "Masked Basic", Tooltip = "Aktifkan pembatas FPS", OnChanged = PROTO618, OnChanged = PROTO619})
	obj:BuildConfigSection({Default = "None", Text = "Max Players", Numeric = true, Thickness = 1.5, OnChanged = PROTO620, OnChanged = PROTO621})
	obj:Wait()
	obj:AddButton()
	obj:Connect({Text = "Tools Jerk", Func = "Tools Jerk", Max = 24, Rounding = 0, Callback = PROTO624, OnChanged = PROTO626, OnChanged = PROTO629})
	obj:IsLoaded()
	obj:AddSlider({Callback = PROTO630})
	obj:AddSlider({Text = "Exit Gate", Mode = "Toggle", Min = 2, Max = 30, Default = 8, Rounding = 0, ["Left Arm"] = true, ["Right Arm"] = true, LeftHand = true, RightHand = true, Callback = PROTO631, OnChanged = PROTO632, OnChanged = PROTO633, OnChanged = PROTO634})
	obj:AddToggle({Text = "Trigger Distance", Min = 50, Default = 10})
	obj:OnClick({internal = "Survivors", Default = "GetSCPs", Title = "SCP Color", Callback = PROTO635, OnChanged = PROTO636})

end

main()