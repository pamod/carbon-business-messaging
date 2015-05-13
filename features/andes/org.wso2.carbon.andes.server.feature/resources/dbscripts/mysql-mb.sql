/*
 * Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

-- WSO2 Message Broker MySQL Database schema --

-- Start of Message Store Tables --

CREATE TABLE IF NOT EXISTS MB_CONTENT (
                MESSAGE_ID BIGINT,
                CONTENT_OFFSET INTEGER,
                MESSAGE_CONTENT VARBINARY(65500),
                PRIMARY KEY (MESSAGE_ID,CONTENT_OFFSET)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_QUEUE_MAPPING (
                QUEUE_ID INTEGER AUTO_INCREMENT,
                QUEUE_NAME VARCHAR(512) NOT NULL,
                PRIMARY KEY (QUEUE_ID, QUEUE_NAME)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_METADATA (
                MESSAGE_ID BIGINT,
                QUEUE_ID INTEGER,
                MESSAGE_METADATA VARBINARY(65500),
                PRIMARY KEY (MESSAGE_ID, QUEUE_ID),
                FOREIGN KEY (QUEUE_ID) REFERENCES MB_QUEUE_MAPPING (QUEUE_ID)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_EXPIRATION_DATA (
                MESSAGE_ID BIGINT UNIQUE,
                EXPIRATION_TIME BIGINT,
                MESSAGE_DESTINATION VARCHAR(512) NOT NULL,
                FOREIGN KEY (MESSAGE_ID) REFERENCES MB_METADATA (MESSAGE_ID)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- End of Message Store Tables --

-- Start of Andes Context Store Tables --
 
CREATE TABLE IF NOT EXISTS MB_DURABLE_SUBSCRIPTION (
                        SUBSCRIPTION_ID VARCHAR(512) NOT NULL, 
                        DESTINATION_IDENTIFIER VARCHAR(512) NOT NULL,
                        SUBSCRIPTION_DATA VARCHAR(2048) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_NODE (
                        NODE_ID VARCHAR(512) NOT NULL,
                        NODE_DATA VARCHAR(2048) NOT NULL,
                        PRIMARY KEY(NODE_ID)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_EXCHANGE (
                        EXCHANGE_NAME VARCHAR(512) NOT NULL,
                        EXCHANGE_DATA VARCHAR(2048) NOT NULL,
                        PRIMARY KEY(EXCHANGE_NAME)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_QUEUE (
                        QUEUE_NAME VARCHAR(512) NOT NULL,
                        QUEUE_DATA VARCHAR(2048) NOT NULL,
                        PRIMARY KEY(QUEUE_NAME)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_BINDING (
                        EXCHANGE_NAME VARCHAR(512) NOT NULL,
                        QUEUE_NAME VARCHAR(512) NOT NULL,
                        BINDING_DETAILS VARCHAR(2048) NOT NULL,
                        FOREIGN KEY (EXCHANGE_NAME) REFERENCES MB_EXCHANGE (EXCHANGE_NAME),
                        FOREIGN KEY (QUEUE_NAME) REFERENCES MB_QUEUE (QUEUE_NAME)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS MB_QUEUE_COUNTER (
                        QUEUE_NAME VARCHAR(512) NOT NULL,
                        MESSAGE_COUNT BIGINT, 
                        PRIMARY KEY (QUEUE_NAME) 
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS MB_MSG_STORE_STATUS (
                        NODE_ID VARCHAR(512) NOT NULL,
                        TIME_STAMP BIGINT, 
                        PRIMARY KEY (NODE_ID, TIME_STAMP)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- End of Andes Context Store Tables --
