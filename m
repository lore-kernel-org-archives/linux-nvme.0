From: parav@mellanox.com (Parav Pandit)
Date: Wed, 8 Feb 2017 15:42:47 +0000
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write	commands.
In-Reply-To: <030701d28221$c115d1d0$43417570$@opengridcomputing.com>
References: <1486507170-23285-1-git-send-email-parav@mellanox.com>
 <20170208082743.GB7629@lst.de>
 <VI1PR0502MB30080615048602665537DBB9D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <030701d28221$c115d1d0$43417570$@opengridcomputing.com>
Message-ID: <VI1PR0502MB300844453C85D8C1251F2D5DD1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Steve,

> -----Original Message-----
> From: Steve Wise [mailto:swise at opengridcomputing.com]
> Sent: Wednesday, February 8, 2017 9:41 AM
> To: Parav Pandit <parav at mellanox.com>; 'Christoph Hellwig' <hch at lst.de>
> Cc: axboe at fb.com; keith.busch at intel.com; sagi at grimberg.me; linux-
> nvme at lists.infradead.org
> Subject: RE: [PATCH] nvme-rdma: Support 2 inline data SGEs for write
> commands.
> 
> > >
> > > This looks fine to me in general, but I'm a little curious how your
> > > arrived
> at
> > > that 2 number.  Why not 4 or 8?
> >
> > Some adapters doesn't support more than 5 sges. So increasing it to 4
> > or 8
> would
> > fail them.
> > Chuck reported 1 out of 3 adapters only support 3. Its likely due to
> min(send_sge,
> > recv_sge).
> > With total of 3 SGEs (64B cmd sge + data sges), WQE fits in 64 bytes
> > size at
> the
> > provider driver level. So to strike balance between cache line usage
> > and performance, and to be nice to those adapters which has low SGE
> > (either due to min(send_sge, recv) or other otherwise, I picked 2 data sges.
> >
> > Side  note: I have split out send and recv sge in other unrelated
> > patch which
> is in
> > review internally from linux-rdma tree.
> 
> I'm looking forward to this patch since cxgb4 has max_recv_sge of 4 and
> max_send_sge of 17!
> 
Sure. I will send out shortly once done with review and testing with nvme target.

> Steve.
