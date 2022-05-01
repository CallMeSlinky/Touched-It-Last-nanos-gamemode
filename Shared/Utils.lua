-- Mostly stolen from Syed's sandbox gamemode. Thanks :pepe:

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end

-- List of Character Meshes
CHARACTER_MESHES = {
	"nanos-world::SK_Male",
	"nanos-world::SK_Female",
	"nanos-world::SK_Mannequin",
	"nanos-world::SK_Mannequin_Female",
	"nanos-world::SK_ClassicMale",
	"nanos-world::SK_PostApocalyptic",
}

-- List of SK_Male hair Static Meshes
SK_MALE_HAIR_MESHES = {
	"",
	"nanos-world::SM_Hair_Long",
	"nanos-world::SM_Hair_Short"
}

-- List of SK_Male beard Static Meshes
SK_MALE_BEARD_MESHES = {
	"",
	"nanos-world::SM_Beard_Extra",
	"nanos-world::SM_Beard_Middle",
	"nanos-world::SM_Beard_Mustache_01",
	"nanos-world::SM_Beard_Mustache_02",
	"nanos-world::SM_Beard_Side"
}

-- List of SK_Female hair Static Meshes
SK_FEMALE_HAIR_MESHES = {
	"",
	"nanos-world::SM_Hair_Kwang"
}

-- List of Death Male voices
MALE_DEATH_SOUNDS = {
	"nanos-world::A_Male_01_Death",
	"nanos-world::A_Male_02_Death",
	"nanos-world::A_Male_03_Death",
	"nanos-world::A_Male_04_Death",
	"nanos-world::A_Male_05_Death",
	"nanos-world::A_Male_06_Death",
	"nanos-world::A_Wilhelm_Scream"
}

-- List of Pain Male voices
MALE_PAIN_SOUNDS = {
	"nanos-world::A_Male_01_Pain",
	"nanos-world::A_Male_02_Pain",
	"nanos-world::A_Male_03_Pain",
	"nanos-world::A_Male_04_Pain",
	"nanos-world::A_Male_05_Pain",
	"nanos-world::A_Male_06_Pain",
	"nanos-world::A_Male_07_Pain",
	"nanos-world::A_Male_06_Pain"
}

-- List of Death Female voices
FEMALE_DEATH_SOUNDS = {
	"nanos-world::A_Female_01_Death",
	"nanos-world::A_Female_02_Death",
	"nanos-world::A_Female_03_Death",
	"nanos-world::A_Female_04_Death",
	"nanos-world::A_Female_05_Death"
}

-- List of Pain Female voices
FEMALE_PAIN_SOUNDS = {
	"nanos-world::A_Female_01_Pain",
	"nanos-world::A_Female_02_Pain",
	"nanos-world::A_Female_03_Pain",
	"nanos-world::A_Female_04_Pain",
	"nanos-world::A_Female_05_Pain",
	"nanos-world::A_Female_06_Pain",
	"nanos-world::A_Female_07_Pain",
	"nanos-world::A_Female_06_Pain"
}

-- List of Male/Female Meshes Morph Targets
HUMAN_MORPH_TARGETS = {
	"nose1",
	"nose2",
	"brows",
	"mouth",
	"fat",
	"nose3",
	"chin",
	"face",
	"nose4",
	"skinny",
	"jaw",
	"brows2",
	"angry",
	"smirk",
	"smirk2",
	"smirk3",
	"smile",
	"nose6",
	"jaw_forward",
	"lips",
	"lips2",
	"mouth_wide",
	"eyes1",
	"eyes2",
	"eyes3",
	"eyes4",
	"eyes_retraction",
	"lips3",
	"eyes5",
	"nose7",
	"forehead",
	"bodyfat",
}

HUMAN_SKIN_TONES = {
	Color(1.000000, 1.000000, 1.000000),
	Color(1.000000, 0.926933, 0.820785),
	Color(0.984375, 0.854302, 0.661377),
	Color(1.000000, 0.866979, 0.785255),
	Color(0.890625, 0.768996, 0.658135),
	Color(0.880208, 0.706081, 0.588818),
	Color(0.526042, 0.340051, 0.221689),
	Color(0.244792, 0.185846, 0.151720),
	Color(0.791667, 0.573959, 0.428820),
	Color(0.947917, 0.655642, 0.399902),
	Color(0.583333, 0.406594, 0.261284),
	Color(0.645833, 0.465268, 0.360730),
	Color(1.000000, 0.917535, 0.739583),
	Color(0.932292, 0.825388, 0.670085),
	Color(0.817708, 0.710384, 0.549398),
	Color(0.765625, 0.620475, 0.454590),
	Color(0.050000, 0.050000, 0.080000),
}

HAIR_TINTS = {
	Color(0.067708, 0.030797, 0.001471),
	Color(0.983483, 1.000000, 0.166667),
	Color(0.010000, 0.010000, 0.010000),
	Color(1.000000, 0.129006, 0.000000),
}

function GetRandomSpawnPoint()
  -- List of Spawn Locations
  SPAWN_POINTS = Server.GetMapSpawnPoints()

	return #SPAWN_POINTS > 0 and SPAWN_POINTS[math.random(#SPAWN_POINTS)] or { location = Vector(), rotation = Rotator() }
