From: james@dingwall.me.uk (James Dingwall)
Date: Fri, 30 Nov 2018 11:50:14 +0000
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181127150102.GA6181@localhost.localdomain>
References: <20181126133839.GA4348@dingwall.me.uk>
 <20181126153110.GM26707@localhost.localdomain>
 <20181127075426.GA4173@infradead.org>
 <20181127102554.GA16387@dingwall.me.uk>
 <20181127150102.GA6181@localhost.localdomain>
Message-ID: <20181130115014.GA1123@dingwall.me.uk>

On Tue, Nov 27, 2018@08:01:02AM -0700, Keith Busch wrote:
> On Tue, Nov 27, 2018@02:25:54AM -0800, James Dingwall wrote:
> > Hi,
> > On Mon, Nov 26, 2018@11:54:27PM -0800, Christoph Hellwig wrote:
> > > On Mon, Nov 26, 2018@08:31:11AM -0700, Keith Busch wrote:
> > > > According to the resolution discussion here:
> > > > 
> > > >   https://downloadcenter.intel.com/download/28320/Known-Issue-Intel-SSD-760p-Pro-7600p-Series-SubNQN-Conflict-on-Linux
> > > > 
> > > >   "
> > > >   If you purchased your Intel? SSD from an OEM, your firmware version may
> > > >   have a different naming. Contact your local OEM representative for
> > > >   latest firmware revisions.
> > > >   "
> > > > 
> > > > Sounds like Lenovo will need to merge the Intel update into their
> > > > specific firmware if they haven't already done so.
> > > 
> > > OEMs are notoriously bad in picking up firmware fixes.  If the problems
> > > with this drive persist we should probably add a quick that ignores the
> > > drive provided NQN and build up one from based on the legacy
> > > model/serial number algorithm instead.
> > 
> > Would something like this be the way to go if an appropriate entry is
> > created in the nvme_id_table in pci.c?  The example subnqn shown in
> > http://lists.infradead.org/pipermail/linux-nvme/2018-November/021154.html
> > looks like the fallback entry so I suppose the firmware fix has been to
> > just blank the relevant field.  (Should 2014.08.org be 2014-08.org
> > in core.c when generating the fake name?)
> > 
> > Thanks,
> > James
> 
> Looks correct, and just needs the nvme_id_table updated as you
> mentioned. I also recommend skipping the NVME_VS(1, 2, 1) check if the
> quirk is set so we're not warning users.
> 
I have tested this patch in a build of the Ubuntu 4.15.0-39-generic
kernel adjusted only for a strncpy / strlcpy for the change in core.c.
I have moved the NVME_VS(1, 2, 1) if the quirk is set.  I'm not sure
how to restrict the nvme_id_table entry to specific firmware revisions
but perhaps that doesn't matter if (at least in this case) the fixed
firmware no longer supplies a value.

james at nvmetest:~$ cat /sys/class/block/nvme[01]n1/device/subsysnqn
nqn.2014.08.org.nvmexpress:80868086BTHH82250N1X1P0E    INTEL SSDPEKKF010T8L                    
nqn.2014.08.org.nvmexpress:80868086BTHH82250N261P0E    INTEL SSDPEKKF010T8L                    
james at nvmetest:~$ uname -r
4.15.0-39-generic

I have put the patch as a single commit on nvme-quirk-subnqn of
https://github.com/JKDingwall/linux.git.  I can split it if it makes
sense.

Thanks,
James


commit e6a9e9cc96aefbf4c984844f19b23095f225d5c0
Author: James Dingwall <james at dingwall.me.uk>
Date:   Tue Nov 27 16:11:23 2018 +0000

    nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN
    
    If a device provides an NQN it is expected to be globally unique.
    Unfortunately some firmware revisions for Intel 760p/Pro 7600p devices did
    not satisfy this requirement.  In these circumstances if a system has >1
    affected device then only one device is enabled.  If this quirk is enabled
    then the device supplied subnqn is ignored and we fallback to generating
    one as if the field was empty.  In this case we also suppress the version
    check so we don't print a warning when the quirk is enabled.
    
    Signed-off-by: James Dingwall <james at dingwall.me.uk>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 559d567693b8..54bd23bba17d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2076,14 +2076,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
-	}
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 
-	if (ctrl->vs >= NVME_VS(1, 2, 1))
-		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+		if (ctrl->vs >= NVME_VS(1, 2, 1))
+			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+	}
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..a07155c05328 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..f05cdf4802f7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2696,6 +2696,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
