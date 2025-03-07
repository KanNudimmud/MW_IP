import cv2
import numpy as np

img = cv2.imread("Resources/Lena.jpg")

imgHor = np.hstack((img,img))
imgVer = np.vstack((img,img))
imgStack = stackImages(0.5,([]))

cv2.imshow("Horizontal",imgHor)
cv2.imshow("Vertical",imgVer)
cv2.waitKey(0)