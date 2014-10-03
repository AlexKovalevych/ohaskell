----
title: Создаём проект
prevChapter: /ru/prepare/index.html
nextChapter: /ru/prepare/about-modules-minimum.html
----

Мы не можем начать изучение языка без испытательного полигона. Поэтому скачайте и установите [Haskell Platform](http://www.haskell.org/platform/).

В состав Haskell Platform входит два важнейших компонента, о которых вам нужно знать:

1. `ghc`, компилятор Haskell (Glasgow Haskell Compiler);
2. `ghci`, интерпретатор Haskell.

Запомнили? А теперь можете забыть. Особенно про интерпретатор. Ведь вы планируете использовать Haskell в реальной работе, а это значит, все ваши проекты будут компилироваться. Да, интерпретатор бывает полезен в ряде случаев, но без него вполне можно обойтись. Однако и непосредственное использование компилятора вам тоже едва ли понадобится.

В реальной работе вы не будете создавать файлик `Main.hs` на рабочем столе для последующего скармливания его компилятору. Напротив, вы создадите нормальный рабочий проект с логичной внутренней структурой. Так давайте и создадим такой с самого начала. А поможет нам в этом удобная утилита из Haskell Platform с необычным названием `cabal`. Эта утилита предназначена для сборки проектов. Уверен, вы слышали о вещах типа `cmake` или `qmake`, так вот воспринимайте `cabal` как `cmake` для Haskell.

Как вы уже поняли, `.hs` - стандартное расширение для файлов с исходным кодом на Haskell.

Начнём творить. Разумеется, все описываемые ниже действия подразумевают вашу крепкую дружбу с командной строкой. Я буду приводить Unix-овые команды, если же вы используете Windows - адаптируйте примеры под себя (лично я с 2008 года окончательно ушёл в мир Unix и про Windows уже давно забыл).

## Готовим структуру

Открываем терминал и творим:
```bash
$ mkdir -p Real/src/Utils
$ touch Real/src/Main.hs
$ touch Real/src/Utils/Helpers.hs
```
Итак, у нас появился каталог `Real` с привычной структурой: 
```bash
Real/
    src/
        Main.hs
        Utils/
            Helpers.hs
```
Есть корневой каталог `src`, внутри которой лежат все наши исходники, некоторым образом сгруппированные.

Кстати, об именах. Вам, вероятно, интересно, почему имена файлов и каталогов внутри каталога `src` начинаются с большой буквы? Чуть позже я объясню причину. А пока откроем файл `Main.hs` и напишем в нём:
```haskell
main = putStrLn "Hi, haskeller!"
```
Закрываем, возвращаемся в корень проекта.

## Настраиваем

На всякий случай, проверим нашу версию `cabal`:

```bash
$ cabal --version
cabal-install version 1.18.0.5
using version 1.18.1.4 of the Cabal library
```

Если у вас эта же версия или старше - прекрасно. Если младше - значит вы установили слишком старую версию Haskell Platform (не понятно, откуда вы вообще её взяли). На официальном сайте Haskell **обязательно** возьмите новую.

Теперь выполняем команду:
```bash
$ cabal sandbox init
```
Вы увидите что-то наподобие этого:
```bash
Writing a default package environment file to
/Users/dshevchenko/Profession/Learn/Real/cabal.sandbox.config
Creating a new sandbox at
/Users/dshevchenko/Profession/Learn/Real/.cabal-sandbox
```

Итак, наша песочница создана. Подробнее о том, что это такое и с чего это едят, я рассказываю в главе [О песочнице](http://ohaskell.dshevchenko.biz/ru/prepare/about-sandbox.html). А пока выполним следующую команду:

```bash
$ cabal init
```

Мы попадём в интерактивный диалог, в ходе которого нам будет предложено ответить на несколько вопросов о нашем проекте. В конце этого диалога будут автоматически созданы файлы проекта, и наш каталог приобретёт следующее содержимое:
```haskell
Real.cabal
Setup.hs
cabal.sandbox.config
src/
    Main.hs
    Utils/
        Helpers.hs
```
Кстати, если вдруг вы увидите вот такое предупреждение:
```bash
Generating LICENSE...
Warning: unknown license type, you must put a copy in LICENSE yourself.
```
не беспокойтесь. Просто добавьте файл `LICENSE` вручную, для поддержания классического вида проекта. Например, так:

```bash
$ wget -O LICENSE http://www.gnu.org/licenses/gpl-3.0.txt
```

Продолжим. Как уже было упомянуто, в корневом каталоге нашего проекта появились два новых файла, `Real.cabal` и `Setup.hs`. Второй файл нам не так интересен, а вот первый - это и есть сборочный файл нашего проекта. Откроем его:
```haskell
-- Initial Real.cabal generated by cabal init.  For further documentation, 
-- see http://haskell.org/cabal/users-guide/

name:                Real
version:             0.1.0.0
-- synopsis:            
-- description:         
license:             GPL-3
license-file:        LICENSE
author:              Denis Shevchenko
maintainer:          me@dshevchenko.biz
-- copyright:           
-- category:            
build-type:          Simple
-- extra-source-files:  
cabal-version:       >=1.10

executable Real
  -- main-is:             
  -- other-modules:       
  -- other-extensions:    
  build-depends:       base >=4.7 && <4.8
  hs-source-dirs:      src
  default-language:    Haskell2010
```
Здесь уже сохранены те самые значения, которые мы вводили в процессе вышеупомянутого диалога. Однако собрать проект прямо сейчас мы не сможем, потому что строка:
```haskell
  -- main-is:
```
закомментирована. В этом файле принят Haskell-подобный синтаксис, и поэтому однострочные комментарии здесь, как и в программном коде, начинаются с двух минусов подряд. Многострочный комментарий, который вам тоже понадобится, заключается между символами `{-` и `-}`.

Нам необходимо раскомментировать эту строку и прописать в ней имя файла `Main.hs`, содержащего функцию `main`:
```haskell
  main-is: Main.hs
```

## Конфигурируем

Выполняем:
```bash
$ cabal configure
```
В результате произойдёт подготовка проекта к сборке. Но прежде чем перейти к этой самой сборке, обращаю ваше внимание на последнюю часть файла `Real.cabal`:
```haskell
executable Real
  main-is:             Main.hs             
  -- other-modules:       
  -- other-extensions:    
  build-depends:       base >=4.7 && <4.8
  hs-source-dirs:      src
  default-language:    Haskell2010
```
Видите отступ в два пробела перед четырьмя последними строчками? Оказывается, этот отступ необходим, и без него проект не соберётся. Кроме того, отступ этот должен быть не менее двух пробелов. Я рекомендую четыре, для красоты. О важности отступов мы, кстати, поговорим в одной из будущих глав.

И ещё одна деталь. Это необязательно, но лишним не будет. Допишем в секцию executable Real ещё одну строку:
```haskell
  ghc-options:         -W
```
Параметр `ghc-options` позволяет задавать компиляторные флаги. В частности, флаг `-W` вежливо попросит `ghc` показывать все основные предупреждения при компиляции. Не стоит пренебрегать этой возможностью, поверьте мне на слово.

## Собираем

Выполняем:
```bash
$ cabal build
Resolving dependencies...
Configuring Real-0.1.0.0...
Building Real-0.1.0.0...
Preprocessing executable 'Real' for Real-0.1.0.0...
[1 of 1] Compiling Main             ( src/Main.hs, dist/build/Real/Real-tmp/Main.o )
Linking dist/build/Real/Real ...
```
Готово. В нашем каталоге появилось кое-что новенькое:
```bash
LICENSE
Real.cabal
Setup.hs
cabal.sandbox.config
dist/
    build/
        Real/
            Real  <- Это и есть исполняемый файл.
...
```
Остальное содержимое каталога `dist` нас пока не интересует.

## Запускаем

Пришло время запустить наше приложение. Находясь в корне проекта, выполняем:
```bash
$ ./dist/build/Real/Real
Hi haskeller!
```
Вот и всё. Теперь вы знаете, как создавать, настраивать и собирать Haskell-проект. Вероятно, вас интересует, зачем мы создавали файл `Helpers.hs` в подкаталоге `Utils`? Какой в нём смысл, если он всё равно остался пустым? В следующей главе вы это узнаете.
