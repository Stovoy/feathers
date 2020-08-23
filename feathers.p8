pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- feathers by stovoy

player = {
 x=16,
 y=24,
 w=7,
 h=8,
 dx=0,
 dy=0,
 facing_right=true,
 jumps=2,
 sprite=2
}

game_map = {
 left = 0,
 top = 0,
 right = 800,
 bottom = 800
}

game_camera = {
 x = 0,
 y = 0
}

dirs = {
 left = 0,
 right = 1,
 up = 2,
 down = 3
}

function _init()
 cls(1)
end

function _draw()
	cls(1)
 map(0,0,0,0,game_map.right,game_map.bottom)
 spr(player.sprite,player.x,player.y,1,1,not player.facing_right)
end

function _update()
 local speed = 0.3
 local maxspeed = 2

 if btnp(2) and player.jumps > 0 then
  player.jumps -= 1
  player.dy -= 2
 end
 player.dy = min(player.dy+0.2,2)
 
 -- vertical collision
 local desty = player.y + player.dy
 if player.dy > 0 and is_colliding(player,dirs.down,0) then
  -- floor
  player.y = desty-(desty%8)
  player.dy = 0
  player.jumps = 2
 elseif player.dy < 0 and is_colliding(player,dirs.up,0) then
  -- ceiling
  player.dy = 0
 end


 if btnp(0) then
  -- left
  player.dx = min(player.dx-speed, -maxspeed)
  player.facing_right = false
 end
 if btnp(1) then
  -- right
  player.dx = max(player.dx+speed, maxspeed)
  player.facing_right = true
 end
 if player.dx > 0 then
  player.dx = max(player.dx*0.9, 0)
 else
  player.dx = min(player.dx*0.9, 0)
 end

 -- horizontal collision
 local destx = player.x+player.dx
 if player.dx < 0 and is_colliding(player,dirs.left,0) then
  -- left
  player.dx = 0
 elseif player.dx > 0 and is_colliding(player,dirs.right,0) then
  -- right
  player.dx = 0
 end

 if player.dy > 0 then
  player.sprite = 3
 else
  player.sprite = 2
 end

 player.x += player.dx
 player.y += player.dy

 game_camera.x=player.x-64
 game_camera.y=player.y-64
 game_camera.x = min(max(game_camera.x, game_map.left), game_map.right)
 game_camera.y = min(max(game_camera.y, game_map.top), game_map.bottom)
 camera(game_camera.x, game_camera.y)
end

function is_colliding(entity, direction, flag)
 local x = entity.x
 local y = entity.y
 local w = entity.w
 local h = entity.h

 local x1 = 0
 local y1 = 0
 local x2 = 0
 local y2 = 0

 if direction == dirs.left then
    x1=x-1
    y1=y
    x2=x
    y2=y+h-1
 elseif direction == dirs.right then
    x1=x+w
    y1=y
    x2=x+w+1
    y2=y+h-1
 elseif direction == dirs.up then
    x1=x+1
    y1=y-1
    x2=x+w-1
    y2=y
 elseif direction == dirs.down then
    x1=x
    y1=y+h
    x2=x+w
    y2=y+h
 end

 x1/=8
 y1/=8
 x2/=8
 y2/=8

 return fget(mget(x1,y1), flag)
  or fget(mget(x1,y2), flag)
  or fget(mget(x2,y1), flag)
  or fget(mget(x2,y2), flag)
end

