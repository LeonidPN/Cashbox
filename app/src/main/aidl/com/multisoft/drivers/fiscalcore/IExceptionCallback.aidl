// IExceptionCallback.aidl
package com.multisoft.drivers.fiscalcore;

/// <summary>
/// Коллбек об ошибке.
/// </summary>
interface IExceptionCallback
{
    /// <summary>
    /// Обработчик ошибок. Если при выполнении функции произошла ошибка, будет вызван коллбек HandleException
    /// </summary>
    /// <param name="errCode">Код ошибки com.multisoft.drivers.fiscalcore.ErrCode</param>
    /// <param name="message">Сообщение об ошибке. Группы ошибок WrongStatus, Hardware, Printer, WrongArgument а также большинство Generic переведены на русски язык.</param>
    /// <param name="extErrCode">Расширенный код ошибки, см. com.multisoft.drivers.fiscalcore.ErrCode</param>
    /// <param name="stackTrace">Стек ошибки</param>
    void HandleException(int errCode, String message, int extErrCode, String stack);
}
