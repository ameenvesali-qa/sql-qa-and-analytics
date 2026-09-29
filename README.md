# SQL for QA and Analytics

![SQL Checks](https://github.com/ameenvesali-qa/sql-qa-and-analytics/actions/workflows/sql-checks.yml/badge.svg)

A PostgreSQL schema with deliberately messy seed data, and a set of queries written from a QA engineer's point of view: the kind of checks you'd run to find bad data before it becomes a bug report. The domain (users booking things and paying for them) is invented for practice and isn't based on any real company's data or schema.

## Schema

Three tables, defined in `schema.sql`:

- **users** — id, email, full_name, created_at
- **bookings** — id, user_id (→ users), checkin, checkout, total_price, status, created_at
- **payments** — id, booking_id (→ bookings), amount, paid_at, transaction_ref

The schema intentionally has no `UNIQUE` or `CHECK` constraints, so bad data (like a duplicate email or an impossible date range) can actually get inserted, and the queries below have something real to catch.

## Seed data

`seed.sql` loads a few clean rows, plus specific planted problems for the QA checks to find:

- a booking with no matching payment
- a duplicate user email
- a payment amount that doesn't match its booking's total price
- a booking where the checkout date is before the checkin date

## QA data-quality checks (`qa-checks/`)

| File | What it catches |
|---|---|
| `01-orphaned-bookings.sql` | Bookings with no matching payment |
| `02-email-duplication.sql` | Emails that appear more than once in `users` |
| `03-payment-mismatch.sql` | Payments whose amount doesn't match the booking's total price |
| `04-impossible-booking-date.sql` | Bookings where checkout is before checkin |

Each file is a self-contained query you can run on its own.

## Running it locally

Requires PostgreSQL.

```
createdb qa_practice
psql qa_practice -f schema.sql
psql qa_practice -f seed.sql

# run one check
psql qa_practice -f qa-checks/01-orphaned-bookings.sql

# run all checks
for f in qa-checks/*.sql; do psql qa_practice -f "$f"; done
```

## CI

GitHub Actions spins up a throwaway PostgreSQL container on every push and pull request to `main`, loads the schema and seed data into it, and runs every query in `qa-checks/`. This confirms the SQL is valid and runs cleanly against fresh data; it does not assert expected results, so a query's actual output is still checked by reading it.

## Tools

PostgreSQL, SQL, GitHub Actions, Git and GitHub
