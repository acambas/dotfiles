return {
  "terje/simctl.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("simctl").setup({
      notify = true,                -- enable error notifications
      devicePicker = true,          -- show the device picker if no deviceId is supplied
      appPicker = true,             -- show the app picker if no appId is supplied
      privacyServicePicker = true,  -- show the privacy service picker if no service is supplied
      defaultToBootedDevice = true, -- default to booted device if no deviceId is supplied
      openSimulatorApp = true,      -- open Simulator.app when booting a device, otherwise the device will run headless
    })

    local function myCustomFunction(opts)
      local simctlArgs = { deviceId = "booted" }
      local simctl = require("simctl.api")
      if opts.args == "boot" then
        simctl.boot()
      elseif opts.args == "restart" then
        simctl.terminate({ deviceId = "booted", appId = "net.klarna.app.dev" }, function()
          simctl.launch({ deviceId = "booted", appId = "net.klarna.app.dev" })
        end)
      elseif opts.args == "terminate" then
        simctl.terminate(simctlArgs)
      elseif opts.args == "shutdown" then
        simctl.shutdown(simctlArgs)
      elseif opts.args == "launch" then
        simctl.launch(simctlArgs)
      elseif opts.args == "erase" then
        simctl.erase(simctlArgs)
      elseif opts.args == "toggle_appearance" then
        simctl.ui.toggleAppearance(simctlArgs)
      else
        print("Unknown task: " .. opts.args)
      end
    end

    -- Define a custom completion function
    -- This function should return a list of completions based on the current word being completed
    local function myCompletionFunction(argLead, cmdline, cursorPos)
      -- argLead: the leading portion of the argument currently being completed on
      -- cmdline: the entire command line
      -- cursorPos: the cursor position in the command line (byte index)

      local completions = { "boot", "launch", "terminate", "erase", "toggle_appearance", "shutdown", "restart" }
      -- Filter completions based on argLead
      local matches = {}
      for _, completion in ipairs(completions) do
        if completion:find("^" .. argLead) then
          table.insert(matches, completion)
        end
      end
      return matches
    end

    -- Create a new user command named MyCommand with custom completion
    vim.api.nvim_create_user_command('Simulator', myCustomFunction, {
      nargs = 1,
      complete = myCompletionFunction
    })
  end,
}
