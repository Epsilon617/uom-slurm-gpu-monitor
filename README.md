# UoM Slurm GPU Monitor

`gpuq` is a lightweight Slurm dashboard for the University of Manchester HPC environment.

It was built for a very specific workflow:

- watch `gpuL` and `gpuA` without hammering the scheduler
- keep a compact live view that refreshes every few seconds
- show your own jobs directly under the cluster summary
- make queue pressure, pending reasons, and current CPU/GPU usage visible at a glance

The current live mode is intentionally conservative:

- automatic refresh only
- no live scrolling inside the dashboard
- full queue browsing is still available through `gpuq --view`

That tradeoff is deliberate. On shared HPC login nodes, a stable read-only dashboard is much more reliable than a shell script pretending to be a full terminal UI.

## Features

- live Slurm summary for `gpuL` and `gpuA`
- Monokai-friendly terminal colors
- pending reason summaries per partition
- `Your jobs` table with:
  - partition
  - state
  - elapsed time
  - time limit
  - CPU count
  - GPU count
  - node / reason
  - job name
- current `CPU used / quota` and `GPU used / quota`
- one-shot snapshot view with `gpuq --view`

## Requirements

The script expects these commands to exist on the target system:

- `bash`
- `squeue`
- `sinfo`
- `sacctmgr`
- `awk`
- `column`
- `sort`
- `date`
- `id`
- `perl`
- `tput`
- `less`
- `mktemp`
- `stty`

This project is intended for Slurm-based HPC systems. It is not a general cluster monitoring package.

## Install

Clone the repo and run:

```bash
./install.sh
```

The installer:

- copies `bin/gpuq` into `~/bin/gpuq`
- makes it executable
- adds a shell wrapper to `~/.bashrc` if needed:

```bash
gpuq() { bash "$HOME/bin/gpuq" "$@"; }
```

That wrapper is intentional. On some HPC filesystems, direct execution from home directories is unreliable, while `bash ~/bin/gpuq` is stable.

After installation:

```bash
source ~/.bashrc
gpuq
gpuq 3
gpuq --view
```

## Usage

```text
gpuq
gpuq 3
gpuq -n 3
gpuq --view
```

- `gpuq`: refresh every 5 seconds
- `gpuq 3`: refresh every 3 seconds
- `gpuq --view`: open one full snapshot in `less -R`

## Design Notes

- The live dashboard uses a compact, read-only refresh loop.
- Input-heavy live interaction was intentionally removed because it was not reliable across different terminal frontends.
- The redraw path clears each printed line explicitly so stale text does not remain on screen after shorter updates.

## Project Layout

```text
bin/gpuq        Main dashboard script
install.sh      Local installer for ~/bin and ~/.bashrc
tests/smoke.sh  Minimal syntax and CLI smoke checks
```

## Smoke Test

```bash
./tests/smoke.sh
```

This validates shell syntax and a few safe non-interactive code paths.

## License

MIT
