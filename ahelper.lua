script_authors('jo_lac', 'Alexandr_Mansory', 'Radiant_Smith')
script_version('02.04.2022 #3')
-- ��������� ������ ������, �� ������������� ������������� ��, ��� ����� �� ���� ��� ��������������� �� ��������, ������������ ��� ������������� ������� �������. ������ ������� ������� �� ����� ��������������� �� ��� ��������. ������ �������� ������� � ��������, ����� �������� �������������� ������ �� ip. ����� ������� ��������������. �� �������� ���������. ����������� �� ���� ����� � ����.
require 'lib.moonloader'
require 'lib.sampfuncs'
local memory = require 'memory'
local Vector3D = require "vector3d"
local event = require 'lib.samp.events'
local vk = require 'lib.vkeys'
local cjson = require "cjson"
local encoding = require "encoding"
local effil = require "effil"
encoding.default = "cp1251"
u8 = encoding.UTF8
local nicks = {}
local phares = {'����', '����', '����', '����', '����', '����', '����', '����', '�����', 'mq', 'mQ', 'Mq', 'MQ'}
local notphares = {'�����', '�������', '������', '�������', '�����', '�����', '������', '�����', '�������', '������', '�������', '�����', '�����', '������', '�����', '�������', '������', '�������', '�����', '�����', '������'}
local timee, typerep, pip = 0, 0, false
local color1, color3, color4, color5, acolor1, acolor2, acolor3, acolor4, acolor5 = 0xffaa00, 0xf1f1ab, 0xf4be91, 0x0ffa00, 'ffaa00', '6699ff', 'f1f1ab', 'f4be91', '0ffa00'	-- color format: 0xHEX, acolor format: 'HEX'
local table1 = {}
local json = {msg1 = {true, false, {'/msg ��������� ������, � 17:00 ������ ������� 50-�� /donat ������.', '/msg � 21:30 ����� ����������� �������� � ��������� ������ - /info.'}}, msg2 = {true, false, {'/msg ��������� ������, � 19:00 ������ ����������� �� 50 �������� ������.', '/msg � 21:30 ����� ����������� �������� � ��������� ������ - /info.'}},	msg3 = {false, false, {'/msg ��������� ������, � 21:30 ����� ����������� �������� � ��������� ������ - /info.', '/msg ��� ����, ����� ��� ������, ����������� /mm > ������ ��������', '/msg ����� �������� ��������� �� ��� ������� ����� ��������� 50 /donat ������.'}}, msg4 = {false, false, {'/msg ��������� ������, ���� ���������, ��� �� ������ ������� ������ "�����������".', '/msg ��� �� ������ ������ �������� � ������ ��������� �� ��������������.'}}, msg5 = {false, false, {'/msg ��������� ������, � ����� � ������������ ���������� �� ������� ��������', '/msg ������� 50 (/donat) ������ ������������ �� 18:00.'}}, msgk = {true, false, '', '', '', {'/msg ������� � ������ (/INFO) �� , , !'}}, autorep = {true, false, true, false, true, false, true}, amute = true, cmd1 = {false, false, {}, {}}, cmd2 = {false, false, {}, {}}, cmd3 = {false, false, {}, {}}, spam = true, asms = {true}, privet = {'������.', '������'}, textsms = {' ������', ' q ', ' ��', ' ������', ' Q ', ' ��', ' ���', ' ���', ' ���', ' ���', ' � ', ' � ', ' ��', ' ��', ' privet', ' Privet'}, iznas = true, sptext = {'sp', 'Sp', 'sP', 'SP', '��', '��', '��', '��'}, notsptext = {'sps', 'Sps', 'SPS', '�������', '�������', '�������', '���', '���', '���', '�������', '�������', '������', 'transp'}, chat = false, nottextsms = {'%w+_%w+'}}
local stdcfg = {msg1 = {true, false, {'/msg ��������� ������, � 17:00 ������ ������� 50-�� /donat ������.', '/msg � 21:30 ����� ����������� �������� � ��������� ������ - /info.'}}, msg2 = {true, false, {'/msg ��������� ������, � 19:00 ������ ����������� �� 50 �������� ������.', '/msg � 21:30 ����� ����������� �������� � ��������� ������ - /info.'}},	msg3 = {false, false, {'/msg ��������� ������, � 21:30 ����� ����������� �������� � ��������� ������ - /info.', '/msg ��� ����, ����� ��� ������, ����������� /mm > ������ ��������', '/msg ����� �������� ��������� �� ��� ������� ����� ��������� 50 /donat ������.'}}, msg4 = {false, false, {'/msg ��������� ������, ���� ���������, ��� �� ������ ������� ������ "�����������".', '/msg ��� �� ������ ������ �������� � ������ ��������� �� ��������������.'}}, msg5 = {false, false, {'/msg ��������� ������, � ����� � ������������ ���������� �� ������� ��������', '/msg ������� 50 (/donat) ������ ������������ �� 18:00.'}}, msgk = {true, false, '', '', '', {'/msg ������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!'}}, autorep = {true, false, true, false, true, false, true}, amute = true, cmd1 = {false, false, {}, {}}, cmd2 = {false, false, {}, {}}, cmd3 = {false, false, {}, {}}, spam = true, asms = {true}, privet = {'������.', '������'}, textsms = {' ������', ' q ', ' ��', ' ������', ' Q ', ' ��', ' ���', ' ���', ' ���', ' ���', ' � ', ' � ', ' ��', ' ��', ' privet', ' Privet'}, iznas = true, sptext = {'sp', 'Sp', 'sP', 'SP', '��', '��', '��', '��'}, notsptext = {'sps', 'Sps', 'SPS', '�������', '�������', '�������', '���', '���', '���', '�������', '�������', '������', 'transp'}, chat = false, nottextsms = {'%w+_%w+'}}
if not doesDirectoryExist('moonloader\\config') then createDirectory('moonloader\\config') end
if not doesFileExist('moonloader\\config\\offhelper.json') then
	local f = io.open('moonloader\\config\\offhelper.json', 'w')
	f:write(encodeJson(table1))
	f:close()
end
local f = io.open('moonloader\\config\\offhelper.json', 'r')
local table1 = decodeJson(f:read("*a"))
f:close()
if not doesFileExist('moonloader\\config\\offhelper_nicks.json') then
	local a = io.open('moonloader\\config\\offhelper_nicks.json', 'w')
	a:write(encodeJson(nicks))
	a:close()
end
local a = io.open('moonloader\\config\\offhelper_nicks.json', 'r')
local nicks = decodeJson(a:read("*a"))
a:close()
if not doesFileExist('moonloader\\config\\ahelper.json') then
	local f = io.open('moonloader\\config\\ahelper.json', 'w')
	f:write(encodeJson(stdcfg))
	f:close()
