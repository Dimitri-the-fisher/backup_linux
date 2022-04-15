#!/bin/bash

### pega o dia e a hora
dia=$(date +%w)
hora=$(date +%k | tr -d ' ')'h'

### descobre o dia da semana
if [ $dia = 0 ]; then
  diaAbrev='Dom'
elif [ $dia = 1 ]; then
  diaAbrev='Seg'
elif [ $dia = 2 ]; then
  diaAbrev='Ter'
elif [ $dia = 3 ]; then
  diaAbrev='Qua'
elif [ $dia = 4 ]; then
  diaAbrev='Qui'
elif [ $dia = 5 ]; then
  diaAbrev='Sex'
else
  diaAbrev='Sab'
fi

export PGPASSWORD=pixnet
backupDir='/mnt/backup/backup_database'
nomeBanco='database'

backupFile=$backupDir$nomeBanco'.backup'

#### inicio do backup

## apaga backup anterior (caso exista)
rm $(echo $backupDir$nomeBanco'.backup')


## executa o pg_dump, ou procura o binário do pg_dump no linux
/usr/lib/postgresql/9.3/bin/pg_dump -v -U user_linux -Fc -f $backupFile $nomeBanco -n public


#rm $(echo $backupDir$nomeBanco'.backup.bz2')

bzip2 $backupFile


## roda o vacuum
#/usr/bin/vacuumdb -U postgres -d $nomeBanco -z


#contrab

# 0 7 * * * /var/hum/./rotback
#01 * * * * /opt/pixeon/scrips_bkp_bd/bkp_lta_local.sh
#bkp_database.sh
#bkp_lta.sh