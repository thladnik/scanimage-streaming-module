function USRFC_SSM_DisposeTcpConnEnv(source,event,arguments)
    global SSM_TcpClient;

    % dispose TCP environment
    SSM_CloseTcpClient();
    SSM_TcpClient.toolbox_ui.delete;

    disp('SSM UI disposed.');
end