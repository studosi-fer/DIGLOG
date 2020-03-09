## [DIGLOG] 4. Labos, Simulacijski (2015/16)
##
## Skripta za izradu tablice potpunog zbrajala.
## By: DrinkingBuddy;
## LICENSE: GPL v3 license (http://www.gnu.org/licenses/gpl-3.0.txt)




## Output file di ce izaci sva rjesenja
f = file('dlab_02-2.txt', 'w')

## Tablica koja drzi kod 
kod = [0 for x in xrange(4)]

## Tablica koja ce drzati sve
tablica = [[0 for x in range(33)] for x in range(12)] 

## Vraca binarnu vrijednost znamenke u kodu
def dekoder(broj):
    for rijec in kod:
        if str(broj) == str(rijec):
            binkod = str(bin(broj))
            return binkod

## Pronalazi broj i stavlja ga u kodni oblik
def koder(broj):
    if str(kod[0]) == str(broj):
        return '00'
    elif str(kod[1]) == str(broj):
        return '01'
    elif str(kod[2]) == str(broj):
        return '10'
    else:
        return '11'

def izradikodnutablicu():
    # Punjenje kodne tablice
    kod[0] = raw_input('Upisite znamenku koja pribada binarnom kodu "00": ')
    kod[1] = raw_input('Upisite znamenku koja pribada binarnom kodu "01": ')
    kod[2] = raw_input('Upisite znamenku koja pribada binarnom kodu "10": ')
    kod[3] = raw_input('Upisite znamenku koja pribada binarnom kodu "11": ')

def izraditablicu(kodnatablica):

    tablica[0][0] = 'a1'
    tablica[1][0] = 'a2'
    tablica[2][0] = 'b1'
    tablica[3][0] = 'b2'
    tablica[4][0] = 'ci'

    tablica[5][0] = 'a'
    tablica[6][0] = 'b'    
    tablica[7][0] = 'c'

    tablica[8][0] = 'a+b+c'

    tablica[9][0] = 'r1'
    tablica[10][0] = 'r0'
    tablica[11][0] = 'co'

    ## Punjenje tablice
    for x in xrange(32):

        ## Punjene binarnog signala a0, a1, b0, b1, ci
        xbin = bin(x)
        xbin = str(xbin)

        if x < 2:
            tablica[0][x + 1] = 0
            tablica[1][x + 1] = 0
            tablica[2][x + 1] = 0
            tablica[3][x + 1] = 0
            tablica[4][x + 1] = xbin[2]
        elif x < 4:
            tablica[0][x + 1] = 0
            tablica[1][x + 1] = 0
            tablica[2][x + 1] = 0
            tablica[3][x + 1] = xbin[2]
            tablica[4][x + 1] = xbin[3]
        elif x < 8:
            tablica[0][x + 1] = 0
            tablica[1][x + 1] = 0
            tablica[2][x + 1] = xbin[2]
            tablica[3][x + 1] = xbin[3]
            tablica[4][x + 1] = xbin[4]
        elif x < 16:
            tablica[0][x + 1] = 0
            tablica[1][x + 1] = xbin[2]
            tablica[2][x + 1] = xbin[3]
            tablica[3][x + 1] = xbin[4]
            tablica[4][x + 1] = xbin[5]
        else:
            tablica[0][x + 1] = 1
            tablica[1][x + 1] = xbin[3]
            tablica[2][x + 1] = xbin[4]
            tablica[3][x + 1] = xbin[5]
            tablica[4][x + 1] = xbin[6]

        ## Punjenje s vrijednostima od a, b, c
        a0 = tablica[0][x + 1]
        a1 = tablica[1][x + 1]
        b0 = tablica[2][x + 1]
        b1 = tablica[3][x + 1]
        ci = tablica[4][x + 1]


        if str(a0) == '0' and str(a1) == '0':
            tablica[5][x + 1] = kod[0]
        elif str(a0) == '0' and str(a1) == '1':
            tablica[5][x + 1] = kod[1]
        elif str(a0) == '1' and str(a1) == '0': ## U v3 uvijet je bio str(a0) == '0' and str(a1) == '0'
            tablica[5][x + 1] = kod[2]
        else:
            tablica[5][x + 1] = kod[3]

        if str(b0) == '0' and str(b1) == '0':
            tablica[6][x + 1] = kod[0]
        elif str(b0) == '0' and str(b1) == '1':
            tablica[6][x + 1] = kod[1]
        elif str(b0) == '1' and str(b1) == '0':
            tablica[6][x + 1] = kod[2]
        else:
            tablica[6][x + 1] = kod[3]


        tablica[7][x + 1] = ci


        ## Punjenje s vrijednosti a+b+c
        tablica[8][x + 1] = int(tablica[5][x + 1]) + int(tablica[6][x + 1]) + int(tablica[7][x + 1])


        ## Punjenje s vrijednostima r0, r1, co
        suma = tablica[8][x + 1]
        modsuma = tablica[8][x + 1] % 4

        tablica[9][x + 1] = koder(modsuma)[0]
        tablica[10][x + 1] = koder(modsuma)[1]

        if suma > 3:
            tablica[11][x + 1] = 1


