function USRFC_SSM_InitTcpConnEnv(source, event, arguments)

    global SSM_TcpClient;

    % load test image
    %t = Tiff('test_00001.tif','r');

    setup the tcp client
    SSM_TcpClient = struct;
    SSM_TcpClient.test_tiff_image= read(t);
    SSM_TcpClient.connection_status = false;
    SSM_TcpClient.tcp_connection = [];
    SSM_TcpClient.toolbox_ui = SSM_UI();

    disp('TCP Environment set up.');

end