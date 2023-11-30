#!/bin/bash
servico='ARQUIVOS_GRAVACAO'

while test -n "$1"; do
        case "$1" in
        -s)
                servico='ARQUIVOS_GRAVACAO'
                shift
                ;;
        *)
                echo "PARAMETROS INVALIDOS: $1"
                exit $STATE_UNKNOWN
                ;;
        esac
        shift
done

if [ ! "$servico" ]; then
        echo "Favor definir o servico"
        exit $STATE_UNKNOWN
fi

STATUS=$(echo "exec ss_sp_PBX_nagios '$servico'"|isql -b -dx MSSQL-discador dss dss88340566 2>/dev/null)
STATE_NAGIOS=$(echo $STATUS| cut -d'_' -f 1)
STATE_MSG=$(echo $STATUS| cut -d'_' -f 2)
echo $STATE_MSG
exit $STATE_NAGIOS
