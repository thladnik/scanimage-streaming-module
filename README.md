# ScanImage Streaming Module (SSM)
ScanImage Streaming Module is a addon written for streaming calcium imaging frames and meta data from ScanImage to a remote server via TCP/IP. It can be integrated into ScanImage by setting the following user functions:

|#|Event Name|User Function|Arguments|
|------|------|------|------|
|1|applicationOpen|USRFC_SSM_InitTcpConnEnv|{}|
|2|applicationWillClose|USRFC_SSM_DisposeTcpConnEnv|{}|
|3|acqModeStart|USRFC_SSM_StartAcquisitionGRAB|{}|
|4|focusStart|USRFC_SSM_StartAcquisitionFOCUS|{}|
|5|frameAcquired|USRFC_SSM_SendTcpFrame|{}|
|6|acqAbort|USRFC_SSM_SendAcquisitionEnd|{}|
|7|focusDone|USRFC_SSM_SendAcquisitionEnd|{}|

---
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
