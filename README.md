# Dependencies

- Node.js

# Setup

From the root of this repository, run:

```bash
./create-hello-bug-project.sh
cd hello-bug-project
```

This creates a new directory with a git repository and a series of commits. One commit introduces a bug into the code.

# Finding the Bug with Git Bisect

Start the bisect process:

```bash
git bisect start
git bisect bad        # Mark HEAD as bad (it contains the bug)
```

Find the initial commit hash with:

```bash
git log --oneline
```

Then, mark the initial commit as good:

```bash
git bisect good <commit-hash>  # Replace <commit-hash> with the initial commit hash (known good)
```

Git will now automatically update your HEAD to the midpoint between the good and bad commit you indicated. Now, test the program to see if the bug is present:

```bash
node main.js
```

If the output is "Hello!", mark the commit as good:

```bash
git bisect good
```

If the output is "Bug!", mark it as bad:

```bash
git bisect bad
```

Continue these steps until git identifies logs the following message: <commit-hash> is the first bad commit

# Documenting the Bug

When you have found the commit, tag it and review the changes:

```bash
git tag bug-commit
git show
```

Good luck hunting the bug!
