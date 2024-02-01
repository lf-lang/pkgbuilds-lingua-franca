This is a monorepo containing multiple AUR packages. Since AUR requires a git-based workflow and there is one repository per package, we use git subtree to manage all packages in this combined monorepo.

### Updating a package

To update a package that is already within this monorepo, simply make and commit your changes to the corresponding `PKGBUILD`. Don't forget to run `makepkg --printsrcinfo > .SRCINFO` and commit the change to `.SRCINFO` (otherwise the update will not be recognized by the AUR). To push the changes for a package called `<pkgname>` to the AUR, run the following command:
```
git subtree push --prefix=<pkgname> ssh://aur@aur.archlinux.org/<pkgname>.git master
```
Alternatively, you can use the `push_all.sh` script in this repo to push all packages.

Note that you need to be the maintainer of the package and authenticate via ssh in order to push the package updates to the AUR.

### Adding a new package

Adding a completely new package is a bit more complicated. First, you need to create the AUR repository using this command:
```
git -c init.defaultbranch=master clone ssh://aur@aur.archlinux.org/<pkgname>.git tmp
```
This will initialize an empty repository and clone it into `tmp/`. The clone is actually not needed and we can remove it with `rm -r tmp`.

Once the upstream repository is initialized, you can push the corresponding `PKGBUILD`. This assumes that you have already created a subdirectory `<pkgname>` with a `PKGBUILD` and an up-to-date `.SRCINFO` file, and committed those changes in the main monorepo. The following commands create a new subtree and push the changes to the newly created AUR repository:
```
git subtree split --prefix <pkgname> --branch <pkgname>
git push ssh://aur@aur.archlinux.org/<pkgname>.git <pkgname>:master
```
