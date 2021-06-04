function GitUpdater(event, ...)
  GitUpdate = GitUpdate or {}
  GitUpdate.repo = "https://github.com/tdk1069/EleUI2/releases/latest/download/"
  GitUpdate.versionFile = "version.txt"
  GitUpdate.packageFile = "EleUI2.mpackage"
  GitUpdate.downloadDoneID = registerAnonymousEventHandler("sysDownloadDone", "GitUpdater")
  GitUpdate.downloadErrorID = registerAnonymousEventHandler("sysDownloadError", "GitUpdater")
  GitUpdate.uninstallPackageID = registerAnonymousEventHandler("sysUninstallPackage", "GitUpdater")
  GitUpdate.localPath = getMudletHomeDir().."/settings/"
  GitUpdate.checkOnly = GitUpdate.checkOnly or nil
  event = event or {}
  
  if event['check'] == true then
    GitUpdate.checkOnly = true
  end

  if not io.exists(GitUpdate.localPath) then
    lfs.mkdir(GitUpdate.localPath)
  end

  if event == "sysDownloadDone" then
    local downloadFullFile = arg[1]
    local vFile = arg[1]:match(".*%/(.*%..*)$")

    if vFile == "version.txt" then
      local f, error, versiontxt = io.open(downloadFullFile)
      if f then
        versiontxt = f:read("*a");
        io.close(f)
      end
      local verNum = tonumber(versiontxt:match("Version: (.*)"))
      local thisVerNum = tonumber(brax.version:match("Version: (.*)"))
      if not GitUpdate.checkOnly then
        cecho("<cyan>»»<reset>Online Version:<yellow>"..verNum.."\n")
        cecho("<cyan>»»<reset>Installed Version:<yellow>"..thisVerNum.."\n")
      end
      
      if verNum > thisVerNum then
      if not GitUpdate.checkOnly then
        cecho("<cyan>»»<reset>Update Available (<yellow>"..versiontxt.."<reset>).. Downloading\n")
      end
        if gmcp.Char.Status.name == "Brax" then
          cecho("<red>»»<reset>Blocking Update on Dev Profile!<red>««<reset>\n")
          return
        else
          if GitUpdate.checkOnly then
            cecho("<red>»»\n»»<reset>Update Available but not downloaded. run <yellow>ui update<reset> to install\n<red>»»<reset>\n")
            GitUpdate.checkOnly = false
          else
            downloadFile(GitUpdate.localPath..GitUpdate.packageFile,GitUpdate.repo..GitUpdate.packageFile)
          end
        end
      else
        cecho("<cyan>»»<reset>No update available<reset>\n")
        GitUpdate.checkOnly = false
      end
    elseif vFile == "EleUI2.mpackage" then -- end EleUI_version.txt download
      print("Update downloaded - Start uninstall")
      Adjustable.Container.saveAll()
      uninstallPackage("EleUI2")
    end 

  elseif event == "sysUninstallPackage" then
    if arg[1] == "EleUI2" then
      cecho("<cyan>»»<reset>Uninstalled: <yellow>"..arg[1].."\n")
      cecho("<cyan>»»<reset>Waiting to install\n")
      cecho("<cyan>»»"..GitUpdate.localPath..GitUpdate.packageFile.."\n") 

      installPackage(GitUpdate.localPath..GitUpdate.packageFile)
      tempTimer(5, [[ installPackage("]]..GitUpdate.localPath..GitUpdate.packageFile..[[") ]])
      tempTimer(10, [[ installPackage("]]..GitUpdate.localPath..GitUpdate.packageFile..[[") ]])
    end
  elseif event == "sysDownloadError" then
   cecho("<red>»»<reset>Download Error: "..arg[1].."\n")
  else
    if not GitUpdate.checkOnly then
      cecho("<cyan>»»<reset>Checking for update<reset>...\n")
    end
    downloadFile(GitUpdate.localPath..GitUpdate.versionFile,GitUpdate.repo..GitUpdate.versionFile)
  end
end