end
local f = io.open('moonloader\\config\\ahelper.json', 'r')
local json = decodeJson(f:read("*a"))
f:close()
local keyToggle = vk.VK_XBUTTON2
local keyApply = vk.VK_LBUTTON
local LIP = {};
mouseCoordinates = false
local const = 1100
local quest = {{'����� ������ ����� �� ����', '����� ������ � ����� �� �������� �� 3/3', '����� ������, ���� �� ������ � ��� ����� �������� 3/3', '����� ������ �� ���� � ������', '����� ������ � �����, ���� ����� ����� ������������ ���� �������� �� �����', '����� ������ � �����, ���� ����� ����� �������� � ������������� �������', '����� ������ � �����, ���� ����� ����� ������������ fly �� �����', '����� ������ � �����, ���� ����� ����� ������������ ����� �� �����'}, {'����� ������ ����� �� ����', '����� ������ � ����� �� �������� �� 3/3', '����� ������, ���� �� ������ � ��� ����� �������� 3/3', '����� ������ �� ���� � ������', '����� ������ � �����, ���� ����� ����� ������������ ���� �� �������', '����� ������ � �����, ���� ����� ����� �������� � ������������� �������', '����� ������ � �����, ���� ����� ����� ������������ fly �� �������', '����� ������ � �����, ���� ����� ����� ������������ ����� �� �������', '����� ������ � ����� �� SK �� ����� �������', '����� ������ �� ��� �� ������� �� ����� ������'}, {'����� ������ ���. ��������� �� ����', '����� ������ �� ������� �������� �� �������� ������', '����� ������, ���� ��� ����������� ������� ���', '����� ������ �� ���� � ������', '����� ������ �� NonRP/������������ �������� ������', '����� ������ �� �������� ������ � NonRP ����� � �����������', '����� ������ �� ��, ��� �� ������� 2 ������ �� �����', '����� ������, ���� � ���� ���� ����� ����� �������'}, {'����� �� ��� � �������-���', '����� �������� �� ��', '����� �������� �� �������� � ������', '����� �������� �� ������������� �����', '����� �������� �� ����������� �������� �� ����������', '����� �������� �� �������� �������'}}
local answer = {{'������', '������ ������, �� ����� �� 2 ����� ���� ������ ������', '�������', '������, ����', '������', '������ ������� � �����/���� (��� �� ��), ����� 3/3', '������ ������ � �����/����, ����� 2/3', '������ ������ � �����/����, ����� 3/3'}, {'������', '������ ������, �� ����� �� 2 ������� ���� ������ ������', '�������', '������, ����', '������ �����/����, ����� 1/3', '������ ������� � �����/����, ����� 1/3', '������ ������ � �����/����, ����� 1/3', '������ ������ � �����/����, ����� 3/3', '������ �����/����, ����� 1/3', '������ �����/����, ����� 1/3'}, {'�������', '�������� ��������', '������', '������ � �����/����', '2 ��������', '�������', '������� 7-�� ������', '������ ���� �������'}, {'������ � ���������, ��� ��������� ��������� �� �� 5 ����', '�����/����, �������', '�������', '�������', '������, �� �� 5 ����', '������, �� �� 5 ����'}}
local prefix = 'AHelper: '
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local nick = sampGetPlayerNickname(idd)
	local a = false
	local acceptednicknames = {'Emmerald_Lacoste', 'Aodhfayonn_Sullivan', 'Orlando_BlackStar', 'Alexandr_Mansory', 'Joe_Biden', 'John_Sullivan', 'Tenshi_TuathaDe', 'Zahar_TuathaDe', 'Kio_Luv', 'Christopher_Young'}
	for i, v in ipairs(acceptednicknames) do
		if nick == v then
			a = true
			break
		end
	end
	if not a then
		sampAddChatMessage('AHelper: ��������� �������������� ������. ��� ������: {'..acolor1..'}215.', color3)
		sampAddChatMessage('AHelper: ������ ��� {'..acolor1..'}(vk.com/jo_lac){'..acolor3..'} �� ���� ������.', color3)
		sampTextdrawSetString(93, '0')
		sampTextdrawSetString(94, '215')
		close()
	else
		sampTextdrawSetString(93, '1')
		sampTextdrawSetString(94, '0')
	end
	initializeRender()
	sampRegisterChatCommand('checkupd', checkupd)
	sampRegisterChatCommand('offahelper', close)
	sampRegisterChatCommand('otbor', otbor)
	sampRegisterChatCommand('setotbor', setotbor)
	sampRegisterChatCommand('gohelp', helpwork)
	sampRegisterChatCommand('help', helplist)
	sampRegisterChatCommand('listhelp', helpcheck)
	sampRegisterChatCommand('addhelp', helpadd)
	sampRegisterChatCommand('delhelp', helpdel)
	sampRegisterChatCommand('pip', pipwork)
	sampRegisterChatCommand('up', fcwork)
	sampRegisterChatCommand('fcset', funcset)
	sampRegisterChatCommand("chip", chip)
	sampRegisterChatCommand('sendresponse',
		function(params)
			sampSendDialogResponse(sampGetCurrentDialogId(), 1, tonumber(params)+1, '')
		end
	)
	sampRegisterChatCommand('cmd1', floodc1)
	sampRegisterChatCommand('cmd2', floodc2)
	sampRegisterChatCommand('cmd3', floodc3)
	sampRegisterChatCommand('msg1', flood1)
	sampRegisterChatCommand('msg2', flood2)
	sampRegisterChatCommand('msg3', flood3)
	sampRegisterChatCommand('msg4', flood4)
	sampRegisterChatCommand('msg5', flood5)
	sampRegisterChatCommand('msgk', flood6)
	sampRegisterChatCommand('rec', rec)
	sampRegisterChatCommand('recnick', recnick)
	sampRegisterChatCommand('ahelper', info)
	if not doesFileExist("moonloader\\config\\FChecker.ini") then
	  local data =
	  {
		  font =
		  {
			  name = "Segoe UI",
			  size = 9,
			  flag = 5,
		  },
		  options =
		  {
			  coordX = 55,
			  coordY = 279,
			  turn = 1,
		  },
		  friends =
		  {
			"Emmerald_Lacoste",
			"John_Sullivan",
		  },
	  };
	  LIP.save('moonloader\\config\\FChecker.ini', data);
	end
	data = LIP.load('moonloader\\config\\FChecker.ini');
    for i = 1, #data.friends do
      if data.friends[i] ~= nil then data.friends[i] = string.upper(data.friends[i]) end
    end
    LIP.save('moonloader\\config\\FChecker.ini', data);
    sampRegisterChatCommand("fcturn", cmdTurn)
    sampRegisterChatCommand("fcreload", cmdReload)
    sampRegisterChatCommand("fcsize", cmdFontSize)
    sampRegisterChatCommand("fcfont", cmdFontName)
    sampRegisterChatCommand("fcflag", cmdFontFlag)
    sampRegisterChatCommand("fcadd", cmdFriendsAdd)
    sampRegisterChatCommand("fcdelete", cmdFriendsRemove)
    sampRegisterChatCommand("fcmove", cmdMouseCoords)
    font = renderCreateFont(data.font.name, data.font.size, data.font.flag);
    lua_thread.create(fchecker)
	lua_thread.create(dialog)
	local afk = false
	while true do
		wait(0)
		if testCheat('KK') then afk = not afk end
        if afk then
            memory.setuint8(7634870, 1, false)
            memory.setuint8(7635034, 1, false)
            memory.fill(7623723, 144, 8, false)
            memory.fill(5499528, 144, 6, false)
			sampTextdrawSetString(95, '1')
			sampTextdrawSetString(96, '1')
		else
            memory.setuint8(7634870, 0, false)
            memory.setuint8(7635034, 0, false)
            memory.hex2bin('0F 84 7B 01 00 00', 7623723, 8)
            memory.hex2bin('50 51 FF 15 00 83 85 00', 5499528, 6)
			sampTextdrawSetString(95, '1')
			sampTextdrawSetString(96, '0')
        end
		while isPauseMenuActive() do
			if cursorEnabled then
				showCursor(false)
			end
			wait(100)
		end
		if isKeyDown(keyToggle) then
			cursorEnabled = not cursorEnabled
			showCursor(cursorEnabled)
 			while isKeyDown(keyToggle) do wait(80) end
 		end
		if cursorEnabled then
			local mode = sampGetCursorMode()
			if mode == 0 then
				showCursor(true)
			end
			sx, sy = getCursorPos()
			local sw, sh = getScreenResolution()
			if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
				local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
				local camX, camY, camZ = getActiveCameraCoordinates()
				local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
				if result and colpoint.entity ~= 0 then
					local normal = colpoint.normal
					local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
					local zOffset = 300
					if normal[3] >= 0.5 then zOffset = 1 end
					local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3, true, true, false, true, false, false, false)
					if result then
						pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)
						local curX, curY, curZ = getCharCoordinates(playerPed)
						local dist = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
						local hoffs = renderGetFontDrawHeight(font)
						sy = sy - 2
						sx = sx - 2
						renderFontDrawText(font, string.format("%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)
						local tpIntoCar = nil
						if colpoint.entityType == 2 then
							local car = getVehiclePointerHandle(colpoint.entity)
							if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
								displayVehicleName(sx, sy - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
								local color = 0xAAFFFFFF
							end
						end
						createPointMarker(pos.x, pos.y, pos.z)
						if isKeyDown(keyApply) then
							teleportPlayer(pos.x, pos.y, pos.z)
							removePointMarker()
							while isKeyDown(keyApply) do wait(0) end
							showCursor(false)
						end
					end
				end
			end
		end
		wait(0)
		removePointMarker()
	end
end
function close()
	local script = thisScript()
	script:unload()
end
function setotbor(param)
	if #param ~= 0 then
		if param:find('^%d') then
			typ = tonumber(param:match('^(%d)'))
			sampAddChatMessage('AHelper: ���������� ��� ������: '..tostring(typ), color5)
		else
			sampAddChatMessage('AHelper: ��������� "/setotbor [id]", ��������� � id � /ahelper >> �����.', color1)
		end
	else
		sampAddChatMessage('AHelper: ��������� "/setotbor [id]", ��������� � id � /ahelper >> �����.', color1)
	end
end
function otbor()
	if typ ~= 0 then
		lua_thread.create(
		function()
			wait(const)
			sampSendChat('/m ������� ������:')
			wait(const)
			sampSendChat('/m ��� ������ ������ ���� ���������� ��� � ��� ��� � ������.')
			wait(const)
			sampSendChat('/m ������� � ����� �� ����� ����� 15 ������, ��������� - 10 ������.')
			wait(const)
			sampSendChat('/m ����� ��� ����� ��� ��� � ������� - �����. ��������� � ������ ����� � ������ - �����.')
			wait(const)
			sampSendChat('/m ��� ����� ���� ������ - �����. ����� ��� ������� - �����. �������� ����� - �����.')
			wait(const*10)
			while true do
				wait(0)
				if not sampIsChatInputActive() and not sampIsDialogActive() then
					for i, v in ipairs(quest[typ]) do
						sampAddChatMessage('AHelper: ����� - '..answer[typ][i], color3)
						sampSendChat('/m ��� '..v..'?')
						wait(const)
						waiter()
						while true do
							if not appl then wait(100) else
								appl = false
								break
							end
						end
					end
					typ = 0
					sampAddChatMessage('AHelper: ������� �����������. ���� ���, ������.', color3)
					break
				end
			end
		end)
	else
		sampAddChatMessage('AHelper: ������� ������� �����: "/setotbor [id]", ��������� � id � /ahelper >> �����.', color1)
	end
end
function waiter()
	while true do
		if isKeyJustPressed(vk.VK_B) then
			wait(0)
			appl = true
			break
		else
			wait(100)
		end
	end
end
function event.onShowDialog(dialogId, style, title, button1, button2, text)
	if aworked then
		if title:find('^%w+_%w+') and dialogId == 1932 then
			table1.nick[num] = title
			table1.accnum[num] = text:match('^����� ��������:%D+(%d+)')
			table1.today[num] = text:match('� ���� �������:%D+(%d+)')
			table1.yesterday[num] = text:match('� ���� �����:%D+(%d+)')
			setVirtualKeyDown(vk.VK_ESCAPE, true)
			aworked = false
		end
	end
end
function helplist()
	if #nicks ~= 0 then
		if #table.nicks ~= 0 then
			local dialogtext = '���\t� ��������\t������ �������\t������ �����\t��� �������\n'
			for i = 1, #table1.nick do
				dialogtext = dialogtext..table1.nick[i]..'\t'..table1.accnum[i]..'\t'..table1.today[i]..'\t'..table1.yesterday[i]..'\n'
			end
			sampShowDialog(1000, 'offstats helper', dialogtext, '�������', '', 5)
		else
			sampAddChatMessage('AHelper: ������� ������� ��������! /gohelp', color5)
		end
	else
		sampAddChatMessage('AHelper: ������� ������ ����! /addhelp', color5)
	end
end
function helpcheck()
	if #table.nick ~= 0 then
		sampAddChatMessage('������ ���������, ��� ���� ���������:', color5)
		for i, v in ipairs(nicks) do
			sampAddChatMessage(v, color5)
		end
	else
		sampAddChatMessage('AHelper: ������� ������ ����! /addhelp', color5)
	end
end
function helpdelall()
	for i, v in ipairs(nicks) do
		nicks[i] = nil
		sampAddChatMessage('AHelper: ��� ���� ���� �������.', color5)
	end
end
function helpdel(param)
	if param:find('^%w+_%w+') then
		local a = false
		for i, v in ipairs(nicks) do
			if param == v then
				nicks[i] = nil
				save2()
				sampAddChatMessage('AHelper: ��� '..param..' �����.', color5)
				a = true
			end
		end
		if not a then
			sampAddChatMessage('AHelper: ������ ���� ��� ���, ���� �� �� ��������� � ������.', color5)
		end
	else
		sampAddChatMessage('AHelper: ��������� "/delhelp [Nick_Name]"', color5)
	end
end
function helpadd(param)
	if param:find('^%w+_%w+') then
		nicks[#nicks+1] = param
		save2()
		sampAddChatMessage('AHelper: ��� '..param..' ��������.', color5)
	else
		sampAddChatMessage('AHelper: ��������� "/addhelp [Nick_Name]"', color5)
	end
end
function helpwork()
	if #nicks ~= 0 then
		lua_thread.create(
		function()
			for i, v in ipairs(nicks) do
				wait(1000)
				num = i
				aworked = true
				sampAddChatMessage('a')
				sampSendChat('/offstats '..v)
				while true do
					if not aworked then break end
					wait(100)
				end
				setVirtualKeyDown(vk.VK_ESCAPE, false)
			end
			local dialogtext = '���\t� ��������\t������ �������\t������ �����\t��� �������\n'
			helplist()
			save1()
		end)
	else
		sampAddChatMessage('AHelper: ������� ������ ����! /addhelp', color5)
	end
end
function report(nick, id, time, param)
	if json.autorep[1] or json.autorep[3] or json.autorep[5] then
		while true do
			if typerep ~= 0 then
				if os.time() >= time then
					typerep = 0
					sampAddChatMessage('AHelper: ����� �����������, ������ ������� �������������.', color5)
					break
				elseif isKeyJustPressed(vk.VK_X) or isKeyDown(vk.VK_X) then
					if not sampIsChatInputActive() and not sampIsDialogActive() then
						if typerep == 1 then
							sampSendChat("/pm " ..id.. " ������ �������� ���, ��������.")
							wait(1250)
							sampSendChat("/sp " ..id)
							wait(0)
							sampAddChatMessage("AHelper: ���������.", color5)
						elseif typerep == 2 then
							sampSendChat("/pm "..id.." ������ ����� ��� ���������, ��������.")
							wait(1250)
							sampSendChat("/veh "..id.." "..param.." 1 1")
							wait(0)
							sampAddChatMessage("AHelper: ���������.", color5)
						elseif typerep == 3 then
							sampSendChat("/pm "..id.." ������ ������������ ���, ��������.")
							wait(1250)
							sampSendChat("/gothere "..id.." "..param)
							wait(0)
							sampAddChatMessage("AHelper: ���������.", color5)
						end
						typerep = 0
						sampTextdrawSetString(93, '1')
						sampTextdrawSetString(94, '0')
						break
					end
					if isKeyJustPressed(vk.VK_Z) or isKeyDown(vk.VK_Z) then
						typerep = 0
						sampAddChatMessage("AHelper: ������ �������.", color5)
						sampTextdrawSetString(93, '1')
						sampTextdrawSetString(94, '0')
						break
					end
					wait(0)
				end
			else
				break
			end
		end
	end
end
function fcwork()
	local aa = 0
	if sampIsDialogActive() then sampCloseCurrentDialogWithButton(0) end
	if typ ~= nil and goal ~= nil then
		sampSendChat('/fcoins')
		lua_thread.create(
		function()
			while not sampIsDialogActive() do wait(50) end
			sampSendDialogResponse(26353, 2, 1, '')
			while true do
				if not fcworked then break end
				sampSendDialogResponse(26354, 2, tonumber(typ)-1, '')
				aa = aa + 1
				if tonumber(goal) == aa then
					fcworked = false
					aa = 0
					typ, goal = ''
					sampAddChatMessage('���������. ������ ��� ��� ����� /fcset.', color5)
					wait(500)
					sampCloseCurrentDialogWithButton(0)
				end
				wait(150)
			end
		end
		)
	else
		sampAddChatMessage('������� ����� /fcset.', color5)
	end
end
function funcset(param)
	if #param ~= 0 then
		if param:find('^.+ .+') then
			typ, goal = param:match('^(.+) (.+)')
			if tonumber(typ) > 0 and tonumber(typ) < 4 then
				sampAddChatMessage('�����: '..typ..', ����������: '..goal..'. ������ ����� /up.', color5)
				fcworked = true
			else
				sampAddChatMessage('����� ���������� �����. ������� 1 � �������� 3.', color5)
			end
		else
			sampAddChatMessage('�������������: /fcset [����� ������ /fcoins > 2] [���������� ���������]', color5)
		end
	else
		sampAddChatMessage('�������������: /fcset [����� ������ /fcoins > 2] [���������� ���������]', color5)
	end
end
function smsfunc(revtext)
	wait(1000)
	local rid = revtext:match('^%](%d+)%[%w+_%w+ :����������� | .+')
	sampSendChat('/sms '..rid:reverse()..' '..json.privet[math.random(1, #json.privet)])
end
function pipwork(param)
	local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	if #param ~= 0 then
		if sampIsPlayerConnected(tostring(param)) or param == id then
			pip = true
			sampSendChat('/getip '..param)
		else
			sampAddChatMessage('AHelper: ������ ������ ��� �� �������.', color5)
		end
	else
		sampAddChatMessage('AHelper: ��������� "/pip [id]"', color5)
	end
end
event.onApplyPlayerAnimation = function(playerId, animLib, animName, frameDelta, loop, lockX, lockY, freeze, time)	-- (c) Radiant_Smith
	if animLib == 'BIKES' and animName == 'BIKES_BACK' then
		if playerId == izid then
			sampSendChat('/iznas '..tostring(izid))
		end
	end
end
function checkupd()
	autoupdate('https://raw.githubusercontent.com/Who-Who/AHelper-ATRP/main/currentver')
end
function event.onServerMessage(color, text)
	--[[AUTOUPDATE-WAITER]]if text:find('^�� ����� ��� .+') then checkupd() end
	--[[A-AREP]]if text == '[��������] ��� 5 ������������� �����!!! [/arep]' and afloodwork then
		local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
		local nick = sampGetPlayerNickname(idd)
		if nick == 'Alexandr_Mansory' then
			afloodwork = false
			lua_thread.create(
			function()
				wait(0)
				sampSendChat('/a /arep /arep /arep')
				wait(1000)
				sampSendChat('/a /arep /arep /arep')
				wait(1000)
				sampSendChat('/a /arep /arep /arep')
				wait(1000)
				sampSendChat('/a /arep /arep /arep')
				wait(1000)
				sampSendChat('/a /arep /arep /arep')
				wait(600000)
				afloodwork = true
			end
		)
		end
	end
	--[[PIP]]if text:find('^��� %[%w+_%w+%]  R%-IP %[%d+.%d+.%d+.%d+%]  IP %[%d+.%d+.%d+.%d+%]') then
		if pip then
			local ip = text:match('^��� %[%w+_%w+%]  R%-IP %[%d+.%d+.%d+.%d+%]  IP %[(%d+.%d+.%d+.%d+)%]')
			pip = false
			lua_thread.create(
				function ()
					wait(1100)
					sampSendChat('/pgetip '..ip)
				end
			)
			return false
		end
	end
	--[[FCUP]]if text == '�� ������� ��������� {FFCC00}���������� {3399FF}��� ��������' or text == '�� ������� ��������� {FFCC00}�������������� {3399FF}��� ��������' or text == '�� ������� ��������� {FFCC00}������ {3399FF}��� ��������' then
		return false
	elseif text == '� ��� ������������ F-Coins' then
		fcworked = false
		typ, goal = nil, nil
		sampAddChatMessage('�� �����������.', color5)
		return false
	end
	--[[ANTIIZNAS]]if json.iznas then
		local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
		local nick = sampGetPlayerNickname(idd)
		if text:match("^%w+_%w+ ����������� (%w+_%w+)") == nick then
			for i=0, 200 do
				if sampIsPlayerConnected(i) then
					if sampGetPlayerNickname(i) == text:match("^(%w+_%w+) ����������� %w+_%w+") then
						izid = i
						break
					end
				end
			end
		end
	end
	--[[SMS]]if json.asms[1] then
		local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
		local nick = sampGetPlayerNickname(idd)
		for i, v in ipairs(json.textsms) do
			if text:find('^SMS:'..v..'.+%| �����������: %w+_%w+%[%d+%]') then
				local notsms = false
				for i, v in ipairs(json.nottextsms) do if text:find('^SMS:'..v..'.+%| �����������: %w+_%w+') or text:find('^SMS:.+'..v..' %| �����������: %w+_%w+') or text:find('^SMS:.+'..v..'.+%| �����������: %w+_%w+') then notsms = true break end end
				if not notsms then
					local revtext = text:reverse()
					if revtext:find('^%]%d+%[%w+_%w+ :����������� | .+') then
						local revid = tostring(revtext:match('^%](%d+)%[%w+_%w+ :����������� | .+'))
						if revid:reverse() ~= idd then
							lua_thread.create(smsfunc, revtext)
						end
					end
				end
				break
			end
		end
	end
	--[[MUTE]]if json.amute then
		if text:find('^%[����%-�������%] %w+_%w+%[%d+%]: .*') then
			local nnick, iid, mmessage = text:match('^%[����%-�������%] (%w+_%w+)%[(%d+)%]: (.*)')
			for i, v in pairs(phares) do
				if mmessage:find(v) then
					local antimute = false
					for ii, vv in pairs(notphares) do
						if mmessage:find(vv) then antimute = true break end
					end
					if not antimute then
						local time = os.time()+5
						sampAddChatMessage('AHelper: ������ ��� ������ '..nnick..'['..iid..'] �� ���������� ������? ����� M ��� �������������.', color4)
						lua_thread.create(bind, iid, time)
					end
					break
				end
			end
		end
	end
	--[[REPORT]]if text:find("^%w+_%w+%[%d+%] : {FFCD00}.+") then
		if json.autorep[1] or json.autorep[3] or json.autorep[5] then
			atext = text:match("^%w+_%w+%[%d+%] : {FFCD00}(.+)")
			local worked = false
			if json.autorep[1] then
				local ban = false
				for i, v in ipairs(json.sptext) do
					if atext:find(v) then
						for c, b in ipairs(json.notsptext) do if atext:find(b) then ban = true end end
						if not ban then
							nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
							local timee = os.time() + 10
							typerep = 1
							worked = true
							sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
							sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
							lua_thread.create(report, nick, id, timee, '')
							sampTextdrawSetString(94, id)
							if json.autorep[2] then return false end
						end
						break
					end
				end
			end
			if not worked then
				if atext:find('���') or atext:find('nrg') or atext:find('���������') or atext:find('������') or atext:find('������') or atext:find('car') or atext:find('���') or atext:find('NRG') or atext:find('CAR') or atext:find('��������') or atext:find('infernus') or atext:find('�����') or atext:find('elegy') or atext:find('������') or atext:find('sultan') then
					if json.autorep[3] and not worked then
						if atext:find('���') or atext:find('nrg') or atext:find('���������') or atext:find('������') or atext:find('������') or atext:find('car') or atext:find('���') or atext:find('NRG') or atext:find('CAR') or atext:find('��������') or atext:find('infernus') or atext:find('�����') or atext:find('elegy') or atext:find('������') or atext:find('sultan') then
							worked = true
							if atext:find('���') or atext:find('nrg') or atext:find('���������') or atext:find('������') or atext:find('������') or atext:find('car') or atext:find('���') or atext:find('NRG') or atext:find('CAR') then veh = '522' elseif atext:find('��������') or atext:find('infernus') then veh = '411' elseif atext:find('�����') or atext:find('elegy') then veh = '562' elseif atext:find('������') or atext:find('sultan') then veh = '560' end
							nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
							local timee = os.time() + 10
							typerep = 2
							sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
							sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
							lua_thread.create(report, nick, id, timee, veh)
							sampTextdrawSetString(94, id)
						end
					end
				elseif atext:find('%d+ ���') or atext:find('��� %d+') or atext:find('car %d+') or atext:find('%d+ car') or atext:find('������ %d+') or atext:find('%d+ ������') then
					if atext:find('%d+ ���') then local veh = atext:match('(%d+) ���') elseif atext:find('��� %d+') then local veh = atext:match('��� (%d+)') elseif atext:find('%d+ car') then local veh = atext:match('(%d+) car') elseif atext:find('car %d+') then local veh = atext:match('car (%d+)') elseif atext:find('������ %d+') then local veh = atext:match('������ (%d+)') elseif atext:find('������ %d+') then local veh = atext:match('������ (%d+)') elseif atext:find('%d+ �����') then local veh = atext:match('(%d+) �����') end
					nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
					local timee = os.time() + 10
					typerep = 2
					sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
					sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
					lua_thread.create(report, nick, id, timee, veh)
					sampTextdrawSetString(94, id)
					if json.autorep[4] then return false end
				elseif atext:find('� %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('� (%d+)')
						local timee = os.time() + 10
						typerep = 3
						sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
						sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
						lua_thread.create(report, nick, id, timee, id2)
						sampTextdrawSetString(94, id)
						if json.autorep[6] then return false end
					end
				elseif atext:find('� id %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('� id (%d+)')
						local timee = os.time() + 10
						typerep = 3
						sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
						sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
						lua_thread.create(report, nick, id, timee, id2)
						sampTextdrawSetString(94, id)
						if json.autorep[6] then return false end
					end
				elseif atext:find('k %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('k (%d+)')
						local timee = os.time() + 10
						typerep = 3
						sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
						sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
						lua_thread.create(report, nick, id, timee, id2)
						sampTextdrawSetString(94, id)
						if json.autorep[6] then return false end
					end
				elseif atext:find('k id %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('k id (%d+)')
						local timee = os.time() + 10
						typerep = 3
						sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
						sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
						lua_thread.create(report, nick, id, timee, id2)
						sampTextdrawSetString(94, id)
						if json.autorep[6] then return false end
					end
				elseif atext:find('� �� %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('� �� (%d+)')
						local timee = os.time() + 10
						typerep = 3
						sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
						sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
						lua_thread.create(report, nick, id, timee, id2)
						sampTextdrawSetString(94, id)
						if json.autorep[6] then return false end
					end
				elseif atext:find('gothere %d+ %d+') and not worked then
					if json.autorep[5] then
						worked = true
						nick, id = text:match("^(%w+_%w+)%[(%d+)%] : .+")
						local id2 = atext:match('gothere %d+ (%d+)')
						local id3 = atext:match('gothere (%d+) %d+')
						local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
						if id3 == idd then
							timee = os.time() + 10
							typerep = 3
							sampAddChatMessage('AHelper: �������� �� ������ �� {AAFF55} ' .. nick .. '{'..acolor1..'}[{AAFF55}' .. id .. '{'..acolor1..'}]?', color1)
							sampAddChatMessage('�����: {AAFF55}'..atext..'{'..acolor1..'}? {AAFF55} ����� X.', color5)
							lua_thread.create(report, nick, id, timee, id2)
							sampTextdrawSetString(94, id)
							if json.autorep[6] then return false end
						end
					end
				end
			end
		elseif typerep ~= 0 then typerep = 0 end
	end
	if text:find('^������������� %w+_%w+%[%d+%] ��� %w+_%w+%[%d+%]: .+') then
		if typerep ~= 0 then
			if json.autorep[7] then
				local res, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
				if text:match('^������������� %w+_%w+%[%d+%] ��� %w+_%w+%[(%d+)%]: .+') == id and text:match('^������������� %w+_%w+%[(%d+)%] ��� %w+_%w+%[%d+%]: .+') ~= tostring(idd) then
					typerep = 0
					sampAddChatMessage('AHelper: �� ������ ��� ������� ������ �������������.', color1)
					sampTextdrawSetString(94, '0')
				end
			end
		end
	end
	--[[SPAM]]if json.spam then
		-- info:
		if text == '��������! �� ���������� ������� ������ ��� �� ����� �� �������� ��� �� ����� �� �������� �������' then return false elseif text == '������ ������� �������, �����, ������� ������ � ������ ������ ����� ����: {33cc00}attractive-rp.ru/#donat' then return false elseif text == 'Attractive RP | {FF9A30}���������� � ������� / ����������: {fb6400}/info' then return false elseif text == 'Attractive RP | {FF9A30}�� ������ ���������� ���������������� ����� �� ����� ����� �� 25 ������ {fb6400}/info' then return false elseif text == 'Attractive RP | {FF9A30}���������� ���� ������� �� 3 �������� �����. ���������: {fb6400}vk.com/attractive_samp' then return false elseif text == '�� ������� ��������� ����� {00CC00}��4 �����{FFFFFF}. ��������� ���� ����� �� �����: {00CC00}attractive-rp.ru' then return false elseif text == 'Attractive RP | {FF9A30}���� �� �� �������� ��� ������ � ���������, �� �������� ��� {fb6400}IP: 176.32.36.95:7777' then return false elseif text == 'Attractive RP | {FF9A30}�� ������� ������������ �����, ������� � ������� �������, ����� �������� ����� {fb6400}/fcoins' then return false elseif text == '[��������� �����]' then return false elseif text:find('^���� ������ �� ������ ������ ���������� {99CC00}%(%d+.%d+ F-Coins%)') then return false elseif text == 'Attractive RP | {FF9A30}���������� ������� �� ����� {fb6400}��4 ����� {FF9A30}����� ����� �� 25 ������ {fb6400}/info' then return false
		-- san news:
		elseif text == '  ���������� ��������� ��������� SAN News' then return false elseif text == 'SAN | ����� ���������� �� ����������� ����� � �������. GPS 1 - 6 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ���������� �������� �� ������� ������, �� ����������� �����! GPS 1 - 6 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | �������������� Performance Tuning �� ���� ���������. GPS 1 - 8 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ������ ���������! ��� ������ �������������� �����������! GPS 1 - 9 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ���������� ����������� ������� � ������������ ���������� �����! GPS 1 - 10 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ������� � ������ �� ������� ����! GPS 4 - 4 - 7 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | �������� ���� � ���� �����, ���� � ������� ������ � �������! GPS 3 - 5 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ������ ����������? ����� ���������� ��� � ������� � ��������! GPS 3 - 5 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ��������� �� �����, ������� �� �����! GPS 5 - 5 | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | San News ��� ����� ����������! | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ������ �������� � �����������? ���������� ������ ��������� (( /vacancy )) | �������� SAN News (���. 11888)' then return false elseif text == 'SAN | ������ �������� � �����������? ���������� ������ �������� (( /vacancy )) | �������� SAN News (���. 11888)' then return false elseif text:find('^SAN | ����� ".+" ���� ����� �����! ��� �� ����� | �������� %w+_%w+%[%d+%] %(���. %d+%)') then return false elseif text:find('^SAN | {80FF00}� 15:50 ������ ����� � "%w+". ��� �� �� ���������� {FFCD00}| �������� %w+_%w+%[%d+%] %(���. %d+%)') then return false
		-- ace will:
		elseif text == '������������� Ace_Will: ��������� ������. ���������� � ���, ��� ������� ������ ������� ������ ��� ����.' then return false elseif text == '������������� Ace_Will: ��������� ��� ��������, ��� ����������, ������ ������� ������� � ������ �������.' then return false elseif text == '������������� Ace_Will: ������� ����� ������ �������� ������ ���� � 17:00 �� ����������� �������.' then return false elseif text == '������������� Ace_Will: �������� ���������� ������ ��� �����������. ��� ���������� ������� ���������� � �������!' then return false elseif text == '������������� Ace_Will: ��� ��� ������� ������, ��� ����� �������� ���� � ������ ��� �������: clck.ru/dWiFs' then return false end
	end
	if text:find("^�� ���������� ��������� ������� | �������� %d+ ��.") then sampSendClickTextdraw(id1) return false elseif text:find("^�� ���������� ���������� ������� | �������� %d+ ��.") then sampSendClickTextdraw(id2) return false elseif text:find("^�� ���������� ������� ������� | �������� %d+ ��.") then sampSendClickTextdraw(id3) return false end
end
function event.onTogglePlayerControllable(controllable)
	if not controllable then return false end
end
function event.onShowTextDraw(textdrawId, textdraw)
	if textdraw.text == 'Gift#1' then id1 = tonumber(textdrawId) elseif textdraw.text == 'Gift#2' then id2 = tonumber(textdrawId) elseif textdraw.text == 'Gift#3' then id3 = tonumber(textdrawId) end
end
function work()
	json.autorep[1] = not json.autorep[1]
	if json.autorep[1] then
		sampAddChatMessage('AHelper: ������� ����� �� ������ ������ �������.', color1)
	elseif json.autorep[1] == false then
		sampAddChatMessage('AHelper: ������� ����� �� ������ ������ ��������.', color1)
	end
end
function work2()
	json.autorep[2] = not json.autorep[2]
	if json.autorep[2] then
		sampAddChatMessage('AHelper: �������� ��������� ������� ��������.', color1)
	elseif json.autorep[2] == false then
		sampAddChatMessage('AHelper: �������� ��������� ������� ���������.', color1)
	end
end
function rec(param)
	if #param == 0 then
		lua_thread.create(function()
			local ip, port = sampGetCurrentServerAddress()
			sampSetGamestate(4)
			wait(0)
			sampConnectToServer(ip, port)
		end)
	else
		if tonumber(param) == nil then sampAddChatMessage('[������]: {ff9900}������� ����� � ��������!', 0xFF0000)
		else
			local sec = tonumber(param)
			lua_thread.create(function()
				local ip, port = sampGetCurrentServerAddress()
				wait(param*1000)
				sampSetGamestate(4)
				sampConnectToServer(ip, port)
			end)
		end
	end
end
function recnick(param)
	if #param == 0 then
		sampAddChatMessage('[������]: {ff9900}������� ��� ��� ���������������!', 0xFF0000)
	else
		lua_thread.create(function()
			local ip, port = sampGetCurrentServerAddress()
			sampSetGamestate(4)
			sampSetLocalPlayerName(param)
			wait(0)
			sampConnectToServer(ip, port)
		end)
	end
end
function info()
	if json.spam then
		if json.chat then
			if json.asms[1] then
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}��������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}���\n{'..acolor1..'}���������������\t{'..acolor4..'}��������\n{'..acolor3..'}�����', '�������', '�������', 4)
			else
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}��������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}���\n{'..acolor1..'}���������������\t{'..acolor4..'}���������\n{'..acolor3..'}�����', '�������', '�������', 4)
			end
		else
			if json.asms[1] then
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}��������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}������\n{'..acolor1..'}���������������\t{'..acolor4..'}��������\n{'..acolor3..'}�����', '�������', '�������', 4)
			else
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}��������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}������\n{'..acolor1..'}���������������\t{'..acolor4..'}���������\n{'..acolor3..'}�����', '�������', '�������', 4)
			end
		end
	else
		if json.chat then
			if json.asms[1] then
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}���������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}���\n{'..acolor1..'}���������������\t{'..acolor4..'}��������\n{'..acolor3..'}�����', '�������', '�������', 4)
			else
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}���������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}���\n{'..acolor1..'}���������������\t{'..acolor4..'}���������\n{'..acolor3..'}�����', '�������', '�������', 4)
			end
		else
			if json.asms[1] then
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}���������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}������\n{'..acolor1..'}���������������\t{'..acolor4..'}��������\n{'..acolor3..'}�����', '�������', '�������', 4)
			else
				sampShowDialog(669, 'AHelper by jo_lac', '{'..acolor3..'}/ahelper\t{'..acolor4..'}������� �������\n{'..acolor4..'}/msgk\n{'..acolor2..'}/msg1\n{'..acolor2..'}/msg2\n{'..acolor2..'}/msg3\n{'..acolor2..'}/msg4\n{'..acolor2..'}/msg5\n{'..acolor2..'}/cmd1\n{'..acolor2..'}/cmd2\n{'..acolor2..'}/cmd3\n{'..acolor4..'}������� ������ ����\n{'..acolor4..'}������� ����� �� ������\n{'..acolor4..'}������� ��������� �����\n{'..acolor2..'}FChecker\n{'..acolor2..'}chip\n{'..acolor4..'}�������� �����\t{'..acolor4..'}���������\n{'..acolor1..'}������� ��������\n{'..acolor1..'}����-�������������\n{'..acolor1..'}����������� ����������\t{'..acolor4..'}������\n{'..acolor1..'}���������������\t{'..acolor4..'}���������\n{'..acolor3..'}�����', '�������', '�������', 4)
			end
		end
	end
