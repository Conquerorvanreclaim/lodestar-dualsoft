# Cryptographic anchors

SHA-256 anchors for the three CI crypto files captured from the CI server.

| file | sha256 |
|---|---|
| `hudson.util.Secret` | `e998e02b205f4eadd5c445e38420a0f8783081442ebb0ed0c52d9634642cbfe7` |
| `master.key` | `602ed5f63056c344ff9e0bae7e880965b13574d94df484cfc1136575bcc00596` |
| `secret.key` | `e2e59fccc5916529c6efc80c6e89a3864771481f90ff14c79327eca906222ada` |

The binaries themselves are not committed here; they ship with the releases.
Verify a downloaded copy with:

```
sha256sum <file>
```
