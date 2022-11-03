DELIMITER $$

USE `database`$$

DROP FUNCTION IF EXISTS `CRC16`$$

CREATE FUNCTION `CRC16`(_STRING VARCHAR(255)) RETURNS INT(11)
    DETERMINISTIC
BEGIN
    DECLARE _CRC INT;
    DECLARE _ord INT;
    DECLARE _n INT;
    DECLARE _x INT;
    DECLARE _strlend INT;
    SET _CRC := 0xffff;

    IF (_STRING IS NULL) THEN
       RETURN NULL;
    END IF;

    SET _n  := 1;  
    SET _strlend := LENGTH(_STRING) ;
          
    loop_crc:  LOOP

       IF  _n > _strlend THEN 
         LEAVE  loop_crc;
       END  IF;

       SET _ord := ORD(SUBSTRING(_STRING, _n, 1) );
       SET _x := ((_CRC>>8) ^ _ord) & 0xff;
       SET _x := _x ^ (_x>>4);       
       SET _CRC := ((_CRC<<8) ^ (_x<<12) ^ (_x<<5) ^ _x) & 0xffff;
       SET  _n := _n + 1;
     END LOOP;
   RETURN _CRC; 

 END$$

DELIMITER ;
