#include <sdkhooks>
#include <tf2_stocks>
#include <tf2attributes>

public Plugin myinfo = 
{
	name = "Total Mayhem",
	author = "myst",
	description = "Gives the game more action by increasing move speed, reload and fire rate, clip size.",
	version = "1.0",
	url = "https://titan.tf"
}

public void OnPluginStart()
{
	HookEvent("player_spawn", Event_PlayerSpawn);
}

public Action Event_PlayerSpawn(Handle hEvent, const char[] sName, bool bDontBroadcast)
{
	int iClient = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	
	float flHealth; float flSpeed; float flTargetSpeed;
	
	switch (TF2_GetPlayerClass(iClient))
	{
		case TFClass_Scout:  	flHealth = 150.0 - 125.0, flSpeed = 400.0, flTargetSpeed = 450.0;
		case TFClass_Soldier:	flHealth = 1.0, 		  flSpeed = 240.0, flTargetSpeed = 290.0;
		case TFClass_Pyro:		flHealth = 250.0 - 175.0, flSpeed = 300.0, flTargetSpeed = 350.0;
		case TFClass_DemoMan:	flHealth = 200.0 - 175.0, flSpeed = 280.0, flTargetSpeed = 330.0;
		case TFClass_Heavy:		flHealth = 500.0 - 300.0, flSpeed = 230.0, flTargetSpeed = 280.0;
		case TFClass_Engineer:	flHealth = 200.0 - 125.0, flSpeed = 300.0, flTargetSpeed = 350.0;
		case TFClass_Medic:		flHealth = 200.0 - 150.0, flSpeed = 320.0, flTargetSpeed = 370.0;
		case TFClass_Sniper:	flHealth = 200.0 - 125.0, flSpeed = 300.0, flTargetSpeed = 350.0;
		case TFClass_Spy:		flHealth = 200.0 - 125.0, flSpeed = 320.0, flTargetSpeed = 370.0;
	}
	
	TF2Attrib_SetByName(iClient, "move speed bonus", flTargetSpeed/flSpeed);
	TF2Attrib_RemoveByName(iClient, "max health additive bonus");
	TF2Attrib_SetByName(iClient, "max health additive bonus", flHealth);
	
	for (int iSlot = 0; iSlot < 5; iSlot++)
	{ 
		int iWeapon = GetPlayerWeaponSlot(iClient, iSlot);
		
		if (IsValidEntity(iWeapon))
		{
			TF2Attrib_SetByName(iWeapon, "clip size bonus", 2.0);
			TF2Attrib_SetByName(iWeapon, "faster reload rate", 0.5);
			TF2Attrib_SetByName(iWeapon, "fire rate bonus", 0.75);
			TF2Attrib_SetByName(iWeapon, "ammo regen", 1.0);
			TF2Attrib_SetByName(iWeapon, "mod see enemy health", 1.0);
		}
	}
	
	TF2_RegeneratePlayer(iClient);
}