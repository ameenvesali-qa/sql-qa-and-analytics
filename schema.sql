DROP TABLE IF EXISTS payments, bookings, users CASCADE;

CREATE TABLE users (
  id         SERIAL PRIMARY KEY,
  email      TEXT NOT NULL,
  full_name  TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE bookings (
  id          SERIAL PRIMARY KEY,
  user_id     INTEGER NOT NULL REFERENCES users(id),
  checkin     DATE NOT NULL,
  checkout    DATE NOT NULL,
  total_price NUMERIC(10,2) NOT NULL,
  status      TEXT NOT NULL,
  created_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE payments (
  id              SERIAL PRIMARY KEY,
  booking_id      INTEGER NOT NULL REFERENCES bookings(id),
  amount          NUMERIC(10,2) NOT NULL,
  paid_at         TIMESTAMP NOT NULL DEFAULT now(),
  transaction_ref TEXT NOT NULL
);
