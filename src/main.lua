
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
   -- require("app.MyApp"):create():run()
    dump(cc.disable_global)
    cc.FileUtils:getInstance():addSearchPath('res/creator')
    
    local creatorReader = creator.CreatorReader:createWithFilename ('scenes/StartGame.ccreator')
    creatorReader:setup()
    local myscene = creatorReader:getSceneGraph() 
    
    local function onSceneEvent(event)
        if event == "enter" then
            
            local child = myscene:getChildByName ('Canvas'):getChildByName ('menuAnim')      
            local temp = creatorReader:getAnimationManager ()       
--            local co = coroutine.create (function ()
--                print(11)
--                local lable = cc.Label:createWithSystemFont (os.time ()
--                , "Arial", 20)
--                myscene:addChild (lable)
--                lable:move (display.cx, display.cy + 200)
--            end)
--            coroutine.resume (co)
--            local spschedule = cc.Sprite:create ()
--            myscene:addChild (spschedule)
--            spschedule:runAction(cc.Sequence:create(cc.DelayTime:create(4),cc.CallFunc:create(function(args)
--                temp:playAnimationClip(child,"menuAnim") 
--            end)))
--           for k, v in pairs( getmetatable(creatorReader:getAnimationManager())) do
--                print(k, v)
--           end

            local callbackEntry
            callbackEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)  
                temp:playAnimationClip (child, "menuAnim") 
                cc.Director:getInstance ():getScheduler ():unscheduleScriptEntry (callbackEntry)
            end, 0.5, false)


        elseif event == "enterTransitionFinish" then
        -- dump(cc.FileUtils:getInstance():getSearchPaths())
        elseif event == "exit" then

        elseif event == "exitTransitionStart" then

        elseif event == "cleanup" then

        end
    end
    myscene:registerScriptHandler(onSceneEvent)
     for k, v in pairs( getmetatable(myscene:getChildByName('Canvas'))) do
          print(k, v)
     end
   -- myscene:getChildByName('Canvas'):setScale(0.2)
    cc.Director:getInstance ():replaceScene (myscene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
