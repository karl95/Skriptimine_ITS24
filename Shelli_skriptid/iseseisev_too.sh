  GNU nano 7.2                                                                                     iseseisev_too.sh
#!/bin/bash
fail=$1
LOGIFAIL="/mnt/c/GitHub-ITS24/Shelli_skriptid/systeemilogi.log"
#funksioon, mis muudab tähed väikeseks ja asendab täpitähed
asenda_tahed(){
        echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/õ/o/g' -e 's/ä/a/g' -e 's/ö/o/g' -e 's/ü/y/g'
}

#kontrollime kas grupp olemas
check_or_create_group() {
        if getent group "$1" > /dev/null; then
                echo "Grupp $1 juba on olemas!"
        else
                echo "Gruppi $1 pole, loome selle..."
                groupadd "$1"
        fi
}

#loeme faili rida realt
while read enimi pnimi kursus; do
        #töötleme ees- ja perenimed ära
        eesnimi=$(asenda_tahed "$enimi")
        perenimi=$(asenda_tahed "$pnimi")
        #loome kasutajanime ees- ja perekonna nimest
        kasutajanimi="${eesnimi}.${perenimi}"

#loome kursuse
check_or_create_group "$kursus"

#loome kasutaja ja lisame selle  gruppi
cat /etc/passwd | grep $kasutajanimi >> /dev/null
if [ $? -ne 0 ]; then
        useradd -g "$kursus" -d /home/$kasutajanimi -m -s /bin/bash -c "$enimi $pnimi" $kasutajanimi
        echo "$(date '+%d.%m.%Y %H:%M:%S') - $teenus ei töötanud käivitati uuesti. Kontrollijaks oli $RUN " >> "$LOGIFAIL"
else
        echo "Kasutaja $kasutajanimi lisatud gruppi $kursus"
fi
done < "$fail"
