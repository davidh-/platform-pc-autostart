import cv2
import argparse
import time
import socket

def is_camera_reachable(rtsp_url):
    try:
        # Extract the camera's IP address and port from the RTSP URL
        ip, port = rtsp_url[7:].split("/")[0].split(":")

        # Create a socket object
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # Set a timeout of 2 seconds for the connection attempt
        s.settimeout(2)

        # Try connecting to the camera's IP and port
        s.connect((ip, int(port)))

        # Close the socket
        s.close()

        return True

    except Exception:
        return False

def check_rtsp_camera_status(rtsp_url, username, password):
    try:
        # Check if the camera is reachable before proceeding
        if not is_camera_reachable(rtsp_url):
            print(f"Camera at {rtsp_url} is not reachable or encountered an error.")
            return False

        # Append the username and password to the RTSP URL
        rtsp_url_with_auth = f"{rtsp_url[:7]}{username}:{password}@{rtsp_url[7:]}"

        # Create a VideoCapture object to connect to the camera's RTSP stream
        cap = cv2.VideoCapture(rtsp_url_with_auth)

        # Check if the camera is opened and the stream is accessible
        if cap.isOpened():
            print(f"Camera at {rtsp_url} is ON and running.")
            return True
        else:
            print(f"Camera at {rtsp_url} is not reachable or encountered an error.")
            return False

        # Release the VideoCapture object
        cap.release()

    except Exception as e:
        print(f"Error while checking {rtsp_url}:", str(e))
        return False

if __name__ == "__main__":
    # Create the argument parser
    parser = argparse.ArgumentParser(description="Check the status of RTSP cameras.")
    parser.add_argument("username", type=str, help="Username for camera authentication")
    parser.add_argument("password", type=str, help="Password for camera authentication")
    args = parser.parse_args()

    # Replace the following variables with your camera's RTSP URLs
    camera1_rtsp_url = "rtsp://192.168.1.108:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif"
    camera2_rtsp_url = "rtsp://192.168.1.109:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif"

    while True:
        # Check status for Camera 1
        camera1_status = check_rtsp_camera_status(camera1_rtsp_url, args.username, args.password)

        # Check status for Camera 2
        camera2_status = check_rtsp_camera_status(camera2_rtsp_url, args.username, args.password)

        # Print the overall result based on camera statuses
        if camera1_status and camera2_status:
            print("Both cameras are ON and running.")
            break
        elif camera1_status:
            print("Camera 108 PTZ is ON and running, but Camera 109 ASC is OFF.")
        elif camera2_status:
            print("Camera 109 ASC is ON and running, but Camera 108 PTZ is OFF.")
        else:
            print("Both cameras are OFF.")

        print("Waiting for both cameras to be ON...")
        time.sleep(1)  # Wait for 60 seconds before checking again

    
