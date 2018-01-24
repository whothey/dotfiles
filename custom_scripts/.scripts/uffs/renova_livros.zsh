# /bin/zsh

USER="$1" # First argument is user
PW="$2"   # Second is the password ## TODO: handle passwords with hidden input

# Store cookies for further use
CJARFILE="/tmp/consulta_uffs_cookiejar"

# Main URL for all operations
URL="http://consulta.uffs.edu.br/pergamum/biblioteca_s/php/login_usu.php?flag=index.php"

function do_post {
    local PARAMETERS="$1"

    # Do not forget to use "-e" (the referer flag), Pergamum does a ref-check :^)
    curl -s -L -c $CJARFILE -e $URL -d $PARAMETERS $URL
}

function renova_livro {
    local CODLIVRO="$1"
    local CODBIBLIOTECA="$2"
    local CODBIBEXEMPLAR="$3"
    local CONT="$4"
    local ANTERIORPENDENTE="$5"
    local RND=$(echo `date -u %s.%3N` " * 1000" | bc -l)
    local RPARAMETERS="rs=ajax_renova&rst=&rsrnd=$RND&rsargs[]=$CODLIVRO&rsargs[]=$CODBIBLIOTECA&rsargs[]=$CODBIBEXEMPLAR&rsargs[]=$ANTERIORPENDENTE"

    do_post "$RPARAMETERS"
}

function pergamum_login {
    local LPARAMETERS="flag=index.php&login=$USER&password=$PW&button=Acessar&numero_mestre="

    do_post "$LPARAMETERS"
}

# Cleanup Cookie Jar
echo "" > $CJARFILE

# Parse books here

# Renovando Funds:
# rs=ajax_renova&rst=&rsrnd=1503360756221&rsargs[]=17282&rsargs[]=1&rsargs[]=1&rsargs[]=18097
# rs=ajax_renova&rst=&rsrnd=1503360870386&rsargs[]=17282&rsargs[]=1&rsargs[]=1&rsargs[]=18097
# rsrnd=new Date().getTime()
# rsrnd=$(echo `date -u +%s%3N` * 1000 | bc -l)
#RESPONSE=`curl -s -L -c $CJARFILE -e $URL -d $PARAMETERS $URL`

pergamum_login

rm "$CJARFILE"
