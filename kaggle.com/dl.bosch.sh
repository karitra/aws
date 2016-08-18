#/bin/bash
#
# Note: file cookies.txt should be present (not in repo)
#

WORKING_PATH=$HOME/data/kaggle.com/bosch
#
# TODO: error report
#
mkdir -p $WORKING_PATH
cp cookies.txt $WORKING_PATH

pushd $WORKING_PATH

DATA=(
https://www.kaggle.com/c/bosch-production-line-performance/download/test_categorical.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/train_categorical.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/train_date.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/test_date.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/sample_submission.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/test_numeric.csv.zip
https://www.kaggle.com/c/bosch-production-line-performance/download/train_numeric.csv.zip
)
for dl in ${DATA[*]}; do
	echo Downloading $dl...
	wget -c -q --load-cookies cookies.txt -nH $dl
done

echo Extracting samples...
unzip *.zip
echo Done!
popd

