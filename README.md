# envflare_cli

A CLI tool to generate and manage flavor-based environment variable files for Flutter projects. Simplify environment configuration across different build flavors (e.g., development, staging, production) with schema validation and automated code generation.

## Features

- **Flavor Management**: Create, remove, and list environment flavors.
- **Schema-Based Variables**: Define environment variables in a schema file (`.env.schema`).
- **Environment Operations**: Add, remove, set, and list environment variables per flavor.
- **Sync & Validate**: Ensure all flavors have consistent variables and validate configurations.
- **Code Generation**: Generate Dart code using `envied` package for secure environment access.
- **CLI-Friendly**: Simple command-line interface with helpful error messages.

## Getting Started

### Prerequisites

- Dart SDK (^3.4.0)

### Dependencies

To use the code generation feature, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  envied: ^1.3.4

dev_dependencies:
  build_runner: ^2.13.1
  envied_generator: ^1.3.4
```

Then run `flutter pub get` to install them.

### Installation

#### From pub.dev (Recommended)

```bash
dart pub global activate envflare_cli
```

Verify installation:
```bash
envflare --help
```

## Usage

### Initialize Project

Start by initializing your project:
```bash
envflare init
```
This creates `.env.schema` and `.envflare_cli.json` config files.

### Manage Flavors

Add a new flavor:
```bash
envflare flavor add development
```

List all flavors:
```bash
envflare flavor list
```

Remove a flavor:
```bash
envflare flavor remove development
```

### Manage Environment Variables

Add a new variable to schema and all flavors:
```bash
envflare add API_URL
```

Set value for a variable in a specific flavor:
```bash
envflare set API_URL https://api.example.com --flavor development
```

Set value for all flavors:
```bash
envflare set DEBUG true
```

List variables for a flavor:
```bash
envflare list --flavor development
```

List all variables across flavors:
```bash
envflare list
```

Remove a variable from schema and all flavors:
```bash
envflare remove API_URL
```

Sync variables across flavors (add missing ones):
```bash
envflare sync
```

Validate configurations:
```bash
envflare validate
```

### Generate Code

Generate secure Dart code using `envied` (requires dependencies above):
```bash
envflare generate
```
This runs `build_runner` to create environment classes from your `.env` files.

## Example Workflow

1. Initialize:
   ```bash
   envflare init
   ```

2. Add flavors:
   ```bash
   envflare flavor add dev
   envflare flavor add prod
   ```

3. Add variables:
   ```bash
   envflare add API_BASE_URL
   envflare add DEBUG_MODE
   ```

4. Set values:
   ```bash
   envflare set API_BASE_URL https://dev.api.com --flavor dev
   envflare set API_BASE_URL https://prod.api.com --flavor prod
   envflare set DEBUG_MODE true --flavor dev
   envflare set DEBUG_MODE false --flavor prod
   ```

5. Generate code:
   ```bash
   envflare generate
   ```

## File Structure

After setup, your project will have:
```
.env.schema          # Schema file with variable keys
.envflare_cli.json         # Config file with flavor list
.envs/
  dev.env           # Environment file for 'dev' flavor
  prod.env          # Environment file for 'prod' flavor
```

## Additional Information

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Issues

If you find any bugs or have feature requests, please open an issue on GitHub.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Author

Created by Muhammad Rizky
