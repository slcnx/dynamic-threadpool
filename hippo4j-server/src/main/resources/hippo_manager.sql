CREATE DATABASE /*!32312 IF NOT EXISTS*/ `hippo_manager` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `hippo_manager`;

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = tenant   */
/******************************************/
DROP TABLE IF EXISTS `tenant`, `tenant_info`;
CREATE TABLE `tenant` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) DEFAULT NULL COMMENT '租户ID',
  `tenant_name` varchar(128) DEFAULT NULL COMMENT '租户名称',
  `tenant_desc` varchar(256) DEFAULT NULL COMMENT '租户介绍',
  `owner` varchar(32) DEFAULT '-' COMMENT '负责人',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `uk_tenantinfo_tenantid` (`tenant_id`,`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='租户表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = item   */
/******************************************/
DROP TABLE IF EXISTS `item`, `item_info`;
CREATE TABLE `item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) DEFAULT NULL COMMENT '租户ID',
  `item_id` varchar(128) DEFAULT NULL COMMENT '项目ID',
  `item_name` varchar(128) DEFAULT NULL COMMENT '项目名称',
  `item_desc` varchar(256) DEFAULT NULL COMMENT '项目介绍',
  `owner` varchar(32) DEFAULT NULL COMMENT '负责人',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_iteminfo_tenantitem` (`tenant_id`,`item_id`,`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='项目表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = config   */
/******************************************/
DROP TABLE IF EXISTS `config`, `config_info`;
CREATE TABLE `config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) DEFAULT NULL COMMENT '租户ID',
  `item_id` varchar(256) DEFAULT NULL COMMENT '项目ID',
  `tp_id` varchar(56) DEFAULT NULL COMMENT '线程池ID',
  `tp_name` varchar(56) DEFAULT NULL COMMENT '线程池名称',
  `core_size` int(11) DEFAULT NULL COMMENT '核心线程数',
  `max_size` int(11) DEFAULT NULL COMMENT '最大线程数',
  `queue_type` int(11) DEFAULT NULL COMMENT '队列类型...',
  `capacity` int(11) DEFAULT NULL COMMENT '队列大小',
  `rejected_type` int(11) DEFAULT NULL COMMENT '拒绝策略',
  `keep_alive_time` int(11) DEFAULT NULL COMMENT '线程存活时间',
  `content` longtext COMMENT '线程池内容',
  `md5` varchar(32) NOT NULL COMMENT 'MD5',
  `is_alarm` tinyint(1) DEFAULT NULL COMMENT '是否报警 0：报警 1:不报警',
  `capacity_alarm` int(11) DEFAULT NULL COMMENT '容量报警',
  `liveness_alarm` int(11) DEFAULT NULL COMMENT '活跃度报警',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`tenant_id`,`item_id`,`tp_id`,`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='线程池配置表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = log_record_info   */
/******************************************/
DROP TABLE IF EXISTS `log_record_info`;
CREATE TABLE `log_record_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant` varchar(128) NOT NULL DEFAULT '' COMMENT '租户标识',
  `biz_key` varchar(128) NOT NULL DEFAULT '' COMMENT '日志业务标识',
  `biz_no` varchar(128) NOT NULL DEFAULT '' COMMENT '业务码标识',
  `operator` varchar(64) NOT NULL DEFAULT '' COMMENT '操作人',
  `action` varchar(128) NOT NULL DEFAULT '' COMMENT '动作',
  `category` varchar(128) NOT NULL DEFAULT '' COMMENT '种类',
  `detail` varchar(2048) NOT NULL DEFAULT '' COMMENT '修改的详细信息，可以为json',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_biz_key` (`biz_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = user   */
/******************************************/
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `user_name` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(512) NOT NULL COMMENT '用户密码',
  `role` varchar(50) NOT NULL COMMENT '角色',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = role   */
/******************************************/
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `role` varchar(64) NOT NULL COMMENT '角色',
  `user_name` varchar(64) NOT NULL COMMENT '用户名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = permission   */
/******************************************/
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `role` varchar(512) NOT NULL COMMENT '角色',
  `resource` varchar(512) NOT NULL COMMENT '资源',
  `action` varchar(8) NOT NULL COMMENT '读写权限',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

