

STATE_NULL = 0;
STATE_RUN   = 1;
STATE_PAUSE = 2;
STATE_READY = 3;

--data level
DATA_LEVEL_NEW     = 0;
DATA_LEVEL_LOCAL = 1;
DATA_LEVEL_NET       = 2;


--自作关卡
MAKE_GAME = 0;
IS_MAKE_GAME = 0;
MAKE_GAME_NULL = 0;
MAKE_GAME_WALL=1;
MAKE_GAME_COLOR=2;
MAKE_GAME_ELEMENT=3;

--
ANIMATE_HELP = 1;
ANIMATE_HELP_GAME   =1;
ANIMATE_HELP_LOAD    = 2;
ANIMATE_HELP_STUDY  = 3;

--
OPTION_UI_FROM = 1;
OPTION_UI_FROM_LOAD = 1;
OPTION_UI_FROM_MENU = 2;



DATA_LEVEL = DATA_LEVEL_LOCAL;
mkcolor = {r=255,g=255,b=255,a=255};
IS_ANIMATE_HELP = false;
HELP_TIMER_INTERVAL=120;
IS_CONTINUE = true;
IS_CLICKDOWN = false;

--
GAME_MODE_SCORE = 0;
GAME_MODE_COMBO = 1;
GAME_MODE = GAME_MODE_SCORE;

MAX_COL=6;
MAX_ROW=7;
GRID_WIDTH = 50;
OFFSET_Y = 125;
OFFSET_X = 0;

--game data
GameData = {};
GameData.numarray = IntArray:new();
GameData.bonus = 0;
GameData.level = 1;
GameData.highscore = 0;
GameData.highlevel = 1;
GameData.actionlist = {};
GameData.withdrawcnt = 5;
GameData.state = STATE_NULL;
GameData.selectname = "";
GameData.maxhitcnt = 0;
GameData.timer = 0;
GameData.time = 0;
GameData.volume = 0.5;
GameData._highscore = 0;
GameData.currentuser = "ouloba";
GameData.helptimer = 0;
GameData.helpindex = 1;
GameData.helpactionlist ={};
GameData.helpani = 1;
GameData.helpthread = nil;
GameData.helppath = nil;
GameData.helplevel = 1;
GameData.scale = 1;
GameData.startanitimer = 0;
GameData.arrindex = {};
GameData.arrcoin   = {};
GameData.effecttimer = 0;
GameData.newhitcnt = 0;
GameData.selectlevel = 1;
GameData.prevlevel = 0;
GameData.buy = 0;
GameData.price = 0;
GameData.PI = 2*math.atan(1);
GameData.rank = 0;
GameData.givestar = 0;

local tblUpdateWnd = {}; 
local tblUpdateWndAdd = {}; 

--game cfg
GameCfg = {};
--[[GameCfg[1] = {3, 2000,3};
GameCfg[2] = {3, 3000,4};
GameCfg[3] = {3, 4000,5};
GameCfg[4] = {3, 5000,0};
GameCfg[5] = {3, 6000,0};
GameCfg[6] = {3, 7000,0};
GameCfg[7] = {4, 8000,0};
GameCfg[8] = {4, 9000,0};
GameCfg[9] = {4, 10000,0};
GameCfg[10] = {4, 12000,0};
GameCfg[11] = {5, 15000,0};
GameCfg[12] = {5, 18000,0};
GameCfg[13] = {5, 20000,0};
GameCfg[14] = {5, 22000,0};
GameCfg[15] = {6, 25000,0};
GameCfg[16] = {7, 28000,0};
GameCfg[17] = {8, 30000,0};
GameCfg[18] = {9, 32000,0};
GameCfg[19] = {10, 35000,0};
GameCfg[20] = {11, 40000,0};
--]]
--render attr ref 
RenderRefMoveLogic = {__index = RenderRefMoveLogic};
RenderRefEditBoxLogic = {__index = RenderRefEditBoxLogic};
RenderRefPictureLogic = {__index = RenderRefPictureLogic};
RenderRefRectLogic = {__index = RenderRefRectLogic};
WindowRefLogic = {__index=WindowRefLogic};
RenderRefParticleLogic = {__index=RenderRefParticleLogic};

GameCfgRef = {};

local tblWndPicture = {};
tblWndPicture["Continue"]={"resumebtn", "resumebtndown"};
tblWndPicture["ScoreMode"]={"scoremodebtn", "scoremodebtndown"};
tblWndPicture["ComboMode"]={"combomodebtn", "combomodebtndown"};
tblWndPicture["Ranking"]={"ranking", "rankingbtndown"};
tblWndPicture["Option"]={"optionbkup", "optionbkdown"};
local tblWndPictureFile = {};
tblWndPictureFile["Continue"]={"resumebtn", "resumebtndown"};
tblWndPictureFile["ScoreMode"]={"scoremodebtn", "scoremodebtndown"};
tblWndPictureFile["ComboMode"]={"combomodebtn", "combomodebtndown"};
tblWndPictureFile["Ranking"]={"ranking", "rankingbtndown"};
tblWndPictureFile["Option"]={"optionbkup", "optionbkdown"};

function LoadGameCfg()

	LXZAPI_OutputDebugStr("LoadGameCfg start ...............");
--
	local dbcfgsys  = CLXZDBCfgSystem:Instance();
	dbcfgsys:CreateIndex(2);
	
	--level data
	CFG_LEVEL  = dbcfgsys:Load("WallStreetLevel.txt");	
	local dbcfg = dbcfgsys:GetDBCfgByID(CFG_LEVEL);
	
	GameCfgRef.level            = dbcfg:GetFieldIndex("关卡序号", GameCfgRef.level);
	GameCfgRef.maxcoin       = dbcfg:GetFieldIndex("最大币值", GameCfgRef.maxcoin);
	GameCfgRef.maxcoin2       = dbcfg:GetFieldIndex("最大币值2", GameCfgRef.maxcoin2);
	GameCfgRef.wincoin       = dbcfg:GetFieldIndex("目标分数", GameCfgRef.wincoin);
	GameCfgRef.wincoin2     = dbcfg:GetFieldIndex("目标分数2", GameCfgRef.wincoin2);
	GameCfgRef.wincoin3     = dbcfg:GetFieldIndex("目标分数3", GameCfgRef.wincoin3);
	GameCfgRef.maxhitcnt    = dbcfg:GetFieldIndex("目标连击", GameCfgRef.maxhitcnt);
	GameCfgRef.timer           = dbcfg:GetFieldIndex("游戏时间", GameCfgRef.timer);
	GameCfgRef.leveldata    = dbcfg:GetFieldIndex("数据ID", GameCfgRef.leveldata);
	
	if(dbcfg:GetRowNums()==0) then
		LXZMessageBox("LoadGameCfg Empty Cfg File");
		return;
	end
	
	for row = 1, dbcfg:GetRowNums(), 1 do		
		local level = dbcfg:GetIntValue(GameCfgRef.level , row);
		local maxcoin0 = dbcfg:GetIntValue(GameCfgRef.maxcoin , row);
		local maxcoin2 = dbcfg:GetIntValue(GameCfgRef.maxcoin2 , row);
		local wincoin0 = dbcfg:GetIntValue(GameCfgRef.wincoin , row);
		local wincoin2 = dbcfg:GetIntValue(GameCfgRef.wincoin2, row);
		local wincoin3 = dbcfg:GetIntValue(GameCfgRef.wincoin3, row);
		local maxhitcnt0 = dbcfg:GetIntValue(GameCfgRef.maxhitcnt , row);
		local timer0 = dbcfg:GetIntValue(GameCfgRef.timer , row);
		local data0 = dbcfg:GetIntValue(GameCfgRef.leveldata , row);
		
		GameCfg[level] = {maxcoin=maxcoin0, maxcoin2=maxcoin2,wincoin=wincoin0, wincoin2=wincoin2, wincoin3=wincoin3, maxhitcnt=maxhitcnt0, timer= timer0, data=data0};		
	end
	
	LXZAPI_OutputDebugStr("LoadGameCfg end...............");
end

function HelperGetCurrentLocalUser()
	
	local user = LXZAPI_CallSystemAPI("GetGameCenterUser", "");
	if(user ~= ""and user~= nil) then
		GameData.currentuser = user;
		--LXZMessageBox("HelperGetCurrentLocalUser");
	end

end

LXZAPI_AddSearchPath(LXZAPIGetWritePath());


local db = nil;
local json = luaopen_cjson();

function HelperInitCreateDB()

	--require "path"
	LXZDoFile("sqlite3.lua");
	
	local corecfg = ICGuiGetLXZCoreCfg();
	
	local  dbfullpath = "";
	local  platform = LXZAPIGetOS();
	if(platform == "WIN32") then
		if(corecfg.IsEditTool) then
			dbfullpath = LXZAPIGetWritePath().."EditCrazyWallStreet.db";
		else
			dbfullpath = LXZAPIGetWritePath().."CrazyWallStreet.db";
		end
	elseif (platform == "ANDROID") then
		dbfullpath = LXZAPIGetWritePath().."CrazyWallStreet.db";
	elseif (platform == "IOS") then
		dbfullpath =  LXZAPIGetWritePath().."CrazyWallStreet.db";
	end	

	LXZAPI_OutputDebugStr("HelperInitCreateDB:"..dbfullpath);
	db = sqlite3.open(dbfullpath);	
	
	--
	local sql = "CREATE TABLE  IF NOT EXISTS UserGameRecord(name TEXT, highscore INTEGER)";	
	local d,err = db:exec(sql);	
	if(d==nil) then
		sql = "CREATE TABLE UserGameRecord(name TEXT, highscore INTEGER)";	
		db:exec(sql);	
	end
	
	--
	local sql = "alter table UserGameRecord add level  default 1";	
	db:exec(sql);	
	
	local sql = "alter table UserGameRecord add mode  default 0";
	db:exec(sql);	
	

	
	--
	--local sql = "CREATE TABLE  IF NOT EXISTS GameRecord(currentuser TEXT, volume INTEGER, mode INTEGER)";
	local sql = "CREATE TABLE IF NOT EXISTS GameRecord(currentuser TEXT, volume INTEGER, mode INTEGER)";
	db:exec(sql);	
	
	--local sql = "insert into GameRecord(currentuser, volume, mode) VALUES('ouloba', 80, 0)";
	--db:exec(sql);	
	
	local sql = "alter table GameRecord add bonus  default 0";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add maxhitcnt  default 0";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add level  default 1";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add withdrawcnt  default 0";	
	db:exec(sql);	
	
	local sql = "alter table GameRecord add time  default 0";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add buy  default 0";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add rank  default  0";
	db:exec(sql);	
	
	local sql = "alter table GameRecord add givestar  default  0";
	db:exec(sql);	
	
		
	return db;
end

function SaveDBCurrentUser()
	local bExist = false;
	for row in  db:rows("select * from GameRecord") do
		bExist = true;
		break;
	end
	
	local time = GameData.timer;	
	if(time<0) then
		time = 0;
	end
	
	local volume = math.floor(GameData.volume*100);
	
	local sql = "";
	if(bExist == true) then
		sql = "update GameRecord set currentuser='"..GameData.currentuser.."', volume="..volume..", mode="..GAME_MODE..", bonus="..GameData.bonus..", maxhitcnt="..GameData.maxhitcnt..", level="..GameData.level..", withdrawcnt="..GameData.withdrawcnt..", time="..time.." ,buy="..GameData.buy.." ,rank="..GameData.rank.." ,givestar="..GameData.givestar;
	else
		sql = "insert into GameRecord(currentuser,volume,mode,bonus,maxhitcnt,level,withdrawcnt,time,buy,rank,givestar) VALUES('"..GameData.currentuser.."', "..volume..","..GAME_MODE..", "..GameData.bonus..", "..GameData.maxhitcnt..", "..GameData.level..", "..GameData.withdrawcnt..","..time..","..GameData.buy..","..GameData.rank..","..GameData.givestar..")";
	end
	
	--LXZMessageBox(sql);
	db:exec(sql);
end

--	bonus,maxhitcnt,level,withdrawcnt
function LoadDBCurrentUser()

	for row in  db:rows("select * from GameRecord") do
		LXZMessageBox("row:currentuser:"..row.currentuser);
		GameData.currentuser = row.currentuser;
		GameData.volume = row.volume/100;
		GameData.bonus = row.bonus;
		GameData.maxhitcnt=row.maxhitcnt;
		GameData.level = row.level;
		GameData.selectlevel = row.level;
		GameData.withdrawcnt=row.withdrawcnt;
		GameData.timer = row.time;
		GameData.buy = row.buy;
		GameData.rank = row.rank;
		GameData.givestar = row.givestar;
		GAME_MODE = row.mode;
		if(GameData.level==0) then
			GameData.level = 1;
		end
		
		if(GameData.buy==2) then
			GameData.buy = 0;
		end
		
		--LXZMessageBox("volume:"..row.volume.." currentuser:"..row.currentuser.." GAME_MODE:"..row.mode);
		break;
	end
	
	
end

function GetSumOfAllScores()
	for row in  db:rows("select sum(highscore) as total from UserGameRecord ".." WHERE name ='"..GameData.currentuser.."'") do
		--LXZMessageBox("sum:"..row.total);
		return row.total;
	end
	
	return 0;
end

function SaveDB(level, score)
	local bExist = false;
	local highscore = -1;
	for row in db:rows("select * from UserGameRecord where name ='"..GameData.currentuser.."' and level="..level.." and mode="..GAME_MODE) do
		bExist = true;
		highscore = row.highscore;
		break;
	end
	
	if(highscore>=score) then
		return;
	end
	
	local sql = "";
	if(bExist == true) then
		sql = "UPDATE UserGameRecord SET highscore="..score.." WHERE name ='"..GameData.currentuser.."' AND level="..level.." AND mode="..GAME_MODE;
	else
		sql = "insert into UserGameRecord(name,highscore,level,mode) VALUES('"..GameData.currentuser.."',"..score..","..level..","..GAME_MODE..")";
	end
	
	--LXZMessageBox(sql);
	local d, err = db:exec(sql);
	if(d==nil) then
		--LXZMessageBox("sql:"..sql.." err:"..err);
		--ShowTipMessage(err);	
	end
	
	--ShowTipMessage("SaveDB:"..score.." level:"..level.." user:"..GameData.currentuser);	
		
end

function LoadDB()

	-- high level
	GameData.highlevel = 1;
	local sql = "select * from UserGameRecord where name ='"..GameData.currentuser.."' and mode="..GAME_MODE.." order by level DESC limit 1";
	local rows = db:rows(sql);
	if(rows==nil) then
		--GameData.highlevel = 1;
		return;
	end
	
	for row in  rows do
		--GameData.highscore = row.highscore;
		GameData.highlevel = row.level;
		--LXZMessageBox("highlevel="..row.level.." mode="..GAME_MODE);
		break;
	end
	
	--high score
	local sql = "select * from UserGameRecord where name ='"..GameData.currentuser.."' order by highscore DESC limit 1";
	local rows = db:rows(sql);
	for row in  rows do
		--GameData.highscore = row.highscore;
		GameData._highscore = row.highscore;
		break;
	end
	
	
end



function LoadLevelHighScore(level)
	local sql = "select * from UserGameRecord where name ='"..GameData.currentuser.."' and level="..level.." and mode="..GAME_MODE;
	local rows,err = db:rows(sql);
	if(rows == nil) then
		--LXZMessageBox("name:"..GameData.currentuser.." level:"..level.." mode:"..GAME_MODE.." err:"..err);			
		--LXZMessageBox("sql:"..sql.." err:"..err);
		ShowTipMessage(err);	
		return 0;
	end
	
	for row in  rows do		
		--LXZMessageBox("name:"..GameData.currentuser.." level:"..level.." highscore:"..row.highscore);
		--ShowTipMessage("highscore:"..row.highscore);	
		return row.highscore;		
	end
	
	--LXZMessageBox("sql:"..sql);
	--ShowTipMessage("LoadLevelHighScore:"..level.." user:"..GameData.currentuser);	
	return 0;
end

function HelperSetWindowControlColor(wnd, r, g, b, a)
	local render = wnd:GetRender("Rectangle");
	if(render ~= nil) then
		RenderRefRectLogic.color = render:GetAttributeNameRef("Rect:FillColor", RenderRefRectLogic.color);
		local addr = render:GetAddress(RenderRefRectLogic.color);
		local rgba = tousertype(addr, "RGBA");
		rgba.red = r;
		rgba.alpha = a;
		rgba.blue = b;
		rgba.green = g;
	--	LXZMessageBox("Name:"..wnd:GetName().." r:"..r.." g:"..g.." b:"..b.." a:"..a);
	end
end

function HelperShow(name,bShow)
	local root = HelperGetRoot();
	if(bShow==true) then
		root:GetChild(name):Show();
	else
		root:GetChild(name):Hide();
	end
end

function HelperSetWindowTextScale(wnd, scale)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.scale = render:GetAttributeNameRef("EditBox:fScale", RenderRefEditBoxLogic.scale);
		render:SetAttribute(RenderRefEditBoxLogic.scale, scale);
	end
end

function HelperGetWindowTextLineCount(wnd)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.linecount = render:GetAttributeNameRef("EditBox:lineCount", RenderRefEditBoxLogic.linecount);
		return tonumber(render:GetAttribute(RenderRefEditBoxLogic.linecount));
	end
end

function HelperSetWindowText(wnd, text)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.text = render:GetAttributeNameRef("EditBox:Text", RenderRefEditBoxLogic.text);
		render:SetAttribute(RenderRefEditBoxLogic.text, text);
	end
end

function HelperSetWindowTextFont(wnd, fnt)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.font = render:GetAttributeNameRef("EditBox:FontFile", RenderRefEditBoxLogic.font);
		render:SetAttribute(RenderRefEditBoxLogic.font, fnt);
	end
end

function HelperGetWindowTextFont(wnd)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.font = render:GetAttributeNameRef("EditBox:FontFile", RenderRefEditBoxLogic.font);
		return render:GetAttribute(RenderRefEditBoxLogic.font);
	end
	
	return "";
end

function HelperSetParticleEmission(wnd, cnt)
	local render = wnd:GetRender("Particle");
	if(render ~= nil) then
		RenderRefParticleLogic.nEmission = render:GetAttributeNameRef("Particle:Info:nEmission", RenderRefParticleLogic.nEmission);				
		render:SetAttribute(RenderRefParticleLogic.nEmission, tostring(cnt));	
	end
end

function HelperSetWindowSpeed(wnd, speed)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.Speed = render:GetAttributeNameRef("MoveLogic:Speed", RenderRefMoveLogic.Speed);				
		render:SetAttribute(RenderRefMoveLogic.Speed, tostring(speed));	
	end
end

function HelperGetWindowSpeed(wnd)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.Speed = render:GetAttributeNameRef("MoveLogic:Speed", RenderRefMoveLogic.Speed);				
		return tonumber(render:GetAttribute(RenderRefMoveLogic.Speed));	
	end
	
	return 0;
end

--加速度
function HelperSetWindowAccelerate(wnd, acc)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.AccSpeed = render:GetAttributeNameRef("MoveLogic:AccSpeed", RenderRefMoveLogic.AccSpeed);				
		render:SetAttribute(RenderRefMoveLogic.AccSpeed, tostring(acc));	
	end
end

function HelperGetWindowAccelerate(wnd)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.AccSpeed = render:GetAttributeNameRef("MoveLogic:AccSpeed", RenderRefMoveLogic.AccSpeed);				
		return tonumber(render:GetAttribute(RenderRefMoveLogic.Speed));	
	end
	
	return 0;
end

function HelperSetWindowMoveTarget(wnd, tox, toy)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.MovePtList = render:GetAttributeNameRef("MoveLogic:Move:PtList", RenderRefMoveLogic.MovePtList);
				
		local address = render:GetAddress(RenderRefMoveLogic.MovePtList);
		local ptlist = tousertype(address, "LXZPointList");

		local pt = LXZPoint:new_local();
		wnd:GetHotPos(pt);
		ptlist:clear();
		ptlist:push_back(pt);
		
		pt.x = tox;
		pt.y = toy;
		ptlist:push_back(pt);
	end
	
end

function HelperAddWindowMoveTarget(wnd, tox, toy, speed, acc)
	local render = wnd:GetRender("MoveLogic");
	if(render ~= nil) then
		RenderRefMoveLogic.MovePtList = render:GetAttributeNameRef("MoveLogic:Move:PtList", RenderRefMoveLogic.MovePtList);
				
		local address = render:GetAddress(RenderRefMoveLogic.MovePtList);
		local ptlist = tousertype(address, "LXZPointList");

		local pt = LXZPoint:new_local();
		pt.x = tox;
		pt.y = toy;
		ptlist:push_back(pt);
		
		HelperSetWindowSpeed(wnd, tostring(speed));
		HelperSetWindowAccelerate(wnd, tostring(acc));
	end
	
end



function HelperWindowMoveTo(wnd, tox, toy, speed, acc)
			
		HelperSetWindowMoveTarget(wnd, tox, toy);
		HelperSetWindowSpeed(wnd, tostring(speed));
		HelperSetWindowAccelerate(wnd, tostring(acc));
		
		local msg  = CLXZMessage:new_local();
		wnd:ProcMessage("OnStartMove",  msg, wnd);

end

function HelperSetWindowTextColor(wnd, r, g, b, a)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.textcolor = render:GetAttributeNameRef("EditBox:normalTextColour", RenderRefEditBoxLogic.textcolor);
		local addr = render:GetAddress(RenderRefEditBoxLogic.textcolor);
		local rgba = tousertype(addr, "RGBA");
		rgba.red = r;
		rgba.alpha = a;
		rgba.blue = b;
		rgba.green = g;
	end
end

function HelperGetWindowTextColor(wnd)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.textcolor = render:GetAttributeNameRef("EditBox:normalTextColour", RenderRefEditBoxLogic.textcolor);
		local addr = render:GetAddress(RenderRefEditBoxLogic.textcolor);
		local rgba = tousertype(addr, "RGBA");
		return 	rgba.red,rgba.green, rgba.blue, rgba.alpha;		
	end
end

function HelperGetWindowTextPosX(wnd)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.textx = render:GetAttributeNameRef("EditBox:HorzScrollBar:ScrollInfo:Pos", RenderRefEditBoxLogic.textx);
		return tonumber(render:GetAttribute(RenderRefEditBoxLogic.textx, textx));
	end
	
	return 0;
end

function HelperSetWindowTextPosX(wnd, x)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.textx = render:GetAttributeNameRef("EditBox:HorzScrollBar:ScrollInfo:Pos", RenderRefEditBoxLogic.textx);
		render:SetAttribute(RenderRefEditBoxLogic.textx, tostring(x));	
	end
	
	return 0;
end


function HelperGetWindowTextPosY(wnd)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.texty = render:GetAttributeNameRef("EditBox:VertScrollBar:ScrollInfo:Pos", RenderRefEditBoxLogic.texty);
		return tonumber(render:GetAttribute(RenderRefEditBoxLogic.texty, texty));		
	end
	
	return 0;
end

function HelperSetWindowTextPosY(wnd, y)
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.texty = render:GetAttributeNameRef("EditBox:VertScrollBar:ScrollInfo:Pos", RenderRefEditBoxLogic.texty);
		render:SetAttribute(RenderRefEditBoxLogic.texty, tostring(y));	
		--LXZMessageBox("texty:"..y);
	end
end


function HelperGetWindowText(wnd)
	--LXZMessageBox("HelperGetWindowText");
	local render = wnd:GetRender("EditBox");
	if(render ~= nil) then
		RenderRefEditBoxLogic.text = render:GetAttributeNameRef("EditBox:Text", RenderRefEditBoxLogic.text);
		return render:GetAttribute(RenderRefEditBoxLogic.text, text);
	end

end

function HelperGetRoot()
	local winmgr = CLXZWindowMgr:Instance();
	local wnd =  winmgr:GetRoot();
	return wnd;
end

local corecfg = ICGuiGetLXZCoreCfg();




function GetPosByRowCol(row, col)
		local x = 10+col*GRID_WIDTH+GRID_WIDTH/2+OFFSET_X;
		local y = row*GRID_WIDTH+GRID_WIDTH/2+OFFSET_Y;
		return x*GameData.scale,y*GameData.scale;
end

function GetRowColByPos(x, y)
	--x = x/GameData.scale;
	--y = y/GameData.scale;
	local row = math.floor((y-OFFSET_Y*GameData.scale)/(GRID_WIDTH*GameData.scale));
	local col  = math.floor((x-OFFSET_X)/(GRID_WIDTH*GameData.scale));
	return row, col;	
end

function IsInArray(a, intarr)
	for i = 0, intarr:size()-1,1 do
		if(intarr:get(i)==a) then
			return true;
		end
	end
			
	return false;
end

local function IsValidateRowCol(main, r, c)
	if(r >=MAX_ROW or r<1) then
		return false;
	end
	
	if( c>=MAX_COL or c<1) then
		return false;
	end
		
	if (main:GetChild(c.."|"..r) ~= nil) then
		return false;
	end
	
	return true;	
end

function GetNextRowCol(main, r, c) 
		
	local intarr = IntArray:new_local();		
	if(IsValidateRowCol(main, r, c+1)==true) then
		intarr:push(GetIndexByRowCol(r, c+1));
	end
		
	if(IsValidateRowCol(main, r, c-1)==true) then
		intarr:push(GetIndexByRowCol(r, c-1));
	end
	
	if(IsValidateRowCol(main, r+1, c)==true) then
		intarr:push(GetIndexByRowCol(r+1, c));
	end
	
	if(IsValidateRowCol(main, r-1, c)==true) then
		intarr:push(GetIndexByRowCol(r-1, c));
	end
	
	--if(intarr:size() == 0) then
	--	LXZMessageBox("GetNextRowCol r:"..r.." c:"..c.." max row:"..MAX_ROW);
--	end
	if(intarr:size()==0) then
		return 
	end
	
	
	local i = math.random(1, intarr:size());
	local index = intarr:get(i-1);
	
	return GetRowColByIndex(index);
end

function CreateGameBackground()
	local pt = LXZPoint:new_local();
	local root = HelperGetRoot();
	
	--
	local wnd = root:GetLXZWindow("Game:background");
	
--	wnd:ClearChilds();
	if(wnd:GetFirstChild()==nil) then
		for row=0,MAX_ROW-1,1 do
			for col=0,MAX_COL-1,1 do
				pt.x, pt.y = GetPosByRowCol(row, col);
				local e = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Elementbk");
				e.update = nil;
				wnd:AddChild(e);
				e:SetHotPos(pt);
				e:SetName(col.."|"..row);		
			--	HelperSetWindowPicture(e, "elementbkbk");
			end
		end		
	end
	
end

function LoadGameLevel(newdataname, olddataname, main)
	local pt = LXZPoint:new_local();
	local root = HelperGetRoot();
	local control = root:GetLXZWindow("Game:control");
	main:ClearChilds();
	control:ClearChilds();
	--GameData.actionlist = {};
	
	--
	CreateGameBackground();
	
	--
--	if(IS_MAKE_GAME ~=0) then
--		return false;
--	end
	
	local str = LXZAPI_GetFileContent(newdataname);
	if(str ~= nil) then
		local lvltbl = json.decode(str);
		for i = 1, table.getn(lvltbl),1 do 
			local e = lvltbl[i];
			pt.x,pt.y = GetPosByRowCol(e.row, e.col);
			
			local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:"..e.class);
			wnd.update = nil;
			main:AddChild(wnd);
			HelperSetWindowText(wnd, e.text);
			wnd:SetHotPos(pt);
			wnd:SetName(e.col.."|"..e.row);				
			HelperSetWindowTextFont(wnd, e.fnt);
			
		end
		
		return true;		
	else
		local filename = olddataname;
		control:DelBit(STATUS_IsNotSerialChild);
		local ret = control:LoadChildsFromFile(filename, nil);
		control:SetBit(STATUS_IsNotSerialChild);
		if(ret==true) then
			local wnd = control:GetFirstChild();
			while(wnd ~= nil) do
					local row, col =GetRowColByWnd(wnd);
					pt.x, pt.y = GetPosByRowCol(row, col);

					--pt.y = pt.y-200;
					--wnd:SetHotPos(pt);
					--HelperWindowMoveTo(wnd, pt.x, pt.y+200, 50+(pt.y+200)*0.5,  50);
					local window = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:"..wnd:GetClassName());
					window.update = nil;
					main:AddChild(window);
					local text = HelperGetWindowText(wnd);
					HelperSetWindowText(window, text);
					window:SetHotPos(pt);
					window:SetName(col.."|"..row);			
			
					local fnt = HelperGetWindowTextFont(wnd);
					HelperSetWindowTextFont(window, fnt);
										
					wnd = wnd:GetNextSibling();
			end
			
			control:ClearChilds();
			return true;
		end
		
		control:ClearChilds();
	end
	
	return false;
end

