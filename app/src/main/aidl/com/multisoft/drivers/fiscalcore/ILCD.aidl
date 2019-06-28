// ILCD.aidl
package com.multisoft.drivers.fiscalcore;

/*! Интерфейс управления дисплеем покупателя.
 * <para>MSPOS-T-Ф имеет дисплей покупателя.</para>
 * <para>Имя пакета (packageName) для подключения: <b>"com.multisoft.drivers.fiscalcore"</b></para>
 * <para>Имя компонента (componentName) для подключения: <b>"com.multisoft.fiscalcore"</b></para>
 * <para>Наименование действия (action) для Intent: <b>"com.multisoft.drivers.fiscalcore.ILCD"</b></para>
 */

interface ILCD
{
    /// <summary>
    /// <para>запрос версии интерфейса</para>
    /// <para>формат версии: Major.Minor.Release.Build;</para>
    /// <para>Major   - старшая версия aidl, изменение версии указвает на изменение порядка функций / их сигнатур;</para>
    /// <para>Minor   - младшая версия aidl, изменение версии указвает на добавление функции, обратная совместимость;</para>
    /// <para>Release - версия приложения, инкрементируется с релизом;</para>
    /// <para>Build   - версия сборки, выставляется автоматически в момент сборки;</para>
    /// </summary>
    /// <returns>строка, например, 1.0.0.12</returns>
    String GetAidlVersion();

    /// запрос готовности LCD. Выполняется  каждый раз перед началом работы, как в примере
    /// </summary>
    /// <returns>true - LCD готов. false - не готов</returns>
    ///  <example>
    ///        пример использования, выполняется перед началом работы:
    ///     <code>
    ///         //команды подключения к сервису
    ///         while(!ILCD.IsReady())
    ///                Thread.Sleep(2000);
    ///            //начало работы
    ///        </code>
    /// </example>
    boolean IsReady();

    /// <summary>
    /// настроить яркость подсветки. для MSPOS-Т-Ф возмоны только 0 (выкл) или 100(вкл)
    /// </summary>
    /// <param name="percentage">значение яркости в процентах</param>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean SetBacklight(int percentage);

    /// <summary>
    /// очистить дисплей
    /// </summary>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean ClearScreen();

    /// <summary>
    /// вывести текст на дисплей. строка прижимается влево
    /// </summary>
    /// <param name="message">строка текста</param>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean SetScreenText(String message);

    /// <summary>
    /// вывести изображение на дисплей. максимум: 128*40 пикселей.
    /// </summary>
    /// <param name="bmp">массив байт файла с изображением</param>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean SetScreenBitmap(in byte[] bmp);

    /// <summary>
    /// вывести текст на дисплей, с указанием размера. строка прижимается влево.
    /// </summary>
    /// <param name="line">текст для отображения</param>
    /// <param name="size">размер</param>
    /// <param name="doubleHeight">двойная высота символов</param>
    /// <returns>true - упешно. false - ошибка</returns>
	boolean SetScreenTextBySize(String line, int size, boolean doubleHeight);

    /// <summary>
    /// <para>вывести на дисплей несколько строк текста с указанием занимаемых пропорций экрана в высоту.</para>
    /// <para>Пример: пропорции {1, 2} делят экран в высоту на 3 части.</para>
    /// <para>Первая строка занимает 1/3 экрана, вторая - 2/3</para>
    /// <para>Размеры массивов должны совпадать</para>
    /// <para>Строки прижимаются влево. Рекомендуемый максимальный размер массивов: 4, иначе текст тяжело читаем.</para>
    /// </summary>
    /// <param name="lines">массив строк для вывода</param>
    /// <param name="proportions">массив сответствующих строкам пропорций в высоту</param>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean SetScreenMultiLine(in String[] lines, in int[] proportions);

    /// <summary>
    /// вывести на дисплей 2 строки. строки прижимаются влево.
    /// </summary>
    /// <param name="top">вверхняя строка</param>
    /// <param name="bottom">нижняя строка</param>
    /// <returns>true - упешно. false - ошибка</returns>
    boolean SetScreen2Lines(String top, String bottom);
}
