From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 6 Apr 2018 11:16:22 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
References: <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
 <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
 <20180405224138.GH10098@localhost.localdomain>
 <20180405224830.GI10098@localhost.localdomain>
 <20180405230515.GJ10098@localhost.localdomain>
 <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
Message-ID: <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>

es1;4804;0cOn Fri, Apr 06, 2018@12:11:48PM -0500, Alex G. wrote:
> On 04/06/2018 10:32 AM, Keith Busch wrote:
> > On Thu, Apr 05, 2018@06:44:21PM -0500, Alex G. wrote:
> >> Actually, it crashed very fast [1]
> > 
> > Could you possibly do an experiment for this? Does this happen if you're
> > not using MD RAID and disable NVME_MULTIPATH?
> 
> Okay, no md-raid (or lvm mirror), NVME_MULTIPATH not set, and we still
> get a use-after-free (log attached). Could this be a race condition
> between nvme causing an unload and AER recovery?



You're using AER inject, right?

Two things with aer inject:

aer_inject.c doesn't grab the pci_lock_rescan_remove() when it calls
pci_get_domain_bus_and_slot so theoretically we could be in


pciehp_unconfigure_device with the rescan lock, aer_inject will get the pci_dev,
via pci_get_domain_bus_and_slot, which will do a pci_dev_get().


pciehp_unconfigure_device will start iterating over the devices, calling pci_dev_get(),

So we now have 2 references on the device. aer_inject then calls the aer irq handler:
aer_irq() where we delegate off to a work queue, so we're unblocked and we kick back
to aer_inject(), where at the end we do a pci_dev_put().

Now back to pciehp_unconfigure_device() it does a pci_dev_put() as well and our ref
count drops to 0.

It seems like an error with aer_inject, it needs to continue to hold that reference to
the pci_device until the delegated work queue is complete, I think?

If you comment out the pci_dev_put() at the bottom of aer_inject.c aer_inject(), does that UAF
go away? --note this isnt the real fix, but it will tell me if I am insane or on the right path.
