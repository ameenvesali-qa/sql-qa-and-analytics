-- Clean, valid data
INSERT INTO users (email, full_name) VALUES
  ('sara@example.com', 'Sara Ahmadi'),
  ('reza@example.com', 'Reza Karimi'),
  ('lina@example.com', 'Lina Moradi');

INSERT INTO bookings (user_id, checkin, checkout, total_price, status) VALUES
  (1, '2026-10-01', '2026-10-05', 400.00, 'confirmed'),
  (2, '2026-10-10', '2026-10-12', 200.00, 'confirmed');

INSERT INTO payments (booking_id, amount, transaction_ref) VALUES
  (1, 400.00, 'TXN-1001'),
  (2, 200.00, 'TXN-1002');

-- Planted problems, for the data-quality queries

-- 1. Booking with NO matching payment (orphaned booking)
INSERT INTO bookings (user_id, checkin, checkout, total_price, status) VALUES
  (3, '2026-10-15', '2026-10-18', 300.00, 'confirmed');

-- 2. Duplicate email (same person entered twice, or a bug created a duplicate account)
INSERT INTO users (email, full_name) VALUES
  ('sara@example.com', 'Sara A.');

-- 3. Payment amount that does NOT match its booking's total_price
INSERT INTO bookings (user_id, checkin, checkout, total_price, status) VALUES
  (1, '2026-11-01', '2026-11-03', 250.00, 'confirmed');
INSERT INTO payments (booking_id, amount, transaction_ref) VALUES
  (4, 150.00, 'TXN-1003');

-- 4. checkout date BEFORE checkin date (impossible booking)
INSERT INTO bookings (user_id, checkin, checkout, total_price, status) VALUES
  (2, '2026-12-05', '2026-12-01', 100.00, 'confirmed');
