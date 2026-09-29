-- Bookings that have no matching row in payments.
-- Catches: a payment that failed to record, or a booking created without ever being paid.
SELECT b.id, b.user_id, b.total_price, b.status
FROM bookings b
LEFT JOIN payments p ON p.booking_id = b.id
WHERE p.id IS NULL;
