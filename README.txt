TF2 MvM Wave Manager (restart / jump to next wave) SourceMOD Plugin

Command
  sm_tf2_mvm_wave_restart 
    Current wave restart

  sm_tf2_mvm_jump_to_next_wave
    Jump to next wave

SYNOPSYS
  Recommend use this plugin with Custom Vote plugin.
  http://forums.alliedmods.net/showthread.php?p=633808

  Example My ./addons/sourcemod/configs/customvotes/core.vote.cfg

    "Votes"
    {
      "wave_restart"
      {
        "title"         "Restart wave"
        "type"          "confirm"
        "command"       "sm_tf2_mvm_wave_restart"
        "trigger"
        {
          "command" "!wave_restart" // alternate chat trigger
          "percent" "100"
        }
      }

      "next_wave"
      {
        "title"         "Jump to next wave"
        "type"          "confirm"
        "command"       "sm_tf2_mvm_jump_to_next_wave"
        "trigger"
        {
          "command" "!next_wave"    // alternate chat trigger
          "percent" "100"
        }
      }
    }

