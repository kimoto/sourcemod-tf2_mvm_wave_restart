#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define PLUGIN_VERSION "1.0.0"
#define UNDEFINED_VALUE -1

public Plugin:myinfo =  
{
  name = "TF2 MvM Wave Restart",
  author = "kimoto",
  description = "TF2 MvM Wave Restart",
  version = PLUGIN_VERSION,
  url = "http://kymt.me/"
};

new oldFlags = -1;

public OnPluginStart()
{
  RegServerCmd("sm_tf2_mvm_wave_restart", Command_MvMWaveRestart);
  RegServerCmd("sm_tf2_mvm_jump_to_next_wave", Command_MvMJumpToNextWave);
  RegServerCmd("sm_wave_restart", Command_MvMWaveRestart); // Alias
}

public OnPluginEnd()
{
}

public JumpToWave(wave_number)
{
  oldFlags = GetCommandFlags("tf_mvm_jump_to_wave");
  SetCommandFlags("tf_mvm_jump_to_wave", oldFlags & ~FCVAR_CHEAT);
  ServerCommand("tf_mvm_jump_to_wave %d", wave_number);
  ServerExecute();
  CreateTimer(0.25, Timer_ResetFlag, INVALID_HANDLE, 0);
}

public Action:Command_MvMWaveRestart(args)
{
  new ent = FindEntityByClassname(-1, "tf_objective_resource");
  if(ent == -1){
    LogMessage("tf_objective_resource not found");
  }
  JumpToWave(GetEntData(ent, FindSendPropInfo("CTFObjectiveResource", "m_nMannVsMachineWaveCount")));
}

public Action:Command_MvMJumpToNextWave(args)
{
  new ent = FindEntityByClassname(-1, "tf_objective_resource");
  if(ent == -1){
    LogMessage("tf_objective_resource not found");
  }
  new current_wave = GetEntData(ent, FindSendPropInfo("CTFObjectiveResource", "m_nMannVsMachineWaveCount"));
  new max_wave = GetEntData(ent, FindSendPropInfo("CTFObjectiveResource", "m_nMannVsMachineMaxWaveCount"));

  new next_wave = current_wave + 1;
  if(next_wave > max_wave)
    next_wave = max_wave;

  JumpToWave(next_wave);
}

public Action:Timer_ResetFlag(Handle:timer, any:data)
{
  SetCommandFlags("tf_mvm_jump_to_wave", oldFlags);
}

