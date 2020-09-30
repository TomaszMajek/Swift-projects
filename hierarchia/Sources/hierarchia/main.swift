import Foundation

enum Program {
    case Bawelna, BawelnaEko, Syntetyki, Wirowanie, Odpompowanie, Spoczynek, Wylaczona
}

protocol PralkaProtocol {
    var temperatura: Int {get set}
    var program: Program {get set}
}

class Pralka: PralkaProtocol {
    var temperatura = 0
    var program = Program.Spoczynek
}

class Wyswietlacz {
    var pralka: PralkaProtocol
    var sterownik: Sterownik

    init(pralka: PralkaProtocol, sterownik: Sterownik) {
        self.pralka = pralka
        self.sterownik = sterownik
    }

    func start() {
        var numer = 0
        while(numer < 1 || numer > 4) {
            print("Programy:\n1 - Bawelna,\n2 - BawelnaEko,\n3 - Syntetyki,\n4 - Wylacz pralke,\nWybierz cyfrę:")
            if let typed = readLine() {
                if let num = Int(typed) {
                    numer = num
                }
                if numer == 4 {
                    print("Wyłączanie pralki...")
                    exit(0)
                }
            }
            print("\nWybierz temperaturę prania: ")
            if let line = readLine() {
                if let temp = Int(line) {
                    pralka.temperatura = temp
                }
            }
            if(numer < 1 || numer > 4) {
                print("Brak programu, wybierz inny:")
            } 
        }
        switch numer {
            case 1:
                pralka.program = .Bawelna
                sterownik.zaczynaj()
            case 2:
                pralka.program = .BawelnaEko
                sterownik.zaczynaj()
            case 3:
                pralka.program = .Syntetyki
                sterownik.zaczynaj()
            default:
                pralka.program = .Wylaczona
                sterownik.zaczynaj()
        }
    }
}

class Sterownik {
    var pralka: PralkaProtocol
    var pompa_wejscie: Pompa_wejscie
    var silnik: Silnik
    var pompa_wyjscie: Pompa_wyjscie

    init(pralka: PralkaProtocol, pompa_wejscie: Pompa_wejscie, silnik: Silnik, pompa_wyjscie: Pompa_wyjscie) {
        self.pralka = pralka
        self.pompa_wejscie = pompa_wejscie
        self.silnik = silnik
        self.pompa_wyjscie = pompa_wyjscie
    }

    func zaczynaj() {
        print("\n\n--- Wybrano program: \(pralka.program).  --- \n--- W temperaturze: \(pralka.temperatura) stopni. ---\n\n")
        if(pralka.program == .Wylaczona) {
            return
        }
        if(pralka.program == .Bawelna || pralka.program == .BawelnaEko || pralka.program == .Syntetyki) {
            pompa_wejscie.przeplyw()
            silnik.pierz()
            pompa_wyjscie.przeplyw()
        }
        if(pralka.program == .Wirowanie) {
            silnik.wiruj()
        }
        print("Zakonczono pranie\n\n")
        sleep(2)
    }
}

protocol Pompa {
    func przeplyw()
}

class Pompa_wejscie: Pompa {
    func przeplyw() {
        sleep(1)
        print("Pobrano wode i detergenty")
        sleep(1)
    }
}

class Silnik {
    var obroty: Obroty
    init(obroty: Obroty) {
        self.obroty = obroty
    }
    func pierz() {
        var i = 0
        while i < 2 {
            obroty.obracanie()
            i+=1
        }
    }
    func wiruj() {
        var i = 0
        while i < 2 {
            obroty.obracanie()
            i+=1
        }
    }
}

class Obroty{
    func obracanie() {
        var i = 0
        while i < 2 {
            print("Pranie...")
            sleep(1)
            i+=1
        }
    }
}

class Pompa_wyjscie: Pompa {
    func przeplyw() {
        sleep(1)
        print("Odprowadzono wode i trwa płukanie")
        sleep(1)
    }
}

var pralkaMain = Pralka()
var pompa_wejscie = Pompa_wejscie()
var pompa_wyjscie = Pompa_wyjscie()
var obroty = Obroty()
var silnik = Silnik(obroty: obroty)
var sterownik = Sterownik(pralka: pralkaMain, pompa_wejscie: pompa_wejscie, silnik: silnik, pompa_wyjscie: pompa_wyjscie)
var wyswietlacz = Wyswietlacz(pralka: pralkaMain, sterownik: sterownik)
while(pralkaMain.program != .Wylaczona) {
    wyswietlacz.start()
}