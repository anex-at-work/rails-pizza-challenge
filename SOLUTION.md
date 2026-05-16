# SOLUTION.md

## Personal Preferences and High-Level Explanation

This solution is obviously quite far from a typical production-grade codebase, but mostly in the details. I intentionally tried to minimize the amount of functionality provided by RoR out of the box: `SQLite` instead of `Postgres` (though it can be replaced with any other DB), `ActiveSupport::Test` instead of `RSpec`, and so on.

Below is the list of core decisions, explanations of why they were made this way, and possible alternatives.

### Models

I decided to keep the domain model simple and went with only three models, without introducing complex entity relationships. `SQLite` limitations also prevent the usage of some "standard" features. For example, UUIDs should be not generated at the application level, but on the the DB layer. Datatype support is also limited, which is why some functionality is intentionally omitted (such as ENUMs).

1. `Order` — manages orders and is technically the key entity in the application. Relations to discounts and promotions are incorporated directly into the model itself. In a real-world application, these concerns should definitely be separated, which would make them easier to manage, track, and extend with more sophisticated business logic. The final price is calculated on the application level, allowing it to be cached instead of recalculated for every request. Notes about the monetary format are described below.

2. `Pizza` — manages pizzas and their base prices. Some intentionally omitted features (whose complexity can grow infinitely) include:
   - supported pizza sizes,
   - ingredient relations,
   - availability tracking,
   - and similar domain-specific functionality.

3. `OrderPizza` — a classical many-to-many model used to connect `Order` and `Pizza`. For this solution, it is probably slightly overengineered: it stores ingredients in JSON/hash format and also keeps size multipliers to avoid recalculating them repeatedly.

### Monetary Format

I chose the simplest possible approach for price storage: storing values in cents only.

Alternatives I would personally prefer:
- storing values as "nanos" using a structure similar to Google's Money type:
  https://github.com/googleapis/googleapis/blob/master/google/type/money.proto
  which allows handling much more complex monetary cases;
- storing values as `String` and converting/managing them via `BigDecimal`.

For simplicity, precision handling is intentionally omitted.

### Factories vs Fixtures

I personally prefer factories because they provide much more control over models and work especially well with tools like `Faker`, making test setup significantly easier compared to fixtures. A certain level of entropy in generated data also occasionally helps catch edge cases.

In this solution, factories are arguably overcomplicated, but on the other hand, they make model usage and test data much more transparent.

### Services

I went with a classical Service Object approach (close to the DDD definition) for `CalculatePrice` — the core service of the application. It implements a very simplified version of the `Pipeline` pattern (without auto-registration, ordering, rollback actions, etc.).

`ApplyDiscount` and `ApplyPromotions` are simplified implementations of the Strategy/Policy pattern with dependency injection for configuration. This makes them significantly easier to test (see `test/services/apply_promotions_test.rb#31` as an example).

In a real-world application, policy definitions themselves would most likely be stored as externally manageable configuration.

From a personal preference perspective, I generally prefer side-effect-free methods (inspired by functional programming principles), which is why `CalculatePrice` itself does not maintain any internal state besides injected dependencies/configuration.

No state -> easier testing.

### Controllers and Views

RoR has evolved enough to support things like removing elements without requiring a dedicated frontend response. In a real-world application, though, I would probably return a much simpler response (in this case, even an empty `2XX` response would be enough).

Personally, I also prefer using decorators to make the output cleaner and more presentation-oriented, but that is heavily task-specific.