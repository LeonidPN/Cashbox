// IFiscalCore.aidl
package com.multisoft.drivers.fiscalcore;

import com.multisoft.drivers.fiscalcore.IAuth;
import com.multisoft.drivers.fiscalcore.IExceptionCallback;

/*! \mainpage Интерфейс фискального ядра IFiscalCore
 *
 * \section intro_sec Введение
 * Данная документация описывает интерфейс фискального ядра (ФЯ)
 * предназначена для разработчиков, выполняющих интеграцию учётных программ с фискальным ядром.
 * Необходимы базовые знания <a href="https://developers.google.com/training/courses/android-fundamentals">Adnroid</a>,
 * <a href="https://developer.android.com/reference/android/app/Activity.html">Activity</a>,
 * <a href="https://developer.android.com/reference/android/app/Application.html">Application</a>,
 * <a href="https://developer.android.com/reference/android/content/Intent.html">Intent</a>,
 * <a href="https://developer.android.com/guide/components/services.html">services</a>,
 * <a href="https://developer.android.com/guide/components/aidl">AIDL</a>
 *
 * \subsection b4start_sec Перед началом работы
 * <para>Ознакомьтесь с  <a href="http://doc.multisoft.ru/doc/MSPOS/Examples/">примерами</a> для Android- и VisualStudio</para>
 * <para>Загрузите и добавьте в проект  <a href="http://doc.multisoft.ru/doc/MSPOS/">файлы описания интерфейсов *.aidl</a></para>
 * Вы можете модифицировать проекты с примерами, но не забудьте обновить файлы описания интерфейсов!
 * <para>Изучите наш <a href="http://77.243.109.96:8881/redmine/projects/mspos-k/wiki/QA">QA</a>, там все ответы на самые частые вопросы.</para>
 *
 * \subsection models_sec Поддерживаемые модели
 * <para>В настоящий момент Фискальное ядро установлено на следующие модели ККТ: <b>MSPOS-K, MSPOS-T-Ф, MSPOS-Е-Ф</b>.</para>
 * <para>Им соответствуют строковые константы моделей (<a href="https://developer.android.com/reference/android/os/Build.html#MODEL">Build.MODEL</a>) устройств:</para>
 * <para><b>MSPOS-K: <code>"V1S-G", "V1S", "V2"</code></b></para>
 * <para><b>MSPOS-T-Ф: <code>"T1MINI-G", "T1MINI"</code></b></para>
 * <para><b>MSPOS-Е-Ф: <code>"P1_4G", "P1_4G-G", "P1_4G-EU"</code></b></para>
 *
 * \subsection connection_sec Подключение к фискальному ядру
 * <para>Подключение к интерфейсу фискального ядра IFiscalCore осуществляется при помощи <a href="https://developer.android.com/reference/android/content/Intent.html">Intent</a></para>
 * <para>Имя пакета (packageName) для подключения: <b>"com.multisoft.drivers.fiscalcore"</b></para>
 * <para>Имя компонента (componentName) для подключения: <b>"com.multisoft.fiscalcore"</b></para>
 * <para>Наименование действия (action) для Intent: <b>"com.multisoft.drivers.fiscalcore.IFiscalCore"</b></para>
 * <para>После получения интерфейса ФЯ необходимо дождаться его инициализации при помощи функции IFiscalCore.IsReady.</para>
 * <para>После успешной инициализации можно начинать межпроцессное взаимодействие с ФЯ вызовом функций AIDL.</para>
 *
 * \subsection lcd_sec Подключение к дисплею покупателя ILCD
 * <para>Интерфейс дисплея покупателя ILCD</para>
 * <para>MSPOS-T-Ф имеет дисплей покупателя.</para>
 * <para>Подключение производится аналогично IFiscalCore, за исключением:</para>
 * <para>Наименование действия (action) для Intent: <b>"com.multisoft.drivers.fiscalcore.ILCD"</b></para>
 *
 * \subsection enums_sec Используемые перечисления
 *
 *  com.multisoft.drivers.fiscalcore
 *
 * \subsection info_sec Общая информация
 * Если в процессе выполнения функции произошло прерывание, вызывается переданный в неё коллбек IExceptionCallback (если объявлен и не null),
 * В этом случае на на выход функции передаётся, по возможности, заведомо некорректное значение.
 * Для целочисленных переменных это -1, для строк - пустая строка, для булевых - false.
 *
 * \section structure_sec Структура
 *
 * \subsection main_sec Основные команды ядра
 * <para>В этом блоке находятся команды запроса версии, проверки готовности интерфейса фискального ядра и автотестирования</para>
 * <para>IFiscalCore.IsReady</para>
 * <para>IFiscalCore.GetAidlVersion</para>
 * <para>IFiscalCore.SelfTest</para>
 *
 * \subsection service_sec Сервисные команды
 * <para>IFiscalCore.SetSerial</para>
 * <para>В том числе команды для внутреннего использования (на момент 1.5.24): </para>
 * <para>IFiscalCore.GetUUID</para>
 * <para>IFiscalCore.GetFiscalModuleVersion</para>
 * <para>IFiscalCore.FNResetDebug</para>
 * <para>IFiscalCore.LoggerControl</para>
 * <para>IFiscalCore.DirectIO</para>
 *
 * \subsection local_sec Локализация
 * <para>Опционально: установка локализации перед началом работы.</para>
 * <para>По умолчанию: Ru-ru</para>
 * <para>Поддерживаемые локализации: Ru-ru, в разработке En-en</para>
 * <para>Запрос локализации осуществляется через IFiscalCore.GetLang</para>
 * <para>Установка локализации осуществляется через Intent.PutExtras перед подключением к ядру</para>
 *
 * \subsection kktstat_sec Статус ККТ
 * <para>IFiscalCore.GetRegNum</para>
 * <para>IFiscalCore.GetSerial</para>
 * <para>IFiscalCore.GetAppVersion</para>
 * <para>IFiscalCore.GetTaxId</para>
 * <para>IFiscalCore.GetKKTRegisteredName</para>
 * <para>IFiscalCore.GetDayPayTotalByDocType</para>
 * <para>IFiscalCore.GetFiscalMemoryFiscalized</para>
 * <para>IFiscalCore.GetGrandTotalsSalesGross</para>
 *
 * \subsection fnstat_sec Чтение статуса ФН
 * <para>IFiscalCore.FNGetNumber</para>
 * <para>IFiscalCore.FNGetState</para>
 * <para>IFiscalCore.FNGetWarningFlags</para>
 * <para>IFiscalCore.FNGetCurrentDocType</para>
 * <para>IFiscalCore.FNGetDocDataStatus</para>
 * <para>IFiscalCore.FNGetLastDocDateTime</para>
 * <para>IFiscalCore.FNGetSoftwareVersion</para>
 * <para>IFiscalCore.FNGetFirmwareType</para>
 * <para>IFiscalCore.FNGetLastFDNumber</para>
 * <para>IFiscalCore.FNGetLifetime</para>
 * <para>IFiscalCore.FNGetRegistrationsMade</para>
 * <para>IFiscalCore.FNGetRegistrationsLeft</para>
 * <para>IFiscalCore.FNGetRegTimeFirst</para>
 * <para>IFiscalCore.FNGetRegTimeByNum</para>
 * <para>IFiscalCore.FNGetLastFDNum</para>
 * <para>IFiscalCore.FNGetLastFiscalSign</para>
 * <para>IFiscalCore.FNGetRegTaxSystemByNum</para>
 * <para>IFiscalCore.FNGetOpModeByNum</para>
 * <para>IFiscalCore.FNGetRegFDByNum</para>
 * <para>IFiscalCore.GetAgentTag</para>
 *
 * \subsection ofdstat_sec Состояние ОФД
 * <para>IFiscalCore.OFDGetConnectionStatus</para>
 * <para>IFiscalCore.OFDGetQueuedMessagesCount</para>
 * <para>IFiscalCore.OFDGetMessageStatus</para>
 * <para>IFiscalCore.OFDGetFirstQueuedDocNumber</para>
 * <para>IFiscalCore.OFDGetLastNotSentDocTime</para>
 *
 * \subsection shiftstat_sec Состояние смены
 * <para>IFiscalCore.GetDayState</para>
 * <para>IFiscalCore.GetDayNumber</para>
 * <para>IFiscalCore.GetDayLastReceiptNumber</para>
 *
 * \subsection shiftstatreports_sec Состояние смены: отчёты
 * <para>IFiscalCore.PrintXReport</para>
 * <para>IFiscalCore.GetDayCanceledTotal</para>
 * <para>IFiscalCore.GetDayPayCount</para>
 * <para>IFiscalCore.GetDayOpenDateTime</para>
 * <para>IFiscalCore.GetDayPayTotal</para>
 * <para>IFiscalCore.GetPayTotal</para>
 *
 * \subsection reg_sec Регистрация
 * <para>IFiscalCore.Register</para>
 * <para>IFiscalCore.CorrectRegistration</para>
 * <para>IFiscalCore.CloseFiscalMode</para>
 *
 * \subsection shift_sec Смена
 * <para>IFiscalCore.OpenDay</para>
 * <para>IFiscalCore.CloseDay</para>
 * <para>IFiscalCore.PrintCalculationsReport</para>
 *
 * \subsection rec_sec Чек
 * <para>IFiscalCore.OpenRec</para>
 * <para>IFiscalCore.GetRecType</para>
 * <para>IFiscalCore.GetRecState</para>
 * <para>IFiscalCore.SetTaxationUsing</para>
 * <para>IFiscalCore.GetTaxation</para>
 * <para>IFiscalCore.CloseRec</para>
 * <para>IFiscalCore.PrintRecItemPay</para>
 * <para>IFiscalCore.PrintLine</para>
 * <para>IFiscalCore.RecVoid</para>
 * <para>IFiscalCore.PrintQRCode</para>
 * <para>IFiscalCore.PrintBarCode</para>
 * <para>IFiscalCore.Feed</para>
 * <para>IFiscalCore.SetTagAttribute</para>
 * <para>IFiscalCore.SetAgentTagUsing</para>
 * <para>IFiscalCore.SetFont</para>
 * <para>IFiscalCore.PrintRaster</para>
 * <para>IFiscalCore.PrintLineAligned</para>
 * <para>IFiscalCore.OpenDrawer</para>
 * <para>IFiscalCore.SetPaperWidth</para>
 * <para>IFiscalCore.SetTagByteAttribute</para>
 * <para>IFiscalCore.SetItemTaxes</para>
 * <para>IFiscalCore.SetShowTaxes</para>
 * <para>IFiscalCore.PrintRecItem</para>
 *
 * \subsection payhelp_sec Итог
 * <para>IFiscalCore.GetRecTotal</para>
 * <para>IFiscalCore.CheckDrawerCash</para>
 * <para>IFiscalCore.PrintRecTotal</para>
 * <para>IFiscalCore.GetRecPayTotal</para>
 * <para>IFiscalCore.PrintRecTotalRound</para>
 *
 * \subsection corrrec_sec Чек коррекции
 * <para>IFiscalCore.FNMakeCorrectionRec</para>
 * <para>IFiscalCore.SetSumTaxes</para>
 *
 * \subsection ofqueryinfo_sec Запрос информации о подтверждении документа от ОФД
 * <para>IFiscalCore.QueryOFDReceiptByNum</para>
 * <para>IFiscalCore.OfdOut_GetTime</para>
 * <para>IFiscalCore.OfdOut_GetFDNumber</para>
 * <para>IFiscalCore.OfdOut_GetFiscalSign</para>
 * <para>IFiscalCore.OfdOut_GetSize</para>
 *
 * \subsection archive_sec Работа с архивом ФН
 * <para>IFiscalCore.QueryFiscalDocInfo</para>
 * <para>IFiscalCore.FDI_GetDocType</para>
 * <para>IFiscalCore.FDI_GetConfirmFromOFD</para>
 * <para>IFiscalCore.FDI_GetDataArray</para>
 * <para>IFiscalCore.FDI_GetFiscalSign</para>
 * <para>IFiscalCore.FDI_GetDate</para>
 * <para>IFiscalCore.FDI_GetDocJSON</para>
 * <para>IFiscalCore.GetRegistrationParameter</para>
 *
 * \subsection archiveprint_sec Печать из архива
 * <para>IFiscalCore.FNPrintDocFromArchive</para>

 * \subsection setparams_sec Запрос и установка параметров
	<para>Данный блок методов позволяет настраивать параметры ККТ в режиме реального времени.</para>
    <para>Чтобы при следующей загрузке ядра настройки были применены, их нужно сохранить функцией IFiscalCore.SaveOptions</para>
    <para>Порядок изменения параметров, указанных при регистрации:
	http://77.243.109.96:8881/redmine/projects/mspos-k/wiki/QA#Q11
	</para>
 *  <para>В этом блоке находятся методы для настройки аппарата перед регистрацией.</para>
 *  <para>Под "пользователем" следует понимать организацию - пользователя ККТ</para>

 * \subsection ofdsettings_sec Параметры ОФД
 *
 * <para><b>Установка параметров ОФД</b></para>
 * <para>IFiscalCore.SetOfdHost</para>
 * <para>IFiscalCore.SetOfdPort</para>
 * <para>IFiscalCore.SetOfdName</para>
 * <para>IFiscalCore.SetOfdTaxId</para>
 *
 * <para><b>Запрос параметров ОФД</b></para>
 * <para>IFiscalCore.GetOfdHost</para>
 * <para>IFiscalCore.GetOfdPort</para>
 * <para>IFiscalCore.GetOfdName</para>
 * <para>IFiscalCore.GetOfdTaxId</para>

 * \subsection mainsettings_sec Основные настройки
 *
 * <para><b>Установка основных настроек</b></para>
 * <para>IFiscalCore.SetOrgName</para>
 * <para>IFiscalCore.SetOrgAddress</para>
 * <para>IFiscalCore.SetPhysicalAddress</para>
 * <para>IFiscalCore.SetSenderEmail</para>
 * <para>IFiscalCore.SetReceiptCheckURI</para>
 * <para>IFiscalCore.SetFnsServerAddress</para>
 * <para>IFiscalCore.SetFLC</para>
 * <para>IFiscalCore.GetFLC</para>
 *
 * <para><b>Запрос основных настроек</b></para>
 * <para>IFiscalCore.GetOrgName</para>
 * <para>IFiscalCore.GetOrgAddress</para>
 * <para>IFiscalCore.GetPhysicalAddress</para>
 * <para>IFiscalCore.GetSenderEmail</para>
 * <para>IFiscalCore.GetReceiptCheckURI</para>
 * <para>IFiscalCore.GetFNSServerAddress</para>
 * <para>IFiscalCore.GetCashierTaxId</para>
 * <para>IFiscalCore.GetExtendedAutotest</para>
 * <para>IFiscalCore.GetVendingSerial</para>

 * \subsection addsettings_sec Дополнительные настройки
 *  <para>Нужны при регистрации ККТ только в некоторых режимах работы.</para>
 *  <para>Если испольльзуются, их необходимо указывать до вызова функции регистрации/перерегистрации.</para>
 *
 * <para><b>Установка дополнительных настроек</b></para>
 * <para>IFiscalCore.SetCashierTaxId</para>
 * <para>IFiscalCore.SetVendingSerial</para>
 * <para>IFiscalCore.SetExtendedAutotest</para>
 * <para>IFiscalCore.SetTransferOperatorName</para>
 * <para>IFiscalCore.SetTransferOperatorTaxId</para>
 * <para>IFiscalCore.SetTransferOperatorTelNum</para>
 * <para>IFiscalCore.SetTransferOperatorAddress</para>
 * <para>IFiscalCore.SetPaymentAgentTelNum</para>
 * <para>IFiscalCore.SetPaymentAgentOperation</para>
 * <para>IFiscalCore.SetCommissionAgentTelNum</para>
 * <para>IFiscalCore.SetContractorTelNum</para>
 * <para>IFiscalCore.SetCutType</para>
 * <para>IFiscalCore.SetHeaderLines</para>
 * <para>IFiscalCore.SetTrailerLines</para>
 * <para>IFiscalCore.SetPrePrintHeaderLines</para>
 * <para>IFiscalCore.SetDayCloseAutoPayOut</para>
 *
 *	<para><b>Запрос дополнительных настроек</b></para>
 * <para>IFiscalCore.GetTransferOperatorName</para>
 * <para>IFiscalCore.GetTransferOperatorTaxId</para>
 * <para>IFiscalCore.GetTransferOperatorTelNum</para>
 * <para>IFiscalCore.GetTransferOperatorAddress</para>
 * <para>IFiscalCore.GetPaymentAgentTelNum</para>
 * <para>IFiscalCore.GetPaymentAgentOperation</para>
 * <para>IFiscalCore.GetCommissionAgentTelNum</para>
 * <para>IFiscalCore.GetContractorTelNum</para>

 * \subsection applysettings_sec Применение настроек
 * Используется для сохранения настроек в памяти ККТ.
 * При удалении фискального ядра, а также сбросе к заводским настройкам сохранённые данные стираются.
 * <para>IFiscalCore.SaveOptions</para>
 * Основные настройки должны быть установлены и сохранены перед регистрацией ККТ.
 *
 * \subsection othersettings_sec Временные настройки
 * Команды данной группы имеют ограниченное действие, например, только для текущего документа.
 * Либо устанавливают одиночное значение, и не имеют действия при повторном вызове.
 * <para>IFiscalCore.SetDateTime</para>
 * <para>IFiscalCore.SetUserName</para>
 * <para>IFiscalCore.SendClientAddress</para>
 * <para>IFiscalCore.ForcePrintForm</para>
 * <para>IFiscalCore.SetTagPrintForm</para>
 * <para>IFiscalCore.FreezeDateTime</para>
 * <para>IFiscalCore.ContinueDateTime</para>
 */

