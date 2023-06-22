from pywinauto.application import Application
import time

# Connect to the application
app = Application().connect(path='C:/Program Files (x86)/OTDAU/otdau218.exe')

tktoplevel = app.TkTopLevel
tktoplevel.wait('ready', timeout=15)

title = 'OTDAU -- Optical Tracking Data Acquisition Unit    Version 2.18  6-2-23'

windows = app.windows(title_re=title)
handle_main = windows[0].handle

window_main = app.window(handle=handle_main)
window_main.set_focus()

button_load = window_main['Button26']
button_load.click_input()

# # Wait for the open file dialog
# dialog = app.window(title_re='Select a configuration File') 
# dialog.wait('ready')

# path_low = 'c-dahua-81242-109-2048-1536-and-dahua-50432-108-2560x1440-52000-sysconfig.txt'
# path_high = 'c-dahua-81242-109-2880-2160-and-dahua-50432-108-2560x1440-52000-sysconfig.txt'
# path_new = 'c-dahua-81242-109-2880-2160-and-dahua-50432-108-2560x1440'

# path = path_new
# # Type the file path and press enter
# dialog.type_keys(path + '{ENTER}', with_spaces=True)

# # click recording menu button
# menu_item = tktoplevel.menu_item(u'Recording')
# menu_item.click()

# windows_new = app.windows(title_re=title)
# handle_rec = windows_new[0].handle

# window_record = app.window(handle=handle_rec)
# window_record.set_focus()

# # click enable recording
# window_record['Button12'].click_input()

# # click save recording options
# window_record['Button2'].click_input()

# # close recording options
# window_record['Button1'].click_input()


# click run 
button_run = window_main['Button28']
button_run.click_input()


# to-do: add check every so often to see if otdau running
# handle edge case when power boots for system and cameras notup yet. 