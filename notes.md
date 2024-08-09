#  SnapKit


#  lazy var
ленивым свойством называется свойство, начальное значение которого не вычисляется до первого его использования, имеет ключевое слово lazy
ленивым свойством не может быть константа, только var
пример

допустим есть класс
class SomeClass {
    // в нем есть свойства
    let a = 1
    let b = 2
    let c = 3
}
если этот класс будет инициализирован, вмместе с ним будут инициализированны все три свойства. Что если нам нужно инициализировать только одно свойство
а остальные два инициализировать только при необходимости(just in time). для этого свойства b и c свойства необходимо пометить как lazy var

еще пример
struct Player {
    var name: String
    var height: Int
    
    lazy var intro = {
        return "Hello, this is \(name) and I'm \(height) cm tall"
    }
}
свойство intro должно возвращать конкретную инфу из name и height
можно вызвать intro и получить данные из String, это свойство сделано ленивым потому что на момент инициализации экземпляра класса данных еще нет
инициализация должна быть завершена до того как свойством intro будет получена информация из остальных свойств

создадим экземпляр класса Player
var tom = Player(name: "Tom", height: 170)
// и только когда этой свойство потребовалось мы его вызвали
print(tom.intro) // "Hello, this is Tom and I'm 170 cm tall"

# пример тяжелых вычислений
struct Calc {
    static func calcGames()-> Int {
        var games: [Int] = []
        for i in 1...4_000 {games.append(i)}
        return games.last!
    }
}

struct Player {
    var name: String
    var height: Int
    var gamesPlayed = Clac.calcGames() // если не сделать этой свойство lazy по при инициализации будут проводиться вычисления, которые не будут давать
    инициализироваться экземпляру структуры Player
    
    // но если сделать его lazy
    lazy var gamesPlayed = { // то экземпляр инициализируется сразу, а вычисления будут произведены при необходимости
        return Clac.calcGames()
    }()
    
    lazy var intro = {
        return "Hello, this is \(name) and I'm \(height) meters tall"
    }()
}
# в чем разница с вычисляемыми свойствами? 
вычисляемые свойства вычисляют значение внутри себя каждый раз когда к этим свойствам обращаются
lazy var хранит уже вычисленное значение, то есть каждый раз при обращении к lazy пересчета не будет, а будет выдан результат который уже вычислен
при первом обращении к нему и хранится в объекте
напоминалка var nameOfVar: Int {return} - computed property

# Область применения lazy var
например Delay expensive tasks, то есть какие-то тяжелые в вычислительном отношении задачи, обработка которых занимает много времени
используя подход с lazy var такие тяжелые процессы будут выполнены только когда это требуется, еще если этих задач несколько

# Ошибки использования
повсеместное использование lazy stored properies не является потокобезопасным, если к свойству lazy обращаются несколько потоков
одновременно и это свойство lazy еще не было инициализированно нет гарантий, что свойство будет инициализированно только один раз
это может привести к старнному поведению приложения




# Generics
Устраняют дубликацию кода создавая общее решение которое может производить различные операции над арзличными типами
Дженерики это универсальные методы которые позволяют выдавать в качестве результат своей работы различные типы данных
метод должен вернуть экземпляр модели но модель может быть любого типа, то есть метод должен возвращать экземпляр модели который требуется

func driveHome<T: Drivable>(vehicle: T) { // Drivable - Generic Constraint or protocol conformance
    // convention = single letter T, but it might be any word
    // T - generic
    // after the colon (T:) we constraining generic, we are telling it what protocol it has to conform to
    // in method driveHome T is a generic that conforms to protocol Drivable
    // (vehicle:) - might be any possible type as long as it conforms to protocol Drivable
}

e.g.
protocol Drivable {
    var motor: Bool
    var wheels: Bool
}
struct TeslaModelS: Drivable {
    var motor = true
    var wheels = true
}
Tesla class conform to protocol Drivable

Dive in deeper is in Generics.playground


# typealias
typealiases are the nicknames, link to something for example closures

пример использования‼️
public typealias Parameters = [String : Any]
var parameters: Parameters { get }

с замыканиями‼️
typealias SomeClosureFuctionality = (some closure body)
func someFunc(arg: String, completed: @escaping SomeClosureFuctionality)

