import os
import imgaug as ia
from imgaug import augmenters as iaa
import numpy as np
import cv2

def load_yolo_annotations(label_path, image_width, image_height):
    with open(label_path, 'r') as file:
        lines = file.readlines()

    boxes = []
    for line in lines:
        values = line.strip().split()
        class_label = int(values[0])
        x_center, y_center, width, height = map(float, values[1:])
        xmin = int((x_center - width / 2) * image_width)
        ymin = int((y_center - height / 2) * image_height)
        xmax = int((x_center + width / 2) * image_width)
        ymax = int((y_center + height / 2) * image_height)
        boxes.append([xmin, ymin, xmax, ymax, class_label])

    return np.array([boxes])

def save_yolo_annotations(output_label_path, augmented_boxes, image_width, image_height, base_name, i):
    label_filename = f"{base_name}augmented{i}.txt"
    label_path = os.path.join(output_label_path, label_filename)

    with open(label_path, 'w') as file:
        for box in augmented_boxes[0]:
            x_center = (box[0] + box[2]) / (2.0 * image_width)
            y_center = (box[1] + box[3]) / (2.0 * image_height)
            width = (box[2] - box[0]) / image_width
            height = (box[3] - box[1]) / image_height
            line = f"0 {x_center:.6f} {y_center:.6f} {width:.6f} {height:.6f}\n"
            file.write(line)


def augment_images_labels_yolo(image_path, label_path, output_image_path, output_label_path, num_augmentations):
    global image_width, image_height
    image = cv2.imread(image_path)
    image_height, image_width, _ = image.shape
    boxes = load_yolo_annotations(label_path, image_width, image_height)

    seq = iaa.Sequential([
        iaa.Fliplr(0.5),  # horizontal flips
        iaa.Affine(rotate=(-10, 10)),  # rotation
        iaa.Multiply((0.8, 1.2)),  # brightness
        iaa.GaussianBlur(sigma=(0.0, 3.0))  # Gaussian blur
    ])

    for i in range(num_augmentations):
        bboxes = boxes[0][:4]
        class_labels = boxes[0][:4]

        bb_objects = [ia.BoundingBox(x1=int(x[0]), y1=int(x[1]), x2=int(x[2]), y2=int(x[3]), label=int(c[0])) for x, c in zip(bboxes, class_labels)]
        bbs = ia.BoundingBoxesOnImage(bb_objects, shape=image.shape)

        augmented = seq(image=image, bounding_boxes=bbs)
        aug_image = augmented[0]
        aug_bbs = augmented[1]

        augmented_boxes = np.array([[bb.x1, bb.y1, bb.x2, bb.y2, bb.label] for bb in aug_bbs.bounding_boxes])

        # Save augmented image and labels directly to the specified location
        base_name = os.path.splitext(os.path.basename(image_path))[0]
        output_image_filename = f"{base_name}augmented{i}.jpg"
        output_image_path_i = os.path.join(output_image_path, output_image_filename)
        cv2.imwrite(output_image_path_i, aug_image)

        output_label_filename = f"{base_name}augmented{i}.txt"
        output_label_path_i = os.path.join(output_label_path, output_label_filename)
        save_yolo_annotations(output_label_path, [augmented_boxes], image_width, image_height, base_name, i)

        cv2.imshow("Augmented Image", aug_image)
        cv2.waitKey(100)

    cv2.destroyAllWindows()


# Example usage
image_folder = 'C:\\Users\\Musawer-Hussain\\Desktop\\Augmentation\\old_data'
label_folder = 'C:\\Users\\Musawer-Hussain\\Desktop\\Augmentation\\old_data'
output_image_folder = 'C:\\Users\\Musawer-Hussain\\Desktop\\Augmentation\\new_data'
output_label_folder = 'C:\\Users\\Musawer-Hussain\\Desktop\\Augmentation\\new_data'
num_augmentations = 5

# List all image files in the folder
image_files = [f for f in os.listdir(image_folder) if f.lower().endswith(('.jpg', '.png'))]

for image_file in image_files:
    image_path = os.path.join(image_folder, image_file)
    label_file = os.path.splitext(image_file)[0] + '.txt'
    label_path = os.path.join(label_folder, label_file)
    output_image_path = output_image_folder
    output_label_path = output_label_folder

    augment_images_labels_yolo(image_path, label_path, output_image_path, output_label_path, num_augmentations)