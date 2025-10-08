{ ... }:

{
  imports = [ ../default.nix ];

  go-task = {
    enable = true;
    taskfile = "Taskfile.yml";

    settings = {
      version = "3";
      vars = {
        GREETING = "Hello World from Task!";
        BUILD_DIR = "dist";
      };
      env = {
        CGO_ENABLED = "0";
      };
      output = "prefixed";
    };

    tasks = {
      default = {
        desc = "Default task - runs hello";
        deps = [ "hello" ];
        silent = true;
      };

      hello = {
        desc = "Say hello";
        cmds = [ "echo '{{.GREETING}}'" ];
        silent = true;
      };

      build = {
        desc = "Build the project";
        cmds = [
          "echo 'Building project...'"
          "mkdir -p {{.BUILD_DIR}}"
          "go build -v -o {{.BUILD_DIR}}/app ./cmd/app"
          "echo 'Build complete!'"
        ];
        sources = [
          "**/*.go"
          "go.mod"
          "go.sum"
        ];
        generates = [ "{{.BUILD_DIR}}/app" ];
        env = {
          GOOS = "linux";
          GOARCH = "amd64";
        };
        preconditions = [
          {
            sh = "test -f go.mod";
            msg = "go.mod file not found. Run 'go mod init' first.";
          }
        ];
      };

      test = {
        desc = "Run tests";
        cmds = [
          "echo 'Running tests...'"
          "go test -v ./..."
        ];
        deps = [ "build" ];
        vars = {
          TEST_TIMEOUT = "30s";
        };
      };

      test-coverage = {
        desc = "Run tests with coverage";
        cmds = [
          "go test -v -race -coverprofile=coverage.out ./..."
          "go tool cover -html=coverage.out -o coverage.html"
          "echo 'Coverage report generated: coverage.html'"
        ];
        generates = [
          "coverage.out"
          "coverage.html"
        ];
      };

      clean = {
        desc = "Clean build artifacts";
        cmds = [
          "rm -rf {{.BUILD_DIR}}"
          "rm -f coverage.out coverage.html"
          "echo 'Clean complete!'"
        ];
      };

      dev = {
        desc = "Start development server";
        cmds = [
          "echo 'Starting development server on port {{.PORT}}...'"
          "go run ./cmd/app"
        ];
        deps = [ "build" ];
        vars = {
          PORT = "8080";
        };
        env = {
          GO_ENV = "development";
          LOG_LEVEL = "debug";
        };
        dir = "./cmd/app";
      };

      lint = {
        desc = "Run linter";
        cmds = [ "golangci-lint run" ];
        sources = [ "**/*.go" ];
      };

      format = {
        desc = "Format code";
        cmds = [
          "go fmt ./..."
          "goimports -w ."
        ];
        sources = [ "**/*.go" ];
      };
    };
  };
  enterShell = ''
    echo "Welcome to the devenv-go-task example!"
    echo "Available tasks:"
    task --list
  '';
}
