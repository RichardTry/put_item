minetest.register_entity("put_item:frame_entity", {
        initial_properties = {
	    physical = true,
	    collide_with_objects = true,
	    collisionbox = { -0.18, 0, -0.18, 0.18, 0.42, 0.18 },
            selectionbox = { -0.18, 0, -0.18, 0.18, 0.42, 0.18 },
	    pointable = true,
	    
            visual = "mesh",
            mesh = "put_item_frame.obj",
	    textures = {"put_item_frame.png",
			"put_item_frame_back.png",
			"put_item_wood.png"
			},
	    
	    
	    --visual = "wielditem",
	    --wield_item = "default:dirt",--"put_item:wine",

	    --visual_size = {x = 0.25, y = 0.25, z = 0.25},
	    visual_size = {x = 10, y = 10, z = 10},
        },

        --on_activate = function(self, staticdata, dtime_s),

        --on_step = function(self, dtime, moveresult),
            -- Called every server step
            -- dtime: Elapsed time
            -- moveresult: Table with collision info (only available if physical=true)

        --on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir),

        --on_rightclick = function(self, clicker),

        --get_staticdata = function(self),
            -- Called sometimes; the string returned is passed to on_activate when
            -- the entity is re-activated from static state

        --_custom_field = whatever,
            -- You can define arbitrary member variables here (see Item definition
            -- for more info) by using a '_' prefix
})

minetest.register_craftitem("put_item:wine", {
    description = "Bottle of Wine",
    inventory_image = "put_item_frame_icon.png",
    themodel = "yeah!",
    on_place = function(itemstack, placer, pointed_thing)
	--minetest.chat_send_all(minetest.registered_items[itemstack:to_string()].themodel)
	local placer_pos = placer:get_pos()
	placer_pos.y = placer_pos.y + placer:get_properties().eye_height
	local raycast = minetest.raycast(placer_pos, vector.add(placer_pos, vector.multiply(placer:get_look_dir(), 20)), false)
	local pointed = raycast:next()
	if pointed and pointed.type == "node" and pointed.intersection_normal.y == 1 then
		local obj =  minetest.add_entity(pointed.intersection_point, "put_item:frame_entity")
		obj:set_yaw(placer:get_look_horizontal())
	end
	itemstack:take_item()
	return itemstack
    end
})
