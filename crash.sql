use test;

DROP TABLE IF EXISTS SomeTable;
CREATE TABLE `SomeTable` (
	`Id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	INDEX `Index 1` (`Id`)
)
ENGINE=InnoDB
;

INSERT INTO `SomeTable` (`Id`) VALUES (1);


SET @id = 1;
SELECT S.Id FROM (
		SELECT m.Id FROM SomeTable m
	WHERE @id IN (0, m.Id)
	GROUP BY m.Id -- CRASH !!!!
) AS M
INNER JOIN (
	SELECT s.Id FROM SomeTable s
	WHERE @id IN (0, s.Id) -- CRASH !!!!
) AS S
ON S.Id = M.Id