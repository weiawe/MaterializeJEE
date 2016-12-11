#
# 在Mysql中取消外键约束: 
#
SET FOREIGN_KEY_CHECKS=0;

#----------------------------
# 数据字典 SYS_DATA_DIC
#----------------------------
DROP TABLE IF EXISTS `SYS_DATA_DIC`;
CREATE TABLE `SYS_DATA_DIC` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CATEGORY` varchar(50) DEFAULT NULL COMMENT '数据字典名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '字典值',
  `TRANSLATION` varchar(100) DEFAULT NULL COMMENT '字典值翻译',
  `RANKING` int(11) DEFAULT '0' COMMENT '组内顺序',
  `ACTIVE_FLAG` int(11) DEFAULT '1' COMMENT '是否有效#1:有效;0:无效',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典';

#----------------------------
# 定时任务设置 SYS_QUARTZ_JOB
#----------------------------
DROP TABLE IF EXISTS `SYS_QUARTZ_JOB`;
CREATE TABLE `SYS_QUARTZ_JOB` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `JOB_NAME` varchar(100) DEFAULT NULL COMMENT '任务名称',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `JOB_GROUP` varchar(100) DEFAULT 'default' COMMENT '任务组',
  `JOB_CLASS` varchar(255) DEFAULT NULL COMMENT '任务实现类',
  `JOB_PARAMS` varchar(255) DEFAULT NULL COMMENT '任务参数，格式：A=a,B=b',
  `JOB_STATUS` int(11) DEFAULT '1' COMMENT '任务状态，0-禁用 ;1-启用 ',
  `IS_CONCURRENT` int(11) DEFAULT '0' COMMENT '允许并发执行，0-不允许；1-允许',
  `CRON_EXPRESSION` varchar(30) DEFAULT NULL COMMENT '任务运行时间表达式',
  `PREVIOUS_RUN_TIME` datetime DEFAULT NULL COMMENT '上次运行时间',
  `LAST_RUN_TIME` datetime DEFAULT NULL COMMENT '最后运行时间',
  `NEXT_RUN_TIME` datetime DEFAULT NULL COMMENT '下次运行时间',
  `CREATE_ID` bigint(20) NOT NULL COMMENT '创建者ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务设置';

#----------------------------
# 定时任务日志 SYS_QUARTZ_LOG
#----------------------------
DROP TABLE IF EXISTS `SYS_QUARTZ_LOG`;
CREATE TABLE `SYS_QUARTZ_LOG` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `JOB_ID` bigint(20) DEFAULT NULL COMMENT '任务主键',
  `JOB_NAME` varchar(100) DEFAULT NULL COMMENT '任务名称',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `RESULT_FLAG` int(11) DEFAULT NULL COMMENT '运行结果，0-失败；1-成功',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '结果描述',
  PRIMARY KEY (`ID`),
  KEY `FK_QUARTZ_LOG_JOB` (`JOB_ID`),
  CONSTRAINT `FK_QUARTZ_LOG_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `SYS_QUARTZ_JOB` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务日志';

