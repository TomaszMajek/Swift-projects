import Foundation

var tab = [Int]()
let semaphore = DispatchSemaphore(value: 1)

class Producer{
    static var count = 0
    var number:Int

    init(number:Int){
        self.number = number
    }

    func add() {
        semaphore.wait(timeout: DispatchTime.distantFuture)
        print("Dodano \(Producer.count) (producent nr \(self.number))")
        tab.append(Producer.count)
        Producer.count = Producer.count + 1
        semaphore.signal()
    }
}

class Consumer{
    var number:Int

    init(number:Int){
        self.number = number
    }

    func remove() {
        semaphore.wait(timeout: DispatchTime.distantFuture)
        defer{
            semaphore.signal()

        }
        guard !tab.isEmpty else {
            return
        }
        let num = tab.removeLast()
        print("Usunieto \(num) (konsument nr \(self.number))")
    }
}

let dispatchQueue = DispatchQueue(label: "testdt", attributes: .concurrent)

var producer_1 = Producer(number: 1)
var producer_2 = Producer(number: 2)
var producer_3 = Producer(number: 3)
var consumer_1 = Consumer(number: 1)
var consumer_2 = Consumer(number: 2)
var consumer_3 = Consumer(number: 3)

dispatchQueue.async {
    for _ in 0..<8{
        producer_1.add()
        producer_2.add()
        producer_3.add()
    }
}

dispatchQueue.async {
    for _ in 0..<8{
        consumer_1.remove()
        consumer_2.remove()
        consumer_3.remove()
    }
}
