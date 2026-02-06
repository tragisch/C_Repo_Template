# Bazel Setup Tools

Quick-start Konfiguration für Bazel auf macOS.

## Verwendung

### Erste Verwendung
```bash
bash init_bazel_env.sh
```

Dies erstellt automatisch die Cache-Verzeichnisse:
- `~/.bazel/repo-cache` - Repository dependencies
- `~/.bazel/distdir` - Distribution mirror (optional)
- `~/.bazel/build-cache` - Build artifacts

### Die .bazelrc ist bereits konfiguriert
Die `.bazelrc` Datei verweist bereits auf diese Verzeichnisse:
```bazelrc
common --repository_cache=~/.bazel/repo-cache
build --disk_cache=~/.bazel/build-cache
```

## Info

Siehe `docs/BAZEL_CACHING.md` für ausführliche Dokumentation.

**Key Points**:
- ✅ Caches überleben `bazel clean --expunge`
- 🚀 85-95% schneller nach initial build
- 📦 Offline builds möglich mit `--distdir`
