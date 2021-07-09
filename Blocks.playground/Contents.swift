import UIKit
import PlaygroundSupport
/* блоки
 let dispatchItem = DispatchWorkItem {
 блок 1
 }
 DispatchQueue.main
 .async(execute:dispatchItem) // помещаем блок в очередь
 // уведомление об окончании работы
 dispatchItem.notify(queue: DispatchQueue.main) {
 print("блок закончен")
 }
 .wait() - подождать
 .cansel() - отмена выполнения блока
 flags - как исполняется
 tagret - переназначить очередь для объекта
*/
PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("performing workItem")
}
//workItem.perform()

let queue = DispatchQueue(label: "барьер", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))
queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("is completed")
}
workItem.isCancelled // проверка на начало работы
workItem.cancel() // если не начал

workItem.wait()


