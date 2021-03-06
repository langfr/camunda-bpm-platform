--
-- Copyright © 2012 - 2018 camunda services GmbH and various authors (info@camunda.com)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
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

create table ACT_ID_GROUP (
  ID_ varchar(64) not null,
  REV_ integer,
  NAME_ varchar(255),
  TYPE_ varchar(255),
  primary key (ID_)
);

create table ACT_ID_MEMBERSHIP (
  USER_ID_ varchar(64) not null,
  GROUP_ID_ varchar(64) not null,
  primary key (USER_ID_, GROUP_ID_)
);

create table ACT_ID_USER (
  ID_ varchar(64) not null,
  REV_ integer,
  FIRST_ varchar(255),
  LAST_ varchar(255),
  EMAIL_ varchar(255),
  PWD_ varchar(255),
  SALT_ varchar(255),
  LOCK_EXP_TIME_ datetime year to fraction(5),
  ATTEMPTS_ integer,
  PICTURE_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_ID_INFO (
  ID_ varchar(64) not null,
  REV_ integer,
  USER_ID_ varchar(64),
  TYPE_ varchar(64),
  KEY_ varchar(255),
  VALUE_ varchar(255),
  PASSWORD_ byte,
  PARENT_ID_ varchar(255),
  primary key (ID_)
);

create table ACT_ID_TENANT (
  ID_ varchar(64) not null,
  REV_ integer,
  NAME_ varchar(255),
  primary key (ID_)
);

create table ACT_ID_TENANT_MEMBER (
  ID_ varchar(64) not null,
  TENANT_ID_ varchar(64) not null,
  USER_ID_ varchar(64),
  GROUP_ID_ varchar(64),
  primary key (ID_)
);

alter table ACT_ID_MEMBERSHIP 
  add constraint foreign key (GROUP_ID_)
  references ACT_ID_GROUP(ID_)
  constraint ACT_FK_MEMB_GROUP;

alter table ACT_ID_MEMBERSHIP 
  add constraint foreign key (USER_ID_)
  references ACT_ID_USER(ID_)
  constraint ACT_FK_MEMB_USER;

alter table ACT_ID_TENANT_MEMBER
  add constraint foreign key (TENANT_ID_)
  references ACT_ID_TENANT
  constraint ACT_FK_TENANT_MEMB;

alter table ACT_ID_TENANT_MEMBER
  add constraint foreign key (USER_ID_)
  references ACT_ID_USER
  constraint ACT_FK_TENANT_MEMB_USER;

alter table ACT_ID_TENANT_MEMBER
  add constraint foreign key (GROUP_ID_)
  references ACT_ID_GROUP
  constraint ACT_FK_TENANT_MEMB_GROUP;

create unique index ACT_UNIQ_TENANT_MEMB_USER on ACT_ID_TENANT_MEMBER(TENANT_ID_,ACT_FCT_USER_ID_OR_ID_(USER_ID_,ID_));
create unique index ACT_UNIQ_TENANT_MEMB_GROUP on ACT_ID_TENANT_MEMBER(TENANT_ID_,ACT_FCT_GROUP_ID_OR_ID_(GROUP_ID_,ID_));
