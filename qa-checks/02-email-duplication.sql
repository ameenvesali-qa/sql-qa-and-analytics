-- Emails that appear more than once in the users table.
-- Catches: a duplicate account, or a bug that created a user twice.
SELECT email, COUNT(*) AS times_used
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