local function CreateCoins(max, mustnew)

	local pt = LXZPoint:new_local();
	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	main:ClearChilds();
	
	--
	if(mustnew == nil) then
		if(DATA_LEVEL==DATA_LEVEL_LOCAL) then
			--
			if(LoadGameLevel(GameCfg[GameData.level].data..".nlv", GameCfg[GameData.level].data..".lvl", main)==true) then
				IS_ANIMATE_START = true;
				EffectAnitmateGameStart();
				return;
			end
			
		elseif (DATA_LEVEL==DATA_LEVEL_NET) then
			DowndLoadFile("tmplvl.dat", GameCfg[GameData.level].data..".lvl", function(urlresponse)
				local filename = nil;
				if(urlresponse.IsSuccess == 1) then	
					filename = LXZAPIGetWritePath().."tmplvl.dat";						
				else --no file
					filename = LXZAPIGetWritePath()..GameCfg[GameData.level].data..".lvl";						
				end
				
				main:DelBit(STATUS_IsNotSerialChild);
				local ret = main:LoadChildsFromFile(filename, nil);
				main:SetBit(STATUS_IsNotSerialChild);
				if(ret==true) then
					IS_ANIMATE_START = true;
					EffectAnitmateGameStart();
					return;
				end	
				
				CreateCoins(max, true);
				
			end, false);
			
			return;		
		end
	end
	
	-- target
	local mm = 5;
	local offsetmin =  1;
	if(max<5) then
		mm = max;
		offsetmin = 1;
	else
		offsetmin = math.random(1, max-mm);
	end
	
	local targetarray = IntArray:new_local();	
	local offsetmax = offsetmin+mm-1;
	
	local r = math.random(2,MAX_ROW-1);
	local c = math.random(2,MAX_COL-1);
	for tar = offsetmin, offsetmax, 1 do			
			local index = GetIndexByRowCol(r,c);
			pt.x, pt.y = GetPosByRowCol(r, c);
			targetarray:push(index);			
			local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
			main:AddChild(wnd);
			HelperSetWindowText(wnd, tostring(tar));
			wnd:SetHotPos(pt);
			wnd:SetName(c.."|"..r);		
			wnd.update = nil;
			--HelperSetWindowTextColor(wnd, 0, 255, 255, 255);
			HelperSetWindowTextFont(wnd, "yellownum.fnt");
			
			r,c = GetNextRowCol(main, r,c);		
			if(r == nil or c==nil) then
				break;
			end			
	end
	
	
	
	--
	math.randomseed(os.clock());
	
	local nMax = MAX_ROW*MAX_COL;
	local avg    = nMax/max;
	if(avg<1) then
		avg = 1;	
	end
	
	avg = math.floor(avg);
		
	local intarr = IntArray:new_local();
	for i = 1, max, 1 do
		for c=1,avg,1 do
			intarr:push(i);
		end
	end
	
	for i = max*avg, nMax, 1 do
		intarr:push(1);
	end
	
	--
	for row  = 0, MAX_ROW-1,1 do 
		for col= 0,MAX_COL-1,1 do
		--local row = math.floor(i/MAX_COL);
		--local col  = math.mod(i,MAX_COL);		
			pt.x, pt.y = GetPosByRowCol(row, col);
			local grid = GetIndexByRowCol(row,col);
			if(IsInArray(grid, targetarray) == false) then
							
				local index = math.random(1,intarr:size());
				local num = intarr:get(index-1);
				intarr:erase(index-1, false);
				
				pt.y = pt.y-200;				
				
				local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
				main:AddChild(wnd);
				HelperSetWindowText(wnd, tostring(num));
				wnd:SetHotPos(pt);
				wnd:SetName(col.."|"..row);
				wnd.update = nil;
				
				--HelperWindowMoveTo(wnd, pt.x, pt.y+200, 50+row*10,  50);
			end
		end
	end
	
	IS_ANIMATE_START = true;
	EffectAnitmateGameStart();

end

function HideGameHeadWindow()
	local root = HelperGetRoot();
	local wnd = root:GetChild("Game");
	
	wnd:GetChild("highscore"):Hide();
	wnd:GetChild("highscoretitle"):Hide();
	wnd:GetChild("state"):Hide();
	wnd:GetChild("stagetitle"):Hide();
	wnd:GetChild("targettitle"):Hide();
	wnd:GetChild("target"):Hide();
	wnd:GetChild("scoretitle"):Hide();
	wnd:GetChild("score"):Hide();
	
	wnd:GetChild("scoretitle"):Hide();
	wnd:GetChild("score"):Hide();
	
	wnd:GetChild("timertitle"):Hide();
	wnd:GetChild("timer"):Hide();
	
	wnd:GetChild("helpbtn"):Hide();
	wnd:GetChild("pause"):Hide();
	wnd:GetChild("elementbtn"):Hide();
	wnd:GetChild("list"):Hide();
	wnd:GetChild("withdrawbtn"):Hide();
	wnd:GetChild("background"):Hide();
	wnd:GetChild("helptips"):Hide();
	wnd:GetChild("bonustips"):Hide();
	
end

function ShowGameHeadWindow()
	local root = HelperGetRoot();
	local wnd = root:GetChild("Game");
	
	wnd:GetChild("highscore"):Show();
	wnd:GetChild("highscoretitle"):Show();
	wnd:GetChild("state"):Show();
	wnd:GetChild("stagetitle"):Show();
	wnd:GetChild("targettitle"):Show();
	wnd:GetChild("target"):Show();
	wnd:GetChild("scoretitle"):Show();
	wnd:GetChild("score"):Show();
	
	wnd:GetChild("scoretitle"):Show();
	wnd:GetChild("score"):Show();
	
	wnd:GetChild("timertitle"):Show();
	wnd:GetChild("timer"):Show();
	
	wnd:GetChild("helpbtn"):Show();
	wnd:GetChild("pause"):Show();
	--wnd:GetChild("elementbtn"):Show();
	wnd:GetChild("list"):Show();
	wnd:GetChild("withdrawbtn"):Show();
	wnd:GetChild("background"):Show();
	wnd:GetChild("main"):Show();
	wnd:GetChild("main"):Show();
	
end

function GetMaxCoin(level)
	if(GAME_MODE==GAME_MODE_COMBO) then
		return GameCfg[level].maxcoin2;
	end
	
	return GameCfg[level].maxcoin;
end

function UpdateDataToUI()

	local level    = GameData.level;
	local max    = GetMaxCoin(GameData.level);
	local target = GetWinCoin();
	local hitcnt = GameCfg[GameData.level].maxhitcnt;
	
	local root = HelperGetRoot();	
	HelperSetWindowText(root:GetLXZWindow("Game:state"), tostring(level));
	HelperSetWindowText(root:GetLXZWindow("Game:target"), tostring(target));
	
	--revise bug
	if(GameData.withdrawcnt == nil) then
		GameData.withdrawcnt = 0;
	end
	
	if(GameData.rank>=1) then
		HelperSetWindowText(root:GetLXZWindow("Game:highscore"), tostring(GameData.rank));
	else
		HelperSetWindowText(root:GetLXZWindow("Game:highscore"), "");
	end
	
	HelperSetWindowText(root:GetLXZWindow("Game:score"), tostring(GameData.bonus));
	HelperSetWindowText(root:GetLXZWindow("Game:withdrawbtn"), tostring(GameData.withdrawcnt));
	if(GameData.state == STATE_NULL) then
		--root:GetLXZWindow("Game:withdrawbtn"):Hide();
		root:GetLXZWindow("Game:elementbtn"):Hide();
	else
		root:GetLXZWindow("Game:withdrawbtn"):Show();				
	end	
	
	UpdateEditUI();
	
end

function StartGame(level)

	--
	os.remove(LXZAPIGetWritePath().."record.nda");	
	
	ShowGameHeadWindow();

	--
	GameData.state = STATE_READY;
	GameData.time  = os.time()+2;
	if(GAME_MODE==GAME_MODE_COMBO) then
		GameData.timer = 0;
	else
		GameData.timer = GameCfg[level].timer;
	end
	
	GameData.actionlist = {};
	
	--clear
	GameData.selectlevel = level;
	GameData.highscore = LoadLevelHighScore(level);
	GameData.oldhighscore = GameData.highscore;	
	GameData.bonus = 0;
	GameData.maxhitcnt = 0;
	GameData.prevlevel = GameData.level;
	GameData.level = level;
	if(GameData.level>GameData.highlevel) then
		GameData.highlevel = GameData.level;
	end
	
	--
	local root = HelperGetRoot();
	if(GameData.level>=10 and IS_MAKE_GAME==0) then
		HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 192, 192, 192, 255);		
		root:GetLXZWindow("Game:helpbtn"):SetBit(STATUS_IsDisable);
	else
		HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 255, 255, 255, 255);	
		root:GetLXZWindow("Game:helpbtn"):DelBit(STATUS_IsDisable);
	end
	
	--
	--
	root:GetLXZWindow("Game:win"):Hide();
	root:GetLXZWindow("Game:fail"):Hide();
	root:GetLXZWindow("Game:main"):Show();
		
	--
	local max = GetMaxCoin(GameData.level); --GameCfg[GameData.level].maxcoin;
	local target = GameCfg[GameData.level].wincoin;
	CreateCoins(max);
	GameData.withdrawcnt = 20;
	
	--
	--LXZMessageBox("OnMenuNewGame");
	HelperShow("Menu", false);
			
	--
	UpdateDataToUI();
	
	--
	
end



function xxxURLResponeFunc(urlresponse)
	--LXZMessageBox(urlresponse:getResponseData());
	--local obj = json.decode(urlresponse:getResponseData());
	--LXZMessageBox("timestamp:"..obj["timestamp"].." mc:"..obj["mc"]);	
end

function xxxOnSystemNotify(token, param)
	if(token == "GameCenterUser") then
		GameData.currentuser = param;
		LoadDB();
		UpdateDataToUI();
		SaveDBCurrentUser();
		--LXZAPI_CallSystemAPI("RestorePurchase", "");
		--ShowTipMessage("welcome "..param);
	elseif(token == "LocalUserRank") then
		GameData.rank = tonumber(param);
		UpdateDataToUI();
		SaveDBCurrentUser();
	elseif(token=="ActiveGameStageOk") then
		GameData.buy = 1;
		ShowTipMessage("Success");
		UpdateStageUI();
	elseif(token=="ActiveGameStageFail") then
		ShowTipMessage("Buy failed"..param);
	elseif(token=="PurchasePrice") then
		local root  = HelperGetRoot();
		GameData.price = tonumber(param);
		--LXZAPI_CallSystemAPI("RestorePurchase", "");
	elseif(token=="PurchaseStatus") then
		ShowTipMessage("You are disable in-app purchase!");
	end
end

LXZAPI_HookSystemNotify("xxxOnSystemNotify");

local function OnBuyStage(window, msg0, sender)
	LXZAPI_CallSystemAPI("BuyGameStage", "");
end

local function OnNewGame(window, msg0, sender)
	StartGame(1);	
	
	--测试代码
	--[[local urlrequest = _urlRequest:new();
	urlrequest.url = "http://192.168.233.131/api";
	urlrequest.nRequestType = eRequestGet;
	
	local curl = CLXZCurl:Instance();
	curl:send(urlrequest);--]]
	
end

local function OnRestore(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MessageBox");
	EffectNormalButton(wnd:GetChild("restorebtn"), function()	
		LXZAPI_CallSystemAPI("RestorePurchase", "");
		wnd:Hide();
	end, true);
	
	
end

local function OnRanking(window, msg0, sender)
	--LXZMessageBox("OnRanking");
	--HelperShow("Menu",false);
	local root = HelperGetRoot();
	EffectNormalButton(root:GetLXZWindow("Menu:Ranking"), function() 
--	EffectAnimateMenuHide("Ranking", function()
		local ret = LXZAPI_CallSystemAPI("OnRanking", "");	
	end);	
end

local function OnExit(window, msg0, sender)
	local root  = HelperGetRoot();					
	EffectNormalButton(sender,function ()						
		root:GetLXZWindow("Game:win"):Hide();
		root:GetLXZWindow("Game:fail"):Hide();
		ShowGameHeadWindow();		
	end);
end


local function OnNextLevel(window, msg0, sender)
	local root  = HelperGetRoot();					
	
	--[[if(GameData.level==22 and GameData.givestar==0)  then	
		--
		ShowMsgBox("we need your rate, ok?", function(param) 
													LXZAPI_CallSystemAPI("RequestGiveStar", "");
													GameData.givestar=1;
													SaveDBCurrentUser();
													ShowTipMessage("thanks");
													end,
													nil,
													function(param) ShowTipMessage("thanks"); end,
													nil);																

		return;
	end--]]
	
	EffectNormalButton(root:GetLXZWindow("Game:win:nextstagebtn"),function ()			
	--[[	if(GameData.level<table.getn(GameCfg)) then
			if(GameData.buy==0 and GameData.level>=19) then
				ShowMessageBox("Do you confirm to buy or restore 19-45 game stage?", function(param) 
												LXZAPI_CallSystemAPI("BuyGameStage", "");
												GameData.buy=2;
												ShowTipMessage("ok");
												end,
												nil,
												function(param) ShowTipMessage("cancel"); end,
												nil);			
				return;
				
			elseif(GameData.buy==2 and GameData.level>=19) then
				ShowTipMessage("Buy:"..GameData.buy.." level:"..GameData.level);
				return;
			end--]]
						
			StartGame(GameData.level+1);
		--end
		--LXZMessageBox("OnNextLevel");
		SaveDB(GameData.highlevel, GameData.highscore);
	end);
	
	--LXZMessageBox("SaveDB level:"..GameData.highlevel.." score :"..GameData.highscore);
end

tblWndPictureFile["Continue"]={"game1.png", "game2.png"};
tblWndPictureFile["ScoreMode"]={"game1.png", "game2.png"};
tblWndPictureFile["ComboMode"]={"game1.png", "game2.png"};
tblWndPictureFile["Ranking"]={"game1.png", "game2.png"};
tblWndPictureFile["Option"]={"game5.png", "game5.png"};

local function OnMenuDown(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Menu");
	
	--
	--HelperSetWindowPictureFile(wnd:GetChild("NewGame"), "game1.png");
	--HelperSetWindowPicture(wnd:GetChild("NewGame"), "newgamebtn");
	
	HelperSetWindowPictureFile(wnd:GetChild("Continue"), "game1.png");
	HelperSetWindowPicture(wnd:GetChild("Continue"), "resumebtn");
	
	HelperSetWindowPictureFile(wnd:GetChild("ScoreMode"), "game1.png");
	HelperSetWindowPicture(wnd:GetChild("ScoreMode"), "scoremodebtn");
	
	HelperSetWindowPictureFile(wnd:GetChild("ComboMode"), "game1.png");
	HelperSetWindowPicture(wnd:GetChild("ComboMode"), "combomodebtn");
	
	HelperSetWindowPictureFile(wnd:GetChild("Ranking"), "game1.png");
	HelperSetWindowPicture(wnd:GetChild("Ranking"), "ranking");
	
	HelperSetWindowPictureFile(wnd:GetChild("Option"), "game5.png");
	HelperSetWindowPicture(wnd:GetChild("Option"), "optionbkup");
	
	--	
	if(sender == wnd:GetChild("Option")) then		
		HelperSetWindowPictureFile(sender, "game5.png");
		HelperSetWindowPicture(wnd:GetChild("Option"), "optionbkdown");
	end
	
	if(sender == wnd:GetChild("Continue")) then		
		HelperSetWindowPictureFile(sender, "game2.png");
		HelperSetWindowPicture(wnd:GetChild("Continue"), "resumebtndown");
	end
	
	if(sender == wnd:GetChild("ScoreMode")) then		
		HelperSetWindowPictureFile(sender, "game2.png");
		HelperSetWindowPicture(wnd:GetChild("ScoreMode"), "scoremodebtndown");
	end
	
	if(sender == wnd:GetChild("ComboMode")) then		
		HelperSetWindowPictureFile(sender, "game2.png");
		HelperSetWindowPicture(wnd:GetChild("ComboMode"), "combomodebtndown");
	end
	
	if(sender == wnd:GetChild("Ranking")) then		
		HelperSetWindowPictureFile(sender, "game2.png");
		HelperSetWindowPicture(wnd:GetChild("Ranking"), "rankingbtndown");
	end
	
	--
	if(sender:GetName()=="exitbtn") then
		HelperSetWindowPictureFile(sender, "game3.png");
		HelperSetWindowPicture(sender, "exitbtndown");
	end
	
	if(sender:GetName()=="nextstagebtn") then
		HelperSetWindowPictureFile(sender, "game3.png");
		HelperSetWindowPicture(sender, "nextstagebtndown");
	end
	
	if(sender:GetName()=="replaybtn") then
		HelperSetWindowPictureFile(sender, "game3.png");
		HelperSetWindowPicture(sender, "replaybtndown");
	end
	
	--PlayEffect("menu.wav");
end

local function OnPause(window, msg0, sender)
	--HelperShow("Menu",true);
	local root = HelperGetRoot();
	
	EffectCircleButtonNoSound(root:GetLXZWindow("Game:pause"), function()
	
		local wnd = root:GetLXZWindow("Menu");
		
		--HelperSetWindowPictureFile(wnd:GetChild("NewGame"), "game1.png");
		--HelperSetWindowPicture(wnd:GetChild("NewGame"), "newgamebtn");
		
		HelperSetWindowPictureFile(wnd:GetChild("Continue"), "game1.png");
		HelperSetWindowPicture(wnd:GetChild("Continue"), "resumebtn");
		
		HelperSetWindowPictureFile(wnd:GetChild("ScoreMode"), "game1.png");
		HelperSetWindowPicture(wnd:GetChild("ScoreMode"), "scoremodebtn");
		
		HelperSetWindowPictureFile(wnd:GetChild("ComboMode"), "game1.png");
		HelperSetWindowPicture(wnd:GetChild("ComboMode"), "combomodebtn");
		
		HelperSetWindowPictureFile(wnd:GetChild("Ranking"), "game1.png");
		HelperSetWindowPicture(wnd:GetChild("Ranking"), "ranking");
			
		--PlayEffect("menu.wav");
		EffectAnimateMenuShow();	
	end);
	
	GameData.oldstate = GameData.state;
	GameData.state = STATE_PAUSE;	
end

local function OnUnload(window, msg0, sender)
	local path = LXZAPIGetWritePath();
	local name = "record.nda";
	local filename = path..name;
	local root = HelperGetRoot();
	
	local win = root:GetLXZWindow("Game:win");
	local fail = root:GetLXZWindow("Game:fail");
	
	local iscompleted = false;
	if(win:IsVisible()==true or fail:IsVisible()==true) then
		iscompleted = true;
	end
	
	local wnd = root:GetLXZWindow("Game:main");
	if(GameData.state == STATE_RUN and iscompleted==false) then
		SaveChildrens(wnd, name);
	else
		os.remove(filename);
	end
	
	SaveDBCurrentUser();

end

local function OnLXZResume(window, msg0, sender)
	if(GameData.state == GAME_RUN) then
		local root = HelperGetRoot();
		 root:GetChild("LevelSets"):Hide();
		 root:GetChild("option"):Hide();
		 root:GetChild("MessageBox"):Hide();
		 root:GetChild("Help"):Hide();
		 if(root:GetLXZWindow("Game:help")~=nil) then
			root:GetLXZWindow("Game:help"):Hide();
		 end
		 
		 --
		 root:GetChild("Load"):Show();
	end
	
	--下载更新文件
	HelperDowndLoadFile("1.lu", "engulf_updatev1.lua", function(urlresponse)
	if(urlresponse.IsSuccess==1) then
			LXZDoFile("engulf_updatev1.lua");
		end	
	end, 
	true);
end

function EffectAnimateNum(wnd, text, thread1,interval)
	
	local nnstr = "";
	local newtext = "";	
	local co = coroutine.create(function (thread)
		HelperSetWindowText(wnd, "");
		if(interval==nil) then
			interval = 35;
		end
				
		for i = 1, string.len(text),1 do
			local time = 0;
			while(1) do			
				AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+interval}, thread);
				coroutine.yield();
				PlayEffect("click.wav");
				
				local num = tonumber(string.char(string.byte(text, i)));
				local nn  = math.random(0,9);
				time = time+interval;
				if(time>=200) then
					nn=num;
				end
				
				if(num==nn) then
					nnstr = nnstr..nn;	
					newtext = nnstr;
					for k=i+1,string.len(text),1 do
						local kn = tonumber(string.char(string.byte(text, i)));
						newtext = newtext..math.random(0,kn);
					end
					HelperSetWindowText(wnd, newtext);
					break;
				else
					newtext = nnstr..nn;
					for k=i+1,string.len(text),1 do
						local kn = tonumber(string.char(string.byte(text, i)));
						newtext = newtext..math.random(0,kn);
					end
					HelperSetWindowText(wnd, newtext);
				end				
			end			
			--LXZAPI_OutputDebugStr("newtext:"..newtext);
		end
		
		if(thread1 ~= nil) then
			coroutine.resume(thread1);	
		end
		
	end);	
	coroutine.resume(co, co);	

end


function EffectAnimateNum1(wnd, text, thread1,interval)
	
	local oldtext = HelperGetWindowText(wnd);
	local nnstr = "";
	local newtext = "";	
	local co = coroutine.create(function (thread)
		HelperSetWindowText(wnd, "");
		if(interval==nil) then
			interval = 35;
		end
		
		local len = string.len(text);				
		local oldlen = string.len(oldtext);				
		for i = 1, len,1 do
			
			local kk = 1;
			local index = i-len+oldlen;
			if(index>0) then
				kk = tonumber(string.char(string.byte(oldtext, index)));				
			end			
			--LXZMessageBox("EffectAnimateNum1:"..kk);
			
			while(1) do			
				AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+interval}, thread);
				coroutine.yield();
				--PlayEffect("click.wav");
				
				local num = tonumber(string.char(string.byte(text, i)));
				local nn  = math.mod(kk,10);				
				if(num==nn) then
					nnstr = nnstr..nn;	
					newtext = nnstr;
					for k=i+1,string.len(text),1 do
						local kn = tonumber(string.char(string.byte(text, i)));
						newtext = newtext..kn;
					end
					HelperSetWindowText(wnd, newtext);
					break;
				else
					newtext = nnstr..nn;
					for k=i+1,string.len(text),1 do
						local kn = tonumber(string.char(string.byte(text, i)));
						newtext = newtext..kn;
					end
					HelperSetWindowText(wnd, newtext);
				end		

				kk = kk+1;
			end		
			
			--LXZAPI_OutputDebugStr("newtext:"..newtext);
		end
		
		if(thread1 ~= nil) then
			coroutine.resume(thread1);	
		end
		
	end);	
	coroutine.resume(co, co);	

end


function EffectAnimateTextAndScaleWnd(wnd, text, thread1,interval, ext)
	if(ext == nil) then
		ext = 0;
	end

	HelperSetWindowText(wnd, text);
	wnd:Show();
	wnd:SetHeight(25*GameData.scale*(HelperGetWindowTextLineCount(wnd)+ext));	
	EffectAnimateText(wnd, text, thread1,interval)
end

function EffectAnimateText(wnd, text, thread1,interval, nosound)
	local newtext = "";
	
	local co = coroutine.create(function (thread)
		HelperSetWindowText(wnd, "");
		if(interval==nil) then
			interval = 35;
		end
				
		for i = 1, string.len(text),1 do
			AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+interval}, thread);
			coroutine.yield();
			if(nosound==nil) then
				PlayEffect("keychar.wav");
			end
			newtext = newtext..string.char(string.byte(text, i));
			HelperSetWindowText(wnd, newtext);
			--LXZAPI_OutputDebugStr("newtext:"..newtext);
		end
		
		if(thread1 ~= nil) then
			coroutine.resume(thread1);	
		end
		
	end);	
	coroutine.resume(co, co);	
end

function EffectAnimateMenuHide(name,func)
	local root = HelperGetRoot();
	local co = coroutine.create(function (thread)
			local wnd = root:GetChild("Menu");
			wnd:Show();
			wnd:SetBit(STATUS_IsDisable);
			
			AddWndUpdateFunc(wnd:GetChild(name), EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=20}, thread);
			AddWndUpdateFunc(wnd:GetChild(name), EffectZoomInFunc, {time=LXZAPI_timeGetTime()+300,step=0.05,from=1,max=1.2});
			coroutine.yield();
			
			local  function waittime(w,tt)
				AddWndUpdateFunc(w, EffectTimer, {time=LXZAPI_timeGetTime()+tt}, thread);	
				coroutine.yield();
			end
				
					
			local childNames={"Continue", "ComboMode","ScoreMode","Ranking","Option"};
			for k,v in pairs(childNames) do
				--wnd:GetChild(v):Show();
				AddWndUpdateFunc(wnd:GetChild(v), EffectEase,{type=tween.QUINT, fn=tween.easeIn, begin=0, offset=0, change=200, duration=300,attribute="CLXZWindow:Hot:HotPosX",hide=true,reset=true}, thread);
				waittime(wnd:GetChild(v),100);
			end
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();

					
			wnd:DelBit(STATUS_IsDisable);
			wnd:Hide();
			--wnd:SetHotPos(pt);
			--LXZMessageBox("hide :"..wnd:GetName());
			--PlayEffect("click.wav");
			if(func ~= nil) then
				func();
			end			
		end);	
	local res,err = coroutine.resume(co, co);	
	if(res==false) then		
		LXZMessageBox("EffectAnimateMenuHide false :"..err);
	end
end

function EffectEase(wnd, t)
	if t.attribute== nil then
		return true;
	end
	
	if t.fn == nil then
		return true;
	end
	
	if t.attribute_ref == nil then
		t.attribute_ref=wnd:GetAttributeNameRef(t.attribute);
	end
	
	if t.offset == nil then
		t.offset = 0;
	end
	
	if t.origin == nil then
		t.origin = wnd:GetAttribute(t.attribute_ref);
	end
	
	if t.time == nil then
		t.time = 0;
	end
	
	if t.begin == nil then
		t.begin = 0;
	end
	
	if t.count==nil then
		t.count=1;
	end
		
	local v=t.fn(t.type,t.time,t.begin, t.change, t.duration)+t.origin+t.offset;
	t.time=t.time+LXZAPI_GetFrameTime();
	wnd:SetAttribute (t.attribute_ref, v);
	
	if t.time>=t.duration then
		t.count=t.count-1;
		if t.count<=0 then
			if t.reset ~= nil then
				wnd:SetAttribute (t.attribute_ref, t.origin);
			end
			
			if t.hide~= nil then
				wnd:Hide();
			end
			
			if t.del ~= nil then
				wnd:Delete();
			end
			
			--kkk=kkk+1;
			
			return true;
		else
			t.time=0;
		end	
	end
	
	return false;
end

function EffectAnimateMenuShow()
	local root = HelperGetRoot();
	--LXZMessageBox("EffectAnimateMenu");
	local co = coroutine.create(function (thread)
			local wnd = root:GetChild("Menu");
			wnd:Show();
			wnd:SetBit(STATUS_IsDisable);
			wnd:GetChild("Continue"):Hide();
			wnd:GetChild("ComboMode"):Hide();
			wnd:GetChild("ScoreMode"):Hide();
			wnd:GetChild("Ranking"):Hide();
			wnd:GetChild("Option"):Hide();
			
			--
			HelperSetWindowPictureFile(wnd:GetChild("Continue"), "game1.png");
			HelperSetWindowPicture(wnd:GetChild("Continue"), "resumebtn");
			
			HelperSetWindowPictureFile(wnd:GetChild("ScoreMode"), "game1.png");
			HelperSetWindowPicture(wnd:GetChild("ScoreMode"), "scoremodebtn");
			
			HelperSetWindowPictureFile(wnd:GetChild("ComboMode"), "game1.png");
			HelperSetWindowPicture(wnd:GetChild("ComboMode"), "combomodebtn");
			
			HelperSetWindowPictureFile(wnd:GetChild("Ranking"), "game1.png");
			HelperSetWindowPicture(wnd:GetChild("Ranking"), "ranking");
			
			HelperSetWindowPictureFile(wnd:GetChild("Option"), "game5.png");
			HelperSetWindowPicture(wnd:GetChild("Option"), "optionbkup");
			
			local  function waittime(w,tt)
				AddWndUpdateFunc(w, EffectTimer, {time=LXZAPI_timeGetTime()+tt}, thread);	
				coroutine.yield();
			end			
					
			local count = 0;
			local childNames={"Continue", "ComboMode","ScoreMode","Ranking","Option"};
			for k,v in pairs(childNames) do
				wnd:GetChild(v):Show();
				AddWndUpdateFunc(wnd:GetChild(v), EffectEase,{type=tween.QUINT, fn=tween.easeOut, begin=0, offset=-200, change=200, duration=300,reset=true,attribute="CLXZWindow:Hot:HotPosX"}, thread);
				waittime(wnd:GetChild(v),100);
				count=count+1;
			end
		
			coroutine.yield();	
			coroutine.yield();	
			coroutine.yield();	
			coroutine.yield();
			coroutine.yield();	
									
			wnd:DelBit(STATUS_IsDisable);
		end);	
	local res,err = coroutine.resume(co, co);	
	if(res==false) then		
		LXZMessageBox("EffectAnimateMenu false :"..err);
	end
end

