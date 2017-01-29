try
  set theFiles to (choose file with prompt "Select one or more files to encrypt." default location (path to desktop) with multiple selections allowed )
on error
  return
end try

set thePosixPaths to {}

repeat with currentFile in theFiles
  set thePath to (the POSIX path of currentFile)
  copy thePath to the end of thePosixPaths
end repeat

return thePosixPaths
