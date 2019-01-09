From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 9 Jan 2019 13:51:04 +0300
Subject: [bug report] nvmet-tcp: add NVMe over TCP target driver
Message-ID: <20190109105103.GB14983@kadam>

Hello Sagi Grimberg,

The patch 872d26a391da: "nvmet-tcp: add NVMe over TCP target driver"
from Dec 3, 2018, leads to the following static checker warning:

	drivers/nvme/target/tcp.c:1116 nvmet_tcp_try_recv_one()
	error: uninitialized symbol 'result'.

drivers/nvme/target/tcp.c
    1090 static int nvmet_tcp_try_recv_one(struct nvmet_tcp_queue *queue)
    1091 {
    1092 	int result;
    1093 
    1094 	if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
    1095 		return 0;
    1096 
    1097 	if (queue->rcv_state == NVMET_TCP_RECV_PDU) {
    1098 		result = nvmet_tcp_try_recv_pdu(queue);
    1099 		if (result != 0)
    1100 			goto done_recv;
    1101 	}
    1102 
    1103 	if (queue->rcv_state == NVMET_TCP_RECV_DATA) {
    1104 		result = nvmet_tcp_try_recv_data(queue);
    1105 		if (result != 0)
    1106 			goto done_recv;
    1107 	}
    1108 
    1109 	if (queue->rcv_state == NVMET_TCP_RECV_DDGST) {
    1110 		result = nvmet_tcp_try_recv_ddgst(queue);
    1111 		if (result != 0)
    1112 			goto done_recv;
    1113 	}
    1114 <<---- result is uninitialized on this 1114 line.
    1115 done_recv:
--> 1116 	if (result < 0) {
    1117 		if (result == -EAGAIN)
    1118 			return 0;
    1119 		return result;
    1120 	}
    1121 	return 1;
    1122 }

regards,
dan carpenter
