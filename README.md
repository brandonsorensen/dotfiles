# dotfiles

## Structure

```
common/   # shared config (nvim, tmux, shell, git, pi)
mac/      # macOS-specific config (Brewfile, iTerm2)
scripts/  # utility scripts
```

Configs are symlinked from `~/.config/` (or `$HOME`) into the appropriate subdirectory here. Machine-specific branches contain their own setup instructions.

## Pi global config

Global pi config lives in `common/.pi/agent/` and is intended to be symlinked as `~/.pi/agent`:

```bash
mkdir -p ~/.pi
mv ~/.pi/agent ~/.pi/agent.backup 2>/dev/null || true
ln -s "$PWD/common/.pi/agent" ~/.pi/agent
```

Runtime state such as auth, trust decisions, sessions, and installed pi packages is ignored by git inside that directory.

## Branch strategy

`master` is the common base for all machines. Machine-specific branches (e.g. `terra`) extend it for a particular OS and hardware — some machines run macOS, others Linux.

### Keeping branches in sync

The goal is to keep platform-agnostic changes on `master` so they flow to all machines, and keep machine-specific changes isolated to their branch.

**Adding a common change:**

Commit directly to `master`, then merge into each machine branch:

```bash
git checkout master
# make changes, commit
git checkout terra
git merge master
```

**Pulling a machine-specific commit up to master:**

If a commit on a machine branch turns out to be platform-agnostic, cherry-pick it onto `master` first, then merge master back down:

```bash
git checkout master
git cherry-pick <commit>
git checkout terra
git merge master
```

When cherry-picking a range, go oldest-first and resolve conflicts by preferring master's version of any file that has diverged, then adding the new content from the cherry-picked commit.

**Periodic reconciliation:**

To find commits on a machine branch not yet on master:
```bash
git log --oneline master..<branch>
```

To find commits on master not yet in a machine branch:
```bash
git log --oneline <branch>..master
```
