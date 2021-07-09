import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/* группы отправки
 let concurrentQueue = DispathcQueue(
 label: concurrent,
 qos: ".userInteractive,
 attributes: .concurrent)
 
 let taskGroupBlue = DispatchGroup()
 
 concurrentQueue.async(group: taskBlueGroup) {
 // тут выполняться первый блок(например)
 }
 taskGroupBlue.notify(queue: DispatchQueue.main) {
 print("Закончил работу")
 }
 
 let taskGroup = DispatchGroup()
 taskGroup.enter()
 // группа
 taskGroup.leave()
 
 taskGroup.notufy(queue: DispatchQueue.main) {
 print("выполнено")
 }
 
 taskGroup. wait()
 taskGroup.wait(timeout: .now() +3) // начинаем отчет с того момента, как начали выполнять код
 
 */
let queue = DispatchQueue(label: "concurrent", attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("все закончено на группе")
}

let secondGroup = DispatchGroup()
secondGroup.enter()
queue.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
            sleep(2) // время
            secondGroup.leave() // выходим из группы
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 3)
print(result)

secondGroup.notify(queue: .main) {
    print("2 группа")
}
print("эта строка выше всех ")

secondGroup.wait() // выполнение кода не начинает пока в 2 группах не пройдет
