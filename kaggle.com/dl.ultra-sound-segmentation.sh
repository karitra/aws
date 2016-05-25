#/bin/bash
#
WORKING_PATH=$HOME/kaggle.com/UNS

mkdir -p $WORKING_PATH
pushd $WORKING_PATH

echo Downloading data...
wget -q https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/train_masks.csv.zip &
sleep 5 && wget -q https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/sample_submission.csv.zip & 
sleep 5 && wget -q https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/test.zip &
sleep 10 && wget -q https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/train.zip &

wait

echo Extracting samples...
unzip train_masks.csv.zip
unzip sample_submission.csv.zip
unzip test.zip
unzip train.zip
echo Done!
popd

