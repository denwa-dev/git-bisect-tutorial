# Dependencies

- Node.js

# Setup

From the root of this repository, run:

```bash
./create-hello-bug-project.sh
cd hello-bug-project
```

This creates a new directory with a git repository and a series of commits. One commit introduces a bug.

# Finding the Bug with Git Bisect

Start bisecting:

```bash
git bisect start
git bisect bad        # Mark HEAD as bad (contains the bug)
```

Then, mark the initial commit as good (replace `<commit-hash>` with the hash of the first commit, found via `git log --oneline`):

```bash
git bisect good <commit-hash>
```

Git will now check out a commit halfway between good and bad. At each step, test the program:

```bash
node main.js
```

- If the output is "Hello!", run: `git bisect good`
- If the output is "Bug!", run: `git bisect bad`

Repeat until git prints:

```
<commit-hash> is the first bad commit
```

# Documenting the Bug

When you find the buggy commit, tag it and review the changes:

```bash
git tag bug-commit
git show
```

Good luck hunting the bug!
