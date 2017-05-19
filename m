From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 May 2017 10:18:34 -0400
Subject: [PATCH] nvme: Change our APST table to be no more aggressive
 than Intel RSTe
In-Reply-To: <20170519063505.GA15980@infradead.org>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
 <20170519063505.GA15980@infradead.org>
Message-ID: <20170519141834.GB6015@localhost.localdomain>

On Thu, May 18, 2017@11:35:05PM -0700, Christoph Hellwig wrote:
> On Thu, May 18, 2017@06:13:55PM -0700, Andy Lutomirski wrote:
> > a) Leave the Dell quirk in place until someone from Dell or Samsung
> > figures out what's actually going on.  Add a blanket quirk turning off
> > the deepest sleep state on all Intel devices [1] at least until
> > someone from Intel figures out what's going on -- Hi, Keith!  Deal
> > with any other problems as they're reported.
> 
> I think we should just blacklist the 60p entirely.  It also seems to
> corrupt data 100% reliable when used with XFS.

I assume you're talking about the 600p/p3100. That family of devices
prefer 4k alignment, and patch below will enforce that, fixing all
access issues. I wasn't planning to post it because my understanding is
an imminent f/w update will make it unnecessary.

I understand there is a different issue specific to the KBL NUC platforms
that exposes some other errata, but I don't know much about that.

For all issues, though, a f/w update fixing them is undergoing validation,
but I don't have insider information on the release date.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5e709d..49d8070 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -964,7 +964,11 @@ static void __nvme_revalidate_disk(struct gendisk
*disk, struct nvme_id_ns *id)
 		blk_integrity_unregister(disk);
 
 	ns->pi_type = pi_type;
-	blk_queue_logical_block_size(ns->queue, bs);
+
+	if (ns->ctrl->quirks & NVME_QUIRK_PAGE_ALIGN)
+		blk_queue_logical_block_size(ns->queue, ns->ctrl->page_size);
+	else
+		blk_queue_logical_block_size(ns->queue, bs);
 
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fda6ebb..4b6e21f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -83,6 +83,11 @@ enum nvme_quirks {
 	 * APST should not be used.
 	 */
 	NVME_QUIRK_NO_APST			= (1 << 4),
+
+	/*
+	 * Require 4k aligned IO despite smaller LBA size
+	 */
+	NVME_QUIRK_PAGE_ALIGN			= (1 << 5),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a2f0d3..e08d1f7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2144,6 +2144,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DISCARD_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0xf1a5),
+		.driver_data = NVME_QUIRK_PAGE_ALIGN },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
--
