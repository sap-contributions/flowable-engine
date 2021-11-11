
CREATE TABLE FLOWABLE.ACT_DMN_DATABASECHANGELOGLOCK (ID INTEGER NOT NULL, LOCKED NUMBER(1) NOT NULL, LOCKGRANTED TIMESTAMP, LOCKEDBY VARCHAR2(255), CONSTRAINT PK_ACT_DMN_DATABASECHANGELOGLO PRIMARY KEY (ID));

DELETE FROM FLOWABLE.ACT_DMN_DATABASECHANGELOGLOCK;

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

UPDATE FLOWABLE.ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.68.111 (192.168.68.111)', LOCKGRANTED = TO_TIMESTAMP('2021-11-11 14:55:41.281', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 1 AND LOCKED = 0;

CREATE TABLE FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID VARCHAR2(255) NOT NULL, AUTHOR VARCHAR2(255) NOT NULL, FILENAME VARCHAR2(255) NOT NULL, DATEEXECUTED TIMESTAMP NOT NULL, ORDEREXECUTED INTEGER NOT NULL, EXECTYPE VARCHAR2(10) NOT NULL, MD5SUM VARCHAR2(35), DESCRIPTION VARCHAR2(255), COMMENTS VARCHAR2(255), TAG VARCHAR2(255), LIQUIBASE VARCHAR2(20), CONTEXTS VARCHAR2(255), LABELS VARCHAR2(255), DEPLOYMENT_ID VARCHAR2(10));

CREATE TABLE FLOWABLE.ACT_DMN_DEPLOYMENT (ID_ VARCHAR2(255) NOT NULL, NAME_ VARCHAR2(255), CATEGORY_ VARCHAR2(255), DEPLOY_TIME_ TIMESTAMP, TENANT_ID_ VARCHAR2(255), PARENT_DEPLOYMENT_ID_ VARCHAR2(255), CONSTRAINT PK_ACT_DMN_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE FLOWABLE.ACT_DMN_DEPLOYMENT_RESOURCE (ID_ VARCHAR2(255) NOT NULL, NAME_ VARCHAR2(255), DEPLOYMENT_ID_ VARCHAR2(255), RESOURCE_BYTES_ BLOB, CONSTRAINT PK_ACT_DMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

CREATE TABLE FLOWABLE.ACT_DMN_DECISION_TABLE (ID_ VARCHAR2(255) NOT NULL, NAME_ VARCHAR2(255), VERSION_ INTEGER, KEY_ VARCHAR2(255), CATEGORY_ VARCHAR2(255), DEPLOYMENT_ID_ VARCHAR2(255), PARENT_DEPLOYMENT_ID_ VARCHAR2(255), TENANT_ID_ VARCHAR2(255), RESOURCE_NAME_ VARCHAR2(255), DESCRIPTION_ VARCHAR2(255), CONSTRAINT PK_ACT_DMN_DECISION_TABLE PRIMARY KEY (ID_));

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 1, '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

CREATE TABLE FLOWABLE.ACT_DMN_HI_DECISION_EXECUTION (ID_ VARCHAR2(255) NOT NULL, DECISION_DEFINITION_ID_ VARCHAR2(255), DEPLOYMENT_ID_ VARCHAR2(255), START_TIME_ TIMESTAMP, END_TIME_ TIMESTAMP, INSTANCE_ID_ VARCHAR2(255), EXECUTION_ID_ VARCHAR2(255), ACTIVITY_ID_ VARCHAR2(255), FAILED_ NUMBER(1) DEFAULT 0, TENANT_ID_ VARCHAR2(255), EXECUTION_JSON_ CLOB, CONSTRAINT PK_ACT_DMN_HI_DECISION_EXECUTI PRIMARY KEY (ID_));

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 2, '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

ALTER TABLE FLOWABLE.ACT_DMN_HI_DECISION_EXECUTION ADD SCOPE_TYPE_ VARCHAR2(255);

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 3, '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

ALTER TABLE FLOWABLE.ACT_DMN_DECISION_TABLE DROP COLUMN PARENT_DEPLOYMENT_ID_;

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 4, '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

CREATE UNIQUE INDEX FLOWABLE.ACT_IDX_DEC_TBL_UNIQ ON FLOWABLE.ACT_DMN_DECISION_TABLE(KEY_, VERSION_, TENANT_ID_);

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 5, '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

DROP INDEX FLOWABLE.ACT_IDX_DEC_TBL_UNIQ;

ALTER TABLE FLOWABLE.ACT_DMN_DECISION_TABLE RENAME TO ACT_DMN_DECISION;

CREATE UNIQUE INDEX FLOWABLE.ACT_IDX_DMN_DEC_UNIQ ON FLOWABLE.ACT_DMN_DECISION(KEY_, VERSION_, TENANT_ID_);

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 6, '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

ALTER TABLE FLOWABLE.ACT_DMN_DECISION ADD DECISION_TYPE_ VARCHAR2(255);

INSERT INTO FLOWABLE.ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', SYSTIMESTAMP, 7, '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', 'EXECUTED', NULL, NULL, '4.3.5', '6642541334');

UPDATE FLOWABLE.ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

