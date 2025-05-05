local Library = {}
local PlayerGui = game:GetService("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Gui = game.Players.LocalPlayer.PlayerGui
local SectionStr = "Section"
local WindowStr = "Window"
local oldPlr
local oldCore
local studio
local client


if RunService:IsStudio() then
	oldPlr = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("WizardLibrary")
	oldCore = false
	studio = true
else
	oldPlr = false
	client = true
	oldCore = CoreGui:FindFirstChild("WizardLibrary")
end

if oldPlr then
	oldPlr:Destroy()
elseif oldCore then
	oldCore:Destroy()
end

wait(0.5)

local WizardLibrary = Instance.new("ScreenGui")
WizardLibrary.Name = "WizardLibrary"

if RunService:IsStudio() then
	WizardLibrary.Parent = game.Players.LocalPlayer.PlayerGui
else
	WizardLibrary.Parent = CoreGui
end

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = WizardLibrary
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 0, 0, 0)
Container.Size = UDim2.new(0, 100, 0, 100)

function Library:MakeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

function EnterLeaveButton(button, corner, cornerRad, transparency)
	if corner then
		local UICorner = Instance.new("UICorner")
		UICorner.Parent = button
		UICorner.CornerRadius = UDim.new(0, cornerRad)
	end
	if button:IsA("ImageLabel") or button:IsA("ImageButton") then
		local startTrans = button.ImageTransparency
		button.MouseEnter:Connect(function()
			button.ImageTransparency = transparency
		end)
		button.MouseLeave:Connect(function()
			button.ImageTransparency = startTrans
		end)
	else
		local startTrans = button.BackgroundTransparency
		button.MouseEnter:Connect(function()
			button.BackgroundTransparency = transparency
		end)
		button.MouseLeave:Connect(function()
			button.BackgroundTransparency = startTrans
		end)
	end
end