function EffectAnimateMessageBox()
	local root = HelperGetRoot();
	
	local wnd = root:GetLXZWindow("MessageBox");
	local count = HelperGetWindowTextLineCount(root:GetLXZWindow("MessageBox:text"));
	wnd:SetHeight((320+count*25)*GameData.scale);	
	root:GetLXZWindow("MessageBox:text"):SetHeight((count*25+50)*GameData.scale);	
	--wnd:MoveToCenter();
	local pt = LXZPoint:new_local();		
	pt.y = (root:GetHeight()-wnd:GetHeight())/3;
	wnd:SetPos(pt);
	
	
	local co = coroutine.create(function (thread)
	
			wnd:SetBit(STATUS_IsDisable);
									
			root:GetLXZWindow("MessageBox:text"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:text"), EffectMove, {speed=40*GameData.scale, dir=1, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y-250*GameData.scale,x=pt.x, y=pt.y}, thread);
			
			root:GetLXZWindow("MessageBox:okbtn"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:okbtn"), EffectMove, {speed=40*GameData.scale, dir=2, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+250*GameData.scale,x=pt.x, y=pt.y, coe=2}, thread);
			
			root:GetLXZWindow("MessageBox:restorebtn"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:restorebtn"), EffectMove, {speed=40*GameData.scale, dir=2, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+250*GameData.scale,x=pt.x, y=pt.y, coe=2}, thread);
			
			
			root:GetLXZWindow("MessageBox:cancelbtn"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:cancelbtn"), EffectMove, {speed=40*GameData.scale, dir=2, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+250*GameData.scale,x=pt.x, y=pt.y, coe=2}, thread);
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:text"), EffectShake, {interval=15, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=2*GameData.scale});
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:okbtn"), EffectShake, {interval=10, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=1*GameData.scale});
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:restorebtn"), EffectShake, {interval=10, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=1*GameData.scale});
			AddWndUpdateFunc(root:GetLXZWindow("MessageBox:cancelbtn"), EffectShake, {interval=15, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=1*GameData.scale});
						
			wnd:DelBit(STATUS_IsDisable);
	end);
	coroutine.resume(co, co);	
end


--
function EffectAnimateMsgBox()
	local root = HelperGetRoot();
	
	local wnd = root:GetLXZWindow("MsgBox");
	local count = HelperGetWindowTextLineCount(root:GetLXZWindow("MsgBox:text"));
	wnd:SetHeight((300+count*25)*GameData.scale);	
	root:GetLXZWindow("MsgBox:text"):SetHeight((count*25+50)*GameData.scale);	
	--wnd:MoveToCenter();
	local pt = LXZPoint:new_local();		
	pt.y = (root:GetHeight()-wnd:GetHeight())/3;
	wnd:SetPos(pt);
	
	
	local co = coroutine.create(function (thread)
	
			wnd:SetBit(STATUS_IsDisable);
									
			root:GetLXZWindow("MsgBox:text"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:text"), EffectMove, {speed=40*GameData.scale, dir=1, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y-250*GameData.scale,x=pt.x, y=pt.y}, thread);
			
			root:GetLXZWindow("MsgBox:okbtn"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:okbtn"), EffectMove, {speed=40*GameData.scale, dir=2, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+250*GameData.scale,x=pt.x, y=pt.y, coe=2}, thread);
						
			root:GetLXZWindow("MsgBox:cancelbtn"):GetHotPos(pt);			
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:cancelbtn"), EffectMove, {speed=40*GameData.scale, dir=2, range=50*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+250*GameData.scale,x=pt.x, y=pt.y, coe=2}, thread);
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();

			
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:text"), EffectShake, {interval=15, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=2*GameData.scale});
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:okbtn"), EffectShake, {interval=10, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=1*GameData.scale});			
			AddWndUpdateFunc(root:GetLXZWindow("MsgBox:cancelbtn"), EffectShake, {interval=15, frame={{0,5},{0,-5},{0,4},{0,-4},{0,3},{0,-3},{0,-2},{0,2},{0,-1},{0,1}}, coe=1*GameData.scale});
						
			wnd:DelBit(STATUS_IsDisable);
	end);
	coroutine.resume(co, co);	
end

function EffectAnimateFail()
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:fail");
	
	local corecfg = ICGuiGetLXZCoreCfg();	
	if(IntergalTimes(corecfg.nScreenHeight,568)==true) then
		if(GameData.level<5)  then
			wnd:SetExtY(20*GameData.scale);
		else
			wnd:SetExtY(44*GameData.scale);
		end
	else
		wnd:SetExtY(0);
	end
	
		
	local co = coroutine.create(function (thread)
			local pt = LXZPoint:new_local();			
			local effect = root:GetLXZWindow("Game:effect");
			local background = root:GetLXZWindow("Game:background");
			root:SetBit(STATUS_IsDisable);
			background:ClearChilds();
			wnd:GetLXZWindow("exitbtn"):Hide();
			
			local tips = root:GetLXZWindow("Game:fail:tips");		
			tips:Hide();
			
			HideGameHeadWindow();
			
			LXZAPI_CallSystemAPI("showAD", "true (0 0)");
			
		--	if(GameData.newhitcnt>5) then
			AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+2000}, thread);		
			coroutine.yield();					
									
			effect:ClearChilds();
			PlayEffect("gamefail.wav");
			root:GetLXZWindow("Game:main"):Hide();
			wnd:Show();
			wnd:GetLXZWindow("levelmaxcoin"):Hide();
			wnd:GetLXZWindow("currentcoin"):Hide();
			wnd:GetLXZWindow("target"):Hide();
			
		--	AddWndUpdateFunc(wnd, EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=2});
			
			wnd:GetLXZWindow("failbtn"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("failbtn"), EffectMove, {speed=5*GameData.scale, dir=1, range=10*GameData.scale, acce=1, fromx = pt.x, fromy = pt.y-300*GameData.scale,x=pt.x, y=pt.y, coe=1.05, min=5}, thread);
			
			wnd:GetLXZWindow("replaybtn"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("replaybtn"), EffectMove, {speed=5*GameData.scale, dir=2, range=50, acce=1, fromx = pt.x, fromy = pt.y+300*GameData.scale,x=pt.x, y=pt.y}, thread);
					
			if(GameData.level>=25) then
				wnd:GetLXZWindow("exitbtn"):Show();
				wnd:GetLXZWindow("exitbtn"):GetHotPos(pt);
				AddWndUpdateFunc(wnd:GetLXZWindow("exitbtn"), EffectMove, {speed=5*GameData.scale, dir=2, range=50, acce=1, fromx = pt.x, fromy = pt.y+300*GameData.scale,x=pt.x, y=pt.y},thread);
				coroutine.yield();
			else
				wnd:GetLXZWindow("exitbtn"):Hide();
			end					
			
			coroutine.yield();
			coroutine.yield();
						
			--PlayEffect("menu.wav");					
			AddWndUpdateFunc(wnd:GetLXZWindow("failbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=3*GameData.scale});
			AddWndUpdateFunc(wnd:GetLXZWindow("replaybtn"), EffectShake, {interval=10, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=2*GameData.scale});
			AddWndUpdateFunc(wnd:GetLXZWindow("exitbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=1*GameData.scale});
			
			--
			local target = GetWinCoin();
			HelperSetWindowText(wnd:GetLXZWindow("target:text"), tostring(target));
			wnd:GetLXZWindow("target"):Show();	
			wnd:GetLXZWindow("target"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("target"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);			
			coroutine.yield();
			
			--
			HelperSetWindowText(wnd:GetLXZWindow("levelmaxcoin:text"), "");
			wnd:GetLXZWindow("levelmaxcoin"):Show();	
			wnd:GetLXZWindow("levelmaxcoin"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("levelmaxcoin"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
			--AddWndUpdateFunc(wnd:GetLXZWindow("levelmaxcoin"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
			coroutine.yield();
			
			HelperSetWindowText(wnd:GetLXZWindow("currentcoin:text"), "");
			wnd:GetLXZWindow("currentcoin"):Show();	
			wnd:GetLXZWindow("currentcoin"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("currentcoin"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
			--AddWndUpdateFunc(wnd:GetLXZWindow("currentcoin"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
			coroutine.yield();
									
			if(GameData.highscore<=GameData.bonus) then
				EffectAnimateNum(wnd:GetLXZWindow("levelmaxcoin:text"), tostring(GameData.highscore), thread, 15);
			else
				EffectAnimateText(wnd:GetLXZWindow("levelmaxcoin:text"), tostring(GameData.highscore), thread,15);			
			end			
			coroutine.yield();
			
			--			
			EffectAnimateNum(wnd:GetLXZWindow("currentcoin:text"), tostring(GameData.bonus), thread, 15);			
			coroutine.yield();		
			
			--第二关
			if(GameData.level<25) then						
				EffectAnimateTextAndScaleWnd(tips, "Your have got "..GameData.bonus.." points,  but not reach target points,  you can use help button", thread,10, 1);				
				coroutine.yield();			
				AddWndUpdateFunc(wnd:GetLXZWindow("tips:helpbtn"), EffectAnimate, {interval=30, playcnt=20, frame={"helpup","helpdown"}},nil);				
			end
			
			root:DelBit(STATUS_IsDisable);
			--PlayEffect("menu.wav");
	end);
	coroutine.resume(co, co);	

end

function EffectAnimateWin()
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:win");
	local corecfg = ICGuiGetLXZCoreCfg();	
	if(IntergalTimes(corecfg.nScreenHeight,568)==true) then
		if(GameData.level<5) then
			wnd:SetExtY(60*GameData.scale);
		else
			wnd:SetExtY(44*GameData.scale);
		end
	else
		if(GameData.level<5) then
			wnd:SetExtY(20*GameData.scale);
		else
			wnd:SetExtY(0);
		end
	end
	
	local co = coroutine.create(function (thread)
			local pt = LXZPoint:new_local();	
		
			local effect = root:GetLXZWindow("Game:effect");
			local background = root:GetLXZWindow("Game:background");
			background:ClearChilds();
			root:SetBit(STATUS_IsDisable);
			wnd:GetLXZWindow("exitbtn"):Hide();
			
			LXZAPI_CallSystemAPI("showAD", "true (0 0)");
			
		--	if(GameData.newhitcnt>5) then
			AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+2000}, thread);		
			coroutine.yield();				
		--	end			
			
			effect:ClearChilds();
			root:GetLXZWindow("Game:main"):Hide();
			PlayEffect("gamewin.wav");
			wnd:Show();
			wnd:GetLXZWindow("levelmaxcoin"):Hide();
			wnd:GetLXZWindow("currentcoin"):Hide();
			wnd:GetLXZWindow("target"):Hide();
			
			--AddWndUpdateFunc(root:GetLXZWindow("Game:win"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=2});
			
			root:GetLXZWindow("Game:win:winbtn"):GetHotPos(pt);
			AddWndUpdateFunc(root:GetLXZWindow("Game:win:winbtn"), EffectMove, {speed=5*GameData.scale, dir=1, range=10*GameData.scale, acce=1, fromx = pt.x, fromy = pt.y-150*GameData.scale,x=pt.x, y=pt.y, coe=1.05, min=5}, thread);
			
			wnd:GetChild("star1"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetChild("star1"), EffectMove, {speed=5*GameData.scale, dir=1, range=10*GameData.scale, acce=1, fromx = pt.x, fromy = pt.y-150*GameData.scale,x=pt.x, y=pt.y, coe=1.05, min=5}, thread);
			wnd:GetChild("star2"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetChild("star2"), EffectMove, {speed=5*GameData.scale, dir=1, range=10*GameData.scale, acce=1, fromx = pt.x, fromy = pt.y-150*GameData.scale,x=pt.x, y=pt.y, coe=1.05, min=5}, thread);
			wnd:GetChild("star3"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetChild("star3"), EffectMove, {speed=5*GameData.scale, dir=1, range=10*GameData.scale, acce=1, fromx = pt.x, fromy = pt.y-150*GameData.scale,x=pt.x, y=pt.y, coe=1.05, min=5}, thread);
			
			--
			local level = GameData.level;
			local hscore = GameData.highscore;
			if(hscore<GameCfg[level].wincoin) then
				HelperSetWindowPicture(wnd:GetChild("star1"),"greystar");
				HelperSetWindowPicture(wnd:GetChild("star2"),"greystar");
				HelperSetWindowPicture(wnd:GetChild("star3"),"greystar");
			elseif(hscore<GameCfg[level].wincoin2) then
				HelperSetWindowPicture(wnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(wnd:GetChild("star2"),"greystar");
				HelperSetWindowPicture(wnd:GetChild("star3"),"greystar");
			elseif(hscore<GameCfg[level].wincoin3) then
				HelperSetWindowPicture(wnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(wnd:GetChild("star2"),"greenstar");
				HelperSetWindowPicture(wnd:GetChild("star3"),"greystar");
			else
				HelperSetWindowPicture(wnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(wnd:GetChild("star2"),"greenstar");
				HelperSetWindowPicture(wnd:GetChild("star3"),"greenstar");
			end
			
			root:GetLXZWindow("Game:win:nextstagebtn"):GetHotPos(pt);
			AddWndUpdateFunc(root:GetLXZWindow("Game:win:nextstagebtn"), EffectMove, {speed=5*GameData.scale, dir=2, range=50, acce=1, fromx = pt.x, fromy = pt.y+150,x=pt.x, y=pt.y}, thread);
			
			if(GameData.level>=5) then
				wnd:GetLXZWindow("exitbtn"):Show();
				root:GetLXZWindow("Game:win:exitbtn"):GetHotPos(pt);
				AddWndUpdateFunc(root:GetLXZWindow("Game:win:exitbtn"), EffectMove, {speed=5*GameData.scale, dir=2, range=50, acce=1, fromx = pt.x, fromy = pt.y+150,x=pt.x, y=pt.y}, thread);
				coroutine.yield();				
			else
				wnd:GetLXZWindow("exitbtn"):Hide();
			end
					
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			coroutine.yield();
			--PlayEffect("menu.wav");
			
			AddWndUpdateFunc(wnd:GetLXZWindow("winbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=3*GameData.scale});
			AddWndUpdateFunc(wnd:GetLXZWindow("nextstagebtn"), EffectShake, {interval=10, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=2*GameData.scale});
			AddWndUpdateFunc(wnd:GetLXZWindow("exitbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=1*GameData.scale});
			
			--
			local target = GetWinCoin();
			HelperSetWindowText(wnd:GetLXZWindow("target:text"), tostring(target));
			wnd:GetLXZWindow("target"):Show();	
			wnd:GetLXZWindow("target"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("target"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);			
			coroutine.yield();
			
			--
			HelperSetWindowText(wnd:GetLXZWindow("levelmaxcoin:text"), "");
			wnd:GetLXZWindow("levelmaxcoin"):Show();	
			wnd:GetLXZWindow("levelmaxcoin"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("levelmaxcoin"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
			--AddWndUpdateFunc(wnd:GetLXZWindow("levelmaxcoin"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
			coroutine.yield();
			
			--
			HelperSetWindowText(wnd:GetLXZWindow("currentcoin:text"), "");
			wnd:GetLXZWindow("currentcoin"):Show();	
			wnd:GetLXZWindow("currentcoin"):GetHotPos(pt);
			AddWndUpdateFunc(wnd:GetLXZWindow("currentcoin"), EffectMove, {speed=10*GameData.scale, dir=4, range=50, acce=1, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
			--AddWndUpdateFunc(wnd:GetLXZWindow("currentcoin"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
			coroutine.yield();
									
			if(GameData.highscore<=GameData.bonus) then
				EffectAnimateNum(wnd:GetLXZWindow("levelmaxcoin:text"), tostring(GameData.highscore), thread, 40);
			else
				EffectAnimateText(wnd:GetLXZWindow("levelmaxcoin:text"), tostring(GameData.highscore), thread,100);			
			end			
			coroutine.yield();
			
			--			
			EffectAnimateNum(wnd:GetLXZWindow("currentcoin:text"), tostring(GameData.bonus), thread, 40);			
			coroutine.yield();		
			
			root:DelBit(STATUS_IsDisable);
	end);
	coroutine.resume(co, co);	

end

function EffectAnimateLoading()
	local root = HelperGetRoot();
	local pt = LXZPoint:new_local();	
	local oldpt1 = LXZPoint:new_local();	
	local oldpt2 = LXZPoint:new_local();	
	local oldpt3 = LXZPoint:new_local();	
	
	local co = coroutine.create(function (thread)
			local wnd = root:GetChild("Load");
			wnd:SetBit(STATUS_IsDisable);
			wnd:GetChild("weibo"):Hide();
			wnd:GetChild("help"):Hide();
			wnd:GetChild("setoption"):Hide();
			wnd:GetChild("play"):Hide();
			
			--AddWndUpdateFunc(root:GetLXZWindow("Load:play"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=-300, change=300, duration=500,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
			AddWndUpdateFunc(root:GetLXZWindow("Load:head"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=-300, change=300, duration=1000,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
			AddWndUpdateFunc(root:GetLXZWindow("Load:name"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=-300, change=300, duration=1000,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
	
			--[[root:GetLXZWindow("Load:play"):GetHotPos(pt);
			oldpt1.x = pt.x;
			oldpt1.y = pt.y;
			AddWndUpdateFunc(root:GetLXZWindow("Load:play"), EffectMove, {speed=10*GameData.scale, dir=2, range=20*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y+300*GameData.scale,x=pt.x, y=pt.y, coe=5, min=1, playcnt=6}, thread);
			
			root:GetLXZWindow("Load:head"):GetHotPos(pt);
			oldpt2.x = pt.x;
			oldpt2.y = pt.y;
			AddWndUpdateFunc(root:GetLXZWindow("Load:head"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=20});	
			AddWndUpdateFunc(root:GetLXZWindow("Load:head"), EffectMove, {speed=10*GameData.scale, dir=1, range=20*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y-300*GameData.scale,x=pt.x, y=pt.y,coe=5, min=1, playcnt=6}, thread);
			AddWndUpdateFunc(root:GetLXZWindow("Load:head"), EffectZoomInFunc, {time=LXZAPI_timeGetTime()+300,step=0.05,from=0.5,max=1});
			
			
			
			root:GetLXZWindow("Load:name"):GetHotPos(pt);
			oldpt3.x = pt.x;
			oldpt3.y = pt.y;
			AddWndUpdateFunc(root:GetLXZWindow("Load:name"), EffectMove, {speed=10*GameData.scale, dir=1, range=20*GameData.scale, acce=5, fromx = pt.x, fromy = pt.y-300*GameData.scale,x=pt.x, y=pt.y, coe=5,min=1, playcnt=6}, thread);
			--]]
			coroutine.yield();
			--coroutine.yield();
			coroutine.yield();
			
			--PlayEffect("menu.wav");
			--AddWndUpdateFunc(root:GetLXZWindow("Load:head"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=6*GameData.scale});
		   -- AddWndUpdateFunc(root:GetLXZWindow("Load:name"), EffectSpringMove, {a=20, b = 0, c = 0, d=100,p=6});			
			--AddWndUpdateFunc(root:GetLXZWindow("Load:play"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=4*GameData.scale});
			--AddWndUpdateFunc(root:GetLXZWindow("Load:name"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=3*GameData.scale});
			
			--		
			wnd:GetChild("weibo"):Show();			
			AddWndUpdateFunc(wnd:GetChild("weibo"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=50, change=-50, duration=300,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
			coroutine.yield();
			
			wnd:GetChild("help"):Show();		
			AddWndUpdateFunc(wnd:GetChild("help"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=50, change=-50, duration=300,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
			coroutine.yield();
			
			wnd:GetChild("setoption"):Show();		
			AddWndUpdateFunc(wnd:GetChild("setoption"), EffectEase,{type=tween.BOUNCE, fn=tween.easeInOut, begin=0, offset=50, change=-50, duration=300,reset=true,attribute="CLXZWindow:Hot:HotPosY"}, thread);
			coroutine.yield();
			
			wnd:GetChild("play"):Show();
			AddWndUpdateFunc(wnd:GetChild("play"), EffectEase,{type=tween.QUINT, fn=tween.easeOut, begin=0, offset=150, change=255, duration=300,reset=true,attribute="CLXZWindow:Mask:alpha"}, thread);
			coroutine.yield();
			
		--	PlayEffect("menu.wav");
			wnd:DelBit(STATUS_IsDisable);
					
	end);
	
	coroutine.resume(co, co);	
end

local function OnLoad(window, msg0, sender)
	HelperShow("Menu",true);
	
	--
	local audio = SimpleAudioEngine:sharedEngine();
	--[[audio:preloadEffect("move.wav");
	audio:preloadEffect("move1.wav");
	audio:preloadEffect("move2.wav");
	audio:preloadEffect("itemboom.wav");
	audio:preloadEffect("startgame.wav");
	audio:preloadEffect("menu.wav");
	audio:preloadEffect("desc.wav");
	audio:preloadEffect("asc.wav");
	audio:preloadEffect("continue.wav");	--]]
	
	--
		
	--
	LoadGameCfg();
	HelperInitCreateDB();
	LoadDBCurrentUser();
	HelperGetCurrentLocalUser();
	LoadDB();
	
	
	--
	UpdateDataToUI();
	
	--
	SetVolume(GameData.volume);
	
	--
	local root = HelperGetRoot();
	 root:GetChild("LevelSets"):Hide();
	 root:GetChild("option"):Hide();
	 root:GetChild("MessageBox"):Hide();
	 root:GetChild("Help"):Hide();
	root:GetLXZWindow("Game:helptips"):Hide();
	root:GetLXZWindow("Game:fail"):Hide();
	root:GetLXZWindow("Game:win"):Hide();
	root:GetLXZWindow("Game:bonustips"):Hide();
	 if(root:GetLXZWindow("Game:help")~=nil) then
		root:GetLXZWindow("Game:help"):Hide();
	 end
	 
	 --
	 local pt = LXZPoint:new_local();
	 root:GetLXZWindow("LevelSets:Sets"):SetExtX(0);
	 for i=1,5,1 do
		local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Sets");
		wnd:SetName("Sets"..i);
		pt.x = (i-1)*wnd:GetWidth();
		root:GetLXZWindow("LevelSets:Sets"):AddChild(wnd);
		wnd:SetPos(pt);
		wnd:EnableDrag();
		--LXZMessageBox("x:"..pt.x);
	 end
	 
	 --
	root:GetChild("Load"):Show();

	 
	local corecfg = ICGuiGetLXZCoreCfg();	
	local sysos = LXZAPIGetOS();
	if(IntergalTimes(corecfg.nScreenWidth,320) and IntergalTimes(corecfg.nScreenHeight,480)) then
		root:SetWidth(320);
		root:SetHeight(480);
	elseif(IntergalTimes(corecfg.nScreenWidth,320) and IntergalTimes(corecfg.nScreenHeight,568)) then
		root:SetWidth(320);
		root:SetHeight(568);	
	end
	
	--	
	
end

function EffectRotateFunc(wnd, tblParam)
	if(tblParam.speed == nil) then
		tblParam.speed = 0.1571;
	end
	
	if(tblParam.playcnt==nil) then
		tblParam.playcnt=1;
	end
	
	if(tblParam.startangle==nil) then
		tblParam.startangle = 0;
	end
	
	if(tblParam.endangle==nil) then
		if(tblParam.speed>0) then
			tblParam.endangle = math.atan(1)*8;
		else
			tblParam.endangle = -math.atan(1)*8;
		end
	end
	
	if(tblParam.curangle == nil) then
		tblParam.curangle = tblParam.startangle;
		HelperSetWindowPictureAngle(wnd, tblParam.curangle);
		return false;
	end
	
	if(tblParam.acce==nil) then
		tblParam.acce = 0;
	end
	
	tblParam.speed = tblParam.speed+tblParam.acce;
	
	tblParam.curangle = tblParam.curangle+tblParam.speed;
	if(tblParam.speed>0 and tblParam.curangle>=tblParam.endangle) then
		tblParam.playcnt = tblParam.playcnt-1;
		if(tblParam.playcnt<=0) then
			HelperSetWindowPictureAngle(wnd, tblParam.startangle);
			return true;
		else
			tblParam.curangle = tblParam.startangle;
		end		
	elseif(tblParam.speed<0 and tblParam.curangle<=tblParam.endangle) then
		--LXZMessageBox("ddd:"..tblParam.curangle.." :"..tblParam.endangle);
		tblParam.playcnt = tblParam.playcnt-1;
		if(tblParam.playcnt<=0) then
			HelperSetWindowPictureAngle(wnd, tblParam.startangle);
			return true;
		else
			tblParam.curangle = tblParam.startangle;
		end		
	end
		
	HelperSetWindowPictureAngle(wnd, tblParam.curangle);
--[[	if(tblParam.speed<0) then
		if(AAA==nil) then
			AAA = wnd:GetName();
		end
		
		if(AAA==wnd:GetName()) then
			LXZMessageBox("ddd:"..tblParam.curangle);
		end
	end--]]
	
	return false;
end

function EffectColorPicture(wnd, tblParam)
	if(tblParam.time==nil) then
		tblParam.time=0;
	end

	if(tblParam.interval== nil) then
		tblParam.interval = 100;
	end
	
	if(tblParam.frame == nil or table.getn(tblParam.frame)==0) then
		return true;
	end
	
	if(tblParam.playcnt==nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.index==nil) then
		tblParam.index=1;
		HelperSetWindowPictureColor(wnd, unpack(tblParam.frame[tblParam.index]));
		return false;
	end
			
	if(LXZAPI_timeGetTime()>=tblParam.time) then
	
		if(tblParam.index>table.getn(tblParam.frame)) then
			if(tblParam.playcnt<=1) then			
				HelperSetWindowPictureColor(wnd, unpack(tblParam.frame[1]));
				return true;
			else
				tblParam.playcnt = tblParam.playcnt-1;
				tblParam.index = math.mod(tblParam.index,table.getn(tblParam.frame));
			end
		end		
		
		HelperSetWindowPictureColor(wnd, unpack(tblParam.frame[tblParam.index]));
		--LXZAPI_OutputDebugStr("EffectAnimate:"..tblParam.frame[tblParam.index]);
		tblParam.index=tblParam.index+1;	
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
	end	
	
	return false;	
end

function EffectColorText(wnd, tblParam)
	if(tblParam.time==nil) then
		tblParam.time=0;
	end

	if(tblParam.interval== nil) then
		tblParam.interval = 100;
	end
	
	if(tblParam.frame == nil or table.getn(tblParam.frame)==0) then
		return true;
	end
	
	if(tblParam.playcnt==nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.index==nil) then
		tblParam.index=1;
		HelperSetWindowTextColor(wnd, unpack(tblParam.frame[tblParam.index]));
		return false;
	end
			
	if(LXZAPI_timeGetTime()>=tblParam.time) then
	
		if(tblParam.index>table.getn(tblParam.frame)) then
			if(tblParam.playcnt<=1) then			
				HelperSetWindowTextColor(wnd, unpack(tblParam.frame[1]));
				return true;
			else
				tblParam.playcnt = tblParam.playcnt-1;
				tblParam.index = math.mod(tblParam.index,table.getn(tblParam.frame));
			end
		end		
		
		HelperSetWindowTextColor(wnd, unpack(tblParam.frame[tblParam.index]));
		--LXZAPI_OutputDebugStr("EffectAnimate:"..tblParam.frame[tblParam.index]);
		tblParam.index=tblParam.index+1;	
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
	end	
	
	return false;	
end

function EffectPlaySound(wnd, tblParam)
	if(tblParam.time==nil) then
		tblParam.time=0;
	end

	if(tblParam.interval== nil) then
		tblParam.interval = 100;
	end
	
	if(tblParam.frame == nil or table.getn(tblParam.frame)==0) then
		return true;
	end
	
	if(tblParam.playcnt==nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.index==nil) then
		tblParam.index=1;
		PlayEffect(tblParam.frame[tblParam.index]);		
		tblParam.index=2;
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
		return false;
	end
			
	if(LXZAPI_timeGetTime()>=tblParam.time) then
	
		if(tblParam.index>table.getn(tblParam.frame)) then
			if(tblParam.playcnt<=1) then			
				return true;
			else
				tblParam.playcnt = tblParam.playcnt-1;
				tblParam.index = 1+math.mod(tblParam.index,table.getn(tblParam.frame));
			end
		end		
		
		PlayEffect(tblParam.frame[tblParam.index]);
		--LXZAPI_OutputDebugStr("EffectAnimate:"..tblParam.frame[tblParam.index]);
		tblParam.index=tblParam.index+1;	
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
	end	
	
	return false;	

end

function EffectAnimate(wnd, tblParam)
	if(tblParam.time==nil) then
		tblParam.time=0;
	end

	if(tblParam.interval== nil) then
		tblParam.interval = 100;
	end
	
	if(tblParam.frame == nil or table.getn(tblParam.frame)==0) then
		return true;
	end
	
	if(tblParam.playcnt==nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.index==nil) then
		tblParam.index=1;
		HelperSetWindowPicture(wnd, tblParam.frame[tblParam.index]);
		
		if(tblParam.file ~= nil) then
			HelperSetWindowPictureFile(wnd, tblParam.file[tblParam.index]);
		end
		
		tblParam.index=tblParam.index+1;	
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
		return false;
	end
			
	if(LXZAPI_timeGetTime()>=tblParam.time) then
	
		if(tblParam.index>table.getn(tblParam.frame)) then
			if(tblParam.playcnt<=1) then			
				HelperSetWindowPicture(wnd, tblParam.frame[1]);
				if(tblParam.file ~= nil) then
					HelperSetWindowPictureFile(wnd, tblParam.file[1]);
				end
				return true;
			else
				tblParam.playcnt = tblParam.playcnt-1;
				tblParam.index = math.mod(tblParam.index,table.getn(tblParam.frame));
			end
		end		
		
		HelperSetWindowPicture(wnd, tblParam.frame[tblParam.index]);
		if(tblParam.file ~= nil) then
			HelperSetWindowPictureFile(wnd, tblParam.file[tblParam.index]);
		end
		
		--LXZAPI_OutputDebugStr("EffectAnimate:"..tblParam.frame[tblParam.index]);
		tblParam.index=tblParam.index+1;	
		tblParam.time = tblParam.interval+LXZAPI_timeGetTime();
	end	
	
	return false;	

end

function EffectZoomInFunc(wnd, tblParam)
	
	--
	WindowRefLogic.ScaleX = wnd:GetAttributeNameRef("CLXZWindow:Scale:fScaleX", WindowRefLogic.ScaleX);		
	WindowRefLogic.ScaleY = wnd:GetAttributeNameRef("CLXZWindow:Scale:fScaleY", WindowRefLogic.ScaleY);
	
	if(tblParam.from==nil) then
		tblParam.from= 0.1;
	end
	
	if(tblParam.step==nil) then
		tblParam.step = 0.001;
	end
	
	if(tblParam.max==nil) then
		tblParam.max = 2;
	end
	
	if(tblParam.playcnt == nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.acc== nil) then
		tblParam.acc=0;
	end
			
	local scale = tonumber(wnd:GetAttribute(WindowRefLogic.ScaleX));
	if(tblParam.oldscale==nil) then
		tblParam.oldscale=1;
		scale = tblParam.from;
		wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(scale));
		wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(scale));			
	else
		scale = scale+tblParam.step;
	end
		
	if(scale>tblParam.max) then
		tblParam.playcnt = tblParam.playcnt-1;
		if(tblParam.playcnt<=0) then			
			if(tblParam.oldscale~=nil) then
				if(tblParam.noreset==nil) then
					wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(tblParam.oldscale));
					wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(tblParam.oldscale));					
				end
			end
			return true;		
		else
			scale = tblParam.from;
		end
	end
	
	tblParam.step = tblParam.step + tblParam.acc;
	
	wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(scale));
	wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(scale));		
	
	return false;
end

function EffectZoomInOutFunc(wnd, tblParam)
	
	--
	WindowRefLogic.ScaleX = wnd:GetAttributeNameRef("CLXZWindow:Scale:fScaleX", WindowRefLogic.ScaleX);		
	WindowRefLogic.ScaleY = wnd:GetAttributeNameRef("CLXZWindow:Scale:fScaleY", WindowRefLogic.ScaleY);
	
	if(tblParam.from==nil) then
		tblParam.from= 0.1;
	end
	
	if(tblParam.step==nil) then
		tblParam.step = 0.001;
	end
	
	if(tblParam.max==nil) then
		tblParam.max = 2;
	end
	
	if(tblParam.playcnt == nil) then
		tblParam.playcnt = 1;
	end
	
	if(tblParam.dir==nil) then
		tblParam.dir=1;
	end
			
	local scale = tostring(wnd:GetAttribute(WindowRefLogic.ScaleX));
	if(tblParam.oldscale==nil) then
		tblParam.oldscale=1;
		scale = tblParam.from;
		wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(scale));
		wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(scale));			
	else
		scale = scale+tblParam.step*tblParam.dir;
	end
	
	if(tblParam.dir==1) then
		if(scale>tblParam.max) then
			tblParam.playcnt = tblParam.playcnt-1;
			scale = tblParam.max;
			if(tblParam.playcnt>0) then
				tblParam.dir=-1;				
			end
		end
	else
		if(scale<tblParam.from) then
			tblParam.playcnt = tblParam.playcnt-1;
			scale = tblParam.from;
			if(tblParam.playcnt>0) then
				tblParam.dir=1;			
			end
		end
	end
	
	wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(scale));
	wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(scale));		
	
	if(tblParam.playcnt<=0) then
		if(tblParam.oldscale~=nil) then
			wnd:SetAttribute(WindowRefLogic.ScaleX, tostring(tblParam.oldscale));
			wnd:SetAttribute(WindowRefLogic.ScaleY, tostring(tblParam.oldscale));					
		end
		return true;
	end
	
	return false;
end


--millionseconds
function EffectCountdown(wnd, tblParam)
	if(tblParam.totaltimes==nil) then
		tblParam.totaltimes = 1000;
	end
	
	if(tblParam.countdown==nil) then
		tblParam.countdown = 10;
	end
		
	if(tblParam.oldtotaltimes==nil) then
		tblParam.oldtotaltimes = tblParam.totaltimes;
		return false;
	end
	
	if(IS_MAKE_GAME ~= 0) then
		--LXZMessageBox("EffectCountdown:"..tblParam.totaltimes.." tblParam.countdown:"..tblParam.countdown);
		return false;
	end
	
	tblParam.totaltimes = tblParam.totaltimes-LXZAPI_GetFrameTime();	
	if(tblParam.totaltimes<=tblParam.countdown) then
		if(tblParam.oldtotaltimes>tblParam.countdown and tblParam.func~=nil) then
			tblParam.func(wnd, tblParam);
		end
		return true;
	end
	
	tblParam.oldtotaltimes = tblParam.totaltimes;
	
	return false;
end

function EffectTimer(wnd, tblParam)
	if(LXZAPI_timeGetTime()>tblParam.time) then
		if(tblParam.func ~= nil) then
			tblParam.func(wnd, tblParam.param);
		end
		return true;
	end
	
	return false;
end

function EffectGameCountdown(wnd, tblParam)
	if(GameData.state == STATE_NULL) then
		return true;
	end
	
	local corecfg = ICGuiGetLXZCoreCfg();
	if(GameData.state~=STATE_RUN  or corecfg.IsEditing==true) then
		return false;
	end
	
	return EffectCountdown(wnd, tblParam);
end

function EffectShake(wnd, tblParam)
	
	if(tblParam.frame == nil or table.getn(tblParam.frame)<=0) then
		return true;
	end
	
	if(tblParam.interval == nil) then
		tblParam.interval = 10;
	end
	
	if(tblParam.coe==nil) then
		tblParam.coe=1;
	end
	
	if(tblParam.start == nil) then		
		local pt = LXZPoint:new_local();
		wnd:GetHotPos(pt);
		tblParam.start = LXZAPI_timeGetTime()+tblParam.interval;
		tblParam.index = 1;		
		tblParam.x = pt.x;
		tblParam.y = pt.y;
		return false;
	end
	
	if(LXZAPI_timeGetTime()>=tblParam.start) then
		local pt = LXZPoint:new_local();
		if(tblParam.index>table.getn(tblParam.frame)) then
			pt.x = tblParam.x;
			pt.y = tblParam.y;		
			wnd:SetHotPos(pt);	
			--LXZMessageBox("EffectShake x:"..pt.x.." y:"..pt.y);
			return true;
		end			
		
		tblParam.start = LXZAPI_timeGetTime()+tblParam.interval;
		pt.x = tblParam.frame[tblParam.index][1]*tblParam.coe+tblParam.x;
		pt.y = tblParam.frame[tblParam.index][2]*tblParam.coe+tblParam.y;		
		tblParam.index = tblParam.index+1;
		--if(wnd:GetName()=="failbtn") then
	--		LXZMessageBox("x:"..pt.x.." y:"..pt.y);
		--end
		
		wnd:SetHotPos(pt);	
	end
	
	return false;
end

function EffectMove(wnd, tblParam)
	if(tblParam.speed== nil) then
		tblParam.speed = 1;
	end
		
	if(tblParam.acce == nil) then
		tblParam.acce = 0;
	end
	
	if(tblParam.dir==nil) then
		tblParam.dir =1;
	end
	
	local pt = LXZPoint:new_local();
	local dir = {{x=0,y=1}, {x=0, y=-1},{x=1,y=0}, {x=-1,y=0}};	
	if(tblParam.dirx == nil or tblParam.diry==nil) then
		tblParam.dirx = dir[tblParam.dir].x;
		tblParam.diry = dir[tblParam.dir].y;
	end
	
	if(tblParam.fromx == nil) then
		local pt = LXZPoint:new_local();
		wnd:GetHotPos(pt);
		tblParam.fromx = pt.x;
		tblParam.fromy = pt.y;
	end
	
	if(tblParam.range == nil) then
		tblParam.range = 10;
	end
	
	if(tblParam.fromx==tblParam.x and tblParam.fromy==tblParam.y) then
		return true;
	end
	
	if(tblParam.x == nil) then
		local pt = LXZPoint:new_local();
		wnd:GetHotPos(pt);
		
		pt.x = pt.x+tblParam.range*tblParam.dirx;
		pt.y = pt.y+tblParam.range*tblParam.diry;
		
		tblParam.x = pt.x;
		tblParam.y = pt.y;		
	end
		
	if(tblParam.start == nil) then
		wnd:GetHotPos(pt);
		tblParam.oldx = pt.x;
		tblParam.oldy = pt.y;		
		tblParam.start = 1;			
		pt.x = tblParam.fromx;
		pt.y = tblParam.fromy;
		wnd:SetHotPos(pt);		
		wnd:Show();
		tblParam.curx = pt.x;
		tblParam.cury = pt.y;
		
		local offsetx = pt.x-tblParam.x;
		local offsety = pt.y-tblParam.y;
		local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
		tblParam.olddist = dist;
		--LXZMessageBox("Name:"..wnd:GetName().." dist:"..dist.." olddist:"..tblParam.olddist);
		return false;
	end
		
	tblParam.speed = tblParam.speed+tblParam.acce;
	if(tblParam.speed<0.001) then
		tblParam.speed = 0.001;
	end
			
	--
	tblParam.curx = tblParam.curx+tblParam.speed*tblParam.dirx;
	tblParam.cury = tblParam.cury+tblParam.speed*tblParam.diry;	
	pt.x = tblParam.curx;
	pt.y = tblParam.cury;
	
	local offsetx = pt.x-tblParam.x;
	local offsety = pt.y-tblParam.y;
	
	local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
	if(tblParam.olddist < dist or dist<=1) then		
		pt.x = tblParam.x;
		pt.y = tblParam.y;
		wnd:SetHotPos(pt);
		if(tblParam.hide ~= nil) then
			wnd:Hide();
		end
		
		if(tblParam.func~= nil) then
			tblParam.func(wnd, tblParam.param);
		end		
				
		if(tblParam.reset ~= nil and tblParam.reset==true) then
			pt.x = tblParam.oldx;
			pt.y = tblParam.oldy;
			wnd:SetHotPos(pt);
			--LXZMessageBox("Name:"..wnd:GetName().." dist:"..dist.." olddist:"..tblParam.olddist);
		end
		
		if(tblParam.del ~= nil) then
			wnd:Delete();
			wnd.update = nil;
		end
		
		return true;		
	end	
	
	if(tblParam.debug~=nil) then
		LXZMessageBox("Name:"..wnd:GetName().." dist:"..dist.." olddist:"..tblParam.olddist.." x:"..pt.x.." y:"..pt.y);
	end
	
	tblParam.olddist = dist;	
	wnd:SetHotPos(pt);	
	
	
	
	return false;
end

function EffectFilmMoveText(wnd, tblParam)
	if(tblParam.speed== nil) then
		tblParam.speed = 1;
	end
		
	if(tblParam.acce == nil) then
		tblParam.acc = 0;
	end
	
	if(tblParam.dir == nil) then
		tblParam.dir = 1;
	end
	
	if(tblParam.fromx == nil) then
		local pt = LXZPoint:new_local();
		--wnd:GetHotPos(pt);
		pt.x = HelperGetWindowTextPosX(wnd);
		pt.y = HelperGetWindowTextPosY(wnd);
		
		tblParam.fromx = pt.x;
		tblParam.fromy = pt.y;
	end
	
	if(tblParam.range == nil) then
		tblParam.range = 10;
	end
	
	local pt = LXZPoint:new_local();
	local dir = {{x=0,y=1}, {x=0, y=-1},{x=1,y=0}, {x=-1,y=0}};	
	
	if(tblParam.x == nil) then
		local pt = LXZPoint:new_local();
		--wnd:GetHotPos(pt);
		pt.x = HelperGetWindowTextPosX(wnd);
		pt.y = HelperGetWindowTextPosY(wnd);
		
		pt.x = pt.x+tblParam.range*dir[tblParam.dir].x;
		pt.y = pt.y+tblParam.range*dir[tblParam.dir].y;
		
		tblParam.x = pt.x;
		tblParam.y = pt.y;		
	end
		
	if(tblParam.start == nil) then
		--wnd:GetHotPos(pt);
		pt.x = HelperGetWindowTextPosX(wnd);
		pt.y = HelperGetWindowTextPosY(wnd);
		
		tblParam.oldx = pt.x;
		tblParam.oldy = pt.y;		
		tblParam.start = 1;			
		pt.x = tblParam.fromx;
		pt.y = tblParam.fromy;
		--wnd:SetHotPos(pt);				
		HelperSetWindowTextPosX(wnd, pt.x);
		HelperSetWindowTextPosY(wnd, pt.y);
		
		wnd:Show();
		tblParam.curx = pt.x;
		tblParam.cury = pt.y;
		
		local offsetx = pt.x-tblParam.x;
		local offsety = pt.y-tblParam.y;
		local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
		tblParam.olddist = dist;
	
		return false;
	end
		
	tblParam.speed = tblParam.speed+tblParam.acce;
			
	--
	tblParam.curx = tblParam.curx+tblParam.speed*dir[tblParam.dir].x;
	tblParam.cury = tblParam.cury+tblParam.speed*dir[tblParam.dir].y;	
	pt.x = tblParam.curx;
	pt.y = tblParam.cury;
	
	local offsetx = pt.x-tblParam.x;
	local offsety = pt.y-tblParam.y;
	
	local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
	if(dist<=tblParam.speed or tblParam.olddist < dist) then		
		pt.x = tblParam.x;
		pt.y = tblParam.y;
		--wnd:SetHotPos(pt);
		HelperSetWindowTextPosX(wnd, pt.x);
		HelperSetWindowTextPosY(wnd, pt.y);
		
		if(tblParam.hide ~= nil) then
			wnd:Hide();
		end
		
		if(tblParam.func~= nil) then
			tblParam.func(wnd, tblParam.param);
		end		
		
		if(tblParam.reset ~= nil and tblParam.reset==true) then
			pt.x = tblParam.oldx;
			pt.y = tblParam.oldy;
			--wnd:SetHotPos(pt);
			HelperSetWindowTextPosX(wnd, pt.x);
			HelperSetWindowTextPosY(wnd, pt.y);
		end
		
		if(tblParam.del ~= nil) then
			wnd:Delete();
			wnd.update = nil;
		end
		
		return true;		
	end	
	
	tblParam.olddist = dist;	
	--wnd:SetHotPos(pt);	
	HelperSetWindowTextPosX(wnd, pt.x);
	HelperSetWindowTextPosY(wnd, pt.y);
	
	return false;
end


function EffectChildMove(wnd, tblParam)
	if(tblParam.speed== nil) then
		tblParam.speed = 1;
	end
		
	if(tblParam.acce == nil) then
		tblParam.acc = 0;
	end
	
	if(tblParam.dir == nil) then
		tblParam.dir = 1;
	end
	
	if(tblParam.fromx == nil) then
		local pt = LXZPoint:new_local();
		pt.x = wnd:GetExtX();
		pt.y = wnd:GetExtY();		
		tblParam.fromx = pt.x;
		tblParam.fromy = pt.y;
	end
	
	if(tblParam.range == nil) then
		tblParam.range = 10;
	end
	
	local pt = LXZPoint:new_local();
	local dir = {{x=0,y=1}, {x=0, y=-1},{x=1,y=0}, {x=-1,y=0}};	
	
	if(tblParam.x == nil) then
		local pt = LXZPoint:new_local();
		--wnd:GetHotPos(pt);
		pt.x = wnd:GetExtX();
		pt.y = wnd:GetExtY();
		
		pt.x = pt.x+tblParam.range*dir[tblParam.dir].x;
		pt.y = pt.y+tblParam.range*dir[tblParam.dir].y;
		
		tblParam.x = pt.x;
		tblParam.y = pt.y;		
	end
		
	if(tblParam.start == nil) then
		pt.x = wnd:GetExtX();
		pt.y = wnd:GetExtY();
		tblParam.oldx = pt.x;
		tblParam.oldy = pt.y;		
		tblParam.start = 1;			
		pt.x = tblParam.fromx;
		pt.y = tblParam.fromy;
		--wnd:SetHotPos(pt);		
		wnd:SetExtX(pt.x);
		wnd:SetExtY(pt.y);
		wnd:Invalidate();
		
		wnd:Show();
		tblParam.curx = pt.x;
		tblParam.cury = pt.y;
		
		local offsetx = pt.x-tblParam.x;
		local offsety = pt.y-tblParam.y;
		local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
		tblParam.olddist = dist;
	
		return false;
	end
		
	tblParam.speed = tblParam.speed+tblParam.acce;
			
	--
	tblParam.curx = tblParam.curx+tblParam.speed*dir[tblParam.dir].x;
	tblParam.cury = tblParam.cury+tblParam.speed*dir[tblParam.dir].y;	
	pt.x = tblParam.curx;
	pt.y = tblParam.cury;
	
	local offsetx = pt.x-tblParam.x;
	local offsety = pt.y-tblParam.y;
	
	local dist = math.sqrt(offsetx*offsetx+offsety*offsety);
	if(dist<=tblParam.speed or tblParam.olddist < dist) then		
		pt.x = tblParam.x;
		pt.y = tblParam.y;
		--wnd:SetHotPos(pt);
		wnd:SetExtX(pt.x);
		wnd:SetExtY(pt.y);
		wnd:Invalidate();
		
		if(tblParam.hide ~= nil) then
			wnd:Hide();
		end
		
		if(tblParam.func~= nil) then
			tblParam.func(wnd, tblParam.param);
		end		
				
		if(tblParam.reset ~= nil and tblParam.reset==true) then
			pt.x = tblParam.oldx;
			pt.y = tblParam.oldy;
			--wnd:SetHotPos(pt);
			wnd:SetExtX(pt.x);
			wnd:SetExtY(pt.y);
			wnd:Invalidate();
		end
		
		if(tblParam.del ~= nil) then
			wnd:Delete();
			wnd.update = nil;
		end
		
		return true;		
	end	
	
	tblParam.olddist = dist;	
	--wnd:SetHotPos(pt);	
	wnd:SetExtX(pt.x);
	wnd:SetExtY(pt.y);
	wnd:Invalidate();
	
	return false;
end


--[[
-t   时间
-b 初相位
-c  结束相位
-d 劲度系数
-a 振幅
-p  阻尼系数
easeOut: function(t,b,c,d,a,p){
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			if (!a || a < Math.abs(c)) { a=c; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (c/a);
			return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b);
		},

--]]

function EffectSpringMove(wnd, tblParam)
	if(tblParam.t == nil) then
		tblParam.t = 0;
	end
	
	if(tblParam.b == nil) then
		tblParam.b = 0;
	end
	
	if(tblParam.c == nil) then
		tblParam.c = 0;
	end
	
	if(tblParam.p == nil) then
		tblParam.p = tblParam.d*0.3;
	end
	
	if(tblParam.a == nil) then
		tblParam.a = 0;
	end
	
	if(tblParam.a ==0 or tblParam.a<math.abs(tblParam.c)) then
		tblParam.a=tblParam.c;
		tblParam.s =tblParam.p/4;
	else	
		tblParam.s =tblParam.p/(2*GameData.PI)*math.asin(tblParam.c/tblParam.a);
	end
	
	local t = tblParam.t/tblParam.d;
	
	local pt = LXZPoint:new_local();
	if(tblParam.start == nil) then		
		wnd:GetHotPos(pt);
		tblParam.start = 1;		
		tblParam.fromx = pt.x;
		tblParam.fromy = pt.y;	
				
		local da = tblParam.b;	
		if(tblParam.t ~= 0) then
			da = (tblParam.a*math.exp(-10*t) * math.sin( (t*tblParam.d-tblParam.s)*(2*GameData.PI)/tblParam.p ) + tblParam.c + tblParam.b);	
		end
		
		pt.y = tblParam.fromy+da;
		wnd:SetHotPos(pt);	
		tblParam.t = tblParam.t+1;
		return false;
	end	
	
	if(math.floor(t)==1) then
		local da = tblParam.b+tblParam.c;	
		pt.y = tblParam.fromy+da;
		pt.x = tblParam.fromx;
		wnd:SetHotPos(pt);	
		return true;
	end
	
	local da = (tblParam.a*math.exp(-10*t) * math.sin((t*tblParam.d-tblParam.s)*(2*GameData.PI)/tblParam.p ) + tblParam.c + tblParam.b);	
	pt.y = tblParam.fromy+da;
	pt.x = tblParam.fromx;
	wnd:SetHotPos(pt);	
	tblParam.t = tblParam.t+1;
	--LXZMessageBox("da:"..da)
	
	return false;
end



function EffectFaceIn(wnd, tblParam)
	WindowRefLogic.alpha = wnd:GetAttributeNameRef("CLXZWindow:Mask:alpha", WindowRefLogic.alpha);		
	
	if(tblParam.step==nil) then
		tblParam.step = 2;
	end
	
	if(tblParam.from==nil) then
		tblParam.from=100;
	end
	
	if(tblParam.start==nil) then
		tblParam.start = 1;
		tblParam.old = tonumber(wnd:GetAttribute(WindowRefLogic.alpha));
		wnd:SetAttribute(WindowRefLogic.alpha, tostring(tblParam.from));
		return false;
	end
	
	local alpha = tonumber(wnd:GetAttribute(WindowRefLogic.alpha));
	alpha = alpha+tblParam.step;	
	if(alpha>255) then
		alpha = 255;
	end
	
	wnd:SetAttribute(WindowRefLogic.alpha, tostring(alpha));
	
	if(LXZAPI_timeGetTime()>tblParam.time) then
		wnd:SetAttribute(WindowRefLogic.alpha, tostring(tblParam.old));
		return true;
	end
	
	return false;
end

function EffectSelectElement(wnd, tblParam)
	if(wnd.selected == nil) then
		return true;
	end
	
	if(wnd:GetClassName()~="Element") then	
		wnd.selected = nil;
		return true;
	end
	
	if(tblParam.oldselected == nil or wnd.selected ~= tblParam.oldselected or wnd.forceupdate~= nil ) then	
		tblParam.oldselected = wnd.selected;
		wnd.forceupdate= nil;
		local pic = "";
		if(wnd.selected == true) then
			if(IS_CONTINUE==true) then
				pic = "elementselbk";
			else
				pic = "elementsumbk";
			end
		else
			pic = "elementbk";
		end
		
		HelperSetWindowPicture(wnd, pic);		
		if(wnd.selected == false) then
			wnd.selected = nil;
			return true;
		end		
	end
	
	return false;
end

function EffectFaceOut(wnd, tblParam, bStop)
	WindowRefLogic.alpha = wnd:GetAttributeNameRef("CLXZWindow:Mask:alpha", WindowRefLogic.alpha);		
	
	if(tblParam.step==nil) then
		tblParam.step = 2;
	end
	
	if(tblParam.from==nil) then
		tblParam.from=100;
	end
	
	if(tblParam.End==nil) then
		tblParam.End=0;
	end
	
	if(tblParam.playcnt == nil) then
		tblParam.playcnt=1;
	end
	
	if(tblParam.start==nil) then
		tblParam.start = 1;
		if(tblParam.old==nil) then
			tblParam.old = tonumber(wnd:GetAttribute(WindowRefLogic.alpha));
		end
		
		wnd:SetAttribute(WindowRefLogic.alpha, tostring(tblParam.from));
		return false;
	end
		
	local alpha = tonumber(wnd:GetAttribute(WindowRefLogic.alpha));
	alpha = alpha-tblParam.step;	
	if(alpha<=tblParam.End) then
		tblParam.playcnt = tblParam.playcnt-1;
		if(tblParam.playcnt<=0) then
			alpha = tblParam.End;
			wnd:SetAttribute(WindowRefLogic.alpha, tostring(tblParam.old));
			if(tblParam.hide ~= nil) then
				wnd:Hide();
				wnd.update = nil;
			end
			
			if(tblParam.del~=nil) then
				wnd:Delete();
				wnd.update = nil;
			end				
			return true;
		else
			alpha = tblParam.from;
		end
	end
	wnd:SetAttribute(WindowRefLogic.alpha, tostring(alpha));

	return false;
end


function UpdateWindow()
	local tbl = {};
	local count = 0;
	local ref = 0;
	local cnt = 0;
	for k,wnd in pairs(tblUpdateWnd) do
		if(wnd.updateself == nil) then
			cnt = UpdateWnd(wnd,k);
			ref = ref+cnt;
		end
		count = count+1;
	end
	
	--LXZAPI_OutputDebugStr("tblUpdateWnd:"..count.." ref:"..ref);
	
	for k,wnd in pairs(tblUpdateWnd) do
		if(wnd ~= nil and wnd:IsDeleted() == false) then
			tbl[wnd:GetID()] = wnd;
		end
	end
	
	tblUpdateWnd = tbl;
	
end


function UpdateWnd(wnd,k)
	--
	if(wnd == nil or wnd.update == nil or wnd:IsDeleted() == true) then
		return 0;
	end

	local ref = 0;
	for i = 1, table.getn(wnd.update),1 do		
		local v = wnd.update[i];						
		if(v ~= nil and v.p~=nil and v.id==k and v.f(wnd, v.p)==true) then					
			v.p = nil;			
			v.f = nil;
			if(v.thread ~= nil) then
				coroutine.resume(v.thread);
			end
		else
			ref = ref+1;
		end
		
		if(wnd.update == nil or wnd:IsDeleted()==true) then
			wnd.update = nil;
			tblUpdateWnd[k] = nil;
			return 0;
		end						
	end		
	
	return ref;
end

function ResetHandPosition()
	local root = HelperGetRoot();	
	local pt = LXZPoint:new_local();		
	local	action = GameData.helpactionlist[GameData.helpindex];
	if(action~= nil) then
			local hand  = root:GetLXZWindow("Game:help:hand");
			local indexctrl1 = action.pos[GameData.helpani];
			local row1, col1 = GetRowColByIndex(indexctrl1);
			pt.x, pt.y = GetPosByRowCol(row1,col1);
			pt.x = pt.x+GRID_WIDTH*GameData.scale*0.5;
			pt.y = pt.y-GRID_WIDTH*GameData.scale*0.5;	
			hand:SetHotPos(pt);
	end
end

local function OnUpdate(window, msg0, sender)
	--
	local root = HelperGetRoot();	
	local main = root:GetLXZWindow("Game:main");
	local pt = LXZPoint:new_local();		
	
	UpdateWindow();
		
	if(IS_ANIMATE_HELP==true) then
		
		if(LXZAPI_timeGetTime()>=GameData.helptimer+HELP_TIMER_INTERVAL) then
			local action = GameData.helpactionlist[GameData.helpindex];
			if(action~=nil) then
				if(AnimateHelpAction(action)==true) then
					GameData.helpindex = GameData.helpindex+1;
					GameData.helpani = 1;
					
					--reset hand position
					ResetHandPosition();					
				end
			else
				--end
				IS_ANIMATE_HELP = false;	
				if(GameData.helpthread ~= nil) then
					coroutine.resume(GameData.helpthread);
					GameData.helpthread=nil;
				end
				
				root:GetLXZWindow("Game:help:return"):DelBit(STATUS_IsDisable);
				
			end
			GameData.helptimer = LXZAPI_timeGetTime();
		end
	end
	
		local corecfg = ICGuiGetLXZCoreCfg();
	if(GameData.state ~= STATE_RUN or corecfg.IsEditing==true) then
		return;
	end
		
	local time = 0;
	if(GAME_MODE==GAME_MODE_COMBO) then
		time = GameData.timer+LXZAPI_GetFrameTime()/1000.0;
	else
		time = GameData.timer-LXZAPI_GetFrameTime()/1000.0;
	end
	if(time<0) then
		time = 0;
	end
	
	--[[local function  IsInRange(a)
		return (GameData.timer>a and time<a);
	end
	
	if(IsInRange(120)==true) then
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectColorText, {interval=30, playcnt=30, frame={{255,255,255,255},{255,255,255,100}}});
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectPlaySound, {interval=500, playcnt=1, frame={"timenotify.wav"}});
	elseif(IsInRange(60)==true)  then
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectColorText, {interval=30, playcnt=30, frame={{255,255,255,255},{255,255,255,100}}});
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectPlaySound, {interval=500, playcnt=2, frame={"timenotify.wav"}});
	elseif(IsInRange(30)==true) then		
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectColorText, {interval=30, playcnt=30, frame={{255,255,255,255},{255,255,255,100}}});
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectPlaySound, {interval=500, playcnt=3, frame={"timenotify.wav"}});
	elseif(IsInRange(10)==true) then		
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectColorText, {interval=30, playcnt=200, frame={{255,255,255,255},{255,255,255,100}}});
		AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectPlaySound, {interval=500, playcnt=10, frame={"timenotify.wav"}});
		--PlayEffect("timenotify.wav");
	end--]]
	
	GameData.timer = time;
	time = math.floor(time);	
	
	local min = math.floor(time/60);
	local sec = time-min*60;
		
	local sec10 = math.floor(sec/10);
	local sec1 = sec-sec10*10;
	
	local timetxt = "";
	if(min>0) then
		timetxt = min.."'";
	end
	
	if(sec10<=0) then
		timetxt = timetxt.."0"..sec1;
	else
		timetxt = timetxt..sec;
	end
	
	local root = HelperGetRoot();
	HelperSetWindowText(root:GetLXZWindow("Game:timer"), timetxt);
	
	if(IsGameWin()) then
		GameWinProc();
		--wndarr:delete();
		return;
	elseif(IsGameFail()) then	
		GameFailProc();
		--wndarr:delete();
		return;
	end	
	
end

function GetLastRowCol()
	local intarr = GameData.numarray;
	if(intarr:size()<=0) then
		return nil, nil;
	end
	
	local indexctrl = intarr:get(intarr:size()-1);
	local row, col = GetRowColByIndex(indexctrl);
	
	return row, col;	
end

function GetLastCoinValue()
	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	local intarr = GameData.numarray;
	if(intarr:size()<=0) then
		return 0;
	end
	
	for i=intarr:size()-1, 0, -1 do
		local indexctrl = intarr:get(i);
		local row, col = GetRowColByIndex(indexctrl);
		local coin = main:GetChild(col.."|"..row);
		if(coin ~= nil) then
			local val = tonumber(HelperGetWindowText(coin));
			return val;		
		end	
		
	end
	
	return 0;
end

local function IsLastElement()
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:main");
	local child = wnd:GetFirstChild();
	
	local count = 0;
	while child ~= nil do
		if(child:GetClassName()=="Element") then
			count = count+1;
		end
	
		child = child:GetNextSibling();
	end
	
	if(count<=1) then
		return true;
	end
	
	return false;	
end

local function IsWillGameWin()
	local wincoin = GetWinCoin();
	if(GameData.bonus>=wincoin) then
		return true;
	end
	
	return false;
end

local function  IsTimerOver()
	if(GAME_MODE == GAME_MODE_COMBO) then
		return	false
	end
	
	return (GameData.timer<=0);
end

function GetWinCoin()
	if(GAME_MODE == GAME_MODE_COMBO) then
		return GameCfg[GameData.level].wincoin2;
	else
		return GameCfg[GameData.level].wincoin;
	end
	
	return 0;
end

function IsGameWin()
	
	if(IsLastElement()==false  and IsTimerOver()==false) then
		return false;
	end

	if(GameData.bonus>=GetWinCoin()) then
		return true;
	end
	
	return false;
end


function IsGameFail()

	if(IsLastElement()==false and IsTimerOver()==false) then
		return false;
	end

	if(GameData.bonus<GetWinCoin()) then
		return true;
	end
	
	return false;
end

function CancelSelectedElement()
	--
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:control");
	wnd:ClearChilds();
	
	local main = root:GetLXZWindow("Game:main");
	local intarr = GameData.numarray;
	for i = 0, intarr:size()-1, 1 do
		local index = intarr:get(i);
		local row, col = GetRowColByIndex(index);
		local element = main:GetChild(col.."|"..row);
		if(element~= nil) then
			element.selected = false;
		end		
	end
	
	intarr:zero_size();
	IS_CONTINUE = false;

end


function PrevProcElement()

	local root = HelperGetRoot();	
	local main = root:GetLXZWindow("Game:main");

	local wndarr = WndArray:new();
	local intarr = GameData.numarray;
	
	local arrpos = {};
	local arrcoin = {};
	local arrcolor = {};
	
	local cnt = 0;
	for i=0,intarr:size()-1,1 do
			local indexctrl = intarr:get(i);
			local row, col = GetRowColByIndex(indexctrl);
			local coin = main:GetChild(col.."|"..row);
			
			local coinnum = 0;	
			local color = 0;
		
			if(coin ~= nil) then
				wndarr:push(coin);
				coinnum = tonumber(HelperGetWindowText(coin));		
				local fnt = HelperGetWindowTextFont(coin);
				local r,g,b,a = HelperGetWindowTextColor(coin);
				if(fnt=="yellownum.fnt" or r ~= 255 or g ~= 255 or b ~= 255) then
					color = 1;
				end
			end				
			
			table.insert(arrpos, indexctrl);
			table.insert(arrcoin, coinnum);
			table.insert(arrcolor, color);
	end
	
	return wndarr, arrpos, arrcoin,arrcolor;
end

function SaveAction(action)
	local cnt = table.getn(GameData.actionlist);
	table.insert(GameData.actionlist,  action);
	--table.insert(GameData.helpactionlist,  action);
	if(cnt>=5) then
		--local actionback = PopFrontAction();
		--DeleteAction(actionback);
	end	
end

function PopFrontAction()
	local action =  GameData.actionlist[1];
	table.remove(GameData.actionlist, 1);
	return action;
end

function PopBackAction()
	local index = table.getn(GameData.actionlist);
	--LXZMessageBox("PopBackAction:"..index);
	local action = GameData.actionlist[index];
	table.remove(GameData.actionlist, index);	
	--table.remove(GameData.helpactionlist, index);
	
	return action;
end

function DeleteAction(action)
	
	local intarr = action.pos;
	--intarr:delete();
	
	intarr = action.coin;
	--intarr:delete();
	
	action = nil;	

end

function MayGotBonus()

	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	local intarr = GameData.numarray;

	--clear coin	
	local nSum = 0;
	local nPrev = 0;
	
	for i=0,intarr:size()-1,1 do
		local indexctrl = intarr:get(i);
		local row, col = GetRowColByIndex(indexctrl);
		local coin = main:GetChild(col.."|"..row);
		if(coin ~= nil and coin:GetClassName()=="Element") then
			local val = tonumber(HelperGetWindowText(coin));
							
			--nSum = val;
			if(val>nPrev) then
				nSum = nSum+val;
			elseif(val<=nPrev) then
				nSum = nSum-val;
			end	
			
			--
			nPrev = val;		
		end	
		
	end
	
	if(nSum<0) then
		nSum = 0;
	end
		
	return nSum;
	
end

function AddEffect(effectname, pt)
	local root = HelperGetRoot();
	local effect = root:GetLXZWindow("Game:effect");	
	local bomb = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:"..effectname);
	bomb:SetHotPos(pt);
	effect:AddChild(bomb);
	bomb:Show();
	
	local func = function()
		bomb:Delete();
	end
		
	AddWndUpdateFunc(bomb, EffectTimer, {time=LXZAPI_timeGetTime()+2000, func=func});
	
	--
	local cnt = GameData.newhitcnt+5;
	if(cnt>50) then
		cnt = 50;
	end 
	
	HelperSetParticleEmission(bomb,  cnt);
		
end


function OnAnimateEffect(window, msg0, sender)
	
	
	local root = HelperGetRoot();	
	local animateeffect = root:GetLXZWindow("Game:animateeffect");
	local main = root:GetLXZWindow("Game:main");
	
	
	local timersys = CLXZTimerSystem:Instance();
	local leftcount = timersys:GetTimerLeftCount(HANDLE_ANIMATEEFFECT);
	local cnt = animateeffect:GetChildCount();
	local index = cnt-leftcount;
	
	--LXZMessageBox("OnAnimateEffect:"..leftcount.." index:"..index.."  cnt:".. cnt);
	
	local child = animateeffect:GetChild(tostring(index-1+5));
	if(child) then
		child:Show();
	end
	
	if(leftcount == 0) then
		animateeffect:ClearChilds();
		animateeffect:Hide();
		--main:Show();
	end

end

function AddAnimateEffect(name, wndarr)
	local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
	HelperSetWindowText(wnd, name);
	wndarr:push(wnd);
end


function CreateMoveEffect(effecttbl, IsExtraEffect, sndfile)
	local root = HelperGetRoot();

	--local co = coroutine.create(function (thread)	
		local cnt = math.floor((table.getn(effecttbl)+1)/2);
		local frm = LXZPoint:new_local();	
		for i=1,table.getn(effecttbl),1 do
			local info = effecttbl[i];
			
			frm.x = info.frmx;
			frm.y = info.frmy;
		
			local wnd = nil;
			local from = 255;
			if(IsExtraEffect~= nil and IsExtraEffect==true) then		
				wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:ExtraEffect");
				wnd.update = {};
				AddWndUpdateFunc(wnd, EffectZoomInFunc, {step=(0.01+0.004*table.getn(effecttbl)),from=0.5,max=1.5,playcnt=1});
				--from = from+table.getn(effecttbl);
			else
				wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:CoinEffect");
				wnd.update = {};
			end		
			
			HelperSetWindowText(wnd, info.name);
			wnd:SetHotPos(frm);	
			root:GetLXZWindow("Game:effect"):AddChild(wnd);
			--HelperWindowMoveTo(wnd, info.tox, info.toy, 100, 0);		
			
			--			
			AddWndUpdateFunc(wnd, EffectMove, {speed=3*GameData.scale, dir=2, range=50, acce=0, fromx = frm.x, fromy = frm.y,x=info.tox, y=info.toy, del=true});
			AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+1000, from=from,step=10/GameData.scale,del=true,playcnt=1});
			
			--set mini font
			HelperSetWindowTextFont(wnd, "mininum1.fnt");	
			
			--AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+50},thread);			
			--coroutine.yield();
			
			--PlayEffect("click.wav");
		end
--	end);

	 if(sndfile~=nil) then
		AddWndUpdateFunc(root, EffectPlaySound, {interval=200, playcnt=cnt, frame={sndfile}});		
	 end
	
--	coroutine.resume(co, co);		
	
end

EFFECT_MOVE_DISTANCE = 150;
--ExtraEffect

function CreateBonusEffect(num, pt, bContinue)
	local root = HelperGetRoot();
	local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Bonus");
	local pp = LXZPoint:new_local();
	root:GetPos(pp);
	
	pt.y = pt.y-GRID_WIDTH;
	if((pt.x+GRID_WIDTH/2)>(pp.x+root:GetWidth()))then
		pt.x = pp.x+root:GetWidth()-GRID_WIDTH/2;
	end
		
	local co = coroutine.create(function (thread)	
	
		root:GetLXZWindow("Game:effect"):AddChild(wnd);
		HelperSetWindowText(wnd, tostring(num));
		
	--[[	local y = (2.5*GRID_WIDTH+OFFSET_Y)*GameData.scale;	
		if(root:GetLXZWindow("Game:blocktips"):IsVisible()==false) then
			y = (1*GRID_WIDTH+OFFSET_Y)*GameData.scale;	
		end
				
		--wnd:Zoom(GameData.scale);
		
	--	pt.y = y;
	--	pt.x = root:GetWidth()/2;--]]
		--wnd:Zoom(GameData.scale);
		wnd:SetHotPos(pt);
	
		wnd:Show();	
		if(bContinue == true) then
			AddWndUpdateFunc(wnd, EffectZoomInFunc,  {time=LXZAPI_timeGetTime()+300,step=0.2,from=0.5,max=1.5, noreset=true}, thread);	
		else
			AddWndUpdateFunc(wnd, EffectZoomInFunc,  {time=LXZAPI_timeGetTime()+300,step=0.2,from=0.5,max=1.2, noreset=true}, thread);	
		end
		coroutine.yield();
		
		--	
		
		AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=10}, thread);
		AddWndUpdateFunc(wnd, EffectMove,{speed=4*GameData.scale, dir=2, range=50, acce=0, fromx = pt.x, fromy = pt.y,x=pt.x, y=pt.y-150*GameData.scale});
		coroutine.yield();
		
		--
		wnd:Delete();
	
	end);
	
	coroutine.resume(co, co);
end

function CreateBlockEffect(num)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:blocktips");
	local pt = LXZPoint:new_local();
		
	local co = coroutine.create(function (thread)	
	
		HelperSetWindowText(wnd:GetChild("num"), tostring(num));
		
		local y = (GRID_WIDTH+OFFSET_Y)*GameData.scale;		 
		wnd:GetHotPos(pt);
		pt.y = y;
		wnd:SetHotPos(pt);
	
		wnd:Show();	
		AddWndUpdateFunc(wnd, EffectZoomInFunc,  {time=LXZAPI_timeGetTime()+300,step=0.1,from=0.5,max=1.2, noreset=true}, thread);	
		coroutine.yield();
		
		--	
		
		AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=10}, thread);
		AddWndUpdateFunc(wnd, EffectMove,{speed=2*GameData.scale, dir=2, range=50, acce=0, fromx = pt.x, fromy = pt.y,x=pt.x, y=pt.y-50*GameData.scale});
		coroutine.yield();
		
		wnd:Hide();
		wnd:SetHotPos(pt);
	
	end);
	
	coroutine.resume(co, co);

end

function CaculateBonus(main, intarr,  IsAction)
	local nSum = 0;
	local nPrev = 0;
	local nCnt = 0;
	local nOrder = 0;
	local bContinue = true;
	local pt = LXZPoint:new_local();
	local effecttbl = {};
	
	for i=0,intarr:size()-1,1 do
		local indexctrl = intarr:get(i);
		local row1, col1 = GetRowColByIndex(indexctrl);
		local coin = main:GetChild(col1.."|"..row1);
		if(coin ~= nil) then
			local val = tonumber(HelperGetWindowText(coin));
			
			--
			local IsAsc = true;
			
			--nSum = val;
			if(val>nPrev) then
				nSum = nSum+val;
				nOrder = nOrder+1;
				IsAsc = true;
			elseif(val<=nPrev) then
				nSum = nSum-val;
				nOrder = nOrder-1;
				IsAsc = false;
			end					
					
			if(bContinue==true and math.abs(nPrev-val)~=1 and nPrev~=0) then
				bContinue = false;
				k1=1;
			end
			
			--
			nCnt = nCnt+1;
			
			--
			nPrev = val;			
			
			--delete and add bomb effect
			if(IsAction==true)  then			
				coin:GetHotPos(pt);
				
				AddEffect("BombEffect", pt);	
				
				--
				if(IsAsc==true) then
					table.insert(effecttbl, {name="+"..val, frmx=pt.x, frmy=pt.y,  tox=pt.x, toy=pt.y-EFFECT_MOVE_DISTANCE*GameData.scale});				
				else
					table.insert(effecttbl, {name="-"..val, frmx=pt.x, frmy=pt.y,  tox=pt.x, toy=pt.y-EFFECT_MOVE_DISTANCE*GameData.scale});				
				end
							
				coin:Delete();
			end
		end	
		
	end
	
	return nSum, nCnt,nOrder,bContinue, effecttbl;
end

function FingerUpProc(pt)
	--
	local root = HelperGetRoot();
	local control = root:GetLXZWindow("Game:control");
	local main = root:GetLXZWindow("Game:main");
	local effect = root:GetLXZWindow("Game:effect");
	local background = root:GetLXZWindow("Game:background");
	local animateeffect = root:GetLXZWindow("Game:animateeffect");
	
	control:ClearChilds();
	main:ScreenToWindowPos(pt);
	ClearPanel();
		
	--
	local row,col = GetRowColByPos(pt.x, pt.y);
	if(IsCanMoveTo(row, col)==false) then
		return;
	end
	

	local isinarr = false;
	local curindex = GetIndexByRowCol(row,col);
	local intarr    = GameData.numarray;
	for i = 0, intarr:size()-1,1 do
		if(intarr:get(i)==curindex) then
			isinarr = true;
			break;
		end
	end
	
	local element = main:GetChild(col.."|"..row);
	if(element ~= nil and element:GetClassName()~="Element") then
		return;
	end
	
	if(isinarr==false) then
		intarr:push(curindex);
	end
		
	local wndarr, intarrpos, intarrcoin,intarrcolor = PrevProcElement();
	if(wndarr:size()<=1) then
		wndarr:delete();
		CancelSelectedElement();
		
		--
		if(IS_MAKE_GAME==MAKE_GAME_ELEMENT and element~= nil) then			
			local maxcoin = GetMaxCoin(GameData.level)+5;--GameCfg[GameData.level].maxcoin;
			local coin = tonumber(HelperGetWindowText(element))+1;
			coin = 1+math.mod(coin-1, maxcoin);
			HelperSetWindowText(element, tostring(coin));		
				--LXZMessageBox("coin:"..coin);
		end		
	
		return;
	end
	
	--
	if(IS_MAKE_GAME~=0) then
		local curcoin = 1;
		for i=0,intarr:size()-1,1 do
			local indexctrl = intarr:get(i);
			local row, col = GetRowColByIndex(indexctrl);
			local coin = main:GetChild(col.."|"..row);
			
			if(i~=0) then
				if(coin == nil) then					
					pt.x, pt.y = GetPosByRowCol(row, col);
					local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
					main:AddChild(wnd);				
					wnd:SetHotPos(pt);
					wnd:SetName(col.."|"..row);
					coin = wnd;
				end
								
				local maxcoin = GetMaxCoin(GameData.level);--GameCfg[GameData.level].maxcoin;
				curcoin = 1+math.mod(curcoin, maxcoin);
				
				HelperSetWindowText(coin, tostring(curcoin));			
				
			else
				curcoin = tonumber(HelperGetWindowText(coin));
			end
			
			HelperSetWindowTextColor(coin,  mkcolor.r,  mkcolor.g,  mkcolor.b,  mkcolor.a);
			
		end
		return;
	end
	
	--clear coin	
	local oldbonus = GameData.bonus;
	
	--	
	GameData.newhitcnt =wndarr:size();
	wndarr:zero_size();
	
	--

	
	--else
	local bAllSameOrder = false;
	local k1 = 2;
	local k2 = 1;
	local nSum, nCnt, nOrder, bContinue, effecttbl = CaculateBonus(main, intarr, true);
	
	if(bContinue==false) then		
		k1=1;
	end
	
	if(nCnt == nOrder) then
		bAllSameOrder = true;
		k2 =2;
	end
	
	local willwinevent = false;
			
	--caculate bonus
	local bonus = 0;
	if(nSum > 0) then
		local coe     = GetMaxCoin(GameData.level)+GameData.level;
		if(nOrder<=0) then
			nOrder = 1;
		end
		
		bonus = nSum+coe*nCnt*nOrder*k1*k2;
				
	--	LXZMessageBox("Sum:"..nSum.." nCnt:"..nCnt.." k1:"..k1.." k2:"..k2.." nOrder:"..nOrder);		
		if(bContinue==true and GameData.maxhitcnt<nCnt and bAllSameOrder == true) then
			GameData.maxhitcnt = nCnt;			
		end
		
		local willwin = IsWillGameWin();		
		GameData.bonus = 	GameData.bonus+bonus;
		
		--		
		
		if(willwin==false and IsWillGameWin()) then
			willwinevent = true;
		end
		
		if(GameData.highscore<GameData.bonus) then
			GameData.highscore = GameData.bonus;	
			--EffectAnimateNum1(root:GetLXZWindow("Game:highscore"), tostring(GameData.highscore), nil, 50);
			SaveDB(GameData.level, GameData.highscore);
		end
				
	
		EffectAnimateNum1(root:GetLXZWindow("Game:score"), tostring(GameData.bonus), nil, 50);		
		if(GameData.bonus > GameData._highscore) then
			GameData._highscore = GameData.bonus;			
		end
				
		--create
		pt.x, pt.y = GetPosByRowCol(row, col);
		local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
		main:AddChild(wnd);
		HelperSetWindowText(wnd, tostring(nSum));
		wnd:SetHotPos(pt);
		wnd:SetName(col.."|"..row);
		wnd.update = nil;
		--HelperSetWindowTextColor(wnd,  0,  100,  nSum,  255);
		HelperSetWindowTextFont(wnd, "yellownum.fnt");
		if(nSum>=100) then
			HelperSetWindowTextScale(wnd, 0.4*GameData.scale);
		--	LXZMessageBox("nSum:"..nSum);
		elseif(nSum>=1000) then		
			HelperSetWindowTextScale(wnd, 0.25*GameData.scale);
		end		
	end
	
	--clear
	--intarr:zero_size();
	SaveAction({pos=intarrpos,  coin=intarrcoin, color=intarrcolor, nrow=row, ncol=col, oldbonus=oldbonus, newcoin=nSum, newbonus=GameData.bonus});	
	
	--
	--
	local sndfile = "desc.wav";
	if(willwinevent == true) then
		sndfile = "gamewin.wav";
	elseif(bContinue == true) then
		sndfile = "continue.wav";	
	elseif(bAllSameOrder==true) then						
		--PlayEffect("zhangsheng.wav");
		sndfile = "asc.wav";
	else
		--PlayEffect("flystar.wav");		
		sndfile = "desc.wav";				
	end	
	
	if(bContinue==true) then			
			CreateMoveEffect(effecttbl, true, sndfile);
			CreateBlockEffect(nOrder);			
	else
			CreateMoveEffect(effecttbl, false, sndfile);
	end
		
	pt.x, pt.y = GetPosByRowCol(row, col);
	CreateBonusEffect(bonus, pt, bContinue);
	--	

		
	--clear
	wndarr:delete();		
	
	
end

local function OnFingerUp(window, msg0, sender)

	if(GameData.state ~= STATE_RUN) then
		return;
	end

	if(os.time()<GameData.time) then
		return;
	end
	
	--LXZMessageBox("OnFingerUp");
	local x = msg0:int();
	local y = msg0:int();
	--FingerMoveProc(x,y);
	
	local pt = LXZPoint:new_local();		
	pt.x = x;
	pt.y = y;
	
	if(IS_CLICKDOWN == false) then
		CancelSelectedElement();
		return;
	end
	
	IS_CLICKDOWN = false;
		
	--
	FingerUpProc(pt);
	
	--
	CancelSelectedElement();
end

function GameFailProc()
		GameData.state = STATE_NULL;
		UpdateDataToUI();
		
		local root = HelperGetRoot();
		local wnd = root:GetLXZWindow("Game:fail");
		root:GetLXZWindow("Game:bonustips"):Hide();
		--root:GetLXZWindow("Game:main"):Hide();
		
		HelperSetWindowPictureFile(wnd:GetChild("replaybtn"), "game3.png");
		HelperSetWindowPicture(wnd:GetChild("replaybtn"), "replay");
		
		HelperSetWindowPictureFile(wnd:GetChild("exitbtn"), "game3.png");
		HelperSetWindowPicture(wnd:GetChild("exitbtn"), "exitbtn");
		
		--wnd:Show();
		
		--PlayEffect("gamefail.wav");
		
		--
		--LXZMessageBox("GameFailProc");
		root:GetLXZWindow("Game:control"):ClearChilds();
		SaveDB(GameData.level, GameData.highscore);
		
		LXZAPI_CallSystemAPI("SendGameCenterPoint", GetSumOfAllScores());
		
		--
		EffectAnimateFail();		
end

function GameWinProc()
		GameData.state = STATE_NULL;
		UpdateDataToUI();
	
		local root = HelperGetRoot();
		local wnd = root:GetLXZWindow("Game:win");
		root:GetLXZWindow("Game:bonustips"):Hide();
		
				
		HelperSetWindowPictureFile(wnd:GetChild("nextstagebtn"), "game3.png");
		HelperSetWindowPicture(wnd:GetChild("nextstagebtn"), "nextstagebtn");
		
		HelperSetWindowPictureFile(wnd:GetChild("exitbtn"), "game3.png");
		HelperSetWindowPicture(wnd:GetChild("exitbtn"), "exitbtn");
		
		--wnd:Show();		
		
		--PlayEffect("gamewin.wav");
		
		--
		--LXZMessageBox("GameWinProc");
		SaveDB(GameData.level, GameData.highscore);
		
		--
		LXZAPI_CallSystemAPI("SendGameCenterPoint", GetSumOfAllScores());
		
		if(GameData.level==GameData.highlevel) then
			SaveDB(GameData.level+1, 0);
			GameData.highlevel = GameData.level+1;
		end
		
		root:GetLXZWindow("Game:control"):ClearChilds();
		EffectAnimateWin();
		HideGameHeadWindow();
end

function IntIsInNumArray(num)
	local intarr = GameData.numarray;
	for i=0,intarr:size()-1,1 do
		local effect = intarr:get(i);
		if(num==effect) then
			return effect;
		end		
	end
end

function GetRowColByIndex(index)
	local row = math.floor(index/MAX_COL);
	local col  = math.mod(index, MAX_COL);
	return row, col;
end

function GetRowColByWnd(wnd)
	local name = wnd:GetName();
	local _,_,col, row = string.find(name, "(%d+)|(%d+)");
	--LXZMessageBox("name:"..name.." col:"..col.." row:"..row);
	return  row,col;
end

function GetIndexByRowCol(row, col)
	local index = row*MAX_COL+col;
	return index;
end

function IsPrevLastMoveTo(row, col) 
	local intarr = GameData.numarray;
	local size = intarr:size();
	if(size<=1) then
		return false;
	end
	
	local index = intarr:get(size-2);
	local r,c = GetRowColByIndex(index);
		
	if(c == col and r == row) then
		return true;
	end
	
	return false;
	
end

function IsCanMoveTo(row, col)
	if(row < 0 or col<0 or col>=MAX_COL or row >=MAX_ROW) then
		return false;
	end
	
	--
	local intarr = GameData.numarray;
	local size = intarr:size();
	if(size<=0) then
		return true;
	end
	
	local index = intarr:get(size-1);
	local r,c = GetRowColByIndex(index);
	
	--local 
	local root   = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	local element = main:GetChild(col.."|"..row);
	if(element ~= nil and element:GetClassName()=="Wall") then
		return false;	
	end
	
	local num = math.abs(tonumber(r)-row)+math.abs(tonumber(c)-col);
	if(num>1) then
		return false;
	end
	
	return true;
end

function BackPrevMoveStep()
	local root = HelperGetRoot();
	local intarr = GameData.numarray;
	local size = intarr:size();
	if(size<=0) then
		return true;
	end
	
	local index = intarr:get(size-1);
	local row,col = GetRowColByIndex(index);
			
	local control = root:GetLXZWindow("Game:control");
	local effect = control:GetChild(col.."|"..row);
	if(effect ~= nil) then		
		if(size>=2) then
			local pindex = intarr:get(size-2);
			local prow,pcol = GetRowColByIndex(pindex);
			local ctrl = control:GetChild(pcol.."|"..prow);
			if(ctrl ~= nil) then
				local e = ctrl:GetChild((col-pcol).."|"..(row-prow));
				if(e~= nil) then
					e:Hide();		
				else
					LXZMessageBox("child3:"..pcol.."|"..prow.." "..(col-pcol).."|"..(row-prow));
				end
			else
				LXZMessageBox("child3:"..pcol.."|"..prow);
			end
		end		
		effect:Delete();		
	end
	
	intarr:erase(size-1, false);
	if(intarr:size()>0) then
		index =  intarr:get(intarr:size()-1);
		local prow,pcol = GetRowColByIndex(index);
		local element = root:GetLXZWindow("Game:main:"..pcol.."|"..prow);
		if(element ~= nil) then
			EffectCircleButtonNoSound(element, nil, true);			
		end
	end
	
	--
	CheckContinue(root:GetLXZWindow("Game:main"), intarr, intarr:size());
	
	--
	local element = root:GetLXZWindow("Game:main:"..col.."|"..row);
	if(element ~= nil) then
		element.selected = false;		
	end
		
	--
	ChangePanel();
	
	PlayEffect("backmove.wav");
	
end


function PlayEffect(name)
	local audio = SimpleAudioEngine:sharedEngine();
	audio:playEffect(name, false);
	
	--local wave = CLXZWave:new_local();	
	--wave:Load(name);		
	--wave:Play();
end

function LinkMoveEffect(row, col,  prow, pcol, main)
	local root = HelperGetRoot();			
	local pt = LXZPoint:new_local();
	
	pt.x, pt.y = GetPosByRowCol(row, col);	
	local control = root:GetLXZWindow("Game:control");	
	local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:moveeffect1");
	control:AddChild(wnd );
	wnd:SetName(col.."|"..row);
	wnd :SetHotPos(pt);
	wnd:GetChild("0|0"):Show();
	wnd:GetChild("1|0"):Hide();
	wnd:GetChild("0|1"):Hide();
	wnd:GetChild("-1|0"):Hide();
	wnd:GetChild("0|-1"):Hide();
	wnd.update = nil;
	wnd:GetChild("0|0").update = nil;
	wnd:GetChild("1|0").update = nil;
	wnd:GetChild("0|1").update = nil;
	wnd:GetChild("-1|0").update = nil;
	wnd:GetChild("0|-1").update = nil;
	
	--local intarr = GameData.numarray;
	if(prow == nil or pcol==nil) then
		IS_CONTINUE = true;
		return;
	end
		
--	local index = intarr:get(intarr:size()-1);
--	local prow,pcol = GetRowColByIndex(index);	
	local child1= (pcol-col).."|"..(prow-row);
	local child2 = (col-pcol).."|"..(row-prow);
	--LXZMessageBox("child1:"..child1.." child2:"..child2);
	local wnd1 = control:GetChild(pcol.."|"..prow);
	if(wnd1~=nil) then
		if(wnd1:GetChild(child2)~=nil) then
			wnd1:GetChild(child2):Show();
		else
			LXZMessageBox("child1:"..pcol.."|"..prow.." "..child2);
		end
	else
		LXZMessageBox("element:"..pcol.."|"..prow);
	end
	
	local wnd2 = control:GetChild(col.."|"..row);
	if(wnd2~= nil) then
		if(wnd2:GetChild(child1)~= nil) then
			wnd2:GetChild(child1):Show();
		else
			LXZMessageBox("child2:"..pcol.."|"..prow.." "..child1);
		end
	else
		LXZMessageBox("element:"..col.."|"..row);
	end
		
end

function ShowBonusTips(main, intarr, level)
	local root = HelperGetRoot();		
	local nSum, nCnt, nOrder, bContinue, effecttbl = CaculateBonus(main, intarr, false);
	
	local k1 = 1;
	local k2 = 1;	
	if(bContinue==true) then		
		k1=2;
	end
	
	if(nCnt == nOrder) then
		k2 =2;
	end
	
	local bonus = 0;
	if(nSum > 0) then
		local coe     = GetMaxCoin(level)+level;
		if(nOrder<=0) then
			nOrder = 1;
		end
		
		bonus = nSum+coe*nCnt*nOrder*k1*k2;	
	end
	
	if(nCnt<=1) then
		return;
	end
	
	local wnd = root:GetLXZWindow("Game:bonustips");
	HelperSetWindowText(wnd,  nCnt.." Blocks "..bonus.." points");
	wnd:Show();		
	wnd:GetParent():LayerTop(wnd);
	AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255, End=100,step=5,hide=true});	
	AddWndUpdateFunc(wnd, EffectZoomInFunc,{time=LXZAPI_timeGetTime()+300,step=0.1,from=0.5,max=1})
end

function FingerMoveProc(x, y)
	local corecfg = ICGuiGetLXZCoreCfg();
	if(corecfg.IsClickDown == false)  then
		LXZAPI_OutputDebugStr("OnFingerMove corecfg.IsClickDown");
		return;
	end
	
	--
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:main");
		
	local pt = LXZPoint:new_local();
	local offset = LXZPoint:new_local();
	wnd:GetPos(offset);
		
	pt.x = x;
	pt.y = y;
	wnd:ScreenToWindowPos(pt);
	
	local row,col = GetRowColByPos(pt.x,pt.y);
	if(IsCanMoveTo(row, col) == false) then
		LXZAPI_OutputDebugStr("OnFingerMove :IsCanMoveTo");
		return;
	end
		
	local num = GetIndexByRowCol(row, col);
	if(IntIsInNumArray(num) ~= nil) then
		if(IsPrevLastMoveTo(row, col)==true) then
			BackPrevMoveStep();
			ShowBonusTips(wnd, GameData.numarray, GameData.level); 
		end	
		LXZAPI_OutputDebugStr("OnFingerMove :IntIsInNumArray");
		return;
	end
	
		
	--

	
	
	local cnt = GameData.numarray:size();
	PlayEffect("move"..(1+math.mod(cnt,2))..".wav");
	
		
	--sound	
	local main = root:GetLXZWindow("Game:main");
	local element = main:GetChild(col.."|"..row);
	if(element == nil or element:GetClassName()=="Element") then	
		local prow,pcol = GetLastRowCol();
		LinkMoveEffect(row, col, prow, pcol, main);
		GameData.numarray:push(num);	
		CheckContinue(main, GameData.numarray, GameData.numarray:size());
	end
	
	if(element ~= nil and element:GetClassName()=="Element") then	
		EffectCircleButtonNoSound(element, nil, true);
		element.selected = true;
		AddWndUpdateFunc(element, EffectSelectElement, {});
	end
	
	local control = root:GetLXZWindow("Game:control");
	local ctrl = control:GetChild(col.."|"..row);
	if(ctrl~=nil) then
		AddWndUpdateFunc(ctrl, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255, End=100,step=20}, thread);
		--EffectCircleButtonNoSound(ctrl, nil, true);
	end
	
	ChangePanel();
	
	--
	ShowBonusTips(main, GameData.numarray, GameData.level); 
		
end


local function OnFingerMove(window, msg0, sender)
	--LXZMessageBox("OnFingerMove");
	if(GameData.state ~= STATE_RUN) then
		return;
	end
	
	if(IS_MAKE_GAME~=0) then
		return;
	end
	
	if(os.time()<GameData.time) then
		return;
	end
	
	local x = msg0:int();
	local y = msg0:int();
	
	FingerMoveProc(x, y);
		
end

function ClearPanel()
	local root = HelperGetRoot();
	local window  = root:GetLXZWindow("Game:list");	
	window:ClearChilds();
	window:SetExtX(0);
end

function CheckContinue(main, intarr, currentindex, istable)
	IS_CONTINUE = true;
	
	local pcoin = 0;
	for i = 1,currentindex,1 do			
		local index = 0;
		
		if(istable ~= nil and istable==true) then
			index = intarr[i];
		else
			index = intarr:get(i-1);
		end
		
		local row,col = GetRowColByIndex(index);
		local wnd = main:GetChild(col.."|"..row);
		if(wnd ~= nil) then
			local coin = tonumber(HelperGetWindowText(wnd));
			if(coin<pcoin or math.abs(coin-pcoin)~=1) then
				if(pcoin~= 0) then
					IS_CONTINUE = false;
					break;
				end
			end				
			pcoin = coin;
		end						
	end		

	--update
	for i = 1,currentindex,1 do			
		
		local index = 0;
		if(istable ~= nil and istable==true) then
			index = intarr[i];
		else
			index = intarr:get(i-1);
		end
		
		local row,col = GetRowColByIndex(index);
		local wnd = main:GetChild(col.."|"..row);
		if(wnd ~= nil) then
			wnd.forceupdate = true;			
		end						
	end				

end

function 	ChangePanel()
	local root = HelperGetRoot();
	local window  = root:GetLXZWindow("Game:list");	
	local main  = root:GetLXZWindow("Game:main");	
	window:ClearChilds();
	
	local intarr = GameData.numarray;
	if(intarr:size()<=0) then
		return;
	end

	local index = intarr:get(intarr:size()-1);
	local row,col = GetRowColByIndex(index);
	local wnd = main:GetChild(col.."|"..row);	
	if(wnd ~=nil) then
		local clone = wnd:Clone();	
		window:AddChild(clone);
		HelperSetWindowText(clone, MayGotBonus());
		EffectCircleButtonNoSound(window, nil, true);
	end
	
end

local function OnRFingerUp(window, msg0, sender)
	if(GameData.state ~= STATE_RUN or IS_MAKE_GAME==0) then
		return;
	end
	
	local x = msg0:int();
	local y = msg0:int();
		
	--
	CancelSelectedElement();
	
	--
	--FingerMoveProc(x, y);
	
	--
	local root = HelperGetRoot();
	local pt = LXZPoint:new_local();
	pt.x = x;
	pt.y = y;
	root:GetChild("Game"):ScreenToWindowPos(pt);
	local main = root:GetLXZWindow("Game:main");
	local row,col = GetRowColByPos(pt.x,pt.y);
	
	local colortable = {{r=255,g=255,b=255,a=255},{r=0,g=255,b=255,a=255},{r=255,g=0,b=255,a=255},{r=255,g=255,b=0,a=255}};
	
	local element = main:GetChild(col.."|"..row);
	if(element ~= nil) then
		local r,g,b,a = HelperGetWindowTextColor(element);
		for i = 1, table.getn(colortable), 1 do
			local c = colortable[i];
			if(c.r==r and c.g==g and c.b==b and c.a==a) then
				local ii =1+math.mod(i,table.getn(colortable));
				c = colortable[ii];
				--LXZMessageBox("colortable:"..ii);
				r = c.r;
				g = c.g;
				b = c.b;
				a = c.a;
				break;
			end		
		end
			
		HelperSetWindowTextColor(element, r, g, b, a);		
	end
	

end

local function OnFingerDown(window, msg0, sender)
	--LXZMessageBox("OnFingerDown");
	if(GameData.state ~= STATE_RUN) then
		return;
	end
	
	if(os.time()<GameData.time) then
		return;
	end
	
	local x = msg0:int();
	local y = msg0:int();
	
	--
	IS_CLICKDOWN = true;
		
	--
	CancelSelectedElement();
	
	--
	FingerMoveProc(x, y);
	
	--
	local root = HelperGetRoot();
	local pt = LXZPoint:new_local();
	pt.x = x;
	pt.y = y;
	root:GetChild("Game"):ScreenToWindowPos(pt);
	local main = root:GetLXZWindow("Game:main");
	local row,col = GetRowColByPos(pt.x,pt.y);
	
	local element = main:GetChild(col.."|"..row);
	if(element ~= nil) then
		if(IS_MAKE_GAME~=0) then
			--CancelSelectedElement();
			GameData.selectname = "";
			if(IS_MAKE_GAME==MAKE_GAME_WALL and element:GetClassName()=="Element") then
				CancelSelectedElement();
				element:Delete();		
				return;
			elseif(IS_MAKE_GAME==MAKE_GAME_ELEMENT and element:GetClassName()=="Wall") then
				CancelSelectedElement();
				element:Delete();		
				return;
			elseif(IS_MAKE_GAME==MAKE_GAME_COLOR and  element:GetClassName()=="Element") then
				HelperSetWindowTextFont(element, "yellownum.fnt");
				return;
			end			
			return;
		end	
		
		local wnd  = root:GetLXZWindow("Game:select");
		pt.x, pt.y = GetPosByRowCol(row,col);
		wnd:SetHotPos(pt);
		wnd:Show();
		GameData.selectname = element:GetName();									
	else
		if(IS_MAKE_GAME~=0) then
			if(IsCanMoveTo(row, col) == false) then
				return;
			end
		
			if(IS_MAKE_GAME==MAKE_GAME_WALL) then
				local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Wall");			
				main:AddChild(wnd);			
				pt.x, pt.y = GetPosByRowCol(row,col);
				wnd:SetHotPos(pt);
				wnd:SetName(col.."|"..row);						
				return;
			elseif(IS_MAKE_GAME==MAKE_GAME_ELEMENT) then
				local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
				main:AddChild(wnd);
				pt.x, pt.y = GetPosByRowCol(row,col);
				local tar = math.random(1, GetMaxCoin(GameData.level));
				HelperSetWindowText(wnd, tostring(tar));
				wnd:SetHotPos(pt);
				wnd:SetName(col.."|"..row);				
				return;
			end	
		end
	end
	
	
end

function HelperSetWindowPictureAngle(wnd, angle, realname)
	local render = nil;
	if(realname==nil) then
		render = wnd:GetRender("Picture");
	else
		render = wnd:GetRender(realname);
	end
	
	if(render~=nil) then		
		RenderRefPictureLogic.SpriteRadia = render:GetAttributeNameRef("Picture:Sprite:fRadia", RenderRefPictureLogic.SpriteRadia);		
		local fRadia = tonumber(render:GetAttribute(RenderRefPictureLogic.SpriteRadia));		
		render:SetAttribute(RenderRefPictureLogic.SpriteRadia, tostring(angle));				
	end
	
end

function HelperGetWindowPictureColor(wnd, realname)
	local render = nil;
	if(realname==nil) then
		render = wnd:GetRender("Picture");
	else
		render = wnd:GetRender(realname);
	end
	
	--LXZMessageBox("HelperSetWindowPictureMixPictureColor");
	
	if(render ~= nil) then
		RenderRefPictureLogic.spritecolor = render:GetAttributeNameRef("Picture:Sprite:color", RenderRefPictureLogic.spritecolor);
		local addr = render:GetAddress(RenderRefPictureLogic.spritecolor);
		local rgba = tousertype(addr, "RGBA");
	--	LXZMessageBox("HelperSetWindowPictureMixPictureColor:"..RenderRefPicture.spritecolor.." r:"..r.." g:"..g.." b:"..b.." a:"..a);
		return rgba.red,rgba.green,rgba.blue,rgba.alpha;
	end
end

function HelperSetWindowPictureColor(wnd, r, g, b, a, realname)
	local render = nil;
	if(realname==nil) then
		render = wnd:GetRender("Picture");
	else
		render = wnd:GetRender(realname);
	end
	
	--LXZMessageBox("HelperSetWindowPictureMixPictureColor");
	
	if(render ~= nil) then
		RenderRefPictureLogic.spritecolor = render:GetAttributeNameRef("Picture:Sprite:color", RenderRefPictureLogic.spritecolor);
		local addr = render:GetAddress(RenderRefPictureLogic.spritecolor);
		local rgba = tousertype(addr, "RGBA");
	--	LXZMessageBox("HelperSetWindowPictureMixPictureColor:"..RenderRefPicture.spritecolor.." r:"..r.." g:"..g.." b:"..b.." a:"..a);
		rgba.red = r;
		rgba.alpha = a;
		rgba.blue = b;
		rgba.green = g;
		--LXZMessageBox("a:"..a);
	end
end

function HelperSetWindowPicture(wnd,  name, realname)
	local render = nil;
	if(realname==nil) then
		render = wnd:GetRender("Picture");
	else
		render = wnd:GetRender(realname);
	end
	
	if(render ~= nil) then
		--LXZMessageBox("HelperSetWindowTextureFile");
		RenderRefPictureLogic.imagename = render:GetAttributeNameRef("Picture:Sprite:ImageName", RenderRefPictureLogic.imagename);
		render:SetAttribute(RenderRefPictureLogic.imagename, name);	
	end
end


function HelperSetWindowPictureFile(wnd,  name, realname)
	local render = nil;
	if(realname==nil) then
		render = wnd:GetRender("Picture");
	else
		render = wnd:GetRender(realname);
	end
	
	if(render ~= nil) then
		--LXZMessageBox("HelperSetWindowTextureFile");
		RenderRefPictureLogic.file = render:GetAttributeNameRef("Picture:Sprite:file", RenderRefPictureLogic.file);
		render:SetAttribute(RenderRefPictureLogic.file, name);	
	end
end


function UpdateStageUI()
	
	local root = HelperGetRoot();
	local wnd = root:GetChild("LevelSets");
		
	local sets = wnd:GetChild("Sets");
	--sets:SetExtX(0);
	
	local currentpage = GameData.currentpage;
	--LXZMessageBox("currentpage:"..currentpage.." highlevel:"..GameData.highlevel);
	
	local lockname = "lockedbk";
	local unlockname = "unlockedbk";
	if(GAME_MODE==GAME_MODE_SCORE) then
	--	HelperSetWindowPicture(wnd:GetChild("title"), "scoremodetitle");
		lockname = "lockedbk1";
		unlockname = "unlockedbk1";
	--else
		--HelperSetWindowPicture(wnd:GetChild("title"), "combomodetitle");
	end--]]
	
	--
	for k = 1,5,1 do
		local page = wnd:GetChild("page"..k);	
		if(k==currentpage) then
			HelperSetWindowPicture(page, "currentdot");
		else
			HelperSetWindowPicture(page, "dot");
		end
		
		local window = sets:GetChild("Sets"..k);
	
		--
		for i = 1, 9,1 do 
			local level = (k-1)*9+i;
			local stagewnd = window:GetChild("stage"..i);
			
			HelperSetWindowText(stagewnd:GetChild("num"), tostring(level));
			
			if(GameData.selectlevel==level) then
				HelperSetWindowTextColor(stagewnd:GetChild("num"), 255,255,0,255);
			else
				HelperSetWindowTextColor(stagewnd:GetChild("num"), 255,255,255,255);
			end
			
			if(level<= GameData.highlevel) then
				HelperSetWindowPicture(stagewnd, unlockname);								
			else
				HelperSetWindowPicture(stagewnd, lockname);								
			end
			
			--
			local hscore = LoadLevelHighScore(level);
			if(hscore<GameCfg[level].wincoin) then
				HelperSetWindowPicture(stagewnd:GetChild("star1"),"greystar");
				HelperSetWindowPicture(stagewnd:GetChild("star2"),"greystar");
				HelperSetWindowPicture(stagewnd:GetChild("star3"),"greystar");
			elseif(hscore<GameCfg[level].wincoin2) then
				HelperSetWindowPicture(stagewnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(stagewnd:GetChild("star2"),"greystar");
				HelperSetWindowPicture(stagewnd:GetChild("star3"),"greystar");
			elseif(hscore<GameCfg[level].wincoin3) then
				HelperSetWindowPicture(stagewnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(stagewnd:GetChild("star2"),"greenstar");
				HelperSetWindowPicture(stagewnd:GetChild("star3"),"greystar");
			else
				HelperSetWindowPicture(stagewnd:GetChild("star1"),"greenstar");
				HelperSetWindowPicture(stagewnd:GetChild("star2"),"greenstar");
				HelperSetWindowPicture(stagewnd:GetChild("star3"),"greenstar");
			end
			
			--if(level<19 or GameData.buy==1) then
				stagewnd:GetChild("lock"):Hide();				
			--else			
			--	stagewnd:GetChild("lock"):Show();				
			--end
			
		end
	end
	
	--
	local pt = LXZPoint:new_local();
	pt.x = sets:GetExtX();
	pt.y = sets:GetExtY();
	local dir = 3;
	local targetx = -320*GameData.scale*(GameData.currentpage-1)
	if(pt.x<targetx) then
		dir=3;			
	else
		dir = 4;
	end
		
	if(pt.x~=targetx) then
		local co = coroutine.create(function(thread)				
			if(wnd:IsVisible()) then
				wnd:SetBit(STATUS_IsDisable);							
				AddWndUpdateFunc(sets, EffectChildMove,  {speed=30*GameData.scale, dir=dir, range=50, acce=0, fromx = pt.x, fromy =0, x=targetx,  y=0}, thread);
				--LXZMessageBox("GameData.currentpage:"..GameData.currentpage.." x:"..pt.x.." tox:"..targetx);
				coroutine.yield();
				wnd:DelBit(STATUS_IsDisable);
				
				if(GameData.currentpage==(1+math.floor(GameData.selectlevel/9))) then
					local window = sets:GetChild("Sets"..GameData.currentpage);
					local stagewnd = window:GetChild("stage"..(math.mod(GameData.selectlevel,9)));
					EffectCircleButtonNoSound(stagewnd, function()
						local coe = 1*GameData.scale;	
						AddWndUpdateFunc(root:GetLXZWindow("LevelSets:playbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=coe});							
					end);
				end
	
				
			--	LXZMessageBox("ddd");
			else
				sets:SetExtX(targetx);
			end
			
		end);
		
		coroutine.resume(co,co);
		--LXZMessageBox("from:"..pt.x.." tox:"..targetx);
	end
		
end

local function callGameMode(mode)
	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	main:ClearChilds();
	CancelSelectedElement();
	
	local wnd = root:GetChild("LevelSets");
	wnd:SetExtX(0);
	wnd:Show();
	if(GameData.buy==0) then
		LXZAPI_CallSystemAPI("RequestProductInfo", tostring(GameData.currentpage));
	end
	root:GetChild("Menu"):Hide();
	
	--
	--
	GAME_MODE = mode;
	
	--
	--LXZMessageBox("callGameMode:"..mode);
	LoadDB();

	--
	if(GameData.level>GameData.highlevel) then
		GameData.level = GameData.highlevel;
	end
	
	--
	GameData.currentpage = 1+math.floor((GameData.selectlevel-1)/9);	

	--
	UpdateStageUI();	
	
	--
	SaveDBCurrentUser();
	
	--PlayEffect("menu.wav");
end


local function OnStage(window, msg0, sender)	
	local root = HelperGetRoot();
	--EffectNormalButton(root:GetLXZWindow("Menu:ScoreMode"), function() 
	EffectAnimateMenuHide("ScoreMode", function()
			callGameMode(GAME_MODE_SCORE);
	end);
	
	--PlayEffect("click.wav");	
end

local function OnMenuReplay(window, msg0, sender)
	local root = HelperGetRoot();
	--EffectNormalButton(root:GetLXZWindow("Menu:ComboMode"), function() 
		EffectAnimateMenuHide("ComboMode", function()
			StartGame(GameData.level);
	end);	
end

local function OnSetWall(window, msg0, sender)
	

	IS_MAKE_GAME = IS_MAKE_GAME+1;
	IS_MAKE_GAME = math.mod(IS_MAKE_GAME, 4);
	if(IS_MAKE_GAME==0) then
		IS_MAKE_GAME = 1;
	end
	
	--LXZMessageBox("IS_MAKE_GAME:"..IS_MAKE_GAME)
		
	UpdateEditUI();

end

local function OnMakeGame(window, msg0, sender)
	local root = HelperGetRoot();
	
	if(IS_MAKE_GAME==0) then
		IS_MAKE_GAME = 1;
	else
		IS_MAKE_GAME = 0;
	end
	
	--
	UpdateEditUI();
	
end

function TrimRightChar(str, a)
	local c = string.sub(str, string.len(str),string.len(str));
	if(c == a) then
		--LXZMessageBox("c:"..c.." len:"..string.len(pass));
		str = string.sub(str, 1, string.len(str)-1);
	end	
	
	return str;
end

function wallstreetURLResponeFunc(urlresponse)	
	local urlrequest = urlresponse:getRequest();
	if(urlrequest.thread ~= nil) then
		--LXZMessageBox("urlrequest.thread:"..type(urlrequest.thread));
		coroutine.resume(urlrequest.thread, urlresponse);
	end	
end

local function apiPostJSON(url, data, thread)

	local urlrequest = _urlRequest:new();
	urlrequest.nRequestType = eRequestGet;
	urlrequest.func = "wallstreetURLResponeFunc";
	urlrequest.url = url.."?";
	for k,v in pairs(data) do
		urlrequest.url = urlrequest.url ..k.."="..v.."&";
	end	
		
	urlrequest.url = TrimRightChar(urlrequest.url, '&');
	urlrequest.url = TrimRightChar(urlrequest.url, '?');
	urlrequest.thread = thread;
	--LXZMessageBox(urlrequest.url);
	
	local curl = CLXZCurl:Instance();
	curl:send(urlrequest);	

	local urlresponse = coroutine.yield();
	--LXZMessageBox("urlresponse yeild:"..type(urlresponse));
	return urlresponse;
end

API_URL= 'https://trade.fxbtc.com/api';
local function fxbtcapi_get_token(thread, name, pwd)
	local data =  {op="get_token",username=name, password=pwd};
	return apiPostJSON(API_URL, data, thread);	
end

local function testBaidu(thread)
	local data = {};
	return apiPostJSON("http://www.baidu.com", data, thread);	
end


--下载
function HelperDowndLoadFile(tmpname, asfilename, fn, IsUpdateLocal)
	
	local co = coroutine.create(function (thread)	
		local urlrequest = _urlRequest:new();
		urlrequest.nRequestType = eRequestDownloadFile;
		urlrequest.func = "wallstreetURLResponeFunc";
		urlrequest.thread = thread;
		urlrequest.strFtpDownloadAsFile = LXZAPIGetWritePath()..tmpname;
		if(IsUpdateLocal==true) then
			urlrequest.strFtpDownloadRenameFile = LXZAPIGetWritePath()..asfilename;
		end
		urlrequest.url = "ftp://ftpuser:123456789@115.28.78.174/test/"..asfilename;
		
		local curl = CLXZCurl:Instance();
		curl:send(urlrequest);	
		local urlresponse = coroutine.yield();		
		fn(urlresponse);
	end);
	
	coroutine.resume(co, co);	
end

function DowndLoadFile(tmpname, asfilename, fn, IsUpdateLocal)
	
	local co = coroutine.create(function (thread)	
		local urlrequest = _urlRequest:new();
		urlrequest.nRequestType = eRequestDownloadFile;
		urlrequest.func = "wallstreetURLResponeFunc";
		urlrequest.thread = thread;
		urlrequest.strFtpDownloadAsFile = LXZAPIGetWritePath()..tmpname;
		if(IsUpdateLocal==true) then
			urlrequest.strFtpDownloadRenameFile = LXZAPIGetWritePath()..asfilename;
		end
		urlrequest.url = "ftp://ftpuser:123456789@192.168.0.100/"..asfilename;
		
		local curl = CLXZCurl:Instance();
		curl:send(urlrequest);	
		local urlresponse = coroutine.yield();		
		fn(urlresponse);
	end);
	
	coroutine.resume(co, co);	
end

function UploadFile(fullname, name, fn)

	local co = coroutine.create(function (thread)	
		local urlrequest = _urlRequest:new();
		urlrequest.nRequestType = eRequestUploadFile;
		urlrequest.func = "wallstreetURLResponeFunc";
		urlrequest.thread = thread;
		urlrequest.strFtpUploadLocalFile = fullname;
		urlrequest.strFtpUploadAsFile = name;
		urlrequest.strFtpRenameToFile = name;
		urlrequest.url = "ftp://ftpouloba:123@192.168.0.100/"..urlrequest.strFtpUploadAsFile;
		
		local curl = CLXZCurl:Instance();
		curl:send(urlrequest);	
		local urlresponse = coroutine.yield();		
		fn(urlresponse);
		
	end);
	
	coroutine.resume(co, co);
end

function HelperUpdateLevelData(level)
	local path = LXZAPIGetWritePath();
	local filename = path..GameCfg[level].data..".ha";
			
	ShowTipMessage("OnUpload: "..GameCfg[level].data..".ha");
	
	--
	UploadFile(filename, GameCfg[level].data..".ha", function(urlresponse)
		if(urlresponse.IsSuccess==0) then
			LXZMessageBox("xxxURLResponeFunc: "..urlresponse:getError());
			ShowTipMessage("OnUpload help "..urlresponse:getError());
		else
			ShowTipMessage("OnUpload help success");
		end
		
		filename = path..GameCfg[level].data..".nlv";
		UploadFile(filename, GameCfg[level].data..".nlv", function(urlresponse)
			if(urlresponse.IsSuccess==0) then
				LXZMessageBox("xxxURLResponeFunc: "..urlresponse:getError());
				ShowTipMessage("OnUpload level data fail "..urlresponse:getError());
			else
				ShowTipMessage("OnUpload level data success");
			end
		end);		
	end);	
end

local function OnUpload(window, msg0, sender)
	HelperUpdateLevelData(GameData.level);
end

local function OnUploadAll(window, msg0, sender)
	
		
	local co = coroutine.create(function (thread)	
		for level=5,45,1 do
			HelperUpdateLevelData(level);
		end
		
		AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+500},thread);
		coroutine.yield();
		
	--
	end);	
	coroutine.resume(co, co);

end

function SaveChildrens(main, name)
	local path = LXZAPIGetWritePath();
	local filename = path..name;
	local lvltbl = {};	
	local wnd = main:GetFirstChild();
	while(wnd ~= nil) do
		local row,col = GetRowColByWnd(wnd);
		local class = wnd:GetClassName();
		local fnt = HelperGetWindowTextFont(wnd);
		local text = HelperGetWindowText(wnd);
		
		local e = {row=row,col=col,class=class,fnt=fnt, text=text};
		table.insert(lvltbl, e);
	
		wnd = wnd:GetNextSibling();
	end
	
	local str = json.encode(lvltbl);
	local file = io.open(filename, "w");
	if(file ~= nil) then
		file:write(str);
		file:close();
	end	
end

local function OnSaveGame(window, msg0, sender)
	local name = GameCfg[GameData.level].data..".nlv";
		
	ShowTipMessage("save data....");

	local root = HelperGetRoot();
	local window = root:GetLXZWindow("Game:main");
	SaveChildrens(window, name);	
				
end

function GetAStarFinder()
		
	--astar	
	if(gFinder  == nil) then
		local astar = CLXZAStarFinder:new();
		local intarr = IntArray:new();
		intarr:resize(MAX_ROW*MAX_COL, 1);
		PathIntArray = intarr;	
		astar:loadMapFromMemory(intarr, MAX_COL,MAX_ROW, 0);
		gFinder  = astar;
		gFinderIntArray = intarr;
	end
	
	return gFinder;
end

function GetAStarFinderIntArray()	
	--
	GetAStarFinder();	
	return gFinderIntArray;
end

function ShowHelpAnimate(shortfilename)
		local root = HelperGetRoot();
		root:GetLXZWindow("Game:help:hand"):Hide();
		
		GameData.helptimer = LXZAPI_timeGetTime();
		GameData.helpindex = 1;
		GameData.helpactionlist ={};
		IS_ANIMATE_HELP = true;
		
		GameData.oldstate = GameData.state;
		GameData.state = STATE_PAUSE;	
		
		--
		local help = root:GetLXZWindow("Game:help");	
		help:Show();
	
		
		local main = help:GetChild("main");
		main:ClearChilds();	
		
		
		local lvlname = shortfilename..".lvl";
		local path = LXZAPIGetWritePath();
		local name = shortfilename..".ha";
		local filename = path..name;
		local filecontent = LXZAPI_GetFileContent(name);
		if(filecontent ~= nil) then
			GameData.helpactionlist = json.decode(filecontent);
		else
			lvlname = shortfilename..".hlp";
		end
		
		LoadGameLevel(shortfilename..".nlv",lvlname, main);
		HelperSetWindowText(help:GetChild("state"), tostring(GameData.helplevel));
		HelperSetWindowText(help:GetChild("score"), tostring(0));
		ResetHandPosition();		
		
end

local function OnNextLevelHelp(window, msg0, sender)
	if(IS_MAKE_GAME==0) then
		return;
	end

	GameData.helplevel = GameData.helplevel+1;
	ShowHelpAnimate(tostring(GameData.helplevel));
end

local function OnGameHelp(window, msg0, sender)
	local root = HelperGetRoot();
	local co = coroutine.create(function (thread)
		
		--LXZMessageBox("OnGameHelp:");
		PlayEffect("click.wav");
		AddWndUpdateFunc(sender, EffectAnimate, {interval=30, playcnt=10, frame={"helpup","helpdown"}}, thread);
		--AddWndUpdateFunc(root:GetLXZWindow("Game:helpbtn"), EffectPlaySound, {interval=30, playcnt=10, frame={"move1.wav","move2.wav"}});
		AddWndUpdateFunc(sender, EffectFaceOut, {time=LXZAPI_timeGetTime()+500, from=255,step=7});
		coroutine.yield();
		--LXZMessageBox("OnGameHelp:");
	
		--
		HideGameHeadWindow();
		root:GetLXZWindow("Game:background"):Show();
		root:GetLXZWindow("Game:main"):Hide();
		root:GetLXZWindow("Game:fail"):Hide();
		ANIMATE_HELP = ANIMATE_HELP_GAME;
		HELP_TIMER_INTERVAL=200;
		GameData.helplevel = GameData.level;
		GameData.helpthread = thread;
		root:GetLXZWindow("Game:help:return"):SetBit(STATUS_IsDisable);
		ShowHelpAnimate(tostring(GameData.helplevel));				
		coroutine.yield();
		--LXZMessageBox("aaaa");
		
		if(sender:GetParent():GetName()=="tips") then
			local help = root:GetLXZWindow("Game:help");	
			help:GetChild("main"):ClearChilds();		
			help:Hide();
			root:GetLXZWindow("Game:background"):Hide();
			root:GetLXZWindow("Game:fail"):Show();
		end
		--]]
		
		--PlayEffect("menu.wav");
	end);
	
	local res, err = coroutine.resume(co, co);	
	if(res==false) then
		LXZMessageBox("OnGameHelp:"..err);
	end
	
end

function codetable(data)	
	if(data == nil or type(data)~="table") then
		LXZMessageBox("printtable data nil:".. type(data));
		return;
	end
	
	

	--LXZMessageBox("printtable:"..type(data));
	local urlstr = "[";
	for k,v in pairs(data) do
		urlstr = urlstr ..k.."="..tostring(v)..",";
	end	
	
	urlstr = TrimRightChar(urlstr, ',');

end

local function OnSaveForHelp(window, msg0, sender)
	local path = LXZAPIGetWritePath();
	local name = GameData.level..".ha";
	local filename = path..name;
	
	ShowTipMessage("save data....");

--[[	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:main");
	wnd:DelBit(STATUS_IsNotSerialChild);
	local ret = wnd:SaveChildsToFile(filename, nil);
	wnd:SetBit(STATUS_IsNotSerialChild);
	--]]
	local file = io.open(filename, "w");
	if(file~= nil) then
		local tabletext =json.encode(GameData.actionlist);
		file:write(tabletext);
		file:close();
	end
	
end

local function OnSetLevel(window, msg0, sender)
	--LXZMessageBox("OnSetLevel:"..sender:GetName());
	
	local firstindex, lastindex, levelstr = string.find(sender:GetName(), "%a+(%d+)");
	--LXZMessageBox(levelstr.." Name:"..sender:GetName());
	StartGame(tonumber(levelstr));	
	
	local root = HelperGetRoot();
	local wnd = root:GetChild("LevelSets");
	wnd:Hide();
	
end



function AnimateHelpAction(action)
	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:help:main");
	local hand  = root:GetLXZWindow("Game:help:hand");
	local pt = LXZPoint:new_local();
	hand:Show();
			
	--delete	
	local intarrpos = action.pos;
	local intarrcoin = action.coin;
	if(GameData.helpani <= table.getn(intarrpos)) then
				
		local indexctrl = intarrpos[GameData.helpani];
		local row, col = GetRowColByIndex(indexctrl);
		local prow = nil;
		local pcol = nil;
		if(GameData.helpani>1) then
			local pindexctrl = intarrpos[GameData.helpani-1];
			prow,pcol = GetRowColByIndex(pindexctrl);
		end
		
		pt.x, pt.y = GetPosByRowCol(row, col);
		
		LinkMoveEffect(row, col, prow, pcol, main);
		CheckContinue(main, intarrpos, GameData.helpani, true);
		
		--
		local element = main:GetChild(col.."|"..row);
		if(element ~= nil and element:GetClassName()=="Element") then	
			EffectCircleButtonNoSound(element, nil, true);
			element.selected = true;
			AddWndUpdateFunc(element, EffectSelectElement, {});			
		end
		
		--move hand
		if(GameData.helpani< table.getn(intarrpos)) then
			local indexctrl1 = intarrpos[GameData.helpani+1];
			local row1, col1 = GetRowColByIndex(indexctrl1);
			local dir = 1;
			if(row==row1) then
				if(col==(col1+1)) then
					dir = 4;
				else
					dir = 3;
				end
			else
				if(row==(row1+1)) then
					dir = 2;
				else
					dir = 1;
				end
			end
			
			pt.x, pt.y = GetPosByRowCol(row1,col1);
			pt.x = pt.x+GRID_WIDTH*GameData.scale*0.5;
			pt.y = pt.y-GRID_WIDTH*GameData.scale*0.5;			
			local cnt = math.floor((HELP_TIMER_INTERVAL+LXZAPI_GetFrameTime()-1)/LXZAPI_GetFrameTime());
			AddWndUpdateFunc(hand, EffectMove, {speed=GRID_WIDTH*GameData.scale/cnt, dir=dir, x=pt.x, y=pt.y});
		end
		
		--sound
		local cnt = GameData.helpani;
		PlayEffect("move"..(1+math.mod(cnt,2))..".wav");
		
		GameData.helpani = GameData.helpani+1;
		return false;
	end
	
	local control = root:GetLXZWindow("Game:control");	
	control:ClearChilds();
	
	local effecttbl = {};
	local prevcoin = 0;
	local bAsc = true;
	local bContinue = true;
	local nSum = 0;
	local nOrder = 0;
	local nCnt = 0;
	local k1 = 2;
	local k2 = 2;
		
	for i = 1, table.getn(intarrpos), 1 do
		local indexctrl = intarrpos[i];
		local coin = intarrcoin[i];
		local row, col = GetRowColByIndex(indexctrl);
		
		local tmp = main:GetChild(col.."|"..row);
		if(tmp) then
			pt.x, pt.y = GetPosByRowCol(row, col);
			AddEffect("BombEffect", pt);
			tmp:Delete();
			
			if(coin>prevcoin) then
				table.insert(effecttbl, {name="+"..coin, frmx=pt.x, frmy=pt.y,  tox=pt.x, toy=pt.y-EFFECT_MOVE_DISTANCE*GameData.scale});
				if((coin ~= prevcoin+1) and prevcoin ~= 0) then
					bContinue = false;
				end		

				nSum = nSum+coin;
				nOrder = nOrder+1;
			else
				table.insert(effecttbl, {name="-"..coin, frmx=pt.x, frmy=pt.y,  tox=pt.x, toy=pt.y-EFFECT_MOVE_DISTANCE*GameData.scale});
				bAsc = false;
				bContinue = false;
				nSum = nSum+coin;
				nOrder = nOrder-1;
			end
			
			prevcoin = coin;	
			nCnt = nCnt+1;			
		end	
	end
	
	-- new coin
	if(math.abs(nOrder) ~= nCnt) then	
		k2=1;
	end
	
	local bonus = 0;
	if(nSum>0) then
		local level = GameData.level;
		if(ANIMATE_HELP==ANIMATE_HELP_LOAD) then
			level = 10;
		end
		
		local coe     = GetMaxCoin(level)+level;
		if(nOrder<=0) then
			nOrder = 1;
		end
		
		bonus = nSum+coe*nCnt*nOrder*k1*k2;		
		EffectAnimateNum1(root:GetLXZWindow("Game:help:score"), tostring(bonus+action.oldbonus), nil, 50);
	end
	
	--delete
	local element = main:GetChild(action.ncol.."|"..action.nrow);
	if(element ~= nil) then
		element:Delete();
	end	
	
	--create
	if(action.newcoin>0) then
		pt.x, pt.y = GetPosByRowCol(action.nrow, action.ncol);
		local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
		main:AddChild(wnd);
		HelperSetWindowText(wnd, tostring(action.newcoin));
		wnd:SetHotPos(pt);
		wnd:SetName(action.ncol.."|"..action.nrow);		
		wnd.update = nil;
		HelperSetWindowTextFont(wnd, "yellownum.fnt");
		if(nSum>=100) then
			HelperSetWindowTextScale(wnd, 0.4*GameData.scale);
		elseif(nSum>=1000)then
			HelperSetWindowTextScale(wnd, 0.25*GameData.scale);
		end
	end	
	
	if(action.newcoin2~= nil) then
		pt.x, pt.y = GetPosByRowCol(action.nrow2, action.ncol2);
		local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
		main:AddChild(wnd);
		HelperSetWindowText(wnd, tostring(action.newcoin2));
		wnd:SetHotPos(pt);
		wnd:SetName(action.ncol2.."|"..action.nrow2);	
		wnd.update = nil;
		HelperSetWindowTextFont(wnd, "yellownum.fnt");
	else
		CreateMoveEffect(effecttbl, bContinue);
		if(bContinue == true) then
			CreateBlockEffect(nCnt);
			PlayEffect("continue.wav");	
		elseif(bAsc==true) then						
			--PlayEffect("zhangsheng.wav");
			PlayEffect("asc.wav");
		else
			--PlayEffect("flystar.wav");		
			PlayEffect("desc.wav");				
		end
	end
	
	CreateBonusEffect(bonus, pt, bContinue);
	
	return true;

end

function WithdrawPrevAction()
	if(table.getn(GameData.actionlist)<=0) then
		return false;
	end
	
	if(GameData.withdrawcnt<=0) then
		return false;
	end
	
	GameData.withdrawcnt = GameData.withdrawcnt-1;
	UpdateDataToUI();

	local action = PopBackAction();
	local root = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	
	--delete create
	local element = main:GetChild(action.ncol.."|"..action.nrow);
	if(element ~= nil) then
		element:Delete();
	end
	
	--create 
	local pt = LXZPoint:new_local();
	
	local intarrpos = action.pos;
	local intarrcoin = action.coin;
	local intarrcolor = action.color;
	for i = 1, table.getn(intarrpos), 1 do
		local indexctrl = intarrpos[i];
		local row, col = GetRowColByIndex(indexctrl);
		
		local tmp = main:GetChild(col.."|"..row);
		if(tmp) then
			tmp:Delete();
		end
		
		local coin = intarrcoin[i];	
		if(coin>0) then		
			pt.x, pt.y = GetPosByRowCol(row, col);
			local wnd = CLXZWindowDicMgr:CloneClass("CrazyWallStreet.cls:Element");
			main:AddChild(wnd);
			HelperSetWindowText(wnd, tostring(coin));
			wnd:SetHotPos(pt);
			wnd:SetName(col.."|"..row);		
			
			--LXZMessageBox("CreateCoin: "..wnd:GetName().." coin:"..coin);
			--LXZMessageBox("HelperSetWindowTextFont:"..table.getn(intarrcolor));
			if(intarrcolor~= nil and intarrcolor[i]>0) then
				HelperSetWindowTextFont(wnd, "yellownum.fnt");				
			end
			
			if(coin>=100) then
				HelperSetWindowTextScale(wnd, 0.4*GameData.scale);
		--	LXZMessageBox("nSum:"..nSum);
			elseif(coin>=1000) then		
				HelperSetWindowTextScale(wnd, 0.25*GameData.scale);
			end
		end
	end
	
	GameData.bonus = action.oldbonus;
	HelperSetWindowText(root:GetLXZWindow("Game:score"), tostring(GameData.bonus));
	
	--delete mem
	DeleteAction(action);
	
	return true;
end

local function OnWithdraw(window, msg0, sender)
	--LXZMessageBox("OnWithdraw");
	local root = HelperGetRoot();
	
	EffectCircleButton(root:GetLXZWindow("Game:withdrawbtn"), function()
		if(GameData.state ~= STATE_RUN) then
			return;
		end
		
		WithdrawPrevAction();	
	end);
	
	--PlayEffect("menu.wav");
end


local function OnReplay(window, msg0, sender)
	local root  = HelperGetRoot();					
	EffectNormalButton(root:GetLXZWindow("Game:fail:replaybtn"),function ()			
		StartGame(GameData.level);
	end);
end

local function OnBomb(window, msg0, sender)
--	LXZMessageBox("OnBomb");
	local root  = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	
	local wnd = main:GetChild(GameData.selectname);
	if(wnd ~= nil) then
		local coin = tonumber(HelperGetWindowText(wnd));
		local newcoin = math.random(1, coin);
		HelperSetWindowText(wnd, tostring(newcoin));
		
		--
		local pt = LXZPoint:new_local();
		wnd:GetHotPos(pt);
		AddEffect("BombEffect", pt);		
		
		--
		PlayEffect("itemboom.wav");
	end		
	
	
end

local function OnElementDelete(window, msg0, sender)
	local root  = HelperGetRoot();
	local wnd  = root:GetLXZWindow("Game:select");
	
	--LXZMessageBox("OnElementDelete");
	sender.update = nil;
	tblUpdateWnd[sender:GetID()] = nil;
	if(sender:GetName()==GameData.selectname) then
		wnd:Hide();
		GameData.selectname = "";
	end

end

local function OnLoginLoading(window, msg0, sender)
	
	--RenderRefPictureLogic
	--[[local timerid = msg0:getSystemData();
	local timersys = CLXZTimerSystem:Instance();
	local index = timersys:GetTriggeredCount(timerid);
			
	local render = sender:GetRender("Rectangle");
	if(render ~= nil) then
		RenderRefRectLogic.color = render:GetAttributeNameRef("Rect:FillColor", RenderRefRectLogic.color);
		local addr = render:GetAddress(RenderRefRectLogic.color);
		local rgba = tousertype(addr, "RGBA");
		rgba.alpha = 255-index*10;
	--	LXZMessageBox("Name:"..wnd:GetName().." r:"..r.." g:"..g.." b:"..b.." a:"..a);
	end
	
	render = sender:GetRender("Picture");
	if(render ~= nil) then
		RenderRefPictureLogic.color = render:GetAttributeNameRef("Picture:Sprite:color", RenderRefPictureLogic.color);
		local addr = render:GetAddress(RenderRefPictureLogic.color);
		local rgba = tousertype(addr, "RGBA");
		rgba.alpha = 255-index*10;
	--	LXZMessageBox("Name:"..wnd:GetName().." r:"..r.." g:"..g.." b:"..b.." a:"..a);
	end
	--]]
	
end

function ShowTipMessage(strMsg)
	local winmgr = CLXZWindowMgr:Instance();		
	local root = winmgr:GetRoot();
	local wnd = root:GetLXZWindow("TipMsg");
	HelperSetWindowText(wnd,  strMsg);
	wnd:Show();		
	wnd:GetParent():LayerTop(wnd);
	AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+1000, from=255,step=7,hide=true});
	wnd:SetHeight(25*GameData.scale*(HelperGetWindowTextLineCount(wnd)));	
end

--[[
local function OnSetColor(window, msg0, sender)
	local root  = HelperGetRoot();
	local main = root:GetLXZWindow("Game:main");
	
	local colortable = {{r=255,g=255,b=255,a=255},{r=0,g=255,b=255,a=255},{r=255,g=0,b=255,a=255},{r=255,g=255,b=0,a=255}};
	
	for i = 1, table.getn(colortable), 1 do
		local c = colortable[i];
		if(c.r==mkcolor.r and c.g==mkcolor.g and c.b==mkcolor.b and c.a==mkcolor.a) then
			local ii =1+math.mod(i,table.getn(colortable));
			c = colortable[ii];
			--LXZMessageBox("colortable:"..ii);
			mkcolor.r = c.r;
			mkcolor.g = c.g;
			mkcolor.b = c.b;
			mkcolor.a = c.a;
			break;
		end		
	end
			
	HelperSetWindowControlColor(root:GetLXZWindow("Game:colorbtn"), mkcolor.r, mkcolor.g, mkcolor.b, mkcolor.a);
	
end
--]]

function EffectNormalButton(wnd, func,nosound)
	local co = coroutine.create(function (thread)
		if(nosound==nil) then
			PlayEffect("menu.wav");
		end
		
		local old = wnd:IsBitSet(STATUS_IsDisable);
		wnd:SetBit(STATUS_IsDisable);
		--AddWndUpdateFunc(wnd, EffectColorPicture, {interval=10, playcnt=5, frame={{255,255,255,255},{255,255,255,100}}}, thread);
		AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=20}, thread);
		AddWndUpdateFunc(wnd, EffectZoomInFunc, {time=LXZAPI_timeGetTime()+300,step=0.05,from=1,max=1.2});
		coroutine.yield();
		if(old == false) then
			wnd:DelBit(STATUS_IsDisable);
		end
		if(func ~= nil) then
			func();
		end
	end);
	
	local res,err = coroutine.resume(co,co);
	if(res==false) then
		LXZMessageBox("OnPlay"..err);
	end

end

function EffectCircleButtonNoSound(wnd, func)
	if(wnd.iseffectcircle~= nil) then
		return;
	end

	local co = coroutine.create(function (thread)
		--AddWndUpdateFunc(wnd, EffectColorPicture, {interval=10, playcnt=5, frame={{255,255,255,255},{255,255,255,100}}}, thread);
		
		local old = wnd:IsBitSet(STATUS_IsDisable);
		wnd:SetBit(STATUS_IsDisable);
		
		wnd.iseffectcircle=true;
		AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255, End=100,step=20, old=255}, thread);
		AddWndUpdateFunc(wnd, EffectZoomInFunc, {time=LXZAPI_timeGetTime()+300,step=0.1,from=0.5,max=1.2});		
		coroutine.yield();
		if(old == false) then
			wnd:DelBit(STATUS_IsDisable);
		end
		
		wnd.iseffectcircle=nil;
		if(func ~= nil) then
			func();
		end
	end);
	
	local res,err = coroutine.resume(co,co);
	if(res==false) then
		LXZMessageBox("OnPlay"..err);
	end

end

function EffectCircleButton(wnd, func)
	local co = coroutine.create(function (thread)
		PlayEffect("menu.wav");
		
		local old = wnd:IsBitSet(STATUS_IsDisable);
		wnd:SetBit(STATUS_IsDisable);
		
		--AddWndUpdateFunc(wnd, EffectColorPicture, {interval=10, playcnt=5, frame={{255,255,255,255},{255,255,255,100}}}, thread);
		AddWndUpdateFunc(wnd, EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=20,old=255}, thread);
		AddWndUpdateFunc(wnd, EffectZoomInFunc, {time=LXZAPI_timeGetTime()+300,step=0.1,from=0.5,max=1.2});
		coroutine.yield();
		if(old == false) then
			wnd:DelBit(STATUS_IsDisable);
		end
		
		if(func ~= nil) then
			func();
		end
	end);
	
	local res,err = coroutine.resume(co,co);
	if(res==false) then
		LXZMessageBox("OnPlay"..err);
	end

end

local function OnPlay(window, msg0, sender)
	local root  = HelperGetRoot();					
	EffectNormalButton(root:GetLXZWindow("Load:play"),function ()				
		ShowGameHeadWindow();
		if(GameData.state == STATE_RUN) then
			root:GetChild("Load"):Hide();			
			return;
		end
		
		UpdateDataToUI();
		if(LoadPlayRecord()==false) then
			root:GetChild("Game"):Show();
			root:GetChild("Load"):Hide();
			--root:GetChild("Menu"):Show();	
			--PlayEffect("menu.wav");
			EffectAnimateMenuShow();
		else
			LXZMessageBox("ddd");
			root:GetChild("Load"):Hide();
			if(GameData.level==1 and GameData.highlevel==1) then
				StartGame(GameData.level);
			end
		end
	end, true);

end

local function OnExitHelp(window, msg0, sender)
	local root = HelperGetRoot();	
	EffectCircleButtonNoSound(root:GetLXZWindow("Help:return"), function()
		root:GetLXZWindow("Help"):Hide();	
		--PlayEffect("menu.wav");
	end);
end

local function OnExitMenu(window, msg0, sender)
	local root = HelperGetRoot();
	--AddWndUpdateFunc(root:GetLXZWindow("Menu"), EffectFaceOut, {time=LXZAPI_timeGetTime()+500, from=255,step=7,hide=true});
	EffectCircleButtonNoSound(root:GetLXZWindow("Menu:return"), function()
		root:GetLXZWindow("Menu"):Hide();
		if(GameData.oldstate ~= nil) then
			GameData.state = GameData.oldstate;		
			GameData.oldstate = nil;			
		end
	end);
end

local function OnRelogin(window, msg0, sender)
	local root = HelperGetRoot();	
	-- EffectNormalButton(root:GetLXZWindow("Menu:Continue"), function()
	EffectAnimateMenuHide("Continue", function()
		root:GetLXZWindow("Menu"):Hide();	
		root:GetLXZWindow("Load"):Show();		
		--
		EffectAnimateLoading();
	end);
	
	--PlayEffect("menu.wav");
end

local function OnExitMsgBox(window, msg0, sender)
	local root = HelperGetRoot();	
	EffectCircleButton(root:GetLXZWindow("MessageBox:return"), function()
		root:GetLXZWindow("MessageBox"):Hide();	
		--PlayEffect("menu.wav");
	end);
end

local function OnExitGameHelp(window, msg0, sender)
	local root = HelperGetRoot();	
	EffectCircleButtonNoSound(root:GetLXZWindow("Game:help:return"), function()
		root:GetLXZWindow("Game:help"):Hide();	
		--PlayEffect("menu.wav");
		--ShowGameHeadWindow();
		
		IS_ANIMATE_HELP = false;
		
		GameData.helptimer = 0;
		GameData.helpindex = 1;
		GameData.helpactionlist ={};
		
		GameData.state = GameData.oldstate;		
		GameData.oldstate = nil;	

		--
		if(ANIMATE_HELP == ANIMATE_HELP_GAME) then
			ShowGameHeadWindow();
		elseif(ANIMATE_HELP==ANIMATE_HELP_LOAD) then
			root:GetLXZWindow("Load"):Show();	
		end
		
		UpdateDataToUI();
		
		if(GameData.helpthread ~= nil) then
			coroutine.resume(GameData.helpthread);
			GameData.helpthread=nil;
		end

	end);
	
end

local function OnHelp(window, msg0, sender)
	--LXZMessageBox("OnHelp");
	local root = HelperGetRoot();	
	EffectCircleButtonNoSound(root:GetLXZWindow("Load:help"), function()

		local co = coroutine.create(function(thread)		
			HideGameHeadWindow();
			root:GetLXZWindow("Game:background"):Show();
			root:GetLXZWindow("Game:main"):Hide();
			root:GetLXZWindow("Load"):Hide();
			root:GetLXZWindow("Help"):Hide();
			root:GetLXZWindow("Menu"):Hide();	
			
			--root:GetLXZWindow("Game:background"):Show();
			--root:GetLXZWindow("Game:background"):Show();
			
			--
			--ShowGameHeadWindow();
			
			--
			CreateGameBackground();
			
			local help = root:GetLXZWindow("Game:help");	
			local control = root:GetLXZWindow("Game:control");	
			help:Show();
			help:GetChild("main"):ClearChilds();
			control:ClearChilds();
			root:GetLXZWindow("Game:help:hand"):Hide();
			
			--
			local tips = root:GetLXZWindow("Game:helptips");
			tips:Show();		
			tips:SetHeight(30*GameData.scale);
			
		--	LXZMessageBox("sssaaaaa");
		
				--
			local function waitclick()
				--wait click
				root:DelBit(STATUS_IsDisable);
				tips.tipsthread = thread;
				coroutine.yield();
				root:SetBit(STATUS_IsDisable);
			end
			
			--		
			EffectAnimateTextAndScaleWnd(tips, "In the integer queue， if an integer is bigger than the previous one, then add it, otherwise subtract it, the accounting result turns out as a new integer.\n\nclick to skip", thread,10);				
			tips:SetCapture();
			coroutine.yield();			
			waitclick();
									
			EffectAnimateTextAndScaleWnd(tips, "the link of continous ascending sequence of integers can get you super hit points, the longer the sequence is, the more points you get. \n\nclick to skip", thread,10);				
			tips:SetCapture();
			coroutine.yield();			
			waitclick();						
				
			EffectAnimateTextAndScaleWnd(tips, "game demo", nil,30);
			AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+1000},thread);
			coroutine.yield();		
			
			tips:Hide();
			root:DelBit(STATUS_IsDisable);
			--LXZMessageBox("aaaaa");
			
			--
			HideGameHeadWindow();

						
			ANIMATE_HELP = ANIMATE_HELP_LOAD;
			HELP_TIMER_INTERVAL=200;
			GameData.helplevel = 10;
			GameData.helpthread = thread;
			ShowHelpAnimate("help");
			coroutine.yield();
			
			help:GetChild("main"):ClearChilds();
			control:ClearChilds();
			
			root:GetLXZWindow("Load"):Show();
			root:GetLXZWindow("Help"):Hide();
			local help = root:GetLXZWindow("Game:help");	
			help:Hide();
			root:GetLXZWindow("Game:help:hand"):Hide();
			

		end);
		
		coroutine.resume(co,co);
		
	end);
	
	--	
end

local function OnWeiBo(window, msg0, sender)
--	LXZMessageBox("OnWeiBo");
	ShowTipMessage("Twitter share");
	
	local root = HelperGetRoot();	
	EffectCircleButtonNoSound(root:GetLXZWindow("Load:weibo"), function() 
		local ret = LXZAPI_CallSystemAPI("OnTwitter", "Super Einstein is a brand-new intelligent game. I have just got "..GetSumOfAllScores().." points, welcome to play with me together "..math.random(0,9));	
		if(ret == nil or ret=="") then
			ShowTipMessage("Twitter share successed!");
		else
			ShowTipMessage("Twitter share failed!");
		end
	end);
	--PlayEffect("menu.wav");
end

local function OnLoadingSetOption(window, msg0, sender)
		local root = HelperGetRoot();	
		EffectCircleButtonNoSound(root:GetLXZWindow("Load:setoption"), function() 
			root:GetLXZWindow("option"):Show();	
		OPTION_UI_FROM = OPTION_UI_FROM_LOAD;
			--PlayEffect("menu.wav");
		end);
end

local function OnSetOption(window, msg0, sender)
	--LXZMessageBox("OnSetOption");
	local root = HelperGetRoot();	
		--EffectNormalButton(root:GetLXZWindow("Menu:Option"),function() 
		EffectAnimateMenuHide("Option", function()
			root:GetLXZWindow("option"):Show();		
			OPTION_UI_FROM = OPTION_UI_FROM_MENU;
			--PlayEffect("menu.wav");
		end);		
end

local function OnReturnLogin(window, msg0, sender)
	local root = HelperGetRoot();	
	EffectCircleButtonNoSound(root:GetLXZWindow("option:return"), function()
		root:GetLXZWindow("option"):Hide();	
		if(OPTION_UI_FROM == OPTION_UI_FROM_LOAD) then
			root:GetLXZWindow("Load"):Show();	
		elseif(OPTION_UI_FROM == OPTION_UI_FROM_MENU) then
			--root:GetLXZWindow("Menu"):Show();	
			EffectAnimateMenuShow();
		end
		--PlayEffect("menu.wav");
	end);
	
end

local function OnPlayStage(window, msg0, sender)
	--LXZMessageBox("OnPlayStage");
	--StartGame(GameData.level);
	local root = HelperGetRoot();	
	EffectNormalButton(root:GetLXZWindow("LevelSets:playbtn"), function()
		StartGame(GameData.selectlevel);		
		
		root:GetLXZWindow("LevelSets"):Hide();
		root:GetLXZWindow("Menu"):Hide();
	end, true);
	
	--PlayEffect("menu.wav");
end

local function OnSelectStage(window, msg0, sender)
	local level = tonumber(HelperGetWindowText(sender:GetChild("num")));
--	LXZMessageBox("sender:"..sender:GetName());
	if(sender:GetChild("lock"):IsVisible()==true and level>=19) then	
		ShowMessageBox("Do you confirm to buy or restore 19-45 game stage?", function(param) 
			LXZAPI_CallSystemAPI("BuyGameStage", "");
			ShowTipMessage("ok");
			--GameData.buy = 1; --testBaidu
			UpdateStageUI();
			end,
			nil,
			function(param) ShowTipMessage("cancel"); end,
			nil);
		return;
	end
	
	if(level>GameData.highlevel) then
		return;
	end

	EffectCircleButtonNoSound(sender, function()
		HelperSetWindowTextColor(sender:GetChild("num"), 255,255,0,255);
		GameData.selectlevel = level;
		UpdateStageUI();
		
		local root = HelperGetRoot();
		local coe = 1*GameData.scale;	
		AddWndUpdateFunc(root:GetLXZWindow("LevelSets:playbtn"), EffectShake, {interval=15, frame={{0,5},{0,4},{0,3},{0,2},{0,1}}, coe=coe});
				
	end);
	
	--PlayEffect("menu.wav");
		
end

local function OnReturnMenu(window, msg0, sender)
	local root = HelperGetRoot();
	EffectCircleButtonNoSound(root:GetLXZWindow("LevelSets:return"), function()
		root:GetLXZWindow("LevelSets"):Hide();
		root:GetLXZWindow("Menu"):Show();
		EffectAnimateMenuShow();
		--PlayEffect("menu.wav");
	end);

end

local function OnStageDragging(window, msg0, sender)
	local x = msg0:int();
	local y = msg0:int();

	local root = HelperGetRoot();	
	local wnd = root:GetLXZWindow("LevelSets:Sets");
	
	if(corecfg.nUserSaveX==-1) then
		corecfg.nUserSaveX = x;
		return;
	end
	
	local corecfg = ICGuiGetLXZCoreCfg();
	local offsetx = x-corecfg.nUserSaveX;
	local old = wnd:GetExtX();
	local newx = old+offsetx;
		
	corecfg.nUserSaveX = x;
	if(newx<(-4*320*GameData.scale)) then
		newx = -4*320*GameData.scale;
	elseif(newx>0) then
		newx=0;
	end

	if(math.abs(x-corecfg.nClickDownX)>=1) then
		--wnd:EnableDrag();	
		sender:EnableDrag();
		wnd:SetExtX(newx);
	end
	
end

local function OnStageDraggingEnd(window, msg0, sender)
	local x = msg0:int();
	local y = msg0:int();
	
	local corecfg = ICGuiGetLXZCoreCfg();
	local offsetx = x-corecfg.nClickDownX;

	local root = HelperGetRoot();	
	local wnd = root:GetLXZWindow("LevelSets:Sets");
	--wnd:SetExtX(0);
	
	if(GameData.currentpage == nil) then
		GameData.selectlevel = GameData.level;
		GameData.currentpage = 1+math.floor((GameData.selectlevel-1)/9);			
	end
	
	local nextpage = GameData.currentpage;
	if(offsetx<0) then
		nextpage = nextpage+1;		
	elseif (offsetx>0) then		
		nextpage = nextpage-1;
	end
		
	if(nextpage<=0 or nextpage>5) then
		UpdateStageUI();
		return;
	end
	
	--LXZMessageBox("DragingEnd:"..nextpage.." offsetx:"..offsetx);
	GameData.currentpage = nextpage;		
	UpdateStageUI();
	
--	PlayEffect("menu.wav");
	
end

function UpdateEditUI()
	local root = HelperGetRoot();
	
	if(DATA_LEVEL==DATA_LEVEL_NEW) then
		HelperSetWindowText(root:GetLXZWindow("Game:leveldata"),  "new");
	elseif(DATA_LEVEL==DATA_LEVEL_LOCAL) then
		HelperSetWindowText(root:GetLXZWindow("Game:leveldata"), "local");
	elseif(DATA_LEVEL==DATA_LEVEL_NET) then
		HelperSetWindowText(root:GetLXZWindow("Game:leveldata"), "net");
	end
	
	--
	if(GameData.level>=10 and IS_MAKE_GAME==0) then
		HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 192, 192, 192, 255);		
		root:GetLXZWindow("Game:helpbtn"):SetBit(STATUS_IsDisable);
	else
		HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 255, 255, 255, 255);	
		root:GetLXZWindow("Game:helpbtn"):DelBit(STATUS_IsDisable);
	end
	
	if(MAKE_GAME==1) then	
	
		if(IS_MAKE_GAME==MAKE_GAME_WALL) then
			HelperSetWindowPictureColor(root:GetLXZWindow("Game:elementbtn"), 255, 255, 255, 255, "wall");
		elseif(IS_MAKE_GAME==MAKE_GAME_COLOR) then	
			HelperSetWindowPictureColor(root:GetLXZWindow("Game:elementbtn"), 155, 255, 0, 255, "wall");
		elseif(IS_MAKE_GAME==MAKE_GAME_ELEMENT) then	
			HelperSetWindowPictureColor(root:GetLXZWindow("Game:elementbtn"), 255, 255, 255, 0, "wall");
		end
	
		if(IS_MAKE_GAME ~= 0) then
			root:GetLXZWindow("Game:savebtn"):Show();
			root:GetLXZWindow("Game:uploadbtn"):Show();
			root:GetLXZWindow("Game:uploadallbtn"):Show();
			root:GetLXZWindow("Game:elementbtn"):Show();
			root:GetLXZWindow("Game:leveldata"):Show();
			root:GetLXZWindow("Game:makegamebtn"):Show();
			root:GetLXZWindow("Game:savehelpbtn"):Show();
			HelperSetWindowText(root:GetLXZWindow("Game:makegamebtn"), "game");
		--	LXZMessageBox("MAKE_GAME:"..MAKE_GAME.." IS_MAKE_GAME:"..IS_MAKE_GAME);
		else
			root:GetLXZWindow("Game:savebtn"):Show();
			root:GetLXZWindow("Game:uploadbtn"):Show();
			root:GetLXZWindow("Game:uploadallbtn"):Show();
			root:GetLXZWindow("Game:elementbtn"):Hide();
			root:GetLXZWindow("Game:leveldata"):Show();
			root:GetLXZWindow("Game:makegamebtn"):Show();
			root:GetLXZWindow("Game:savehelpbtn"):Show();
			HelperSetWindowText(root:GetLXZWindow("Game:makegamebtn"), "edit");
		end
	else
			root:GetLXZWindow("Game:savebtn"):Hide();
			root:GetLXZWindow("Game:savehelpbtn"):Hide();
			root:GetLXZWindow("Game:uploadbtn"):Hide();
			root:GetLXZWindow("Game:uploadallbtn"):Hide();
			root:GetLXZWindow("Game:elementbtn"):Hide();
			root:GetLXZWindow("Game:leveldata"):Hide();
			root:GetLXZWindow("Game:makegamebtn"):Hide();
			HelperSetWindowText(root:GetLXZWindow("Game:makegamebtn"), "edit");
	end
		
end

local function OnActiveMakeGame(window, msg0, sender)
	if(MAKE_GAME==0) then
		MAKE_GAME=0;--1;
	else
		MAKE_GAME=0;
	end
	
	UpdateEditUI();
end

local function OnSetLevelData(window, msg0, sender)
	
	DATA_LEVEL = math.mod(DATA_LEVEL+1, 3);	
	UpdateEditUI();

end

local function OnVolumeDragging(window, msg0, sender)
	local x = msg0:int();
	local y = msg0:int();

	local root = HelperGetRoot();	
	local wnd = root:GetLXZWindow("option:volumebar");
	
	local dot = wnd:GetChild("dot");
	local volumebtn = root:GetLXZWindow("option:volume");
	
	local width = wnd:GetWidth();
	
	local corecfg = ICGuiGetLXZCoreCfg();
		
	if(corecfg.nUserSaveX==-1) then
		corecfg.nUserSaveX = x;
		corecfg.nUserSaveY  = y;
		return;
	end
	
	local offsetx = x-corecfg.nUserSaveX;
	
	--
	corecfg.nUserSaveX = x;
	corecfg.nUserSaveY  = y;

	--wnd:SetExtX(offsetx);
	dot:EnableDrag();
		
	local pt = LXZPoint:new_local();
	dot:GetHotPos(pt);
	
	pt.x = pt.x+offsetx;
	if(pt.x<0) then
		pt.x = 0;
	elseif(pt.x>width) then
		pt.x = width;
	end
	
	local vol = pt.x/width;
	SetVolume(vol);
	
	PlayEffect("volume.wav");
	
end

function SetVolume(vol)
	local root = HelperGetRoot();	
	local wnd = root:GetLXZWindow("option:volumebar");
	
	local dot = wnd:GetChild("dot");
	local volumebtn = root:GetLXZWindow("option:volume");
	
	local width = wnd:GetWidth();
	
	local pt = LXZPoint:new_local();
	dot:GetHotPos(pt);
	
	pt.x = width*vol;	
	dot:SetHotPos(pt);	
	
	volumebtn:SetWidth(pt.x);
	
	local audio = SimpleAudioEngine:sharedEngine();
	audio:setBackgroundMusicVolume(vol);
	audio:setEffectsVolume(vol);		
	
	GameData.volume = vol;
	
end

local function OnVolumeDraggingEnd(window, msg0, sender)
	--LXZMessageBox("OnVolumeDraggingEnd");
	SaveDBCurrentUser();
end

function ShowMessageBox(text, funcok, paramok,  funccacel, paramcancel)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MessageBox");
	local textwnd = wnd:GetChild("text");
	HelperSetWindowText(textwnd, text);
	wnd.funcok = funcok;
	wnd.paramok = paramok;
	wnd.funccancel = funccancel;
	wnd.paramcancel = paramcancel;
	
	wnd:Show();
	wnd:GetParent():LayerTop(wnd);
	EffectAnimateMessageBox();
	
	wnd:SetCapture();
	
end

function ShowMsgBox(text, funcok, paramok,  funccacel, paramcancel)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MsgBox");
	local textwnd = wnd:GetChild("text");
	HelperSetWindowText(textwnd, text);
	wnd.funcok = funcok;
	wnd.paramok = paramok;
	wnd.funccancel = funccancel;
	wnd.paramcancel = paramcancel;
	
	wnd:Show();
	wnd:GetParent():LayerTop(wnd);
	EffectAnimateMsgBox();
	
	wnd:SetCapture();
	
end


function AddWndUpdateFunc(wnd, func, param, thread, id, updateself)
	if(wnd.update==nil) then
		wnd.update = {};
	end
	
	--start it
	func(wnd, param);

	--
	tblUpdateWnd[wnd:GetID()] = wnd;
	wnd.updateself = updateself;
	
	--	
	local del = 0;
	for i = 1, table.getn(wnd.update),1 do
		local v = wnd.update[i];
		if(v ~= nil and v.f ~= nil) then
			if(v.f==func and id==v.fid) then		
				v.f = func;
				v.p = param;
				v.thread = thread;
				v.id = wnd:GetID();
				v.fid = id;
				return;
			end
		else
			del = i;
		end		
	end
	
	if(del>0) then
		wnd.update[del] = {f=func,p=param,thread=thread,id=wnd:GetID(),fid=id};
	else
		table.insert(wnd.update, {f=func,p=param,thread=thread,id=wnd:GetID(),fid=id});
	end
	
end


local function OnExtraEffectMoving(window, msg0, sender)
	local r,g,b,a = HelperGetWindowPictureColor(sender);
	a = a-5;
	if(a<0) then
		a = 0;
	end
			
	HelperSetWindowPictureColor(sender, r,g,b,a);	

end

local function OnMessageBoxOk(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MessageBox");
	EffectNormalButton(wnd:GetChild("okbtn"), function()	
		if(wnd.funcok~= nil) then
			wnd.funcok(wnd.paramok);
			wnd.funcok = nil;
			wnd.paramok = nil;
		end	
		wnd:Hide();
	end, true);
	
end

local function OnMessageBoxCancel(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MessageBox");
	EffectNormalButton(wnd:GetChild("cancelbtn"), function()	
		if(wnd.funccancel~= nil) then
			wnd.funccancel(wnd.paramcancel);
			wnd.funccancel = nil;
			wnd.paramcancel = nil;
		end
		
		wnd:Hide();	
		
	end, true);
	
end

--
local function OnMsgBoxOk(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MsgBox");
	EffectNormalButton(wnd:GetChild("okbtn"), function()	
		if(wnd.funcok~= nil) then
			wnd.funcok(wnd.paramok);
			wnd.funcok = nil;
			wnd.paramok = nil;
		end	
		wnd:Hide();
	end, true);
	
end

local function OnMsgBoxCancel(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("MsgBox");
	EffectNormalButton(wnd:GetChild("cancelbtn"), function()	
		if(wnd.funccancel~= nil) then
			wnd.funccancel(wnd.paramcancel);
			wnd.funccancel = nil;
			wnd.paramcancel = nil;
		end
		
		wnd:Hide();	
		
	end, true);
	
end

local function OnZoom(window, msg0, sender)
	local scale = msg0:float();
		
	GameData.scale = scale;
	local windic = CLXZWindowDicMgr:GetDicByName("CrazyWallStreet.cls");
	windic:Zoom(scale);	

end

function IntergalTimes(a, b)
	if(math.floor(a/b)==(a/b)) then
		return true;
	end
	
	return false;
end

local function OnAutoScale(window, msg0, sender)
	local root = HelperGetRoot();	
	local corecfg = ICGuiGetLXZCoreCfg();	
	local sysos = LXZAPIGetOS();
	local pt = LXZPoint:new_local();
	
	--
	root:GetLXZWindow("Load"):SetBit(STATUS_IsExternWindow);
	root:GetLXZWindow("Menu"):SetBit(STATUS_IsExternWindow);
	root:GetLXZWindow("LevelSets"):SetBit(STATUS_IsExternWindow);
	
	if(sysos == "IOS") then	
		local platform = LXZAPI_CallSystemAPI("getTargetPlatform");
		if(platform == "iphone") then		
			if(IntergalTimes(corecfg.nScreenHeight,568)==true) then
				root:GetLXZWindow("Load"):SetExtY(30*GameData.scale);			
				root:GetLXZWindow("Menu"):SetExtY(44*GameData.scale);	
				root:GetLXZWindow("LevelSets"):SetExtY(44*GameData.scale);	
				root:GetLXZWindow("option"):SetExtY(44*GameData.scale);	
				root:GetLXZWindow("option"):Invalidate();
				root:GetLXZWindow("Load"):Invalidate();
				root:GetLXZWindow("Menu"):Invalidate();	
				root:GetLXZWindow("LevelSets"):Invalidate();	
				root:GetLXZWindow("Game:fail"):SetExtY(44*GameData.scale);	
				root:GetLXZWindow("Game:win"):SetExtY(44*GameData.scale);	
				OFFSET_Y = 160;
			elseif(IntergalTimes(corecfg.nScreenHeight,480)==true) then
				root:GetLXZWindow("Load"):SetExtY(0);
				root:GetLXZWindow("Menu"):SetExtY(0);	
				root:GetLXZWindow("LevelSets"):SetExtY(0);	
				root:GetLXZWindow("option"):SetExtY(0);	
				root:GetLXZWindow("option"):Invalidate();
				root:GetLXZWindow("Load"):Invalidate();		
				root:GetLXZWindow("Menu"):Invalidate();	
				root:GetLXZWindow("LevelSets"):Invalidate();	
				root:GetLXZWindow("Game:fail"):SetExtY(0);	
				root:GetLXZWindow("Game:win"):SetExtY(0);	
				OFFSET_Y = 125;		
			end
		end
		
		corecfg.fAutoScaleX = 1;
		corecfg.fAutoScaleY  = 1;	
	end
		
	--[[local wnd = root:GetLXZWindow("Game:timer");
	local pt = LXZPoint:new_local();
	wnd:GetPos(pt);
	ShowTipMessage("Timer x: "..pt.x.." y:"..pt.y);]]	
	corecfg.nAutoOffsetX = (corecfg.nScreenWidth-root:GetWidth()*corecfg.fAutoScaleX)/2;
	corecfg.nAutoOffsetY = (corecfg.nScreenHeight-root:GetHeight()*corecfg.fAutoScaleY)/2;
	if(corecfg.nAutoOffsetX<0) then
		corecfg.nAutoOffsetX = 0;
	end
	
	if(corecfg.nAutoOffsetY<0) then
		corecfg.nAutoOffsetY = 0;
	end
	--ShowTipMessage("LXZAPIGetWritePath(): "..LXZAPIGetWritePath());
	
	local wnd = root:GetLXZWindow("Load");
	if(GameData.state ~= STATE_RUN and wnd:IsVisible() == true) then
		EffectAnimateLoading();
	end
	--		
	
	--	
	root:GetLXZWindow("Game:timer"):GetPos(pt);
	pt.y = pt.y+root:GetLXZWindow("Game:timer"):GetHeight();	
	wnd = root:GetLXZWindow("Game:bonustips");	
	local y = (pt.y+OFFSET_Y*GameData.scale)/2;	
	wnd:GetPos(pt)
	pt.y = y;
	pt.x = root:GetWidth()/2;
	wnd:SetHotPos(pt);
	
end

function LoadPlayRecord()
	local root = HelperGetRoot();	
	local size = LXZAPI_GetFileSize(LXZAPIGetWritePath().."record.nda");
	local main = root:GetLXZWindow("Game:main");
	main:Show();
	if(size>0) then
		if(LoadGameLevel("record.nda", "",  main)==true) then
			
			--
			if(main:GetChildCount()<=1) then
				return false;
			end
			
			--
			IS_ANIMATE_START = true;
			GameData.highscore = LoadLevelHighScore(GameData.level);
			EffectAnitmateGameStart();
			
			--			
			--
			root:GetLXZWindow("Load"):Hide();
			root:GetLXZWindow("Menu"):Hide();	

		if(GameData.level>=10 and IS_MAKE_GAME==0) then
			HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 192, 192, 192, 255);		
			root:GetLXZWindow("Game:helpbtn"):SetBit(STATUS_IsDisable);
		else
			HelperSetWindowPictureColor(root:GetLXZWindow("Game:helpbtn"), 255, 255, 255, 255);	
			root:GetLXZWindow("Game:helpbtn"):DelBit(STATUS_IsDisable);
		end
			
			--
			--UpdateDataToUI();
			--PlayEffect("startgame.wav");
			return true;
		end
	end	
	
	return false;
end

function EffectAnimateStudyHelp()
	local root = HelperGetRoot();	
	local GameWnd = root:GetLXZWindow("Game");
	local pt = LXZPoint:new_local();	
		
	local co = coroutine.create(function (thread)		
		local tips = root:GetLXZWindow("Game:helptips");
		local main = root:GetLXZWindow("Game:main");
		root:SetBit(STATUS_IsDisable);
		tips:Show();
		main:SetBit(STATUS_IsHideChildren);
		tips:SetHeight(30*GameData.scale);
		
		if(GameData.level==1) then		
			
			AddWndUpdateFunc(root:GetLXZWindow("Game:list"), EffectAnimate, {interval=100, playcnt=10, file={"game1.png","game5.png"}, frame={"elementsumbk", "elementsumbk"}});
			EffectAnimateTextAndScaleWnd(tips, "the accounting result ", thread,30);
			coroutine.yield();
			
			AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+1000},thread);
			coroutine.yield();	
			
			tips:SetHeight(25*GameData.scale);			
			AddWndUpdateFunc(root:GetLXZWindow("Game:timertitle"), EffectAnimate, {interval=100, playcnt=10, file={"","game5.png"}, frame={"", "timerbk"}},thread);
			EffectAnimateText(tips, "game countdown ", nil,30);
			coroutine.yield();
			

			AddWndUpdateFunc(root:GetLXZWindow("Game:pause"), EffectAnimate, {interval=100, playcnt=10, file={"game1.png","game5.png"}, frame={"menubtn", "menubtn"}},thread);
			EffectAnimateText(tips, "game menu ", nil,30);
			coroutine.yield();
			
			
			AddWndUpdateFunc(root:GetLXZWindow("Game:helpbtn"), EffectAnimate, {interval=100, playcnt=10, file={"game1.png","game1.png"}, frame={"helpup", "helpdown"}},thread);
			EffectAnimateText(tips, "stage help button ", nil,30);
			coroutine.yield();
			
			
			AddWndUpdateFunc(root:GetLXZWindow("Game:withdrawbtn"), EffectAnimate, {interval=100, playcnt=10, file={"game1.png","game5.png"}, frame={"livesbk", "livesbk"}},thread);			
			EffectAnimateText(tips, "withdraw button ", nil,30);
			coroutine.yield();
									
			--
			EffectAnimateTextAndScaleWnd(tips, "game demo", nil,30);
			AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+1000},thread);
			coroutine.yield();		
			
			--animate help
			tips:Hide();
			HideGameHeadWindow();
			root:GetLXZWindow("Game:background"):Show();
			root:GetLXZWindow("Game:main"):Hide();
			ANIMATE_HELP = ANIMATE_HELP_GAME;
			HELP_TIMER_INTERVAL=200;
			GameData.helplevel = GameData.level;
			GameData.helpthread = thread;
			ShowHelpAnimate(tostring(GameData.helplevel));
			coroutine.yield();
			ShowGameHeadWindow();
			root:GetLXZWindow("Game:main"):Show();
			root:GetLXZWindow("Game:help"):Hide();
			--end
			
			--
			EffectAnimateTextAndScaleWnd(tips, "game start", thread,100);
			coroutine.yield();
			AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+1000},thread);
			coroutine.yield();	
			tips:Hide();
			
		end
				
		--tips hide
		tips:Hide();
						
		main:DelBit(STATUS_IsHideChildren);				
		root:DelBit(STATUS_IsDisable);
				
		--
		GameData.state = STATE_RUN;
		GameData.time = os.time();
		UpdateDataToUI();
		
		EffectAnitmateGameStart(true);
	end);
	
	coroutine.resume(co,co);