might be helpful for TVDataSource & Delegate protocols, you can combine them with one object
e.g. typealias TableViewMethods = UITableViewDelegate & UITableViewDataSource
then use this typealias in extension SomeViewController: TableViewMethods
nickname for type



# associatedtype
when defining a protocol it's useful to declare one or more associated types as part of the protocol's definition.
An associated type gives a placeholder name to a type that's used as aprt of the protocol.
Dive in deeper is in associatedtype.playground


# Что такое nib?
В Swift термин "nib" обозначает файл интерфейса, созданный в Interface Builder, который используется для хранения
пользовательского интерфейса приложения. Файлы nib содержат информацию об элементах пользовательского интерфейса, их
расположении на экране, взаимосвязях между ними и другую информацию, необходимую для отображения интерфейса приложения.

Nib-файлы в Swift обычно имеют расширение ".xib" или ".nib" и используются для создания пользовательских интерфейсов в приложениях
для iOS, macOS. В коде Swift можно загружать и использовать nib-файлы для создания пользовательского
интерфейса программно или для настройки интерфейса из кода.

# CollectionViewFlowLayout
это класс который предоставляет стандартную реализацию пакета layout для UICollectionView.
он управляет расположением и отображением элементов коллекции в виде сетки или списка.
поддерживает такие настройки ячеек как размер, интервалы между ними, напрвление прокрутки, выравнивание элементов.
Он так же обеспечивает возможность настройки внешнего вида коллекции, например отступы между секциями и ячейками.

1️⃣ создать экземпляр коллекции
2️⃣ создать layout, настроить его(например layout.scrollDirection = .horizontal), передать в инициализатор в свойство "collectionViewLayout" 
3️⃣ опеределеннаяВьюха.addArrangedSubview(UICollectionView) - добавить коллекцию на вью
4️⃣ задать коллекции констрейнты
5️⃣ создать ячейку для коллекции, дать ей identifier, зарегать - UICollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
6️⃣ реализовать протоколы UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout.
7️⃣ в UICollectionViewDelegateFlowLayout реализовать sizeForItemAt, minimumLineSpacingForSectionAt, minimumInteritemSpacingForSectionAt, insetForSectionAt


# collection cells
addSubview(stack)
stack.addArranged(label)
did set - mock data for labels
сверстать переиспользуемую ячейку для "следующие часы" которых 10 или более в коллекции
поработать над ячейками на страницах внизу над pageControl
pageControl работа при вращении всех ячеек сделать реакцию только на нижние

# focusGroupIdentifier
отделяем одну секцию где 1+10 ячеек от коллекции с тремя ячейками внизу над pageControl


# Памятка для создания UITableView приложения
**Написание кода**:
   - Откройте файл ViewController.swift.
   - Убедитесь, что класс ViewController наследуется от UIViewController и протоколов UITableViewDataSource и UITableViewDelegate.
   - Добавьте свойства для UITableView и данных, например:
     
     var tableView: UITableView!
     var data = ["Item 1", "Item 2", "Item 3"]
     
   - В методе viewDidLoad инициализируйте UITableView и добавьте его на экран:
     
     tableView = UITableView(frame: view.bounds)
     view.addSubview(tableView)
     tableView.dataSource = self
     tableView.delegate = self
     
   - Реализуйте методы протоколов UITableViewDataSource и UITableViewDelegate для отображения данных в таблице:
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
         cell.textLabel?.text = data[indexPath.row]
         return cell
     }


# Codable
Протокол Codable в Swift представляет собой объединение двух других протоколов: Encodable и Decodable. 
Codable позволяет типу данных быть кодируемым (Encodable) и декодируемым (Decodable), что обеспечивает 
простой способ сериализации и десериализации данных в формат JSON, Plist и другие форматы.

Когда вы объявляете структуру или класс в Swift и хотите, чтобы они могли быть преобразованы в JSON (или другой формат) и обратно, 
вы можете применить протокол Codable. Для этого необходимо, чтобы все свойства вашей структуры или класса также были Codable.

Пример:

struct Person: Codable {
    var name: String
    var age: Int
}

let person = Person(name: "Alice", age: 30)

// Кодирование (Encoding)
let jsonEncoder = JSONEncoder()
if let jsonData = try? jsonEncoder.encode(person) {
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
}

// Декодирование (Decoding)
let jsonString = """
{
    "name": "Bob",
    "age": 25
}
"""

