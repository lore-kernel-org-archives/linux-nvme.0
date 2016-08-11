From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 11 Aug 2016 09:19:18 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
Message-ID: <006601d1f3db$58cd1e00$0a675a00$@opengridcomputing.com>

> >
> > the DNR bit should not be set normally, only when we either don't want
> > to requeue or we can't.
> >

So when a request is requeued, when is it restarted?  It is getting restarted on
a controller that is in recovery mode and hasn't setup the new qp.  So the
nvme_rdma_queue struct associated with the request is pointing to a freed
ib_pq...
