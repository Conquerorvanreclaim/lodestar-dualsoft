# Dualsoft — MaxBet (maxbet.rs) — v1

## Summary

First release of the staged publication. It covers MaxBet, the flagship white-label operator client of Dualsoft d.o.o. serving Serbia and Bosnia (maxbet.rs, maxbet.ba).

## Contents

1. Source tree for the brand's front-end skins and deployments (file list and hashes in `SHA256SUMS`).
2. Brand deployment configs for the MaxBet estate (72+ servers; 127 configuration files).
3. Relevant database schemas from the snapshot's schema set (`omega`, `sigma`, `vegasbet`; subset applicable to this brand).
4. Sanitized OpenVPN profile for the brand network segment (1 file).

MaxBet is a white-label client of the vendor, not the vendor itself.

## Integrity

This release ships `SHA256SUMS`. From the release directory run:

```
sha256sum -c SHA256SUMS
```

The full file-level manifest for the entire snapshot (137,220 source-tree paths) is in the `w1-estate` release. The CI crypto anchors for snapshot identity are listed in the hub README.

## What this brand shares with others

MaxBet runs on shared white-label infrastructure operated by Dualsoft d.o.o., which serves 20+ operator brands with no isolation between clients. Credentials were rotated only months after the snapshot. A debug-enabled build is still served by the update infrastructure.

## Related

- Manifest: `w1-estate` release.
- Previous brand release: none, first release.
- Next brand release: MerkurTip.

## Notice

See [NOTICE.md](../NOTICE.md). The material is proprietary to Dualsoft d.o.o. and its clients and is published for review and audit. No warranty is given.
