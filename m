From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 May 2018 10:13:08 -0600
Subject: Deprecating NVME_IOCTL_SUBSYS_RESET
In-Reply-To: <866e6766-3a3f-8d14-8475-481e839502ad@gmail.com>
References: <866e6766-3a3f-8d14-8475-481e839502ad@gmail.com>
Message-ID: <20180510161308.GA4477@localhost.localdomain>

On Thu, May 10, 2018@10:06:42AM -0500, Alex G. wrote:
> There are ways to harden the IOCTL by quiescing all IO before issuing the
> actual reset. Such safeguards are implemented everywhere else in the driver.
> Is NVME_IOCTL_SUBSYS_RESET used in the real-world? I think it's too big of
> an attack surface, and we're better off with -EOPNOTSUPP.

Quiescing here is not really a solution since an NVMe Subsystem Reset
resets all the controllers in that subsystem, some of which may be
connected to different hosts: we can't quiesce those other hosts from
the driver level on the host issuing the reset.

I'm not sure we want to get rid of this feature either since this is
sometimes the only option for completing a firmware upgrade.

That said, I have heard enough cases where this reset method is not
successful, so there's some work to do here. Most failures seem to be
around the handling of the rapid link down-up sequence, and success
seems very dependent on the platform and the device used.