interface IFiscalCore
{
    // **************************** Основные команды ядра **************************** //

    /// <summary>
    /// <para><b>основные команды ядра</b></para>
    /// <para>запрос версии сервиса</para>
	/// <para>формат версии: Major.Minor.Release.Build;</para>
	/// <para>Major   - старшая версия aidl, изменение версии указвает на изменение порядка функций / их сигнатур;</para>
	/// <para>Minor   - младшая версия aidl, изменение версии указвает на добавление функции, обратная совместимость;</para>
	/// <para>Release - версия приложения, инкрементируется с релизом;</para>
	/// <para>Build   - версия сборки, выставляется автоматически в момент сборки;</para>
    /// </summary>
    /// <returns>строка, например, 1.4.18.18103</returns>
    String GetAidlVersion();

	/// <summary>
    /// <para>служебная функция для работы в режиме ЕНВД без ФН до 01.07.2018</para>
    /// <para>Целочисленный результат выполнения передаётся в аргументе IAuth.Result. </para>
    /// <para>Передаваймый в качестве параметра IAuth должен при вызове Exchange возвращать имя приложения(или пользователя)-инициатора смены режима работы.</para>
    /// <para>Если код (cmd) не поддерживается, в HandleException возвращается com.multisoft.drivers.fiscalcore.ErrCode.WrongArgument и переданный в команду код в message и extErrCode.</para>
    /// <para>Если в режиме ОФД ФП инициализирована, возвращает com.multisoft.drivers.fiscalcore.ErrCode.WrongStatus "Фискальная память инициализирована. Смена режима работы невозможна" com.multisoft.drivers.fiscalcore.ExtStatusErr.Common</para>
    /// <para>Если в режиме ОФД обнаружен зарегистрированный ФН, возвращает com.multisoft.drivers.fiscalcore.ErrCode.WrongStatus "Неправильное состояние ФН" com.multisoft.drivers.fiscalcore.ExtStatusErr.Common</para>
    /// </summary>
    /// <param name="cmd">код команды. с 1.8.28 поддерживаются коды -1 и -2 (см. com.multisoft.drivers.fiscalcore.DirectIOCmd).</param>
    /// <param name="argument">аргумент функции. Пустая строка, если для конкретного кода не указано иное.</param>
    /// <param name="auth">служебный интерфейс.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке.</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.DirectIOCmd"/>
	/// <seealso cref="IAuth"/>
    void DirectIO(int cmd, String argument, IAuth auth, IExceptionCallback callback);

    /// <summary>
    /// <para><b>основные команды ядра</b></para>
    /// запрос готовности сервиса. Выполняется  каждый раз перед началом работы, как в примере
    /// </summary>
    /// <returns>true - сервис готов. false - не готов</returns>
    ///  <example>
    ///		пример использования, выполняется перед началом работы:
    ///     <code>
    ///         //команды подключения к сервису
    ///         while(!IFiscalCore.IsReady())
    ///				Thread.Sleep(50);
    ///			//начало работы
    ///		</code>
    /// </example>
    boolean IsReady();

    // **************************** Автотестирование **************************** //

    /// <summary>
    /// <para><b>основные команды ядра</b></para>
    /// <para>автотестирование</para>
    /// выполняет функцию автотестирования и печатает чек автотеста.
    /// </summary>
    /// <seealso cref="SetExtendedAutotest"/>
    /// <param name="callback"></param>
    /// <example>
    ///		пример использования, выполняется перед началом работы:
    ///     <code>
    ///         //команды подключения к сервису
    ///         while(!IFiscalCore.IsReady())
    ///				Thread.Sleep(50);
    ///			//начало работы
    ///		</code>
    /// </example>
    void SelfTest(IExceptionCallback callback);


    // **************************** Сервисные команды **************************** //
    /// <summary>
    /// <para><b>plaftorm-specific</b></para>
    /// <para><b>Для внутреннего использования</b></para>
    /// Запрос GUUID
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка c GUUID</returns>
    String GetUUID(IExceptionCallback callback);

    /// <summary>
    /// <para><b>plaftorm-specific</b></para>
    /// <para><b>Для внутреннего использования</b></para>
    /// Запрос версии фискального модуля
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка c версией.</returns>
    String GetFiscalModuleVersion(IExceptionCallback callback);

    // **************************** Локализация **************************** //
    /// <summary>
    /// <para><b>локализация</b></para>
    /// Вернуть используемый язык || запрос текущей локализации. По умолчанию "Ru-ru".
    /// задаётся при подключении к сервису через параметры intent-а
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>"Ru-ru" или "En-en"</returns>
    /// <example>
    ///		пример установки языка, выполняется при установке соединения с сервисом:
    ///     <code>
	///         //...создание serviceIntent
    ///         Bundle bundle = new Bundle();
    ///         bundle.PutString("lang", "Ru-ru");
    ///         serviceIntent.PutExtras(bundle);
    ///         var connection = new FiscalCoreServiceConnection(this);
    ///         BindService(serviceIntent, connection, Bind.AutoCreate);
    ///		</code>
    /// </example>
    String GetLang(IExceptionCallback callback);

