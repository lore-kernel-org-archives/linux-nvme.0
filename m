From: keith.busch@intel.com (Keith Busch)
Date: Fri, 6 Apr 2018 13:34:43 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <767385b2-41fe-8a7c-3bed-f0b51f977635@eng.utah.edu>
References: <20180405224830.GI10098@localhost.localdomain>
 <20180405230515.GJ10098@localhost.localdomain>
 <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
 <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>
 <93003ab7-f4a0-7e5d-f107-277df20f5566@gmail.com>
 <20180406180445.GL10098@localhost.localdomain>
 <767385b2-41fe-8a7c-3bed-f0b51f977635@eng.utah.edu>
Message-ID: <20180406193443.GM10098@localhost.localdomain>

On Fri, Apr 06, 2018@01:00:37PM -0600, Scott Bauer wrote:
> I think we may get into a deadlock situation if we grab the pci_lock_rescan.
> the hotplug unconfigure code will eventually call driver->remove() which I believe
> can end up in the aer_remove(), which will do a flush_work. If the aer delegated
> irq handler is waiting on the pci_lock_rescan, before it does a walk_bus, we've deadlocked
> there as the hp code is waiting on the remove() to finish, and the remove is waiting on 
> the flush work to finish and the work being flushed is waiting on the lock.

Darn. I believe your point is valid, though not through pciehp since
root ports themselves are not pcie hot pluggable components, but other
paths could get there.
