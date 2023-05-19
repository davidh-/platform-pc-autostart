from pywinauto.application import Application
import time

# Connect to the application
app = Application().connect(path='C:/Program Files/OTDAU/otdau217.exe')

tktoplevel = app.TkTopLevel
tktoplevel.wait('ready', timeout=15)

windows = app.windows(title_re='OTDAU -- Optical Tracking Data Acquisition Unit    Version 2.17  12-7-22')
handle_main = windows[0].handle

window_main = app.window(handle=handle_main)
window_main.set_focus()

button_load = window_main['Button25']
button_load.click_input()

# Wait for the open file dialog
dialog = app.window(title_re='Select a configuration File') 
dialog.wait('ready')

# Type the file path and press enter
dialog.type_keys('c-dahua-81242-109-2880-2160-and-dahua-50432-108-2560x1440-52000-sysconfig.txt{ENTER}', with_spaces=True)

# click recording menu button
menu_item = tktoplevel.menu_item(u'Recording')
menu_item.click()

windows_new = app.windows(title_re='OTDAU -- Optical Tracking Data Acquisition Unit    Version 2.17  12-7-22')
handle_rec = windows_new[0].handle

window_record = app.window(handle=handle_rec)
window_record.set_focus()

# click enable recording
window_record['Button12'].click_input()

# click save recording options
window_record['Button2'].click_input()

# close recording options
window_record['Button1'].click_input()


# click run 
button_run = window_main['Button27']
button_run.click_input()


