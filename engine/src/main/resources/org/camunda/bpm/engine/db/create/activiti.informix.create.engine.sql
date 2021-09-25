--
-- Copyright Camunda Services GmbH and/or licensed to Camunda Services GmbH
-- under one or more contributor license agreements. See the NOTICE file
-- distributed with this work for additional information regarding copyright
-- ownership. Camunda licenses this file to you under the Apache License,
-- Version 2.0; you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

create table ACT_GE_PROPERTY (
  NAME_ varchar(64) not null,
  VALUE_ varchar(255),
  REV_ integer,
  primary key (NAME_)
);

insert into ACT_GE_PROPERTY
values ('schema.version', 'fox', 1);

insert into ACT_GE_PROPERTY
values ('schema.history', 'create(fox)', 1);

insert into ACT_GE_PROPERTY
values ('next.dbid', '1', 1);

insert into ACT_GE_PROPERTY
values ('deployment.lock', '0', 1);

insert into ACT_GE_PROPERTY
values ('history.cleanup.job.lock', '0', 1);

insert into ACT_GE_PROPERTY
values ('startup.lock', '0', 1);

insert into ACT_GE_PROPERTY
values ('historyLevel', '3', 1);

insert into ACT_GE_PROPERTY
values ('telemetry.lock', '0', 1);

insert into ACT_GE_PROPERTY
values ('installationId.lock', '0', 1);

create table ACT_GE_BYTEARRAY (
  ID_ varchar(64) not null,
  REV_ integer,
  NAME_ varchar(255),
  DEPLOYMENT_ID_ varchar(64),
  BYTES_ byte,
  GENERATED_ boolean,
  TENANT_ID_ varchar(64),
  TYPE_ integer,
  CREATE_TIME_ datetime year to fraction(5),
  ROOT_PROC_INST_ID_ varchar(64),
  REMOVAL_TIME_ datetime year to fraction(5),
  primary key (ID_)
);

create table ACT_GE_SCHEMA_LOG (
  ID_ varchar(64) not null,
  TIMESTAMP_ datetime year to fraction(5),
  VERSION_ varchar(255),
  primary key (ID_)
);

insert into ACT_GE_SCHEMA_LOG
values ('0', CURRENT, '7.15.0');

