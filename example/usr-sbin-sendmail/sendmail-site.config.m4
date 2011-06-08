define(`confMANROOT',`/usr/share/man/man')dnl
define(`confDONT_INSTALL_CATMAN')dnl
APPENDDEF(`confMAPDEF',`-DMAP_REGEX -DDNSMAP=1 -DUSERDB=0')dnl
APPENDDEF(`confENVDEF',`-DNETUNIX=0 -DMATCHGECOS=0 -DXDEBUG=0')dnl
APPENDDEF(`confENVDEF',`-DSASL=2 -DSM_CONF_SHM=1')dnl
APPENDDEF(`confLIBS',`-lsasl2')dnl
APPENDDEF(`confLIBDIRS',`-L/usr/local/lib/sasl2 -L/usr/lib -L/usr/lib64')dnl
APPENDDEF(`confINCDIRS',`-I/usr/local/include/sasl -I/usr/include -I/usr/include/gdbm')dnl
APPENDDEF(`conf_sendmail_ENVDEF',`-DMILTER')dnl
APPENDDEF(`conf_libmilter_ENVDEF', `-DMILTER')dnl
