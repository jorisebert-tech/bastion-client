# Release Checksum Generator

This repository contains scripts and a GitHub Actions workflow used to generate SHA256 checksums for release assets and create draft GitHub releases.

## 📌 What it does

When triggered manually, the GitHub Actions workflow will:

1. Run a PowerShell script (`generate_checksums.ps1`)
2. Generate SHA256 checksums for:
   - `client/client.jar` (single file)
   - All files inside `runtimes/`
3. Create a **Draft Release** on GitHub using the version you provide
4. Upload only the following directories as release assets:
   - `client/`
   - `runtimes/`
5. Leave the release as **Draft** for manual review and publication

---

## 🧩 Files & Structure

```
.
├── client/
│   └── client.jar
├── runtimes/
│   └── ...
├── generate_checksums.ps1
└── .github/
    └── workflows/
        └── create-draft-release.yml
```

---

## ⚙️ How to run locally

### ✅ Windows / PowerShell

```powershell
pwsh ./generate_checksums.ps1
```

This generates:

- `client/version.json`
- `runtimes/versions.json`

---

## 🚀 GitHub Release Workflow

### Triggering

Go to:

```
Actions → Create Draft Release → Run workflow
```

You will be prompted to enter a version number.

### Version format

The version must follow this format:

```
vMAJOR.MINOR.PATCH
```

Example:

```
v1.0.0
v2.3.5
v10.0.1
```

### What happens

- A draft release is created with the tag you enter.
- Checksums are generated.
- `client/` and `runtimes/` are uploaded as release assets.
- The release stays in **Draft** mode for manual publishing.

---

## ✔️ Notes

- The workflow will **fail** if the version format is invalid.
- The workflow will **not publish** the release automatically.
- Only the `client/` and `runtimes/` directories are released.

---