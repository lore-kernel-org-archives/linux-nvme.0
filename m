From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 1 Aug 2016 16:38:31 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
Message-ID: <015701d1ec3d$0c9a6420$25cf2c60$@opengridcomputing.com>

> > On Fri, Jul 29, 2016@04:40:40PM -0500, Steve Wise wrote:
> > > Running many fio jobs on 10 NVMF/RDMA ram disks, and bringing down and
> back
> > up
> > > the interfaces in a loop uncovers this crash.  I'm not sure if this has
been
> > > reported/fixed?  I'm using the for-linus branch of linux-block + sagi's 5
> > > patches on the host.
> > >
> > > What this test tickles is keep-alive recovery in the presence of heavy
> > > raw/direct IO.  Before the crash there are logs of these logged, which is
> > > probably expected:
> >
> > With what fixes does this happen?  This looks pretty similar to an
> > issue you reported before.
> 
> As I said, I'm using the for-linus branch of the linux-block repo
> (git://git.kernel.dk/linux-block) + sagi's 5 recent patches.   So I should be
> using the latest and greatest, I think.  This problem was originally seen on
> nvmf-all.3 as well.  Perhaps I have reported this previously.  But now I'm
> trying to fix it :)
> 

I do have two different problem reports internally at Chelsio that both show the
same signature.  I found the other one :)  For the 2nd problem report, there was
no ifup/down to induce keep alive recovery.  It just loads up 10 ram disks on a
64 core host/target pair in a similar manner, and after a while lots of
nvme_rdma_post_send() errors are logged (probably due to a connection death) and
then the crash.   I'm still gathering info on that one, but it appears the qp
again was freed somehow and then attempts to post to it cause the crash...

Steve
