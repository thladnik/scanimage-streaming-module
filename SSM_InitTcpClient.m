function output = SSM_InitTcpClient(ip_adress, port)
    global SSM_TcpClient;
    
    % init tcp client
    if ~SSM_TcpClient.connection_status
        SSM_TcpClient.tcp_connection = tcpclient(ip_adress, port);
        SSM_TcpClient.connection_status = true;
        disp('Client connected')
        fprintf('Client successfully connected to IP adress %s on port %s.\n', ip_adress, int2str(port));
        output = true;
    else
        disp('ERROR: Client already connected.');
        output = false;
    end
end