end


function EffectAnitmateGameStart(IsNoHelp)

	if(GameData.level<=1 and IsNoHelp==nil) then
		EffectAnimateStudyHelp();
		return;
	end
	
	local root = HelperGetRoot();	
	local main = root:GetLXZWindow("Game:main");
	local pt = LXZPoint:new_local();	
		
	local co = coroutine.create(function (thread)		
		local target = GetWinCoin();
		
		root:SetBit(STATUS_IsDisable);
		main:SetBit(STATUS_IsHideChildren);
		
		local pt = LXZPoint:new_local();
		PlayEffect("click.wav");
		
		--
		root:GetLXZWindow("Game:targetpointtips"):Hide();	
		
		--
		if(GameData.prevlevel == GameData.level and GameData.level<5) then
			local tips = root:GetLXZWindow("Game:helptips");
			AddWndUpdateFunc(root:GetLXZWindow("Game:helpbtn"), EffectAnimate, {interval=100, playcnt=10, file={"game1.png","game1.png"}, frame={"helpup", "helpdown"}},thread);
			EffectAnimateText(tips, "stage help button ", nil,30);
			tips:Show();
			coroutine.yield();
			tips:Hide();
		end
		
				
		root:GetLXZWindow("Game:leveltips"):Show();	
		root:GetLXZWindow("Game:leveltips"):GetHotPos(pt);
		AddWndUpdateFunc(root:GetLXZWindow("Game:leveltips"), EffectMove, {speed=20*GameData.scale, dir=4, range=50, acce=-0.05, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
		AddWndUpdateFunc(root:GetLXZWindow("Game:leveltips"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
		--AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+200}, thread);
		coroutine.yield();
	--	PlayEffect("click.wav");	
			
		EffectAnimateText(root:GetLXZWindow("Game:leveltips:text"), tostring(GameData.level), thread,15, true);
		coroutine.yield();
		
		root:GetLXZWindow("Game:targetpointtips"):Show();	
		root:GetLXZWindow("Game:targetpointtips"):GetHotPos(pt);
		AddWndUpdateFunc(root:GetLXZWindow("Game:targetpointtips"), EffectMove, {speed=20*GameData.scale, dir=4, range=50, acce=-0.05, fromx = pt.x+150*GameData.scale, fromy = pt.y,x=pt.x, y=pt.y}, thread);
		AddWndUpdateFunc(root:GetLXZWindow("Game:targetpointtips"), EffectFaceIn, {time=LXZAPI_timeGetTime()+500, from=0,step=10});									
		--AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+200}, thread);
		coroutine.yield();
		--PlayEffect("click.wav");	
		
		EffectAnimateText(root:GetLXZWindow("Game:targetpointtips:text"), tostring(target), thread,15, true);
		coroutine.yield();
		
		AddWndUpdateFunc(root, EffectTimer, {time=LXZAPI_timeGetTime()+500},thread);
		coroutine.yield();
		
		AddWndUpdateFunc(root:GetLXZWindow("Game:leveltips"), EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=20,hide=true}, nil);		
		AddWndUpdateFunc(root:GetLXZWindow("Game:targetpointtips"), EffectFaceOut, {time=LXZAPI_timeGetTime()+300, from=255,step=20,hide=true}, thread);
		coroutine.yield();

		local func = function()
			AddWndUpdateFunc(root:GetLXZWindow("Game:target"), EffectColorText, {interval=30, playcnt=20, frame={{255,255,255,255},{0,0,0,0}}});
			--AddWndUpdateFunc(root:GetLXZWindow("Game:target"), EffectPlaySound, {interval=60, playcnt=10, frame={"click.wav","click.wav"}});
		end
		
		local rowcols = MAX_ROW+MAX_COL;
		local vec = LXZVector2D:new_local();
		
		local org = LXZPoint:new_local();
		org.x,org.y = GetPosByRowCol(0, 0);
		
	--[[	vec.x = 1;
		vec.y  = 1;
		vec:normalize();
		org.x = org.x-vec.x*150*GameData.scale;
		org.y = org.y-vec.y*150*GameData.scale;--]]
		
		AddWndUpdateFunc(main, EffectTimer, {time=LXZAPI_timeGetTime()+300, func=func},thread);
		--PlayEffect("startgame.wav");
		main:DelBit(STATUS_IsHideChildren);
		local wnd = main:GetFirstChild();
		while (wnd ~= nil) do
			--wnd:GetHotPos(pt);		
			local row,col = GetRowColByWnd(wnd);
			pt.x, pt.y = GetPosByRowCol(row, col);
			local index = GetIndexByRowCol(row,col);			
			
			wnd.update = nil;
			wnd:SetHotPos(pt);				

			vec.x = pt.x;
			vec.y  = pt.y;
			vec:normalize();
			
			--AddWndUpdateFunc(wnd, EffectMove,{speed=1*GameData.scale, dirx=vec.x*(col+1)*1, diry=vec.y*(row+1)*1, range=5, acce=0, fromx = org.x, fromy = org.y,x=pt.x, y=pt.y});
			--AddWndUpdateFunc(wnd, EffectZoomInFunc, {step=0.01, acc=0.008, from=0,max=1})					
			
			wnd:Hide();
			AddWndUpdateFunc(wnd, EffectTimer, {time=LXZAPI_timeGetTime()+20*(row+col),  func= function(wnd) wnd:Show(); AddWndUpdateFunc(wnd, EffectZoomInFunc, {step=0.01, acc=0.015, from=0,max=1}); AddWndUpdateFunc(wnd, EffectRotateFunc, {speed=0.1,  acce=0.055, playcnt=1}); end});
					
			wnd = wnd:GetNextSibling();
		end		
		coroutine.yield();
		
		
		GameData.state = STATE_RUN;
		GameData.time = os.time();
		UpdateDataToUI();
		
		local function func_countdown(wnd, tblParam)
			--LXZMessageBox("AAAA");
			AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectColorText, {interval=30, playcnt=30*tblParam.soundcnt, frame={{255,255,255,255},{255,255,255,100}}});
			AddWndUpdateFunc(root:GetLXZWindow("Game:timer"), EffectPlaySound, {interval=tblParam.sndinterval, playcnt=tblParam.soundcnt, frame={"timenotify.wav"}});					
		end
				
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=240*1000,  func=func_countdown, soundcnt=1, sndinterval=0}, nil, 1);		
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=180*1000,  func=func_countdown, soundcnt=2, sndinterval=500}, nil, 2);
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=120*1000,  func=func_countdown, soundcnt=3, sndinterval=400}, nil, 3);
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=60*1000,  func=func_countdown, soundcnt=4, sndinterval=300}, nil, 4);
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=30*1000,   func=func_countdown, soundcnt=5, sndinterval=200}, nil, 5);
		AddWndUpdateFunc(root, EffectGameCountdown, {totaltimes=GameData.timer*1000, countdown=10*1000,   func=func_countdown, soundcnt=10, sndinterval=1000}, nil, 6);		
		
			
	--[[	local wnd = main:GetFirstChild();
		while (wnd ~= nil) do
			AddWndUpdateFunc(wnd, EffectZoomInOutFunc, {time=LXZAPI_timeGetTime()+2000,step=0.01,from=0.95,max=1.1,playcnt=10});
			wnd = wnd:GetNextSibling();
		end		--]]
		
		root:DelBit(STATUS_IsDisable);				
	end);
	
	local res,err = coroutine.resume(co,co);
	if(res==false) then
		LXZMessageBox("start game:"..err);
	end
	
