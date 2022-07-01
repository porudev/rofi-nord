from bin.rofi import Rofi

"""
Weather module for py3status

By porudev
"""

import requests
import math
import config

icons_list = {
    "01d": "", # Clear sky day.
    "01n": "", # Clear sky night.
    "02d": "", # Few clouds day.
    "02n": "", # Few clouds night.
    "03d": "", # Scattered clouds day.
    "03n": "", # Scattered clouds night.
    "04d": "", # Broken clouds day.
    "04n": "", # Broken clouds night.
    "09d": "", # Shower rain day.
    "09n": "", # Shower rain night.
    "10d": "", # Rain day.
    "10n": "", # Rain night
    "11d": "", # Thunderstorm day.
    "11n": "", # Thunderstorm night
    "13d": "", # Snow day. Snowflake alternative: 
    "13n": "", # Snow night. Snowflake alternative: 
    "50d": "", # Mist day.
    "50n": "", # Mist night.
}

atmophere_icons_list = {
    701: "", # Mist
    711: "", # Smoke
    721: "", # Haze
    731: "", # Dust (Sand / dust whirls)
    741: "", # Fog
    751: "", # Sand
    761: "", # Dust
    762: "", # Ash
    771: "", # Squalls
    781: ""  # Tornado
}

def get_weather() -> str:
    try:
        url = f'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=20.9712&lon=107.0448&appid={config.key}'
        result = requests.get(url)

        if(result.status_code == requests.codes['ok']):        
                weather = result.json()

                icon = weather['weather'][0]['icon'].capitalize()
                desciption = weather['weather'][0]['description'].capitalize()
                temp = int(math.ceil(float(weather['main']['temp'])))
                feels_like = int(math.ceil(float(weather['main']['feels_like'])))

                return f" {icons_list[icon]} {desciption} {temp}°C feels like {feels_like}°C ", icons_list[icon]

        else:
            return "  No info "
    except:
        return "  No info "

today, icon = get_weather()

r = Rofi(rofi_args=['-theme', '~/rofi-nord/.rasi/weather.rasi'])
r.select(f'{today}', [f'{icon}', 'atmosphere', 'icon'],
    rofi_args=['-i'])
