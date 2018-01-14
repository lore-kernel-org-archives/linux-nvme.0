From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 12:50:34 +0200
Subject: Fabric Connect Fails with Chelsio from Windows Host
In-Reply-To: <CADNRq_+3uBmOYTJ+R6RaiU5HUa81vrBMQ2Ug39qqvA1Eng+MKg@mail.gmail.com>
References: <CADNRq_+3uBmOYTJ+R6RaiU5HUa81vrBMQ2Ug39qqvA1Eng+MKg@mail.gmail.com>
Message-ID: <c3a14be0-2cca-842e-7b04-1560bb8af605@grimberg.me>

> Hi all,
> 
> I have written a Windows application to test NVMe over RDMA with
> Chelsio RNICs in host and target.
> When I issue the fabric connect command from host, target fails in
> nvmet_rdma_map_sgl_keyed( ) with Status code 0x6 (Internal error). And
> RDMA connect command working fine.
> 
> I have tried the same application with Mellanox RNICs, and connect is
> working fine. Also I have tired with the linux host and linux target,
> fabric connect command working fine.
> 
> Has anybody tested the linux NVMe over RDMA stack with Chelsio RNIC?

I think Steve Wise have.

As I see it, this probably related to the rdma_rw_ctx that involves MRs.
Are you able to add some logging prints to your system?
