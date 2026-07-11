# Development

## Local development

- Use Rojo to build and sync the project.
- Use Wally to install dependencies and keep versions consistent.

## Recommended workflow

```bash
wally install
rojo build -o Nexus.rbxlx
rojo serve
```

## Running documentation locally

Install MkDocs and build the site:

```bash
python -m pip install mkdocs
mkdocs serve
```

Then open the local server URL shown in the terminal.

## Repository layout

- `src/` — Luau source files for Nexus.
- `docs/` — MkDocs documentation source files.
- `mkdocs.yml` — MkDocs site configuration.
- `wally.toml` — Wally package metadata.
- `default.project.json` — Rojo project definition.

## Contribution

If you want to contribute, please open a pull request with a clear description of your changes. Keep API additions compatible with the existing event and async abstractions.
