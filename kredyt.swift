var mieszkanie:Float = 500000
var lata:Float = 30
var oprocentowanie:Float = 0.05
var i:Float = 0.001
var wplata:Float = 100000

var kredyt:Float = mieszkanie - wplata

var odsetkowa:Float = 0
var kapitalowa:Float = kredyt / (lata * 12)
var tablica: [Float] = []

//pomocnicze
var poprzednia:Float = 0
var suma:Float = 0
var numer:Float = 1
var do_zaplacenia = kredyt

for rosnace_oprocentowanie in 1 ... 60 {
	for miesiac in 1 ... 6 {
        odsetkowa = do_zaplacenia * (oprocentowanie / 12)
        tablica.append(numer)
        //ogolna
		tablica.append(kapitalowa + odsetkowa)
		//kapitalowa
		tablica.append(kapitalowa)
		//odsetkowa
		tablica.append(odsetkowa)
		//poprzednia rata
		poprzednia = kapitalowa + odsetkowa
        do_zaplacenia -= odsetkowa
        suma += poprzednia
        numer += 1
	}
	oprocentowanie += i
}

var row0:Int = 0
var row1:Int = 1
var row2:Int = 2
var row3:Int = 3

var rows:Int = 0

while rows < 360 {
    print(tablica[row0], terminator: " \t")
    row0 += 4
    print(tablica[row1], terminator: " \t")
    row1 += 4
    print(tablica[row2], terminator: " \t")
    row2 += 4
    print(tablica[row3])
    row3 += 4
    
    rows += 1
    
}
print("\ncalkowity koszt kredytu: ", suma)
print("nadplacone pieniadze: ", suma - 400000)