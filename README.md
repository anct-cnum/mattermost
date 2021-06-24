# mattermost
1. Créer une application NodeJS et un addon MySQL
2. You need to set a few environment variables for it to work on Clever Cloud:
 - `MM_SERVICESETTINGS_LISTENADDRESS=":8080"`
 - `MM_SQLSETTINGS_DATASOURCE="<username>:<password>@tcp(<host>:<port>)/<dbname>?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s"`
 - If you are using postgresql: `MM_SQLSETTINGS_DRIVERNAME="mysql"`
 - `MM_SQLSETTINGS_MAXOPENCONNS="<maxconnstodb_or_lower>"`
3. Editer les paramètres avec la console système : le système de stockage doit être Amazon S3 (configurer une instance Cellar)

To update mattermost, simply change the wget url in the build.sh to the version you want.
