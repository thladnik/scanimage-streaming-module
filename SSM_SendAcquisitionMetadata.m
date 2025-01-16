function SSM_SendAcquisitionMetadata(acqu_mode, source,event)
    global SSM_TcpClient;

    if ~SSM_TcpClient.connection_status
        return
    end
    
    % create meta data as struct
    meta_data = struct();

    % add acquisition mode
    meta_data.acquisition_mode = acqu_mode;
    
    % add rolling average factor
    if (~isempty(source.hSI.hDisplay.displayRollingAverageFactor)); meta_data.rolling_avg_factor = source.hSI.hDisplay.displayRollingAverageFactor; end

    % add number of slices in stack
    if (~isempty(source.hSI.hStackManager.numSlices)); meta_data.stack_num_slices = source.hSI.hStackManager.numSlices; end

    % add start position of stack
    if (~isempty(source.hSI.hStackManager.stackZStartPos)); meta_data.stack_z_start_pos = source.hSI.hStackManager.stackZStartPos; end

    % add end position of stack
    if (~isempty(source.hSI.hStackManager.stackZEndPos)); meta_data.stack_z_stop_pos = source.hSI.hStackManager.stackZEndPos; end

    % add number of frames per volume
    if (~isempty(source.hSI.hStackManager.numFramesPerVolume)); meta_data.stack_num_frames_per_volume = source.hSI.hStackManager.numFramesPerVolume; end

    %add number of frames per volume with flyback
    if (~isempty(source.hSI.hStackManager.numFramesPerVolumeWithFlyback)); meta_data.stack_num_frames_per_volume_with_flyback = source.hSI.hStackManager.numFramesPerVolumeWithFlyback; end

    % add number of frames per slice
    if (~isempty(source.hSI.hStackManager.framesPerSlice)); meta_data.stack_num_frames_per_slice = source.hSI.hStackManager.framesPerSlice; end

    % add data type of frames
    if (~isempty(source.hSI.hScan_ImagingScanner.channelsDataType)); meta_data.channels_data_type = source.hSI.hScan_ImagingScanner.channelsDataType; end

    % add mean pixel dwell time
    if (~isempty(source.hSI.hScan_ImagingScanner.scanPixelTimeMean)); meta_data.scan_pixel_time_mean = source.hSI.hScan_ImagingScanner.scanPixelTimeMean; end
    
    % decode meta data to json and to bytes
    meta_data = jsonencode(meta_data);
    meta_data_bytes = uint8(meta_data);

    % create communication code
    com_code_meta_data = int64([10, length(meta_data)]);
    com_code_meta_data_bytes = typecast(com_code_meta_data, 'uint8');

    % create final message
    msg = [com_code_meta_data_bytes, meta_data_bytes];

    % send message
    SSM_TcpClient.tcp_connection.write(msg);

end