if let jsonData = jsonString.data(using: .utf8) {
    let jsonDecoder = JSONDecoder()
    if let decodedPerson = try? jsonDecoder.decode(Person.self, from: jsonData) {
        print(decodedPerson)
    }
}

Протокол Codable позволяет легко работать с данными в различных форматах, делая процесс кодирования и декодирования более удобным и безопасным.


# Json
JSON (JavaScript Object Notation) — это формат обмена данными, основанный на синтаксисе языка JavaScript.
JSON представляет собой текстовый формат, который легко читается как человеком, так и компьютером. 
Он часто используется для передачи структурированных данных между веб-сервером и клиентом, а также в различных приложениях.

Основные характеристики JSON:

1. **Простота чтения и записи**: JSON представляет данные в виде пар "ключ: значение", что делает его легко читаемым и понятным.

2. **Легковесность**: JSON является легковесным форматом данных, что означает, что он занимает меньше места в сравнении с другими форматами, такими как XML.

3. **Поддержка различных типов данных**: JSON поддерживает различные типы данных, такие как строки, числа, логические значения, массивы и объекты.

Пример JSON-структуры:
{
    "name": "John Doe",
    "age": 30,
    "isStudent": false,
    "hobbies": ["reading", "traveling"],
    "address": {
        "street": "123 Main Street",
        "city": "New York"
    }
}


В этом примере объект содержит имя, возраст, статус студента, список хобби и адрес. 
JSON может быть вложенным, что позволяет представлять сложные структуры данных.

JSON широко используется во многих областях, таких как веб-разработка, API (интерфейсы программирования приложений), 
обмен данными между приложениями и многое другое. В языке программирования Swift, 
например, JSON часто используется для передачи данных между сервером и мобильным приложением.


# URLSession
Playgrounds open in finder


# MVC
MVC (Model-View-Controller) — это популярная архитектурная концепция, которая используется для разделения кода на три основных компонента: модель (Model), представление (View) и контроллер (Controller). Давайте рассмотрим каждый компонент подробнее:

1. Модель (Model):
   - Модель представляет собой данные вашего приложения и логику работы с этими данными.
   - Она отвечает за обработку данных, взаимодействие с базой данных, сетевыми запросами и другими операциями, не связанными с отображением.
   - Модель не должна содержать никакой информации о том, как эти данные будут отображаться.

2. Представление (View):
   - Представление отвечает за отображение данных пользователю и взаимодействие с пользователем.
   - Оно может быть представлением пользовательского интерфейса (например, экраны, кнопки, таблицы и т. д.).
   - Представление не должно содержать бизнес-логики или прямого доступа к данным.

3. Контроллер (Controller):
   - Контроллер действует как посредник между моделью и представлением.
   - Он обрабатывает действия пользователя, обновляет модель и обновляет представление в соответствии с изменениями в модели.
   - Контроллер может также содержать некоторую логику, связанную с управлением потоком приложения.

Преимущества MVC:
- Отделение ответственностей: MVC помогает разделить различные аспекты приложения, что делает код более организованным и легким для поддержки.
- Повторное использование кода: Благодаря разделению на компоненты, вы можете повторно использовать модели, представления и контроллеры в других частях приложения.
- Улучшенная расширяемость: Изменения в одной части приложения обычно не затрагивают другие части, что упрощает добавление новых функций.

Недостатки MVC:
- Тяжелая зависимость представления от контроллера: В классической реализации MVC представление прямо связано с контроллером, что может привести к проблемам с тестированием и сложности в поддержке.
- Массивный контроллер: В некоторых случаях контроллер может стать слишком громоздким из-за его множества обязанностей.


# YandexWeather API key
6184a09d-4b23-4d7f-ab6d-06182e8ee20c


# Completion Handlers:
Completion handlers в Swift — это замыкания (closures), которые передаются в функцию в качестве
аргумента и вызываются после завершения выполнения функции. Они используются для обработки результатов
асинхронных операций, таких как загрузка данных из сети, выполнение запросов к базе данных и другие длительные операции.

func printSome(completion: (String) -> Void) { // func take closure as an argument
    let result = "Готово"
    completion(result)
}

printSome { message in // message is a temporary var, name as u like
    print(message)
}


# @escaping:
По умолчанию замыкания, переданные в качестве аргументов функции, являются non-escaping, 
что означает, что они должны быть вызваны до завершения выполнения функции. Однако, если 
замыкание может быть сохранено за пределами выполнения функции (например, сохранено в 
свойстве класса или передано в другую функцию), то оно должно быть помечено как @escaping.