end

local function OnHelpRule(window, msg0, sender)
	local root = HelperGetRoot();	
	root:GetLXZWindow("Help:morehelp"):Show();
	PlayEffect("menu.wav");
	
end

local function OnExitMoreHelp(window, msg0, sender)
	local root = HelperGetRoot();	
	root:GetLXZWindow("Help:morehelp"):Hide();
	PlayEffect("menu.wav");
end

local function OnClickHelpTips(window, msg0, sender)
	local root = HelperGetRoot();
	local wnd = root:GetLXZWindow("Game:helptips");
	if(wnd.tipsthread~= nil) then
		coroutine.resume(wnd.tipsthread);
		wnd.tipsthread = nil;
	end
	--LXZMessageBox("click to skip");
end

--event call back
game_event_callback = {};
game_event_callback["OnLoad"]            = OnLoad;
game_event_callback["OnUpdate"]        = OnUpdate;
game_event_callback["OnPause"] = OnPause;
game_event_callback["OnNewGame"]  = OnNewGame;
game_event_callback["OnContinue"]     = OnRelogin;
game_event_callback["OnRanking"]      = OnRanking;
game_event_callback["OnNextLevel"]   = OnNextLevel;
--game_event_callback["OnRFingerUp"]   = OnRFingerUp;
game_event_callback["OnFingerDown"]   = OnFingerDown;
game_event_callback["OnFingerUp"]   = OnFingerUp;
game_event_callback["OnFingerMove"]   = OnFingerMove;
game_event_callback["OnScoreMode"]   = OnStage;
game_event_callback["OnComboMode"]   = OnMenuReplay;
game_event_callback["OnSetLevel"]   = OnSetLevel;
game_event_callback["OnWithdraw"]   = OnWithdraw;
game_event_callback["OnReplay"]   = OnReplay;
game_event_callback["OnBomb"]   = OnBomb;
game_event_callback["OnElementDelete"]   = OnElementDelete;
game_event_callback["OnAnimateEffect"]   = OnAnimateEffect;
game_event_callback["OnLoginLoading"]   = OnLoginLoading;
game_event_callback["OnMakeGame"]   = OnMakeGame;
game_event_callback["OnSaveGame"]   = OnSaveGame;
game_event_callback["OnUpload"]   = OnUpload;
game_event_callback["OnUploadAll"]   = OnUploadAll;
game_event_callback["OnSetColor"]   = OnSetColor;
game_event_callback["OnSetWall"]   = OnSetWall;

