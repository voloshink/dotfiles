# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Dotfiles Architecture

This repository uses the **Dotbot** configuration management system with a modular approach:

- **meta/base.yaml** - Base configuration with common defaults for all dotbot operations
- **meta/configs/** - Individual configuration files for different tools (nvim.yaml, zsh.yaml, etc.)
- **meta/profiles/** - Profile definitions combining multiple configurations
  - `home` - Personal environment profile
  - `work` - Work environment profile

## Core Installation Commands

### Install Complete Profiles

```bash
./install-profile home        # Install home profile
./install-profile work        # Install work profile
./install-profile home work   # Install multiple profiles
```

### Install Individual Configurations

```bash
./install-standalone nvim     # Install only Neovim config
./install-standalone zsh tmux # Install multiple configs
./install-standalone apt-sudo # Install with sudo privileges (add -sudo suffix)
```

## Configuration Structure

### Available Configurations

- **nvim** - LazyVim-based Neovim setup
- **nvim-kickstart** - Alternative Neovim configuration (kickstart.nvim-based)
- **zsh** - Base Oh-my-zsh configuration
- **zsh-home** - Oh-my-zsh configuration for home profile
- **zsh-work** - Oh-my-zsh configuration for work profile
- **tmux** - Terminal multiplexer with vi bindings
- **lazygit** - Git TUI configuration
- **ghostty** - Terminal emulator configuration
- **xcode** - Xcode themes and settings
- **ideavimrc** - IntelliJ Vim plugin configuration
- **tmuxinator** - Tmux session management
- **git** - Git configuration
- **homebrew** - Homebrew package manager configuration
- **bin** - Custom utility scripts

### Profile Differences

- **home profile**: Uses `zsh-home` configuration
- **work profile**: Uses `zsh-work` configuration
- Both profiles include the same core tools but with environment-specific settings

## Development Workflow

### Adding New Configurations

1. Create config file in `meta/configs/[tool].yaml`
2. Create corresponding directory with dotfiles in repository root
3. Update relevant profile(s) in `meta/profiles/`
4. Test with `./install-standalone [tool]`

### Modifying Existing Configurations

1. Edit the dotfiles directly in their respective directories
2. Run `./install-standalone [config]` to apply changes
3. Or run `./install-profile [profile]` to reinstall entire profile

## Key Tools and Technologies

- **Dotbot**: Configuration management framework
- **LazyVim**: Neovim distribution with modern plugin management
- **Oh-my-zsh**: Zsh framework with themes and plugins
- **Tmux**: Terminal multiplexer with custom key bindings
- **Lazygit**: Terminal-based Git interface

## Environment Variables

The system supports environment variable expansion in dotbot configs. Variables can be defined in shell environment files and referenced in YAML configurations using `$VARIABLE_NAME` syntax.

## Notes

- All installation scripts automatically handle git submodule initialization
- Configurations use force linking and creation of parent directories
- The system supports sudo operations by adding `-sudo` suffix to config names
- Profile files support comments using `#` at the beginning of lines to ignore configurations

