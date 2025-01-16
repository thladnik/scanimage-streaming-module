function output = SSM_CloseTcpClient()

    global SSM_TcpClient;

    if SSM_TcpClient.connection_status
        
        % communication code for closing the tcp connection
        com_code_disconnected = int64([-1, 0]);
        com_code_disconnected_bytes = typecast(com_code_disconnected, 'uint8');

        % send code
        SSM_TcpClient.tcp_connection.write(com_code_disconnected_bytes);

        % delete tcp client object
        SSM_TcpClient = rmfield(SSM_TcpClient, 'tcp_connection');
        SSM_TcpClient.tcp_connection = [];
        SSM_TcpClient.connection_status = false;
    
        disp('TCP connection successfully closed.');
        output = true;
    else
        disp('Warning: Cannot close non-existent connection.');
        output = false;
    end

end