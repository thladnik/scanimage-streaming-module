function USRFC_SSM_SendTcpFrame(source,event,arguments)
    global SSM_TcpClient;

    if ~SSM_TcpClient.connection_status
        return
    end

    % grab image
    imageXY = source.hSI.hDisplay.lastFrame{1,1};
    %imageXY = source.hSI.hDisplay.lastAveragedFrame{1,1};
    image_number = source.hSI.hDisplay.lastFrameNumber;
    last_frame_timestamp = source.hSI.hDisplay.lastFrameTimestamp * 1000; % in ms

    % test frame
    %imageXY = ArrenbergTcpClient.test_tiff_image;

    % get frame width and height
    s = size(imageXY);
    width = s(2);
    height = s(1);

    %convert to 16bit
    img_SendData = int16(imageXY);
    imgSendData = reshape(img_SendData(:), 1, width*height);
    imgSendData_bytes = typecast(imgSendData, 'uint8');

    % frame header
    frame_header = struct();
    if (~isempty(image_number)); frame_header.frame_number = image_number; end
    if (~isempty(last_frame_timestamp)); frame_header.last_frame_time_stamp = last_frame_timestamp; end
    if (~isempty(width)); frame_header.frame_width = width; end
    if(~isempty(height)); frame_header.frame_height = height; end

    % decode frame header to json
    frame_header = jsonencode(frame_header);
    frame_header_bytes = uint8(frame_header);

    % create communication codes
    com_code_frame_header = int64([20, length(frame_header_bytes)]);
    com_code_frame_header_bytes = typecast(com_code_frame_header, 'uint8');
    com_code_frame = int64([30, length(imgSendData_bytes)]);
    com_code_frame_bytes = typecast(com_code_frame, 'uint8');

    % create message
    msg = [com_code_frame_header_bytes, frame_header_bytes, com_code_frame_bytes, imgSendData_bytes];

    % send message
    SSM_TcpClient.tcp_connection.write(msg);

end