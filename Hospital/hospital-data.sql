# Hospital Data

INSERT INTO room VALUES 
(1, 100, 1),
(2, 100, 1),
(3, 100, 2),
(4, 100, 2),
(5, 100, 5);

INSERT INTO patient VALUES 
(1, 'Josh', 'Reddick', '123 Avenue Lane', '(757)-692-7505', 1, 3),
(2, 'Jane', 'Doe', '321 Lane Boulevard', '(234)-345-76322', 2, 5),
(3, 'John', 'Roe', '364 Road Lane', '(863)-234-2342', 3, 6),
(4, 'Jack', 'Moe', '963 Street Road', '(345)-324-6842', 4, 1),
(5, 'Jill', 'Woe', '963 Circle Avenue', '(945)-447-2475', 4, 1);

INSERT INTO physician VALUES
(1, 'Neurology', '667565', 'Bob', 'Taylor', '556 Mickey Street', '(919)378-8592'),
(2, 'Anesthesiology', '225456', 'Jene', 'Oscars', '28 Apple Bloom Road', '(780)654-5896'),
(3, 'Dermatology', '123456', 'Dave', 'Chappelle', '5102 Dorris Lane', '(916)856-4785'),
(4, 'Medical genetics', '778455', 'Robin', 'Williams', '72 Davenport Road', '(919)785-6661'),
(5, 'Emergency medicine', '542154', 'Sarah', 'Jenkins', '8452 Crenshaw Avenue', '(910)656-7581');

INSERT INTO nurse VALUES 
(99, '999999', 'George', 'Washington', '111 President Way', '(338)-238-4823'),
(98, '999998', 'Napolean', 'Bonaparte', '456 France Avenue', '(283)-281-3485'),
(97, '999997', 'Isaac', 'Newton', '395 Apple Street', '(287)-234-4583'),
(96, '999996', 'Pablo', 'Picasso', '689 Paint Road', '(953)-284-2848'),
(95, '999995', 'Winston', 'Churchill', '948 United Circle', '(109)-482-4858');

INSERT INTO medication VALUES
(50, 1, 99, '3 MG'),
(51, 2, 98, '5 MG'),
(52, 3, 97, '100 MG'),
(53, 4, 96, '5 MG'),
(54, 5, 95, '3 MG');

INSERT INTO healthRecord VALUES
(1, 'Skin Cancer', '2023-04-12', 'Finalized', 'Patient is in remission.'),
(2, 'Kidney Disease', '2023-04-10', 'Finalized', 'Left kidney was removed.'),
(3, 'Covid-19', '2023-05-10', 'Active', 'Patient tested positive for Covid-19. Needed back for further testing in 2 weeks.'),
(4, 'Aids', '2023-05-16', 'Finalized', 'Patient testest positive for advanced aids. Patient is terminal.'),
(5, 'Brain tumor', '2023-05-14', 'Active', 'MRI found brain tumor. Further examination and surgery needed.');

INSERT INTO instructions VALUES
(1, 300, 'Administer IV Fluid', 'Ready', '2023-01-21', '2023-01-20', 1, 99),
(2, 15000, 'Remove Cancer Cells', 'Not Ready', NULL, '2022-08-13', 2, 98),
(3, 32000, 'Kidney Removal', 'Ready', '2023-04-10', '2023-04-02', 3, 97),
(4, 1200, 'MRI', 'Ready', '2023-03-21', '2023-03-20', 4, 96),
(5, 500, 'COVID Cure', 'Not Ready', NULL, '2020-03-12', 5, 95);

INSERT INTO monitors VALUES
(1, 3, '2023-05-1', NULL),
(2, 1, '2023-04-2', '2023-04-12'),
(3, 5, '2023-05-13', NULL),
(4, 2, '2023-03-29', '2023-04-10'),
(5, 4, '2023-05-12', '2023-05-15');

INSERT INTO invoice VALUES
(1, '2023-05-10', 10000, '4', 1, 1, 1),
(2, '2023-05-12', 3600, '10', 2, 2, 2),
(3, '2023-05-14', 1200, '4', 3, 3, 3),
(4, '2023-05-16', 50000, '4', 4, 4, 4),
(5, '2023-05-18', 4000, '4', 5, 4, 5);

INSERT INTO give_Meds VALUES 
(1, 99, 3),
(2, 98, 5),
(3, 97, 4),
(4, 96, 10),
(5, 95, 20);