end

function SpawnCharacterRandomized(location, rotation, asset)
	local selected_mesh = asset or CHARACTER_MESHES[math.random(#CHARACTER_MESHES)]
	local spawn_point = GetRandomSpawnPoint()
	local new_char = Character(location or spawn_point.location, rotation or spawn_point.rotation, selected_mesh)

	-- Customization
	if (selected_mesh == "nanos-world::SK_Male") then
		local selected_hair = SK_MALE_HAIR_MESHES[math.random(#SK_MALE_HAIR_MESHES)]
		if (selected_hair ~= "") then
			new_char:AddStaticMeshAttached("hair", selected_hair, "hair_male")
		end

		local selected_beard = SK_MALE_BEARD_MESHES[math.random(#SK_MALE_BEARD_MESHES)]
		if (selected_beard ~= "") then
			new_char:AddStaticMeshAttached("beard", selected_beard, "beard")
		end
	end

	if (selected_mesh == "nanos-world::SK_Male" or selected_mesh == "nanos-world::SK_Mannequin") then
		local selected_death_Sound = MALE_DEATH_SOUNDS[math.random(#MALE_DEATH_SOUNDS)]
		new_char:SetDeathSound(selected_death_Sound)

		local selected_pain_Sound = MALE_PAIN_SOUNDS[math.random(#MALE_PAIN_SOUNDS)]
		new_char:SetPainSound(selected_pain_Sound)
	end

	if (selected_mesh == "nanos-world::SK_Female" or selected_mesh == "nanos-world::SK_Mannequin_Female") then
		local selected_death_Sound = FEMALE_DEATH_SOUNDS[math.random(#FEMALE_DEATH_SOUNDS)]
		new_char:SetDeathSound(selected_death_Sound)

		local selected_pain_Sound = FEMALE_PAIN_SOUNDS[math.random(#FEMALE_PAIN_SOUNDS)]
		new_char:SetPainSound(selected_pain_Sound)
	end

	if (selected_mesh == "nanos-world::SK_Female") then
		local selected_hair = SK_FEMALE_HAIR_MESHES[math.random(#SK_FEMALE_HAIR_MESHES)]
		if (selected_hair ~= "") then
			new_char:AddStaticMeshAttached("hair", selected_hair, "hair_female")
		end

		-- Those parameters are specific to female mesh
		new_char:SetMaterialColorParameter("BlushTint", Color(0.52, 0.12, 0.15))
		new_char:SetMaterialColorParameter("EyeShadowTint", Color(0.24, 0.05, 0.07))
		new_char:SetMaterialColorParameter("LipstickTint", Color(0.31, 0.03, 0.1))
	end

	-- Adds eyes to humanoid meshes
	if (selected_mesh == "nanos-world::SK_Male" or selected_mesh == "nanos-world::SK_Female") then
		new_char:AddStaticMeshAttached("eye_left", "nanos-world::SM_Eye", "eye_left")
		new_char:AddStaticMeshAttached("eye_right", "nanos-world::SM_Eye", "eye_right")

		-- Those parameters are specific to humanoid meshes (were added in their materials)
		new_char:SetMaterialColorParameter("HairTint", HAIR_TINTS[math.random(#HAIR_TINTS)])
		new_char:SetMaterialColorParameter("Tint", HUMAN_SKIN_TONES[math.random(#HUMAN_SKIN_TONES)])

		new_char:SetMaterialScalarParameter("Muscular", math.random(100) / 100)
		new_char:SetMaterialScalarParameter("BaseColorPower", math.random(2) + 0.5)

		for i, morph_target in ipairs(HUMAN_MORPH_TARGETS) do
			new_char:SetMorphTarget(morph_target, math.random(200) / 100 - 1)
		end
	end

	return new_char
end

function SpawnPlayer(player, location, rotation)
	local new_char = SpawnCharacterRandomized(location, rotation)

	player:Possess(new_char)

	-- Sets a callback to automatically respawn the character, 10 seconds after he dies
	new_char:Subscribe("Death", function(chara, last_damage_taken, last_bone_damaged, damage_reason, hit_from, instigator)
		if (instigator) then
			if (instigator == player) then
				Server.BroadcastChatMessage("<cyan>" .. instigator:GetName() .. "</> committed suicide")
			else
				Server.BroadcastChatMessage("<cyan>" .. instigator:GetName() .. "</> killed <cyan>" .. player:GetName() .. "</>")
			end
		else
			Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> died")
		end

		-- Respawns the Character after 5 seconds, we Bind the Timer to the Character, this way if the Character gets destroyed in the meanwhile, this Timer never gets destroyed
		Timer.Bind(
			Timer.SetTimeout(function(character)
				-- If he is not dead anymore after 5 seconds, ignores it
				if (character:GetHealth() ~= 0) then return end

				-- Respawns the Character at a random point
				local spawn_point = GetRandomSpawnPoint()
				character:Respawn(spawn_point.location, spawn_point.rotation)
			end, 5000, chara),
			chara
		)
	end)
end