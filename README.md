# Pierre Boutquin's Dotfiles Repo

Pierre Boutquin's Dotfiles Repo is a cross-platform dotfiles repository for macOS, Linux, and Windows. It is designed to provide a consistent development environment across platforms by using robust configuration management, automated setup scripts, and streamlined tools for productivity.

## Features

- **Cross-Platform Support**:
  - Configures Zsh with `oh-my-posh` for macOS, Linux, and Windows.
  - Platform-specific `.zshrc` and `.zprofile` files.
- **Environment Customization**:
  - Secure handling of private environment variables via `private_env.sh`.
  - Customizable prompt themes using `oh-my-posh` or `starship`.
- **Development Tools**:
  - Git configurations for global `config` and `ignore` files.
  - Dotfiles tailored for Ruby on Rails, .NET, Python, and more.
- **XDG Base Directory Compliance**:
  - Stores configuration files in `~/.config` for compatibility with modern conventions.
- **Idempotent Setup Scripts**:
  - Automated installation script (`install.zsh`) ensures safe and repeatable setup.
  - Backups existing configurations to `.bak` files before overwriting.
- **Aliases and Enhancements**:
  - Useful shell aliases for navigation, file management, and system commands.
  - Safety enhancements like interactive `rm`, `cp`, and `mv`.

## Getting Started

### Installation

1. Clone this repository to your local machine:

    ```bash
    mkdir -p ~/.dotfiles
    git clone https://github.com/boutquin/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

2. Make the `install.zsh` script executable:

    ```bash
    chmod +x install.zsh
    ```

3. Run the installation script:

    ```bash
    ./install.zsh
    ```

4. Reload your shell to apply the changes:

    ```bash
    source ~/.zshrc
    ```

### Folder Structure

dotfiles/
├── config/
│   ├── git/
│   │   ├── config
│   │   └── ignore
│   └── starship.toml
├── zsh/
│   ├── macos/
│   │   ├── .zshrc
│   │   └── .zprofile
│   ├── linux/
│   │   ├── .zshrc
│   │   └── .zprofile
│   ├── oh-my-posh.json
│   └── aliases.zsh
├── private_env.zsh
└── install.zsh

### Key Configuration Highlights

- **Zsh Configuration**:
  - `.zshrc` tailored for interactive shells with aliases, plugins, and prompts.
  - `.zprofile` manages environment variables and login shell configurations.
- **Private Environment Variables**:
  - Store sensitive information in `private_env.zsh` (e.g., API keys).
  - Securely linked to `~/.config/private_env.zsh` during installation.
- **Prompt Themes**:
  - `oh-my-posh.json` defines a stylish and informative terminal prompt.
  - Optional Starship configuration for lightweight prompts.

## Contributing

We welcome contributions to improve and expand this repository! Please follow the steps below to contribute:

### Reporting Bugs

If you encounter a bug, open an issue on the [Issues](https://github.com/boutquin/dotfiles/issues) page with the following details:

- Clear and descriptive title.
- Steps to reproduce the issue.
- Expected vs. actual behavior.
- Screenshots or logs, if applicable.
- System information (OS, terminal emulator, etc.).

### Suggesting Enhancements

Have an idea for a new feature or improvement? Submit a feature request on the [Issues](https://github.com/boutquin/dotfiles/issues) page. Include:

- A descriptive title.
- Detailed explanation of the enhancement.
- Benefits and use cases.
- Potential challenges or trade-offs.

### Contributing Code

1. **Fork the repository**:

    ```bash
    git clone https://github.com/boutquin/dotfiles.git
    cd dotfiles
    ```

2. **Create a feature branch**:

    ```bash
    git checkout -b feature-name
    ```

3. **Make your changes**:
   - Ensure your changes align with the repository's structure and standards.
   - Test your changes thoroughly.

4. **Commit your changes**:

    ```bash
    git commit -m "Add feature-name"
    ```

5. **Push to your fork**:

    ```bash
    git push origin feature-name
    ```

6. **Open a pull request**:
   - Go to the original repository and open a pull request.
   - Provide a clear description of your changes.

## Security and Best Practices

- **Private Files**:
  - `private_env.zsh` is excluded from version control using `.gitignore`.
  - Always secure this file with restrictive permissions:

    ```bash
    chmod 600 ~/.config/private_env.zsh
    ```

- **Backups**:
  - The installation script automatically creates backups of existing configurations.

## License

This repository is licensed under the Apache 2.0 License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, feel free to:

- Open an issue on [GitHub](https://github.com/boutquin/dotfiles/issues).
- Start a discussion on [GitHub Discussions](https://github.com/boutquin/dotfiles/discussions).

## Acknowledgments

- Inspired by the [Oh My Zsh](https://ohmyz.sh/) community.
- Prompt themes powered by [Oh My Posh](https://ohmyposh.dev/).
- Contributions and feedback from developers worldwide.
