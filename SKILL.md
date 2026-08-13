---
name: paper-collage-video-windows
description: Check, troubleshoot, and produce Remotion paper-collage or Vox-style short videos on Windows. Covers Node.js/npm, Python, FFmpeg, Edge TTS Mandarin narration, storyboards, assets, Remotion rendering, audio mixing, and final MP4 validation. Use for environment checks, paper-collage videos, Mandarin voice-over, silent exports, blocked npm.ps1, Edge TTS network errors, Remotion render failures, or unplayable MP4 files.
---

# Paper Collage Video on Windows

## Principles

Diagnose before generating. If the user asks only for an environment check, do not create assets, call paid APIs, or render video.
For beginners, provide one short group of commands at a time, explain the expected result, and continue from the actual output.
Preserve existing renders and use a version suffix for revised exports.

## Workflow

### 1. Confirm the brief

Confirm topic, script, aspect ratio, duration, production method, narration language and voice, music, and sound effects.
If the user rejects sound effects, retain narration and remove only the effects track.

### 2. Run Gate 0

From the skill directory, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check_windows_video_env.ps1
```

Or check components individually:

```powershell
node --version
npm.cmd --version
python --version
ffmpeg -version
ffprobe -version
python -c "import importlib.metadata; print(importlib.metadata.version('edge-tts'))"
```

Node, npm, Python, FFmpeg, and ffprobe must be callable. Edge TTS is required only for that narration method. Cloud generation keys must be reported only as set or missing; never print their values.
Read [Windows troubleshooting](references/windows-troubleshooting.md) for failed checks.

### 3. Pre-produce the content

Before asset generation, prepare:

1. A narration script sized for the target duration.
2. Three to six scenes with subject, background, foreground, text, and motion.
3. An asset manifest that identifies transparent PNGs, torn edges, and front/back layer splits.
4. User approval of the storyboard.

Use paper texture, visible torn edges, cutout shadows, a limited palette, and slight misalignment. Prefer layered parallax, pushes, pans, rocking, and staged entrances over uniform floating motion.

### 4. Generate and verify narration

Test Edge TTS with a short sentence before the complete narration:

```powershell
python -m edge_tts --voice zh-CN-YunjianNeural --text "Voice test successful" --write-media "$env:USERPROFILE\Downloads\tts-test.mp3"
```

Proceed only when the test file is non-empty and playable. Default to `zh-CN-YunjianNeural` for a Mandarin male voice unless the user requests another voice.
For network errors, test `speech.platform.bing.com:443`. Never accept a zero-byte MP3 as success.

### 5. Assemble and render with Remotion

Use `npm.cmd` and `npx.cmd` in PowerShell to avoid `npm.ps1` execution-policy errors.
Preview at low cost before the final render. Put audio in Remotion's accessible static/public path.
For render failures, lower concurrency first, then check Edge/Chromium paths, package versions, and asset URLs.

### 6. Mix and export

Keep narration dominant, music supportive, and effects sparse and purposeful. Do not attenuate the same track twice.
Prefer H.264, `yuv420p`, AAC, and `faststart`. Read [Audio and export](references/audio-and-export.md).

### 7. Run Gate 1

Use `ffprobe` to verify that the final file contains both video and audio. Check:

- Correct resolution and aspect ratio.
- Duration close to the brief.
- H.264 video with `yuv420p`.
- At least one AAC audio stream.
- Clear narration without silence, clipping, or rejected effects.
- Successful playback in a common player.

Report the final absolute path, duration, and included audio tracks. If the user hears no sound, inspect the audio stream and loudness before rerendering.

## Communication

Respond to beginners in their language. Show commands one per line and state what success looks like. Ask for the complete error text or screenshot, then solve only the current blocker.
