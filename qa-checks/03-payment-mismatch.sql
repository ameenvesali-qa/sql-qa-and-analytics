-- payments that doesnt match the booking price
-- Catches: a mismatch total_price in booking with payment amount.
SELECT b.id, b.total_price, p.amount, (b.total_price - p.amount) AS difference
FROM bookings b
JOIN payments p ON p.booking_id = b.id
WHERE b.total_price != p.amount;
