import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true // не заканчивал работу

/* Новая очередь. Барьеры отправки

DispatchQueue(label: "concurrentQueue",qos: .default, attributes: .concurrent,)
DispatchQueue(label: "serialQueue")
 Race condition - результат исполнения кода зависит от последовательности операции внутри него
 */
class SaveArray <Element>  {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) { // другие операции не заполняются из за барьера
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]() // значение пустой массив
        queue.sync { // ожидаем ответ синхронно
            result = self.array
        }
        return result
    }
}

var saveArray = SaveArray <Int> ()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    saveArray.append(element: index)
} // паралл запросы
print(saveArray.elements) // тут получаем элементы


var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    array.append(index)
} // паралл запросы
print(array)
