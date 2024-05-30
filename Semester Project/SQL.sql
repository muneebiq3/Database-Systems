create database dms;
use dms;
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL CHECK (Username REGEXP '^[A-Za-z0-9]+$'),
    PIN VARCHAR(4) NOT NULL CHECK (PIN REGEXP '^[0-9]{4}$'), -- 4-digit PIN
    FirstName VARCHAR(50) NOT NULL CHECK (FirstName REGEXP '^[A-Za-z]+$'),
    LastName VARCHAR(50) NOT NULL CHECK (LastName REGEXP '^[A-Za-z]+$'),
    Phone VARCHAR(15) NOT NULL CHECK (Phone REGEXP '^[0-9]{11}$'),
    CNIC VARCHAR(15) UNIQUE NOT NULL CHECK (CNIC REGEXP '^[0-9]{5}-[0-9]{7}-[0-9]$')
);

CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Balance DECIMAL(10, 2) DEFAULT 0.0,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    FromAccountID INT NOT NULL,
    ToAccountID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FromAccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (ToAccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Loan (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    LoanAmount DECIMAL(10, 2) NOT NULL,
    InterestRate FLOAT NOT NULL,
    DueDate DATE NOT NULL,
    Repaid TINYINT(1) NOT NULL DEFAULT 0,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE BankStatement (
    StatementID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    Date DATE NOT NULL,
    Details VARCHAR(255) NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);
-- Insert sample users
INSERT INTO User (Username, PIN, FirstName, LastName, Phone, CNIC)
VALUES
('user1', '1234', 'Ahmed', 'Khan', '03001234567', '35201-1234567-1'),
('user2', '2345', 'Ayesha', 'Bibi', '03112345678', '42201-2345678-2'),
('user3', '3456', 'Ali', 'Hassan', '03211234567', '61101-3456789-3'),
('user4', '4567', 'Fatima', 'Javed', '03331234567', '17301-4567890-4'),
('user5', '5678', 'Zain', 'Malik', '03451234567', '37405-5678901-5'),
('user6', '6789', 'Sara', 'Nawaz', '03561234567', '54303-6789012-6'),
('user7', '7890', 'Usman', 'Iqbal', '03671234567', '33102-7890123-7'),
('user8', '8901', 'Hina', 'Faisal', '03781234567', '42101-8901234-8'),
('user9', '9012', 'Bilal', 'Shahid', '03891234567', '11101-9012345-9'),
('user10', '0123', 'Nadia', 'Kamal', '03901234567', '54102-0123456-0');

-- Insert sample accounts
INSERT INTO Account (UserID, Balance)
VALUES
(1, 1000.00),
(2, 2000.00),
(3, 3000.00),
(4, 4000.00),
(5, 5000.00),
(6, 6000.00),
(7, 7000.00),
(8, 8000.00),
(9, 9000.00),
(10, 10000.00);

-- Insert sample transactions
INSERT INTO Transaction (FromAccountID, ToAccountID, Amount)
VALUES
(1, 2, 100.00),
(2, 3, 200.00),
(3, 4, 300.00),
(4, 5, 400.00),
(5, 6, 500.00),
(6, 7, 600.00),
(7, 8, 700.00),
(8, 9, 800.00),
(9, 10, 900.00),
(10, 1, 1000.00);

-- Insert sample loans
INSERT INTO Loan (AccountID, LoanAmount, InterestRate, DueDate)
VALUES
(1, 5000.00, 5.5, '2025-01-01'),
(2, 6000.00, 5.0, '2025-02-01'),
(3, 7000.00, 4.5, '2025-03-01'),
(4, 8000.00, 4.0, '2025-04-01'),
(5, 9000.00, 3.5, '2025-05-01'),
(6, 10000.00, 3.0, '2025-06-01'),
(7, 11000.00, 2.5, '2025-07-01'),
(8, 12000.00, 2.0, '2025-08-01'),
(9, 13000.00, 1.5, '2025-09-01'),
(10, 14000.00, 1.0, '2025-10-01');

-- Insert sample bank statements
INSERT INTO BankStatement (AccountID, Date, Details)
VALUES
(1, '2024-01-01', 'Opening Balance'),
(2, '2024-01-02', 'Deposit'),
(3, '2024-01-03', 'Withdrawal'),
(4, '2024-01-04', 'Transfer'),
(5, '2024-01-05', 'Loan Disbursed'),
(6, '2024-01-06', 'Interest Credited'),
(7, '2024-01-07', 'ATM Withdrawal'),
(8, '2024-01-08', 'POS Purchase'),
(9, '2024-01-09', 'Fee Charged'),
(10, '2024-01-10', 'Refund');
-- Deposit money into an account
UPDATE Account
SET Balance = Balance + 500.00
WHERE AccountID = 1;

-- Add a bank statement for the deposit
INSERT INTO BankStatement (AccountID, Date, Details)
VALUES (1, NOW(), 'Deposit of 500.00');
-- Withdraw money from an account
UPDATE Account
SET Balance = Balance - 200.00
WHERE AccountID = 2 AND Balance >= 200.00;

-- Add a bank statement for the withdrawal
INSERT INTO BankStatement (AccountID, Date, Details)
VALUES (2, NOW(), 'Withdrawal of 200.00');

-- Transfer money between accounts
UPDATE Account
SET Balance = Balance - 100.00
WHERE AccountID = 3 AND Balance >= 100.00;

UPDATE Account
SET Balance = Balance + 100.00
WHERE AccountID = 4;

-- Add a transaction record for the transfer
INSERT INTO Transaction (FromAccountID, ToAccountID, Amount)
VALUES (3, 4, 100.00);

-- Add bank statements for the transfer
INSERT INTO BankStatement (AccountID, Date, Details)
VALUES (3, NOW(), 'Transfer of 100.00 to Account 4');

INSERT INTO BankStatement (AccountID, Date, Details)
VALUES (4, NOW(), 'Transfer of 100.00 from Account 3');

-- Add a new loan
INSERT INTO Loan (AccountID, LoanAmount, InterestRate, DueDate)
VALUES (1, 2000.00, 5.0, '2025-12-31');

-- Add a bank statement for the loan
INSERT INTO BankStatement (AccountID, Date, Details)
VALUES (1, NOW(), 'Loan of 2000.00 at 5.0% interest');

-- Retrieve bank statements for a specific account
SELECT * FROM BankStatement
WHERE AccountID = 1
ORDER BY Date DESC;

SELECT U.UserID, U.Username, A.AccountID, A.Balance
FROM User U
CROSS JOIN Account A;

SELECT U.UserID, U.Username, A.AccountID, A.Balance
FROM User U
INNER JOIN Account A ON U.UserID = A.UserID;

SELECT *
FROM User
NATURAL JOIN Account;

-- Group Function Commands

-- Total balance across all accounts
SELECT SUM(Balance) AS TotalBalance
FROM Account;

-- Average balance across all accounts
SELECT AVG(Balance) AS AverageBalance
FROM Account;

-- Number of transactions made
SELECT COUNT(*) AS NumberOfTransactions
FROM Transaction;

-- Maximum and minimum balances
SELECT MAX(Balance) AS MaximumBalance, MIN(Balance) AS MinimumBalance
FROM Account;

-- Total loan amount and average interest rate
SELECT SUM(LoanAmount) AS TotalLoanAmount, AVG(InterestRate) AS AverageInterestRate
FROM Loan;

-- Number of users with more than one account
SELECT COUNT(*) AS UsersWithMultipleAccounts
FROM (
    SELECT UserID
    FROM Account
    GROUP BY UserID
    HAVING COUNT(*) > 1
) AS Subquery;

-- Number of transactions for each account
SELECT FromAccountID, COUNT(*) AS NumberOfTransactions
FROM Transaction
GROUP BY FromAccountID;

-- Total amount of money transferred per account
SELECT FromAccountID, SUM(Amount) AS TotalTransferredAmount
FROM Transaction
GROUP BY FromAccountID;

-- Number of loans per account
SELECT AccountID, COUNT(*) AS NumberOfLoans
FROM Loan
GROUP BY AccountID;

-- Total bank statements for each account
SELECT AccountID, COUNT(*) AS TotalStatements
FROM BankStatement
GROUP BY AccountID;



