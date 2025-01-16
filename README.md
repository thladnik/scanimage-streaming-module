# ScanImage Streaming Module
ScanImage addons of the Arrenberg Lab

# TCP Communication Protocol Layout

| byte 0-7 | byte  8-15 | byte 16-X |
|----------|------------|-----------|
| *com code* |*com code*|   *data*  |
| signal code |  data length  |   data    |



### signal code:
The signal code specifies what kind of data is send. The signal code can contain the following numbers
- 10: data contains acquisition meta data (data format: json)
- 20: data contains frame header (data format: json)
- 30: data contains frame (data format: int64)
- 40: data contains acquisition end (data format: int64)

### data length: 
data length specifies the length of the data send in bytes

### data:
data contains the data send in bytes