var completionHandlers: [() -> Void] = [] //массив функций, которые не принимают аргументы и не возвращают значение

func someFunctionWithEscapingClosure(completion: @escaping () -> Void) { // создаем метод
    completionHandlers.append(completion) ловим значение аргумента completion
}

func someOtherFunction() {
    someFunctionWithEscapingClosure {
        print("Замыкание сохранено в массиве")
    }
}

someOtherFunction()

completionHandlers.first?()

# Тип Result<Data, Error>
1. Result - это перечисление (enum). Оно представляет результат выполнения операции, 
который может быть успешным или неудачным.

2. В типе Result<Data, Error>, Data представляет успешный результат операции, 
а Error представляет ошибку, которая может возникнуть в процессе выполнения операции.

3. **Использование:**
   - При успешном выполнении операции используется .success(data) для хранения данных.
   - При возникновении ошибки используется .failure(error) для хранения ошибки.
   
protocol NetworkManagerProtocol {
    func fetchWeather(completion: @escaping (Result<Data, Error>) -> Void)
}
Здесь метод fetchWeather принимает замыкание completion, которое принимает аргумент типа
Result<Data, Error>. При успешном выполнении операции метод должен вызывать замыкание 
с .success(data), где data содержит данные о погоде в формате Data. В случае ошибки метод 
должен вызывать замыкание с .failure(error), где error представляет ошибку типа Error.


# Значение протокола по умолчанию
В Swift протоколам нельзя напрямую задавать значения по умолчанию для свойств, 
как это можно делать в обычных классах или структурах. Однако существует способ 
обойти это ограничение, используя расширения протоколов.

protocol MyProtocol {
    var myProperty: Int { get set }
}

extension MyProtocol {
    var myProperty: Int {
        return 10 // Значение по умолчанию
    }
}

struct MyClass: MyProtocol {
    // Нет необходимости реализовывать myProperty здесь
}

let myObject = MyClass()
print(myObject.myProperty) // Выведет: 10

в данном приложении значение по умолчанию baseURL протокола Routing используется при создании endPoint ссылки на данные
погоды. подписывая endPoint под Routing внутри endPoint нет необходимости реализовывать свойство baseUrl. при этом при необходимости
это свойство можно переопределить


# httpMethod
1. **GET**: Используется для запроса данных с сервера. GET-запросы обычно используются для получения информации и не должны изменять данные на сервере.

2. **POST**: Используется для отправки данных на сервер для создания новых ресурсов. POST-запросы обычно используются для отправки данных формы или загрузки файлов.

3. **PUT**: Используется для обновления существующего ресурса на сервере. PUT-запросы заменяют существующий ресурс новыми данными.

4. **DELETE**: Используется для удаления ресурса на сервере. DELETE-запросы удаляют указанный ресурс.

5. **PATCH**: Используется для частичного обновления ресурса на сервере. PATCH-запросы обновляют только указанные атрибуты ресурса, не затрагивая остальные.

В Swift вы можете использовать HTTP-методы при выполнении сетевых запросов с помощью классов и методов, предоставляемых фреймворками, такими как URLSession. Например, чтобы отправить GET-запрос, вы можете использовать следующий код:

let url = URL(string: "https://api.example.com/data")!
var request = URLRequest(url: url)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    // Обработка ответа от сервера
}
task.resume()


Аналогично, для отправки POST-запроса:

let url = URL(string: "https://api.example.com/data")!
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.httpBody = "key1=value1&key2=value2".data(using: .utf8)

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    // Обработка ответа от сервера
}
task.resume()


# API
API (Application Programming Interface) представляет собой набор определенных правил 
и инструкций, которые позволяют различным программам взаимодействовать между собой. 
Основные свойства API включают в себя:

1. Интерфейс: API определяет интерфейс, через который происходит взаимодействие между 
различными программами. Этот интерфейс определяет доступные методы и структуры данных для обмена информацией.

2. Структурированность: API обычно предоставляет структурированные данные в формате, 
который легко понять и обрабатывать. Это может быть JSON, XML или другие форматы.

3. Документация: Хорошие API поставляются с документацией, которая описывает доступные 
методы, параметры запросов, ожидаемые ответы и примеры использования.

