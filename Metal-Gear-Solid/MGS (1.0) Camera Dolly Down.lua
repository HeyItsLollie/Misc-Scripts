-- This automatically moves the camera as soon
-- as the script is started, and will only stop
-- when the script is terminated, or freecam is
-- toggled off.

thebyte = 255
secbyte = 15
speed = 1

function reduceByte()
	if thebyte > (speed - 1) then
		thebyte = thebyte - speed
	else
		secbyte = secbyte - 1
		thebyte = 255
	end
	
	if secbyte == 1 then
		secbyte = 14
	end
	
	memory.write_u8(0x0B9F2A,thebyte)
	memory.write_u8(0x0B9F2B,secbyte)
	
	--gui.cleartext()
	--gui.text(8,8,thebyte)
	--gui.text(8,24,secbyte)
end

while true do
	reduceByte()
	emu.frameadvance()
end