create table ACT_RE_DEPLOYMENT (
  ID_ varchar(64) not null,
  NAME_ varchar(255),
  DEPLOY_TIME_ datetime year to fraction(5),
  SOURCE_ varchar(255),
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_EXECUTION (
  ID_ varchar(64) not null,
  REV_ integer,
  ROOT_PROC_INST_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  BUSINESS_KEY_ varchar(255),
  PARENT_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  SUPER_EXEC_ varchar(64),
  SUPER_CASE_EXEC_ varchar(64),
  CASE_INST_ID_ varchar(64),
  ACT_INST_ID_ varchar(64),
  ACT_ID_ varchar(255),
  IS_ACTIVE_ boolean,
  IS_CONCURRENT_ boolean,
  IS_SCOPE_ boolean,
  IS_EVENT_SCOPE_ boolean,
  SUSPENSION_STATE_ integer,
  CACHED_ENT_STATE_ integer,
  SEQUENCE_COUNTER_ bigint,
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_JOB (
  ID_ varchar(64) not null,
  REV_ integer,
  TYPE_ varchar(255) not null,
  LOCK_EXP_TIME_ datetime year to fraction(5),
  LOCK_OWNER_ varchar(255),
  EXCLUSIVE_ boolean,
  EXECUTION_ID_ varchar(64),
  PROCESS_INSTANCE_ID_ varchar(64),
  PROCESS_DEF_ID_ varchar(64),
  PROCESS_DEF_KEY_ varchar(255),
  RETRIES_ integer,
  EXCEPTION_STACK_ID_ varchar(64),
  EXCEPTION_MSG_ lvarchar(4000),
  FAILED_ACT_ID_ varchar(255),
  DUEDATE_ datetime year to fraction(5),
  REPEAT_ varchar(255),
  REPEAT_OFFSET_ bigint default 0,
  HANDLER_TYPE_ varchar(255),
  HANDLER_CFG_ lvarchar(4000),
  DEPLOYMENT_ID_ varchar(64),
  SUSPENSION_STATE_ integer not null default 1,
  JOB_DEF_ID_ varchar(64),
  PRIORITY_ bigint not null default 0,
  SEQUENCE_COUNTER_ bigint,
  TENANT_ID_ varchar(64),
  CREATE_TIME_ datetime year to fraction(5),
  primary key (ID_)
);

create table ACT_RU_JOBDEF (
  ID_ varchar(64) not null,
  REV_ integer,
  PROC_DEF_ID_ varchar(64),
  PROC_DEF_KEY_ varchar(255),
  ACT_ID_ varchar(255),
  JOB_TYPE_ varchar(255) not null,
  JOB_CONFIGURATION_ varchar(255),
  SUSPENSION_STATE_ integer,
  JOB_PRIORITY_ bigint,
  TENANT_ID_ varchar(64),
  DEPLOYMENT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RE_PROCDEF (
  ID_ varchar(64) not null,
  REV_ integer,
  CATEGORY_ varchar(255),
  NAME_ varchar(255),
  KEY_ varchar(255) not null,
  VERSION_ integer not null,
  DEPLOYMENT_ID_ varchar(64),
  RESOURCE_NAME_ lvarchar(4000),
  DGRM_RESOURCE_NAME_ lvarchar(4000),
  HAS_START_FORM_KEY_ boolean,
  SUSPENSION_STATE_ integer,
  TENANT_ID_ varchar(64),
  VERSION_TAG_ varchar(64),
  HISTORY_TTL_ integer,
  STARTABLE_ boolean not null default 't',
  primary key (ID_)
);

create table ACT_RE_CAMFORMDEF (
  ID_ varchar(64) not null,
  REV_ integer,
  KEY_ varchar(255) not null,
  VERSION_ integer not null,
  DEPLOYMENT_ID_ varchar(64),
  RESOURCE_NAME_ lvarchar(4000),
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_TASK (
  ID_ varchar(64) not null,
  REV_ integer,
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  CASE_EXECUTION_ID_ varchar(64),
  CASE_INST_ID_ varchar(64),
  CASE_DEF_ID_ varchar(64),
  NAME_ varchar(255),
  PARENT_TASK_ID_ varchar(64),
  DESCRIPTION_ lvarchar(4000),
  TASK_DEF_KEY_ varchar(255),
  OWNER_ varchar(255),
  ASSIGNEE_ varchar(255),
  DELEGATION_ varchar(64),
  PRIORITY_ integer,
  CREATE_TIME_ datetime year to fraction(5),
  DUE_DATE_ datetime year to fraction(5),
  FOLLOW_UP_DATE_ datetime year to fraction(5),
  SUSPENSION_STATE_ integer,
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_IDENTITYLINK (
  ID_ varchar(64) not null,
  REV_ integer,
  GROUP_ID_ varchar(255),
  TYPE_ varchar(255),
  USER_ID_ varchar(255),
  TASK_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_VARIABLE (
  ID_ varchar(64) not null,
  REV_ integer,
  TYPE_ varchar(255) not null,
  NAME_ varchar(255) not null,
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  CASE_EXECUTION_ID_ varchar(64),
  CASE_INST_ID_ varchar(64),
  TASK_ID_ varchar(64),
  BATCH_ID_ varchar(64),
  BYTEARRAY_ID_ varchar(64),
  DOUBLE_ double precision,
  LONG_ bigint,
  TEXT_ lvarchar(4000),
  TEXT2_ lvarchar(4000),
  VAR_SCOPE_ varchar(64) not null,
  SEQUENCE_COUNTER_ bigint,
  IS_CONCURRENT_LOCAL_ boolean,
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_EVENT_SUBSCR (
  ID_ varchar(64) not null,
  REV_ integer,
  EVENT_TYPE_ varchar(255) not null,
  EVENT_NAME_ varchar(255),
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  ACTIVITY_ID_ varchar(255),
  CONFIGURATION_ varchar(255),
  CREATED_ datetime year to fraction(5) not null,
  TENANT_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_INCIDENT (
  ID_ varchar(64) not null,
  REV_ integer not null,
  INCIDENT_TIMESTAMP_ datetime year to fraction(5) not null,
  INCIDENT_MSG_ lvarchar(4000),
  INCIDENT_TYPE_ varchar(255) not null,
  EXECUTION_ID_ varchar(64),
  ACTIVITY_ID_ varchar(255),
  FAILED_ACTIVITY_ID_ varchar(255),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  CAUSE_INCIDENT_ID_ varchar(64),
  ROOT_CAUSE_INCIDENT_ID_ varchar(64),
  CONFIGURATION_ varchar(255),
  TENANT_ID_ varchar(64),
  JOB_DEF_ID_ varchar(64),
  ANNOTATION_ lvarchar(4000),
  primary key (ID_)
);

create table ACT_RU_AUTHORIZATION (
  ID_ varchar(64) not null,
  REV_ integer not null,
  TYPE_ integer not null,
  GROUP_ID_ varchar(255),
  USER_ID_ varchar(255),
  RESOURCE_TYPE_ integer not null,
  RESOURCE_ID_ varchar(255),
  PERMS_ integer,
  REMOVAL_TIME_ datetime year to fraction(5),
  ROOT_PROC_INST_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_RU_FILTER (
  ID_ varchar(64) not null,
  REV_ integer not null,
  RESOURCE_TYPE_ varchar(255) not null,
  NAME_ varchar(255) not null,
  OWNER_ varchar(255),
  QUERY_ text not null,
  PROPERTIES_ text,
  primary key (ID_)
);

create table ACT_RU_METER_LOG (
  ID_ varchar(64) not null,
  NAME_ varchar(64) not null,
  REPORTER_ varchar(255),
  VALUE_ bigint,
  TIMESTAMP_ datetime year to fraction(5),
  MILLISECONDS_ bigint default 0,
  primary key (ID_)
);

create table ACT_RU_TASK_METER_LOG (
  ID_ varchar(64) not null,
  ASSIGNEE_HASH_ bigint,
  TIMESTAMP_ datetime year to fraction(5),
  primary key (ID_)
);

create table ACT_RU_EXT_TASK (
  ID_ varchar(64) not null,
  REV_ integer not null,
  WORKER_ID_ varchar(255),
  TOPIC_NAME_ varchar(255),
  RETRIES_ integer,
  ERROR_MSG_ lvarchar(4000),
  ERROR_DETAILS_ID_ varchar(64),
  LOCK_EXP_TIME_ datetime year to fraction(5),
  SUSPENSION_STATE_ integer,
  EXECUTION_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  PROC_DEF_ID_ varchar(64),
  PROC_DEF_KEY_ varchar(255),
  ACT_ID_ varchar(255),
  ACT_INST_ID_ varchar(64),
  TENANT_ID_ varchar(64),
  PRIORITY_ bigint not null default 0,
  primary key (ID_)
);

create table ACT_RU_BATCH (
  ID_ varchar(64) not null,
  REV_ integer not null,
  TYPE_ varchar(255),
  TOTAL_JOBS_ integer,
  JOBS_CREATED_ integer,
  JOBS_PER_SEED_ integer,
  INVOCATIONS_PER_JOB_ integer,
  SEED_JOB_DEF_ID_ varchar(64),
  BATCH_JOB_DEF_ID_ varchar(64),
  MONITOR_JOB_DEF_ID_ varchar(64),
  SUSPENSION_STATE_ integer,
  CONFIGURATION_ varchar(255),
  TENANT_ID_ varchar(64),
  CREATE_USER_ID_ varchar(255),
  primary key (ID_)
);

create index ACT_IDX_EXECUTION_ROOT_PI on ACT_RU_EXECUTION(ROOT_PROC_INST_ID_);
create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION(BUSINESS_KEY_);
create index ACT_IDX_EXEC_TENANT_ID on ACT_RU_EXECUTION(TENANT_ID_);
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK(CREATE_TIME_);
create index ACT_IDX_TASK_ASSIGNEE on ACT_RU_TASK(ASSIGNEE_);
create index ACT_IDX_TASK_OWNER on ACT_RU_TASK(OWNER_);
create index ACT_IDX_TASK_TENANT_ID on ACT_RU_TASK(TENANT_ID_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK(USER_ID_);
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK(GROUP_ID_);
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR(CONFIGURATION_);
create index ACT_IDX_EVENT_SUBSCR_TENANT_ID on ACT_RU_EVENT_SUBSCR(TENANT_ID_);

create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE(TASK_ID_);
create index ACT_IDX_VARIABLE_TENANT_ID on ACT_RU_VARIABLE(TENANT_ID_);
-- create index ACT_IDX_VARIABLE_TASK_NAME_TYPE on ACT_RU_VARIABLE(TASK_ID_, NAME_, TYPE_);

create index ACT_IDX_ATHRZ_PROCEDEF on ACT_RU_IDENTITYLINK(PROC_DEF_ID_);
create index ACT_IDX_INC_CONFIGURATION on ACT_RU_INCIDENT(CONFIGURATION_);
create index ACT_IDX_INC_TENANT_ID on ACT_RU_INCIDENT(TENANT_ID_);
-- CAM-5914
create index ACT_IDX_JOB_EXECUTION_ID on ACT_RU_JOB(EXECUTION_ID_);
-- create index ACT_IDX_JOB_HANDLER on ACT_RU_JOB(HANDLER_TYPE_,HANDLER_CFG_);
create index ACT_IDX_JOB_PROCINST on ACT_RU_JOB(PROCESS_INSTANCE_ID_);
create index ACT_IDX_JOB_TENANT_ID on ACT_RU_JOB(TENANT_ID_);
create index ACT_IDX_JOBDEF_TENANT_ID on ACT_RU_JOBDEF(TENANT_ID_);
create index ACT_IDX_JOB_JOB_DEF_ID on ACT_RU_JOB(JOB_DEF_ID_);

-- new metric milliseconds column
create index ACT_IDX_METER_LOG_MS on ACT_RU_METER_LOG(MILLISECONDS_);
create index ACT_IDX_METER_LOG_NAME_MS on ACT_RU_METER_LOG(NAME_, MILLISECONDS_);
create index ACT_IDX_METER_LOG_REPORT on ACT_RU_METER_LOG(NAME_, REPORTER_, MILLISECONDS_);

-- old metric timestamp column
create index ACT_IDX_METER_LOG_TIME on ACT_RU_METER_LOG(TIMESTAMP_);
create index ACT_IDX_METER_LOG on ACT_RU_METER_LOG(NAME_, TIMESTAMP_);

create index ACT_IDX_EXT_TASK_TOPIC on ACT_RU_EXT_TASK(TOPIC_NAME_);
create index ACT_IDX_EXT_TASK_TENANT_ID on ACT_RU_EXT_TASK(TENANT_ID_);
create index ACT_IDX_EXT_TASK_PRIORITY on ACT_RU_EXT_TASK(PRIORITY_);
create index ACT_IDX_EXT_TASK_ERR_DETAILS on ACT_RU_EXT_TASK(ERROR_DETAILS_ID_);
create index ACT_IDX_AUTH_GROUP_ID on ACT_RU_AUTHORIZATION(GROUP_ID_);

create function ACT_FCT_USER_ID_OR_ID_(USER_ID_ varchar(255),ID_ varchar(64)) returning varchar(255) with (not variant); return nvl(USER_ID_,ID_); end function;
create function ACT_FCT_GROUP_ID_OR_ID_(GROUP_ID_ varchar(255),ID_ varchar(64)) returning varchar(255) with (not variant); return nvl(GROUP_ID_,ID_); end function;
create function ACT_FCT_RESOURCE_ID_OR_ID_(RESOURCE_ID_ varchar(64),ID_ varchar(64)) returning varchar(64) with (not variant); return nvl(RESOURCE_ID_,ID_); end function;

create unique index ACT_UNIQ_AUTH_USER on ACT_RU_AUTHORIZATION(TYPE_,ACT_FCT_USER_ID_OR_ID_(USER_ID_,ID_),RESOURCE_TYPE_,ACT_FCT_RESOURCE_ID_OR_ID_(RESOURCE_ID_,ID_));
create unique index ACT_UNIQ_AUTH_GROUP on ACT_RU_AUTHORIZATION(TYPE_,ACT_FCT_GROUP_ID_OR_ID_(GROUP_ID_,ID_),RESOURCE_TYPE_,ACT_FCT_RESOURCE_ID_OR_ID_(RESOURCE_ID_,ID_));
create unique index ACT_UNIQ_VARIABLE on ACT_RU_VARIABLE(VAR_SCOPE_,NAME_);

alter table ACT_GE_BYTEARRAY
  add constraint foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_)
  constraint ACT_FK_BYTEARR_DEPL;

alter table ACT_RU_EXECUTION
  add constraint foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_EXE_PROCINST;

alter table ACT_RU_EXECUTION
  add constraint foreign key (PARENT_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_EXE_PARENT;
  
alter table ACT_RU_EXECUTION
  add constraint foreign key (SUPER_EXEC_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_EXE_SUPER;
  
alter table ACT_RU_EXECUTION
  add constraint foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_)
  constraint ACT_FK_EXE_PROCDEF;

alter table ACT_RU_IDENTITYLINK
  add constraint foreign key (TASK_ID_)
  references ACT_RU_TASK (ID_)
  constraint ACT_FK_TSKASS_TASK;

alter table ACT_RU_IDENTITYLINK
  add constraint foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_)
  constraint ACT_FK_ATHRZ_PROCEDEF;

alter table ACT_RU_TASK
  add constraint foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_TASK_EXE;
  
alter table ACT_RU_TASK
  add constraint foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_TASK_PROCINST;
  
alter table ACT_RU_TASK
  add constraint foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_)
  constraint ACT_FK_TASK_PROCDEF;
  
alter table ACT_RU_VARIABLE 
  add constraint foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_VAR_EXE;

alter table ACT_RU_VARIABLE
  add constraint foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION(ID_)
  constraint ACT_FK_VAR_PROCINST;

alter table ACT_RU_VARIABLE 
  add constraint foreign key (BYTEARRAY_ID_)
  references ACT_GE_BYTEARRAY (ID_)
  constraint ACT_FK_VAR_BYTEARRAY;

alter table ACT_RU_JOB 
  add constraint foreign key (EXCEPTION_STACK_ID_)
  references ACT_GE_BYTEARRAY (ID_)
  constraint ACT_FK_JOB_EXCEPTION;
  
alter table ACT_RU_EVENT_SUBSCR
  add constraint foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION(ID_)
  constraint ACT_FK_EVENT_EXEC;
  
alter table ACT_RU_INCIDENT
  add constraint foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_INC_EXE;
  
alter table ACT_RU_INCIDENT
  add constraint foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_INC_PROCINST;

alter table ACT_RU_INCIDENT
  add constraint foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_)
  constraint ACT_FK_INC_PROCDEF;
  
alter table ACT_RU_INCIDENT
  add constraint foreign key (CAUSE_INCIDENT_ID_)
  references ACT_RU_INCIDENT (ID_)
  constraint ACT_FK_INC_CAUSE;

alter table ACT_RU_INCIDENT
  add constraint foreign key (ROOT_CAUSE_INCIDENT_ID_)
  references ACT_RU_INCIDENT (ID_)
  constraint ACT_FK_INC_RCAUSE;

alter table ACT_RU_INCIDENT
  add constraint foreign key (JOB_DEF_ID_)
  references ACT_RU_JOBDEF (ID_)
  constraint ACT_FK_INC_JOB_DEF;

alter table ACT_RU_EXT_TASK
  add constraint foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_)
  constraint ACT_FK_EXT_TASK_EXE;

alter table ACT_RU_EXT_TASK
  add constraint foreign key (ERROR_DETAILS_ID_)
  references ACT_GE_BYTEARRAY (ID_)
  constraint ACT_FK_EXT_TASK_ERROR_DETAILS;

alter table ACT_RU_BATCH
  add constraint foreign key (SEED_JOB_DEF_ID_)
  references ACT_RU_JOBDEF (ID_)
  constraint ACT_FK_BATCH_SEED_JOB_DEF;

alter table ACT_RU_BATCH
  add constraint foreign key (MONITOR_JOB_DEF_ID_)
  references ACT_RU_JOBDEF (ID_)
  constraint ACT_FK_BATCH_MONITOR_JOB_DEF;

alter table ACT_RU_BATCH
  add constraint foreign key (BATCH_JOB_DEF_ID_)
  references ACT_RU_JOBDEF (ID_)
  constraint ACT_FK_BATCH_JOB_DEF;

create index ACT_IDX_BATCH_ID ON ACT_RU_VARIABLE(BATCH_ID_);

alter table ACT_RU_VARIABLE
    add constraint foreign key (BATCH_ID_)
    references ACT_RU_BATCH (ID_)
    constraint ACT_FK_VAR_BATCH;

-- indexes for concurrency problems - https://app.camunda.com/jira/browse/CAM-1646 --
-- create index ACT_IDX_EXECUTION_PROC on ACT_RU_EXECUTION(PROC_DEF_ID_);
-- create index ACT_IDX_EXECUTION_PARENT on ACT_RU_EXECUTION(PARENT_ID_);
-- create index ACT_IDX_EXECUTION_SUPER on ACT_RU_EXECUTION(SUPER_EXEC_);
-- create index ACT_IDX_EXECUTION_PROCINST on ACT_RU_EXECUTION(PROC_INST_ID_);
-- create index ACT_IDX_EVENT_SUBSCR_EXEC on ACT_RU_EVENT_SUBSCR(EXECUTION_ID_);
-- create index ACT_IDX_BA_DEPLOYMENT on ACT_GE_BYTEARRAY(DEPLOYMENT_ID_);
-- create index ACT_IDX_IDENT_LNK_TASK on ACT_RU_IDENTITYLINK(TASK_ID_);
-- create index ACT_IDX_INCIDENT_EXEC on ACT_RU_INCIDENT(EXECUTION_ID_);
-- create index ACT_IDX_INCIDENT_PROCINST on ACT_RU_INCIDENT(PROC_INST_ID_);
-- create index ACT_IDX_INCIDENT_PROC_DEF_ID on ACT_RU_INCIDENT(PROC_DEF_ID_);
-- create index ACT_IDX_INCIDENT_CAUSE on ACT_RU_INCIDENT(CAUSE_INCIDENT_ID_);
-- create index ACT_IDX_INCIDENT_ROOT_CAUSE on ACT_RU_INCIDENT(ROOT_CAUSE_INCIDENT_ID_);
-- create index ACT_IDX_JOB_EXCEPTION_STACK on ACT_RU_JOB(EXCEPTION_STACK_ID_);
-- create index ACT_IDX_VARIABLE_BA on ACT_RU_VARIABLE(BYTEARRAY_ID_);
-- create index ACT_IDX_VARIABLE_EXEC on ACT_RU_VARIABLE(EXECUTION_ID_);
-- create index ACT_IDX_VARIABLE_PROCINST on ACT_RU_VARIABLE(PROC_INST_ID_);
-- create index ACT_IDX_TASK_EXEC on ACT_RU_TASK(EXECUTION_ID_);
-- create index ACT_IDX_TASK_PROCINST on ACT_RU_TASK(PROC_INST_ID_);
-- create index ACT_IDX_TASK_PROC_DEF_ID on ACT_RU_TASK(PROC_DEF_ID_);
-- index for deadlock problem - https://app.camunda.com/jira/browse/CAM-4440 --
create index ACT_IDX_AUTH_RESOURCE_ID on ACT_RU_AUTHORIZATION(RESOURCE_ID_);
-- index to prevent deadlock on fk constraint - https://app.camunda.com/jira/browse/CAM-5440 --
-- create index ACT_IDX_EXT_TASK_EXEC on ACT_RU_EXT_TASK(EXECUTION_ID_);


-- indexes to improve deployment
create index ACT_IDX_BYTEARRAY_ROOT_PI on ACT_GE_BYTEARRAY(ROOT_PROC_INST_ID_);
create index ACT_IDX_BYTEARRAY_RM_TIME on ACT_GE_BYTEARRAY(REMOVAL_TIME_);
create index ACT_IDX_BYTEARRAY_NAME on ACT_GE_BYTEARRAY(NAME_);
create index ACT_IDX_DEPLOYMENT_NAME on ACT_RE_DEPLOYMENT(NAME_);
create index ACT_IDX_DEPLOYMENT_TENANT_ID on ACT_RE_DEPLOYMENT(TENANT_ID_);
create index ACT_IDX_JOBDEF_PROC_DEF_ID on ACT_RU_JOBDEF(PROC_DEF_ID_);
create index ACT_IDX_JOB_HANDLER_TYPE on ACT_RU_JOB(HANDLER_TYPE_);
create index ACT_IDX_EVENT_SUBSCR_EVT_NAME on ACT_RU_EVENT_SUBSCR(EVENT_NAME_);
create index ACT_IDX_PROCDEF_DEPLOYMENT_ID on ACT_RE_PROCDEF(DEPLOYMENT_ID_);
create index ACT_IDX_PROCDEF_TENANT_ID on ACT_RE_PROCDEF(TENANT_ID_);
create index ACT_IDX_PROCDEF_VER_TAG on ACT_RE_PROCDEF(VERSION_TAG_);

-- indices for history cleanup: https://jira.camunda.com/browse/CAM-11616
create index ACT_IDX_AUTH_ROOT_PI on ACT_RU_AUTHORIZATION(ROOT_PROC_INST_ID_);
create index ACT_IDX_AUTH_RM_TIME on ACT_RU_AUTHORIZATION(REMOVAL_TIME_);

create function MINUTE ( param1 datetime year to fraction ) returning integer; define rv integer; select to_char(param1, "%M" )::int into rv from sysmaster:sysdual; return rv; end function;
