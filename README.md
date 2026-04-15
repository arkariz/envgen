# envgen

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
dart pub global activate envgen
```

Verify installation:
```bash
envgen --help
```

## Usage

### Initialize Project

Start by initializing your project:
```bash
envgen init
```
This creates `.env.schema` and `.envgen.json` config files.

### Manage Flavors

Add a new flavor:
```bash
envgen flavor add development
```

List all flavors:
```bash
envgen flavor list
```

Remove a flavor:
```bash
envgen flavor remove development
```

### Manage Environment Variables

Add a new variable to schema and all flavors:
```bash
envgen add API_URL
```

Set value for a variable in a specific flavor:
```bash
envgen set API_URL https://api.example.com --flavor development
```

Set value for all flavors:
```bash
envgen set DEBUG true
```

List variables for a flavor:
```bash
envgen list --flavor development
```

List all variables across flavors:
```bash
envgen list
```

Remove a variable from schema and all flavors:
```bash
envgen remove API_URL
```

Sync variables across flavors (add missing ones):
```bash
envgen sync
```

Validate configurations:
```bash
envgen validate
```

### Generate Code

Generate secure Dart code using `envied` (requires dependencies above):
```bash
envgen generate
```
This runs `build_runner` to create environment classes from your `.env` files.

## Example Workflow

1. Initialize:
   ```bash
   envgen init
   ```

2. Add flavors:
   ```bash
   envgen flavor add dev
   envgen flavor add prod
   ```

3. Add variables:
   ```bash
   envgen add API_BASE_URL
   envgen add DEBUG_MODE
   ```

4. Set values:
   ```bash
   envgen set API_BASE_URL https://dev.api.com --flavor dev
   envgen set API_BASE_URL https://prod.api.com --flavor prod
   envgen set DEBUG_MODE true --flavor dev
   envgen set DEBUG_MODE false --flavor prod
   ```

5. Generate code:
   ```bash
   envgen generate
   ```

## File Structure

After setup, your project will have:
```
.env.schema          # Schema file with variable keys
.envgen.json         # Config file with flavor list
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
