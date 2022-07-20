{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "2ae9d415",
   "metadata": {
    "_cell_guid": "b1076dfc-b9ad-4769-8c92-a6c4dae69d19",
    "_uuid": "8f2839f25d086af736a60e9eeb907d3b93b6e0e5",
    "papermill": {
     "duration": 0.005421,
     "end_time": "2022-07-20T02:05:36.803285",
     "exception": false,
     "start_time": "2022-07-20T02:05:36.797864",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Build KNN-Regression model that uses two inputes: \n",
    "# -displacement and -horsepower \n",
    "# to predict mpg average of a car\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "f2cdb50c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:36.818483Z",
     "iopub.status.busy": "2022-07-20T02:05:36.816031Z",
     "iopub.status.idle": "2022-07-20T02:05:36.992188Z",
     "shell.execute_reply": "2022-07-20T02:05:36.990063Z"
    },
    "papermill": {
     "duration": 0.187649,
     "end_time": "2022-07-20T02:05:36.995130",
     "exception": false,
     "start_time": "2022-07-20T02:05:36.807481",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "df <- read.csv('../input/auto-data/Auto1.csv', stringsAsFactors= FALSE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "b84eef9d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.047291Z",
     "iopub.status.busy": "2022-07-20T02:05:37.005482Z",
     "iopub.status.idle": "2022-07-20T02:05:37.079371Z",
     "shell.execute_reply": "2022-07-20T02:05:37.076452Z"
    },
    "papermill": {
     "duration": 0.083403,
     "end_time": "2022-07-20T02:05:37.082701",
     "exception": false,
     "start_time": "2022-07-20T02:05:36.999298",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t392 obs. of  9 variables:\n",
      " $ mpg         : num  18 15 18 16 17 15 14 14 14 15 ...\n",
      " $ cylinders   : int  8 8 8 8 8 8 8 8 8 8 ...\n",
      " $ displacement: num  307 350 318 304 302 429 454 440 455 390 ...\n",
      " $ horsepower  : int  130 165 150 150 140 198 220 215 225 190 ...\n",
      " $ weight      : int  3504 3693 3436 3433 3449 4341 4354 4312 4425 3850 ...\n",
      " $ acceleration: num  12 11.5 11 12 10.5 10 9 8.5 10 8.5 ...\n",
      " $ year        : int  70 70 70 70 70 70 70 70 70 70 ...\n",
      " $ origin      : int  1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ name        : chr  \"chevrolet chevelle malibu\" \"buick skylark 320\" \"plymouth satellite\" \"amc rebel sst\" ...\n"
     ]
    }
   ],
   "source": [
    "str(df)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "4f9083a3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.094929Z",
     "iopub.status.busy": "2022-07-20T02:05:37.093064Z",
     "iopub.status.idle": "2022-07-20T02:05:37.127848Z",
     "shell.execute_reply": "2022-07-20T02:05:37.125896Z"
    },
    "papermill": {
     "duration": 0.044624,
     "end_time": "2022-07-20T02:05:37.131319",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.086695",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "  displacement     horsepower   \n",
      " Min.   : 68.0   Min.   : 46.0  \n",
      " 1st Qu.:105.0   1st Qu.: 75.0  \n",
      " Median :151.0   Median : 93.5  \n",
      " Mean   :194.4   Mean   :104.5  \n",
      " 3rd Qu.:275.8   3rd Qu.:126.0  \n",
      " Max.   :455.0   Max.   :230.0  \n"
     ]
    }
   ],
   "source": [
    "df_inp <- df[,c('displacement', 'horsepower')]\n",
    "df_out <- df$mpg\n",
    "df_out1 <- df[,c('mpg')]\n",
    "print(summary(df_inp))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "01ab72cd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.143174Z",
     "iopub.status.busy": "2022-07-20T02:05:37.141478Z",
     "iopub.status.idle": "2022-07-20T02:05:37.155959Z",
     "shell.execute_reply": "2022-07-20T02:05:37.154064Z"
    },
    "papermill": {
     "duration": 0.023152,
     "end_time": "2022-07-20T02:05:37.158531",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.135379",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# there is no significant difference in magnitude amongst inputes, so normalization\n",
    "# is not necessary "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "db1ab143",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.170614Z",
     "iopub.status.busy": "2022-07-20T02:05:37.169003Z",
     "iopub.status.idle": "2022-07-20T02:05:37.194405Z",
     "shell.execute_reply": "2022-07-20T02:05:37.192031Z"
    },
    "papermill": {
     "duration": 0.035105,
     "end_time": "2022-07-20T02:05:37.197898",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.162793",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] 313\n"
     ]
    }
   ],
   "source": [
    "# training/testing:\n",
    "m <- nrow(df_inp)\n",
    "r <- 0.8 \n",
    "set.seed(45467)\n",
    "index_train <- sample(1:m , size = floor(r*m), replace = FALSE)\n",
    "print(length(index_train))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "b9863b93",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.210314Z",
     "iopub.status.busy": "2022-07-20T02:05:37.208658Z",
     "iopub.status.idle": "2022-07-20T02:05:37.235779Z",
     "shell.execute_reply": "2022-07-20T02:05:37.229568Z"
    },
    "papermill": {
     "duration": 0.036976,
     "end_time": "2022-07-20T02:05:37.239364",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.202388",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "X_train <- df_inp[index_train,]\n",
    "X_test <- df_inp[-index_train,]\n",
    "y_train <- df_out[index_train]\n",
    "y_test <- df_out[-index_train]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "f2ea48f9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.251389Z",
     "iopub.status.busy": "2022-07-20T02:05:37.249757Z",
     "iopub.status.idle": "2022-07-20T02:05:37.300188Z",
     "shell.execute_reply": "2022-07-20T02:05:37.298202Z"
    },
    "papermill": {
     "duration": 0.060073,
     "end_time": "2022-07-20T02:05:37.303536",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.243463",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Build KNN-Regression, k=5\n",
    "library(FNN)\n",
    "new_inp <- c(125,69)\n",
    "model <- knn.reg(train = X_train, test = new_inp, y= y_train, k=5  )"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "3043f1e4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.315651Z",
     "iopub.status.busy": "2022-07-20T02:05:37.313946Z",
     "iopub.status.idle": "2022-07-20T02:05:37.348232Z",
     "shell.execute_reply": "2022-07-20T02:05:37.346288Z"
    },
    "papermill": {
     "duration": 0.043461,
     "end_time": "2022-07-20T02:05:37.350992",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.307531",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "KNN Model with k=5: \n",
      "Engine displacement : 125 \n",
      "Horsepower: 69 \n",
      " Model Prediction MPG:  27.78"
     ]
    }
   ],
   "source": [
    "f_hat <- model$pred\n",
    "cat('KNN Model with k=5: \\n')\n",
    "cat('Engine displacement :' , new_inp[1], '\\n')\n",
    "cat('Horsepower:' , new_inp[2], '\\n')\n",
    "cat(' Model Prediction MPG: ', f_hat)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "7619663a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.363904Z",
     "iopub.status.busy": "2022-07-20T02:05:37.362158Z",
     "iopub.status.idle": "2022-07-20T02:05:37.398792Z",
     "shell.execute_reply": "2022-07-20T02:05:37.395666Z"
    },
    "papermill": {
     "duration": 0.046582,
     "end_time": "2022-07-20T02:05:37.401993",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.355411",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Training RMSE: 3.162933 \n",
      "Testing RMSE: 4.089409"
     ]
    }
   ],
   "source": [
    "# RMSE's k=5\n",
    "model_train <- knn.reg(train = X_train, test = X_train, y= y_train,  k=5)\n",
    "model_test <- knn.reg(train = X_train, test = X_test, y= y_train, k=5)\n",
    "rmse_train <- sqrt(mean((model_train$pred - y_train)^2))\n",
    "rmse_test <- sqrt(mean((model_test$pred - y_test)^2))\n",
    "cat('Training RMSE:' , rmse_train, '\\n')\n",
    "cat('Testing RMSE:' , rmse_test)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "f2a6f0f1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.416076Z",
     "iopub.status.busy": "2022-07-20T02:05:37.414031Z",
     "iopub.status.idle": "2022-07-20T02:05:37.970180Z",
     "shell.execute_reply": "2022-07-20T02:05:37.967075Z"
    },
    "papermill": {
     "duration": 0.567017,
     "end_time": "2022-07-20T02:05:37.973743",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.406726",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdeZyNdf/H8feZ3c5g7Esmg2RXkhJZx74maVJJWbJUtyhpKLrTXQqhTWXtDo1s\no0KWKJEs2SrL2PdtkDHr7w9+xrjPObOYc13nuub1/Mt8P98Zbz1a3n2v5ThSUlIEAAAA6/Mx\nOwAAAACyB8UOAADAJih2AAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgB\nAADYBMUOAADAJih2AAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADY\nBMUOAADAJih2AAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUO\nAADAJih2AAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADA\nJih2AAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2\nAAAANkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAA\nNkGxAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAANkGx\nAwAAsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAANkGxAwAA\nsAmKHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAANkGxAwAAsAmK\nHQAAgE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAANkGxAwAAsAmKHQAA\ngE1Q7AAAAGyCYgcAAGATFDsAAACboNgBAADYBMUOAADAJih2AAAANkGxAwAAsAmKHQAAgE1Q\n7AAAAGyCYgcAAGATFDsAAACb8DM7gAVcuHBh2rRpV65cMTsIAADwCrly5erZs2eBAgXMDnIr\nil36Zs2aNWjQILNTAAAAL+Ln59evXz+zU9yKYpe+hIQESVOnTq1Ro4bZWQAAgMm2bt3aq1ev\na/XA21DsMqpSpUp16tQxOwUAADBZXFyc2RFc4uEJAAAAm6DYAQAA2ATFDgAAwCYodgAAADZB\nsQMAALAJih0AAIBNUOwAAABsgmIHAABgExQ7AAAAm6DYAQAA2ATFDgAAwCYodgAAADZBsQMA\nALAJih0AAIBNUOwAAABsws/sAAAAAJ504oRmz9bWrZJUo4Z69FBIiNmZPIViBwAA7GvOHPXq\npUuXUldef12ff66uXc3L5EFcigUAADa1caN69EjT6iRduqTHHtPGjSZl8iyKHQAAsKl//1uJ\niU7WExP19tuGpzECxQ4AANjUTz9lZWRlFDsAAGBTFy+6HMXGGpjDOBQ7AABgU6VLuxyVKWNg\nDuNQ7AAAgE117Ohy1KGDgTmMQ7EDAAA29corqlDByXqFCnrlFcPTGIFiBwAAbCo4WGvWqG1b\nORzXVxwOtWunNWsUHGxqMk/hBcUAAMC+SpXSwoU6elRbtkhSzZoqWdLsTB5EsQMAAHZXsqS9\n+9wNXIoFAACwCYodAACwo9hY7dihw4fNzmEoih0AALCX3bvVurWCg3X33SpTRqGhmjrV7EwG\n4R47AABgI1u3qmHDNB8ssW+fnnlGf/9t18+HvRkndgAAwEb69HH+cWH/+Y82bzY8jdEodgAA\nwC7279f69c5Hycn6+mtj05iAYgcAAOxi3z530717jcphGoodAACwi8BAd9PcuY3KYRqKHQAA\nsIuaNRUU5HJat66BUcxBsQMAAHaRN6+eecb5KCREERHGpjEBxQ4AANjIf/6j8PBbF4sU0fz5\nKljQjECG4j12AADARoKCtGSJoqI0b5727VP+/GrUSM8+q6JFzU5mBIodAACwF4dDnTurc2ez\nc5iAS7EAAAA2wYkdAACwvthYffqpVqzQqVMqW1Zt26pHD/n7mx3LaBQ7AABgcbt2qWVLHTx4\n/cvfflNUlKZM0dKlCg42NZnRuBQLAACsLD5eHTqktrobNmzQ00+bEchMFDsAAGBlixfrr7+c\njxYs0N9/G5vGZBQ7AABgZRs3uptu2mRUDq9AsQMAAFZ29aq7aVycUTm8AsUOAABYWYUK7qah\noUbl8AoUOwAAYGUdOypXLuej8uVVv76xaUxGsQMAAJb166+aP1+tWjkZBQRo6lT55aw3u+Ws\nPy0AALCJvXvVo4d+/TV1xd9fCQmS5OOjBx/Uf/6je+4xK51ZKHYAAMBqzp9XkyY6cCDNYkKC\nAgM1fbqaNVOhQiYlMxmXYgEAgNVMmHBrq7vm6lV98UWObXWi2AEAAOv57juXoxUrrl+QzZEo\ndgAAwFISEnT0qLvp2bMGpvEuFDsAAGARJ0+qVy8FBzu/DnuNn19OvhTLwxMAAMAKjh5VgwaK\niUlnW8OGCggwIo9X4sQOAABYwcsvp9/qAgI0ZowRYbwVxQ4AAHi9K1f0zTfp7AkJ0Tff6L77\nDAnkpSh2AADA6x0+rLg4l9PSpTV3rvbvV5s2BmbyRtxjBwAAvF5goLtpaKi6dDEqilfjxA4A\nAHi90qVVvLjLaZ06BkbxahQ7AADg9Xx89PzzzkeBgerTx9g03otiBwAAvN6JE2reXO3b37oe\nFKTp01WxohmZvBH32AEAAC+2fLmGDtXvv1//slw5lS6tCxeUJ4/q11e/frS6m1HsAACAt5o7\nV48+quTk1JUDB3TwoL74Qj17mhfLe3EpFgAAeKVLl9SvX5pWd01KigYOzMkfCOsGxQ4AAHil\n5ct1+rTzUWysli41No01UOwAAIBX2rcv69OcimIHAAC8Uq5cWZ/mVBQ7AADglerVy/o0p6LY\nAQAAr1S7th5+2Pnovvv0wAPGprEGih0AAPBWs2erZs1bF++6S3PnyuEwI5C34z12AADAWxUr\npl9/1cyZWrJER4+qeHGFhysighvsXKHYAQAALxYQoKef1tNPm53DGrgUCwAAYBMUOwAA4JXO\nnNGhQ0pIMDuHlVDsAACAl/n8c1WurCJFVLasChVSz546dszsTNZAsQMAAN5k8GD16qU//7z+\n5eXLmj5d99yjgwdNjWUNFDsAAOA11q7V+PFO1o8c0aBBhqexHoodAADwGjNnuhwtXqzz5w2M\nYkl2eN1J0pUj386N3nPkXHCZKs07hpfLY4c/FAAAOdGePS5HiYmKiXHyvmLcxGIndud2LIho\n/VC5wrkLlQjr/94KSad/+7xKSIUuPZ8d9urQZyPaVQy5M3Len+n+HAAA4I0CAtxNAwONymFV\nVjrc+ufEkmp1Oh+5mpSrcCm/M3sn/6vpleI/bOnTd19C0b6v9K1bqejBP36eOGHG6Edrl9lz\n/Jny+czOCwAAMql2bS1d6nxUoIBCQ41NYz1WOrFb+Hifo/HJw776/Z/Th89fOhYZXuaLx5tv\nu5p/wd+7J781/Omez45898u9W78MSLky4rEos8MCAIDMe/ZZ5c7tfNSnTzrnebBWsfv3Lyfz\nlR3x70drSfIJCBk64wNJIfdObl0m7409BatEvFOx0Jlt75mWEgAAZFnZspo1y0m3a9NGb7xh\nRiCLsdKl2L1xifmK3XPjy8D8D0oqcFepW7ZVLpMnac9+Q5MBAIDs0qGD/vhDEydq3TpduqSK\nFfXYY3rkETkcZiezACsVuwb5A9bun5GkNr6SpNj9n0s6uXa9dP/N2xbtOh+Q714zAgIAgOxQ\noYLef9/sEJZkpUuxI3qE/nNqTuP+4zfu2PPbqm8eaz7GL1eBc7tffm3etht7Vn/89MQjF8u0\nGWZiTgAAkGk7d2roULVpo3btNGoUnzORNVY6sav/bnS76GoLJw++d/JgST7+wR9v27G2deUx\nXWvMv79ZnUohh/5Yu+q3AwF57545+SGzwwIAgAx7910NG6akpOtfLlqksWP1+ed69FFTY1mP\nlYqdb2DZqJ27pk38ZM2vmy76l3z0hdFdKxftueUntX9k2splO3+WpAoNuk2a+dm9+XhqBgAA\ni1i4UEOG3Lp45YoiIlS5Mm8kzhQrFTtJvoEln/7XyKdvWvHPV+3LH3e9e+DPvw+fL1S6UuVy\nBU0LBwAAsmDsWOfriYl67z3NmGFsGmuzWLFzpUi5SkXKmR0CAABkVnKyNmxwOV2/3sAodmCl\nhycAAIDdxMUpMdHl9PJlA6PYgU1O7G6Ij11XrlIXSceOHcvI/qSkpOjo6Li4ODd7Nm/eLCkh\nISFbEgIAgFS5cyskRCdPOp+W43pc5tit2KWkxB8/fjzj+1euXNmuXbuM7Jw9e3ajRo2yGAsA\nALjStasmTXI5QmbYrdgF5K27PjPX4xs3brxw4UL3J3aTJ09etWpV6dKlbzsdAAD4H5GRWrpU\n+/bdul6vnvr3NyOQhdmt2Dl889WrVy/j+319fdu2bet+T3R0tCQfH+5HBADAA4oW1bp1GjxY\n8+Zdf5VdUJCeflpvv63AQLPDWYx9il1ERERwlZfHv1rN7CAAACCTihfXf/+rCxe0c6f8/FS1\nqnLnNjuTJdnnFGrmzJnfLDtqdgoAAJBVBQqofn3dcw+tLsusdGK3b9YHM/ZccLPhYsysUaOu\n32AXGRlpSCgAAABvYaVidzBq4sio/7mz8iaxMTNGjrz+a4odAADe7tAhLVmiAwdUqJAeflh1\n65odyPKsVOwafrXu7X7dhk1dExRcc/TE1+7MkyZ8hw4dCt8dOXV0LbPiAQCAjEpJ0euva+xY\n3fya2NatNWOGChUyL5blWanY+QQUH/rZ6latxnbuOeK1QW+Nmz23b7MKN28IKlK/ffsWZsUD\nAAAZNXasRo++dXHJEnXpouXL5XCYkckOrPfwRLVOQ/+I+fXJGmf7twgLHzjhTGKy2YkAAEBm\nXL7spNVd8+OPWr7c2DS2Yr1iJymwcK0py/cueLf3z1NeCK0SPm/LabMTAQCADPvlF3cfAkux\nuw2WLHaSJJ+2L045sGX+/b4butUt9+SYr83OAwAAMubMmaxP4ZZ1i50kFazabsn2vR/0azhj\nRHezswAAgIwpVizrU7hlpYcnnHL4BQ+YsLRV2+mLd57LW7qK2XEAAEB66tdXoUI6d875NDzc\n2DS2Yvlid01osycGNTM7BAAAyIjAQI0dq2efdTLq2lUPPGB4IPuw9qVYAABgSb17a/Jk5c+f\nuuLrq969NW2aeZnswCYndgAAwGL69lWPHlqxQgcPKjhYDz2ksmXNzmR5FDsAAGCS/PnVsaPZ\nIWyFS7EAAAA2QbEDAACwCS7FAgAAo5w8qSlTtHKlLl1SqVLq1Ek9esiPNpJt+EsJAAAM8euv\nattWp05d/3LTJi1cqM8+05IlaR6PxW3gUiwAAPC8ixfVsWNqq7th7Vr1729GIHui2AEAAM/7\n73917Jjz0ezZOn7c2DS2RbEDAACet2mTy1FysrZuNTCKnVHsAACA51296m4aF2dUDpuj2AEA\nAM+7886sT5FhFDsAAOB5jzwif3/no5o1VbWqsWlsi2IHAAA87Px5HT+uXr2cjPLl09Sphgey\nLd5jBwAAPObsWQ0erK++UmKiJDkcypdPsbGS5O+vli31zjuqXNncjHZCsQMAAJ5x+bIaN9a2\nbakrKSmKjVWZMvrmG1Wtqty5zQtnT1yKBQAAnvHBB2la3Q2HDmnGDFqdJ1DsAACAZ3zzTVZG\nuA0UOwAA4BkHD7ocHTumhAQDo+QUFDsAAOAZefO6HAUGunz7CW4DxQ4AAHhGgwYuR/ffb2CO\nHIRiBwAAPGPIEOfHcg6HXn3V8DQ5AsUOAAB4Rs2amjVLefKkWQwI0JQpatLEpEw2x3vsAACA\nx3Ttqgce0LRp+v13JSWpRg1FROiOO8yOZVsUOwAA4EklSmjYMLND5BRcigUAALAJih0AAIBN\nUOwAAABsgnvsAACAB1y+rCNHlDu3Spc2O0oOwokdAADIVjEx6txZwcGqVEllyqhCBX38sVJS\nzI6VI3BiBwAAss9ff6lBA50+nbqyf7/69NHOnRo/3rxYOQUndgAAIPs8/3yaVnfDhAn6+WfD\n0+Q4FDsAAJBNTp7UihUup199ZWCUHIpiBwAAssn+/UpOdjndu9fAKDkUxQ4AAGSTwEB306Ag\no3LkXBQ7AACQTapUUb58Lqd16xoYJYei2AEAgGwSGKg+fZyPChRQr17GpsmJeN0JAAC4bTt2\n6M03tXSpYmMVEKD4+DTTAgU0b56KFTMpXA5CsQMAALdn2TK1a6e4uOtfXmt1/v6qWFEhIXrg\nAfXtq5IlTQyYc1DsAADAbbh0SU88kdrqbkhIUGKili2TH2XDONxjBwAAbkN0tI4fdz766y+t\nXWtsmpyOYgcAAG7Dzp3uprt2GZUDEsUOAADcFh+3XcLX16gckCh2AADgtlSv7m56991G5YBE\nsQMAALelZUuVL+98VLOm7rvP0DA5HsUOAADchqAgff21ChW6db1ECX31VToXapHd+MsNAABu\nz733autWPf+8KlZUoUK66y4NGaKtW1W5stnJchxeLQMAAG5bmTKaONHsEKDYAQCALNu/Xxs2\n6OpVhYXp3nu58Go6ih0AAMi8U6f03HP69lulpFxfqVRJU6eqQQNTY+V0NGsAAJBJV6+qeXPN\nn5/a6iT9+aeaN9fvv5sXCxQ7AACQWVOnassWJ+v//KOXXzY8DVJR7AAAQCYtWuRytGqVLl0y\nMArSoNgBAIBMOnbM5SgpSSdPGhgFaVDsAABAJv3v64gzPoUnUewAAEAmNW7sclSjBsXORBQ7\nAACQSc8/r2LFnKw7HHrzTcPTIBXFzkArVqhbN1WpoipV1K2bfvzR7EAAAGRJcLB++EEVK6ZZ\nzJ1bn3yitm1NygSJFxQbZ+hQvfNO6pe7d2vOHL38ssaONS8TAABZVb26duzQokX69VfFxaly\nZXXurJAQs2PldBQ7Q8ybl6bV3fDOO7r3XnXubHggAACy5OhRzZmj3bvl76969dS5szp1MjsT\nUnEp1hAffpiVEQAAXuXjjxUaqhde0Mcf68MPFRGhsDD9+qvZsZCKYmeIzZuzMgIAwHssWqS+\nfRUXl2bx8GGFh7t7rR2MRbEzREJCVkYAAHiPUaPSfDLsDefOafx4w9PAOYqdIcLCsjICAMBL\nXLyo3393OV292sAocIdiZ4iePV2OnnjCwBwAAGTJhQvOj+uuOX/ewChwh2JniP791aSJk/Wm\nTfX884anAQAgk4oWVUCAy2mpUgZGgTsUO0MEBCg6WqNHq0yZ6ytlymjMGC1ZIn9/U5MBAJAB\ngYFq0cLltF07A6PAHd5jZ5SAAA0fruHDdeaMJBUubHYgAAAyIDlZCxdq0SKdPSt/fyfP/NWq\npeeeMyMZnKDYGY5KBwCwithYdeiglSudT3181KWLJk1SYKCxseASxQ4AALjwzDPOW12FCnr3\nXd17L3fXeRvusQMAAM7s3au5c52P9u1Tnjy0Oi9EsQMAAM6sX+9u+ssvRuVAJlDsAACAM5cv\nZ30Kk1DsAACAM+XKuZuWL29QDGQGxQ4AADjz0EMKCXE+Cgzk3XXeyYpPxaacOnSpaJl8//9l\n8tbVS9Zs2nkpOfCOu+5p1eL+/L4OM9MBAGAPQUGaPFmPPKLk5FtHo0erdGkzMiEdFit2MT9M\nfmLg6ztS/nPmz6ckXTm5+vEW3aK2nLixIXeJ2uO+WvzcQyXMywgAgMUlJ2vZMq1dqwsX1Lu3\nfvxRf/99fVS2rN58kw8691pWKnanN79XJXxIvCNPs15lJKUkXexWq/Wio5erhz/5SJO6pfMn\nb9/4/YdTo/s3q1EoZv8jJfOYnRcAAAs6cECdO2vTptQVPz+9+KLatVNIiCpXloMrY97LSsXu\nw25j4h25P1u/76m6RSUdW/vMoqOXa7+8eNPY1td39B4wpNeksvcPGNwt6pGfIszMCgCAFV29\nqvBw7dqVZjExUePGqWJFPfSQSbGQUVZ6eGJSTGyhsPHXWp2kmNnbJE19vfnNe0Lq9X+vUvDp\n3982IR8AAFY3e/atre6GyEglJRmbBplmpWIX7OfjG3jjmQn5BPhIKht466FjhaJBSfHHDE0G\nAIA9uPpYWEknT2rHDgOjICusVOwGVy10dteQXy/EX/sy9MkHJb2x6eTNe1ISz43ZcjpX4TYm\n5AMAwOrOncv6FF7ASsXusVlj/BMPPVzl4Unf/HQhMblonUlDGhT/qEWbL1btu7bhn2MbX2hX\na13s1Ydef8XcqAAAWFIJt6+VcD+FF7BSsSsQ9szmuSMLnl3/fJeGhfMWrlzz/g2+Ja9e+O3p\nxqH5QspVuaN4/lL1xi890KD3Bwv6VjE7LAAAFtTG9SWvsDCFhRkYBVlhpWInqVLH1/cd2zbu\ntf73Vw45umvT6jW/X1u/dOrgsStBTR55bsaqPWs/GeTHg9gAAGRB27Zq3tzJuq+vxo83PA0y\nzUqvO7kmsNBdL7z54QtvSikJZ0+fvnwlwTcgKE/eQgXy+psdDQAAi3M49M03GjRI06alPgNb\nurQmTVLLlqYmQ4ZYr9ilcvgHFy0RbHYKAABs4sgRbd0qHx+NHq0339S6dbp4UaGhql9fAQFm\nh0OGWLnYZYekpKTo6Oi4uDg3e2JiYiQl/+8n5QEAYA+HDqlPHy1dqpQUSXI41L69Jk/maQnL\nsVuxi49dV65SF0nHjmXoVXYrV65s165dRnbu37//tpIBAOCdTp3Sgw/qwIHUlZQUffuttm/X\nxo0qWNC8ZMg0uxW7lJT448ePZ3x/48aNFy5c6P7EbvLkyatWrbrjjjtuOx0AAN5nzJg0re6G\nPXv0zjt66y3DAyHr7FbsAvLWXb9+fcb3+/r6tm3b1v2e6OhoST4+FnuCGACADJk/3+Xo228p\ndtZit2Ln8M1Xr149s1MAAGARKSk6csTl9NAhA6MgG9jnFCoiImLQW3+YnQIAAEtxOJQ3r8tp\n/vwGRkE2sE+xmzlz5jfLjpqdAgAAq3nwwayM4JWsdCl236wPZuy54GbDxZhZo0Zdv8EuMjLS\nkFAAAFjWqVNaskTFisnHR//7Vq+AAA0bZkYsZJ2Vit3BqIkjo/a52RAbM2PkyOu/ptgBAODO\nuHEaPlyu3guRL5+mTVPNmsZmwu2yUrFr+NW6t/t1GzZ1TVBwzdETX7szT5rwHTp0KHx35NTR\ntcyKBwCAZXz8sV56ycl6SIhatFCdOnrsMRUtangs3C4rFTufgOJDP1vdqtXYzj1HvDborXGz\n5/ZtVuHmDUFF6rdv38KseAAAWENCgl57zfno5El17qz27Y0NhGxjvYcnqnUa+kfMr0/WONu/\nRVj4wAlnEvmkLwAAMuP333X6tMvpsmUGRkE2s16xkxRYuNaU5XsXvNv75ykvhFYJn7fF9d+d\nAADgFm5aXbpTeDdLFjtJkk/bF6cc2DL/ft8N3eqWe3LM12bnAQDAIkJCsj6Fd7NusZOkglXb\nLdm+94N+DWeM6G52FgAALKJWLRUr5nLasqWBUZDNrPTwhFMOv+ABE5a2ajt98c5zeUtXMTsO\nAABe7MQJTZyoH390uaFpU4WHGxgI2czyxe6a0GZPDGpmdggAALzZxo1q1crlLXQOh7p21Sef\nyOEwNhayk02KHQAAcOeff9Spk/NWV6WKBg/WQw+pUiXDYyGbUewAAMgB5s/X4cPOR7t2qUkT\nhYYaGwgeYe2HJwAAQIb8/ru76ebNRuWAZ1HsAADIARIS3E3j443KAc+i2AEAkANUrOhuGhZm\nVA54FsUOAIAcoHFj5crlfHTXXapTx9g08BSKHQAA9pWUpPfeU/nyqlZNV6442ZA3r778klec\n2AZPxQIAYFPJyXrkEUVFOZ8GBallS/3736pc2dhY8CCKHQAANjV7tstW17u3Jk5UYKCxgeBx\nXIoFAMCmZsxwOVq4kFZnSxQ7AABs6u+/XY5OnFBsrIFRYBCKHQAAdrR/vxIT3W3w9zcqCoxD\nsQMAwF62blX9+qpQQYcOudxTpYrLt5/Aynh4AgAAG9m2TQ8+qIsX09k2cKAhaWA0TuwAALCR\nF19Mv9U9+6yee86QNDAaJ3YAANjF2bNaudLlNH9+NW+up59WeLiBmWAoih0AAHZx5IiSk11O\nq1XT3LkGpoEJuBQLAIBd5MuX9SlsgWIHAIBdlCun0qVdThs0MDAKzEGxAwDALhwODR/ufFSk\niPr0MTYNTMA9dgAAWN+FC5o8Wd99pyNHVLasDh1SSkrqtGRJRUWpSBHz8sEgFDsAACxuzx41\nbaoDB9IsFiigBg1UpIjuv189eihvXpPCwVAUOwAArCw5WY88cmurk3Thgo4e1cKF8vU1IxbM\nwT12AABY2dq12rzZ+WjLFv30k7FpYDKKHQAAVrZpk7upq84Hm6LYAQBgZYmJ7qbx8UblgFfg\nHjsAAKzp6lVFRWnVKnd7wsIMCgPvQLEDAMCCtm1Tx47at8/dnmLF1Ly5UYHgFSh2AABYzfnz\natlSx4652+Pvr6lTlSePUZngFbjHDgAAq/nkE3etzs9PzZtr3Tq1bm1gJngFTuwAALCa1avd\nTXfs4Na6HIsTOwAArObCBXfTuDijcsDrUOwAALCU5GQFB7ucOhwqWdLANPAuFDsAACzi4kW9\n+KKKFtWiRS73XPt8WORU3GMHAIAVxMaqYUNt3epuT65cev99owLBG3FiBwCAFbz5Zjqt7u67\ntXy56tY1KhC8ESd2AAB4vfh4TZ/uclq9umbMULVqcjgMzARvxIkdAABe7K+/1LWrChbUyZMu\n91y4oOrVaXUQJ3YAAHivTZv08MOKjU1nW2CgIWlgAZzYAQDglVJS9OST6bc6SXXqeD4NrIFi\nBwCAV9q8Wdu3p7/N4dCAAZ5PA2ug2AEA4JX++iv9Pb6+Gj9e9et7Pg2sgXvsAADwSv7+7qZF\ni6p9e/Xrp1q1jAoEC6DYAQDgldw3tvfeU0SEUVFgGVyKBQDAK1WooNatnePmAHIAACAASURB\nVI9KlVKnTsamgTVwYgcAgJdJTNTChVq9WvnyKSTk1jfYBQdr3jzlyWNSOHg1ih0AAN4kJkbt\n22vbttQVh0MlSyowUMHBatpUAweqRAnz8sGrUewAADDPhQs6cED58ql8eTkcio9X69bauTPN\nnpQUHTmikSMVGWlSSlgGxQ4AAAMdPaqVK3XqlCQtWaKVK5WUJEmlS2vYMBUseGuru+E//9GQ\nIcqd27iosCCKHQAAhkhI0L/+pcmTlZjoZHr4sJ5/XoUKufz2y5f1++964AHPBYQNUOwAADBE\nv3767LN09pw752564UI2xoEtUewAAPCkvXv10UdatUq//Xa7P6p06ewIBDuj2AEA4DFffaWn\nn1ZcXDb8qAoVVL16Nvwc2BrFDgAAz9i5Uz17KiEhG36Ur68mTZLDkQ0/CrbGJ08AAJDdrl7V\nkiXq3Tt7Wl1oqBYtUsuW2fCjYHec2AEAkK2WLlWvXjp2LBt+VOHC+uEH1aghX99s+GnIASh2\nAABkn3Xr1L599hzUSereXbVrZ8+PQs5AsQMAIPsMG5aJVufjo0qVlCePdu7UP//cOi1bViNG\nZG862B732AEAkE1iY/XzzxnaWb26Jk/W3r3auVMbN2rPHrVvn+bZiJYttWaNQkI8lBR2xYkd\nAADZ5PRpJSenv+2OO/TDDypWLHWlRAl9+62OHtXmzUpJUfXqKlvWczFhY5zYAQCQJT/9pLZt\nFRysgABVqaLISAUFpfNGkly59OSTWr8+Tau7oWRJtW6tNm1odcgyih0AAJk3ebIaNdLixTp3\nTgkJ2r1bb7yh0FD5ub4U9uKLOndOX3zBBVZ4DpdiAQDIpN27NXiwk6uubj5honx5RUYqMNCj\nuQBO7AAAyKQvv8zcC03q1NGyZcqf32OBgOvcFbutW7fu+PNCuj9i+7sjhwwZkn2RAADwbjt2\nZHTnE09o1Spt3Kg77/RkIOA6d8WuZs2aD3VYevPKD81r33HHHbds2/PFpHfffTf7owEA4J2S\nkjK6MzRUDz3EZ7zCMJm7FPvPkUMxMTGeSQIAgHe7elVvvqly5bR0afqbr0lM9GQg4FY8PAEA\nQAbExalFC61Zk7nvqlzZM2kA53h4AgCADBg3LtOtrkgRtWnjmTSAcxQ7AAAyYPp0lyMfH/n8\nz39PAwL0xRc8CQuDUewAAHDr55/10kv66y+XG4KDtWuXunVT3rySlCuX2rbVL79wXAfjcY8d\nAAAuJCSoVy/NmJHONn9/hYXpv/+VpHPnVKCAkwM8wBAUOwAAXHj11fRbnaSaNVN/XaiQ5+IA\n6Uqn2MUefLNx449vfHn6wAVJjRs3vnnPtUUAAGwlNlYTJ2ZoZ//+Ho4CZFQ6xS7hn52rVu28\nZXHVqlWeinMbIiIigqu8PP7VamYHAQDYwm+/6erVdPY4HBo+XK1bGxIISJ+7Yrd7927Dcty+\nmTNnlmr0OMUOAJANDh3S4sXuNuTLp/Bw9e2rRo0MigRkgLtiV6lSJcNyZMS+WR/M2OPusu/F\nmFmjRq2/9uvIyEhDQgEA7OXKFQ0erKlT0/ncsIEDNXq0UZmAjLLSwxMHoyaOjNrnZkNszIyR\nI6//mmIHAMiKnj01d246exwOdehgSBogczJU7M7F/HkyV9lKxXJd+zLxn5gp/574845DZWrd\n36xtj2Y1i3oyYaqGX617u1+3YVPXBAXXHD3xtTvzpAnfoUOHwndHTh1dy5gwAAAbWrcu/VYn\nqW9f1a3r+TRApqVT7OJObRzU/YlPVuyu+/bWjUOrS0q8srtp+dqrT12RpPlz3x05LOL9FdMG\nNjAgq09A8aGfrW7VamznniNeG/TWuNlz+zarcPOGoCL127dvYUASAIA9LV2azoYCBfTyyxo6\n1JA0QKa5e4NicvyRDnc3+mTF7vI1H2xe7fqLeVb0arv61JWSjfotWfXznM/erVfYZ8bgRp8e\nuGhIWkmq1mnoHzG/PlnjbP8WYeEDJ5xJTDbstwYA2NyJE+6mb7yh48f16qvy9TUqEJA57ord\njvGdvj/5T7v3V+/fvGZMqzKSUpIvPzs/xi/XnauXjm/1UP2uvV5avnmaj5LGPL/aqMCSFFi4\n1pTlexe82/vnKS+EVgmft+W0kb87AMC2goPdTevXV1CQUVGArHBX7D75YGdggYZRgxveWLl0\nZMLBuMTSTcffGXT9Gm6eUl0fC8l98pdPPRvTCZ+2L045sGX+/b4butUt9+SYrw0PAACwnaZN\nXY7y5NF99xkYBcgKd8Vu2fmr+cs/f/Nxc8x/50tqMCLNHaP18wXEx/7ikXTpKVi13ZLtez/o\n13DGiO6mBAAA2ErTpmrSxPnotdeUN6+xaYBMc/fwxOGrSQUL5b955YdP9zgcvsOqpjmpDvJx\npKQkeiRdBjj8ggdMWNqq7fTFO8/lLV3FrBgAAGvbuVOffqrfflN8vMqW1cGDqSN/fw0dygMT\nsAR3xa5aHv9dMRul68+ZJiecGhsTm6tot7tzp/mu5efjAvLW82DGDAht9sSgZuZGAABY1qef\nqn9/JSSkrjgceugh1aun8uXVurXKlDEvHJAJ7i7F9rs7OPbAqDmHLl378uCi/qcSkko1e+7m\nPZeOzPz61JXCNfj8YwCANf36q/r0SdPqJKWkaNUqVa+uPn1odbAQdyd2bT4d5Lj7lSeqP7T7\n9b6l/Q6NGTpfUu/RNW9sOLs9+vGWfZNSUgZ82NjjSTMmPnZduUpdJB07diwj+5OSkqKjo+Pi\n4tzsiYmJkZSczHtVAMCO3n9frv4NP26cHnvM2DTAbXFX7ArdNfS7N39rPeKbyBd7X1up2uOz\nIeXzS0pJulSjyl1/7j0cn5zS8IU5Q+92+3y4gVJS4o8fP57x/StXrmzXrl1Gdu7fvz+roQAA\nXikuTitXavlylxs2b1Ziovys9PGbyOHS+Zu12fC5h1svn7Zg5fF//CrfE/5MlxtPeift2Hey\nfLWH+w6L/NejD3o6ZcYF5K27fv36jO9v3LjxwoUL3Z/YTZ48edWqVXfcccdtpwMAeI1vv1Xf\nvnJ/FpCcrPh4ih0sJP2/WUNqNh1S89b3+jh8CyQkxrm7Qc8kDt989epl4kkOX1/ftm3but8T\nHR0tycfHC/+4AIAs+eEHdemipKR0thUvrty5DQkEZI+slxVvqzkRERGD3vrD7BQAACsYMiT9\nViepOy9JhcW4O7Hr27dvxn/QlClTbjvMbZk5c2apRo+Pf7WauTEAAN7o4kXFxSl/fkVFaf58\nbduW/rfcdZdef93zyYDs5K7YffTRRxn/QQYUu32zPpix54KbDRdjZo0adf0Gu8jISE/nAQBY\nwJdf6r33tH27JPn5KTEDb9TPk0cREXrrLRUs6Ol0QPZK/x47v9wlmnfq0rVLxyrFTb7P4GDU\nxJFR+9xsiI2ZMXLk9V9T7AAAGjhQEyemfpmRVtesmRYvVkCA50IBnuOu2O1at3ju3Llz50VF\nz5y4dNZH1Rq26fpI165dOlQKyWVYvps1/Grd2/26DZu6Jii45uiJr92ZJ034Dh06FL47curo\nWqZkAwB4nR9/TNPqMqhjR1odrMtdsat8f+sR97ce8f7nf/7y3dy5c+fO+2ZE//mvD/Cv1rDN\nI4880rVLh7CiQYYFleQTUHzoZ6tbtRrbueeI1wa9NW723L7NKty8IahI/fbtWxgZCQDgvaZP\n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\n3ORjRmaf7NrcT5aRMLz9HOXz5xFRsaPjt3CJiPLnwujqmZ9avnsiPmyf19QBgEvT7lOn/Thu\nmF+9cpYODXpVNDM2saox97dVwkfTnbw4P1kikUiNbboNHTft29Ht65eTSIw8S5hmT3eSkRL5\nZRVbAGUqe/YYNKJfj/a2xlKpkfWck88zB8xt5QjAyqnOl30Gjxo2sJVHOQDlGk9MyzWDSo7U\nhOvNy1kCqFS/5YDhwzq29DSSSIzNK216FJs5QKPpTrL9UK8MgAG7IxRsQUTFEYMdERmG+Mhl\nALKnr8uWnvxkzvAuLmVtTC1K1fLyHrdwZ4pMOPFDN1sLkxIO9YSPgp0gCBfXz2xWu0opS2MA\nUmPbUUvO7alu/2FsSk/5b+nUQXVdy1uYmJT9pHKrLkN3XX2V3ZuR+nrZ90PqVq5gaWpkbG7l\nWrPR2DlroxXFOkEQBCE17s7Po3tWr1jG3NjEtoxz+97jT4XHZ/fmL9i9f7m3hJHU1LpOeFK6\noq2IqLiRCAIv5BNR8SR7/V+EUZlKduZG+q6EiEg7GOyIiIiIRIIvTxARERGJBIMdERERkUgw\n2BERERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMd\nERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BER\nERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMdERERkUgw2BERERGJBIMdERER\nkUgw2BERERGJBIMdERERkUgw2BERERGJxP8B35tbfZfugzEAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# computing validation (testing) RMSE for k between 1 and L \n",
    "L <- 150\n",
    "rmse <- rep(5,L)\n",
    "for (i in 1:L) {\n",
    "  knn_model <- knn.reg(train = X_train, test = X_test, y= y_train, k=i)\n",
    "  rmse[i] <- sqrt(mean((knn_model$pred - y_test)^2))\n",
    "}\n",
    "# plot\n",
    "plot(rmse, pch = 16, col = 'red', xlab = 'values of k', ylab= 'RMSE')\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "ca4a7c8d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-07-20T02:05:37.988359Z",
     "iopub.status.busy": "2022-07-20T02:05:37.986397Z",
     "iopub.status.idle": "2022-07-20T02:05:38.021367Z",
     "shell.execute_reply": "2022-07-20T02:05:38.019200Z"
    },
    "papermill": {
     "duration": 0.045524,
     "end_time": "2022-07-20T02:05:38.024440",
     "exception": false,
     "start_time": "2022-07-20T02:05:37.978916",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "optimal choice of k:  7 \n",
      "validation RMSE for optimal choice of k:  3.836681"
     ]
    }
   ],
   "source": [
    "min_k <- which.min(rmse)\n",
    "cat('optimal choice of k: ', min_k  ,'\\n')\n",
    "cat('validation RMSE for optimal choice of k: ', rmse[min_k])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "b8ab6c0b",
   "metadata": {
    "papermill": {
     "duration": 0.00597,
     "end_time": "2022-07-20T02:05:38.036056",
     "exception": false,
     "start_time": "2022-07-20T02:05:38.030086",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 5.415401,
   "end_time": "2022-07-20T02:05:38.165047",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-07-20T02:05:32.749646",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