#
# 国家区域表 SYS_REGION_COUNTRY 
#
DROP TABLE IF EXISTS `SYS_REGION_COUNTRY`;
CREATE TABLE `SYS_REGION_COUNTRY` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '实体ID',
  `CODE` varchar(3) NOT NULL COMMENT '国家代码',
  `PHONE_CODE` varchar(10) NOT NULL COMMENT '电话代码',
  `LOCALE_CODE` varchar(20) NOT NULL COMMENT '国家区域国际化代码',
  `NAME` varchar(50) NOT NULL COMMENT '国家名',
  `ENLISH_NAME` varchar(200) DEFAULT NULL COMMENT '英语名',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '排序',
  `ICON_CLS` varchar(100) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_REGION_NATION_CODE` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='国家区域表';

#
# 全国行政区域表 SYS_REGION_REGION 
#
DROP TABLE IF EXISTS `SYS_REGION_REGION`;
CREATE TABLE `SYS_REGION_REGION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '实体ID',
  `CODE` varchar(50) NOT NULL COMMENT '区域编码',
  `NAME` varchar(50) NOT NULL COMMENT '区域名',
  `ENLISH_NAME` varchar(200) DEFAULT NULL COMMENT '英语名',
  `SHORT_NAME` varchar(200) DEFAULT NULL COMMENT '缩写',
  `FIRST_CHAR` char(1) DEFAULT NULL COMMENT '首字母',
  `ZIP` varchar(100) DEFAULT NULL COMMENT '邮编',
  `LNG` varchar(40) DEFAULT NULL COMMENT '经度',
  `LAT` varchar(40) DEFAULT NULL COMMENT '纬度',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '排序',
  `REGION_TYPE` int(11) DEFAULT '0' COMMENT '区域类型',
  `PARENT_CODE` varchar(50) DEFAULT NULL COMMENT '父区域编码',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父区域',
  `COUNTRY_ID` bigint(20) DEFAULT NULL COMMENT '所属国家',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_REGION_REGION_CODE` (`CODE`),
  KEY `FK_REGION_REGION_COUNTRY` (`COUNTRY_ID`),
  KEY `FK_REGION_REGION_PARENT` (`PARENT_ID`),
  CONSTRAINT `FK_REGION_REGION_COUNTRY` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `SYS_REGION_COUNTRY` (`ID`),
  CONSTRAINT `FK_REGION_REGION_PARENT` FOREIGN KEY (`PARENT_ID`) REFERENCES `SYS_REGION_REGION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政区域表';

#----------------------------
# 公司信息表 SYS_COMPANY
#----------------------------
DROP TABLE IF EXISTS `SYS_COMPANY`;
CREATE TABLE `SYS_COMPANY` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `COMPANY_TYPE` int(11) DEFAULT '1' COMMENT '公司类型：1-总公司/个体； 2-分公司/连锁',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父公司id',
  `COMPANY_ADDRESS` varchar(200) DEFAULT NULL COMMENT '公司地址',
  `COMPANY_TELPHONE` varchar(20) DEFAULT NULL COMMENT '公司电话',
  `COMPANY_FAX` varchar(20) DEFAULT NULL COMMENT '公司传真',
  `COMPANY_POST` varchar(6) DEFAULT NULL COMMENT '公司邮编',
  `ORG_CODE` varchar(11) DEFAULT NULL COMMENT '组织机构',
  `BUSSINESS_LICENCE` varchar(15) DEFAULT NULL COMMENT '营业执照',
  `COMPANY_LINKMAN` varchar(25) DEFAULT NULL COMMENT '联系人',
  `LINKMAN_TELPHONE` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '结果描述',
  `ACTIVE_FLAG` tinyint(1) DEFAULT '1' COMMENT '是否有效#1:有效;0:无效',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_ID` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司信息表';

#----------------------------
# 公司机构表 SYS_ORGANIZATION
#----------------------------
DROP TABLE IF EXISTS `SYS_ORGANIZATION`;
CREATE TABLE `SYS_ORGANIZATION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ORG_CODE` varchar(20) DEFAULT NULL COMMENT '机构代码',
  `ORG_NAME` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `LEVEL` int(11) DEFAULT NULL COMMENT '机构等级，0表示顶层机构',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '所属父机构',
  `COMPANY_ID` bigint(20) DEFAULT NULL COMMENT '公司id',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '结果描述',
  `ACTIVE_FLAG` tinyint(1) DEFAULT '1' COMMENT '是否有效#1:有效;0:无效',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_ID` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `FK_ORGANIZATION_COMPANY` (`COMPANY_ID`),
  CONSTRAINT `FK_ORGANIZATION_COMPANY` FOREIGN KEY (`COMPANY_ID`) REFERENCES `SYS_COMPANY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司机构表';

#----------------------------
# 角色表 SYS_ROLE
#----------------------------
DROP TABLE IF EXISTS `SYS_ROLE`;
CREATE TABLE `SYS_ROLE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_CODE` varchar(20) DEFAULT NULL COMMENT '角色编码',
  `ROLE_NAME` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '结果描述',
  `ACTIVE_FLAG` tinyint(1) DEFAULT '1' COMMENT '是否有效#1:有效;0:无效',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_ID` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

