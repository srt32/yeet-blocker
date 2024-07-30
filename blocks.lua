-- blocks.lua

core.register_action("process_response", { "http-res" }, function(txn)
  txn.http:res_add_header("X-Custom-Header", "Processed by Lua")

  local headers = txn.http:res_get_headers()

  -- TODO: Add error handling for missing header
  local backend_directive = headers["x-github-edge-resource"][0]

  -- check if backend_directive is not nil
  if backend_directive then
    core.log(core.info, "X-GitHub-Edge-Resource: " .. backend_directive)
    -- split the string on dash
    local parts = {}
    for part in string.gmatch(backend_directive, "([^%-]+)") do
        table.insert(parts, part)
    end

    -- format is (logged in state)-(code to return)
    -- check if first part is set to false
    if parts[1] == "false" then
        txn.http:res_add_header("X-Blocked-By-Glb", "true")

        core.log(core.info, "adding blocked path: " .. txn:get_var("txn.ghpath"))
        core.set_map("/etc/haproxy/path_status.map", txn:get_var("txn.ghpath"), 404)
    end
  else
    core.log(core.info, "X-GitHub-Edge-Resource: none-provided")
  end
end)