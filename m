From: parav@mellanox.com (Parav Pandit)
Date: Wed, 22 Feb 2017 20:46:04 +0000
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <c9679af1-cece-07d0-1ba9-af475a4f1070@grimberg.me>
References: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <b91079ca-0d63-8dae-6a3f-281fc0deb636@grimberg.me>
 <VI1PR0502MB3008D4BD11A7F360840347A4D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1b133bcf-9b4e-9817-dbff-9b69dbcb01dc@grimberg.me>
 <VI1PR0502MB3008674F9EA0F9D891CE06F2D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <c9679af1-cece-07d0-1ba9-af475a4f1070@grimberg.me>
Message-ID: <VI1PR0502MB30080758C49E4177429914BCD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Sagi,

> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Wednesday, February 22, 2017 2:07 PM
> To: Parav Pandit <parav at mellanox.com>; Christoph Hellwig <hch at lst.de>
> Cc: linux-nvme at lists.infradead.org; axboe at fb.com; keith.busch at intel.com
> Subject: Re: [PATCH] nvme-rdma: Support 2 inline data SGEs for write
> commands.
> 
> 
> >> I'm referring to struct nvme_rdma_request
> > Yes, I got that now.
> > That needs to have dynamic allocation for sge array if we want to do based
> on ioccsz.
> > Unless we do 4 or 8 or larger SGEs, extra 8 byte pointer to store link to
> more than one SGE might not be worth enough just for writes.
> 
> Which is what Christoph asked, why not 4 or 8?
Which I explained in to his reply as below previously.

Snippet:
--------------
Some adapters doesn't support more than 5 sges. So increasing it to 4 
or 8 would fail them.
Chuck reported 1 out of 3 adapters only support 3. Its likely due to 
min(send_sge, recv_sge).
With total of 3 SGEs (64B cmd sge + data sges), WQE fits in 64 bytes 
size at the provider driver level. So to strike balance between cache 
line usage and performance, and to be nice to those adapters which has 
low SGE (either due to min(send_sge, recv) or other otherwise, I picked 2 data sges.
--------------
I have this patch ready that splits send and receive sges for a while now,
but it's been tested in very limited environment and requires some more testing that Steve already offered.
I plan to finish these patches first before I push this additional enhancement.
