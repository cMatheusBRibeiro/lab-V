CREATE DATABASE IF NOT EXISTS blog;
USE blog;

CREATE USER IF NOT EXISTS 'usuario'@'localhost' IDENTIFIED BY 'usuario';
GRANT ALL PRIVILEGES ON blog.* TO 'usuario'@'localhost';

CREATE TABLE IF NOT EXISTS usuario (
    USR_ID INT NOT NULL AUTO_INCREMENT,
    USR_LOGIN VARCHAR(60) NOT NULL,
    USR_SENHA VARCHAR(100) NOT NULL,
    USR_NOME VARCHAR(60) NOT NULL,
    USR_ATIVO INT(1) NOT NULL DEFAULT 1,
    
    CONSTRAINT PK_USR_USR_ID
        PRIMARY KEY (USR_ID),
    CONSTRAINT UNQ_USR_USR_LOGIN
        UNIQUE(USR_LOGIN)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS historico_senha (
    HIST_SENHA_ID INT NOT NULL AUTO_INCREMENT,
    USR_ID INT NOT NULL,
    SENHA_ANTIGA VARCHAR(100) NOT NULL,
    DATA_ALTERACAO DATETIME NOT NULL,

    CONSTRAINT PK_HIST_SENHA_HS_ID
        PRIMARY KEY (HIST_SENHA_ID),
    CONSTRAINT FK_HIST_SENHA_USR_ID
        FOREIGN KEY (USR_ID)
        REFERENCES usuario (USR_ID)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS publicacao (
    PUB_ID INT NOT NULL AUTO_INCREMENT,
    USR_ID INT NOT NULL,
    PUB_TITULO VARCHAR(50) NOT NULL,
    PUB_CONTEUDO TEXT NOT NULL,
    PUB_ATIVO INT(1) NOT NULL,

    CONSTRAINT PK_PUB_PUB_ID
        PRIMARY KEY (PUB_ID),
    CONSTRAINT FK_PUB_USR_ID
        FOREIGN KEY (USR_ID)
        REFERENCES usuario (USR_ID)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tag (
    TAG_ID INT NOT NULL AUTO_INCREMENT,
    USR_ID INT NOT NULL,
    TAG_NOME VARCHAR(50) NOT NULL,
    TAG_ATIVO INT(1) NOT NULL,

    CONSTRAINT PK_TAG_TAG_ID
        PRIMARY KEY (TAG_ID),
    CONSTRAINT FK_TAG_USR_ID
        FOREIGN KEY (USR_ID)
        REFERENCES usuario (USR_ID)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tagpub (
    TAG_ID INT NOT NULL,
    PUB_ID INT NOT NULL,

    CONSTRAINT PK_TAGPUB_TAG_PUB_ID
        PRIMARY KEY (TAG_ID, PUB_ID),
    CONSTRAINT FK_TAGPUB_TAG_ID
        FOREIGN KEY (TAG_ID)
        REFERENCES tag (TAG_ID),
    CONSTRAINT FK_TAGPUB_PUB_ID
        FOREIGN KEY (PUB_ID)
        REFERENCES publicacao (PUB_ID)
)ENGINE=INNODB;