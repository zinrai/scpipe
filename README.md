# SCPipe

A command-line utility for copying files between servers through your local machine.

## Overview

SCPipe streamlines the process of transferring files between two remote servers. Instead of manually executing multiple SCP commands to first download a file locally and then upload it to another server, SCPipe handles both operations with a single command.

## Features

- Copy files from one server to another via your local machine
- Retains a local copy of the transferred file
- No additional dependencies beyond standard SSH tools

## Usage

The basic syntax is:

```bash
$ scpipe.sh --from SOURCE --to DESTINATION
```

Where:
- `SOURCE` is in the format `username@server:/path/to/source`
- `DESTINATION` is in the format `username@server:/path/to/destination`

### Examples

Copy a file from server1 to server2:

```bash
$ scpipe.sh --from john@server1.example.com:/home/john/data.txt --to mary@server2.example.com:/home/mary/backup/
```

Copy a file and rename it on the destination server:

```bash
$ scpipe.sh --from john@server1.example.com:/home/john/data.txt --to mary@server2.example.com:/home/mary/backup/renamed.txt
```

## How It Works

- SCPipe copies the file from the source server to your current working directory
  - Currently only supports file transfers (not diretories)
  - Authentication is handled by your SSH configuration (keys, passwords, etc.)
- It then copies the local file to the destination server
- The local copy remains in your current directory after the transfer

## License

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/license/mit) for details.
