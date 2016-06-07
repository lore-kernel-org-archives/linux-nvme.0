From: hch@lst.de ('Christoph Hellwig')
Date: Tue, 7 Jun 2016 22:25:52 +0200
Subject: NVMe over Fabrics support for nvme-cli
In-Reply-To: <022b01d1c0f8$53c13b50$fb43b1f0$@opengridcomputing.com>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
 <022b01d1c0f8$53c13b50$fb43b1f0$@opengridcomputing.com>
Message-ID: <20160607202552.GA16320@lst.de>

On Tue, Jun 07, 2016@03:08:15PM -0500, Steve Wise wrote:
> > 
> > Hi Keith,
> > 
> > the series below adds support for the discovery, connect, connect-all and
> > disconnect commands to nvme-cli, which are useful to support the NVMe over
> > Fabrics host code.  Most of the work is from Ming with various bits and
> > pieces from me.  I also did the final rebase to the latest master tree.
> 
> Hey Christoph, looks like the man page needs to be updated.

Or rather added..

> Also, connect-all doesn't seem to work for me.  Am I doing something wrong?

Yes!

> 
> [root at stevo1 nvme-cli]# nvme discover -t rdma -a 10.0.1.14 -s 4420
> Discovery Log Number of Records 7, Generation counter 51
> =====Discovery Log Entry 0======
> trtype:  1
> adrfam:  0

adrfam = 0 means you didn't set the address family on the target.
I'll also add checking for a valid adrfam on the target to the TODO list.
