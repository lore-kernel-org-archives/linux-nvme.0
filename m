From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 7 Jun 2016 15:32:04 -0500
Subject: NVMe over Fabrics support for nvme-cli
In-Reply-To: <20160607202552.GA16320@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
 <022b01d1c0f8$53c13b50$fb43b1f0$@opengridcomputing.com>
 <20160607202552.GA16320@lst.de>
Message-ID: <022d01d1c0fb$a715e7d0$f541b770$@opengridcomputing.com>

> > Hey Christoph, looks like the man page needs to be updated.
> 
> Or rather added..
> 
> > Also, connect-all doesn't seem to work for me.  Am I doing something wrong?
> 
> Yes!
> 
> >
> > [root at stevo1 nvme-cli]# nvme discover -t rdma -a 10.0.1.14 -s 4420
> > Discovery Log Number of Records 7, Generation counter 51
> > =====Discovery Log Entry 0======
> > trtype:  1
> > adrfam:  0
> 
> adrfam = 0 means you didn't set the address family on the target.
> I'll also add checking for a valid adrfam on the target to the TODO list.

I updated my json input file to add "ipv4" to the "adrfam" entries, and
connect-all works like a champ.

Thanks,

Steve.
