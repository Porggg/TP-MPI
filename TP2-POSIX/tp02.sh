#1. grep '^0 \|^1' binaire.txt
#2. grep -v '^0 \|^1' binaire.txt

#3. grep '[a-z]\([a-z]*\|_*\|[A-Z]*\)' area.c
grep '[a-z]\([a-z]*\|_*\|[A-Z]*\)' area.c | grep -v '//'



