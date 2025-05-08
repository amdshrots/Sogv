-- Create a GUI for the Explorer
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ExplorerGui"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.5, 0)
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "Explorer"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Size = UDim2.new(1, 0, 0.1, 0)
title.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
title.Parent = frame

local treeView = Instance.new("ScrollingFrame")
treeView.Size = UDim2.new(1, 0, 0.9, 0)
treeView.Position = UDim2.new(0, 0, 0.1, 0)
treeView.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
treeView.CanvasSize = UDim2.new(1, 0, 1, 0)
treeView.Parent = frame

local function createTreeViewItem(parent, item, depth)
    local itemFrame = Instance.new("Frame")
    itemFrame.Size = UDim2.new(1, 0, 0, 30)
    itemFrame.BackgroundTransparency = 1
    itemFrame.Parent = parent

    local itemName = Instance.new("TextLabel")
    itemName.Text = string.rep("  ", depth) .. item.Name
    itemName.TextColor3 = Color3.new(1, 1, 1)
    itemName.Size = UDim2.new(1, 0, 1, 0)
    itemName.Parent = itemFrame

    if item:IsA("Folder") or item:IsA("Model") or item:IsA("DataModel") then
        local childrenFrame = Instance.new("Frame")
        childrenFrame.Size = UDim2.new(1, 0, 0, 0)
        childrenFrame.BackgroundTransparency = 1
        childrenFrame.Parent = itemFrame

        for _, child in ipairs(item:GetChildren()) do
            createTreeViewItem(childrenFrame, child, depth + 1)
        end
    end
end

local function populateTreeView(parent, root)
    for _, item in ipairs(root:GetChildren()) do
        createTreeViewItem(parent, item, 0)
    end
end

-- Populate the tree view with the game's hierarchy
populateTreeView(treeView, game)

-- Add a button to refresh the tree view
local refreshButton = Instance.new("TextButton")
refreshButton.Text = "Refresh"
refreshButton.TextColor3 = Color3.new(1, 1, 1)
refreshButton.Size = UDim2.new(0.1, 0, 0.1, 0)
refreshButton.Position = UDim2.new(0.9, 0, 0, 0)
refreshButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
refreshButton.Parent = frame

refreshButton.MouseButton1Click:Connect(function()
    treeView:ClearAllChildren()
    populateTreeView(treeView, game)
end)
