#
# Bastillion Configuration Options
#
#
#set to true to regenerate and import SSH keys
resetApplicationSSHKey={{ default .Env.RESET_APPLICATION_SSH_KEY "false" }}
#SSH key type 'dsa', 'rsa', or 'ecdsa' for generated keys
sshKeyType={{ default .Env.SSH_KEY_TYPE "rsa" }}
#SSH key length for generated keys. 2048 => 'rsa','dsa'; 521 => 'ecdsa'
sshKeyLength={{ default .Env.SSH_KEY_LENGTH "2048" }}
#private ssh key, leave blank to generate key pair
privateKey={{ default .Env.SSH_PRIVATE_KEY "" }}
#public ssh key, leave blank to generate key pair
publicKey={{ default .Env.SSH_PUBLIC_KEY "" }}
#default passphrase, leave blank for key without passphrase
defaultSSHPassphrase=${randomPassphrase}
#alarm state select values
alarmState=OK:OK,INSUFFICIENT_DATA:Insufficient Data,ALARM:Alarm
#system status select values
systemStatus=ok:OK,impaired:Impaired,insufficient-data:Insufficient Data,not-applicable:Not-Applicable
#instance status select values
instanceStatus=ok:OK,impaired:Impaired,insufficient-data:Insufficient Data,not-applicable:Not-Applicable
#instance state select values
instanceState=pending:Pending,running:Running,shutting-down:Shutting-down,terminated:Terminated,stopping:Stopping,stopped:Stopped
#default instance state
defaultInstanceState=running
#enable audit
enableInternalAudit={{ default .Env.ENABLE_INTERNAL_AUDIT "false" }}
#keep audit logs for in days
deleteAuditLogAfter={{ default .Env.DELETE_AUDIT_LOG_AFTER "90" }}
#The number of seconds that the client will wait before sending a null packet to the server to keep the connection alive
serverAliveInterval={{ default .Env.SERVER_ALIVE_INTERVAL "60" }}
#default timeout in minutes for websocket connection (no timeout for <=0)
websocketTimeout=0
#enable SSH agent forwarding
agentForwarding={{ default .Env.AGENT_FORWARDING "false" }}
#enable two-factor authentication with a one-time password - 'required', 'optional', or 'disabled'
oneTimePassword={{ default .Env.ONE_TIME_PASSWORD "optional" }}
#set to false to disable key management. If false, the Bastillion public key will be appended to the authorized_keys file (instead of it being overwritten completely).
keyManagementEnabled={{ default .Env.KEY_MANAGEMENT_ENABLED "true" }}
#set to true to generate keys when added/managed by users and enforce strong passphrases set to false to allow users to set their own public key
forceUserKeyGeneration={{ default .Env.FORCE_USER_KEY_GENERATION "true" }}
#authorized_keys refresh interval in minutes (no refresh for <=0)
authKeysRefreshInterval={{ default .Env.AUTH_KEYS_REFRESH_INTERVAL "120" }}
#Regular expression to enforce password policy
passwordComplexityRegEx=((?=.*\\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()+=]).{8\,20})
#Password complexity error message
passwordComplexityMsg=Passwords must be 8 to 20 characters\, contain one digit\, one lowercase\, one uppercase\, and one special character
#HTTP header to identify client IP Address - 'X-FORWARDED-FOR'
clientIPHeader={{ .Env.CLIENT_IP_HEADER }}
#specify a external authentication module (ex: ldap-ol, ldap-ad).  Edit the jaas.conf to set connection details
jaasModule=
#Default profile for all authenticated LDAP users
defaultProfileForLdap=
#proxy settings for AWS client
awsProtocol=https
awsProxyHost=
awsProxyPort=
awsProxyUser=
awsProxyPassword=
#The session time out value of application in minutes
sessionTimeout={{ default .Env.SESSION_TIMEOUT "15" }}
#AWS IAM access key
accessKey={{ default .Env.AWS_ACCESS_KEY_ID "" }}
#AWS IAM secret key
secretKey={{ default .Env.AWS_SECRET_ACCESS_KEY "" }}
defaultSystemUser={{ default .Env.DEFAULT_SYSTEM_USER "ec2-user" }}
defaultSystemPort={{ default .Env.DEFAULT_SYSTEM_PORT "22" }}
userTagName={{ default .Env.USER_TAG_NAME "" }}
#Use private DNS for instances
useEC2PvtDNS={{ default .Env.USE_EC2_PVT_DNS "false" }}
#Use private IP for instances
useEC2PvtIP={{ default .Env.USE_EC2_PVT_IP "false" }}

#Database and connection pool settings
#Database user
dbUser={{ default .Env.DB_USER "bastillion" }}
#Database password
dbPassword={{ .Env.DB_PASSWORD }}
#Database JDBC driver
dbDriver=org.h2.Driver
#Connection URL to the DB
dbConnectionURL={{ default .Env.DB_CONNECTION_URL "jdbc:h2:keydb/bastillion;CIPHER=AES" }};
#Max connections in the connection pool
maxActive=25
#When true, objects will be validated before being returned by the connection pool
testOnBorrow=true
#The minimum number of objects allowed in the connection pool before spawning new ones
minIdle=2
#The maximum amount of time (in milliseconds) to block before throwing an exception when the connection pool is exhausted
maxWait=15000
