import cv2
import numpy as np

img = cv2.imread("Resources/cards.jpg")

width,height = 250,350
pts1  = np.float32([[100,100],[100,100],[100,100],[100,100]])
pts2  = np.float32([[0,0],[width,0],[0,height],[width,height]])
matrix = cv2.getPerspectiveTransform(pts1,pts2)
imgOut = cv2.warpPerspective(img,matrix,(width,height))

print(img.shape)
cv2.imshow("Image",img)
cv2.imshow("Wrapped Image",imgOut)
cv2.waitKey(0)