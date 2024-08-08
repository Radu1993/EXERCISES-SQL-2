

CREATE TABLE Hackers (hacker_id NUMBER(1) PRIMARY KEY,

  name VARCHAR2(5));

CREATE TABLE Submissions (submission_id NUMBER(3) PRIMARY KEY,

  hacker_id NUMBER(1),

  challenge_id NUMBER(1),

  score NUMBER(2));

INSERT INTO Hackers VALUES (1, ‘John’);

INSERT INTO Hackers VALUES (2, ‘Jane’);

INSERT INTO Hackers VALUES (3, ‘Joe’);

INSERT INTO Hackers VALUES (4, ‘Jim’);

INSERT INTO Submissions VALUES (101, 1, 1, 10);

INSERT INTO Submissions VALUES (102, 1, 1, 12);

INSERT INTO Submissions VALUES (103, 2, 1, 11);

INSERT INTO Submissions VALUES (104, 2, 1, 9);

INSERT INTO Submissions VALUES (105, 2, 2, 13);

INSERT INTO Submissions VALUES (106, 3, 1, 9);

INSERT INTO Submissions VALUES (107, 3, 2, 12);

INSERT INTO Submissions VALUES (108, 3, 2, 15);

INSERT INTO Submissions VALUES (109, 4, 1, 0);


SELECT 
    h.name,
    SUM(s.max_score) AS total_max_score
FROM 
    Hackers h
JOIN 
    (SELECT 
        hacker_id, 
        challenge_id, 
        MAX(score) AS max_score
     FROM 
        Submissions
     GROUP BY 
        hacker_id, challenge_id
    ) s
ON 
    h.hacker_id = s.hacker_id
GROUP BY 
    h.name
HAVING 
    SUM(s.max_score) > 0
ORDER BY 
    total_max_score DESC, 
    h.name;
    
    
    CREATE TABLE Tranzactions (
    sender NUMBER(1),
    receiver NUMBER(1),
    amount NUMBER(2)
);

INSERT INTO Tranzactions VALUES (5, 2, 10);
INSERT INTO Tranzactions VALUES (1, 3, 15);
INSERT INTO Tranzactions VALUES (2, 1, 20);
INSERT INTO Tranzactions VALUES (2, 3, 25);
INSERT INTO Tranzactions VALUES (3, 1, 20);
INSERT INTO Tranzactions VALUES (3, 2, 15);
INSERT INTO Tranzactions VALUES (1, 4, 5);
    
    
    SELECT
    user_id AS utilizator,
    COALESCE(SUM(received) - SUM(sent), 0) AS diferenta_avere
FROM (
    SELECT
        sender AS user_id,
        SUM(amount) AS sent,
        0 AS received
    FROM
        Tranzactions
    GROUP BY
        sender
    UNION ALL
    SELECT
        receiver AS user_id,
        0 AS sent,
        SUM(amount) AS received
    FROM
        Tranzactions
    GROUP BY
        receiver
) AS combined
GROUP BY
    user_id
ORDER BY
    diferenta_avere DESC, user_id;