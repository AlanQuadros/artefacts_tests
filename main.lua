HC = require 'HC'

cooldown = 20
enemy = {}
enemies_controller = {}
enemies_controller.enemies_left = {}
enemies_controller.enemies_right = {}

function love.load()
	love.keyboard.setKeyRepeat(false)
	player = {}
	player.left = false
	player.right = false
	player.left_x = 300
	player.right_x = 450
	player.cooldown = cooldown
	player.keydown = function()
		if player.cooldown <= 0 then
			player.left = false
			player.right = false
		end
	end
	--for i = 0, 10 do
	enemies_controller:spawnEnemyLeft()
	enemies_controller:spawnEnemyRight()
	--end

	
end

function checkCollisionsLeft(enemies_left)
	for i, e in ipairs(enemies_left) do
		if player.left then
			if player.left_x > e.x and player.left_x < e.x + e.width then
				table.remove(enemies_left, i)
			end
		end			
	end
end

function checkCollisionsRight(enemies_right)
	for i, e in ipairs(enemies_right) do
		if player.right then
			if player.right_x > e.x and player.right_x < e.x + e.width then
				table.remove(enemies_right, i)
			end
		end			
	end
end

function enemies_controller:spawnEnemyLeft()
	enemy = {}
	enemy.x = 30
	enemy.y = 450
	enemy.width = 50
  	enemy.height = 100
  	enemy.speed = 2
	table.insert(self.enemies_left, enemy)
end

function enemies_controller:spawnEnemyRight()
	enemy = {}
	enemy.x = 800
	enemy.y = 450
	enemy.width = 50
  	enemy.height = 100
  	enemy.speed = 2
	table.insert(self.enemies_right, enemy)
end

function love.keyreleased(key)
	if key == "escape" then
      love.event.quit()
    end

	if key == "a" then
		player.left = false
	elseif key == 'd' then
		player.right = false
	end
	player.cooldown = cooldown
end

function love.update(dt)
	player.cooldown = player.cooldown - 1
	if love.keyboard.isDown("a") then
		player.left = true
		player.right = false
		player.keydown()
	end

	if love.keyboard.isDown("d") then
		player.right = true
		player.left = false
		player.keydown()
	end

	for _,e in pairs(enemies_controller.enemies_left) do
	    if e.x >= love.graphics.getHeight() then
	    	--print('fim')
	    end
		e.x = e.x + 1 * e.speed    
  	end

  	for _,e in pairs(enemies_controller.enemies_right) do
	    if e.x >= love.graphics.getHeight() then
	    	--print('fim')
	    end
	    e.x = e.x - 1 * e.speed	    
  	end

  	checkCollisionsLeft(enemies_controller.enemies_left, player.left)
  	checkCollisionsRight(enemies_controller.enemies_right, player.rigth)
end

function love.draw()
	if player.left then
		player.right = false
		love.graphics.rectangle("fill", player.left_x, 400, 10, 100, 10, 10)		
	end
	
	if player.right then
		player.left = false
		love.graphics.rectangle("fill", player.right_x, 400, 10, 100, 10, 10)
	end

	for _, e in pairs(enemies_controller.enemies_left) do
		love.graphics.circle("fill", e.x, e.y, e.width, e.height)
	end
	
	for _, e in pairs(enemies_controller.enemies_right) do
		love.graphics.circle("fill", e.x, e.y, e.width, e.height)
	end

end