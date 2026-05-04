index cacc5b7..9e09430 100644
--- a/init.lua
+++ b/init.lua
@@ -255,6 +255,14 @@ rtp:prepend(lazypath)
 --
 -- NOTE: Here is where you install your plugins.
 require('lazy').setup({
+  {
+    'nvim-java/nvim-java',
+    config = function()
+      require('java').setup()
+      vim.lsp.enable 'jdtls'
+    end,
+  },
+
   -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
   { 'NMAC427/guess-indent.nvim', opts = {} },
 
@@ -601,7 +609,7 @@ require('lazy').setup({
       ---@type table<string, vim.lsp.Config>
       local servers = {
         -- clangd = {},
-        -- gopls = {},
+        gopls = {},
         -- pyright = {},
         -- rust_analyzer = {},
         --
@@ -653,6 +661,7 @@ require('lazy').setup({
       local ensure_installed = vim.tbl_keys(servers or {})
       vim.list_extend(ensure_installed, {
         -- You can add other tools here that you want Mason to install
+        'gopls',
       })
 
       require('mason-tool-installer').setup { ensure_installed = ensure_installed }
@@ -970,3 +979,7 @@ require('lazy').setup({
 
 -- The line beneath this is called `modeline`. See `:help modeline`
 -- vim: ts=2 sts=2 sw=2 et
+vim.api.nvim_create_autocmd('BufWritePre', {
+  pattern = '*.go',
+  callback = function() vim.lsp.buf.format() end,
+}