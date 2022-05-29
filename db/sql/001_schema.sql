-- ユーザ情報

CREATE TABLE IF NOT EXISTS `user` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `display_name` VARCHAR(20) NOT NULL,
    `mail` VARCHAR(254) NOT NULL,
    `profile` TEXT,
    `user_name` VARCHAR(64) UNIQUE NOT NULL,
    `age` INT(3) NOT NULL,
    `gender` INT(1) NOT NULL,
    `is_ban` BOOLEAN,
    `is_penalty` BOOLEAN,
    `is_admin` BOOLEAN,
    `join_date` TIMESTAMP NOT NULL,
    `avatar_url` TEXT NOT NULL,
    PRIMARY KEY (`id`)
);

-- ユーザの認証情報

CREATE TABLE IF NOT EXISTS `cert` (
    `user_id` INT UNSIGNED NOT NULL,
    `password` BLOB,
    `cateiru_sso_id` BLOB,
    PRIMARY KEY (`user_id`)
);

-- ログイン履歴

CREATE TABLE IF NOT EXISTS `login_history` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    `ip_address` INT(10) UNSIGNED NOT NULL,
    `device_name` VARCHAR(256),
    `os` VARCHAR(256),
    `is_phone` BOOLEAN,
    `is_tablet` BOOLEAN,
    `is_desktop` BOOLEAN,
    `blowser_name` VARCHAR(256),
    `login_date` TIMESTAMP NOT NULL,
    PRIMARY KEY (`id`)
);

-- 通知

CREATE TABLE IF NOT EXISTS `notice` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    `title` VARCHAR(512) NOT NULL,
    `text` TEXT,
    `url` VARCHAR(8190),
    `is_read` BOOLEAN,
    PRIMARY KEY (`id`)
);

-- メール送信履歴

CREATE TABLE IF NOT EXISTS `mail_post_history` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `mail` VARCHAR(254) NOT NULL,
    `user_id` INT UNSIGNED,
    `title` VARCHAR(512) NOT NULL,
    `body` TEXT NOT NULL,
    `body_html` TEXT,
    PRIMARY KEY (`id`)
);

-- ブロックしているユーザ

CREATE TABLE IF NOT EXISTS `block` (
    `user_id` INT UNSIGNED NOT NULL,
    `target_user` INT UNSIGNED NOT NULL
);

-- 報告

CREATE TABLE IF NOT EXISTS `report` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `target_user` INT UNSIGNED NOT NULL,
    `report_user` INT UNSIGNED NOT NULL,
    `reason` TEXT NOT NULL,
    `category` VARCHAR(256),
    PRIMARY KEY (`id`)
);

-- ユーザの数字統計（利用回数）

CREATE TABLE IF NOT EXISTS `number_of` (
    `user_id` INT UNSIGNED UNIQUE NOT NULL,
    `evaluations` MEDIUMINT UNSIGNED,
    `meet` MEDIUMINT UNSIGNED,
    `application` MEDIUMINT UNSIGNED,
    PRIMARY KEY (`user_id`)
);

-- ユーザの評価

CREATE TABLE IF NOT EXISTS `evaluation` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `target_user` INT UNSIGNED NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
);

-- セッショントークン

CREATE TABLE IF NOT EXISTS `session` (
    `session_token` VARCHAR(256) UNIQUE NOT NULL,
    `date` TIMESTAMP NOT NULL,
    `period_date` TIMESTAMP NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`session_token`)
);

-- リフレッシュトークン

CREATE TABLE IF NOT EXISTS `refresh` (
    `refresh_token` VARCHAR(512) UNIQUE NOT NULL,
    `session_token` VARCHAR(256) UNIQUE NOT NULL,
    `date` TIMESTAMP NOT NULL,
    `period_date` TIMESTAMP NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`refresh_token`)
);

-- 投稿エントリ

CREATE TABLE IF NOT EXISTS `entry` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `owner_user_id` INT UNSIGNED NOT NULL,
    `title` VARCHAR(512) NOT NULL,
    `shop_id` INT UNSIGNED NOT NULL,
    `number_of_people` INT UNSIGNED NOT NULL,
    `date` TIMESTAMP NOT NULL,
    `body` TEXT,
    `is_closed` BOOLEAN NOT NULL,
    PRIMARY KEY (`id`)
);

-- 店情報

CREATE TABLE IF NOT EXISTS `shop` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(1024) NOT NULL,
    `brand_name` VARCHAR(1024) NOT NULL,
    `country` VARCHAR(1024) NOT NULL,
    `prefecture` VARCHAR(1024) NOT NULL,
    `municipality` VARCHAR(1024) NOT NULL,
    `address` TEXT NOT NULL,
    `tel` VARCHAR(255) NOT NULL,
    `lat` FLOAT NOT NULL,
    `lon` FLOAT NOT NULL,
    `genres` TEXT,
    `gender` INT(1) NOT NULL,
    `site_url` TEXT NOT NULL,
    `google_map_url` TEXT NOT NULL,
    `hotpepper_id` VARCHAR(1024) NOT NULL,
    PRIMARY KEY (`id`)
);

-- 会うとき

CREATE TABLE IF NOT EXISTS `meet` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `shop_id` INT UNSIGNED NOT NULL,
    `entry_id` INT UNSIGNED NOT NULL,
    `owner_id` INT UNSIGNED NOT NULL,
    `apply_user_id` INT UNSIGNED NOT NULL,
    `meet_date` DATE,
    `approve_date` DATE,
    `meet_place` VARCHAR(1024),
    `is_cancel` BOOLEAN NOT NULL,
    `is_slapstick` BOOLEAN NOT NULL,
    `find_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
);

-- 行くリクエスト

CREATE TABLE IF NOT EXISTS `application` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `shop_id` INT UNSIGNED NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    `entry_id` INT UNSIGNED NOT NULL,
    `body` TEXT,
    `apply_date` TIMESTAMP NOT NULL,
    `is_meeted` BOOLEAN NOT NULL,
    PRIMARY KEY (`id`)
);

-- Banユーザ

CREATE TABLE IF NOT EXISTS `ban` (
    `ip_address` INT(10) UNSIGNED NOT NULL,
    `mail` VARCHAR(254) NOT NULL
);

-- 野良認証のセッション情報

CREATE TABLE IF NOT EXISTS `nora_session` (
    `token` INT UNSIGNED NOT NULL,
    `total_questions` SMALLINT NOT NULL,
    `current_question` SMALLINT NOT NULL,
    `score` INT UNSIGNED NOT NULL,
    `question_ids` TEXT NOT NULL,
    PRIMARY KEY (`token`)
);

-- 野良認証の問題

CREATE TABLE IF NOT EXISTS `nora_question` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `question_title` TEXT NOT NULL,
    `answers` TEXT NOT NULL,
    `current_answer_index` SMALLINT NOT NULL,
    `score` INT NOT NULL,
    PRIMARY KEY (`id`)
);