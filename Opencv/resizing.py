import cv2
import numpy as np

img = cv2.imread("Resources/lambo.jpg")
print(img.shape)

imgResize = cv2.resize(img,(300,200))
print(imgResize.shape)

imgCrop = img[300:700,200:1200]

cv2.imshow("Image",img)
cv2.imshow("Resized Image",imgResize)
cv2.imshow("Cropped Image",imgCrop)
cv2.waitKey(0)