## Izrada citljivog formata
def napravioutput():
    f.write('Vasa kodna tablica je:\n\n')
    f.write('Kodna Rijec | Znamenka\n')
    f.write('----------------------\n')
    f.write(' 00         | ' + str(kod[0]) + '\n')
    f.write(' 01         | ' + str(kod[1]) + '\n')
    f.write(' 10         | ' + str(kod[2]) + '\n')
    f.write(' 11         | ' + str(kod[3]) + '\n\n\n')

    f.write('Tablica vaseg potunog zbrajala je:\n\n')

    line = ''
    for x in xrange(5):
        line += str(tablica[x][0]) + ' '
    line += '| '
    for x in xrange(3):
        line += str(tablica[x + 5][0]) + ' '
    
    line += '| '
    line += str(tablica[8][0]) + ' | '
    for x in xrange(3):
        line += str(tablica[x + 9][0]) + ' '
    
    f.write(line + '\n')

    f.write('----------------------------------------\n')

    for y in xrange(32):
        line = ''
        for x in xrange(5):
            line += ' ' + str(tablica[x][y + 1]) + ' '
        line += '| '
        for x in xrange(3):
            line += str(tablica[x + 5][y + 1]) + ' '
        line += '| '
        line += '  ' + str(tablica[8][y + 1]) + '   | '
        for x in xrange(3):
            line += ' ' + str(tablica[x + 9][y + 1]) + ' '
        f.write(line + '\n')

    f.write('\n\nFunkcije su vam:\n')

    funk = ''
    for y in range(32):
        if str(tablica[11][y+1]) == str(1):
            funk += str(y) + ','
    
    f.write('\nco(a1, a2, b1, b2, ci) = suma_minterma(' + funk + ')\n')

    funk = ''
    for y in range(32):
        if str(tablica[9][y+1]) == str(1):
            funk += str(y) + ','
    
    f.write('\nr1(a1, a2, b1, b2, ci) = suma_minterma(' + funk + ')\n')

    funk = ''
    for y in range(32):
        if str(tablica[10][y+1]) == str(1):
            funk += str(y) + ','
    
    f.write('\nr0(a1, a2, b1, b2, ci) = suma_minterma(' + funk + ')\n') 
    
    f.close()

def main():
    izradikodnutablicu()
    izraditablicu(kod)
    napravioutput()
    print('Uspjesno izvrseno!\n'
          'Pogledajte file "dlab_02-2.txt" koji se nalazi u direkotoriju di ste pokrenuli ovu skripu.\n'
          'Preporucavam da sami provijerite output, ova skripta ne garantira tocnost'
          'Ako nadzete gresku UPOZORITE druge na gresku i ako znate pokusajte ju popraviti.')


if __name__ == '__main__':
    main()
