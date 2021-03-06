&НаКлиенте
Процедура ОК(Команда)
	ИдентификаторЗадания = Неопределено;
	ВыполнитьФоновоеЗадание(ИдентификаторЗадания);
	Закрыть(ИдентификаторЗадания);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьФоновоеЗадание(ИдентификаторЗадания)
	//Попытка	
	ФоновоеЗадание = ФоновыеЗадания.Выполнить(ИмяМетода, , Ключ, Наименование);
	ИдентификаторЗадания = ФоновоеЗадание.УникальныйИдентификатор;
	//Исключение	
	//	Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
	//КонецПопытки;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗаданиеИД = Параметры.ИдентификаторЗадания;
	ФоновоеЗадание = ПолучитьОбъектФоновогоЗадания(ЗаданиеИД);
	Если ФоновоеЗадание <> Неопределено Тогда
		ИмяМетода = ФоновоеЗадание.ИмяМетода;
		Наименование = ФоновоеЗадание.Наименование;
		Ключ = ФоновоеЗадание.Ключ;
	Иначе
		//Ключ = Новый УникальныйИдентификатор;
	КонецЕсли;

	Если Параметры.Свойство("ИмяМетода") Тогда
		ИмяМетода = Параметры.ИмяМетода;
		Наименование = Параметры.Наименование;
		Ключ = Параметры.Ключ;
	КонецЕсли;
	Для Каждого Метаданное Из Метаданные.РегламентныеЗадания Цикл
		Элементы.ИмяМетода.СписокВыбора.Добавить(Метаданное.ИмяМетода);
	КонецЦикла;
	Элементы.ИмяМетода.СписокВыбора.СортироватьПоЗначению();

КонецПроцедуры

&НаСервере
Функция ПолучитьОбъектФоновогоЗадания(УникальныйНомерЗадания) Экспорт

	Попытка

		Если Не ПустаяСтрока(УникальныйНомерЗадания) Тогда
			УникальныйИдентификаторЗадания = Новый УникальныйИдентификатор(УникальныйНомерЗадания);
			ТекущееФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(УникальныйИдентификаторЗадания);
		Иначе
			ТекущееФоновоеЗадание = Неопределено;
		КонецЕсли;

	Исключение
		ТекущееФоновоеЗадание = Неопределено;
	КонецПопытки;

	Возврат ТекущееФоновоеЗадание;

КонецФункции