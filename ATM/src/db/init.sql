-- ============================================================
-- 数据库初始化脚本
-- 使用方法：在 MySQL 中运行本文件即可完成建库、建表、插入测试数据
-- ============================================================

-- 创建数据库（如已存在则删除重建）
DROP DATABASE IF EXISTS db_atm_app;
CREATE DATABASE db_atm_app DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE db_atm_app;

-- ============================================================
-- 1. 账户表
-- ============================================================
DROP TABLE IF EXISTS db_account;
CREATE TABLE db_account (
    cid             INT          PRIMARY KEY AUTO_INCREMENT COMMENT '账户主键ID',
    accountNumber   VARCHAR(20)  NOT NULL UNIQUE             COMMENT '银行卡号(15位数字)',
    password        VARCHAR(20)  DEFAULT '123456'            COMMENT '登录密码',
    money           DOUBLE       DEFAULT 0.0                 COMMENT '账户余额',
    status          INT          DEFAULT 1                   COMMENT '状态(1-正常, 0-冻结)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账户信息表';

-- ============================================================
-- 2. 用户表
-- ============================================================
DROP TABLE IF EXISTS db_user;
CREATE TABLE db_user (
    id              INT          PRIMARY KEY AUTO_INCREMENT COMMENT '用户主键ID',
    username        VARCHAR(50)  NOT NULL                    COMMENT '姓名',
    identityCard    VARCHAR(20)  NOT NULL                    COMMENT '身份证号码',
    gender          VARCHAR(10)                              COMMENT '性别',
    fk_cid          INT                                      COMMENT '外键-关联db_account.cid',
    FOREIGN KEY (fk_cid) REFERENCES db_account(cid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ============================================================
-- 3. 插入原始测试数据（以下数据仅供测试使用）
-- ============================================================

-- 3.1 账户测试数据
INSERT INTO db_account(accountNumber, password, money) VALUES
('621700380001000', '123456', 10000.00),   -- 张三
('621700380001001', '123456', 50000.00),   -- 李四
('621700380001002', '123456', 8888.88),    -- 王五
('621700380001003', '123456', 200000.00),  -- 赵六
('621700380001004', '666666', 1500.50),    -- 孙七
('621700380001005', '123456', 99999.99),   -- 周八
('621700380001006', '123456', 0.00),       -- 吴九（空账户）
('621700380001007', '123456', 350.00);     -- 郑十

-- 3.2 用户测试数据
INSERT INTO db_user(username, identityCard, gender, fk_cid) VALUES
('张三', '110101199001011234', '男', 1),
('李四', '110101199002021235', '女', 2),
('王五', '110101199003031236', '男', 3),
('赵六', '110101199004041237', '女', 4),
('孙七', '110101199005051238', '男', 5),
('周八', '110101199006061239', '女', 6),
('吴九', '110101199007071230', '男', 7),
('郑十', '110101199008081231', '女', 8);
