From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Thu, 10 May 2018 16:18:06 +0000
Subject: Deprecating NVME_IOCTL_SUBSYS_RESET
References: <866e6766-3a3f-8d14-8475-481e839502ad@gmail.com>
 <20180510161308.GA4477@localhost.localdomain>
Message-ID: <74d5123de0b94d38b08ed85678d2ac91@ausx13mps321.AMER.DELL.COM>

On 5/10/2018 11:11 AM, Keith Busch wrote:
> On Thu, May 10, 2018@10:06:42AM -0500, Alex G. wrote:
>> There are ways to harden the IOCTL by quiescing all IO before issuing the
>> actual reset. Such safeguards are implemented everywhere else in the driver.
>> Is NVME_IOCTL_SUBSYS_RESET used in the real-world? I think it's too big of
>> an attack surface, and we're better off with -EOPNOTSUPP.
> 
> Quiescing here is not really a solution since an NVMe Subsystem Reset
> resets all the controllers in that subsystem, some of which may be
> connected to different hosts: we can't quiesce those other hosts from
> the driver level on the host issuing the reset.
> 
> I'm not sure we want to get rid of this feature either since this is
> sometimes the only option for completing a firmware upgrade.

According to (my reading of) the NVMe spec, an NSSR and PCIe link reset 
should be equivalent. Are we hitting non-compliant drives where that is 
not the case, or can those FW upgrades just use the PCIe link reset?

> That said, I have heard enough cases where this reset method is not
> successful, so there's some work to do here. Most failures seem to be
> around the handling of the rapid link down-up sequence, and success
> seems very dependent on the platform and the device used.

There is also the controller reset, which seems less intrusive, though I 
haven't looked into it. Can that be used instead of the subsystem reset 
for those cases where a subsystem reset is allegedly needed?

Alex
