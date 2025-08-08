# libssl1.1 Legacy Package for Modern Linux Distributions

**⚠️ WARNING:** This package provides **libssl1.1**, an unmaintained version of OpenSSL with known security vulnerabilities. It is **not recommended** for use in new applications or exposed services.

---

## About

OpenSSL 1.1 (libssl1.1) is **end-of-life** and no longer maintained upstream. It contains several [security issues](https://www.openssl.org/news/vulnerabilities.html) that are **not fixed** in this version.

Despite this, many legacy proprietary software packages — such as Dell’s **iDRAC Service Module (ISM)** and **OpenManage Server Administrator (OMSA)** — still depend on libssl1.1 for operation.

This repository provides a **convenience build** of libssl1.1 compiled from the original Debian Bullseye source, repackaged and rebuilt for modern Debian releases (e.g., Bookworm, Trixie), so these outdated binaries can continue running on newer systems.

---

## Why use this?

- Modern Debian and derivatives have moved on to OpenSSL 3.x or newer, dropping libssl1.1.
- Legacy software vendors (Dell iDRAC ISM, OMSA, and others) often lag in updating dependencies.
- This package enables running these tools **without downgrading your entire system** or manually hacking dependencies.

---

## Important Notes

- **Do not use this package for any new development or internet-facing services.**
- Use at your own risk — known vulnerabilities mean your system could be exposed.
- This package is for compatibility only.

---

## Example Software That May Require libssl1.1

- Dell iDRAC Service Module (ISM): https://www.dell.com/support/kbdoc/en-us/000179228/dell-openmanage-enterprise-dell-idrac-service-module-and-dell-omsa-are-not-compatible-with-debian-11-bullseye
- Dell OpenManage Server Administrator (OMSA): https://www.dell.com/support/kbdoc/en-us/000183356/dell-openmanage-server-administrator-omsa-installation-on-debian-11

---

## Build and Usage

This package is built from Debian Bullseye sources and rebuilt for modern Debian releases using Docker and GitHub Actions automation.

For more details, see the Dockerfile and workflow in this repo.

---

## License

Same license as the original OpenSSL project.

---

## Disclaimer

This software is provided "as-is" with no guarantees of security or stability. Use only if you understand the risks and have no alternative.

