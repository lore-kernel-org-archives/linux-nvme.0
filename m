From: vickey.nitt@gmail.com (VIKASH KUMAR)
Date: Thu, 11 Jan 2018 14:37:06 +0530
Subject: Fabric Connect Fails with Chelsio from Windows Host
Message-ID: <CADNRq_+3uBmOYTJ+R6RaiU5HUa81vrBMQ2Ug39qqvA1Eng+MKg@mail.gmail.com>

Hi all,

I have written a Windows application to test NVMe over RDMA with
Chelsio RNICs in host and target.
When I issue the fabric connect command from host, target fails in
nvmet_rdma_map_sgl_keyed( ) with Status code 0x6 (Internal error). And
RDMA connect command working fine.

I have tried the same application with Mellanox RNICs, and connect is
working fine. Also I have tired with the linux host and linux target,
fabric connect command working fine.

Has anybody tested the linux NVMe over RDMA stack with Chelsio RNIC?

Thanks,
Vikash Kumar
