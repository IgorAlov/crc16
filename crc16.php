function crc16($data) //Implementation of the CRC-16/CCITT-FALSE
{  
   $crc = 0xFFFF;
   for ($i = 0; $ i < strlen($data); $i++) {
     	$x = (($crc>>8) ^ ord($data[$i])) & 0xFF;
     	$x ^= $x>>4;
     	$crc = (($crc<<8) ^ ($x<<12) ^ ($x<<5) ^$x) & 0xFFFF;
   }
	return $crc;
}
