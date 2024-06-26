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



# !!! closures !!!

