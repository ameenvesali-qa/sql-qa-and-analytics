-- Catches: bookings where checkout is before checkin​

SELECT id, checkin, checkout
FROM bookings
WHERE checkout < checkin;
