// STAN
enum Stan {
	case Zly, Lakomy, Zmeczony, Wykonczony
	mutating func next() {
		switch self {
			case .Zly: self = .Lakomy
			case .Lakomy: self = .Zmeczony
			case .Zmeczony: self = .Wykonczony
			case .Wykonczony: self = .Wykonczony
		}
	}
}

// OWCA
struct Owca {
	var siarka:Int
}

var stado = [2,1,1,1,2,2,1,2,1,2,1,2,2,1,3,1,2]

// SMOK
class Smok {
	var stan = Stan.Zly
	var zjedzona_siarka = 0;
	func powitaj(m: Mieszkaniec) {
		if (stan == Stan.Zly) {
			print("S: Arrrrr ")
	   		m.przypal()
		}
		else if (stan == Stan.Zmeczony) {
			print("S: Zzzzzz ");
		}
	}
	func smierc_smoka() {
		print("Smok niezyje")
	}
}

// MIESZKANIEC
struct Mieszkaniec {
   func powitaj(smoka s: Smok) {
        print("M: Witaj smoku ")
        s.powitaj(m: self)
      }
   func przypal() {
        print("M: Auuuu ")
      }
}

var x = 0
var smok = Smok()
var mieszkaniec = Mieszkaniec()
mieszkaniec.powitaj(smoka: smok)

while (smok.stan != Stan.Wykonczony) {
	if (smok.stan == Stan.Zly) {
		print(smok.stan)
		print("Szewc: Przygotuje owce z siarka ")
		smok.stan.next();
	}
	else if (smok.stan == Stan.Lakomy || smok.stan == Stan.Zmeczony) {
		print(smok.stan)
		for _ in 0 ... stado.count {
			smok.zjedzona_siarka += stado[x]
			x += 1
			if (smok.zjedzona_siarka > 9 && smok.zjedzona_siarka < 11) {
				
				print(smok.zjedzona_siarka)
				smok.stan.next();
				print(smok.stan)
			}
			else if (smok.zjedzona_siarka >= 20) {
				print(smok.zjedzona_siarka)
				smok.stan.next()
				print(smok.stan)
				print("\n")
				break
			}
		}
	}
}