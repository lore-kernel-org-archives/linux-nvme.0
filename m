From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Jul 2019 15:10:44 -0600
Subject: [PATCH] drivers/nvme: save/restore HMB on suspend/resume
In-Reply-To: <c90ac9850f944407b39e369dce2e1e72@AUSX13MPS303.AMER.DELL.COM>
References: <362aad7f1cf547c2a73e1c4f564984db@AUSX13MPS303.AMER.DELL.COM>
 <20190730204829.GI13948@localhost.localdomain>
 <c90ac9850f944407b39e369dce2e1e72@AUSX13MPS303.AMER.DELL.COM>
Message-ID: <20190730211044.GJ13948@localhost.localdomain>

On Tue, Jul 30, 2019@08:59:38PM +0000, Charles.Hyde@dellteam.com wrote:
> > > LiteOn CL1 devices allocate host memory buffer at initialization.
> > > This patch saves and restores the host memory buffer allocation for
> > > any NVMe device which has HMB.  Devices which have on-board memory
> > > buffers are not impacted.  This patch has been tested locally with the
> > > following devices: LiteOn CL1 and CA3, Hynix BC511 and PC601, WDC
> > > SN520 and SN720.  This patch has also been tested by our partners at
> > > Wistron and Compal.
> > 
> > Please explain why you're doing this rather than what you're doing. We
> > previously concluded that NVMe power states have no spec defined impact
> > on HMB, so changing driver behavior requires justification.
> 
> Why this change is necessary is because LiteOn CL1 devices would
> effectively freeze when coming out of S0ix.  The user perspective is
> that, although the Linux kernel is still running in RAM, no commands
> could be executed because the CL1 device had no memory buffer, or the
> memory buffer was not in the same location; the memory buffer address
> was not discernable by me because I had no ability to run commands in
> this condition.  After implementing this change, these same CL1 devices
> function properly and command access is restored.

But why does the device need this? The kernel has not relocated the HMB,
and it hasn't removed control of the HMB from the device either. We made
a concious choice to not disable HMB in order to get the fastest resume
latency, and additional HMB management is not supposed to be necessary
in the first place. So what's going on with this device that it needs
the driver to disable/enable HMB? Is the nvme power state breaking its
ability to use it or something else?