end
function dialog()
	while true do
		wait(0)
		local result, button, list, _ = sampHasDialogRespond(669)
		if result then if button == 1 then
			if list == 0 then
				sampShowDialog(670, 'AHelper', '{'..acolor2..'}/ahelper\n{'..acolor3..'}������� ��������� ������ � ����������� � ��������.\n{'..acolor3..'}����� �� ������ ���� ��������?\n{ff0000}�� �� ���� ������� ������� ������!', '�������', '', 0)
			elseif list == 1 then
				sampShowDialog(676, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msgk\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msgk[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msgk[2])..'\n{'..acolor4..'}��������� ��������', '�����', '�������', 4)
			elseif list == 2 then
				sampShowDialog(671, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msg1\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg1[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg1[2]), '�����', '�������', 4)
			elseif list == 3 then
				sampShowDialog(672, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msg2\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg2[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg2[2]), '�����', '�������', 4)
			elseif list == 4 then
				sampShowDialog(673, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msg3\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg3[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg3[2]), '�����', '�������', 4)
			elseif list == 5 then
				sampShowDialog(674, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msg4\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg4[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg4[2]), '�����', '�������', 4)
			elseif list == 6 then
				sampShowDialog(675, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msg5\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg5[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg5[2]), '�����', '�������', 4)
			elseif list == 7 then
				if #json['cmd1'][4] < #json['cmd1'][3] then kd = true else kd = false end
				sampShowDialog(801, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/cmd1\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.cmd1[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.cmd1[2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json.cmd1[3])..' ���.', '�����', '�������', 4)
			elseif list == 8 then
				if #json['cmd2'][4] < #json['cmd2'][3] then kd = true else kd = false end
				sampShowDialog(802, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/cmd2\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.cmd2[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.cmd2[2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json.cmd2[3])..' ���.', '�����', '�������', 4)
			elseif list == 9 then
				if #json['cmd3'][4] < #json['cmd3'][3] then kd = true else kd = false end
				sampShowDialog(803, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/cmd3\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.cmd3[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.cmd3[2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json.cmd3[3])..' ���.', '�����', '�������', 4)
			elseif list == 10 then
				if json.amute then
					sampShowDialog(677, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}������� ������ ����\n{'..acolor2..'}���������\t{'..acolor2..'}��������', '�����', '�������', 4)
				elseif json.amute == false then
					sampShowDialog(677, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}������� ������ ����\n{'..acolor2..'}���������\t{'..acolor2..'}���������', '�����', '�������', 4)
				end
			elseif list == 11 then
				list11()
			elseif list == 12 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}������� ��������� �����\n{'..acolor2..'}���� �� �������� � ��� ���������, ���������� "@id", ��� id - id ������ �� �������,\n{'..acolor2..'}�� ������ ������� "@id" �� "Nick_Name", ��� Nick_Name - ��� ���� ������, ��� id �� �����.', '�������', '', 0)
			elseif list == 13 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}FChecker\n{'..acolor2..'}���������� ���������� � ���, ��� �� ����� ������ ������.\n{'..acolor2..'}�������:\n{'..acolor2..'}/fcturn - ��������/��������� �����������\n{'..acolor2..'}/fcreload - ������������� FChecker\n{'..acolor2..'}/fcsize - �������� ������\n{'..acolor2..'}/fcfont - �������� �����\n{'..acolor2..'}/fcflag - ��������� �����\n{'..acolor2..'}/fcadd - �������� �����\n{'..acolor2..'}/fcdelete - ������� �� ������\n{'..acolor2..'}/fcmove - ����������� �������� � ������� ������', '�������', '', 0)
			elseif list == 14 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}chip\n{'..acolor2..'}���������� ���������� � IP. �������������: /chip [ip1] [ip2]', '�������', '', 0)
			elseif list == 15 then
				json.spam = not json.spam
				info()
				save()
			elseif list == 16 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}������� ��������\n{'..acolor4..'}�������������:\n{'..acolor2..'}/fcset - ���������� ����, ��� ���� ������ � � ����� ����������. \n{'..acolor4..'}����������: ����������� ���������� ������������ � ������ ������, � �� ��������� ����� ���������� ��������.\n{'..acolor2..'}/up - ������ ��������.', '�������', '', 0)
			elseif list == 17 then
				if json.iznas then
					sampShowDialog(679, 'AHelper', '{'..acolor3..'}����������\t{'..acolor2..'}����-�������������\n{'..acolor3..'}���������\t{'..acolor2..'}��������', '�����', '�������',4)
				elseif json.iznas == false then
					sampShowDialog(679, 'AHelper', '{'..acolor3..'}����������\t{'..acolor2..'}����-�������������\n{'..acolor3..'}���������\t{'..acolor2..'}���������', '�����', '�������', 4)
				end
			elseif list == 18 then
				json.chat = not json.chat
				info()
				save()
			elseif list == 19 then
				json.asms[1] = not json.asms[1]
				info()
				save()
			elseif list == 20 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}������ �� �������\n{'..acolor2..'}�������������:\n{'..acolor4..'}/setotbor - ���������� ��� ������: 1 - �����, 2 - �����, 3 - ���. ���������, 4 - ��������\n{'..acolor4..'}/otbor - ������ �����. ������� ��������� �������, ����� ��� 10-� ��������� ��������.\n{'..acolor4..'}����� ��������� ������ ������. ��� ��������� �������� ����� ����� �����a�� B (����.).', '�������', '', 0)
			end
		end end
		local result, button, list, _ = sampHasDialogRespond(801)
		if result then if button == 1 then ccomand('cmd1', 3, list, 1) end end
		local result, button, _, input = sampHasDialogRespond(8010)
		if result then cinput('cmd1', 3, button, input, 1, false) end
		local result, button, list, _ = sampHasDialogRespond(802)
		if result then if button == 1 then ccomand('cmd2', 3, list, 2) end end
		local result, button, _, input = sampHasDialogRespond(8020)
		if result then cinput('cmd2', 3, button, input, 2, false) end
		local result, button, list, _ = sampHasDialogRespond(803)
		if result then if button == 1 then ccomand('cmd3', 3, list, 3) end end
		local result, button, _, input = sampHasDialogRespond(8030)
		if result then cinput('cmd3', 3, button, input, 3, false) end
		local result, button, _, input = sampHasDialogRespond(8011)
		if result then cinput('cmd1', 3, button, input, 1, true) end
		local result, button, _, input = sampHasDialogRespond(8021)
		if result then cinput('cmd2', 3, button, input, 2, true) end
		local result, button, _, input = sampHasDialogRespond(8031)
		if result then cinput('cmd2', 3, button, input, 3, true) end
		local result, button, list, _ = sampHasDialogRespond(671)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msg1', 3)
				elseif list == 1 or list == 2 then
					json.msg1[list] = not json.msg1[list]
					sampShowDialog(671, 'AHelper', '{'..acolor3..'}���������� � �������\t{'..acolor3..'}/msg1\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg1[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg1[2]), '�����', '�������', 4)
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(672)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msg2', 3)
				elseif list == 1 or list == 2 then
					json.msg2[list] = not json.msg2[list]
					sampShowDialog(672, 'AHelper', '{'..acolor3..'}���������� � �������\t{'..acolor3..'}/msg2\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg2[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg2[2]), '�����', '�������', 4)
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(673)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msg3', 3)
				elseif list == 1 or list == 2 then
					json.msg3[list] = not json.msg3[list]
					sampShowDialog(673, 'AHelper', '{'..acolor3..'}���������� � �������\t{'..acolor3..'}/msg3\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg3[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg3[2]), '�����', '�������', 4)
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(674)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msg4', 3)
				elseif list == 1 or list == 2 then
					json.msg4[list] = not json.msg4[list]
					sampShowDialog(674, 'AHelper', '{'..acolor3..'}���������� � �������\t{'..acolor3..'}/msg4\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg4[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg4[2]), '�����', '�������', 4)
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(675)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msg5', 3)
				elseif list == 1 or list == 2 then
					json.msg5[list] = not json.msg5[list]
					sampShowDialog(675, 'AHelper', '{'..acolor3..'}���������� � �������\t{'..acolor3..'}/msg5\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msg5[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msg5[2]), '�����', '�������', 4)
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(676)
		if result then
			if button == 1 then
				if list == 0 then
					printhelp('msgk', 6)
				elseif list == 1 or list == 2 then
					json.msgk[list] = not json.msgk[list]
					sampShowDialog(676, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/msgk\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json.msgk[1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json.msgk[2])..'\n{'..acolor4..'}��������� ��������', '�����', '�������', 4)
				elseif list == 3 then
					sampShowDialog(6760, 'AHelper', '{'..acolor4..'}����� �����\t{'..acolor4..'}����\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[3]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[4]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[5]..'\n{'..acolor4..'}�������� msg\t{'..acolor4..'}������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!', '�����', '�������', 5)
				end
				if list ~= 0 then save() end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(6760)
		if result then
			if button == 1 then
				if list == 0 then sampShowDialog(6761, 'AHelper', '{'..acolor4..'}���� ������ ������������� ����������� ���������� /msgk, �� �� ����� ���� ������.\n����� ����� ������� �����:', '�����', '������', 1) elseif list == 1 then sampShowDialog(6762, 'AHelper', '{'..acolor4..'}���� ������ ������������� ����������� ���������� /msgk, �� �� ����� ���� ������.\n����� ����� ������� �����:', '�����', '������', 1) elseif list == 2 then sampShowDialog(6763, 'AHelper', '{'..acolor4..'}���� ������ ������������� ����������� ���������� /msgk, �� �� ����� ���� ������.\n����� ����� �������� �����:', '�����', '������', 1) end
			end
		end
		local result, button, _, input = sampHasDialogRespond(6761)
		if result then
			if button == 1 then
				json.msgk[3] = input
				json.msgk[6] = {'/msg ������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!'}
				sampShowDialog(6760, 'AHelper', '{'..acolor4..'}����� �����\t{'..acolor4..'}����\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[3]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[4]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[5]..'\n{'..acolor4..'}�������� msg\t{'..acolor4..'}������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!', '�����', '�������', 5)
				save()
			end
		end
		local result, button, _, input = sampHasDialogRespond(6762)
		if result then
			if button == 1 then
				json.msgk[4] = input
				json.msgk[6] = {'/msg ������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!'}
				sampShowDialog(6760, 'AHelper', '{'..acolor4..'}����� �����\t{'..acolor4..'}����\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[3]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[4]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[5]..'\n{'..acolor4..'}�������� msg\t{'..acolor4..'}������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!', '�����', '�������', 5)
				save()
			end
		end
		local result, button, _, input = sampHasDialogRespond(6763)
		if result then
			if button == 1 then
				json.msgk[5] = input
				json.msgk[6] = {'/msg ������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!'}
				sampShowDialog(6760, 'AHelper', '{'..acolor4..'}����� �����\t{'..acolor4..'}����\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[3]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[4]..'\n{'..acolor2..'}������ ����\t{'..acolor3..'}'..json.msgk[5]..'\n{'..acolor4..'}�������� msg\t{'..acolor4..'}������� � ������ (/INFO) �� '..json.msgk[3]..', '..json.msgk[4]..', '..json.msgk[5]..'!', '�����', '�������', 5)
				save()
			end
		end
		local result, button, list, _ = sampHasDialogRespond(677)
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(6770, 'AHelper', '{'..acolor3..'}������� ������ ����\n{'..acolor2..'}���� � ����������� �������� ��������� � �.�., �� � ��� ���� 10 ������ �� ��, ����� ������ ������ M.\n{'..acolor2..'}����� ������ ������������� ������ ��� ����, ��� �������� ���������, �������� � �����������.', '�������', '', 0)
				elseif list == 1 then
					json.amute = not json.amute
					if json.amute then
						sampShowDialog(677, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}������� ������ ����\n{'..acolor2..'}���������\t{'..acolor2..'}��������', '�����', '�������', 4)
					elseif json.amute == false then
						sampShowDialog(677, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}������� ������ ����\n{'..acolor2..'}���������\t{'..acolor2..'}���������', '�����', '�������', 4)
					end
					save()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(678)
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(670, 'AHelper', '{'..acolor3..'}������� ����� �� ������\n{'..acolor2..'}����� �������� ������ � ������� "sp", "��" � �.�., � ��� ����� 5 ������ �� ��, ����� ������ �� ������ X. \n{'..acolor2..'}����� ������ ������������� ������� �� ������ � �������� ����������� ������� �� �����.\n{'..acolor3..'}���� ����� "�������� ���������" ��������, �� ������ ������������� ������ ��������� ������� �� ���� � ������� (!).\n{'..acolor3..'}���� ����� "�������� ������ ������" ��������, �� ������ �� ���� ��������, ���� �� ������ ��� ������� ������ �������������.', '�������', '', 0)
				elseif list >= 1 and list <= #json.autorep then
					json.autorep[list] = not json.autorep[list]
					save()
					list11()
				end
			end
		end
		local result, button, list, _ = sampHasDialogRespond(679)
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(670, 'AHelper', '{'..acolor3..'}����-�������������\n{'..acolor2..'}���� ���� ����������, �� (�����) ����� ����������� ����� ������.\n{'..acolor2..'}����������: ���� ����� ������� "/me ����������� Nick_Name", ��� Nick_Name - ���� ���, �� �� ���� ����������� ����� ������.\n{'..acolor2..'}��� �� ������������.', '�������', '', 0)
				elseif list == 1 then
					json.iznas = not json.iznas
					if json.iznas then
						sampShowDialog(679, 'AHelper', '{'..acolor3..'}����������\t{'..acolor2..'}����-�������������\n{'..acolor3..'}���������\t{'..acolor2..'}��������', '�����', '�������', 4)
					elseif json.iznas == false then
						sampShowDialog(679, 'AHelper', '{'..acolor3..'}����������\t{'..acolor2..'}����-�������������\n{'..acolor3..'}���������\t{'..acolor2..'}���������', '�����', '�������', 4)
					end
				end
			end
		end
		local result, button, _, _ = sampHasDialogRespond(900)
		if result then
			if button == 1 then
				lua_thread.create(autoupdate2)
			end
		end
	end
end
function ccomand(param1, param2, list, num)
	if list == 0 then
		printhelp(param1, param2)
	elseif list == 1 or list == 2 then
		json[param1][list] = not json[param1][list]
		sampShowDialog(800+num, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/'..param1..'\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json[param1][1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json[param1][2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json[param1][param2])..' ���.', '�����', '�������', 4)
		save()
	elseif list == 3 then
		if #json[param1][param2+1] < #json[param1][param2] then kd = true else kd = false end
		if kd then sampShowDialog((800+num)*10+1, 'AHelper', '{'..acolor3..'}/'..param1..'\n{'..acolor2..'}����� �������� ����� ��������� ���������� ��������� � ������������� (1,5 ������ = 1500 �����������).\n{'..acolor4..'}���� ��� ��������� ���������, �� ��������� �� �������� �� �� ���.', '�����', '������', 1) else sampShowDialog((800+num)*10, 'AHelper', '{'..acolor3..'}/'..param1..'\n{'..acolor2..'}����� ���������, ������� ����� �����������.', '�����', '������', 1) end
	elseif list == 4 then
		json[param1][param2] = {}
		json[param1][param2+1] = {}
		sampShowDialog(800+num, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/'..param1..'\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json[param1][1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json[param1][2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json[param1][param2])..' ���.', '�����', '�������', 4)
		save()
	end
end
function cinput(param1, param2, button, input, num)
	if button == 1 then
		if not kd then
			if #input > 0 then
				json[param1][param2][#json[param1][param2]+1] = input
			else
				sampAddChatMessage('AHelper: �� �� ��� �����!', color1)
			end
		else
			if #input > 0 then
				if input:find('^%d+') then
					if tonumber(input:match('^(%d+)')) > 500 and tonumber(input:match('^(%d+)')) < 60001 then
						json[param1][param2+1][#json[param1][param2+1]+1] = input:match('^(%d+)')
					else
						sampAddChatMessage('AHelper: ������� 500 � �������� 60001!', color1)
					end
				else
					sampAddChatMessage('AHelper: �� �� ��� ��������!', color1)
				end
			else
				sampAddChatMessage('AHelper: �� �� ��� ��������!', color1)
			end
		end
		if #json[param1][param2+1] < #json[param1][param2] then kd = true else kd = false end
		if kd then
			sampShowDialog((800+num)*10+1, 'AHelper', '{'..acolor3..'}/'..param1..'\n{'..acolor2..'}����� �������� ����� ��������� ���������� ���������.\n{'..acolor4..'}���� ��� ��������� ���������, �� ��������� �� �������� �� �� ���.', '�����', '������', 1)
		else
			sampShowDialog(800+num, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/'..param1..'\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json[param1][1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json[param1][2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json[param1][param2])..' ���.', '�����', '�������', 4)
		end
		save()
	else
		sampShowDialog(800+num, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}/'..param1..'\n{'..acolor2..'}/fuelcars\t{'..acolor2..'}'..tostring(json[param1][1])..'\n{'..acolor2..'}���������� /sduty\t{'..acolor2..'}'..tostring(json[param1][2])..'\n{'..acolor4..'}�������� ������\n{'..acolor4..'}��������\t{'..acolor4..'}'..tostring(#json[param1][param2])..' ���.', '�����', '�������', 4)
	end
end
function printhelp(param1, param2)
	if json.chat then
			for i, v in ipairs(json[param1][param2]) do
			if param1 ~= 'msgk' then
				sampAddChatMessage(v, color1)
			else
				if json[param1][3] ~= '' and json[param1][4] ~= '' and json[param1][5] ~= '' then
					sampAddChatMessage(v, color1)
				else
					sampAddChatMessage('����� �����!', color1)
				end
			end
		end
		if json[param1][1] then
			sampAddChatMessage('/fuelcars', color1)
		end
		if json[param1][2] then
			sampAddChatMessage('/asc /sduty /sduty /sduty /sduty /sduty', color1)
			sampAddChatMessage('/sduty', color1)
		end
	else
		local temp = {}
		if #json[param1][param2] > 1 and #json[param1][param2] < 11 then
			if param1 ~= 'msgk' then for i, v in ipairs(json[param1][param2]) do temp[#temp+1] = v end else temp[#temp+1] = string.format('/msg ������� � ������ (/INFO) �� %s, %s, %s!', json[param1][param2-3], json[param1][param2-2], json[param1][param2-1]) end
			if #temp == 2 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2], '�������', '', 0)
			elseif #temp == 3 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3], '�������', '', 0)
			elseif #temp == 4 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4], '�������', '', 0)
			elseif #temp == 5 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5], '�������', '', 0)
			elseif #temp == 6 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5]..'\n{'..acolor2..'}'..temp[6], '�������', '', 0)
			elseif #temp == 7 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5]..'\n{'..acolor2..'}'..temp[6]..'\n{'..acolor2..'}'..temp[7], '�������', '', 0)
			elseif #temp == 8 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5]..'\n{'..acolor2..'}'..temp[6]..'\n{'..acolor2..'}'..temp[7]..'\n{'..acolor2..'}'..temp[8], '�������', '', 0)
			elseif #temp == 9 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5]..'\n{'..acolor2..'}'..temp[6]..'\n{'..acolor2..'}'..temp[7]..'\n{'..acolor2..'}'..temp[8]'\n{'..acolor2..'}'..temp[9], '�������', '', 0)
			elseif #temp == 10 then
				sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..temp[1]..'\n{'..acolor2..'}'..temp[2]..'\n{'..acolor2..'}'..temp[3]..'\n{'..acolor2..'}'..temp[4]..'\n{'..acolor2..'}'..temp[5]..'\n{'..acolor2..'}'..temp[6]..'\n{'..acolor2..'}'..temp[7]..'\n{'..acolor2..'}'..temp[8]'\n{'..acolor2..'}'..temp[9]..'\n{'..acolor2..'}'..temp[10], '�������', '', 0)
			end
		elseif #json[param1][param2] == 1 then
			local v = ''
			if param1 ~= 'msg6' then
				v = json[param1][param2][#json[param1][param2]]
			else
				v = string.format('/msg ������� � ������ (/INFO) �� %s, %s, %s!', json[param1][param2-3], json[param1][param2-2], json[param1][param2-1])
			end
			if json[param1][1] and json[param1][2] then sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..v..'\n{'..acolor2..'}/fuelcars\n{'..acolor2..'}/asc /sduty /sduty /sduty /sduty /sduty\n{'..acolor2..'}/sduty', '�������', '', 0) elseif json[param1][1] and not json[param1][2] then sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..v..'\n{'..acolor2..'}/fuelcars', '�������', '', 0) elseif not json[param1][1] and json[param1][2] then sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..v..'\n{'..acolor2..'}/asc /sduty /sduty /sduty /sduty /sduty\n{'..acolor2..'}/sduty', '�������', '', 0) else sampShowDialog(670, 'AHelper', '{'..acolor3..'}��� /'..param1..' ����� ����� ������ �����:\n{'..acolor2..'}'..v, '�������', '', 0) end
		else sampShowDialog(670, 'AHelper', '{'..acolor3..'}Error: ���������� ����� �������������� ������ �� 1 �� 10. ����� �� ��������.', '�������', '', 0)
		end
	end
end
function save()
	f = io.open('moonloader\\config\\ahelper.json', 'w')
	f:write(encodeJson(json))
	f:close()
	f = io.open('moonloader\\config\\ahelper.json', 'r')
	json = decodeJson(f:read("*a"))
	f:close()
end
function save1()
	f = io.open('moonloader\\config\\offhelper.json', 'w')
	f:write(encodeJson(table1))
	f:close()
	f = io.open('moonloader\\config\\offhelper.json', 'r')
	table1 = decodeJson(f:read("*a"))
	f:close()
end
function save2()
	a = io.open('moonloader\\config\\offhelper_nicks.json', 'w')
	a:write(encodeJson(nicks))
	a:close()
	a = io.open('moonloader\\config\\offhelper_nicks.json', 'r')
	nicks = decodeJson(a:read("*a"))
	a:close()
end
function list11()
	local vkls = {}
	for i, v in ipairs(json.autorep) do
		if json.autorep[i] then vkls[i] = '��������' elseif json.autorep[i] == false then vkls[i] = '���������' end
	end
	sampShowDialog(678, 'AHelper', '{'..acolor3..'}����������\t{'..acolor3..'}������� ����� �� ������\n{'..acolor2..'}������� /sp\t{'..acolor2..'}'..vkls[1]..'\n{'..acolor2..'}�������� ��������� ��� ������� /sp\t{'..acolor2..'}'..vkls[2]..'\n{'..acolor2..'}������� /veh\t{'..acolor2..'}'..vkls[3]..'\n{'..acolor2..'}�������� ��������� ��� ������� /veh\t{'..acolor2..'}'..vkls[4]..'\n{'..acolor2..'}������� /gothere\t{'..acolor2..'}'..vkls[5]..'\n{'..acolor2..'}�������� ��������� ��� ������� /gothere\t{'..acolor2..'}'..vkls[6]..'\n{'..acolor2..'}�������� ������ ������\t{'..acolor2..'}'..vkls[7], '�������', '', 4)
end
function flood1()
	lua_thread.create(waits, json.msg1[3], 'msg1', {})
end
function flood2()
	lua_thread.create(waits, json.msg2[3], 'msg2', {})
end
function flood3()
	lua_thread.create(waits, json.msg3[3], 'msg3', {})
end
function flood4()
	lua_thread.create(waits, json.msg4[3], 'msg4', {})
end
function flood5()
	lua_thread.create(waits, json.msg5[3], 'msg5', {})
end
function flood6()
	lua_thread.create(waits, json.msgk[6], 'msgk', {})
end
function floodc1()
	lua_thread.create(waits, json.cmd1[3], 'cmd1', json.cmd1[4])
end
function floodc2()
	lua_thread.create(waits, json.cmd2[3], 'cmd2', json.cmd2[4])
end
function floodc3()
	lua_thread.create(waits, json.cmd3[3], 'cmd3', json.cmd3[4])
end
function waits(text, param, time)
	wait(1250)
	for i, v in ipairs(text) do
		if param ~= 'msgk' and not param:find('c%w+') then
			sampSendChat(v)
			if #time ~= 0 then
				wait(time[i])
			else
				wait(1250)
			end
		elseif param == 'msgk' then if json[param][3] ~= '' and json[param][4] ~= '' and json[param][5] ~= '' then
				sampSendChat(v)
				wait(1250)
			end
		elseif param:find('cmd%d+') then if #text ~= 0 then
				sampSendChat(v)
				wait(time[i])
			else
				sampAddChatMessage('AHelper: ����� ����� ���������!', color1)
			end
		end
	end
	if json[param][1] then
		sampSendChat('/fuelcars')
		wait(1250)
	end
	if json[param][2] then
		sampSendChat('/asc /sduty /sduty /sduty /sduty /sduty')
		wait(1250)
		sampSendChat('/sduty')
		wait(1250)
	end
end

function bind(iid, time)
	while true do
		wait(0)
		if os.time() <= time then
			if not sampIsChatInputActive() then
				if isKeyJustPressed(vk.VK_M) or isKeyDown(vk.VK_M) then
					sampSendChat('/mute '..iid..' 30 ���������� ������')
					break
				end
			end
		else
			sampAddChatMessage('AHelper: ����� ��� �����.', color4)
			break
		end
	end
end

function event.onSendChat(message)	-- @id
	for i in message:gmatch('@(%d+)') do
		local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
		if sampIsPlayerConnected(tonumber(i)) or i == idd then
			if message:match('(@%d+)') ~= nil then
				message = message:gsub(message:match('(@%d+)'), sampGetPlayerNickname(tonumber(i)))
			end
		end
	end
	return {message}
end
function event.onSendCommand(command)
	for i in command:gmatch('@(%d+)') do
		if sampIsPlayerConnected(tonumber(i)) or i == idd then
			if command:match('(@%d+)') ~= nil then
				command = command:gsub(command:match('(@%d+)'), sampGetPlayerNickname(tonumber(i)))
			end
		end
	end
	return {command}
end

function initializeRender()		-- clickwarp (�) FYP, ������� �� �������� ���������!
  font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
end
function readFloatArray(ptr, idx)
  return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end
function writeFloatArray(ptr, idx, value)
  writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end
function getVehicleRotationMatrix(car)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      local rx, ry, rz, fx, fy, fz, ux, uy, uz
      rx = readFloatArray(mat, 0)
      ry = readFloatArray(mat, 1)
      rz = readFloatArray(mat, 2)
      fx = readFloatArray(mat, 4)
      fy = readFloatArray(mat, 5)
      fz = readFloatArray(mat, 6)
      ux = readFloatArray(mat, 8)
      uy = readFloatArray(mat, 9)
      uz = readFloatArray(mat, 10)
      return rx, ry, rz, fx, fy, fz, ux, uy, uz
    end
  end
end
function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      writeFloatArray(mat, 0, rx)
      writeFloatArray(mat, 1, ry)
      writeFloatArray(mat, 2, rz)
      writeFloatArray(mat, 4, fx)
      writeFloatArray(mat, 5, fy)
      writeFloatArray(mat, 6, fz)
      writeFloatArray(mat, 8, ux)
      writeFloatArray(mat, 9, uy)
      writeFloatArray(mat, 10, uz)
    end
  end
end
function displayVehicleName(x, y, gxt)
  x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
  useRenderCommands(true)
  setTextWrapx(640.0)
  setTextProportional(true)
  setTextJustify(false)
  setTextScale(0.33, 0.8)
  setTextDropshadow(0, 0, 0, 0, 0)
  setTextColour(255, 255, 255, 230)
  setTextEdge(1, 0, 0, 0, 100)
  setTextFont(1)
  displayText(x, y, gxt)
end
function createPointMarker(x, y, z)
  pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
function removePointMarker()
  if pointMarker then
    removeUser3dMarker(pointMarker)
    pointMarker = nil
  end
end
function getCarFreeSeat(car)
  if doesCharExist(getDriverOfCar(car)) then
    local maxPassengers = getMaximumNumberOfPassengers(car)
    for i = 0, maxPassengers do
      if isCarPassengerSeatFree(car, i) then
        return i + 1
      end
    end
    return nil -- no free seats
  else
    return 0 -- driver seat
  end
end
function jumpIntoCar(car)
  local seat = getCarFreeSeat(car)
  if not seat then return false end                         -- no free seats
  if seat == 0 then warpCharIntoCar(playerPed, car)         -- driver seat
  else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) -- passenger seat
  end
  restoreCameraJumpcut()
  return true
end
function teleportPlayer(x, y, z)
  if isCharInAnyCar(playerPed) then
    setCharCoordinates(playerPed, x, y, z)
  end
  setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end
function setCharCoordinatesDontResetAnim(char, x, y, z)
  if doesCharExist(char) then
    local ptr = getCharPointer(char)
    setEntityCoordinates(ptr, x, y, z)
  end
end
function setEntityCoordinates(entityPtr, x, y, z)
  if entityPtr ~= 0 then
    local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
    if matrixPtr ~= 0 then
      local posPtr = matrixPtr + 0x30
      writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
      writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
      writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
    end
  end
end
function showCursor(toggle)
  if toggle then
    sampSetCursorMode(CMODE_LOCKCAM)
  else
    sampToggleCursor(false)
  end
  cursorEnabled = toggle
end
-- checkip by drags
function asyncHttpRequest(method, url, args, resolve, reject)
	local request_thread = effil.thread(function(method, url, args)
		local requests = require"requests"
		local result, response = pcall(requests.request, method, url, args)
		if result then
			response.json, response.xml = nil, nil
			return true, response
		else
			return false, response
		end
	end)(method, url, args)

	if not resolve then
		resolve = function() end
	end
	if not reject then
		reject = function() end
	end
	lua_thread.create(function()
		local runner = request_thread
		while true do
			local status, err = runner:status()
			if not err then
				if status == "completed" then
					local result, response = runner:get()
					if result then
						resolve(response)
					else
						reject(response)
					end
					return
				elseif status == "canceled" then
					return reject(status)
				end
			else
				return reject(err)
			end
			wait(0)
		end
	end)
end
function distance_cord(lat1, lon1, lat2, lon2)
	if lat1 == nil or lon1 == nil or lat2 == nil or lon2 == nil or lat1 == "" or lon1 == "" or lat2 == "" or lon2 == "" then
		return 0
	end
	local dlat = math.rad(lat2 - lat1)
	local dlon = math.rad(lon2 - lon1)
	local sin_dlat = math.sin(dlat / 2)
	local sin_dlon = math.sin(dlon / 2)
	local a =
		sin_dlat * sin_dlat + math.cos(math.rad(lat1)) * math.cos(
			math.rad(lat2)
		) * sin_dlon * sin_dlon
	local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
	local d = 6378 * c
	return d
end
function chip(cl)
	ips = {}
	for word in string.gmatch(cl, "(%d+%p%d+%p%d+%p%d+)") do
		ips[#ips+1] = { query = word }
	end
	if #ips > 0 then
		data_json = cjson.encode(ips)
		asyncHttpRequest(
			"POST",
			"http://ip-api.com/batch?fields=25305&lang=ru",
			{ data = data_json },
			function(response)
				local rdata = cjson.decode(u8:decode(response.text))
				local text = ""
				for i = 1, #rdata do
					if rdata[i]["status"] == "success" then
						local distances =
							distance_cord(
								rdata[1]["lat"],
								rdata[1]["lon"],
								rdata[i]["lat"],
								rdata[i]["lon"]
							)
						text =
							text .. string.format(
								"\n{FFF500}IP - {FF0400}%s\n{FFF500}������ -{FF0400} %s\n{FFF500}����� -{FF0400} %s\n{FFF500}��������� -{FF0400} %s\n{FFF500}��������� -{FF0400} %d  \n\n",
								rdata[i]["query"],
								rdata[i]["country"],
								rdata[i]["city"],
								rdata[i]["isp"],
								distances
							)
               end
				end
				if text == "" then
					text = " \n\t{FFF500}������ �� �������"
				end
				showdialog("���������� � IP", text)
			end,
			function(err)
				showdialog("���������� � IP", "��������� ������ \n" .. err)
			end
		)
	end
end
function showdialog(name, rdata)
	sampShowDialog(
		math.random(1000),
		"{FF4444}" .. name,
		rdata,
		"�������",
		false,
		0
	)
end
-- FChecker, ������� �� �������� ���������!
function fchecker()
  while true do
	wait(0)
    if not isPauseMenuActive() and not isKeyDown(VK_F8) and data.options.turn == 1 then
      if mouseCoordinates then
        sampToggleCursor(true)
	      mouseX, mouseY = getCursorPos()
      end
      friendsText = " Friends Online:\n"
      for b = 0, 201 do
		local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
        for i = 1, #data.friends do
          if sampIsPlayerConnected(b) or b == idd then
			name = sampGetPlayerNickname(b)
            if data.friends[i] ~= nil then data.friends[i] = string.upper(data.friends[i]) end
            if name ~= nil then regPlayer = string.upper(name) end
            regName = string.match(data.friends[i], regPlayer)
            if regName == data.friends[i] then
              friendStreamed, friendPed = sampGetCharHandleBySampPlayerId(b)
              if friendStreamed then
                friendX, friendY, friendZ = getCharCoordinates(friendPed)
                myX, myY, myZ = getCharCoordinates(playerPed)
                distance = getDistanceBetweenCoords3d(friendX, friendY, friendZ, myX, myY, myZ)
                distanceInteger = math.floor(distance)
              end
              friendPaused = sampIsPlayerPaused(b)
              color = sampGetPlayerColor(b)
              color = string.format("%X", color)
              if friendPaused then color = string.gsub(color, "..(......)", "66%1") else color = string.gsub(color, "..(......)", "FF%1")
              end
              if friendStreamed then friendList = string.format("{%s}%s[%d] (%dm)", color, name, b, distanceInteger) else friendList = string.format("{%s}%s[%d]", color, name, b) end
              friendsText = string.format("%s %s\n", friendsText, friendList)
            end
          end
        end
      end
      if mouseCoordinates then
        renderFontDrawText(font, friendsText, mouseX, mouseY, -1)
        if isKeyDown(VK_LBUTTON) then
          mouseCoordinates = false
          local data = LIP.load('moonloader\\config\\FChecker.ini');
          data.options.coordX = mouseX
          data.options.coordY = mouseY
          LIP.save('moonloader\\config\\FChecker.ini', data);
          sampToggleCursor(false)
          local script = thisScript()
          script:reload()
        end
      else
        if friendsText ~= " Friends Online:\n" and friendsText ~= "nil" then renderFontDrawText(font, friendsText, data.options.coordX, data.options.coordY, -1) else renderFontDrawText(font, "No one is online", data.options.coordX, data.options.coordY, -1) end
      end
    end
  end
end
function cmdMouseCoords()
	mouseCoordinates = true
end
function cmdTurn()
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  if data.options.turn == 1 then
    data.options.turn = 0
    LIP.save('moonloader\\config\\FChecker.ini', data);
    local script = thisScript()
    script:reload()
  else
    data.options.turn = 1
    LIP.save('moonloader\\config\\FChecker.ini', data);
    local script = thisScript()
    script:reload()
  end
end
function cmdReload()
  local script = thisScript()
  script:reload()
end
function cmdFontSize(newSize)
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  data.font.size = newSize
  LIP.save('moonloader\\config\\FChecker.ini', data);
  local script = thisScript()
  script:reload()
end
function cmdFontName(newName)
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  data.font.name = newName
  LIP.save('moonloader\\config\\FChecker.ini', data);
  local script = thisScript()
  script:reload()
end
function cmdFontFlag(newFlag)
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  data.font.flag = newFlag
  LIP.save('moonloader\\config\\FChecker.ini', data);
  local script = thisScript()
  script:reload()
end
function cmdFriendsAdd(newFriend)
  newFriendN = tonumber(newFriend)
  if newFriendN ~= nil then
	local _, idd = sampGetPlayerIdByCharHandle(PLAYER_PED)
    if sampIsPlayerConnected(newFriendN) or newFriendN == idd then newFriend = sampGetPlayerNickname(newFriendN) end
    if newFriend ~= nil then newFriend = string.upper(newFriend) end
  end
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  myIndex = 0
  abc = 1
  while abc == 1 do
    myIndex = myIndex + 1
     if data.friends[myIndex] == nil then abc = 2 end
  end
  data.friends[myIndex] = newFriend
  if data.friends[myIndex] ~= nil then data.friends[myIndex] = string.upper(data.friends[myIndex]) end
  LIP.save('moonloader\\config\\FChecker.ini', data);
  local script = thisScript()
  script:reload()
end
function cmdFriendsRemove(delFriend)
  delFriendN = tonumber(delFriend)
  if delFriendN ~= nil then
    if sampIsPlayerConnected(delFriendN) then delFriend = sampGetPlayerNickname(delFriendN) end
    if delFriend ~= nil then delFriend = string.upper(delFriend) end
  end
  local data = LIP.load('moonloader\\config\\FChecker.ini');
  if delFriend ~= nil then delFriend = string.upper(delFriend) end
  for i = 1, #data.friends do
    if data.friends[i] == delFriend then data.friends[i] = nil end
  end
  LIP.save('moonloader\\config\\FChecker.ini', data);
  local script = thisScript()
  script:reload()
end
function LIP.load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	local file = assert(io.open(fileName, 'r'), 'Error loading file : ' .. fileName);
	local data = {};
	local section;
	for line in file:lines() do
		local tempSection = line:match('^%[([^%[%]]+)%]$');
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection;
			data[section] = data[section] or {};
		end
		local param, value = line:match('^([%w|_]+)%s-=%s-(.+)$');
		if(param and value ~= nil)then
			if(tonumber(value))then
				value = tonumber(value);
			elseif(value == 'true')then
				value = true;
			elseif(value == 'false')then
				value = false;
			end
			if(tonumber(param))then
				param = tonumber(param);
			end
			data[section][param] = value;
		end
	end
	file:close();
	return data;
end
function LIP.save(fileName, data)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	assert(type(data) == 'table', 'Parameter "data" must be a table.');
	local file = assert(io.open(fileName, 'w+b'), 'Error loading file :' .. fileName);
	local contents = '';
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section);
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\n'):format(key, tostring(value));
		end
		contents = contents .. '\n';
	end
	file:write(contents);
	file:close();
	return LIP;
end

function autoupdate(json_url)
	local dlstatus = require('moonloader').download_status
	local ajson = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(ajson) then os.remove(ajson) end
	downloadUrlToFile(json_url, ajson,
	function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
			if doesFileExist(ajson) then
				local f = io.open(ajson, 'r')
				if f then
					local info = decodeJson(u8:decode(f:read('*a')))
					updatelink = info.updateurl
					updateversion = info.latest
					inform = info.inform
					f:close()
					os.remove(ajson)
					if updateversion ~= thisScript().version then
						sampShowDialog(900, 'AHelper', '{'..acolor5..'}���������� ����� ������: '..updateversion..'\n{'..acolor3..'}����� ���� ahelper.json �� moonloader/config.\n������������:'..inform, '��������', '�� ���������', 0)
    				else
        				update = false
						sampAddChatMessage((prefix..'������ ���������� �� ����������, � ��� ����������� ��������� ������.'), color5)
					end
        		end
			else
    			update = false
			end
		end
	end)
end
function autoupdate2()
	local dlstatus = require('moonloader').download_status
	sampAddChatMessage((prefix..'������� ���������� c '..thisScript().version..' �� '..updateversion), color5)
	wait(250)
	downloadUrlToFile(updatelink, thisScript().path,
	function(id3, status1, p13, p23)
		if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
		elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
			sampAddChatMessage((prefix..'���������� ���������!'), color5)
			goupdatestatus = true
			lua_thread.create(function() wait(500) thisScript():reload() end)
		end
		if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
			if goupdatestatus == nil then
				sampAddChatMessage((prefix..'���������� ������ ��������. ������ � �� - @jo_lac. �������� ���������� ������..'), color5)
				update = false
			end
		end
	end)
end
