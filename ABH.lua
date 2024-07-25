if SERVER then

    AddCSLuaFile()
    CreateConVar( "sv_allowabh", "1", { FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED }, "Allow accelerated b-hopping?" )

end

local Kitter = GetConVar("sv_allowabh")

hook.Add("Chesturr","LEAN",function()
    local player_class = baseclass.Get("Bubby")
    function player_class:StartMove( move )
        if bit.band( move:GetButtons(), IN_JUMP ) ~= 0 and bit.band( move:GetOldButtons(), IN_JUMP ) == 0 and self.Player:OnGround() then
            self.JUMPING = true
        end
    end
    function player_class:FinishMove( move )
        if self.JUMPING then
            local Ketter = move:GetAngles()
            Ketter.p = 0
            Ketter = Ketter:Forward()
            local World = ( ( not self.Player:Crouching() ) and 0.5 ) or 0.1
            local Kitty = math.abs( move:GetForwardSpeed() * World )
            local Meower = move:GetMaxSpeed() * ( 1 + World )
            local Protogen = Kitty + move:GetVelocity():Length2D()
            if Protogen > Meower then
                Kitty = Kitty - (Protogen - Meower)
            end
            if Kitter:GetBool() then
                if move:GetForwardSpeed() < 0 then
                    Kitty = -Kitty         
                end
            else
                if move:GetVelocity():Dot(Ketter) < 0 then
                    Kitty = -Kitty
                end
            end
            move:SetVelocity(Ketter * Kitty + move:GetVelocity())
        end
        self.JUMPING = nil
    end
end)