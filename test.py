import cv2
import numpy as np
import tensorflow.keras
import mediapipe as mp
model=tensorflow.keras.models.load_model('model_file.h5')

cap=cv2.VideoCapture(0)
facmesh = mp.solutions.face_mesh
face = facmesh.FaceMesh(static_image_mode=True, min_tracking_confidence=0.6, min_detection_confidence=0.6)
draw = mp.solutions.drawing_utils
faceDetect=cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

labels_dict={0:'Angry',1:'Disgust', 2:'Fear', 3:'Happy',4:'Neutral',5:'Sad',6:'Surprise'}

while True:
    ret,frame=cap.read()
    gray=cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces= faceDetect.detectMultiScale(gray, 1.3, 3)
    for x,y,w,h in faces:
        sub_face_img=gray[y:y+h, x:x+w]
        resized=cv2.resize(sub_face_img,(48,48))
        normalize=resized/255.0
        reshaped=np.reshape(normalize, (1, 48, 48, 1))
        result=model.predict(reshaped)
        label=np.argmax(result, axis=1)[0]
        print(label)
        cv2.rectangle(frame, (x,y), (x+w, y+h), (0,0,255), 1)
        cv2.rectangle(frame,(x,y),(x+w,y+h),(50,50,255),2)
        cv2.rectangle(frame,(x,y-40),(x+w,y),(50,50,255),-1)
        cv2.putText(frame, labels_dict[label], (x, y-10),cv2.FONT_HERSHEY_SIMPLEX,0.8,(255,255,255),2)
    print(frame.shape)
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    op = face.process(rgb)
    if op.multi_face_landmarks:
        for i in op.multi_face_landmarks:
            print(i.landmark[0].y*480)
            draw.draw_landmarks(frame, i, facmesh.FACEMESH_CONTOURS, landmark_drawing_spec=draw.DrawingSpec(color=(0,255,0), circle_radius=0))



    
        
    cv2.imshow("Frame",frame)
    k=cv2.waitKey(1)
    if k==ord('q'):
        break

cap.release()
cv2.destroyAllWindows()