    // **************************** Статус ККТ **************************** //
    /// <summary>
	/// <para><b>Статус ККТ</b></para>
    /// <para>Возвращает регистрационный номер ККТ</para>
    /// <para>Eсли ККТ не зарегистрирована или ФН не подключен, возвращается пустая строка</para>
    /// <para>Формат определяется ФФД п.63: суммарно 20 символов, до установленой длины дополняется пробелами справа</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка, регистрационный номер ККТ</returns>
    String GetRegNum(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Статус ККТ</b></para>
	/// <para>Возвращает заводской номер ККТ (ЗН). Если ФП не инициализирована, возвращается "XXXXXXXXXXXX".</para>
	/// <para>На производстве устанавливается ЗН из 12 символов наподобие "199000111222"</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка с ЗН.</returns>
    String GetSerial(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Статус ККТ</b></para>
    /// Возвращает полную версию ПО ядра (для внутреннего использования)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка из 4 чисел формата: Major.Minor.Build.Revision</returns>
    String GetAppVersion(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Статус ККТ</b></para>
    /// Вернуть ИНН, указанный при регистрации
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - ИНН при последней (пере)регистрации.
    /// Если ФН не подключен, возвращается пустая строка</returns>
    String GetTaxId(IExceptionCallback callback);

    // **************************** Чтение статуса ФН  **************************** //
    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// получить номер ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка c номером ФН</returns>
    String FNGetNumber(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос состояния ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>состояние ФН</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.FNState"/>
    /// <example>пример использования:
    ///   <code>
    ///		if(IFiscalCore.FNGetState(callback) == FNState.ReadyToFiscalization)
    ///     {
	///        //установка и сохранение опций
	///		   //...
    ///        IFiscalCore.Register(...
    ///     }
    ///   </code>
    /// </example>
    int FNGetState(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос флагов предупреждения ФН. Используется ККТ для запроса текущего состояния ФН.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns> флаги предупреждения (если есть)</returns>
	/// <seealso cref="com.multisoft.drivers.fiscalcore.WarningFlag"/>
	/// <example>проверка состояния ФН перед печатью чеков:
    ///   <code>
    ///     var warning = (WarningFlag)IFiscalCore.FNGetWarningFlags(callback)
    ///     if(WarningFlag.OK == warning)
    ///         //предупреждений нет, можно работать
    ///   </code>
    /// </example>
    int FNGetWarningFlags(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос текущего документа из ФН. Используется ККТ для запроса текущего состояния ФН.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число CurrentDoc - тип текущего документа</returns>
	/// <seealso cref="com.multisoft.drivers.fiscalcore.CurrentDoc"/>
	/// <example>пример использования: проверка, не открыт ли документ в ФН
    ///   <code>
    ///		if((CurrentDoc)IFiscalCore.FNGetCurrentDocType(callback) != CurrentDoc.NoDoc)
    ///       IFiscalCore.RecVoid(callback);//отменяем документ в ККТ и в ФН
	///		  callback.Complete();
    ///   </code>
    /// </example>
    int FNGetCurrentDocType(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// Запрос ФН о статусе получения данных текущего документа. Используется ККТ для запроса текущего состояния ФН.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>DocData.DataAcquired или DocData.Nodata в зависимости от того, были ли данные о документе переданы в ФН</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.DocData"/>
    int FNGetDocDataStatus(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос даты и времени последнего фискального документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка, содержащая дату и время последнего фискального документа в формате "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'". </returns>
    String FNGetLastDocDateTime(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// Запрос версии ПО ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - версия ПО ядра</returns>
    String FNGetSoftwareVersion(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос типа ПО ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>тип ПО ФН: дебаг или релиз</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.FirmwareTypes"/>
    int FNGetFirmwareType(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос номера последнего фискального документа из ФН (выполняет запрос в ФН)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>номер последнего фискального документа</returns>
    int FNGetLastFDNumber(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос даты и времени окончания действия ФН, по истечении которого ФН становится недействительным
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - дата и время в формате: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</returns>
    String FNGetLifetime(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// Запрос количества выполненных регистраций ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - количество выполненных регистраций</returns>
    int FNGetRegistrationsMade(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос количества оставшихся регистраций ФН
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - количество оставшихся регистраций</returns>
    int FNGetRegistrationsLeft(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// Запрос времени первой регистрации (фискализации) ФН.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка, содержащая дату и время последней регистрации ФН в формате: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"
    /// если ККТ не зарегистрирована, возвращается "01.01.2000 0:00:00"</returns>
    String FNGetRegTimeFirst(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// Запрос времени регистрации ФН.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <param name="regNum"> номер регистрации, положительное число</param>
    /// <returns>строка, содержащая дату и время последней регистрации ФН в формате: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</returns>
    String FNGetRegTimeByNum(int regNum, IExceptionCallback callback);


    // ****************************  Состояние ОФД ****************************

    /// <summary>
    /// <para><b>Состояние ОФД</b></para>
    /// Запрос состояния соединения с ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>статус соединения</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.ConnectionState"/>
    int OFDGetConnectionStatus(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Состояние ОФД</b></para>
    /// Запрос количества документов, ожидающих отправки в ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - количество сообщений</returns>
    int OFDGetQueuedMessagesCount(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Состояние ОФД</b></para>
    /// Запрос состояния чтения ответа из ОФД на преданное сообщение
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>true - чтение начато, false - чтение не начато</returns>
    boolean OFDGetMessageStatus(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Состояние ОФД</b></para>
    /// Запрос номера документа, находящегося первым в очереди на отправку в ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - номер документа в очереди</returns>
    int OFDGetFirstQueuedDocNumber(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Состояние ОФД</b></para>
    /// дата последнего непереданного в ОФД документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - дата последнего непереданного документа</returns>
    String OFDGetLastNotSentDocTime(IExceptionCallback callback);


    // ****************************  Состояние смены ****************************

    /// <summary>
	/// <para><b>Cостояние смены</b></para>
    /// Вернуть состояние смены в ККТ.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>состояние смены:</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.DayState"/>
    /// <example>пример использования:
    /// <code>
    ///		dayState = (DayState)IFiscalCore.GetDayState(callback);
	///		callack.Complete();
	///		if(dayState == DayState.Closed)
	///		{
	///			IFiscalCore.OpenDay("Иванов И.И", callback);
	///			callack.Complete();
	///		}
    /// </code>
    /// </example>
    int GetDayState(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Cостояние смены</b></para>
    /// Вернуть номер смены.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - номер смены</returns>
    int GetDayNumber(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Cостояние смены</b></para>
    /// Вернуть номер последнего документа в смене.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - номер последнего документа в смене</returns>
    int GetDayLastReceiptNumber(IExceptionCallback callback);

    // ****************************  Состояние смены: отчёты ****************************
    /// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// печать х-отчёта
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void PrintXReport(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// запрос суммы за смену по отменённым документам
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - сумма по отменённым документам</returns>
    String GetDayCanceledTotal(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// запрос значения счётчика операций
    /// </summary>
    /// <param name="counterType">тип счётчика</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>количество выполненных операций</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
    int GetDayPayCount(int counterType, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// запрос даты и времени открытия смены
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - дата и мремя открытия смены в формате "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</returns>
    String GetDayOpenDateTime(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// запрос суммы по типу счётчика
    /// </summary>
    /// <param name="counterType">тип счётчика</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
    /// <returns>сумма по счётчику</returns>
    String GetDayPayTotal(int counterType, IExceptionCallback callback);

    // **************************** Регистрация ****************************
    /// <summary>
    /// <para><b>Регистрация</b></para>
    /// <para>Регистрация (первоначальная регистрация). Выполняется 1 раз за всё время жизни ФН.</para>
	/// <para>В режиме ЕНВД без ФН в качестве параметров необходимо передать корректный ИНН, имя кассира и reg_num, остальные параметры не влияют на результат выполнения.</para>
    /// </summary>
    /// <param name="cashier">строка - имя и номер кассира</param>
    /// <param name="inn">строка - ИНН пользователя при регистрации</param>
    /// <param name="reg_num">строка - регистрационный номер ККТ. В режиме ЕНВД без ФН - является паролем налогового инспектора: передавать "00000".</param>
    /// <param name="tax">байт - код системы налогообложения - битовая маска TaxCode.
    /// Поддеживаемый тип налогов устанавливает соответствующий бит в байте.
    /// Для корректной работы необходимо установить хотя бы один бит в 1.</param>
    /// <param name="op_mode">байт - код режима работы - битовая маска OperatingMode.
    /// Поддеживаемый режим работы устанавливает соответствующий бит в байте.
    /// Может принимать значение 0.</param>
    /// <param name="gambling">true или false - признак проведения азартных игр</param>
    /// <param name="lottery">true или false - признак проведения лотереи</param>
    /// <param name="agent">байт - код платёжного агента - битовая маска AgentTag.
    /// Поддеживаемый код платёжного агента устанавливает соответствующий бит в байте.
    /// Может принимать значение 0.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxCode"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperatingMode"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    /// <example>
    ///     <code>
    ///         //команды настройки полей:
    ///          String regnum = RegNumTextBox.Text;
	///			 // ... Формирование РНМ ККТ происходит на стороне ФНС России:
	///			 // базовый РНМ дополняется лидирующими нулями до длины строки в 10 символов,
	///			 // затем вычисляется и добавляется контрольная сумма (6 символов).
    ///          //настройка системы налогообложения
    ///          int tax = TaxCode.Common + TaxCode.SimplifiedWithExpense + TaxCode.ENVD;
    ///          //настройка режима работы:
    ///          int opmode = OperatingMode.Service + OperatingMode.Encryption;
    ///          //настройка агента:
    ///          int agent = AgentTag.BankPayAgent + AgentTag.BankPaySubAgent;//установлены 1й и 2й биты
	///          //регистрация:
	///          IFiscalCore.Register(cashierTextBox.Text, "1234567890", regnum, tax, opmode, false, false, agent, callback);
	///			 callback.Complete();
    ///     </code>
    /// </example>
    void Register(String cashier, String inn, String reg_num, int tax, int op_mode,
boolean gambling, boolean lottery, int agent, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Регистрация</b></para>
    /// Исправление регистрации || Перерегистрация
    /// </summary>
    /// <param name="corr_reason">причина перерегистрации CorrectionReason</param>
    /// <param name="inn">строка - ИНН пользователя при регистрации</param>
    /// <param name="reg_num">строка - регистрационный номер ККТ</param>
    /// <param name="tax_code">байт - код системы налогообложения - битовая маска TaxCode.
    /// Поддеживаемый тип налогов устанавливает соответствующий бит в байте.
    /// Для корректной работы необходимо установить хотя бы один бит в 1.</param>
    /// <param name="opmode">байт - код режима работы - битовая маска OperatingMode.
    /// Поддеживаемый режим работы устанавливает соответствующий бит в байте.
    /// Может принимать значение 0.</param>
    /// <param name="gambling">true или false - признак проведения азартных игр</param>
    /// <param name="lottery">true или false - признак проведения лотереи</param>
    /// <param name="agent">байт - код платёжного агента - битовая маска AgentTag.
    /// Поддеживаемый код платёжного агента устанавливает соответствующий бит в байте.
    /// Может принимать значение 0.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.CorrectionReason"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxCode"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperatingMode"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    /// <example>
    ///     <code>
    ///       reason = (int)CorrResason.ChangeKKTSettings;
    ///       kktRegNum = regNumTextBox.Text;
    ///       tax = TaxCode.Common + TaxCode.SimplifiedWithExpense + TaxCode.ENVD;
    ///       opMode = OperatingMode.Service + OperatingMode.Encryption;
    ///       agentTag =  AgentTag.BankPayAgent + AgentTag.BankPaySubAgent;
    ///       IFiscalCore.CorrectRegistration(reason, "Иванов И.И", "1234567890", kktRegNum, (int)opMode,  tax, false, false, agentTag, callback);
	///		  callback.Complete();
    ///     </code>
    /// </example>
    void CorrectRegistration(int corr_reason, String cashier, String inn, String reg_num, int tax_code, int op_mode,
 boolean gambling, boolean lottery, int agent, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Регистрация</b></para>
    /// <para>Закрытие архива ФН. Необратимая для пользователя операция.</para>
    /// <para>После выполнения работа с ФН невозможна до следующей регистрации.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void CloseFiscalMode(IExceptionCallback callback);


    // **************************** Смена ****************************

    /// <summary>
    /// <para><b>Смена</b></para>
    /// Открыть смену
    /// </summary>
    /// <param name="cashier">имя и номер кассира</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>пример использования:
    ///   <code>
    ///       try
	///		  {
	///           //если клиентская реализация callback генерирует исключения,
	///           // то все функции работы с чеками можно поместить в один блок try-catch
	///		      IFiscalCore.OpenDay(cashierTextBox.Text,callback);
	///			  callback.Complete();
	///           //команды работы с чеками
	///		  }
	///       catch(Exception e)
	///       {
	///          DisplayNotification(e.Message);
	///          return;
	///       }
    ///
    ///   </code>
    /// </example>
    void OpenDay(String cashier, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Смена</b></para>
    /// Напечатать Z-отчёт и закрыть смену
    /// </summary>
    /// <param name="cashier">имя и номер кассира</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>пример использования:
    /// <code>
    ///     IFiscalCore.OpenDay(cashierTextBox.Text,callback);
	///		callback.Complete();
	///     //команды работы с чеками
    ///     IFiscalCore.CloseDay(cashierTextBox.Text,callback);
	///		callback.Complete();
    ///   </code>
    /// </example>
    void CloseDay(String cashier, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Смена</b></para>
    /// Напечатать отчёт о состоянии расчётов
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void PrintCalculationsReport(IExceptionCallback callback);


    // **************************** Чек ****************************

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Открыть чек. открывает документ одного из поддерживаемых типов.</para>
	/// <para>Eсли код документа выходит за границу RecType, открывается нефискальный документ.</para>
    /// </summary>
    /// <param name="recType">код открываемого документа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.RecType"/>
    /// <example>открыть чек на продажу
    ///     <code>
    ///         IFiscalCore.SetUserName(Cashier.Text,callback);
	///			callback.Complete();
    ///         recType = (int)RecType.Sell;//приход
    ///         IFiscalCore.OpenRec(recType,callback);
	///			callback.Complete();
	///			//... команды добавления позиций, итог, оплата, закрытие чека
    ///     </code>
    /// </example>
    void OpenRec(int recType, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Получить тип открытого документа.</para>
    /// <para>В случае, если документ закрыт, возвращает тип последнего открытого документа.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>тип (последнего)открытого документа</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.RecType"/>
    int GetRecType(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// Возвращает состояние документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>состояние документа</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.RecState"/>
    /// <example>
    ///		проверка, был ли документ уже открыт перед открытием нового документа
    ///     <code>
    ///         if((RecState)IFiscalCore.GetRecState(callback) == RecState.Opened)
    ///				IFiscalCore.RecVoid(callback);//отменяем документ
    ///         IFiscalCore.OpenRec((int)RecType.Sell, callback);
	///			callback.Complete();
    ///         //команды работы с чеком: добавление позиций, оплата, и т.д.
    ///     </code>
    /// </example>
    int GetRecState(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Установить систему налогообложения (СНО).</para>
    /// <para>Нужна при формировании чеков, если ККТ зарегистрирована с 2 и более СНО</para>
	/// <para>Вызывается до открытия чека. Если ККТ зарегистрирована с 1 СНО, факультативна.</para>
    /// </summary>
    /// <param name="tax">используемая система налогообложения</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxCode"/>
    /// <example>пример использования:
    ///   <code>
    ///     IFiscalCore.SetUserName(Cashier.Text,callback);
	///		callback.Complete();
    ///     recType = (int)RecType.Sell;//приход
    ///     IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///		callback.Complete();
    ///     IFiscalCore.OpenRec(recType,callback);
	///		callback.Complete();
    ///
    ///     //добавление первой позиции:
    ///     IFiscalCore.SetItemTaxes((int)TaxNum._NO,callback);//без ндс
    ///     IFiscalCore.SetShowTaxes(true,callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItem("1", "100", "товар", "артикул", callback1);
	///		callback1.Complete();
    ///
    ///     // добавление остальных позиций
    ///     //   . . .
    ///     //
	///     IFiscalCore.PrintRecTotal(callback);//печать итога
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Card, "200","ЭЛЕКТРОННЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, "200", "НАЛИЧНЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.CloseRec(callback);//закрытие документа
	///		callback.Complete();
    ///   </code>
    /// </example>
    void SetTaxationUsing(int tax, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Запрос зарегистрированной системы налогообложения.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>система налогообложения, указанная при регистрации</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxCode"/>
    int GetTaxation(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// Производит закрытие документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>пример использования:
    ///   <code>
    ///     IFiscalCore.SetUserName(Cashier.Text,callback);
	///		callback.Complete();
    ///     recType = (int)RecType.Sell;//приход
    ///     IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///		callback.Complete();
    ///     IFiscalCore.OpenRec(recType,callback);
	///		callback.Complete();
    ///     // добавление позиций
	///     // . . .
	///     IFiscalCore.PrintRecTotal(callback);//печать итога
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Card, "200","ЭЛЕКТРОННЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, "200", "НАЛИЧНЫМИ:",callback);
	///		callback.Complete();
	///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, "-0.50", "СДАЧА:",callback);
	///		callback.Complete();
    ///     IFiscalCore.CloseRec(callback);//закрытие документа
	///		callback.Complete();
    ///   </code>
    /// </example>
    void CloseRec(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// Провести оплату по типу платежа
    /// </summary>
    /// <param name="type">байт тип оплаты. бит </param>
    /// <param name="total">строка - сумма оплаты</param>
    /// <param name="itemText">строка - сопутствующий текст, например, тип оплаты</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.PayType"/>
	/// <example>несколько типов оплат:
    ///   <code>
    ///     //команды открытия документа и добавления позиций
	///     IFiscalCore.PrintRecTotal(callback);//печать итога
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Tare, "2.10", "В ОБМЕН:",callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, "203.00", "НАЛИЧНЫМИ:",callback);
	///		callback.Complete();
	///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, "-5.00", "СДАЧА:",callback);
	///		callback.Complete();
    ///     IFiscalCore.CloseRec(callback);//закрытие документа
	///		callback.Complete();
    ///   </code>
    /// </example>
    void PrintRecItemPay(int type, String total, String itemText, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Печать текста c переводом строки.</para>
    /// </summary>
    /// <param name="align">выравнивание.</param>
    /// <param name="line">строка текста для печати</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Align"/>
	void PrintLine(int align, String line, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// Аннулировать чек
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>пример использования: проверка, не открыт ли документ в ФН
    ///   <code>
    ///		if(IFiscalCore.FNGetCurrentDocType(callback) != (int)CurrentDoc.NoDoc)
    ///       IFiscalCore.RecVoid(callback);//отменяем документ в ККТ и в ФН
    ///   </code>
    /// </example>
    void RecVoid(IExceptionCallback callback);

    // **************************** Итог ****************************

    /// <summary>
    /// <para><b>Итог</b></para>
    /// Вернуть сумму по чеку
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - сумма по чеку</returns>
    /// <example>пример использования:
    ///   <code>
    ///     IFiscalCore.PrintRecTotal(callback);//печать итога
	///		callback.Complete();
    ///     recTotal = IFiscalCore.GetRecTotal(callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((int)PayType.Cash, recTotal, "НАЛИЧНЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.CloseRec(callback);
	///		callback.Complete();
    ///   </code>
    /// </example>
    String GetRecTotal(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Итог</b></para>
    /// <para>Проверить наличие денег в денежном ящике.</para>
    /// <para>Нужна для работы с документами "Расход" и "Возврат прихода", "Изъятие"</para>
    /// <param name="total">сумма для выдачи из кассы</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// </summary>
    /// <example>
    ///     <code>
	///			//проверка, что в ДЯ есть 100р
    ///         IFiscalCore.CheckDrawerCash("100",callback);
	///			callback.Complete();
    ///         IFiscalCore.OpenRec((int)RecType.PayOut, callack);
	///			callback.Complete();
    ///			IFiscalCore.PrintRecItem("1", "100", "изъятие наличных", "", callback);
	///			callback.Complete();
	///			IFiscalCore.PrintRecTotal(callback);//печать итога
	///			callback.Complete();
    ///			IFiscalCore.PrintRecItemPay((int)PayType.Cash, "100", "НАЛИЧНЫМИ:",callback);
	///			callback.Complete();
    ///			IFiscalCore.CloseRec(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    void CheckDrawerCash(String total, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Итог</b></para>
    /// Печать итога.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>производим оплату только когда сумма оплаты (payment) больше суммы по чеку
    ///     <code>
    ///         IFiscalCore.SetUserName(Cashier.Text,callback);
	///			callback.Complete();
    ///         recType = (int)RecType.Sell;//приход
    ///         IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///			callback.Complete();
    ///         IFiscalCore.OpenRec(recType,callback);
	///			callback.Complete();
    ///         //добавление первой позиции:
    ///         IFiscalCore.SetItemTaxes((int)TaxNum._18,callback);
	///			callback.Complete();
    ///         IFiscalCore.SetShowTaxes(true,callback);
	///			callback.Complete();
    ///         IFiscalCore.PrintRecItem("1.00", "1.11", "товар", "",callback);
	///			callback.Complete();
    ///         // добавление остальных позиций (опционально)
    ///         // . . .
    ///         //
	///         //установка адреса клиента. выполняется до CloseRec()
	///         IFiscalCore.SendClientAddress("+79991112233",callback);
	///			callback.Complete();
	///         IFiscalCore.PrintRecTotal(callback);//печать итога
	///			callback.Complete();
    ///         IFiscalCore.PrintRecItemPay((byte)PayType.Cash, "1.11", "НАЛИЧНЫМИ:",callback);
	///			callback.Complete();
    ///         IFiscalCore.CloseRec(callback);//закрытие документа
	///			callback.Complete();
    ///     </code>
    /// </example>
    void PrintRecTotal(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Устанавливает налог по его порядоковому номеру. </para>
    /// <para>Действует до следующего вызова PrintRecItem</para>
    /// <para>Необходимо выполнять в открытом документе перед каждым вызовом IFiscalCore.PrintRecItem.</para>
    /// </summary>
    /// <param name="taxNum">порядоковый номер используемого налога</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxNum"/>
    /// <example>пример использования:
    ///   <code>
    ///     IFiscalCore.SetUserName(Cashier.Text,callback);
	///		callback.Complete();
    ///     recType = (int)RecType.Sell;//приход
    ///     IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///		callback.Complete();
    ///     IFiscalCore.OpenRec(recType,callback);
	///		callback.Complete();
    ///     IFiscalCore.SetItemTaxes((int)TaxNum._10,callback);//"НДС 10%"
	///		callback.Complete();
    ///     IFiscalCore.SetShowTaxes(true,callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItem("20", "10.00", "товар", "артикул",callback);
	///		callback.Complete();
	///     IFiscalCore.PrintRecTotal(callback);//печать итога
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((byte)PayType.Card, "19.50", "ЭЛЕКТРОННЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.PrintRecItemPay((byte)PayType.Cash, "180.50", "НАЛИЧНЫМИ:",callback);
	///		callback.Complete();
    ///     IFiscalCore.CloseRec(callback);//закрытие документа
	///		callback.Complete();
    ///   </code>
    /// </example>
    void SetItemTaxes(int taxNum, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Управляет отрисовкой налога. По умолчанию отрисовка выключена.</para>
	/// <para>Если нужно включить для i-й позиции, то необходимо вызывать с параметром True перед печатью этой позиции (функция  IFiscalCore.PrintRecItem).</para>
    /// </summary>
    /// <param name="val">true - показывать, false  - не показывать</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>пример использования:
    /// <code>
    ///     // ... открытие документа, добавление позиций
	///		IFiscalCore.SetItemTaxes((int)TaxNum._10_110,callback);//НДС 10/110
	///		callback.Complete();
    ///     IFiscalCore.SetShowTaxes(true,callback);
    ///     IFiscalCore.PrintRecItem("1.0", "50", "товар","",callback);
	///		callback.Complete();
    ///     // ... закрытие документа
    /// </code>
    /// </example>
    void SetShowTaxes(boolean val, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// Добавление товарной позиции в открытом документе
    /// </summary>
    /// <param name="count">строка - количество. может принимать как целые, так и дробные значения</param>
    /// <param name="price">строка - цена за единицу (1) количества</param>
    /// <param name="itemname">строка - наименование товара</param>
    /// <param name="article">строка - артикул</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	/// <example>правильная последовательность печати позиции с налогом
    ///   <code>
    ///     // ... открытие документа, добавление позиций
	///		IFiscalCore.SetItemTaxes((int)TaxNum._18_118,callback);//НДС 18/118
	///		callback.Complete();
    ///     IFiscalCore.SetShowTaxes(true,callback);
    ///     IFiscalCore.PrintRecItem("1.0", "12.34", "товар","",callback);
	///		callback.Complete();
    ///     // ... закрытие документа
    ///   </code>
    /// </example>
    void PrintRecItem(String count, String price, String itemname, String article, IExceptionCallback callback);

    // **************************** Чек коррекции ****************************

    /// <summary>
    /// <para><b>Чек коррекции</b></para>
    /// <para>Напечатать чек коррекции.</para>
    /// <para>Вызывается однократно для каждого чека коррекции</para>
    /// </summary>
    /// <param name="operation">тип операции - com.multisoft.drivers.fiscalcore.OperationType, только для OperationType.Sell, OperationType.Buy (Приход, Расход)</param>
    /// <param name="cash">сумма наличными</param>
    /// <param name="emoney">сумма электронными</param>
    /// <param name="advance">сумма авансом</param>
    /// <param name="credit">сумма в кредит</param>
    /// <param name="other">сумма обменом</param>
    /// <param name= "taxNum">порядоковый номер используемого налога com.multisoft.drivers.fiscalcore.TaxNum. Если вызвана IFiscalCore.SetSumTaxes, значение не используется.</param>
    /// <param name="corrType">тип коррекци com.multisoft.drivers.fiscalcore.CorrectionRecType</param>
    /// <param name="docName">строка, наименование основания для коррекции</param>
    /// <param name="docDate">строка, дата документа основания документа в формате "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</param>
    /// <param name="docNum">строка, номер документа основания</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperationType"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.CorrectionRecType"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxNum"/>
	/// <seealso cref="IFiscalCore.SetSumTaxes"
    ///  <example>
    ///     работа с чеком коррекции:
    ///     <code>
    ///         IFiscalCore.SetUserName(cashier,callback);
    ///         IFiscalCore.SetTaxationUsing(TaxCode.Common,callback);
	///			callback.Complete();
    ///         IFiscalCore.OpenRec(RecType.CorrectionReceipt,callback);
	///			callback.Complete();
	///			string docName = "01.02.2017 не сформирован и не выдан кассовый чек";
	///			string docNum = "32";
	///			string docDate = "2017-02-28T19:12:03.000Z";
    ///         IFiscalCore.FNMakeCorrectionRec((int)OperationType.Sell,"10","0","0.00","0.00","0.05",(int)TaxNum._18,(int)CorrectionRecType.Independent,docName,docDate,docNum,callback);
	///			callback.Complete();
    ///         IFiscalCore.CloseRec(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    void FNMakeCorrectionRec(int operation, String cash, String emoney, String advance, String credit,
        String other, int taxNum, int corrType, String docName, String docDate, String docNum, IExceptionCallback callback);

    // ****************************  Запрос информации о подтверждении документа от ОФД ****************************

    /// <summary>
    /// <para><b>Запрос информации о подтверждении документа от ОФД</b></para>
    /// <para>Запросить информацию о подтверждении от ОФД  по номеру документа.</para>
    /// <para>Только при подключенном ФН!</para>
    /// <para>За 1 запрос сохраняется информация об 1 подтверждении фискального документа.</para>
    /// <para>При последующем запросе информация о предыдущем удаляется.</para>
    /// <para>Выполняется для каждого запрашиваемого подтверждения перед вызовом остальных функций, относящихся к разделу "<b>Запрос информации о подтверждении документа от ОФД</b>".</para>
    /// <para>Вызывается перед чтением информации о подтверждении.</para>
    /// <para>Для чтения информации о другом подтверждении необходимо выполнить эту команду снова, указав соответствующий номер.</para>
    /// <param name="docnum">номер переданного в ОФД фискального документа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// </summary>
    /// <example> Запрос информации о подтверждении документов с номерами 1 и 2
    ///     <code>
    ///         //запросить информацию о чеке с номером 1
    ///         IFiscalCore.QueryOFDReceiptByNum(1,callback);
	///			callback.Complete();
    ///         //считать время из документа с номером 1
    ///         var first = IFiscalCore.OfdOut_GetTime(callback);
	///			callback.Complete();
    ///         //запросить информацию о чеке с номером 2
    ///         IFiscalCore.QueryOFDReceiptByNum(2,callback);
	///			callback.Complete();
    ///         //считать время из документа с номером 2
    ///         var second = IFiscalCore.OfdOut_GetTime(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
	void QueryOFDReceiptByNum(int docnum, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос информации о подтверждении документа от ОФД</b></para>
    /// Показать время подтверждения документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - время</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryOFDReceiptByNum(1,callback);
	///			callback.Complete();
    ///         var first = IFiscalCore.OfdOut_GetTime(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    String OfdOut_GetTime(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Запрос информации о подтверждении документа от ОФД</b></para>
    /// Показать номер выбранного подтверждения документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - номер фискального документа</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryOFDReceiptByNum(1,callback);
	///			callback.Complete();
    ///         var first = IFiscalCore.OfdOut_GetFDNumber(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    long OfdOut_GetFDNumber(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Запрос информации о подтверждении документа от ОФД</b></para>
    /// Показать фискальный признак подтверждения документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - фискальный признак, полученный от ОФД</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryOFDReceiptByNum(1,callback);
	///			callback.Complete();
    ///         var first = IFiscalCore.OfdOut_GetFiscalSign(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    String OfdOut_GetFiscalSign(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос информации о подтверждении документа от ОФД</b></para>
    /// Показать размер подтверждения документа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>число - размер документа</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryOFDReceiptByNum(1,callback);
	///			callback.Complete();
    ///         var first = IFiscalCore.OfdOut_GetSize(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    int OfdOut_GetSize(IExceptionCallback callback);


    // ****************************  Работа с архивом ФН ****************************

    /// <summary>
	/// <para><b>Работа с архивом ФН</b></para>
    /// <para>Запросить информацию о документе из архива ФН по номеру.</para>
    /// <para>Только при подключенном ФН!</para>
	/// <para>За 1 запрос сохраняется информация об 1 фискальном документе.</para>
    /// <para>При последующем запросе информация о предыдущем удаляется.</para>
    /// <para>Выполняется для каждого запрашиваемого документа перед вызовом остальных функций, относящихся к разделу "<b>Работа с архивом ФН</b>".</para>
    /// <para>После этого становятся доступными функции с префиксом FDI, </para>
    /// <para>которые отображают информацию из запрошенного документа.</para>
	/// <para>Для чтения информации о другом документе необходимо выполнить эту команду снова c указанием нужного номера документа. </para>
    /// </summary>
    /// <param name="docNum">число - номер документа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	/// <example>
    ///     <code>
    ///         //запросить из архива ФД с номером 1
    ///         IFiscalCore.QueryFiscalDocInfo(1,callback);
	///			callback.Complete();
    ///         //считать время из документа с номером 1
	///			var doctype = IFiscalCore.FDI_GetDocType(callback);
	///			callback.Complete();
	///			//запросить из архива ФД с номером 2
    ///         IFiscalCore.QueryFiscalDocInfo(2,callback);
	///			callback.Complete();
    ///         //считать время из документа с номером 2
	///			var doctype = IFiscalCore.FDI_GetDocType(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    void QueryFiscalDocInfo(int docNum, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Работа с архивом ФН</b></para>
    /// Показать тип документа, выбранного с помощью IFiscalCore.QueryFiscalDocInfo
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>тип документа</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.DocType"/>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryFiscalDocInfo(1,callback);
	///			callback.Complete();
	///			var first = IFiscalCore.FDI_GetDocType(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    int FDI_GetDocType(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Работа с архивом ФН</b></para>
    /// Показать флаг о наличии подтверждения документа, выбранного с помощью IFiscalCore.QueryFiscalDocInfo, от ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>true - документ был подтверждён, false - документ не был подтверждён</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryFiscalDocInfo(1,callback);
	///			callback.Complete();
	///			var first = IFiscalCore.FDI_GetConfirmFromOFD(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    boolean FDI_GetConfirmFromOFD(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Работа с архивом ФН</b></para>
    /// Показать байты документа, выбранного с помощью IFiscalCore.QueryFiscalDocInfo
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - байт-код документа в HEX-формате</returns>
    /// <example>
    ///     <code>
    ///         IFiscalCore.QueryFiscalDocInfo(1,callback);
	///			callback.Complete();
	///			var first = IFiscalCore.FDI_GetDataArray(callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    String FDI_GetDataArray(IExceptionCallback callback);

    // **************************** Печать из архива ****************************

    /// <summary>
	/// <para><b>Печать их архива</b></para>
    /// Вывести на печать документ из архива по номеру
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <param name="docNum">положительное целое число - номер документа</param>
    void FNPrintDocFromArchive(int docNum, IExceptionCallback callback);

    // ****************************  Запрос параметров ****************************

    // В этом блоке находятся методы для настройки аппарата перед регистрацией.
    // Под "пользователем" следует понимать организацию - пользователя КТТ

    // **************************** Параметры ОФД ****************************

    /// <summary>
    /// <para><b>Запрос параметров ОФД</b></para>
    /// Запрос адреса сервера ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>адрес сервера, например "test.server.ofd"  или "11.2.222.11"</returns>
    String GetOfdHost(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос параметров ОФД</b></para>
    /// Запрос порта ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>порт сервера, например, 12345</returns>
    int GetOfdPort(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Запрос параметров ОФД</b></para>
    /// Запрос полного наименования оператора фискальных данных
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - наименование ОФД</returns>
    String GetOfdName(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос параметров ОФД</b></para>
    /// Запрос ИНН ОФД
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - ИНН ОФД</returns>
    String GetOfdTaxId(IExceptionCallback callback);


    // **************************** Основные настройки ****************************

    /// <summary>
    /// <para><b>Запрос основных настроек</b></para>
    /// Запрос имени организации (пользователя)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - имя организации</returns>
    String GetOrgName(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос адреса организации (пользователя)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - адрес организации</returns>
    String GetOrgAddress(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос места расчётов.
    /// Место осуществления расчетов между пользователем и покупателем (клиентом)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - физическое место расчётов</returns>
    String GetPhysicalAddress(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос email-а отправителя чеков
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - email отправителя чеков </returns>
    String GetSenderEmail(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос адреса сайта для проверки фискального признака
    /// </summary>
    /// <returns>строка - адрес сайта для проверки фискального признака</returns>
    String GetReceiptCheckURI(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос сайта налогового органа
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - сайт налогового органа</returns>
    String GetFNSServerAddress(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос ИНН кассира
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - инн кассира</returns>
    String GetCashierTaxId(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// <para>Запрос флага расширенного автотеста.</para>
    /// <para>Если true, печатается чек расширенного автотестирования.</para>
    /// <para>Если false, чек расширенного автотестирования не печатается</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>true или false</returns>
    boolean GetExtendedAutotest(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос основных настроек</b></para>
    /// Запрос номера автомата. Необходим только в автоматическом режиме.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - номер автомата</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperatingMode"/>
    String GetVendingSerial(IExceptionCallback callback);


    // **************************** Дополнительные настройки ****************************

    /// <summary>
    /// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос наименования оператора перевода, для банковских платежных агентов (субагентов)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - наименование оператора перевода</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetTransferOperatorName(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос ИНН оператора перевода, для банковских платежных агентов (субагентов)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - ИНН оператор перевода</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetTransferOperatorTaxId(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос телефона оператора перевода
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - номера телефонов оператора по переводу денежных средств</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetTransferOperatorTelNum(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос адреса оператора перевода, для банковских платежных агентов (субагентов)
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - адрес оператора перевода</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetTransferOperatorAddress(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос номера телефонов платёжного агента, платёжного субагента,
    /// банковского платёжного агента,банковского платёжного субагента
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - номера телефонов платёжного агента, платёжного субагента,
    /// банковского платёжного агента, банковского платёжного субагента</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetPaymentAgentTelNum(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// Запрос операции платёжного агента.
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - наименование операции банковского платёжного агента или банковского платёжного субагента </returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetPaymentAgentOperation(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// <para>Запрос телефона оператора по приёму платежей.</para>
    /// <para>При осуществлении деятельности платёжного агента и платёжного субагента.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - номер телефона оператора по приёму платежей</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetCommissionAgentTelNum(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Запрос дополнительных настроек</b></para>
    /// <para>Запрос номера телефона поставщика</para>
    /// <para>Для платёжного агента и платёжного субагента</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - номер телефона поставщика </returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    String GetContractorTelNum(IExceptionCallback callback);


    // **************************** Применение настроек ****************************

    /// <summary>
    /// <para><b>Применение настроек</b></para>
    /// <para>Инициировать сохранение текущих настроек в память ККТ, </para>
    /// <para>чтобы они были применены при следующей инициализации ядра.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SaveOptions(IExceptionCallback callback);

    // ****************************  Установка параметров ****************************
    // Данный блок методов позволяет настраивать параметры ККТ.
    // Чтобы при следующей загрузке ядра настройки были применены, их нужно сохранить функцией IFiscalCore.SaveOptions()
	// Порядок изменения параметров, указанных при регистрации:
	// http://77.243.109.96:8881/redmine/projects/mspos-k/wiki/QA#Q11

    // **************************** Параметры ОФД ****************************
    // Необходимо указывать до вызова функции регистрации.

    /// <summary>
    /// <para><b>Установка параметров ОФД</b></para>
    /// Установка адреса сервера ОФД для подключения
    /// </summary>
    /// <param name="host">сервер ОФД, например, "test.server.ofd"  или "11.2.222.11"</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOfdHost(String host, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка параметров ОФД</b></para>
    /// Установка порта сервера ОФД для подключения
    /// </summary>
    /// <param name="port">порт, например 9999</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOfdPort(int port, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Установка параметров ОФД</b></para>
    /// Установить наименование ОФД (1046)
    /// </summary>
    /// <param name="text">полное наименование оператора фискальных данных</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOfdName(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка параметров ОФД</b></para>
    /// Установить ИНН ОФД (1017)
    /// </summary>
    /// <param name="text"> ИНН ОФД </param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOfdTaxId(String text, IExceptionCallback callback);


    // **************************** Основные настройки ****************************
    // Необходимо указывать до вызова функции регистрации.

    /// <summary>
    /// <para><b>Установка основных настроек</b></para>
    /// Установить наименование пользователя (пользователя) (1048)
    /// </summary>
    /// <param name="text">наименование организации-пользователя или фамилия, имя, отчество (при наличии) индивидуального предпринимателя - пользователя</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOrgName(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// Установить адрес расчётов (1009)
    /// </summary>
    /// <param name="text">адрес осуществления расчетов между пользователем и покупателем (клиентом)</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetOrgAddress(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// Установить место расчётов
    /// </summary>
    /// <param name="text">(физическое) место расчётов,
	/// место осуществления расчетов между пользователем и покупателем (клиентом)</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetPhysicalAddress(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// <para>Установить адрес электронной почты отправителя чека (1117)</para>
	/// <para>Максимум 64 символа в формате "{С}@{C}" без кавычек и скобок.</para>
	/// <para>Скобки указывают на многократное повторение символа {C}.</para>
    /// </summary>
    /// <param name="text">адрес электронной почты отправителя кассового чека (БСО) в электронной форме, в том числе пользователя, если отправителем является пользователь, в случае передачи покупателю (клиенту) кассового чека или бланка строгой отчетности в электронной форме</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="SendClientAddress"/>
    void SetSenderEmail(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// Установить адрес сайта для проверки фискального признака. Не используется в ФФД 1.05 и 1.1
    /// </summary>
    /// <param name="text">адрес сайта для проверки фискального признака</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetReceiptCheckURI(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// Установить адрес сайта ФНС (1060), максимум 256 символов в представимом в CP866 виде.
    /// </summary>
    /// <param name="text">адрес сайта налогового органа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetFnsServerAddress(String text, IExceptionCallback callback);


    // **************************** Дополнительные настройки ****************************
    // Нужны при регистрации ККТ только в некоторых режимах работы.
    // Если испольльзуются, их необходимо указывать и применять до вызова функции регистрации/перерегистрации.

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установить ИНН кассира (1203), ровно 12 цифр.
    /// </summary>
    /// <param name="text">ИНН кассира</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetCashierTaxId(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить флаг расширенного автотеста.</para>
    /// <para>Если true, печатается чек расширенного автотестирования.</para>
    /// <para>Если false, чек расширенного автотестирования не печатается</para>
    /// </summary>
    /// <param name="newstate">новое состояние</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetExtendedAutotest(boolean newstate, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установить номер автомата (1036). Необходим только в автоматическом режиме.
    /// </summary>
    /// <param name="text">номер автомата, максимум 20 символов</param>
    /// <param name="callback">функция обратного вызова дял передачи параметров ошибки</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperatingMode"/>
    void SetVendingSerial(String text, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Установка дополнительных настроек</b></para>
    /// Установить наименование оператора перевода (1026) в кассовом чеке/БСО
    /// </summary>
    /// <param name="text">наименование оператора перевода, максимум 64 символа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetTransferOperatorName(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установить ИНН оператора перевода (1016) в кассовом чеке/БСО
    /// </summary>
    /// <param name="text">ИНН оператор перевода, ровно 12 цифр</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetTransferOperatorTaxId(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить телефон оператора перевода (1075) в кассовом чеке/БСО</para>
    /// <para>Формат: строка, начинающаяся на '+', далее цифры. Максимум 19 символов, включая "+" в начале</para>
    /// </summary>
    /// <param name="text">строка - номер телефона оператора перевода, например, +79991112233</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetTransferOperatorTelNum(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить адрес оператора перевода (1005) в кассовом чеке/БСО</para>
    /// </summary>
    /// <param name="text">адрес оператора перевода, максимум 256 символов</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetTransferOperatorAddress(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить телефон платёжного агента (1073) в кассовом чеке/БСО</para>
    /// <para>Формат: строка, начинающаяся на '+', далее цифры. Максимум 19 символов, включая "+" в начале</para>
    /// </summary>
    /// <param name="text">строка - телефонный номер</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetPaymentAgentTelNum(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить параметр "операция платёжного агента" (1044) в кассовом чеке/БСО</para>
    /// </summary>
    /// <param name="text">операция платёжного агента, максимум 24 символа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetPaymentAgentOperation(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить телефон оператора по приёму платежей (1074) в кассовом чеке/БСО</para>
    /// <para>Формат: строка, начинающаяся на '+', далее цифры. Максимум 19 символов, включая "+" в начале</para>
    /// </summary>
    /// <param name="text">номер телефона оператора по приёму платежей</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetCommissionAgentTelNum(String text, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Установить телефон поставщика (1171) в кассовом чеке/БСО</para>
    /// <para>Формат: строка, начинающаяся на '+', далее цифры. Максимум 19 символов, включая "+" в начале</para>
    /// </summary>
    /// <param name="text">номер телефона поставщика</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    void SetContractorTelNum(String text, IExceptionCallback callback);


    // **************************** Временные настройки ****************************
    /// <summary>
    /// <para><b>Временные настройки</b></para>
    /// Установить дату и время. Используется для начальной настройки ККТ и корретировки часов ККТ в процессе работы.
    /// </summary>
    /// <param name="datetime">дата и время в формате "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>установка даты и времени
    ///   <code>
    ///     var date = DateTime.Now.ToUniversalTime().ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'");
    ///     IFiscalCore.SetDateTime(date,callback);//установка даты и времени
    ///   </code>
    /// </example>
    void SetDateTime(String datetime, IExceptionCallback callback);

    // **************************** Сервисные команды ****************************
    /// <summary>
    /// <para><b>Сервисные команды</b></para>
    /// <para>Установить заводской номер (ЗН) ККТ</para>
    /// <para>Выполняется 1 раз для каждой ккт перед началом регистрации при производстве.</para>
    /// <para>В процессе эксплуатации может возникнуть необходимость ввести ЗН ККТ заново, если память ккт была сброшена.</para>
    /// <para>Если ФН в ККТ был зарегистрирован, ввод некорректного ЗН приведёт к повторной блокировке.</para>
    /// <para>В этом случае нужно вводить именно тот ЗН, с которым ККТ была зарегистрирована.</para>
    /// <para>ЗН указан на наклейке на корпусе аппарата, например: Заводской номер №199036000000 Дата 13 октября 2017</para>
	/// </summary>
    /// <param name="serial">строка - заводской номер ККТ, состоящий из цифр, например, 199036000000</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>установка заводского номера
    ///     <code>
	///			IFiscalCore.SetSerial("0000000001",callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    void SetSerial(String serial, IExceptionCallback callback);

    // **************************** Временные настройки ****************************
    /// <summary>
	/// <para><b>Временные настройки</b></para>
    /// <para>Установить имя кассира.</para>
    /// <para>Используется для печати документов от чьего-либо имени.</para>
    /// <para>Не является опцией.</para>
    /// <para>Нужно задавать перед началом печати чеков либо при смене кассира, обслуживающего ККТ.</para>
    /// </summary>
    /// <param name="cashier">строка - имя и номер кассира</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <example>открыть чек на продажу
    ///     <code>
    ///         IFiscalCore.SetUserName(Cashier.Text,callback);
	///			callback.Complete();
    ///         recType = (int)RecType.Sell;//приход
    ///         IFiscalCore.OpenRec(recType,callback);
	///			callback.Complete();
    ///     </code>
    /// </example>
    void SetUserName(String cashier, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Временные настройки</b></para>
    /// <para>Опция - настройка флага отрезки.</para>
    /// <para>Устанавливать перед закрытием документа, если нужно сменить тип отрезки.</para>
    /// <para>Возможные значения, если отрезка поддерживается:</para>
    /// </summary>
    /// <param name="newvalue">новое значение флага отрезки</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.CutType"/>
    void SetCutType(int newValue, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Временные настройки</b></para>
    /// <para>Установить телефон или электронный адрес покупателя (1008). Выполняется один раз на весь чек. Повторная передача ведёт к нарушению ФФД.</para>
    /// <para>Для успешной передачи необходимо, чтобы был установлен тег 1117 - IFiscalCore.SetSenderEmail, т.к. 1008 и 1117 применяются совместно.</para>
    /// <para>Для фискального режима, если открыт чек (com.multisoft.drivers.fiscalcore.RecState.Opened) на приход/возврат прихода/расход/возврат расхода. </para>
    /// <para>Если перед OpenRec была вызвана функция IFiscalCore.ForcePrintForm с параметром false, вызов IFiscalCore.SendClientAddress обязателен.</para>
	/// <para>Следует передавать в формате: "+{Ц}" или "{С}@{C}" без скобок и кавычек, скобки указывают на многократное повторение цифры (Ц) или символа (С) в представимом в CP866 виде.</para>
    /// <param name="addr">адрес и/или номер телефона клиента. Максимум 64 символа.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	/// </summary>
    /// <returns>true в случае успеха, иначе false </returns>
    /// <seealso cref="IFiscalCore.ForcePrintForm"/>
    /// <example>
    ///     <code>
    ///         IFiscalCore.SetUserName(Cashier.Text,callback);
	///			callback.Complete();
    ///         recType = (int)RecType.Sell;//приход
    ///         IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///			callback.Complete();
    ///         IFiscalCore.OpenRec(recType,callback);
	///			callback.Complete();
    ///         //добавление первой позиции:
    ///         IFiscalCore.SetItemTaxes((int)TaxNum._0,callback);// НДС 0%
	///			callback.Complete();
    ///         IFiscalCore.SetShowTaxes(true,callback);
	///			callback.Complete();
    ///         IFiscalCore.PrintRecItem("24", "1.05", "товар", "",callback);
	///			callback.Complete();
    ///         // добавление остальных позиций
    ///         // . . .
    ///         //
    ///         //установка адреса клиента. выполняется до CloseRec()
    ///         IFiscalCore.SendClientAddress("ivanov_889278@address.ru",callback);
	///			callback.Complete();
    ///         IFiscalCore.PrintRecTotal(callback);//печать итога
	///			callback.Complete();
	///			total = IFiscalCore.GetRecTotal(callback);
    ///         IFiscalCore.PrintRecItemPay((byte)PayType.Cash, total, "НАЛИЧНЫМИ:",callback);
	///			callback.Complete();
    ///         IFiscalCore.CloseRec(callback);//закрытие документа
	///			callback.Complete();
    ///     </code>
    /// </example>
    void SendClientAddress(String addr, IExceptionCallback callback);


    // **************************** Дополнительные настройки ****************************
    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установка заголовка чека - строк, печатающихся до чека. Параметры сохраняются при вызове. Не требует SaveOptions
    /// </summary>
    /// <param name="header">список строк для заговлока</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetHeaderLines(in List<String> header, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установка дополнительных строк, печатающихся после чека. Параметры сохраняются при вызове. Не требует SaveOptions
    /// </summary>
    /// <param name="trailer">список строк</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetTrailerLines(in List<String> trailer, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// Установка упреждающей печати заголовка.
    /// <para>если true, заголовок следующего чека печатается после окончания печати предыдущего</para>
    /// <para>если false, заголовок печатается перед печатью чека.</para>
    /// </summary>
    /// <param name="newState">true - печатать заголовок сразу после </param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetPrePrintHeaderLines(boolean newState, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка дополнительных настроек</b></para>
    /// <para>Автоинкассация при закрытии смены. Выполняется перед закрытием смены.</para>
	/// <para>Закрытие смены, выполненное после этой функции, произойдёт с автоматическим обнулением счётчика наличности в денежном ящике.</para>
    /// </summary>
    /// <param name="newState">true - автоинкассация включена, false - выключена</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetDayCloseAutoPayOut(boolean newState, IExceptionCallback callback);


    // **************************** Чек ****************************
    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Печать QR-кода.</para>
    /// </summary>
    /// <param name="value">строка - контент</param>
    /// <param name="align">выравнивание</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Align"/>
	void PrintQRCode(String value, int align, IExceptionCallback callback);


	// **************************** Чтение статуса ФН ****************************
    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// <para>Вернуть номер последнего фискального документа (кешируется).</para>
    /// <para>Функция аналогична FNGetLastFDNumber, но выполняется быстрее.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>номер последнего фискального документа</returns>
	long FNGetLastFDNum(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чтение статуса ФН</b></para>
    /// <para>Вернуть ФП последнего фискального документа (кешируется)</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>фискальный признак</returns>
	long FNGetLastFiscalSign(IExceptionCallback callback);

	// **************************** Статус ККТ ****************************
	/// <summary>
	/// <para><b>Статус ККТ</b></para>
	/// <para>Название ККТ в реестре</para>
    /// </summary>
	/// <returns>название ККТ</returns>
	String GetKKTRegisteredName();

    // **************************** Временные настройки ****************************
	/// <summary>
    /// <para><b>Временные настройки</b></para>
	/// <para>Принудительно отключить печать следующего документа</para>
    /// </summary>
	/// <param name="printNextDocument">false - отключить печать следующего документа. true - ничего не предпринимать.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	/// <example>
    ///     <code>
    ///         IFiscalCore.ForcePrintForm(false,callback);
	///			callback.Complete();
    ///         recType = (int)RecType.Sell;//приход
    ///         IFiscalCore.SetTaxationUsing(taxationSystem,callback);//установка системы налогообложения
	///			callback.Complete();
    ///         IFiscalCore.OpenRec(recType,callback);
	///			callback.Complete();
    ///         // добавление позиций
    ///         // . . .
    ///         //установка адреса клиента. Обязательна для Sell, SellRefund, Buy, BuyRefund
    ///         IFiscalCore.SendClientAddress("+79991112233",callback);
	///			callback.Complete();
    ///         IFiscalCore.PrintRecTotal(callback);//печать итога
	///			callback.Complete();
    ///         IFiscalCore.PrintRecItemPay((byte)PayType.Cash, "99.90", "НАЛИЧНЫМИ:",callback);
	///			callback.Complete();
    ///         IFiscalCore.CloseRec(callback);//закрытие документа
	///			callback.Complete();
    ///     </code>
    /// </example>
	void ForcePrintForm(boolean printNextDocument, IExceptionCallback callback);

	// **************************** Чтение статуса ФН ****************************
    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// <para>Вернуть систему налогообложения, указанную при регистрации, по номеру</para>
    /// </summary>
    /// <param name="regNum">номер регистрации</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>код системы налогообложения, указанной при регистрации</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxCode"/>
	int FNGetRegTaxSystemByNum(int regNum, IExceptionCallback callback);

	/// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// <para>Вернуть режим работы, указанный при регистрации, по номеру</para>
    /// </summary>
    /// <param name="regNum">номер регистрации</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>режим работы, указанный при регистрации</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.OperatingMode"/>
	int FNGetOpModeByNum(int regNum, IExceptionCallback callback);

    // ****************************  Состояние смены ****************************
	/// <summary>
    /// <para><b>Состояние смены: отчёты</b></para>
    /// Запрос суммы оплат с учетом остатка на начало смены по типу счётчика
    /// </summary>
    /// <param name="counterType">тип счётчика</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>сумма по счётчику</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
    String GetPayTotal(int counterType, IExceptionCallback callback);

    // **************************** Чек ****************************
    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Вывести на печать штрих-код.</para>
	/// <para>Ограничения на количество символов:</para>
    /// <para>Code39: до 13 символов</para>
    /// <para>Code93: до 16 символов</para>
    /// <para>Code128: до 15 символов</para>
    /// <para>Ean8: 8 цифр</para>
    /// <para>Ean13: 13 цифр</para>
    /// <para>ITF чётное, от 6 до 18 символов</para>
    /// <para>Codebar до 18 символов</para>
	/// </summary>
    /// <param name="type">тип штрих-кода BarCode</param>
    /// <param name="align">выравнивание Align, вне зависимости от передаваемого значения будет выполнено выравнивание по левому краю (1.7.27)</param>
    /// <param name="value">строка - контент</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.BarCode"/>
	/// <seealso cref="com.multisoft.drivers.fiscalcore.Align"/>
	void PrintBarCode(int type, int align, String value, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// Протяжка чековой ленты на count строк, если count > 0, иначе протяжка по умолчанию. Выполняется при открытом документе.
    /// </summary>
    /// <param name="count">количество строк для протяжки</param>
    /// <param name="callback"></param>
	void Feed(int count, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Установка атрибутов тега по номеру.</para>
	/// <para>Значения по умолчанию см. com.multisoft.drivers.fiscalcore.Tag.</para>
    /// <para> Тег (tag) com.multisoft.drivers.fiscalcore.Tag.ExciseTag устанавливается до вызова IFiscalCore.Register / IFiscalCore.CorrectRegistration</para>
	/// <para> Остальные теги устанавливаются до вызова IFiscalCore.PrintRecItem</para>
    /// <para>Для каждой позиции чека функцию IFiscalCore.SetTagAttribute нужно вызывать снова до IFiscalCore.PrintRecItem, в составе которой необходимо передать соответствующий тег.</para>
	/// <para>Валидация тегов, относящихся к признаку агента, относительно их совместимости со значением тега 1222 отсутствует.</para>
    /// </summary>
    /// <param name="tag">номер тега com.multisoft.drivers.fiscalcore.Tag</param>
    /// <param name="value">строковое представление данных тега.</param>
	/// <seealso cref="com.multisoft.drivers.fiscalcore.Tag"/>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetTagAttribute(int tag, String value, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// Запрос ФД документа о (пере)регистрации по её порядковому номеру
    /// </summary>
    /// <param name="regNum">порядковый номер (пере)регистрации</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>номер ФД (пере)регистрации</returns>
	int FNGetRegFDByNum(int regNum, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Статус ККТ</b></para>
    /// Запрос сменных счётчиков по типам документов и оплат
    /// </summary>
    /// <param name="docType">счётчик - тип документа. поддерживаются: Counter.SELL, Counter.SELL_REFUND, Counter.BUY, Counter.BUY_REFUND, Counter.PAID_IN, Counter.PAID_OUT</param>
    /// <param name="payType">счётчик - тип оплаты. поддерживаются Counter.CASH, Counter.CARD, Counter.BANK, Counter.TARE, Counter.VOUCHER</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>сумма за смену по указанным счётчикам</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
	String GetDayPayTotalByDocType(int docType, int payType, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Итог</b></para>
    /// Возвращает сумму оплат (PrintRecItemPay) открытого чека по её типу. Для контроля PrintRecItemPay
    /// </summary>
    /// <param name="payType">тип оплаты. поддерживается Counter.CASH, Counter.CARD, Counter.BANK, Counter.TARE, Counter.VOUCHER</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>строка - сумма оплат</returns>
    /// <seealso cref="IFiscalCore.PrintRecItemPay"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
    String GetRecPayTotal(int payType, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Сервисные команды</b></para>
    /// <para>Выполняет сброс подключенного ФН, если он - отладочный.</para>
    /// <para>Если ФН не отладочный, возвращается ошибка com.multisoft.drivers.fiscalcore.ErrorCode.WrongStatus com.multisoft.drivers.fiscalcore.ExtStatusErr.Common</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void FNResetDebug(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Работа с архивом ФН</b></para>
    /// <para>Запрос ФП документа, выбранного с помощью IFiscalCore.QueryFiscalDocInfo</para>
    /// </summary>
    /// <returns>ФП документа</returns>
	long FDI_GetFiscalSign();

    /// <summary>
    /// <para><b>Работа с архивом ФН</b></para>
    /// <para>Запрос даты документа, выбранного ранее с помощью IFiscalCore.QueryFiscalDocInfo</para>
    /// </summary>
    /// <returns>дата в формате "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"</returns>
    String FDI_GetDate();

    /// <summary>
    /// <para><b>Работа с архивом ФН</b></para>
	/// <para><b>deprecated</b> так как ФН в процессе работы удаляет данные о TLV.</para>
	/// <para><b>Для вычитывания значения тегов в документах регистрации необходимо использовать IFiscalCore.GetRegistrationParameter</b></para>
    /// <para>Запрос TLV документа, выбранного с помощью IFiscalCore.QueryFiscalDocInfo</para>
    /// <para>Возвращает строку массивом TLV документа в формате JSON.</para>
    /// <para><b>TLV</b> пеердаётся как <b>{"Tag":%номер%,"Val":"%значение%"}</b></para>
    /// <para>%<b>номер</b>% - целочисленный номер тега (без символов %);</para>
    /// <para>%<b>значение</b>% - значение тега(без символов %);</para>
    /// <para><b>Регистры битов (1055, 1057)</b> передаются числом (int);</para>
    /// <para><b>ФПД (1077)</b> передаётся в виде строки "ЦЦЦЦЦЦЦЦЦЦ", как в печатной форме;</para>
    /// <para><b>ФПО (1078)</b> - в виде строки с шестнадцатеричным представлением данных, как в печатной форме;</para>
    /// <para>Остальные <b>byte, UInt32, UInt16</b> передаются числом (int);</para>
    /// <para><b>UnixTime</b> - в формате "ДД.ММ.ГГ ЧЧ:ММ";</para>
    /// <para><b>суммовые (VLN, FVLN)</b> - в виде строки; строковые - без изменений;</para>
    /// <para><b>Код товарной номенклатуры (1162)</b> - в виде строки;</para>
    /// <para><b>STLV</b> передаются как TLV с тегом и массивом TLV вместо значения (Val).</para>
    /// <example>
    ///     <code>
	///     	//Предмет расчёта (1059) является STLV и передаётся следующим образом:
    ///         {"Tag":1059,"Val":[{"Tag":1030,"Val":"Товар"},{"Tag":1079,"Val":"1.11"},{"Tag":1023,"Val":"1.00"},{"Tag":1199,"Val":1},{"Tag":1043,"Val":"1.11"}]}
    ///     </code>
    /// </example>
    /// </summary>
    /// <returns>Массив TLV и STLV документа в JSON</returns>
    /// <seealso cref="IFiscalCore.QueryFiscalDocInfo"/>
	String FDI_GetDocJSON();

	/// <summary>
    /// <para><b>Сервисные команды</b></para>
    /// <para>Управление логгером</para>
    /// <para>Rotate - выполняет принудительную ротацию лога. Запускает фоновый процесс по архиввации логов.</para>
    /// <para>UploadToSD - выполняет копирование текущего лога на карту памяти, а также выгрузку всех ранее созданных архивов.</para>
    /// <para>Если после Rotate сразу вызвать UploadToSD, вторая команда будет выполнена после окончания работы первой.</para>
    /// <para>Самые ранние архивы удаляются, пока суммарный объём логов c архивом больше 200МБ и количество архивов больше 2.</para>
    /// </summary>
    /// <param name="loggerCommand">код команды</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.LoggerCommand"/>
	void LoggerControl(int loggerCommand, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Установить признак агента (1057).</para>
    /// <para>Для изменения признака агента в чеке вызывается до его (чека) открытия.</para>
    /// <para>Нужна при формировании чеков, если ККТ зарегистрирована с 1 и более признаками агента</para>
    /// <para>Не является опцией. Действует с момента первого вызова до переинициализации, либо до повторного вызова</para>
    /// </summary>
    /// <param name="agent">используемый признак агента</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
	void SetAgentTagUsing(int agent, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чтение статуса ФН</b></para>
    /// <para>Запрос признака агента из ФН</para>
    /// <para>Нужна при формировании чеков, если ККТ зарегистрирована с 1 и более признаками агента</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>Признак агента, указанный при (пере)регистрации</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.AgentTag"/>
    /// <example>
	///    <code>
	///     //пример выбора признака агента перед открытием чека
    ///     agent = IFiscalCore.GetAgentTag(callback);
    ///     if(agentUsing & agent != 0)
    ///     {
    ///         IFiscalCore.SetAgentTagUsing(agentUsing, callback);
    ///         callback.Complete();
    ///         IFiscalCore.OpenRec((int)RecType.Sell, callback);
    ///         callback.Complete();
	///    </code>
    /// </example>
    int GetAgentTag(IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Настройка шрифта, по умолчанию 0.</para>
    /// <para>К-во символов в строке настраивается автоматически.</para>
	/// <para>Значение сбрасывается в дефолт после переинициализации ФЯ, в т.ч. после выполнения IFiscalCore.SelfTest и IFiscalCore.SaveOptions.</para>
    /// <para>Использовать с осторожностью. При больших значениях РН ККТ и номер ФН не умещаются в 1 строку.</para>
    /// <para>Допускается менять текст перед любыми командами печати.</para>
    /// <para>После применения обязательно устанавливать значение по умолчанию (0).</para>
    /// </summary>
    /// <param name="fontSize">Размер шрифта. Стандартный размер - 0. Для P1, V1 разрешены значения от 0 до 22. Для T1mini80 - от 0 до 28.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    void SetFont(int fontSize, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Печать растровых изображений.</para>
    /// <para>для V1, P1: не более 384 пикселя в ширину</para>
    /// </summary>
    /// <param name="rawFileData">массив байт файла с изображением</param>
	void PrintRaster(in byte[] rawFileData, IExceptionCallback callback);

	/// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Печать текста с переводом строки.</para>
    /// </summary>
    /// <param name="left">строка текста для печати слева</param>
    /// <param name="right">строка текста для печати справа</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Align"/>
	void PrintLineAligned(String left, String right, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек коррекции</b></para>
    /// <para>Установить суммовые налоги в чеке коррекции.</para>
    /// <para>i-элементу в массиве номеров налогов соответствует i-элемент массива сумм налогов</para>
    /// </summary>
    /// <param name="taxNum">массив номеров налогов</param>
    /// <param name="taxSum">массив сумм налогов</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TaxNum"/>
    /// <example>
    ///     <code>
    ///         IFiscalCore.SetUserName(cashier,callback);
    ///         IFiscalCore.SetTaxationUsing(TaxCode.Common,callback);
    ///			callback.Complete();
    ///         IFiscalCore.OpenRec(RecType.CorrectionReceipt,callback);
    ///			callback.Complete();
    ///			string docName = "01.02.2017 не сформирован и не выдан кассовый чек";
    ///			string docNum = "32";
    ///			string docDate = "2017-02-28T19:12:03.000Z";
    ///         int[] taxNum = new[] {(int)TaxNum._10, (int)TaxNum._18_118};
    ///         string[] taxSum = new[] {"1.23", "2.13"};
    ///         IFiscalCore.SetSumTaxes(taxNum,taxSum,callback);
    ///         callback.Complete();
    ///         IFiscalCore.FNMakeCorrectionRec((int)OperationType.Sell,"10","0","0.00","0.00","0.05",(int)TaxNum._18,(int)CorrectionRecType.Independent,docName,docDate,docNum,callback);
    ///			callback.Complete();
    ///         IFiscalCore.CloseRec(callback);
    ///			callback.Complete();
    ///     </code>
    /// </example>
	void SetSumTaxes(in int[] taxNum, in String[] taxSum, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Временные настройки</b></para>
    /// <para>Настройка печатной формы тегов</para>
    /// <para>Необходимо выполнять после IFiscalCore.SetTagAttribute и перед вызовом IFiscalCore.PrintRecItem</para>
    /// <para>Не имеет смысла без IFiscalCore.SetTagAttribute с параметром, отличным от дефолтного.</para>
	/// <para>Значения по умолчанию см. com.multisoft.drivers.fiscalcore.Tag.</para>
    /// <para>После вызова IFiscalCore.PrintRecItem значение сбрасывается в дефолт.</para>
    /// </summary>
    /// <param name="tag">номер тега. в 1.12.37 поддерживается только 1212</param>
    /// <param name="printForm">Печатная форма тега. com.multisoft.drivers.fiscalcore.TagPrintForm</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Tag"/>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.TagPrintForm"/>
    /// <seealso cref="IFiscalCore.SetTagAttribute"/>
	void SetTagPrintForm(int tag, int printForm, IExceptionCallback callback);

	/// <summary>
    /// <para><b>Временные настройки</b></para>
    /// <para>Преобразует входную строку в дату и время методом DateTime.Parse()</para>
    /// <para>Устанавливает фиксированную дату и время в фискальном ядре.</para>
    /// <para>Только для нефискального режима, либо при подключенном МГМ ФН.</para>
    /// </summary>
    /// <param name="dateTime">строка с датой и временем</param>
	void FreezeDateTime(String dateTime, IExceptionCallback callback);

	/// <summary>
    /// <para><b>Временные настройки</b></para>
    /// <para>Восстанавливает системные дату и время в фискальном ядре</para>
    /// </summary>
    void ContinueDateTime();

    /// <summary>
    /// <para><b>Итог</b></para>
    /// <para>Печать итога с округлением до рубля.</para>
    /// <para>Используется вместо PrintRecTotal.</para>
    /// <para>Допускается округлять итог в меньшую сторону до целого значения итога рублях.</para>
    /// </summary>
    /// <param name="total">желаемая сумма итога</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <seealso cref="PrintRecTotal"/>
    void PrintRecTotalRound(String total, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Статус ККТ</b></para>
    /// <para>Получение статуса фискализации ККТ в фискальной памяти (ФП).</para>
    /// <para>До регистрации ФП не фискализирована.</para>
    /// <para>После первой и последующей регистраций ФП фискализирована.</para>
    /// <para>При клонировании ФП не фискализирована.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>true - фискальная память фискализирована, false - нет или ошибка</returns>
    /// <seealso cref="GetSerial"/>
	boolean GetFiscalMemoryFiscalized(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Подать сигнал на открытие денежного ящика (ДЯ), если присутствует.</para>
    /// <para>Если ДЯ отсутствует, коллбек об ошибке не вызывается.</para>
    /// </summary>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void OpenDrawer(IExceptionCallback callback);

    /// <summary>
	/// <para><b>Чек</b></para>
    /// <para>Принудительная установка ширины ленты.</para>
    /// <para>Только для MSPOS-Т-Ф с 80й лентой. В процессе работы ФЯ переинициализируется.</para>
    /// </summary>
    /// <param name="narrowWide">true - узкая, false - широкая</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке.</param>
	void SetPaperWidth(boolean narrowWide, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Чек</b></para>
    /// <para>Установка атрибутов тега по номеру.</para>
    /// <para>Значения по умолчанию см. com.multisoft.drivers.fiscalcore.Tag.</para>
	/// <para>Поддерживается только Tag.CommodityCode - 1162.</para>
	/// <para>Тег 1162 не печатается, т.к. передача КТН в виде массива байт подразумевает, что будут переданы непечатаемые символы.</para>
	/// <para>В этом случае невозможно сформировать печатную форму, идентичную электронной.</para>
	/// <para>1162 устанавливается только одной из функций SetTagByteAttribute или SetTagAttribute.</para>
	/// <para>Установка одного и того же тега одновременно SetTagAttribute и SetTagByteAttribute недопустимо.</para>
    /// </summary>
    /// <param name="tag">номер тега</param>
    /// <param name="value">значение в виде массива байт. null недопустим.</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
	void SetTagByteAttribute(int tag, in byte[] value, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Статус ККТ</b></para>
    /// Запрос счётчиков накоплений на начало смены по типу счётчика
    /// </summary>
    /// <param name="counter">тип счётчика. Поддерживаются SELL, SELL_REFUND, BUY, BUY_REFUND </param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке</param>
    /// <returns>Строковое значение счётчика.</returns>
    /// <seealso cref="com.multisoft.drivers.fiscalcore.Counter"/>
	String GetGrandTotalsSalesGross(int counter, IExceptionCallback callback);

    /// <summary>
    /// <para><b>Работа с архивом ФН</b></para>
    /// <para>Запрос значения тега по его номеру и номеру документа о (пере)регистрации</para>
    /// <para>Рекомендуется использовать вместо IFiscalCore.FDI_GetDocJSON</para>
    /// </summary>
    /// <param name="regNum">номер регистрации в ФН</param>
    /// <param name="tlvNum">номер тега</param>
    /// <param name="callback">функция обратного вызова для передачи информации об ошибке.</param>
    /// <returns>значение тега из TLV, приведённое к строке</returns>
    /// <seealso cref="IFiscalCore.FDI_GetDocJSON"/>
	String GetRegistrationParameter(int regNum, int tlvNum, IExceptionCallback callback);

    /// <summary>
	/// <para><b>Установка основных настроек</b></para>
    /// <para>Установить настройку форматно-логического контроля (ФЛК) TLV</para>
	/// <para>Значение по умолчанию - false (выкл.)</para>
    /// </summary>
    /// <param name="newValue">true - контроль вкл, false - выкл.</param>
	void SetFLC(boolean newValue);

    /// <summary>
    /// <para><b>Установка основных настроек</b></para>
    /// <para>Получить значение настройки форматно-логического контроля (ФЛК) TLV</para>
	/// <para>Значение по умолчанию - false (выкл.)</para>
    /// </summary>
    /// <returns>true - контроль вкл, false - выкл.</returns>
	boolean GetFLC();
}
