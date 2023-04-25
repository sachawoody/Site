<?php

class Utilisateur
{
    private $insert;
    private $select;

    public function __construct($db)
    {
        $this->insert = $db->prepare("INSERT INTO utilisateurs(pseudo_utilisateur, mail_utilisateur, password_utilisateur, id_role) 
                                      VALUES(:pseudo_utilisateur, :mail_utilisateur, :password_utilisateur, :id_role);");
    }

    public function insert($sPseudo, $sMail, $sMdp, $sRole)
    {
        $r = true;
        $this->insert->execute(array(
            ":pseudo_utilisateur" => $sPseudo,
            ":mail_utilisateur" => $sMail,
            ":password_utilisateur" => $sMdp,
            ":id_role" => $sRole,

            // ":description_utilisateur" => ucfirst(strtolower($sPrenom)),
        ));
        if ($this->insert->errorCode() != 0) {
            print_r($this->insert->errorInfo());
            $r = false;
        }
        return $r;
    }

    public function select()
    {
        $this->select->execute();
        if ($this->select->errorCode() != 0) {
            print_r($this->select->errorInfo());
        }
        return $this->select->fetchAll(PDO::FETCH_ASSOC);
    }
}