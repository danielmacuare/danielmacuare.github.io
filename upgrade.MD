# Upgrade Guide: Jekyll Chirpy Theme

This guide provides instructions to upgrade the Jekyll Chirpy theme from version 6.2 to the latest version, 7.4.1.

This guide will also be used as reference on future upgrades.

## Prerequisites

- Git installed
- Ruby and Bundler installed

## Upgrade Steps

### 0. Compare the current version with latest ()
Current Version: v6.2.2
Latest Version: v7.4.1
https://github.com/cotes2020/chirpy-starter/compare/v6.2.2...v7.4.1

### 1. Add the Upstream Remote

If you haven't done so before, add the `chirpy-starter` repository as a remote to your local Git repository.

```bash
git remote add chirpy https://github.com/cotes2020/chirpy-starter.git
```

To verify the remote was added successfully, run:

```bash
git remote -v
```

You should see `chirpy` in the output.

### 2. Fetch the Latest Updates

Fetch all the tags from the upstream `chirpy` remote:

```bash
git fetch chirpy --tags
```

### 3. Merge the Latest Version

Merge the latest tag from upstream into your local branch.

```bash
git merge v7.4.1 --squash --allow-unrelated-histories
```

**Note:** The `--squash` flag combines all the changes from upstream into a single commit, keeping your commit history clean. The `--allow-unrelated-histories` flag is necessary if your local branch and the upstream theme do not share a common Git history.

### 4. Resolve Merge Conflicts

It is common to encounter merge conflicts, especially if you have made customizations to the theme files. You will need to manually resolve these conflicts.

- Run `git status` to see a list of unmerged files.
- Open each conflicting file in a text editor. You will see the conflicting changes marked with `<<<<<<<`, `=======`, and `>>>>>>>`.
- Edit the files to keep your changes, the theme's updates, or a combination of both. Remove the conflict markers.
- Once you have resolved the conflicts in a file, stage it using `git add <filename>`.

### 5. Commit the Changes

After resolving all conflicts, commit the changes to your local repository:

```bash
git commit -m "Upgrade to v7.4.1"
```

### 6. Update Dependencies

Finally, update your local theme gems:

```bash
bundle update
```

## Post-Upgrade

### Check for Breaking Changes

Before upgrading, it's a good practice to check the release notes on GitHub for any breaking changes or specific instructions for the new version.

### Local Testing

After upgrading, always test your website locally to ensure everything works as expected before deploying the changes. You can run your site locally with:

```bash
bundle exec jekyll serve -l
OR
bash tools/run.sh
```

## Rollback Process

If the upgrade introduces issues or does not work as expected, you can revert the changes using Git.

### 1. Revert the Merge Commit

If you followed the upgrade steps and created a single merge commit (as suggested with `--squash`), you can revert this commit:

```bash
git revert <commit-hash-of-upgrade>
```

To find the commit hash, you can use `git log`. Look for the commit message "Upgrade to v7.4.1" (or whatever message you used).

### 2. Reset to a Previous State (Use with Caution)

If you need to discard all changes since the last good commit before the upgrade, you can perform a hard reset. **Be extremely careful with this command as it will discard all uncommitted changes and revert your working directory to the state of the specified commit.**

```bash
git reset --hard <commit-hash-before-upgrade>
```

Replace `<commit-hash-before-upgrade>` with the hash of the commit *before* you started the upgrade process.

### 3. Clean Up Dependencies

After reverting the code, you might also need to revert your `Gemfile.lock` or run `bundle install` to ensure your dependencies match the reverted state.

```bash
bundle install
```

## Results

The upgrade to Jekyll Chirpy theme version 7.4.1 was successfully completed, but it encountered and resolved several issues:

### Issues Encountered

1. **Native gem compilation errors**: During `bundle update`, the process failed when trying to compile the `json` (version 2.15.2) and `racc` (version 1.8.1) gems. The error was caused by a missing `gmkdir` utility in the build process on macOS.

2. **YAML syntax error**: After resolving the gem compilation issues, starting the Jekyll server revealed a YAML syntax error in `_data/share.yml` at line 5, column 27. The first entry had improperly formatted inline syntax where `icon` was on the same line as `type`.

3. **Incorrect Image Paths**: After upgrading, the images on each post were not being rendered.

### Solutions Applied

1. **Fixed native gem compilation**:
   - Installed the `coreutils` package via `brew install coreutils` to provide the missing `gmkdir` utility
   - Installed the problematic gems individually: `gem install json -v '2.15.2'` and `gem install racc -v '1.8.1'`
   - Then successfully ran `bundle update` to complete the dependency updates

2. **Fixed YAML syntax error**:
   - Corrected the formatting in `_data/share.yml` where the LinkedIn platform entry had invalid inline syntax
   - Changed from `type: Linkedin    icon: "fab fa-linkedin"` to separate lines:
     ```yaml
     - type: Linkedin
       icon: "fab fa-linkedin"
       link: "https://www.linkedin.com/sharing/share-offsite/?url=URL"
     ```
3. **Incorrect Image Paths**: 

BEFORE:

![Maintenance's Logical Diagram](2020-09-21/fig2-maintenance-changes.webp){: w="900" h="600" }

AFTER
![Maintenance's Logical Diagram](/assets/img/posts/2020-09-21/fig2-maintenance-changes.webp){: w="900" h="600" }

### Final Status

- Jekyll theme successfully upgraded to Chirpy v7.4.1
- All dependencies updated and compatible
- Local Jekyll server running successfully at http://127.0.0.1:4000
- Site builds without errors
- Ready for deployment
