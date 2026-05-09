local state = {}

local function refresh_lualine()
  local ok, lualine = pcall(require, "lualine")
  if ok then
    lualine.refresh()
  end
end

local function setup_autocmds()
  local group = vim.api.nvim_create_augroup("TermStatus", { clear = true })

  vim.api.nvim_create_autocmd("TermRequest", {
    group = group,
    callback = function(args)
      local seq = vim.v.termrequest or ""
      local buf = args.buf
      if seq:match("^\27%]133;C") then
        state[buf] = "running"
        refresh_lualine()
      elseif seq:match("^\27%]133;D") then
        local code = tonumber(seq:match("D;(%-?%d+)")) or 0
        state[buf] = code ~= 0 and "exited" or "idle"
        if code ~= 0 then
          local name = vim.api.nvim_buf_get_name(buf)
          vim.notify(("终端异常退出 (code=%d): %s"):format(code, name), vim.log.levels.ERROR)
        end
        refresh_lualine()
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWipeout", "TermClose" }, {
    group = group,
    callback = function(args)
      if state[args.buf] ~= nil then
        state[args.buf] = nil
        refresh_lualine()
      end
    end,
  })
end

local function component()
  local bufs = {}
  for buf, _ in pairs(state) do
    if vim.api.nvim_buf_is_valid(buf) then
      table.insert(bufs, buf)
    end
  end
  table.sort(bufs)

  local parts = {}
  for _, buf in ipairs(bufs) do
    local s = state[buf]
    if s == "running" then
      table.insert(parts, "%#DiagnosticOk#●%*")
    elseif s == "exited" then
      table.insert(parts, "%#DiagnosticError#●%*")
    end
  end

  if #parts == 0 then
    return ""
  end
  return ">_" .. table.concat(parts, " ")
end

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      setup_autocmds()
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, component)
    end,
  },
}
