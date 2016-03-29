cooldown = 20
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
left_enemy_x = 30
right_enemy_x = 800
enemy_side = false --false equal left

function love.load()
	love.keyboard.setKeyRepeat(false)
	player = {}
	player.left = false
	player.right = false
	player.left_x = 300
	player.cooldown = cooldown
	player.keydown = function()
		if player.cooldown <= 0 then
			player.left = false
			player.right = false
		end
	end
	for i = 0, 10 do
		enemies_controller:spawnEnemy(30)		
		--enemies_controller:spawnEnemy(800)
	end
end

function checkCollisions(enemies)
	for i, e in ipairs(enemies) do
		if player.left then
			if player.left_x <= e.y + e.height and player.left_x > e.x and player.left_x < e.x + e.width then
				table.remove(enemies, i)
			end
		end			
	end
end

function enemies_controller:spawnEnemy(x)
	enemy = {}
	enemy.x = x
	enemy.y = 450
	enemy.width = 50
  	enemy.height = 100
  	enemy.speed = 2
	table.insert(self.enemies, enemy)
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

	for _,e in pairs(enemies_controller.enemies) do
	    if e.x >= love.graphics.getHeight() then
	    	print('fim')
	    end

	    if not enemy_side then
	    	e.x = e.x + 1 * e.speed
	    else
	    	e.x = e.x - 1 * e.speed
	    end
	    
  	end
  	checkCollisions(enemies_controller.enemies, player.left)
end

function love.draw()
	if player.left then
		player.right = false
		love.graphics.rectangle("fill", player.left_x, 400, 50, 100, 10, 10)		
	end
	
	if player.right then
		player.left = false
		love.graphics.rectangle("fill", 450, 400, 50, 100, 10, 10)
	end

	for _, e in pairs(enemies_controller.enemies) do
		love.graphics.circle("fill", e.x, e.y, e.width, e.height)
	end
	

end