#----------------------------
# 菜单表 SYS_RESOURCE
#----------------------------
DROP TABLE IF EXISTS `SYS_RESOURCE`;
CREATE TABLE `SYS_RESOURCE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '资源名称',
  `TYPE` int(11) DEFAULT NULL COMMENT '类型：0-url ; 1-method',
  `IS_DIRECTORY` int(11) DEFAULT NULL COMMENT '菜单是否为目录，0-页面;1-目录',
  `VALUE` varchar(255) DEFAULT NULL COMMENT '资源值',
  `ICON` varchar(100) DEFAULT NULL COMMENT '图标',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '所属父资源',
  `ORDERS` int(11) DEFAULT NULL COMMENT '排序',
  `LEVEL` int(11) DEFAULT NULL COMMENT '层级',
  `DESCN` varchar(255) DEFAULT NULL COMMENT '描述',
  `ACTIVE_FLAG` tinyint(1) DEFAULT '1' COMMENT '是否有效#1:有效;0:无效',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_ID` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表（menu、action等）';

#----------------------------
# 角色资源权限表 SYS_ROLE_RESOURCE
#----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_RESOURCE`;
CREATE TABLE `SYS_ROLE_RESOURCE` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `RESOURCE_ID` bigint(20) DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`ID`),
  KEY `FK_ROLE_RESOURCE_ROLE` (`ROLE_ID`),
  KEY `FK_ROLE_RESOURCE_RESOURCE` (`RESOURCE_ID`),
  CONSTRAINT `FK_ROLE_RESOURCE_RESOURCE` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `SYS_RESOURCE` (`ID`),
  CONSTRAINT `FK_ROLE_RESOURCE_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源权限表';

#----------------------------
# 系统登录用户 SYS_USER
#----------------------------
DROP TABLE IF EXISTS `SYS_USER`;
CREATE TABLE `SYS_USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '用户ID',
  `PASSWORD` varchar(512) DEFAULT NULL COMMENT '密码',
  `NIKE_NAME` varchar(100) DEFAULT NULL COMMENT '用户昵称',
  `REAL_NAME` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `SEX` char(1) DEFAULT NULL COMMENT '性别，W-女；M-男；',
  `AVATAR` varchar(512) DEFAULT NULL COMMENT '头像路径',
  `TEL_PHONE` varchar(18) DEFAULT NULL COMMENT '联系电话',
  `PHONE` varchar(11) DEFAULT NULL COMMENT '手机',
  `EMAIL` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `COMPANY_ID` bigint(20) DEFAULT NULL COMMENT '公司id',
  `USER_TYPE` int(11) DEFAULT NULL COMMENT '用户类型：1-注册用户;2-正式会员;3-内部员工',
  `REF_ID` bigint(20) DEFAULT NULL COMMENT '引用用户业务表ID',
  `IS_ENABLED` tinyint(1) DEFAULT '1' COMMENT '状态，0-禁用；1-正常；',
  `IS_LOCK` int(11) DEFAULT '0' COMMENT '是否锁定，0-否；1-是',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统登录用户';

