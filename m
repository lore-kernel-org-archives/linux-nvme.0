From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:06:58 +0200
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
Message-ID: <20160801110658.GF16141@lst.de>

On Fri, Jul 29, 2016@04:40:40PM -0500, Steve Wise wrote:
> Running many fio jobs on 10 NVMF/RDMA ram disks, and bringing down and back up
> the interfaces in a loop uncovers this crash.  I'm not sure if this has been
> reported/fixed?  I'm using the for-linus branch of linux-block + sagi's 5
> patches on the host.  
> 
> What this test tickles is keep-alive recovery in the presence of heavy
> raw/direct IO.  Before the crash there are logs of these logged, which is
> probably expected:

With what fixes does this happen?  This looks pretty similar to an
issue you reported before.
