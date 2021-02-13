<?php
    include "weather.php";
    $resp = connectToURL("https://www.mgm.gov.tr/FTPDATA/analiz/SonDurumlarTumu.xml");
    $data = simplexml_load_string($resp);
    $province = "ANTALYA";
    $country = "MURATPASA";
    foreach($data->Merkezler as $val){
        if($val->ili == $province && $val->ilcesi == $country){
            $tmp = $val->tmp;
            $tmp = str_replace(",", ".", $tmp);
            $tmp = floatval($tmp);

            $nem = $val->nem;
            $nem = str_replace(",", ".", $nem);
            $nem = floatval($nem);

            $press = $val->press;
            $press = str_replace(",", ".", $press);
            $press = floatval($press);

            $ws = $val->ws;
            $ws = str_replace(",", ".", $ws);
            $ws = floatval($ws);

            $state = (string)$val->Durum;
         
            $vals = array(
                "state" => $state,
                "tmp" => $tmp,
                "nem" => $nem,
                "press" => $press,
                "ws" =>  $ws,
                "wd" => (int) $val->wd
            );
            break;
        }
    }

    echo json_encode($vals, JSON_UNESCAPED_UNICODE);
?>