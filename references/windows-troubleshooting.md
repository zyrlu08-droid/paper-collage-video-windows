# Windows Troubleshooting

## Node.js is missing

```powershell
Test-Path 'C:\Program Files\nodejs\node.exe'
Get-Command node -ErrorAction SilentlyContinue
```

If the first result is `False`, reinstall Node.js LTS with Add to PATH enabled. Fully restart Codex or PowerShell afterward.

## npm.ps1 is blocked

This is a PowerShell execution-policy issue, not proof that npm is missing. Prefer:

```powershell
npm.cmd --version
npx.cmd --version
```

Recommend changing the user's execution policy only after explaining the impact.

## Edge TTS network errors

```powershell
Test-NetConnection speech.platform.bing.com -Port 443
```

After `TcpTestSucceeded` becomes `True`, run a short voice test. Confirm that the resulting MP3 is larger than zero bytes.

## Remotion browser problems

```powershell
Test-Path 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
Test-Path 'C:\Program Files\Microsoft\Edge\Application\msedge.exe'
```

If bundled Chromium cannot download or launch, configure Remotion to use installed Edge. Reduce rendering concurrency when memory is limited.

## Python command differences

Windows commonly uses `python`, not `python3`. Prefer `python -m pip` and `python -m edge_tts` to target the correct environment.

## The MP4 exists but will not play

Inspect the container and streams with ffprobe. For compatibility, export H.264 video, `yuv420p`, AAC audio, and `faststart`. A `.mp4` extension alone does not prove compatibility.
