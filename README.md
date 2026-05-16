# Rails Pizza Challenge

A Rails 8.1 pizza order management application with order review, customization, promotions, and discounts.

## Implementation Details (PLEASE READ THEM FIRST)

See [SOLUTION.md](./SOLUTION.md) for detailed architectural decisions, service patterns, and personal explanation.

## Quick Start

### Prerequisites

- Ruby (managed via `rvm` or `rbenv`)
- Node.js and npm
- SQLite3

### Setup

```bash
bin/setup --skip-server
```

This installs dependencies, creates the database, and loads seed data (10 randomized pizza orders with the full catalog).

### Run Locally

```bash
bin/dev
```

Starts the Rails server on `http://localhost:3000`. The app opens to the order review page showing all open orders.

## Usage

- **View orders:** Navigate to `/orders` or `/` to see all open orders with pizzas and customizations.
- **Complete an order:** Click the "Complete" button on any order to mark it as completed and remove it from the list.
- **Seed data:** The app includes 10 pre-generated orders with various pizzas, sizes, and ingredient customizations.

## Testing

### Run all tests

```bash
bin/rails test
```

### Run a specific test file

```bash
bin/rails test test/models/order_test.rb
```

### Run a test at a specific line

```bash
bin/rails test test/controllers/orders_controller_test.rb:17
```

### Refresh seed data in test environment

```bash
env RAILS_ENV=test bin/rails db:seed:replant
```

## Linting & Quality

### Lint all Ruby code

```bash
bin/rubocop
```

### Run full CI pipeline (what runs on push)

```bash
bin/ci
```

This runs setup, linters (`rubocop`, `bundler-audit`, `brakeman`), and the full test suite.

## Development Notes

- The app has **no JavaScript build pipeline**; Hotwire is configured via importmap.
- Use `bin/setup --skip-server` to avoid starting the dev server during setup.

## License

MIT
