From: muthucrazy90@gmail.com (muthu crazy)
Date: Mon, 19 Jun 2017 23:28:17 +0530
Subject: RDMA_Connect issue on Windows
Message-ID: <CADLzrv_yFWA2nvt=_SbEUVTuE_MScRrwj-yaFKorvPZ_6pw9bA@mail.gmail.com>

Dear All,

I am trying to make a fabrics setup using Chelsio RNIC where Windows
is the Client PC, and Linux is the target PC. From Windows Client
driver, I am invoking NDKConnect API(It will internally call
RMDA_Connect) and passing below structures as a parameter to it.

struct RDMA_CONN_PARAM
{
RDMA_CM_REQUEST private_data;
private_data_len = sizeof(RDMA_CM_REQUEST)
responder_resources = 0x20
initiator_depth = 0
flow_control=1
retry_count=7
RNR_Retry_count = 7
SRQ = 0
QP_num = 0x400
}

struct RDMA_CM_REQUEST
{
Recfmt = 0
Qid = 0
Hrqsize = 0x20
Hsqsize = 0x20
Reserved[8:31] = 0;
}

but on target side, I could see some junk value along with my actual
data received.(Linux Kernel:4.9.8)

like below:

0xFFFFFFE0, 0xFFFFFFB0, 0x23, 0x6, 0x0, 0xFFFFFFE0, 0xFFFFFFFF
0x20,0x20,0x0,0x1,0x7,0x7,0x0,0x0,0x0,0x4

Has anybody observed this before? Please help me out.


Thanks,
--Muthu
