# Nexus

Nexus is a lightweight Roblox networking module that provides structured remote communication patterns for server-client workflows.

## Documentation

This repository includes MkDocs documentation in the `docs/` directory.

- Local docs source: `docs/`
- MkDocs configuration: `mkdocs.yml`

The project also includes GitHub Actions workflows to build docs and deploy them to GitHub Pages.

## Getting Started

To build the place from scratch, use:

```bash
rojo build -o "Nexus.rbxlx"
```

Then open `Nexus.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

## Local Documentation

Install MkDocs and run the local docs server:

```bash
python -m pip install mkdocs
mkdocs serve
```

## More Information

For more help with Rojo, see [Rojo documentation](https://rojo.space/docs).
