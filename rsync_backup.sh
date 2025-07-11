#!/bin/bash

# === Paths ===
SRC="$HOME/rsync_lab/src/"
DST="$HOME/rsync_lab/dst/"
BACKUP_BASE="$HOME/rsync_lab/full_backups"
LOG_DIR="$HOME/rsync_lab/logs"
TS=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$BACKUP_BASE/$TS"
LOG_FILE="$LOG_DIR/rsync_log_$TS.log"

# === Create required directories ===
mkdir -p "$BACKUP_DIR" "$LOG_DIR"

# === Log the start of the process ===
echo "=== [$(date)] Synchronization started ===" | tee -a "$LOG_FILE"
echo "Backups will be saved to: $BACKUP_DIR" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# === Find and copy files that will be deleted ===
echo "[INFO] Looking for files that will be deleted..." | tee -a "$LOG_FILE"
rsync -av --delete --dry-run "$SRC" "$DST" \
  | grep '^deleting ' \
  | cut -d' ' -f2- \
  | while read -r file; do
      SRC_PATH="$DST/$file"
      if [ -f "$SRC_PATH" ]; then
          echo "[DELETE] Backing up deleted file: $file" | tee -a "$LOG_FILE"
          mkdir -p "$BACKUP_DIR/$(dirname "$file")"
          cp --preserve=all "$SRC_PATH" "$BACKUP_DIR/$file"
      fi
    done

# === Perform actual synchronization with logging ===
echo "" | tee -a "$LOG_FILE"
echo "[INFO] Running rsync with backup and delete..." | tee -a "$LOG_FILE"
rsync -av --backup --backup-dir="$BACKUP_DIR" --delete "$SRC" "$DST" | tee -a "$LOG_FILE"

# === Completion ===
echo "" | tee -a "$LOG_FILE"
echo "=== [$(date)] Synchronization completed ===" | tee -a "$LOG_FILE"
