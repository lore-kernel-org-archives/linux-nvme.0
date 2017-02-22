From: parav@mellanox.com (Parav Pandit)
Date: Wed, 22 Feb 2017 20:02:12 +0000
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <1b133bcf-9b4e-9817-dbff-9b69dbcb01dc@grimberg.me>
References: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <b91079ca-0d63-8dae-6a3f-281fc0deb636@grimberg.me>
 <VI1PR0502MB3008D4BD11A7F360840347A4D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1b133bcf-9b4e-9817-dbff-9b69dbcb01dc@grimberg.me>
Message-ID: <VI1PR0502MB3008674F9EA0F9D891CE06F2D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>

> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Wednesday, February 22, 2017 1:56 PM
> To: Parav Pandit <parav at mellanox.com>; Christoph Hellwig <hch at lst.de>
> Cc: linux-nvme at lists.infradead.org; axboe at fb.com; keith.busch at intel.com
> Subject: Re: [PATCH] nvme-rdma: Support 2 inline data SGEs for write
> commands.
> 
> 
> >>> Hi Christoph, Sagi,
> >>
> >>> Does this host side patch look fine? Its unrelated to target side
> >> implementation.
> >>
> >> I'm still wandering if we want it dynamic according to the target
> >> ioccsz (say 1 per PAGE_SIZE?)
> >
> > I don't think we are consuming any more resources by increasing to 2SGEs
> because it's still aligns to hardware's minimum WQE size of 64B or 128B size.
> > Can we add that additional complexity in incremental manner unless 2 SGEs
> are less optimal compared to 1?
> 
> I'm referring to struct nvme_rdma_request
Yes, I got that now.
That needs to have dynamic allocation for sge array if we want to do based on ioccsz.
Unless we do 4 or 8 or larger SGEs, extra 8 byte pointer to store link to more than one SGE might not be worth enough just for writes.
