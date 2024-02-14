USE Prize_Winner;

CREATE TABLE Settlement (
    user_id VARCHAR(255),
    poll_id VARCHAR(255),
    poll_option_id VARCHAR(255),
    amount INT,
    created_dt DATE
);

INSERT INTO Settlement (user_id, poll_id, poll_option_id, amount, created_dt)
VALUES ('id1', 'p1', 'A', 200, '2021-12-01'),
       ('id2', 'p1', 'C', 250, '2021-12-01'),
       ('id3', 'p1', 'A', 200, '2021-12-01'),
       ('id4', 'p1', 'B', 500, '2021-12-01'),
       ('id5', 'p1', 'C', 50, '2021-12-01'),
       ('id6', 'p1', 'D', 500, '2021-12-01'),
       ('id7', 'p1', 'C', 200, '2021-12-01'),
       ('id8', 'p1', 'A', 100, '2021-12-01');

SELECT *
FROM Settlement




SELECT user_id, 
       amount * (SELECT SUM(amount) FROM Settlement )/(SELECT SUM(amount) FROM Settlement WHERE poll_option_id = 'C') AS Returns
FROM Settlement
WHERE poll_option_id = 'C';



WITH c_investments AS (
  SELECT SUM(amount) AS c_total
  FROM Settlement
  WHERE poll_option_id = 'C'
),
total_investments AS (
  SELECT SUM(amount) AS total
  FROM Settlement
  WHERE poll_option_id IN ('A', 'B', 'D')
),
proportions AS (
  SELECT user_id, amount / total AS proportion
  FROM Settlement
  JOIN total_investments ON Settlement.poll_option_id IN ('A', 'B', 'D')
),
c_users AS (
  SELECT user_id, amount / c_investments.c_total AS proportion
  FROM Settlement
  JOIN c_investments ON Settlement.poll_option_id = 'C'
)
SELECT c_users.user_id, ROUND(c_users.proportion * proportions.proportion * total, 0) AS Returns
FROM c_users
JOIN proportions ON c_users.user_id = proportions.user_id
WHERE c_users.user_id IN ('id2', 'id5', 'id7');




