---
description: "C/C++ conventions for this repo"
applyTo: "**/*.{h,hpp,c,cpp}"
---

# C/C++ Conventions (C Repo Template)

- Header first line: `#pragma once`.
- Use fixed‑width integer types (`uint8_t`, `uint32_t`, …) for public APIs.
- Keep functions small and explicit; avoid hidden global state.
- Validate pointers and sizes before use; avoid unchecked pointer arithmetic.
- Document each public function briefly: purpose, params, return semantics.
- Minimize dynamic allocation; if required, document ownership/lifetime clearly.
- Prefer `static`/`const` for internal symbols; avoid unnecessary globals.
- Include order: system headers (`<...>`) first, then local (`"..."`).
- Tests should use Unity and avoid direct platform/hardware assumptions.
