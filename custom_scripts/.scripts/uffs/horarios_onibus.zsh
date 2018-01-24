#! /bin/zsh
#
# Horários para Universidade Federal da Fronteira Sul (para o Terminal)
# Autor: Gabriel Henrique Rudey
#
# Este programa não possui qualquer vinculo com a AutoViação Chapecó

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

NOW=`date +%H%M`

# Busca pelos dados do website
RESULT=`curl -s -d "linha=24&dia=7" avchap.com.br/m/buscaHorarios.php \
    | grep 'tbody' \
    | sed -r -e 's/<tr>//g' -e 's/<\/tr>/\n/g' \
    | sed -r -e 's/<td[^>]*>//g' -e 's/<\/td>/,/g' \
    | sed -r -e 's/<tbody>|<\/tbody>//g'`

# Input descriptor 3 agora é $RESULT
exec 3<<< $RESULT

# Filtro se o usuário invocar o programa com "-n"
if [[ $1 = '-n' ]]; then
    while read ROW <&3; do
        # Extrai o horário (HH:MM) do ônibus da $ROW
        ROWTIME=`grep -o "[[:digit:]]\+\:[[:digit:]]\+" <<< $ROW | tr -d ':'`

        [[ -z $ROWTIME ]] && TABLE="$TABLE\n${ROW/\t|\ //g}"

        # Compara os horários e adiciona a $ROW para a variavel $TABLE
        [[ $NOW -le $ROWTIME ]] && TABLE="$TABLE\n$ROW"
    done;
else
    TABLE="$RESULT"
fi;

# Transforma resultado em colunas
echo "$TABLE" | column -s, -t | sed -r -e "s/<b>/${BOLD}/g" -e "s/<\/b>/${NORMAL}/g" \
