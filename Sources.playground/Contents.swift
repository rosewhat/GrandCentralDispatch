import UIKit
import PlaygroundSupport

/* Источники отправки - низкоуровневые процессы
 times - переодические уведомления
 signal - уведомление o UNIX сигнале
 descriptor - уведомление о файловых или сокет операциях
 process - уведомление  о событиях связанных с процессом
 mach - уведомления о событиях связанных  с mach портом
 leaway запаздывание
 источник событий - источник отправки - обработка
 Этапы соддания dispatch source:
 1) Создаем источники отправки
 DispatchSource.makeTimerSource()
 
 2) Настраиваем источник отправки
 настраиваем обработчики событий или указываем временную информацию, если мы создаем таймер
 
 3) Назначаем нам обработчик отмены работы источника отправки
 опционально настр обработчик, который срабатывает при освобождении нашего источника отправки
 4) запускаем .resume для того, чтобы запустить процессы
 нужно запустить .resume() так как изначально источник отправки создается в состоянии ожидания
 */
PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "sources", attributes: .concurrent)
let timer = DispatchSource.makeTimerSource( queue: queue)

timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))

timer.setEventHandler {
    print("hello world")
}
// cansel
timer.setCancelHandler {
    print("Times is canselled")
}
// запуск
timer.resume()
