local DMW = DMW
local Hunter = DMW.Rotations.HUNTER
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Pet, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy20Y, Enemy20YC, Enemy30Y, Enemy30YC
local ShotTime = GetTime()

local function Locals()
    Player = DMW.Player
    Buff = Player.Buffs
    Debuff = Player.Debuffs
    Health = Player.Health
	Pet = DMW.Player.Pet
    HP = Player.HP
    Power = Player.PowerPct
    Spell = Player.Spells
    Talent = Player.Talents
    Trait = Player.Traits
    Item = Player.Items
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs()
	GCD = Player:GCD()
	Enemy40Y, Enemy40YC = Player:GetEnemies(40)
	Enemy20Y, Enemy20YC = Player:GetEnemies(20)
    Enemy30Y, Enemy30YC = Player:GetEnemies(30)
    Player40Y, Player40YC = Player:GetEnemies(40)
 end
 
 local function Auto()
 
	if  not IsAutoRepeatSpell(Spell.AutoShot.SpellName) and (DMW.Time - ShotTime) > 0.5 and Target.Distance > 8 and Spell.AutoShot:Cast(Target) then
	StartAttack()
	ShotTime = DMW.Time
	return true
		end
  end

local function Defensive()
 --Aspect of the Monkey
	 if  Setting ("Aspect Of The Monkey") and Player.Combat  and Player.HP < Setting("Aspect of the Monkey HP") and Player.PowerPct > 20  and Target.Distance < 5 and not Buff.AspectOfTheMonkey:Exist(Player)  and Spell.AspectOfTheMonkey:Cast(Player) then
		return true 
	end
end

local function Utility()

-- Pet management
	if Setting("Call Pet") and (not Pet or Pet.Dead) and Spell.CallPet:Cast(Player) then
            return true 
	end

--Mend Pet
	if Setting("Mend Pet") and Player.Combat and not Player.Moving and Pet and not Pet.Dead and Pet.HP < Setting("Mend Pet HP") and Player.PowerPct > 30 and Spell.MendPet:Cast(Pet) then
        return true
    end
	-- Revive Pet	find a way to check if we dont have active pet or dismissed it .
	--if Setting("Revive Pet") and (Pet.Dead) and Spell.RevivePet:Cast(Player) then
    --     return true 
	--end
-- Aspect of the Cheetah
	if Setting("Aspect Of The Cheetah") and not Player.Combat and Player.CombatLeftTime > 8 and not Spell.AspectOfTheHawk:LastCast() and Player.Moving and not Buff.AspectOfTheCheetah:Exist(Player) and Spell.AspectOfTheCheetah:Cast(Player) then
		return true
	end	
 end


function Hunter.Rotation()
    Locals()
	if Utility() then
		return true 
	end
    if Target and Target.ValidEnemy and Target.Distance < 35 then
	if Defensive() then
        return true
	end

 -- Aspect of the Hawk
		if Setting("Aspect of the Hawk") and Target.Facing and Target.Distance > 8 and (not Buff.AspectOfTheHawk:Exist(Player) or Buff.AspectOfTheMonkey:Exist(Player)) and Player.PowerPct > 30 and Spell.AspectOfTheHawk:Cast(Player) then
			return true
		end	 
	
-- Hunter's Mark
        if Target.Facing and Target.Distance > 8 and Target.TTD > 2 and not Debuff.HuntersMark:Exist(Target) and not (Target.CreatureType == "Totem")  and Spell.HuntersMark:Cast(Target) then
                return true
            end
   		
-- Pet Auto		
        if Setting("Auto Pet Attack") and Pet and not Pet.Dead and not UnitIsUnit(Target.Pointer, "pettarget") then
            PetAttack()
        end
		
-- Auto Shot		
		if  Target.Facing  then 
			Auto() 
--	return true
		end			

-- Serpent Sting
		if Target.Facing and  Target.Distance > 8  and Target.TTD > 5 and not (Target.CreatureType == "Mechanical" or Target.CreatureType == "Elemental" or CreatureType == "Totem") and not Debuff.SerpentSting:Exist(Target) and Spell.SerpentSting:Cast(Target) then
                return true
            end

--Concussive Shot  ( fix if mob targets you  or pet lost threat)
		if Target.Facing and  Target.Distance > 8 and (Target.HP < 30 and  Target.CreatureType == "Humanoid" or Target.Player ) and Spell.ConcussiveShot:Cast(Target) then
		return true
		end	
--Arcane Shot	
		if Target.Facing and  Target.Distance > 8 and Player.PowerPct > 40 and Target.TTD > 4  and not (Target.CreatureType == "Totem") and Spell.ArcaneShot:Cast(Target) then
                return true
            end
-- melee
		if  Target.Distance < 6 and  Target.Facing  then
		StartAttack()
		end			
--Raport Strike
		if  Target.Facing and  Target.Distance < 5 and  Target.TTD > 2 and Spell.RaptorStrike:Cast(Target) then
			return true	
		end
-- Wing Clip
		if  Target.Facing and  Target.Distance < 5 and not Debuff.WingClip:Exist(Target) and not (Target.CreatureType == "Totem") and Spell.WingClip:Cast(Target) then
			return true	
		end	
--Mongoose Bite		
		if Target.Facing and  Target.Distance < 5  and Spell.MongooseBite:IsReady() and Spell.MongooseBite:Cast(Target) then
			return true	
		end	

	
	
	end
end	