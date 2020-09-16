-- FOR USE IN BIZHAWK
-- Metal Gear Solid (USA) 1.0
-- Last updated: Sep 16, 2020

-- `/~ : Toggle Freecam controls

-- POSITION : WASD GT
-- A/D : Move X Axis
-- W/S : Move Z Axis
-- G/T : Move Y Axis

-- DISTANCE FROM CAMERA TARGET
-- H / Y
-- On Number Pad: 2 / 8

-- ROTATE/ORBIT CAMERA TARGET : ARROW KEYS
-- Left/Right : Orbit X Axis around camera target
--  Up / Down : Orbit Y Axis around camera target

-- FIELD OF VIEW
-- Z/C: Decrease/Increase FOV
--  X : Reset FOV

-- RENDER PLANE : OKL;
-- K/; : Skew left/right
-- O/L : Skew up/down
-- P : Reset to Normal

-- MISC
-- N : Toggle Dither
-- M : Toggle Freeze
-- Minus/Plus (on number row, above letter keys) : Decrease/Increase Camera Move Speed



-- Turns cam control on or off
camcontrol = false
freezelock = false
dithertoggle = true

-- Listen for inputs
local keyin = { }

-- Freecam move speed handler (default: 64)
camSpeed = 3

-- 90/20 gets the gui text on top of the game render
-- 8/8 keeps it out in the black border
guiTextX = 8
guiTextY = 8

-- Cam Speed Input
local camSpPos = {
	[1] = 1,
	[2] = 16,
	[3] = 64,
	[4] = 128,
	[5] = 256
}

local camSpRot = {
	[1] = 1,
	[2] = 4,
	[3] = 8,
	[4] = 16,
	[5] = 32
}

local camSpFOV = {
	[1] = 1,
	[2] = 2,
	[3] = 4,
	[4] = 8,
	[5] = 16
}

-- Lua timer durations to make precision keyins easier
counter = 0
guicounter = 0
rendcounter = 0
cQ = 15
cT = 20
cH = 30
cF = 60
cD = 120


----------------------
-- Memory positions --
----------------------

-- UI
-- 1 Byte
bUIDrawMap = 0x0AE17B
bUIDrawOrd = 0x0B416E


-- Pause Mode
-- 1 Byte
-- 00 Default / 02 Pause / 04 Freeze (used for item selection)
bFreeze = 0x0AE0A0

-- Enable/Disable Freecam Camera
-- 2 Byte
-- 00.00 Disable / 02.00 Enable
bCamLock = 0x0B9F68

-- Freecam Target Position
-- 2 Byte
bCamPosX = 0x0B9F58
bCamPosY = 0x0B9F5A
bCamPosZ = 0x0B9F5C

vCamPosX = 0
vCamPosY = 0
vCamPosZ = 0

-- Freecam Target Orbit/Rotation
-- 2 Byte
bCamRotX = 0x0B9F62
bCamRotY = 0x0B9F60

vCamRotX = 320
vCamRotY = 512

-- Freecam Distance from Target
-- 2 Byte
bCamDist = 0x0B9F6C

vCamDist = 384
dCamDist = 384

-- Freecam FOV
-- 2 Byte
bCamFOV = 0x0B9F70

vCamFOV = 320
dCamFOV = 320

-- Render Plane Skew
-- 2 Byte? Unsure
bRend1X = 0x0B41DC
bRend1Y = 0x0B41DE
bRend2X = 0x0B421C
bRend2Y = 0x0B421E

vRend1Xv = 160
vRend1Xr = 32928
vRend1Y = 3
vRend2Xv = 480
vRend2Xr = 33248
vRend2Y = 3

dRend1X = 0xA080
dRend2Y = 0x03
dRend2X = 0xE081
dRend1Y = 0x03

-- Dither
bDither1 = 0x0B41E1
bDither2 = 0x0B4221

function controlToggle()
	if keyin.Grave and counter == 0 then
		if not camcontrol then
			-- Read current cam position
			vCamPosX = memory.read_u16_le(bCamPosX)
			vCamPosY = memory.read_u16_le(bCamPosY)
			vCamPosZ = memory.read_u16_le(bCamPosZ)
			
			-- Read current cam rotation
			vCamRotX = memory.read_u16_le(bCamRotX)
			vCamRotY = memory.read_u16_le(bCamRotY)
			
			-- Read current cam distance
			vCamDist =  memory.read_u16_le(bCamDist)
			
			-- Read current cam FOV
			vCamFOV =  memory.read_u16_le(bCamFOV)
			
			guicounter = cF
			counter = cT
		else
			-- Return everything to normal
			memory.write_u8(bUIDrawOrd,0x10)
			memory.write_u8(bUIDrawMap,0x00)
			memory.write_u8(bFreeze,0x00)
			memory.write_u16_be(bCamLock,0x0000)
			memory.write_u16_le(bCamDist,dCamDist)
			memory.write_u16_le(bCamFOV,dCamFOV)
			
			memory.write_u16_be(bRend1X,dRend1X)
			memory.write_u8(bRend1Y,dRend1Y)
			memory.write_u16_be(bRend2X,dRend2X)
			memory.write_u8(bRend2Y,dRend2Y)
			
			memory.write_u8(bDither1,0x02)
			memory.write_u8(bDither2,0x02)
			
			dithertoggle = true
			
			vRend1Xv = 160
			vRend1Xr = 32928
			vRend1Y = 3
			vRend2Xv = 480
			vRend2Xr = 33248
			vRend2Y = 3
			
			guicounter = cF
			counter = cT
		end
		
		camcontrol = not camcontrol
	end
	
	-- counter countdown
	if counter > 0 then
		counter = counter - 1
	end
	
	-- rendcounter countdown
	if rendcounter > 0 then
		rendcounter = rendcounter - 1
	end
	
	-- Gui response
	if guicounter > 0 then
		if camcontrol then
			gui.text(guiTextX,guiTextY, "Cam control enabled")
		else
			gui.text(guiTextX,guiTextY, "Cam control disabled")
		end
		
		guicounter = guicounter - 1
	end
end

function camController()
	memory.write_u16_be(bCamLock,0x0200)
	
	
	-- Freeze Lock
	if keyin.M and counter == 0 then
		freezelock = not freezelock
		counter = cQ
	end
	
	if freezelock then
		memory.write_u8(bFreeze,0x04)
	else
		memory.write_u8(bFreeze,0x00)
	end
	
	
	-- Dither Toggle
	if keyin.N and counter == 0 then
		dithertoggle = not dithertoggle
		counter = cQ
	end
	
	if dithertoggle then
		memory.write_u8(bDither1,0x02)
		memory.write_u8(bDither2,0x02)
	else
		memory.write_u8(bDither1,0x00)
		memory.write_u8(bDither2,0x00)
	end
	
	
	-- Camera Speeds
	if camSpeed > 1 and counter == 0 then
		if keyin.Minus then
			camSpeed = camSpeed - 1
			counter = cT
		end
	end
	
	if camSpeed < 5 and counter == 0 then
		if keyin.Equals then
			camSpeed = camSpeed + 1
			counter = cT
		end
	end
	
	
	-- Simple Dolly
	if keyin.A then
		if vCamPosX > 0 then
			vCamPosX = vCamPosX - camSpPos[camSpeed]
		else
			vCamPosX = vCamPosX + 65536
		end
	end
	
	if keyin.D then
		if vCamPosX < 65535 then
			vCamPosX = vCamPosX + camSpPos[camSpeed]
		else
			vCamPosX = vCamPosX - 65536
		end
	end
	
	if keyin.W then
		if vCamPosZ > 0 then
			vCamPosZ = vCamPosZ - camSpPos[camSpeed]
		else
			vCamPosZ = vCamPosZ + 65536
		end
	end
	
	if keyin.S then
		if vCamPosZ < 65535 then
			vCamPosZ = vCamPosZ + camSpPos[camSpeed]
		else
			vCamPosZ = vCamPosZ - 65536
		end
	end
	
	if keyin.G then
		if vCamPosY > 0 then
			vCamPosY = vCamPosY - camSpPos[camSpeed]
		else
			vCamPosY = vCamPosY + 65536
		end
	end
	
	if keyin.T then
		if vCamPosY < 65535 then
			vCamPosY = vCamPosY + camSpPos[camSpeed]
		else
			vCamPosY = vCamPosY - 65536
		end
	end
	
	
	-- Simple Rotate
	if keyin.LeftArrow then
		if vCamRotX > 0 then
			vCamRotX = vCamRotX - camSpRot[camSpeed]
		else
			vCamRotX = vCamRotX + 65536
		end
	end
	
	if keyin.RightArrow then
		if vCamRotX < 65535 then
			vCamRotX = vCamRotX + camSpRot[camSpeed]
		else
			vCamRotX = vCamRotX - 65536
		end
	end
	
	if keyin.DownArrow then
		if vCamRotY > 0 then
			vCamRotY = vCamRotY - camSpRot[camSpeed]
		else
			vCamRotY = vCamRotY + 65536
		end
	end
	
	if keyin.UpArrow then
		if vCamRotY < 65535 then
			vCamRotY = vCamRotY + camSpRot[camSpeed]
		else
			vCamRotY = vCamRotY - 65536
		end
	end
	
	
	-- Distance from Focus
	if keyin.NumberPad8 or keyin.H then
		if vCamDist > 0 then
			vCamDist = vCamDist - camSpPos[camSpeed]
		else
			vCamDist = 0
		end
	end
	
	if keyin.NumberPad2 or keyin.Y then
		if vCamDist < 65535 then
			vCamDist = vCamDist + camSpPos[camSpeed]
		else
			vCamDist = 65536
		end
	end
	
	
	-- FOV
	if keyin.NumberPad4 or keyin.Z then
		if vCamFOV > 0 then
			vCamFOV = vCamFOV - camSpFOV[camSpeed]
		else
			vCamFOV = 0
		end
	end
	
	if keyin.NumberPad6 or keyin.C then
		if vCamFOV < 65535 then
			vCamFOV = vCamFOV + camSpFOV[camSpeed]
		else
			vCamFOV = 65536
		end
	end
	
	-- Reset FOV
	if keyin.NumberPad5 or keyin.X then
		vCamFOV = dCamFOV
	end
	
	
	-- Render Plane Skew
	if keyin.Semicolon and rendcounter == 0 then
		if vRend1Xv > 0 then
			vRend1Xv = vRend1Xv - 16
		else
			vRend1Xv = vRend1Xv + 2032
		end
		
		if vRend2Xv > -1024 then
			vRend2Xv = vRend2Xv - 16
		else
			vRend2Xv = vRend2Xv - 2032
		end
		
		rendcounter = cQ
	end
	
	if keyin.K and rendcounter == 0 then
		if vRend1Xv < 2031 then
			vRend1Xv = vRend1Xv + 16
		else
			vRend1Xv = vRend1Xv - 2032
		end
		
		if vRend2Xv < 1023 then
			vRend2Xv = vRend2Xv + 16
		else
			vRend2Xv = vRend2Xv - 2032
		end
		
		rendcounter = cQ
	end
	
	vRend1Xr = vRend1Xv + 32768
	vRend2Xr = vRend2Xv + 32768
	
	if keyin.L and rendcounter == 0 then
		if vRend1Y > 0 then
			vRend1Y = vRend1Y - 1
		else
			vRend1Y = vRend1Y + 63
		end
		
		vRend2Y = vRend1Y
		rendcounter = cQ
	end
	
	if keyin.O and rendcounter == 0 then
		if vRend1Y < 63 then
			vRend1Y = vRend1Y + 1
		else
			vRend1Y = vRend1Y - 63
		end
		
		vRend2Y = vRend1Y
		rendcounter = cQ
	end
	
	if keyin.P and rendcounter == 0 then
		vRend1Xv = 160
		vRend1Xr = 32928
		vRend1Y = 3
		vRend2Xv = 480
		vRend2Xr = 33248
		vRend2Y = 3
		
		rendcounter = cQ
	end
	
	-- Write all the things
	memory.write_u16_le(bCamPosX,vCamPosX)
	memory.write_u16_le(bCamPosY,vCamPosY)
	memory.write_u16_le(bCamPosZ,vCamPosZ)
	
	memory.write_u16_le(bCamRotX,vCamRotX)
	memory.write_u16_le(bCamRotY,vCamRotY)
	
	-- distance
	memory.write_u16_le(bCamDist,vCamDist)
	
	-- FOV
	memory.write_u16_le(bCamFOV,vCamFOV)
	
	-- Render plane
	memory.write_u16_le(bRend1X,vRend1Xr)
	memory.write_u8(bRend1Y,vRend1Y)
	memory.write_u16_le(bRend2X,vRend2Xr)
	memory.write_u8(bRend2Y,vRend2Y)
	
	-- something else!!
	memory.write_u8(0x0B9F78,0x02)
	
	-- disable map
	memory.write_u8(bUIDrawOrd,0x00)
	memory.write_u8(bUIDrawMap,0xFF)
	
end

while true do
	keyin=input.get()
	controlToggle()
	if camcontrol then
		camController()
	end
	
	--gui.text(8,24, "vRend1Xv: " and vRend1Xv)
	--gui.text(8,36, "vRend2Xv: " and vRend2Xv)
	
	--gui.text(8,48, "vRend1Xr: " and vRend1Xr)
	--gui.text(8,60, "vRend2Xr: " and vRend2Xr)
	
	emu.frameadvance()
end