#/bin/bash
#
WORKING_PATH=$HOME/data/kaggle.com/UNS

mkdir -p $WORKING_PATH
pushd $WORKING_PATH

#
# TODO: error report
#
cp cookies.txt $WORKING_PATH

echo Downloading data...
wget -q -nH https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/train_masks.csv.zip &
wget -q --load-cookies cookies.txt -nH https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/sample_submission.csv.zip
wget -q --load-cookies cookies.txt -nH https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/test.zip
wget -q --load-cookies cookies.txt -nH https://www.kaggle.com/c/ultrasound-nerve-segmentation/download/train.zip

echo Extracting samples...
unzip train_masks.csv.zip
unzip sample_submission.csv.zip
unzip test.zip
unzip train.zip
echo Done!
popd

