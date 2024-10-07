# 🔒 **LockEdit** 🔒

## **_Take Control of Your Files and Keep Them Safe!_**

---

**LockEdit** is a nifty script that helps you manage file immutability in a secure and structured way. Inspired by the constant vigilance we need over our dotfiles and other critical files, LockEdit makes sure you can edit, lock, and keep track of any file you choose. Whether you're securing your `.zshrc`, safeguarding your scripts, or protecting sensitive configurations, **LockEdit** has your back.

## 📜 **What Does It Do?**

LockEdit is a **CLI tool** that:

1. Temporarily removes the immutable flag (`chattr +i`) from a file.
2. Opens the file in your favorite text editor (because everyone has one).
3. Reseals the file as immutable once you’re done.
4. Logs every file you choose to lock, so you always know what's under LockEdit’s watch.
5. And it does all of this with the power of **Linux permissions**!

## 🛠️ **Installation**

1. **Clone the Repo:**

   ```bash
   git clone https://github.com/yourusername/lockedit.git
   cd lockedit
   ```

2. **Set It Up:**
   Make the script executable and move it to your bin:

   ```bash
   chmod +x lockedit.sh
   sudo mv lockedit.sh /usr/local/bin/lockedit
   ```

3. **Configuration:**
   Set up your configuration files:

   - Global config file: `/etc/lockedit/lockedit.conf`
   - User config file: `~/.config/lockedit/lockedit.conf`

   **Example configuration**:

   ```bash
   PROGRAM_NAME="lockedit"
   LOG_DIR="/etc/$PROGRAM_NAME"
   LOG_FILE="$LOG_DIR/list"
   EDITORS=("nano" "vim" "nvim" "vi" "emacs" "gedit")
   ```

## 💻 **Usage**

Here’s how you LockEdit like a pro:

```bash
lockedit /path/to/your/file
```

This will:

1. Unlock the file, making it writable.
2. Open it in your preferred text editor.
3. Lock it up again, restoring immutability.

## 🚀 **Features**

- **Customizable Editor Selection**: If `$EDITOR` is not set, LockEdit will attempt to find a text editor for you (starting with `nano` and working its way down).
- **File Logging**: Keeps track of all files you've locked with a simple log file.
- **System-Wide or User-Specific Configurations**: The tool checks for both user and global configurations, giving you flexibility based on your needs.
- **Secured Editing**: Files are protected before and after edits using Linux’s `chattr` command.

## 📂 **Configuration Files**

LockEdit uses two potential configuration files. The script checks them in this order:

1. **User Configuration**: `$HOME/.config/lockedit/lockedit.conf`
2. **Global Configuration**: `/etc/lockedit/lockedit.conf`

If both files are missing, LockEdit will throw an error and exit.

## 🛡️ **Security Features**

LockEdit ensures that:

- Files are locked with `chattr +i`, so even if you have write permissions, you cannot modify them without going through LockEdit.
- A custom master password can be set to further secure access to LockEdit (future feature 🚧).

## 📝 **License**

LockEdit is released under the **GPL-2.0 License**. See the `LICENSE` file for more details.

## 🌟 **Contributing**

Want to add a feature or fix a bug? Pull requests are welcome! If you find an issue, please create an issue on GitHub. Let’s make **LockEdit** better together!

## 💬 **Feedback**

Got ideas? Found a bug? Just want to say hi? Open an issue, or fork the project and make a PR. We’d love to hear from you!

## 🙏 **Thanks**

A big thanks to everyone who uses **LockEdit**. Your files are safer now! 🛡️

---

Let’s keep those files locked and loaded! 🔐
