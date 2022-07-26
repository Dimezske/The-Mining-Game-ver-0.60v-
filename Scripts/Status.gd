extends Node2D

func _input(event):
	if OS.is_window_maximized() == true:
		$Backingfs.visible = true
		$CurrencyContainer/Currency.visible = false
		$CurrencyContainer/Currencyfs.visible = true
		$CurrencyContainer/Currencyfs.set_position(Vector2(95,0))
		$EnergyContainer.visible = true
		$HealthContainer.set_position(Vector2(0,0))
		$CurrencyContainer.set_position(Vector2(550,0))
		$WeatherContainer.set_position(Vector2(1450,0))
		$WeatherContainer/Weather.visible = false
		$WeatherContainer/Weatherfs.visible = true
		$WeatherContainer/Weatherfs.set_position(Vector2(-200,0))
	if OS.window_fullscreen == true:
		$Backingfs.visible = true
		$CurrencyContainer/Currency.visible = false
		$CurrencyContainer/Currencyfs.visible = true
		$CurrencyContainer/Currencyfs.set_position(Vector2(95,0))
		$EnergyContainer.visible = true
		$HealthContainer.set_position(Vector2(0,0))
		$CurrencyContainer.set_position(Vector2(550,0))
		$WeatherContainer.set_position(Vector2(1450,0))
		$WeatherContainer/Weather.visible = false
		$WeatherContainer/Weatherfs.visible = true
		$WeatherContainer/Weatherfs.set_position(Vector2(-200,0))
	else:
		$Backingfs.visible = false
		$CurrencyContainer/Currency.visible = true
		$CurrencyContainer/Currencyfs.visible = false
		$EnergyContainer.visible = false
		$HealthContainer.set_position(Vector2(0,0))
		$CurrencyContainer.set_position(Vector2(345,0))
		$WeatherContainer.set_position(Vector2(775,0))
		$WeatherContainer/Weather.visible = true
		$WeatherContainer/Weatherfs.visible = false
func _ready():
	pass # Replace with function body.
