<?php 

    function select( $conn, $table, $condition = "", $params = [] ) {
        try {
            $sql = "SELECT * FROM $table";

            if(!empty($condition)) {
                $sql .= " " . $condition;
            }

            $stmt = $conn->prepare( $sql );
            $stmt->execute($params);

            return $stmt->fetchAll();
        }
        catch(PDOException $e) {
            die( "Erro ao consultar a tabela $table: " . $e->getMessage() );
        }
    }

?>