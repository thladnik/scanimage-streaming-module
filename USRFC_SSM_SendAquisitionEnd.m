function USRFC_SSM_SendAquisitionEnd(source,event,arguments)
    global SSM_TcpClient;

    if ~SSM_TcpClient.connection_status
        return
    end

    % communication code for acquisition end
    com_code_aqu_end = int64([40, 0]);
    com_code_aqu_end_bytes = typecast(com_code_aqu_end, 'uint8');
    %disp('acquisition end');

    % send code
    SSM_TcpClient.tcp_connection.write(com_code_aqu_end_bytes);

end