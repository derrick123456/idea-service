/*********sys-service table初始化脚本,程序启动自动执行********************/

CREATE TABLE IF NOT EXISTS `sys_administration` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '编号',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `alias` varchar(20) DEFAULT NULL COMMENT '别名',
  `abbreviation` varchar(20) DEFAULT NULL COMMENT '简称',
  `pinyin` varchar(20) DEFAULT NULL COMMENT '拼音',
  `initials` varchar(1) DEFAULT NULL COMMENT '首字母',
  `location` varchar(20) DEFAULT NULL COMMENT '坐标',
  `pid` varchar(32) DEFAULT NULL COMMENT '父级id',
  `lever` smallint(1) DEFAULT NULL COMMENT '行政等级',
  `rowno` int(8) DEFAULT NULL COMMENT '行号',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `creatTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_button` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `code` varchar(20) DEFAULT NULL COMMENT '按钮代码',
  `name` varchar(40) DEFAULT NULL COMMENT '按钮名称',
  `value` varchar(200) DEFAULT NULL COMMENT '按钮值',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮表';

CREATE TABLE IF NOT EXISTS `sys_button_resource` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `menu_button_id` varchar(32) DEFAULT NULL COMMENT '菜单按钮表ID',
  `path` varchar(300) DEFAULT NULL COMMENT '路径',
  `pattern` varchar(400) DEFAULT NULL COMMENT '表达式路径',
  `method` varchar(10) DEFAULT NULL COMMENT '请求方式',
  `description` varchar(500) DEFAULT NULL COMMENT '资源描述',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_button_id` (`menu_button_id`,`path`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮类别资源表';

CREATE TABLE IF NOT EXISTS `sys_client` (
  `id` varchar(32) NOT NULL,
  `code` varchar(23) DEFAULT NULL COMMENT '客户端标识',
  `name` varchar(40) DEFAULT NULL COMMENT '客户端名称',
  `keyt` varchar(100) DEFAULT NULL COMMENT '客户端秘钥',
  `refresh` int(11) DEFAULT NULL COMMENT 'token更新时间(秒)',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_code` (
  `id` varchar(32) NOT NULL,
  `code` varchar(24) DEFAULT NULL COMMENT '唯一代码',
  `name` varchar(40) DEFAULT NULL COMMENT '码表名称(如：性别)',
  `description` varchar(50) DEFAULT NULL COMMENT '使用描述',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `rowno` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统所有可配置下拉选项';

CREATE TABLE IF NOT EXISTS `sys_doc` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `name` varchar(40) DEFAULT NULL COMMENT '文档名称',
  `code` varchar(32) DEFAULT NULL COMMENT '文档编号',
  `rowno` int(9) DEFAULT NULL COMMENT '行号',
  `owner` varchar(255) DEFAULT NULL COMMENT '文档拥有者',
  `indexid` varchar(32) DEFAULT NULL COMMENT '文档目录',
  `description` varchar(255) DEFAULT NULL COMMENT '文档备注',
  `coverimg` varchar(255) DEFAULT NULL COMMENT '文档封面',
  `totalfile` int(5) DEFAULT NULL COMMENT '文档附件总数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_doc_index` (
  `id` varchar(32) NOT NULL COMMENT '文档目录id',
  `pid` varchar(32) DEFAULT NULL COMMENT '父目录id',
  `rowNo` int(9) DEFAULT NULL COMMENT '行号',
  `indexname` varchar(255) DEFAULT NULL COMMENT '文档目录名称',
  `indexcode` varchar(255) DEFAULT NULL COMMENT '文档目录编号',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建者',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_employee` (
  `id` varchar(32) NOT NULL,
  `code` varchar(32) DEFAULT NULL COMMENT '员工编号',
  `name` varchar(40) DEFAULT NULL COMMENT '员工姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `leaderId` varchar(32) DEFAULT NULL COMMENT '上级领导',
  `positionId` varchar(32) DEFAULT NULL COMMENT '职位',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `originPlace` varchar(40) DEFAULT NULL COMMENT '籍贯',
  `inDate` date DEFAULT NULL COMMENT '入职日期',
  `outDate` date DEFAULT NULL COMMENT '离职日期',
  `certType` varchar(10) DEFAULT NULL COMMENT '证件类别',
  `certNo` varchar(30) DEFAULT NULL COMMENT '证件编号',
  `certAddress` varchar(100) DEFAULT NULL COMMENT '证件地址',
  `liveAddress` varchar(100) DEFAULT NULL COMMENT '居住地址',
  `telephone` varbinary(20) DEFAULT NULL COMMENT '固定电话',
  `mobile` varchar(20) DEFAULT NULL COMMENT '移动电话',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `weixin` varchar(30) DEFAULT NULL COMMENT '微信',
  `qq` varchar(30) DEFAULT NULL COMMENT 'QQ',
  `weibo` varchar(30) DEFAULT NULL COMMENT '新浪微博',
  `rowNo` int(11) DEFAULT '10' COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工表';

CREATE TABLE IF NOT EXISTS `sys_employee_unit` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `employeeId` varchar(32) DEFAULT NULL COMMENT '员工ID',
  `unitId` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `jobId` varchar(32) DEFAULT NULL COMMENT '岗位ID',
  `mainFlag` smallint(6) DEFAULT NULL COMMENT '主岗位标志(1:主岗位,0:兼职岗位)',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工单位表(支持身兼多职,多部门兼职)';

CREATE TABLE IF NOT EXISTS `sys_file` (
  `id` varchar(32) NOT NULL COMMENT '附件id',
  `docid` varchar(32) DEFAULT NULL COMMENT '文档id',
  `filegroup` varchar(255) DEFAULT NULL COMMENT '文件存储所在组名',
  `filename` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `filepath` varchar(255) DEFAULT NULL COMMENT '文件存储路径',
  `filesize` varchar(20) DEFAULT NULL COMMENT '文件大小',
  `uploader` varchar(32) DEFAULT NULL COMMENT '上传者',
  `uploadTime` timestamp NULL DEFAULT NULL COMMENT '上传时间',
  `url` varchar(255) DEFAULT NULL COMMENT '文件访问url',
  `extension` varchar(255) DEFAULT NULL COMMENT '文件扩展名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_job` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `name` varchar(40) DEFAULT NULL COMMENT '岗位名称',
  `code` varchar(40) DEFAULT NULL COMMENT '岗位编码',
  `unitId` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `jobId` varchar(32) DEFAULT NULL COMMENT '上级岗位ID',
  `description` varchar(200) DEFAULT NULL COMMENT '岗位说明',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位表';

CREATE TABLE IF NOT EXISTS `sys_log_record` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户账号',
  `name` varchar(32) DEFAULT NULL COMMENT '用户实名',
  `title` varchar(200) DEFAULT NULL COMMENT '日志标题',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `clientName` varchar(32) DEFAULT NULL COMMENT '客户端',
  `url` varchar(500) DEFAULT NULL COMMENT '路径',
  `content` varchar(500) DEFAULT NULL COMMENT '操作内容',
  `IP` varchar(32) DEFAULT NULL COMMENT '用户IP',
  `exception_type` varchar(32) DEFAULT NULL COMMENT '异常类型',
  `exception_trace` text COMMENT '异常跟踪',
  `type` int(11) DEFAULT NULL COMMENT '日志类型 1:登录日志 2:访问日志 3:操作日志 4:异常日志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_logininfo` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `userId` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `failCount` int(5) DEFAULT NULL COMMENT '登陆失败次数',
  `validStart` timestamp NULL DEFAULT NULL COMMENT '密码有效期起',
  `validEnd` timestamp NULL DEFAULT NULL COMMENT '密码有效期止',
  `resetFlag` smallint(6) DEFAULT NULL COMMENT '是否于鏊重置密码',
  `loginTime` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `loginIP` varchar(32) DEFAULT NULL COMMENT '最后登录IP',
  `loginType` smallint(6) DEFAULT NULL COMMENT '最后登录终端',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录信息表';

CREATE TABLE IF NOT EXISTS `sys_menu` (
  `id` varchar(32) NOT NULL,
  `pid` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `code` varchar(32) DEFAULT NULL COMMENT '菜单编码(可用于菜单层级排序)',
  `name` varchar(40) DEFAULT NULL COMMENT '菜单名称',
  `ename` varchar(100) DEFAULT NULL COMMENT '菜单英文名称',
  `cname` varchar(40) DEFAULT NULL COMMENT '菜单繁体',
  `link` varchar(100) DEFAULT NULL COMMENT '连接地址',
  `icon` varchar(40) DEFAULT NULL COMMENT '菜单图标',
  `description` varchar(100) DEFAULT NULL COMMENT '备注或描述',
  `genre` varchar(10) DEFAULT NULL COMMENT '菜单类别(PC,APP)',
  `rowNo` int(11) DEFAULT '10' COMMENT '行号',
  `child_display` int(11) DEFAULT '1' COMMENT '子级显示 1:树节点式 2:选项卡式',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改回见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单';

CREATE TABLE IF NOT EXISTS `sys_menu_button` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `buttonId` varchar(32) DEFAULT NULL COMMENT '按钮ID',
  `url` varchar(32) DEFAULT NULL COMMENT '请求路径',
  `method` varchar(32) DEFAULT NULL COMMENT '请求方式(POST,GET,DELETE等)',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单按钮表';

CREATE TABLE IF NOT EXISTS `sys_message` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `name` varchar(40) DEFAULT NULL COMMENT '消息名称',
  `code` varchar(20) DEFAULT NULL COMMENT '消息编号',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户userid',
  `type_id` varchar(32) DEFAULT NULL COMMENT '消息类型id',
  `url` varchar(200) DEFAULT NULL COMMENT '消息处理路径',
  `browseUrl` varchar(200) DEFAULT NULL COMMENT '浏览路径',
  `happendDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息发生日期',
  `recivedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息接收日期',
  `finishedDate` timestamp NULL DEFAULT NULL COMMENT '完成日期',
  `state` smallint(1) DEFAULT '1' COMMENT '处理状态（1待处理 2已处理）',
  `dealType_id` varchar(32) DEFAULT NULL COMMENT '处理',
  `valid` smallint(1) DEFAULT '1' COMMENT '有效标记（1有效 0无效）',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者（userid）',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者（userid）',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_message_dealtype` (
  `id` varchar(32) NOT NULL COMMENT '消息处理类型id',
  `name` varchar(20) DEFAULT NULL COMMENT '消息处理类型名称',
  `code` varchar(32) DEFAULT NULL COMMENT '消息处理类型code',
  `url` varchar(200) DEFAULT NULL COMMENT '消息处理类型url',
  `rowno` int(11) DEFAULT '10' COMMENT '消息处理类型行号',
  `msgType` varchar(32) DEFAULT NULL COMMENT '所属消息类型id',
  `valid` smallint(1) DEFAULT '1' COMMENT '有效标记（1有效 0无效）',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_message_queue` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `content` varchar(300) DEFAULT NULL COMMENT '消息内容',
  `exchange_name` varchar(50) DEFAULT NULL COMMENT '交换机名',
  `queue_name` varchar(50) DEFAULT NULL COMMENT '队列名',
  `model` varchar(20) DEFAULT NULL COMMENT '队列类型',
  `fail_count` int(2) DEFAULT NULL COMMENT '失败次数',
  `correlation_id` varchar(50) DEFAULT NULL COMMENT '队列标识符',
  `type_id` varchar(32) DEFAULT NULL COMMENT '消息类型',
  `group_type` varchar(32) DEFAULT NULL COMMENT '消息接收者类型',
  `group_id_value` varchar(32) DEFAULT NULL COMMENT '消息接收者id值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_message_record` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `title` varchar(40) DEFAULT NULL COMMENT '消息标题',
  `content` varchar(300) DEFAULT NULL COMMENT '消息内容',
  `user_id` varchar(32) DEFAULT NULL COMMENT '消息发送者userid',
  `group_id` varchar(32) DEFAULT NULL COMMENT '消息接收群体id',
  `group_type` smallint(6) DEFAULT NULL COMMENT '消息接收群体种类 1:机构 2:角色 3:个人',
  `message_type` varchar(32) DEFAULT NULL COMMENT '消息类型id',
  `message_dealtype` varchar(32) DEFAULT NULL COMMENT '消息处理路径id',
  `send_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发送日期',
  `url` varchar(50) DEFAULT NULL COMMENT '路径',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `creatTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_message_type` (
  `id` varchar(32) NOT NULL COMMENT '消息类别id',
  `code` varchar(32) DEFAULT NULL COMMENT '消息类别编码',
  `name` varchar(40) DEFAULT NULL COMMENT '消息类别名称',
  `type` varchar(32) DEFAULT NULL COMMENT '消息类别大类(1:可处理消息  2:通知类消息)',
  `description` varchar(200) DEFAULT NULL COMMENT '消息类别描述',
  `rowno` int(11) DEFAULT '10' COMMENT '消息类别行号',
  `valid` smallint(1) DEFAULT '1' COMMENT '有效标记（1有效 0无效）',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_position` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `code` varchar(40) DEFAULT NULL COMMENT '职位编码',
  `name` varchar(40) DEFAULT NULL COMMENT '职位名称',
  `rankCode` varchar(32) DEFAULT NULL COMMENT '级别编码',
  `description` varchar(40) DEFAULT NULL COMMENT '职位描述',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`,`name`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code_2` (`code`),
  UNIQUE KEY `code_3` (`code`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_position_button` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `positionId` varchar(32) DEFAULT NULL COMMENT '岗位ID',
  `buttonId` varchar(32) DEFAULT NULL COMMENT '按钮ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮岗位(职位关联表)';

CREATE TABLE IF NOT EXISTS `sys_position_menu` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `positionId` varchar(32) DEFAULT NULL COMMENT '岗位ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位(职位)菜单关联表';

CREATE TABLE IF NOT EXISTS `sys_position_rank` (
  `id` varchar(32) NOT NULL,
  `code` varchar(32) DEFAULT NULL COMMENT '级别编码',
  `name` varchar(40) DEFAULT NULL COMMENT '级别名称',
  `typeCode` varchar(32) DEFAULT NULL COMMENT '职位类别',
  `description` varchar(50) DEFAULT NULL COMMENT '级别描述',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位级别表';

CREATE TABLE IF NOT EXISTS `sys_positiontype` (
  `id` varchar(32) NOT NULL,
  `code` varchar(20) DEFAULT NULL COMMENT '类别编码',
  `name` varchar(30) DEFAULT NULL COMMENT '类别名称',
  `description` varchar(200) DEFAULT NULL COMMENT '类别描述',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位类别表';

CREATE TABLE IF NOT EXISTS `sys_role` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `rolerank` varchar(32) DEFAULT NULL COMMENT '角色分类(role_rank)',
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL COMMENT '角色名称(如管理员)',
  `description` varchar(200) DEFAULT NULL COMMENT '角色描述',
  `rowNo` int(11) DEFAULT '10' COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

CREATE TABLE IF NOT EXISTS `sys_role_button` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `roleId` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `buttonId` varchar(32) DEFAULT NULL COMMENT '按钮ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `menuId` (`menuId`,`buttonId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮角色关联表';

CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `roleId` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roleId` (`roleId`,`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单关联表';

CREATE TABLE IF NOT EXISTS `sys_role_rank` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `CODE` varchar(32) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL COMMENT '级别或分类名称',
  `description` varchar(200) DEFAULT NULL COMMENT '级别描述',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `rowno` int(11) NOT NULL DEFAULT '10' COMMENT '行号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色分类表(如集团角色,区域角色,地区角色)';

CREATE TABLE IF NOT EXISTS `sys_role_user` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `roleId` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `userId` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roleId` (`roleId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

CREATE TABLE IF NOT EXISTS `sys_security` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `validity` int(11) DEFAULT NULL COMMENT '密码有效期(天)',
  `intensity` varchar(40) DEFAULT NULL COMMENT '密码强度(正则表达式)',
  `retries` int(11) DEFAULT NULL COMMENT '密码重试次数',
  `password` varchar(20) DEFAULT NULL COMMENT '默认密码',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `loginLog` int(11) DEFAULT '1' COMMENT '登录日志开关（1开启2关闭）',
  `accesLog` int(11) DEFAULT '1' COMMENT '访问日志开关（1开启2关闭）',
  `operLog` int(11) DEFAULT '1' COMMENT '操作日志开关（1开启2关闭）',
  `exceLog` int(11) DEFAULT '1' COMMENT '异常日志开关（1开启2关闭）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='安全策略表';

CREATE TABLE IF NOT EXISTS `sys_unit` (
  `id` varchar(32) NOT NULL,
  `code` varchar(32) DEFAULT NULL COMMENT '机构编码',
  `name` varchar(40) DEFAULT NULL COMMENT '机构名称',
  `fullName` varchar(60) DEFAULT NULL COMMENT '机构全称',
  `pid` varchar(32) DEFAULT NULL COMMENT '父ID',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `type` varchar(20) DEFAULT NULL COMMENT '机构类别',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

CREATE TABLE IF NOT EXISTS `sys_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `userid` varchar(32) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL COMMENT '用户联系电话',
  `telephone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `mobile2` varchar(20) DEFAULT NULL COMMENT '移动电话',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `weixin` varchar(30) DEFAULT NULL COMMENT '微信',
  `qq` varchar(30) DEFAULT NULL COMMENT 'QQ',
  `weibo` varchar(30) DEFAULT NULL COMMENT '新浪微博',
  `employeeId` varchar(32) DEFAULT NULL COMMENT '关联员工ID',
  `keyt` varchar(200) DEFAULT NULL COMMENT '用户秘钥(签名下发token)',
  `rowNo` int(11) DEFAULT '10' COMMENT '行号',
  `site_layout` varchar(50) DEFAULT 'default' COMMENT '站点布局 DEFAULT:顶部布局 LEFT-layout:左侧布局 top-LEFT-layout:顶部+左侧布局',
  `valid` smallint(6) unsigned DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `userId` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表(登录用户,用户可关联员工)';

CREATE TABLE IF NOT EXISTS `sys_user_button` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `userId` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `buttonId` varchar(32) DEFAULT NULL COMMENT '按钮ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮用户关联表';

CREATE TABLE IF NOT EXISTS `sys_user_menu` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `userId` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户菜单关联表';

CREATE TABLE IF NOT EXISTS `sys_value` (
  `id` varchar(32) NOT NULL,
  `code` varchar(24) DEFAULT NULL COMMENT '唯一代码',
  `value` varchar(32) DEFAULT NULL COMMENT '码值',
  `name` varchar(40) DEFAULT NULL COMMENT '码值显示值',
  `description` varchar(50) DEFAULT NULL COMMENT '使用描述',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效小计(1:有效，0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `rowno` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统所有可配置下拉选项';

CREATE TABLE IF NOT EXISTS `sys_access_client` (
  `id` varchar(32) NOT NULL,
  `code` varchar(23) DEFAULT NULL COMMENT '客户端标识',
  `name` varchar(40) DEFAULT NULL COMMENT '客户端名称',
  `keyt` varchar(100) DEFAULT NULL COMMENT '客户端秘钥',
  `accessCode` varchar(100) DEFAULT NULL COMMENT '授权码',
  `refresh` int(11) DEFAULT NULL COMMENT 'token更新时间(秒)',
  `rowNo` int(11) DEFAULT NULL COMMENT '行号',
  `valid` smallint(6) DEFAULT '1' COMMENT '有效标记(1:有效,0:无效)',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_access_resource` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `serverCode` varchar(32) DEFAULT NULL COMMENT '服务名称',
  `path` varchar(300) DEFAULT NULL COMMENT '请求路径',
  `pattern` varchar(400) DEFAULT NULL COMMENT '表达式路径',
  `method` varchar(10) DEFAULT NULL COMMENT '请求方式',
  `description` varchar(500) DEFAULT NULL COMMENT '资源描述',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `editor` varchar(32) DEFAULT NULL COMMENT '修改者',
  `editTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方系统资源权限表';

/*2019-10-28*/
ALTER TABLE `sys_access_resource` ADD clientCode VARCHAR(32) DEFAULT NULL COMMENT '客户端标识';

commit;