game_event_callback["OnPlay"]   = OnPlay;
game_event_callback["OnHelp"]   = OnHelp;
game_event_callback["OnWeiBo"]   = OnWeiBo;
game_event_callback["OnLoadingSetOption"]   = OnLoadingSetOption;
game_event_callback["OnSetOption"]   = OnSetOption;
game_event_callback["OnExitHelp"]   = OnExitHelp;
game_event_callback["OnClickHelpTips"]   = OnClickHelpTips;

game_event_callback["OnPlayStage"]   = OnPlayStage;
game_event_callback["OnSelectStage"]   = OnSelectStage;
game_event_callback["OnReturnMenu"]   = OnReturnMenu;
game_event_callback["OnStageDragging"]   = OnStageDragging;
game_event_callback["OnStageDraggingEnd"]   = OnStageDraggingEnd;
game_event_callback["OnMenuDown"]   = OnMenuDown;
game_event_callback["OnSetLevelData"] = OnSetLevelData;
game_event_callback["OnExit"] = OnExit;
game_event_callback["OnReturnLogin"] = OnReturnLogin;
game_event_callback["OnVolumeDragging"]   = OnVolumeDragging;
game_event_callback["OnVolumeDraggingEnd"]   = OnVolumeDraggingEnd;

game_event_callback["OnMessageBoxOk"]   = OnMessageBoxOk;
game_event_callback["OnMessageBoxCancel"]   = OnMessageBoxCancel;