__gfx__
000000001cccccc10ccccc00f0ccc0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000c1cccc1dcccfff000ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cc1cc1adccf0f000cccfff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccc71aadcccfff00ccf0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccc11aad0cc555000ccfff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cc1dd1ad0fcc50f000cc5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000c1dddd1d0c2220000c222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001dddddd100f00f000f0000f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666
cc77c777c7c7ccccc777c7c7c7c7ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc66666
c7ccc7c7c7c7cc7cc7ccc7c7ccc7ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666
c7ccc777c7c7ccccc777c777cc7cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666
c7ccc7ccc7c7cc7cccc7ccc7c7cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666
cc77c7cccc77ccccc777ccc7c7c7cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666666
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666666
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc66666666666666666
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666666666
555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc66666666666666666666
55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666666666666666
5555555555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc66666666666666666666666
55555555555555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666666666666666666
5555555555555555555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666666666666666666
555555555555555555555555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666666666666666666666
55555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666666666666666666666
555555555555555555555555555555555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc6666666666666666666666666666666
55555555555555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccccccccccccccccc666666666666666666666666666666666
5555555555555555555555555555555555555555555555ccccccccccccccccccccccccccccccccccccccccccccccc6666666667d666666666666666666666666
555555555555555555555555555555555555555555555555555ccccccccccccccccccccccccccccccccccccccccc66666666777ddddd66666666666666666666
5555555555555555555555555555555555555555555555555555555ccccccccccccccccccccccccccccccccccc6666666677777dddddddd66666666666666666
555555555555555555555555555555555555555555555555555555555555cccccccccccccccccccccccccccc666666666777777ddddddddddd66666666666666
55555555555555555555555555555555555555555555555555555555555555555cccccccccccccccccccccc6666666677777777dddddddddddddd66666666666
5555555555555555555555555555555555555555555555555555555555555555555555ccccccccccccccc666666667777777777dddddddddddddddddd6666666
55555555555555555555555555555555555555555555555555555555555555555555555555ccccccccc66666666777777777777ddddddddddddddddddddd6666
5555555555555555555555555555555555555555555555555555555555555555555555555555555ccc666666667777777777777dddddddddddddddddddddddd6
5555555555555555555555555555555555555555555555555555555555555555555555555555555556666666777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555555556666677777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555555556667777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555555556677777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555555557777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555555777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555577777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555555777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555555577777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555557777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555555777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555557777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555555777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555557777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555557777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555555555555555555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555555dddddddddd55555555555577777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777dddddddddddddddddddddd77777777777777777777777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777dddddddddddddddddddddd77777777777777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777ddddddddddddddddddddddddd777777777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777ddddddddddddddddddddddddd777777777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777ddddddddddddddddddddddddd777777777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777777ddddddddddddddddddddddddddd7777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777777ddddddddddddddddddddddddddd7777777777777777777777777777777777ddddddddddddddddddddddddd
555555555555555555555555555555555577777777ddddddddddddddddddddddddddd7777777777777777777777777777777777ddddddddddddddddddddddddd
55555555555555555555555555555555557777777777aaaaaaaaaaaaaaaaaaaaddddddddddddd77777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777777777777ddddddddddddddddddddddddddddddd77777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777777777777ddddddddddddddddddddddddddddddd77777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777777777777ddddddddddddddddddddddddddddddd77777777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777777777777ddddddddddddddddddeeeeeeeeeeeeeeeee7777777777777777777777ddddddddddddddddddddddddd
5555555555555555555555555555555555777777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddd7777777777777777ddddddddddddddddddddddddd
5555555555555555555333333333333333377777777777777eeeeeeeeeeeeeddddddddddddddddddddddddd7777777777777777ddddddddddddddddddddddddd
333333333333333333333333333333333333377777777777777dddddddddddddddddddddddddddddddddddd7777777777777777ddddddddddddddddddddddddd
333333333333333333333333333333333333337777777777777dddddddddddddddddddddddddddddddddddd7777777777777777ddddddddddddddddddddddddd
333333333333333333333333333333333333333777777777777dddddddddddddddddddddddddddddddddddd7777777777777777ddddddddddddddddddddddddd
333333333333333333333333333333333333333337777777777ddddddddddddddddddddddddddbbbbbbbbbbbbbb777777777777ddddddddddddddddddddddddd
333333333333333333333333333333333333333333777777777dddddddddddddbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb777777ddddddddddddddddddddddddd
333333333333333333333333333333333333333333337777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7ddddddddddddddddddddddddd
33333333333333333333333333333333333333333333377777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddd
3333333333333333333333333333333333333333333333777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddddddddd
333333333333333333333333333333333333333333333333777777777bbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddddddddddd333333
33333333333333333333333333333333333333333333333337777777777bbbbbbbddddddddddddddddddddddddddddddddddddddddddddddddd3333333333333
333333333333333333333333333333333333333333333333337777777777dddddddddddddddddddddddddddddddddddddddddddddddd33333333333333333333
333333333333333333333333333333333333333333333333333377777777ddddddddddddddddddddddddddddddddddddddddd333333333333333333333333333
333333333333333333333333333333333333333333333333333337777777dddddddddddddddddddddddddddddddddd3333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333377777dddddddddddddddddddddddddd333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333337777ddddddddddddddddddd3333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333777dddddddddddd33333333333333333333333333333333333333333333333333333333
333333333333333333333333333333333333333333333333333333333337ddddd333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

__gff__
0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000010000000000010000000101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000010101010100000101010101000000000000000101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000010101010100000000000000010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000010000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000001010000000000000000000001010101010101000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000101000000000000000000000000000000000001010000000000000001010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000101000000000001010100000000000000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000001010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000001010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144
00 41414144

