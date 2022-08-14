import cv2
import numpy as np

# Reading images
#img = cv2.imread("Resources/Lena.jpg")
#cv2.imshow("Output",img)
#cv2.waitKey(0)

# Reading videos
#cap = cv2.VideoCapture("Resources/Cars.mp4")
#while True:
 #   success,img = cap.read()
  #  cv2.imshow("Video",img)
  #  if cv2.waitKey(1) & 0xFF == ord('q'):
     #   break

# Reading pc-camera
cap = cv2.VideoCapture(0)
cap.set(3,640)
cap.set(4,480)
cap.set(10,100)
while True:
    success,img=cap.read()
    cv2.imshow("Video",img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break