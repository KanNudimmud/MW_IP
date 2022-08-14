import cv2
import numpy as np

# Gray scaled and blurred images
img = cv2.imread("Resources/Lena.jpg")

# Create a kernel
kernel = np.ones((5,5),np.uint8)

imgGray   = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
imgBlur   = cv2.GaussianBlur(imgGray,(7,7),0)
imgCanny  = cv2.Canny(img,100,100) # edge detection algo.
imgDilate = cv2.dilate(imgCanny,kernel,iterations=1)
imgErode  = cv2.erode(imgDilate,kernel,iterations=1)

cv2.imshow("Gray Image",imgGray)
cv2.imshow("Blurred Image",imgBlur)
cv2.imshow("Canny Image",imgCanny)
cv2.imshow("Dialated Image",imgDilate)
cv2.imshow("Eroded Image",imgErode)
cv2.waitKey(0)