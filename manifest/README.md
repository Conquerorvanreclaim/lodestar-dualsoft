# Manifest

The manifest lists the SHA-256 and the path of every file of the estate snapshot, with `.git` excluded.
It ships as a release asset of the `w1-estate` tag rather than a tracked file in this repository.
Verify with `gzip -dc manifest-sha256.txt.gz | sha256sum -c -` from the snapshot root.
Source-tree paths in the manifest: 137220 (139391 files including Git metadata).