/******************************************/
/*   数据库全名 = hippo_manager   */
/*   表名称 = notify   */
/******************************************/
DROP TABLE IF EXISTS `alarm`, `notify`;
CREATE TABLE `notify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` varchar(128) NOT NULL DEFAULT '' COMMENT '租户ID',
  `item_id` varchar(128) NOT NULL COMMENT '项目ID',
  `tp_id` varchar(128) NOT NULL COMMENT '线程池ID',
  `platform` varchar(32) NOT NULL COMMENT '通知平台',
  `type` varchar(32) NOT NULL COMMENT '通知类型',
  `secret_key` varchar(256) NOT NULL COMMENT '密钥',
  `interval` int(11) DEFAULT NULL COMMENT '报警间隔',
  `receives` varchar(512) NOT NULL COMMENT '接收者',
  `enable` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notify_biz_key` (`tenant_id`,`item_id`,`tp_id`,`platform`,`type`,`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知表';

/* 租户 */
INSERT INTO `tenant` (`id`, `tenant_id`, `tenant_name`, `tenant_desc`, `owner`, `gmt_create`, `gmt_modified`, `del_flag`) VALUES ('1', 'prescription', '处方组', '负责维护处方服务, 包括不限于电子处方等业务', '谢良辰', '2021-10-24 13:42:11', '2021-10-24 13:42:11', '0');

/* 项目 */
INSERT INTO `item` (`id`, `tenant_id`, `item_id`, `item_name`, `item_desc`, `owner`, `gmt_create`, `gmt_modified`, `del_flag`) VALUES ('1', 'prescription', 'dynamic-threadpool-example', '动态线程池示例项目', '动态线程池示例项目，对应 Hippo 项目的 example 模块', '马称', '2021-10-24 16:11:00', '2021-10-24 16:11:00', '0');

/* 线程池 */
INSERT INTO `config` (`id`, `tenant_id`, `item_id`, `tp_id`, `tp_name`, `core_size`, `max_size`, `queue_type`, `capacity`, `rejected_type`, `keep_alive_time`, `content`, `md5`, `is_alarm`, `capacity_alarm`, `liveness_alarm`, `gmt_create`, `gmt_modified`, `del_flag`) VALUES ('1', 'prescription', 'dynamic-threadpool-example', 'message-consume', '示例消费者线程池', '1', '5', '9', '1024', '2', '90', '{\"capacity\":1024,\"capacityAlarm\":80,\"coreSize\":1,\"isAlarm\":0,\"itemId\":\"dynamic-threadpool-example\",\"keepAliveTime\":90,\"livenessAlarm\":80,\"maxSize\":5,\"queueType\":9,\"tenantId\":\"prescription\",\"tpId\":\"message-consume\"}', '548564177fd601015e19ef6df42000d1', '0', '80', '80', '2021-10-24 16:12:16', '2021-10-24 16:12:16', '0'),
('2', 'prescription', 'dynamic-threadpool-example', 'message-produce', '示例生产者线程池', '1', '5', '9', '100', '1', '10', '{\"capacity\":100,\"capacityAlarm\":30,\"coreSize\":10,\"isAlarm\":0,\"itemId\":\"dynamic-threadpool-example\",\"keepAliveTime\":10,\"livenessAlarm\":30,\"maxSize\":15,\"queueType\":9,\"rejectedType\":7,\"tenantId\":\"prescription\",\"tpId\":\"message-produce\"}', 'edd6677f6ca35ce2c2e06db5749572c8', '0', '30', '30', '2021-10-24 16:12:56', '2021-10-28 09:49:27', '0');

/* 用户 */
INSERT INTO `user` (`id`, `user_name`, `password`, `role`, `gmt_create`, `gmt_modified`, `del_flag`) VALUES ('1', 'admin', '$2a$10$2KCqRbra0Yn2TwvkZxtfLuWuUP5KyCWsljO/ci5pLD27pqR3TV1vy', 'ROLE_ADMIN', '2021-11-04 21:35:17', '2021-11-15 23:04:59', '0');

/* 通知表 */
INSERT INTO `notify` (`id`, `tenant_id`, `item_id`, `tp_id`, `platform`, `type`, `secret_key`, `interval`, `receives`, `enable`, `gmt_create`, `gmt_modified`, `del_flag`) VALUES ('1461345908531671042', 'prescription', 'dynamic-threadpool-example', 'message-produce', 'DING', 'CONFIG', '4a582a588a161d6e3a1bd1de7eea9ee9f562cdfcbe56b6e72029e7fd512b2eae', NULL, '15601166691', '0', '2021-11-18 22:49:50', '2021-11-18 22:49:50', '0'),
('1461345976047382530', 'prescription', 'dynamic-threadpool-example', 'message-produce', 'DING', 'ALARM', '4a582a588a161d6e3a1bd1de7eea9ee9f562cdfcbe56b6e72029e7fd512b2eae', '30', '15601166691', '0', '2021-11-18 22:50:06', '2021-11-18 22:50:06', '0');
