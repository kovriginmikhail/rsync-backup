# 🔄 Rsync Smart Backup

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/Bash-%3E%3D5.0-blue)](https://www.gnu.org/software/bash/)
[![Last Backup](https://img.shields.io/badge/Last_Backup-Automated-orange?logo=rsync)](https://gitlab.com)
[![CI Status](https://img.shields.io/badge/GitLab-CI_ready-yellow?logo=gitlab)](https://gitlab.com)
[![ShellCheck](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/shellcheck.yml)
[![shfmt](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/shfmt.yml/badge.svg)](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/shfmt.yml)
[![Release](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/release.yml/badge.svg)](https://github.com/kovriginmikhail/rsync-backup/actions/workflows/release.yml)

A smart and safe way to synchronize files with backup protection — powered by `rsync`.  
This Bash script ensures that **no file is lost during sync** by backing up everything that would be deleted.

---

## 🚀 Why Use This Script?

Tired of `rsync --delete` removing files without mercy?  
This script adds an **"undo buffer"** — it backs up any files that `rsync` is about to delete.

✅ No data loss  
✅ Fully automated  
✅ Clean logs and structure  
✅ Easy to schedule with `cron`  
✅ Works on any Linux/macOS system with `rsync`

---

## 📦 What It Does

1. Scans for files that would be deleted from the destination
2. Backs them up to a timestamped folder before actual deletion
3. Runs `rsync` with `--backup` and `--delete`
4. Logs all actions to a timestamped `.log` file

---

## 🗂 Project Structure

```
rsync_lab/
├── src/              # Source files to sync from
├── dst/              # Destination folder
├── full_backups/     # Timestamped backup of deleted files
├── logs/             # Detailed log files for each sync
└── rsync_backup.sh   # Main script
```

---

## ⚙️ Setup & Usage

1. Clone the repo and make the script executable:

```bash
chmod +x rsync_backup.sh
```

2. Run the sync manually:

```bash
./rsync_backup.sh
```

3. (Optional) Set up cron for automatic sync (daily at 2AM):

```bash
crontab -e
```

Add:

```cron
0 2 * * * /absolute/path/to/rsync_backup.sh
```

---

## 🔁 Log Rotation (Optional)

Create a file `/etc/logrotate.d/rsync_backup`:

```conf
/home/YOUR_USER/rsync_lab/logs/*.log {
    daily
    rotate 14
    compress
    missingok
    notifempty
    delaycompress
    copytruncate
}
```

Replace `YOUR_USER` with your actual username.

---

## 🔐 Requirements

- `bash`
- `rsync`
- `cron` (for scheduling)
- `logrotate` (optional)

---

## 📄 License

MIT License – free to use, modify, and distribute.

---

## ❤️ Contributing

Have improvements? Bugfixes? Open a merge request or fork the project.  
Feedback and pull requests are always welcome!
