netsh wlan show profiles

netsh wlan set profileorder name="DAH20" interface="Wi-Fi" priority=1

netsh wlan set profileorder name="Hello" interface="Wi-Fi" priority=2

netsh wlan set profileorder name="platform-wifi" interface="Wi-Fi" priority=3

netsh wlan set profileorder name="platform-android" interface="Wi-Fi" priority=4

netsh wlan show profiles
