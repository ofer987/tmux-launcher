# TMUX Launcher

Terminal User Interface (TUI) application to select existing tmux session or start a new session. Does not work if executed from within tmux session.

## Requirements

- Unix-like (I tested it on macOS)
- NCurses (for terminal user interface)

## Installation

```shell
gem install tmux_launcher
```

## Usage

```shell
tmux_launcher
```

- Quit: q
- Up and Down using j and k keys
- Select: o and enter keys

## Notes

This application is *not* well designed. In fact, it could be used as a standout example of how not to write an application. Just take a look at `app/main.rb`. Yuck! It does so much: display text, take user input, get the next state, ask (i.e., delegate) text display to the state, manage the application lifecycle. So much! It is all very well unnecessary. Plus, the tests are broken and incomprehensive. Like what was I thinking when I wrote them?

Well, let me explain. This was all an experiment to quickly prototype a console application. The next step is to rewrite it like a pro, with a real architecture that uses appropriate [design patterns](https://en.wikipedia.org/wiki/Design_Patterns). Ideally it should be rewritten in [the Go language](https://golang.org), because it is more distributable. Users do not require the Ruby virtual machine. They do not need to use `gem install tmux_launcher`. They do not need to fetch dependencies. So much better!