#----------------------------
# 用户登录历史表 SYS_USER_LOGIN_HISTORY
#----------------------------
DROP TABLE IF EXISTS `SYS_USER_LOGIN_HISTORY`;
CREATE TABLE `SYS_USER_LOGIN_HISTORY` (
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `LOGIN_IP` varchar(38) DEFAULT NULL COMMENT '登录IP',
  `SESSION_ID` varchar(32) DEFAULT NULL COMMENT 'session ID',
  `LOGIN_TIME` datetime DEFAULT NULL COMMENT '登录时间',
  KEY `FK_LOGIN_HISTORY_USER` (`USER_ID`),
  CONSTRAINT `FK_LOGIN_HISTORY_USER` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录历史表';

#----------------------------
# 用户角色映射表 SYS_USER_ROLE
#----------------------------
DROP TABLE IF EXISTS `SYS_USER_ROLE`;
CREATE TABLE `SYS_USER_ROLE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY `FK_USER_ROLE_USER` (`USER_ID`),
  KEY `FK_USER_ROLE_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_USER_ROLE_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`),
  CONSTRAINT `FK_USER_ROLE_USER` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色映射表';

#----------------------------
# 用户机构映射表 SYS_USER_ORGANIZATION
#----------------------------
DROP TABLE IF EXISTS `SYS_USER_ORGANIZATION`;
CREATE TABLE `SYS_USER_ORGANIZATION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户id',
  `ORGANIZATION_ID` bigint(20) DEFAULT NULL COMMENT '机构id',
  PRIMARY KEY (`ID`),
  KEY `FK_USER_ORGANIZATION_USER` (`USER_ID`),
  KEY `FK_USER_ORGANIZATION_ORGANIZATION` (`ORGANIZATION_ID`),
  CONSTRAINT `FK_USER_ORGANIZATION_ORGANIZATION` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `SYS_ORGANIZATION` (`ID`),
  CONSTRAINT `FK_USER_ORGANIZATION_USER` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户机构映射表';

#----------------------------
# 用户上传信息 SYS_UPLOAD_INFO
#----------------------------
DROP TABLE IF EXISTS `SYS_UPLOAD_INFO`;
CREATE TABLE `SYS_UPLOAD_INFO` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '上传用户主键',
  `FILE_NAME` varchar(100) DEFAULT NULL COMMENT '上传文件名称',
  `FILE_PATH` varchar(255) DEFAULT NULL COMMENT '上传文件保存路径',
  `FILE_SIZE` decimal(22,2) DEFAULT NULL COMMENT '文件大小，单位byte',
  `FILE_TYPE` varchar(50) DEFAULT NULL COMMENT '文件类型',
  `UPLOAD_TIME` datetime DEFAULT NULL COMMENT '上传时间',
  `DOWN_TIMES` int(11) DEFAULT '0' COMMENT '下载次数',
  `IS_DELETE` int(11) DEFAULT '0' COMMENT '是否已删除，0-否；1-删除',
  PRIMARY KEY (`ID`),
  KEY `FK_UPLOAD_INFO_USER` (`USER_ID`),
  CONSTRAINT `FK_UPLOAD_INFO_USER` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户上传信息';

#----------------------------
# mapreduce批量任务 SYS_MAPREDUCE_BATCH_JOB
#----------------------------
DROP TABLE IF EXISTS `SYS_MAPREDUCE_BATCH_JOB`;
CREATE TABLE `SYS_MAPREDUCE_BATCH_JOB` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `JOB_CODE` varchar(50) DEFAULT NULL COMMENT '任务代码',
  `JOB_DESC` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `RUN_TYPE` int(11) DEFAULT NULL COMMENT '运行类型：1-自动调度；2-手工运行；3-调试运行',
  `JOB_TYPE` int(11) DEFAULT NULL COMMENT '任务类型：1-simple；2-flow',
  `RUN_TIMES` int(11) DEFAULT '0' COMMENT '运行次数',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建者',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mapreduce批量任务';

#----------------------------
# mapreduce批量任务步骤表 SYS_MAPREDUCE_BATCH_JOB_STEP
#----------------------------
DROP TABLE IF EXISTS `SYS_MAPREDUCE_BATCH_JOB_STEP`;
CREATE TABLE `SYS_MAPREDUCE_BATCH_JOB_STEP` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `JOB_ID` bigint(20) DEFAULT NULL COMMENT '任务ID',
  `STEP_CODE` varchar(50) DEFAULT NULL COMMENT '步骤代码',
  `STEP_DESC` varchar(512) DEFAULT NULL COMMENT '步骤描述',
  `LOCAL_JAR_FILE` varchar(512) DEFAULT NULL COMMENT '本地jar文件路径',
  `RUN_CLASS` varchar(512) DEFAULT NULL COMMENT '运行class类,带包名',
  `RANKING` int(11) DEFAULT NULL COMMENT '步骤序号',
  `PARENT_STEP_ID` bigint(20) DEFAULT NULL COMMENT '父步骤',
  `CHILD_STEP_ID` bigint(20) DEFAULT NULL COMMENT '子步骤',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建者',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  KEY `FK_BATCH_JOB_STEP_JOB` (`JOB_ID`),
  CONSTRAINT `FK_BATCH_JOB_STEP_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `SYS_MAPREDUCE_BATCH_JOB` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mapreduce批量任务步骤表';

#----------------------------
# mapreduce批量任务步骤分支表 SYS_MAPREDUCE_BATCH_JOB_STEP_BRANCH
#----------------------------
DROP TABLE IF EXISTS `SYS_MAPREDUCE_BATCH_JOB_STEP_BRANCH`;
CREATE TABLE `SYS_MAPREDUCE_BATCH_JOB_STEP_BRANCH` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `STEP_ID` bigint(20) DEFAULT NULL COMMENT '步骤ID',
  `BRANCH_TYPE` int(11) DEFAULT NULL COMMENT '分支类型：0-next；1-end;2-fail;3-stop',
  `STEP_STATUS` varchar(50) DEFAULT NULL COMMENT '步骤状态代码',
  `TO_STEP_ID` bigint(20) DEFAULT NULL COMMENT '对应状态时跳转到步骤ID执行',
  PRIMARY KEY (`ID`),
  KEY `FK_BATCH_JOB_STEP_BRANCH_STEP` (`STEP_ID`),
  CONSTRAINT `FK_BATCH_JOB_STEP_BRANCH_STEP` FOREIGN KEY (`STEP_ID`) REFERENCES `SYS_MAPREDUCE_BATCH_JOB_STEP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mapreduce批量任务步骤分支表';

#----------------------------
# mapreduce批量任务实例表 SYS_MAPREDUCE_BATCH_JOB_INSTANCE
#----------------------------
DROP TABLE IF EXISTS `SYS_MAPREDUCE_BATCH_JOB_INSTANCE`;
CREATE TABLE `SYS_MAPREDUCE_BATCH_JOB_INSTANCE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `JOB_ID` bigint(20) DEFAULT NULL COMMENT 'jobid',
  `JOB_PARAMS` varchar(255) DEFAULT NULL COMMENT '运行参数，多个用逗号隔开',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始运行时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '运行结束时间',
  `JOB_STATE` int(11) DEFAULT '0' COMMENT '任务状态 0-创建 1-运行中 2-结束',
  `RESULT_CODE` varchar(20) DEFAULT NULL COMMENT '结果编码',
  `RESULT_DESC` varchar(512) DEFAULT NULL COMMENT '结果描述',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`ID`),
  KEY `FK_BATCH_JOB_INSTANCE_JOB` (`JOB_ID`),
  CONSTRAINT `FK_BATCH_JOB_INSTANCE_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `SYS_MAPREDUCE_BATCH_JOB` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mapreduce批量任务实例表';

#----------------------------
# mapreduce批量任务步骤实例表 SYS_MAPREDUCE_BATCH_JOB_STEP_INSTANCE
#----------------------------
DROP TABLE IF EXISTS `SYS_MAPREDUCE_BATCH_JOB_STEP_INSTANCE`;
CREATE TABLE `SYS_MAPREDUCE_BATCH_JOB_STEP_INSTANCE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `JOB_ID` bigint(20) DEFAULT NULL COMMENT 'jobid',
  `STEP_ID` bigint(20) DEFAULT NULL COMMENT 'stepid',
  `HADOOP_JOB_ID` bigint(20) DEFAULT NULL COMMENT 'hadoop集群中任务ID',
  `JOB_PARAMS` varchar(255) DEFAULT NULL COMMENT '运行参数，多个用逗号隔开',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始运行时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '运行结束时间',
  `STEP_STATE` int(11) DEFAULT '0' COMMENT '步骤状态 0-创建 1-运行中 2-结束',
  `RESULT_CODE` varchar(20) DEFAULT NULL COMMENT '结果编码',
  `RESULT_DESC` varchar(512) DEFAULT NULL COMMENT '结果描述',
  `CREATE_ID` bigint(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`ID`),
  KEY `FK_BATCH_JOB_STEP_INSTANCE_JOB` (`JOB_ID`),
  KEY `FK_BATCH_JOB_STEP_INSTANCE_STEP` (`STEP_ID`),
  CONSTRAINT `FK_BATCH_JOB_STEP_INSTANCE_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `SYS_MAPREDUCE_BATCH_JOB` (`ID`),
  CONSTRAINT `FK_BATCH_JOB_STEP_INSTANCE_STEP` FOREIGN KEY (`STEP_ID`) REFERENCES `SYS_MAPREDUCE_BATCH_JOB_STEP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mapreduce批量任务实例表';


COMMIT;

#
# 在Mysql中恢复外键约束: 
#
SET FOREIGN_KEY_CHECKS=1;