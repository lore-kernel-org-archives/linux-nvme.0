From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 May 2018 10:52:04 -0600
Subject: Deprecating NVME_IOCTL_SUBSYS_RESET
In-Reply-To: <74d5123de0b94d38b08ed85678d2ac91@ausx13mps321.AMER.DELL.COM>
References: <866e6766-3a3f-8d14-8475-481e839502ad@gmail.com>
 <20180510161308.GA4477@localhost.localdomain>
 <74d5123de0b94d38b08ed85678d2ac91@ausx13mps321.AMER.DELL.COM>
Message-ID: <20180510165203.GC4477@localhost.localdomain>

On Thu, May 10, 2018@04:18:06PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> 
> According to (my reading of) the NVMe spec, an NSSR and PCIe link reset 
> should be equivalent.

That can't possibly be the case. A PCIe link reset affects a single
device on that PCIe link, but a NSSR resets ALL controllers in the
subsystem, some of which may be on different links.

The NSSR does indeed lead to a PCIe link reset, but there's a lot more
to it that that.
 
> > That said, I have heard enough cases where this reset method is not
> > successful, so there's some work to do here. Most failures seem to be
> > around the handling of the rapid link down-up sequence, and success
> > seems very dependent on the platform and the device used.
> 
> There is also the controller reset, which seems less intrusive, though I 
> haven't looked into it. Can that be used instead of the subsystem reset 
> for those cases where a subsystem reset is allegedly needed?

According to the spec (section 5.11 Firmware Commit), a device may to
require a subsystem reset in order to complete a firmware upgrade. No
other type of reset will do the trick.
