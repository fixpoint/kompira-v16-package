#!/bin/sh
set -e

# This script lives in scripts/ but uses paths relative to the repository root
# (./RELEASE-NOTES.md, ./packages/...). Move to the repo root so it works no
# matter which directory it is invoked from.
cd "$(dirname "$0")/.."

# Fixed target repository. Hardcoded (not an overridable env var) so the value
# interpolated into the emitted command cannot be a vector for shell injection.
GH_REPO="fixpoint/kompira-v16-package"

if [ "$1" = "" ]; then
    echo "usage: $0 <version>" >&2
    echo "example: $0 1.6.13.post1" >&2
    exit 1
fi

VERSION="$1"

# Reject versions containing characters outside the expected set. VERSION is
# interpolated into the emitted command (run via `| sh`), so this also guards
# against shell injection and accidental quoting issues.
case "$VERSION" in
    *[!0-9A-Za-z._-]*)
        echo "ERROR: invalid version: $VERSION" >&2
        exit 1 ;;
esac

TAG_NAME="v${VERSION}"
TITLE="Kompira Enterprise $TAG_NAME"
RELEASE_NOTE="./RELEASE-NOTES.md"
RELEASE_NOTE_TMP="./.RELEASE-NOTES.md.tmp"
PACKAGE_FILE="./packages/kompira-${VERSION}-bin.tar.gz"

# Check that the package file and the release note file exist.
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "ERROR: Package file not found: $PACKAGE_FILE" >&2
    exit 1
fi
if [ ! -f "$RELEASE_NOTE" ]; then
    echo "ERROR: Release note file not found: $RELEASE_NOTE" >&2
    exit 1
fi

# Extract the release note for the specified version.
# Match from the version heading up to (but not including) the next "---"
# separator (or EOF for the oldest entry); the lookahead keeps the separator
# out of the match, so only the trailing blank lines remain to be stripped.
# VERSION is exported so it is visible to perl as $ENV{VERSION}.
export VERSION
perl -0777 -ne '
  if (/^## Ver\.\Q$ENV{VERSION}\E .*?(?=^---|\z)/sm) {
    my $match = $&;
    $match =~ s/\s+\z//;
    print $match, "\n";
  }
' "$RELEASE_NOTE" > "$RELEASE_NOTE_TMP"

# perl matches the version heading literally (\Q...\E), so empty output means
# the requested version is not present in the release note.
if [ ! -s "$RELEASE_NOTE_TMP" ]; then
    echo "ERROR: Release note for version $VERSION not found in $RELEASE_NOTE" >&2
    rm -f "$RELEASE_NOTE_TMP"
    exit 1
fi

# Create the release on GitHub and upload the package file in one step
# (attaching the asset to `release create` avoids a published release that is
# momentarily missing its binary).
echo "gh release create \"$TAG_NAME\" \"$PACKAGE_FILE\" --title \"$TITLE\" --notes-file \"$RELEASE_NOTE_TMP\" --repo \"$GH_REPO\""