4. Авторизация и безопасность: API может требовать аутентификации для доступа к некоторым 
методам или ресурсам. Также API должны быть защищены от злоумышленников.

5. Версионирование: Поскольку API могут изменяться со временем, важно иметь систему версионирования, 
чтобы обеспечить обратную совместимость и управление изменениями.

Элементы тела запроса (payload) могут включать в себя следующие компоненты:

1. Метод запроса (HTTP-метод): Указывает на тип операции, которую необходимо выполнить (GET, POST, PUT, DELETE и т. д.).

2. Заголовки (Headers): Передают метаданные запроса, такие как тип контента, авторизация, куки и другие параметры.

3. Тело запроса (Body): Содержит данные, которые отправляются на сервер. Это может быть JSON, XML, форма с данными или другой формат.

4. Параметры запроса (Query Parameters): Дополнительные параметры, передаваемые в URL для уточнения запроса (например, фильтры, сортировка).

5. Путь запроса (Path): Часть URL, которая указывает на конкретный ресурс или действие на сервере.

# Example
1. **Метод запроса (HTTP-метод)**:
   - **GET**: Используется для получения данных с сервера. Например, запрос списка всех пользователей: GET /api/users.
   - **POST**: Используется для отправки данных на сервер для создания новых ресурсов. Например, создание нового пользователя: POST /api/users.
   - **PUT**: Используется для обновления существующих ресурсов на сервере. Например, обновление информации о пользователе: PUT /api/users/123.
   - **DELETE**: Используется для удаления ресурсов на сервере. Например, удаление пользователя: DELETE /api/users/123.

2. **Заголовки (Headers)**:
   - Пример заголовка Content-Type для указания типа содержимого: Content-Type: application/json.
   - Пример заголовка Authorization для аутентификации: Authorization: Bearer <token>.

3. **Тело запроса (Body)**:
   - Пример JSON тела запроса для создания нового пользователя:
     
     {
       "name": "John Doe",
       "email": "john.doe@example.com",
       "age": 30
     }
     

4. **Параметры запроса (Query Parameters)**:
   - Пример параметров запроса для фильтрации списка пользователей по статусу активности: GET /api/users?status=active.
   - Еще один пример с параметрами запроса для пагинации: GET /api/users?page=2&limit=10.

5. **Путь запроса (Path)**:
   - Пример пути запроса для конкретного пользователя с идентификатором 123: GET /api/users/123.
   - Другой пример пути запроса для обновления информации о пользователе с идентификатором 456: PUT /api/users/456.

Эти компоненты тела запроса вместе определяют, как клиентская программа взаимодействует с сервером через API. 
Правильное формирование каждого компонента помогает серверу правильно интерпретировать запрос и обработать его 
в соответствии с требуемыми действиями.


# Как энкодятся запросы к API
Энкодятся они тремя методами
1-JSON Encoder
2-URL Encoding
3-JSON&URL Encoding

query говорит нам о том что все передается внтури URL

# API Respond Model


struct WeatherData: Codable {
    let now: Int
    let now_dt: String
    let info: Info
    let fact: Fact
    let forecast: Forecast
}

struct Info: Codable {
    let url: String
    let lat: Double
    let lon: Double
}

struct Fact: Codable {
    let obs_time: Int
    let temp: Int
    let feels_like: Int
    let icon: String
    let condition: String
    let wind_speed: Double
    let wind_dir: String
    let pressure_mm: Int
    let pressure_pa: Int
    let humidity: Int
    let daytime: String
    let polar: Bool
    let season: String
    let wind_gust: Double
}

struct Forecast: Codable {
    let date: String
    let date_ts: Int
    let week: Int
    let sunrise: String
    let sunset: String
    let moon_code: Int
    let moon_text: String
    let parts: [WeatherPart]
}

struct WeatherPart: Codable {
    let part_name: String
    let temp_min: Int
    let temp_avg: Int
    let temp_max: Int
    let wind_speed: Double
    let wind_gust: Double
    let wind_dir: String
    let pressure_mm: Int
    let pressure_pa: Int
    let humidity: Int
    let prec_mm: Double
    let prec_prob: Int
    let prec_period: Int
    let icon: String
    let condition: String
    let feels_like: Int
    let daytime: String
    let polar: Bool
}

# надо собрать ссылку
https://yastatic.net/weather/i/icons/funky/dark/<значение из поля icon>.svg