function Library:NewWindow(title)
	local Window = Instance.new("ImageLabel")
	Window.Name = title.."Window"
	Window.ScaleType = Enum.ScaleType.Slice
	Window.Image = "http://www.roblox.com/asset/?id=3570695787"
	Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Window.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Window.Size = UDim2.new(0, 170, 0, 30)
	Window.ZIndex = 2
	Window.SliceScale = 0.05
	Window.SliceCenter = Rect.new(100, 100, 100, 100)
	Window.BorderSizePixel = 0
	Window.BackgroundTransparency = 1
	local childNum = 0
	local offsetX = -100
	
	Container.ChildAdded:Connect(function(child)
		childNum = childNum + 1
		if #Container:GetChildren() == 1 then
			child.Position = UDim2.new(2, -100, 3, -265)
		else
			offsetX = offsetX + 200
			child.Position = UDim2.new(2, offsetX, 3, -265)
		end
	end)
	Window.Parent = Container
	
	self:MakeDraggable(Window)

	local Topbar = Instance.new("Frame")
	Topbar.Parent = Window
	Topbar.Name = "Topbar"
	Topbar.BackgroundTransparency = 1
	Topbar.Size = UDim2.new(0, 170, 0, 30)
	Topbar.ZIndex = 2

	local BottomRoundCover = Instance.new("Frame")
	BottomRoundCover.Parent = Topbar
	BottomRoundCover.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	BottomRoundCover.Size = UDim2.new(0, 170, 0, 5)
	BottomRoundCover.Position = UDim2.new(0, 0, 0.833, 0)
	BottomRoundCover.BorderSizePixel = 0
	BottomRoundCover.ZIndex = 2

	local WindowToggle = Instance.new("TextButton")
	WindowToggle.Name = "WindowToggle"
	WindowToggle.Parent = Topbar
	WindowToggle.BackgroundTransparency = 1
	WindowToggle.Position = UDim2.new(0.72, 0, 0, 0)
	WindowToggle.Size = UDim2.new(0, 30, 0, 30)
	WindowToggle.ZIndex = 2
	WindowToggle.TextSize = 20
	WindowToggle.Font = Enum.Font.SourceSansSemibold
	WindowToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowToggle.Text = "-"
	local collapsed = false

	
	local WindowClose = Instance.new("TextButton")
	WindowClose.Name = "WindowClose"
	WindowClose.Parent = Topbar
	WindowClose.Font = Enum.Font.SourceSansSemibold
	WindowClose.Text = "x"
	WindowClose.TextSize = 16
	WindowClose.ZIndex = 2
	WindowClose.BackgroundTransparency = 1
	WindowClose.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowClose.BackgroundColor3 = Color3.fromRGB(255, 255 ,255)
	WindowClose.Size = UDim2.new(0, 30, 0, 30)
	WindowClose.Position = UDim2.new(0.825, 0, 0, 0)
	
	

	local WindowTitle = Instance.new("TextLabel")
	WindowTitle.Text = title
	WindowTitle.Parent = Topbar
	WindowTitle.Name = "WindowTitle"
	WindowTitle.TextColor3 = Color3.new(255, 255, 255)
	WindowTitle.TextSize = 17
	WindowTitle.Size = UDim2.new(0, 170, 0, 30)
	WindowTitle.Position = UDim2.new(0.053, 0, 0, 0)
	WindowTitle.ZIndex = 2
	WindowTitle.Font = Enum.Font.SourceSansBold
	WindowTitle.BackgroundTransparency = 1
	WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

	local Body = Instance.new("ImageLabel")
	Body.Name = "Body"
	Body.BackgroundTransparency = 1
	Body.Parent = Window
	Body.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Body.ImageColor3 = Color3.fromRGB(35, 35, 35)
	Body.Position = UDim2.new(0, 0, 0, 0)
	Body.Image = "http://www.roblox.com/asset/?id=3570695787"
	Body.ScaleType = Enum.ScaleType.Slice
	Body.SliceScale = 0.05
	Body.SliceCenter = Rect.new(100, 100, 100, 100)
	Body.ZIndex = 1
	Body.ClipsDescendants = true
	
	local TopbarBodyCover = Instance.new("Frame")
	TopbarBodyCover.BackgroundTransparency = 1
	TopbarBodyCover.Size = UDim2.new(0, 170, 0, 30)
	TopbarBodyCover.ZIndex = 1
	TopbarBodyCover.LayoutOrder = 0
	TopbarBodyCover.Parent = Body
	TopbarBodyCover.Name = "TopbarBodyCover"
	
	local Padding = Instance.new("UIPadding")
	Padding.Parent = Body
	Padding.PaddingTop = UDim.new(0, 0)
	Padding.PaddingBottom = UDim.new(0, 5)
	Padding.PaddingLeft = UDim.new(0, 0)
	Padding.PaddingRight = UDim.new(0, 0)


	local Sorter = Instance.new("UIListLayout")
	Sorter.Name = "Sorter"
	Sorter.FillDirection = Enum.FillDirection.Vertical
	Sorter.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Sorter.SortOrder = Enum.SortOrder.LayoutOrder
	Sorter.VerticalAlignment = Enum.VerticalAlignment.Top
	Sorter.Parent = Body
	local ListLayout = Sorter
	local Totalsize = 0
	Body.ChildAdded:Connect(function()
		Totalsize = Body:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 5
	end)
	Sorter:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if Sorter.AbsoluteContentSize.Y > 0 then
			Totalsize = Body:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 5
		else
			task.wait()
		end
	end)
	
	WindowToggle.MouseButton1Click:Connect(function()
		local collapsing = (WindowToggle.Text == "-")
		local targetText = collapsing and "v" or "-"
		local newTextSize = collapsing and 14 or 20

		for _, frame in ipairs(Body:GetChildren()) do
			if frame:IsA("Frame") then
				frame.Visible = not collapsing
			end
		end

		task.wait()
		local targetSize = collapsing
			and UDim2.new(0, 170, 0, 35)
			or UDim2.new(0, 170, 0, Totalsize)

		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local fadeOut = TweenService:Create(WindowToggle, tweenInfo, {TextTransparency = 1})
		local fadeIn = TweenService:Create(WindowToggle, tweenInfo, {TextTransparency = 0})
		local sizeTween = TweenService:Create(Body, tweenInfo, {Size = targetSize})

		fadeOut:Play()
		fadeOut.Completed:Connect(function()
			WindowToggle.Text = targetText
			WindowToggle.TextSize = newTextSize
			fadeIn:Play()
		end)

		sizeTween:Play()
	end)
	WindowClose.MouseButton1Click:Connect(function()
		local X = Body.Size.X.Offset
		local Y = Body.Size.Y.Offset
		local x = Window.Size.X.Offset
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local sizeTween = TweenService:Create(Body, tweenInfo, {Size = UDim2.new(0, X, 0, 0) })
		sizeTween:Play()
		wait(0.35)
		local tweenInfo = TweenInfo.new(0.23, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local sizeTween = TweenService:Create(Window, tweenInfo, {Size = UDim2.new(0, x, 0, 0) })
		Window.ClipsDescendants = true
		sizeTween:Play()
		sizeTween.Completed:Wait()
		Window:Destroy()
	end)



	local windowObject = {}

	function windowObject:Exit()
		local X = Body.Size.X.Offset
		local Y = Body.Size.Y.Offset
		local x = Window.Size.X.Offset
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local sizeTween = TweenService:Create(Body, tweenInfo, {Size = UDim2.new(0, X, 0, 0) })
		sizeTween:Play()
		wait(0.35)
		local tweenInfo = TweenInfo.new(0.23, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local sizeTween = TweenService:Create(Window, tweenInfo, {Size = UDim2.new(0, x, 0, 0) })
		Window.ClipsDescendants = true
		sizeTween:Play()
		sizeTween.Completed:Wait()
		Window:Destroy()
	end

	function windowObject:NewSection(name)
		
		local Section = Instance.new("Frame")
		Section.Name = (name.."Section")
		Section.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Section.Parent = Body
		Section.Position = UDim2.new(0, 0, 0, 0)
		Section.Size = UDim2.new(0, 170, 0, 0)
		Section.ZIndex = 1
		Section.ClipsDescendants = true
		Section.BorderSizePixel = 0
		Section.AutomaticSize = Enum.AutomaticSize.Y

		local Layout = Instance.new("UIListLayout")
		Layout.Parent = Section
		Layout.Name = "Layout"
		Layout.FillDirection = Enum.FillDirection.Vertical
		Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		Layout.VerticalAlignment = Enum.VerticalAlignment.Top
		
		local SectionInfo = Instance.new("Frame")
		SectionInfo.BackgroundTransparency = 1
		SectionInfo.Size = UDim2.new(0, 170, 0, 30)
		SectionInfo.Parent = Section
		SectionInfo.Name = "SectionInfo"
		SectionInfo.BorderSizePixel = 0
		
		local SectionTopFill = Instance.new("Frame")
		SectionTopFill.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		SectionTopFill.LayoutOrder = 0
		SectionTopFill.Parent = Section
		SectionTopFill.Size = UDim2.new(0, 170, 0, 7)

		local SectionToggle = Instance.new("TextButton")
		SectionToggle.Name = "SectionToggle"
		SectionToggle.Size = UDim2.new(0, 30, 0, 30)
		SectionToggle.Position = UDim2.new(0.822, 0, 0, 0)
		SectionToggle.BackgroundTransparency = 1
		SectionToggle.Parent = SectionInfo
		SectionToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		SectionToggle.ZIndex = 2
		SectionToggle.TextSize = 14
		SectionToggle.Text = "v"
		SectionToggle.Font = Enum.Font.SourceSansSemibold
		
		local SectionTitle = Instance.new("TextLabel")
		SectionTitle.Name = "SectionTitle"
		SectionTitle.Text = name
		SectionTitle.BackgroundTransparency = 1
		SectionTitle.Position = UDim2.new(0.053, 0, 0, 0)
		SectionTitle.Parent = SectionInfo
		SectionTitle.Size = UDim2.new(0, 125, 0, 30)
		SectionTitle.TextSize = 17
		SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		SectionTitle.Font = Enum.Font.SourceSansBold
		SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
		SectionTitle.BorderSizePixel = 0
		
		
		local sectionObject = {}
		function sectionObject:CreateText(text)
			local TextHolder = Instance.new("Frame")
			TextHolder.Name = (text.."TextHolder")
			TextHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			TextHolder.Size = UDim2.new(0, 170, 0, 30)
			TextHolder.Parent = Section
			TextHolder.BorderSizePixel = 0
			
			local Text = Instance.new("TextLabel")
			Text.Text = text
			Text.Name = "Text"
			Text.Font = Enum.Font.SourceSansBold
			Text.TextSize = 14
			Text.TextColor3 = Color3.fromRGB(255, 255, 255)
			Text.BackgroundTransparency = 1
			Text.Size = UDim2.new(0, 125, 0, 30)
			Text.Parent = TextHolder
			Text.Position = UDim2.new(0.053, 0, 0, 0)
			Text.TextXAlignment = Enum.TextXAlignment.Left
			Text.BorderSizePixel = 0
		end
		
		function sectionObject:CreateButton(text, callback)
			local ButtonHolder = Instance.new("Frame")
			ButtonHolder.Name = (text.."ButtonHolder")
			ButtonHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			ButtonHolder.Size = UDim2.new(0, 170, 0, 30)
			ButtonHolder.Parent = Section
			ButtonHolder.BorderSizePixel = 0
			
			local Button = Instance.new("TextButton")
			Button.BackgroundTransparency = 1
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0, 153, 0, 24)
			Button.Position = UDim2.new(0.053, 0, 0, 0)
			Button.Text = text
			Button.Font = Enum.Font.SourceSansBold
			Button.TextSize = 14
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.Parent = ButtonHolder
			Button.ZIndex= 2
		
			
			Button.MouseButton1Click:Connect(function()
				if callback then
					callback()
				end
			end)
			
			local ButtonRound = Instance.new("ImageLabel")
			ButtonRound.ScaleType = Enum.ScaleType.Slice
			ButtonRound.BackgroundTransparency = 1
			ButtonRound.BorderSizePixel = 0
			ButtonRound.Position = UDim2.new(0.5, 0, 0.5, 0)
			ButtonRound.SliceCenter = Rect.new(100, 100, 100, 100)
			ButtonRound.SliceScale = 0.04
			ButtonRound.TileSize = UDim2.new(1, 0, 1, 0)
			ButtonRound.ImageColor3 = Color3.fromRGB(65, 65, 65)
			ButtonRound.Image = "http://www.roblox.com/asset/?id=3570695787"
			ButtonRound.Parent = Button
			ButtonRound.Size = UDim2.new(1, 0, 1, 0)
			ButtonRound.AnchorPoint = Vector2.new(0.5, 0.5)
			EnterLeaveButton(ButtonRound, false, 0, 0.2)
		end
		
		function sectionObject:CreateTextbox(text, callback)
			local TextboxHolder = Instance.new("Frame")
			TextboxHolder.Name = (text.."TextboxHolder")
			TextboxHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			TextboxHolder.Size = UDim2.new(0, 170, 0, 30)
			TextboxHolder.Parent = Section
			TextboxHolder.BorderSizePixel = 0

			local TextBox = Instance.new("TextBox")
			TextBox.BackgroundTransparency = 1
			TextBox.BorderSizePixel = 0
			TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
			TextBox.Font = Enum.Font.SourceSans
			TextBox.TextSize = 14
			TextBox.Position = UDim2.new(0.053, 0, 0, 0)
			TextBox.Size = UDim2.new(0, 153, 0, 24)
			TextBox.PlaceholderText = text
			TextBox.Parent = TextboxHolder
			TextBox.Name = "Textbox"
			TextBox.Font = Enum.Font.SourceSansBold
			TextBox.TextSize = 14
			TextBox.ZIndex = 2
			TextBox.Text = ""
			
			local TextboxRound = Instance.new("ImageLabel")
			TextboxRound.ScaleType = Enum.ScaleType.Slice
			TextboxRound.BackgroundTransparency = 1
			TextboxRound.BorderSizePixel = 0
			TextboxRound.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextboxRound.SliceCenter = Rect.new(100, 100, 100, 100)
			TextboxRound.SliceScale = 0.04
			TextboxRound.TileSize = UDim2.new(1, 0, 1, 0)
			TextboxRound.ImageColor3 = Color3.fromRGB(65, 65, 65)
			TextboxRound.Image = "http://www.roblox.com/asset/?id=3570695787"
			TextboxRound.Parent = TextBox
			TextboxRound.Size = UDim2.new(1, 0, 1, 0)
			TextboxRound.AnchorPoint = Vector2.new(0.5, 0.5)
			EnterLeaveButton(TextboxRound, false, 0, 0.1)

			TextBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					callback(TextBox.Text)
				end
			end)
		end

		function sectionObject:CreateDropdown(text, options, callback)
			local DropdownHolder = Instance.new("Frame")
			DropdownHolder.Name = text.."DropdownHolder"
			DropdownHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			DropdownHolder.Size = UDim2.new(0, 170, 0, 30)
			DropdownHolder.Parent = Section
			DropdownHolder.BorderSizePixel = 0

			local DropdownTitle = Instance.new("TextLabel")
			DropdownTitle.Parent = DropdownHolder
			DropdownTitle.BackgroundTransparency = 1
			DropdownTitle.Position = UDim2.new(0.053, 0, 0, 0)
			DropdownTitle.Size = UDim2.new(0, 153, 0, 24)
			DropdownTitle.Text = text
			DropdownTitle.Font = Enum.Font.SourceSansBold
			DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropdownTitle.TextSize = 14
			DropdownTitle.ZIndex = 2
			DropdownTitle.Name = "DropdownTitle"

			local DropdownToggle = Instance.new("TextButton")
			DropdownToggle.BackgroundTransparency = 1
			DropdownToggle.Position = UDim2.new(0.817, 0, 0, 0)
			DropdownToggle.Size = UDim2.new(0, 28, 0, 24)
			DropdownToggle.Font = Enum.Font.SourceSansBold
			DropdownToggle.Text = ">"
			DropdownToggle.TextSize = 15
			DropdownToggle.Parent = DropdownTitle
			DropdownToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropdownToggle.Name = "DropdownToggle"

			local DropdownMain = Instance.new("ImageLabel")
			DropdownMain.Parent = DropdownTitle
			DropdownMain.BackgroundTransparency = 1
			DropdownMain.Position = UDim2.new(1.093, 0, -0.034, 0)
			DropdownMain.Size = UDim2.new(0, 153, 0, 0)
			DropdownMain.ScaleType = Enum.ScaleType.Slice
			DropdownMain.SliceScale = 0.04
			DropdownMain.SliceCenter = Rect.new(100, 100, 100, 100)
			DropdownMain.Image = "http://www.roblox.com/asset/?id=3570695787"
			DropdownMain.ImageColor3 = Color3.fromRGB(35, 35, 35)
			DropdownMain.ClipsDescendants = true
			DropdownMain.Name= "DropdownMain"

			local ScrollingFrame = Instance.new("ScrollingFrame")
			ScrollingFrame.BackgroundTransparency = 1
			ScrollingFrame.Parent = DropdownMain
			ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
			ScrollingFrame.Size = UDim2.new(0, 153, 0, 0)
			ScrollingFrame.ScrollBarThickness = 3
			ScrollingFrame.AutomaticSize = Enum.AutomaticSize.Y
			ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
			ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

			local ButtonLayout = Instance.new("UIListLayout")
			ButtonLayout.Parent = ScrollingFrame
			ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonLayout.Name = "ButtonLayout"

			for _, option in ipairs(options) do
				local Button = Instance.new("TextButton")
				Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
				Button.BackgroundTransparency = 1
				Button.Size = UDim2.new(1, 0, 0, 25)
				Button.Font = Enum.Font.SourceSansBold
				Button.Text = option
				Button.TextColor3 = Color3.new(1, 1, 1)
				Button.TextSize = 14
				Button.Parent = ScrollingFrame

				Button.MouseEnter:Connect(function()
					TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
				end)
				Button.MouseLeave:Connect(function()
					TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				end)
				Button.MouseButton1Click:Connect(function()
					callback(option)
				end)
			end

			local isOpen = false
			DropdownToggle.MouseButton1Click:Connect(function()
				local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				if not isOpen then
					TweenService:Create(DropdownToggle, tweenInfo, {Rotation = -360}):Play()
					DropdownToggle.Text = "<"
					TweenService:Create(DropdownMain, tweenInfo, {Size = UDim2.new(0, 153, 0, #options * 25)}):Play()
					TweenService:Create(ScrollingFrame, tweenInfo, {Size = UDim2.new(0, 153, 0, #options * 25)}):Play()
				else
					TweenService:Create(DropdownToggle, tweenInfo, {Rotation = 0}):Play()
					DropdownToggle.Text = ">"
					TweenService:Create(DropdownMain, tweenInfo, {Size = UDim2.new(0, 153, 0, 0)}):Play()
					TweenService:Create(ScrollingFrame, tweenInfo, {Size = UDim2.new(0, 153, 0, 0)}):Play()
				end
				isOpen = not isOpen
			end)
		end	
		
		function sectionObject:CreateToggle(text, callback)
			local toggled = false
			local ToggleHolder = Instance.new("Frame")
			ToggleHolder.Name = (text.."ToggleHolder")
			ToggleHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			ToggleHolder.Size = UDim2.new(0, 170, 0, 30)
			ToggleHolder.Parent = Section
			ToggleHolder.BorderSizePixel = 0
			
			local ToggleTitle = Instance.new("TextLabel")
			ToggleTitle.BackgroundTransparency = 1
			ToggleTitle.Font = Enum.Font.SourceSansBold
			ToggleTitle.Text = text
			ToggleTitle.BorderSizePixel = 0
			ToggleTitle.Position = UDim2.new(0.053, 0, 0, 0)
			ToggleTitle.Size = UDim2.new(0, 125, 0, 30)
			ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleTitle.TextSize = 16
			ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
			ToggleTitle.Parent = ToggleHolder
			ToggleTitle.Name = "ToggleTitle"
			
			local ToggleBackground = Instance.new("Frame")
			ToggleBackground.Size = UDim2.new(0, 32, 0, 16)
			ToggleBackground.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
			ToggleBackground.Parent = ToggleHolder
			ToggleBackground.BorderSizePixel = 0
			ToggleBackground.Position = UDim2.new(0.76, 0, 0.25, 0)
			ToggleBackground.Name = "ToggleBackground"
			
			local ToggleCorner = Instance.new("UICorner")
			ToggleCorner.Parent = ToggleBackground
			ToggleCorner.CornerRadius = UDim.new(0, 100)
			ToggleCorner.Name = "ToggleCorner"
			
			local ToggleButton = Instance.new("ImageButton")
			ToggleButton.Position = UDim2.new(0, 3, 0, 2)
			ToggleButton.Parent = ToggleBackground
			ToggleButton.Size = UDim2.new(0, 12, 0, 12)
			ToggleButton.BackgroundTransparency = 1
			ToggleButton.ImageColor3 = Color3.fromRGB(147, 147, 147)
			ToggleButton.Image = "http://www.roblox.com/asset/?id=3570695787"
			ToggleButton.Name = "ToggleButton"
			EnterLeaveButton(ToggleBackground, false, 0, 0.2)
			ToggleButton.MouseButton1Click:Connect(function()
				local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				toggled = not toggled
				if toggled then
					local posTween = TweenService:Create(ToggleButton, tweenInfo, {Position = UDim2.new(0, 17, 0, 2)})
					local colorTween = TweenService:Create(ToggleButton, tweenInfo, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
					posTween:Play()
					colorTween:Play()
				else
					local posTween = TweenService:Create(ToggleButton, tweenInfo, {Position = UDim2.new(0, 2, 0, 2)})
					local colorTween = TweenService:Create(ToggleButton, tweenInfo, {ImageColor3 = Color3.fromRGB(147, 147, 147)})
					posTween:Play()
					colorTween:Play()
				end

				if callback then callback(toggled) end
			end)
			ToggleBackground.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

					toggled = not toggled
					if toggled then
						local posTween = TweenService:Create(ToggleButton, tweenInfo, {Position = UDim2.new(0, 17, 0, 2)})
						local colorTween = TweenService:Create(ToggleButton, tweenInfo, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
						posTween:Play()
						colorTween:Play()
					else
						local posTween = TweenService:Create(ToggleButton, tweenInfo, {Position = UDim2.new(0, 2, 0, 2)})
						local colorTween = TweenService:Create(ToggleButton, tweenInfo, {ImageColor3 = Color3.fromRGB(147, 147, 147)})
						posTween:Play()
						colorTween:Play()
					end

					if callback then callback(toggled) end
				end
			end)

		end

		function sectionObject:CreateSlider(text, min, max, default, decimals, callback)
			local SliderHolder = Instance.new("Frame")
			SliderHolder.Name = text.."SliderHolder"
			SliderHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			SliderHolder.Size = UDim2.new(0, 170, 0, 40)
			SliderHolder.BorderSizePixel = 0
			SliderHolder.Parent = Section

			local SliderTitle = Instance.new("TextLabel")
			SliderTitle.Parent = SliderHolder
			SliderTitle.Text = text
			SliderTitle.Font = Enum.Font.SourceSansBold
			SliderTitle.Size = UDim2.new(0, 125, 0, 15)
			SliderTitle.Position = UDim2.new(0.053, 0,0.1, 0)
			SliderTitle.BackgroundTransparency = 1
			SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderTitle.TextSize = 16
			SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

			local SliderBackground = Instance.new("ImageLabel")
			SliderBackground.Name = "SliderBackground"
			SliderBackground.Parent = SliderHolder
			SliderBackground.BackgroundTransparency = 1
			SliderBackground.BorderSizePixel = 0
			SliderBackground.Position = UDim2.new(0.053, 0, 0.5, 0)
			SliderBackground.Size = UDim2.new(0, 153, 0, 5)
			SliderBackground.ImageColor3 = Color3.fromRGB(65, 65, 65)
			SliderBackground.Image = "http://www.roblox.com/asset/?id=3570695787"
			SliderBackground.ScaleType = Enum.ScaleType.Slice
			SliderBackground.SliceCenter = Rect.new(100, 100, 100, 100)
			SliderBackground.SliceScale = 0.02

			local Slider = Instance.new("ImageLabel")
			Slider.Parent = SliderBackground
			Slider.Name = "Slider"
			Slider.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BackgroundTransparency = 1
			Slider.Size = UDim2.new((default - min) / (max - min), 0, 1.15, 0)
			Slider.Position = UDim2.new(0, 0, 0, 0)
			Slider.Image = "http://www.roblox.com/asset/?id=3570695787"
			Slider.ScaleType = Enum.ScaleType.Slice
			Slider.SliceCenter = Rect.new(100, 100, 100, 100)
			Slider.SliceScale = 0.02

			local SliderValueHolder = Instance.new("ImageLabel")
			SliderValueHolder.Parent = SliderHolder
			SliderValueHolder.Position = UDim2.new(0.77, 0, 0, 0)
			SliderValueHolder.Size = UDim2.new(0, 30, 0, 15)
			SliderValueHolder.BackgroundTransparency = 1
			SliderValueHolder.ImageColor3 = Color3.fromRGB(65, 65, 65)
			SliderValueHolder.Image = "http://www.roblox.com/asset/?id=3570695787"
			SliderValueHolder.ImageTransparency = 0.5
			SliderValueHolder.ScaleType = Enum.ScaleType.Slice
			SliderValueHolder.SliceCenter = Rect.new(100, 100, 100, 100)
			SliderValueHolder.SliceScale = 0.02
			EnterLeaveButton(SliderValueHolder, false, 0, 0.7)

			local SliderValue = Instance.new("TextBox")
			SliderValue.Parent = SliderValueHolder
			SliderValue.Font = Enum.Font.SourceSansBold
			SliderValue.BackgroundTransparency = 1
			SliderValue.Size = UDim2.new(1, 0, 1, 0)
			SliderValue.TextSize = 14
			SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderValue.TextScaled = true
			SliderValue.Text = default

			task.spawn(function()
				while true do
					if not SliderValue:IsFocused() and tonumber(SliderValue.Text) == nil then
						SliderValue.Text = default
					end
					task.wait(0.1)
				end
			end)
			

			local function roundValue(val)
				return decimals and tonumber(string.format("%.2f", val)) or math.round(val)
			end

			local function updateValue(inputX)
				local relative = math.clamp((inputX - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
				local value = min + (max - min) * relative
				local displayValue = roundValue(value)

				local tween = TweenService:Create(Slider, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(relative, 0, 1.15, 0)
				})
				tween:Play()

				SliderValue.Text = tostring(displayValue)
				if callback then callback(displayValue) end
			end

			SliderBackground.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateValue(input.Position.X)
					local moveConn
					moveConn = game:GetService("UserInputService").InputChanged:Connect(function(move)
						if move.UserInputType == Enum.UserInputType.MouseMovement then
							updateValue(move.Position.X)
						end
					end)
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							if moveConn then moveConn:Disconnect() end
						end
					end)
				end
			end)
			SliderValue.FocusLost:Connect(function(enterPressed)
				local typed = tonumber(SliderValue.Text)
				if typed then
					local clamped = math.clamp(typed, min, max)
					local relative = (clamped - min) / (max - min)
					local displayValue = roundValue(clamped)

					local tween = TweenService:Create(Slider, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(relative, 0, 1.15, 0)
					})
					tween:Play()

					SliderValue.Text = tostring(displayValue)
					if callback then callback(displayValue) end
				else
					SliderValue.Text = default
				end
			end)

		end
		return sectionObject
	end
	Body.ChildAdded:Connect(function()
		print("Body Size Y: "..ListLayout.AbsoluteContentSize.Y)
		Body.Size = UDim2.new(0, 170, 0, ListLayout.AbsoluteContentSize.Y + 5)
	end)
	for _, child in ipairs(Body:GetChildren()) do
		if not string.find(child.Name, SectionStr) then
			Body.Size = UDim2.new(0, 170, 0, 35)
		end
	end
	return windowObject
end
return Library
