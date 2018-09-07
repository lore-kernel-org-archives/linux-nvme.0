From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Fri, 7 Sep 2018 15:40:45 +0000
Subject: Devices expected?
In-Reply-To: <20180906210508.GA31480@localhost.localdomain>
References: <DE927C68B458BE418D582EC97927A9288003E585@ORSMSX113.amr.corp.intel.com>
 <20180906210508.GA31480@localhost.localdomain>
Message-ID: <DE927C68B458BE418D582EC97927A9288003FD37@ORSMSX113.amr.corp.intel.com>

> > In general, my question is whether this is expected behavior?  If a
> > bug, is it fixed in a newer kernel?  We are trying to track some disk
> > stats and the unexpected (at least from our perspective) behavior in
> > /proc/diskstats is causing us some confusion.  Thanks!
> 
> With the exception of the 'lsblk' error message, I think all your results are
> expected when CONFIG_NVME_MUTLIPATH=y.

Thanks Keith.  I just pulled the Ubuntu mainline kernel package, rather than building my own, so I guess they have NVMeoF multipathing on by default.

Does nvme2c1n1 represent one path for the nvme2n1 device to use?  If I connected a second path I would see something like nvme2c2n1 pop up as well?
