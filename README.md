Copyright (c) 2018, Mnheia <mnheia@gmail.com>

# windows-time-voice
windows-time-voice is a VBS script that makes Windows tell you the current time.

The script supports English, German, Russian, Spanish, French and Chinese voices. It can use either 12-hour or 24-hour time.

# Example
Edit the configuration at the top of the script:

```
Language = "en"       ' en, de, ru, es, fr, zh
Use24Hour = False
```

The script can be run through Task Scheduler.

If the requested language voice is not installed, the script falls back to an English/default SAPI voice.

# Requirements
- Microsoft Windows
- A compatible SAPI voice for the selected language

# Bugs
Please report any bugs or feature requests through the web interface at https://github.com/mnheia/windows-time-voice/issues
