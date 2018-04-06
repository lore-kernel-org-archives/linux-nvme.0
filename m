From: keith.busch@intel.com (Keith Busch)
Date: Fri, 6 Apr 2018 16:00:59 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <e1218a86-2183-91c9-5a0a-a1c331b5b5f3@gmail.com>
References: <20180405224830.GI10098@localhost.localdomain>
 <20180405230515.GJ10098@localhost.localdomain>
 <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
 <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>
 <93003ab7-f4a0-7e5d-f107-277df20f5566@gmail.com>
 <20180406180445.GL10098@localhost.localdomain>
 <e1218a86-2183-91c9-5a0a-a1c331b5b5f3@gmail.com>
Message-ID: <20180406220058.GN10098@localhost.localdomain>

On Fri, Apr 06, 2018@02:08:38PM -0500, Alex G. wrote:
> On 04/06/2018 01:04 PM, Keith Busch wrote:
> > On Fri, Apr 06, 2018@12:46:06PM -0500, Alex G. wrote:
> >> On 04/06/2018 12:16 PM, Scott Bauer wrote:
> >>> You're using AER inject, right?
> >>
> >> No. I'm causing the errors in hardware with hot-unplug.
> > 
> > I think Scott's still on the right track for this particular sighting.
> > The AER handler looks unsafe under changing topologies. It might need run
> > under pci_lock_rescan_remove() before walking the bus to prevent races
> > with the surprise removal, but it's not clear to me yet if holding that
> > lock is okay to do in this context.
> 
> I think we have three mechanisms that can remove a device: nvme timeout,
> Link Down interrupt, and AER.

The only things that should cause an automatic device removal from the
PCI topology are PCIe Slot events "Link Down" or "Present Detect Change",
or a PCIe DPC trigger.

An nvme command timeout or PCIe AER may have the driver unbind from the
device if recovery attempts are unable to get the controller talking
again, but the PCI device will remain.

> Link Down comes 20-60ms after the link actually dies, in which time nvme
> will queue IO, which can cause a flood of PCIe errors, which trigger AER
> handling. I suspect there is a massive race condition somewhere, but I
> don't yet have convincing evidence to prove it.

I think Scott's identified at least one race here.
 
> > This however does not appear to resemble your previous sightings. In your
> > previous sightings, it looks like something has lost track of commands,
> > and we're freeing the resources with them a second time.
> 
> I think they might be related.

Possibly.

Fixing the AER use-after-free on a removed pci_dev looks like it's going
to require a bit more work in the AER driver to do it safely. But just
as an experiment, could you try applying the below and let us know if
that fixes this most recent sighting? The conditions where this patch
are unsafe should not apply to your test, and this would prove this type
of synchronization is required.

---
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea52e7d4..16ecbcd76373 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -805,8 +805,10 @@ void aer_isr(struct work_struct *work)
 	struct pcie_device *p_device = rpc->rpd;
 	struct aer_err_source uninitialized_var(e_src);
 
+	pci_lock_rescan_remove();
 	mutex_lock(&rpc->rpc_mutex);
 	while (get_e_source(rpc, &e_src))
 		aer_isr_one_error(p_device, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
+	pci_unlock_rescan_remove();
 }
--
