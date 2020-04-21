function GitUpdater(event, ...)
  GitUpdate = GitUpdate or {}
  GitUpdate.repo = "https://github.com/tdk1069/EleUI2/releases/latest/download/"
  GitUpdate.versionFile = "version.txt"
  GitUpdate.packageFile = "EleUI2.mpackage"
  GitUpdate.downloadDoneID = registerAnonymousEventHandler("sysDownloadDone", "GitUpdater")
  GitUpdate.downloadErrorID = registerAnonymousEventHandler("sysDownloadError", "GitUpdater")
  GitUpdate.uninstallPackageID = registerAnonymousEventHandler("sysUninstallPackage", "GitUpdater")
  GitUpdate.localPath = getMudletHomeDir().."/settings/"

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
      print("Online Version: "..verNum)
      print("Installed Version: "..thisVerNum)
      
      if verNum > thisVerNum then
        print("Update Available ("..versiontxt..").. Downloading")
        if gmcp.Char.Status.name == "Brax" then
          print("Blocking Update on dev profile!")
          return
        else
          downloadFile(GitUpdate.localPath..GitUpdate.packageFile,GitUpdate.repo..GitUpdate.packageFile)
        end
      else
        print("No update available")
      end
    elseif vFile == "EleUI2.mpackage" then -- end EleUI_version.txt download
      print("Update downloaded - Start uninstall")
      uninstallPackage("EleUI2")
    end 

  elseif event == "sysUninstallPackage" then
    if arg[1] == "EleUI2" then
      print("Uninstalled:"..arg[1])
      
      print(GitUpdate.localPath..GitUpdate.packageFile)
      installPackage(GitUpdate.localPath..GitUpdate.packageFile)
      tempTimer(3, [[ installPackage(GitUpdate.localPath..GitUpdate.packageFile) ]])
    end
  elseif event == "sysDownloadError" then
   print("Download Error:"..arg[1])
  else
    print("Checking for update")
    downloadFile(GitUpdate.localPath..GitUpdate.versionFile,GitUpdate.repo..GitUpdate.versionFile)
  end
end