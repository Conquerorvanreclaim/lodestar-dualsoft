# lodestar-dualsoft

Public mirror of a snapshot of the internal source infrastructure operated by Dualsoft d.o.o., a white-label betting platform vendor. The snapshot covers 78 internal repositories and 139,391 files (5.5 GB): 137,220 are source-tree paths, the remainder Git metadata. This repository hosts the manifest and the staged per-brand releases, published for review and audit.

## Who LODESTAR is

LODESTAR publishes this material. Contact and verification details are at the bottom of this page.

## What is here

The release is staged: the manifest first, then brand archives one at a time. The full file-level manifest with SHA-256 hashes is the entry point and is released first as `w1-estate`.

| Release family | Tag | Contents |
|---|---|---|
| Estate manifest | `w1-estate` | Full file-level manifest with SHA-256 for all 137,220 source-tree paths. Entry point. |
| Source | per-brand | Selected source trees, including brand front-end skins and deployments. |
| Deployment configs | per-brand | Brand deployment configurations. |
| Database schemas | per-schema | Schemas `omega`, `sigma`, `vegasbet`; 33,957 DB migration files and 286 Oracle PL/SQL packages exist in the snapshot. |
| Network | per-brand | Sanitized OpenVPN profiles for the brand network. |
| CI | `ci-secrets` | CI secret files (values). |
| Crypto anchors | `ci-crypto-anchors` | CI crypto anchors (see Integrity). |

The snapshot contains 147 projects and 50+ microservices in total. Not everything is published; see "What is deliberately not published".

## How it was obtained

- A full copy of the internal estate was taken and packaged by a CI agent.
- The manifest goes out first, brand archives follow one at a time.
- Credentials were rotated only months after the snapshot; a debug-enabled build is still served by the update infrastructure.
- The intake path was never closed.

Context: shared white-label infrastructure serving 20+ operator brands with no isolation between clients.

## Integrity

These anchors identify the snapshot shown to Dualsoft. They are SHA-256 hashes of the CI crypto files:

- `master.key`: `602ed5f63056c344ff9e0bae7e880965b13574d94df484cfc1136575bcc00596`
- `hudson.util.Secret`: `e998e02b205f4eadd5c445e38420a0f8783081442ebb0ed0c52d9634642cbfe7`
- `secret.key`: `e2e59fccc5916529c6efc80c6e89a3864771481f90ff14c79327eca906222ada`

The complete file-level hash list (137,220 paths) is in the `w1-estate` release manifest.

## How to verify a file against the manifest

1. Download the manifest from the `w1-estate` release.
2. Download the file you want to check.
3. Extract the line for that path and check it: `gzip -dc manifest-sha256.txt.gz | grep -F "  <path>" > /tmp/one && sha256sum -c /tmp/one`. Where a release ships `SHA256SUMS`, run `sha256sum -c SHA256SUMS` from the release directory.

## What is deliberately not published

- The current persistence mechanism.
- Whether live access still works.
- The origin of the employee credentials.

## Onion mirror

Primary entry point, independent of GitHub, is the Tor portal:
`http://lodestar6a5eygxyd3yw3qf2r6flr7w3wg24lsozk22ofdf6kjh7i3qd.onion`

This repository is the mirror.

## Contact

- Email: `lodestar.info@proton.me`
- PGP: `6A08 559D A764 5691 B80C 84F3 657A AC57 0894 E7FF` (published in `lodestar_pubkey.asc` in the release assets)

Signed releases carry the `LODESTAR` signature.

## Notice

See [NOTICE.md](NOTICE.md). The material is proprietary to Dualsoft d.o.o. and its clients and is published for review and audit. No warranty is given.
