import UIKit
import PlaygroundSupport
/* Семафоры - ограничивают потоки секций
 
 lry semaphore = DispatchSemaphore(0) // подать сигнал
 semapthore.wait() // пока значение не станет полож
 semaphore.signal() - уведомление о том, что можем запустить в данную секцию еще один поток
 */
PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "semaphore", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 0) // кол во потоков разрешаем - 2
// 0 // 0 - 1 - 0 - 1 - 0 - 1 - 2
semaphore.signal()
queue.async {
    semaphore.wait(timeout: .distantFuture) // бесконечно
    
    Thread.sleep(forTimeInterval: 4) // будет исполняться 4сек
    print("Block 1")
    semaphore.signal() // можно заходить
}
queue.async {
    semaphore.wait(timeout: .distantFuture) // бесконечно
    
    Thread.sleep(forTimeInterval: 2) // будет исполняться 4сек
    print("Block 2") 
    semaphore.signal() // можно заходить
}
queue.async {
    semaphore.wait(timeout: .distantFuture) // бесконечно
    print("Block 3")

    semaphore.signal() // можно заходить
}
queue.async {
    semaphore.wait(timeout: .distantFuture) // бесконечно
    
    print("Block 4" )
    semaphore.signal() // можно заходить
}
