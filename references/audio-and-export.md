# Audio and Export

## Track strategy

- Narration is the information track and must stay intelligible.
- Background music commonly sits 16-24 dB below narration and fades at both ends.
- Effects should be short, restrained, and tied to visible actions.
- When the user rejects effects, remove effects without removing narration.

## Verify streams

```powershell
ffprobe -v error -show_entries format=duration -show_entries stream=index,codec_type,codec_name,width,height,pix_fmt -of json final.mp4
```

Expect at least one `video` stream and one `audio` stream. A zero-byte source audio file or a video-only final file is a failed result.

## Compatibility settings

```text
-c:v libx264 -pix_fmt yuv420p -c:a aac -movflags +faststart
```

Measure track loudness before mixing. Avoid lowering music in both Remotion and FFmpeg. If music is inaudible, play the source music alone, then inspect the mix filter and final AAC stream.
