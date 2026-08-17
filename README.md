# Windows File Copy Scripts with Xcopy and Robocopy

A small collection of interactive Windows Batch scripts for copying files and directory trees with the built-in `Robocopy` and `Xcopy` command-line tools.

The scripts prompt for a source and destination at runtime, so the same file can be reused for different local folders, external drives, and network shares.

## Included scripts

| Script | Tool | Behavior |
| --- | --- | --- |
| `robocopy.bat` | Robocopy | Copies subdirectories from a source directory to a destination with `/S`, excluding empty directories. It then attempts to open the destination in File Explorer. |
| `robocopyDir.bat` | Robocopy | Copies subdirectories with `/S` and displays an estimated completion time with `/ETA`. It selects an executable path according to `PROCESSOR_ARCHITECTURE`. |
| `robocopyFile.bat` | Robocopy | Accepts optional Robocopy arguments at runtime, then runs the copy with `/ETA`. Leaving the options field blank performs a standard directory copy; entering `/S` includes non-empty subdirectories. |
| `xcopyfile.bat` | Xcopy | Runs Xcopy with the combined `/S /F /I /C /Y` switches: copy non-empty subdirectories, display full paths, assume a directory destination, continue after errors, and overwrite without prompting. |

## Requirements

- Windows with Command Prompt (`cmd.exe`);
- `Robocopy` and `Xcopy`, normally included with supported Windows installations;
- read permission for the source;
- write permission for the destination;
- sufficient free space at the destination.

No third-party software is required.

## Usage

1. Double-click the desired `.bat` file, or run it from Command Prompt.
2. Enter the full source path when prompted.
3. Enter the full destination path when prompted.
4. If `robocopyFile.bat` asks for an option, either:
   - leave the field blank for the default Robocopy behavior; or
   - enter `/S` to include non-empty subdirectories.
5. Review the command output to confirm whether the operation completed successfully.

Example paths:

```text
Source:      C:\Users\YourName\Documents
Destination: E:\Backups\Documents
```

UNC network paths may also be used when the current account has access:

```text
Source:      \\SERVER\Shared\Project
Destination: D:\Backups\Project
```

## Switches used by the scripts

### Robocopy

| Switch | Meaning |
| --- | --- |
| `/S` | Copies subdirectories but excludes empty directories. |
| `/ETA` | Displays the estimated completion time for copied files. |

### Xcopy

The string `/SFICY` combines the following switches:

| Switch | Meaning |
| --- | --- |
| `/S` | Copies directories and non-empty subdirectories. |
| `/F` | Displays full source and destination filenames. |
| `/I` | Assumes the destination is a directory when its type is ambiguous. |
| `/C` | Continues copying even if errors occur. |
| `/Y` | Suppresses confirmation before overwriting an existing destination file. |

## Important safety notes

- Verify both paths before continuing. A wrong destination may overwrite existing files.
- `xcopyfile.bat` uses `/Y`, so it can overwrite destination files without asking for confirmation.
- The Robocopy scripts do not use `/MIR`, `/PURGE`, `/MOVE`, or `/MOV`, so they are not intended to delete source files or remove extra destination files.
- These scripts are copy helpers, not a complete backup system. They do not provide versioning, encryption, integrity manifests, retention policies, or automated restore testing.
- Test with disposable sample folders before using the scripts on important data.
- Use only trusted paths and options. Values entered through `set /P` are expanded by `cmd.exe`; shell metacharacters such as `&`, `|`, `<`, `>`, and `^` can cause unexpected command behavior.

## Known limitations

- The scripts target Windows Command Prompt and are not designed for PowerShell, Linux, or macOS.
- They print `Finished` without evaluating the copy command's exit code. Always inspect the Robocopy or Xcopy summary for errors.
- `robocopy.bat` directly calls `%SystemRoot%\SysWOW64\Robocopy.exe`; this path may not be available in every Windows environment.
- `robocopyDir.bat` and `robocopyFile.bat` use the `SysWOW64` executable on AMD64 systems and the `System32` executable otherwise. This is unusual and may behave differently under 32-bit process redirection.
- `robocopy.bat` opens the destination with an unquoted Explorer command, so destinations containing spaces may not open correctly even when the copy itself succeeds.
- `robocopyFile.bat` accepts arbitrary text as additional Robocopy arguments and does not validate it.
- The scripts do not include a `pause` command after the final message. A window opened by double-clicking may close immediately after completion.
- `xcopyfile.bat` contains a non-printing control character in a commented example line. The active Xcopy command is unaffected, but some editors may identify the file as binary data.

## Robocopy exit codes

Robocopy uses a bitmask-style exit code. Values below `8` can describe successful copies or non-fatal differences; values of `8` or higher indicate at least one copy failure. These scripts do not currently interpret or preserve that result for the user.

For a manual check immediately after running Robocopy in the same Command Prompt session, use:

```bat
echo %ERRORLEVEL%
```

## Troubleshooting

### Access denied

Confirm that the current Windows account can read the source and write to the destination. Protected system locations may require an elevated Command Prompt.

### The destination path cannot be found

Check drive letters, network connectivity, share names, and permissions. For network locations, use a complete UNC path such as `\\SERVER\Share\Folder`.

### Empty directories are missing

All active recursive commands use `/S`, which excludes empty directories. Robocopy can include them with `/E`, but that option is not enabled in the supplied scripts.

### The window closes before the result can be read

Open Command Prompt first, change to the directory containing the scripts, and run the selected file from that existing terminal window.

```bat
cd /d C:\Path\To\The\Scripts
robocopyDir.bat
```

## Contributing

Issues and pull requests are welcome. When reporting a problem, include:

- the script name;
- the Windows version and architecture;
- sanitized source and destination path examples;
- the complete Robocopy or Xcopy summary;
- the observed exit code.

Do not include credentials, private network names, or confidential filenames in public reports.

## License

The scripts and documentation in this repository are released under the MIT License. See [LICENSE.md](LICENSE.md).

`Robocopy`, `Xcopy`, Windows, and related components are Microsoft products and are not included in this repository. Their use remains subject to the applicable Microsoft terms.