game_event_callback["OnMsgBoxOk"]   = OnMsgBoxOk;
game_event_callback["OnMsgBoxCancel"]   = OnMsgBoxCancel;

game_event_callback["OnAutoScale"]   = OnAutoScale;
game_event_callback["OnZoom"]   = OnZoom;
game_event_callback["OnUnload"]   = OnUnload;

game_event_callback["OnGameHelp"]   = OnGameHelp;
game_event_callback["OnSaveForHelp"]   = OnSaveForHelp;
game_event_callback["OnExitGameHelp"]   = OnExitGameHelp;
game_event_callback["OnExtraEffectMoving"]   = OnExtraEffectMoving;

game_event_callback["OnExitMenu"]   = OnExitMenu;
game_event_callback["OnExitMsgBox"]   = OnExitMsgBox;

game_event_callback["OnExitMoreHelp"]   = OnExitMoreHelp;
game_event_callback["OnHelpRule"]   = OnHelpRule;
game_event_callback["OnLXZResume"]   = OnLXZResume;
game_event_callback["OnActiveMakeGame"]   = OnActiveMakeGame;
game_event_callback["OnNextLevelHelp"]   = OnNextLevelHelp;
game_event_callback["OnBuyStage"]   = OnBuyStage;
game_event_callback["OnRestore"]   = OnRestore;

local function OnTestMenu(window, msg, sender)
	LXZMessageBox("OnTestMenu");
end

game_event_callback["OnTestMenu"]   = OnTestMenu;


function CrazyWallStreet_OnEvent(window, cmd, msg, sender)
	--LXZMessageBox("cmd:"..cmd);
	--LXZAPI_OutputDebugStr("CrazyWallStreet_OnEvent:"..cmd);
	if(game_event_callback[cmd] ~= nil) then
		game_event_callback[cmd](window, msg, sender);
	end
end
