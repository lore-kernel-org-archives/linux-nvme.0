From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 8 Feb 2017 09:49:03 -0600
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write	commands.
In-Reply-To: <VI1PR0502MB300844453C85D8C1251F2D5DD1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1486507170-23285-1-git-send-email-parav@mellanox.com>
 <20170208082743.GB7629@lst.de>
 <VI1PR0502MB30080615048602665537DBB9D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <030701d28221$c115d1d0$43417570$@opengridcomputing.com>
 <VI1PR0502MB300844453C85D8C1251F2D5DD1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <034801d28222$df51e1b0$9df5a510$@opengridcomputing.com>

> >
> > I'm looking forward to this patch since cxgb4 has max_recv_sge of 4 and
> > max_send_sge of 17!
> >
> Sure. I will send out shortly once done with review and testing with nvme
target.
> 

If you can send this and your 3 or 4 nvme/rdma patches as a series, I'll test
them on cxgb4.

Steve.
