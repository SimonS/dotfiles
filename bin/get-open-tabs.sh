lz4jsoncat $HOME/Library/Application\ Support/Firefox/Profiles/lupwyej0.default-release/sessionstore-backups/recovery.jsonlz4 | jq 'reduce (.windows[] .tabs | length) as $length (0; . + $length)'
