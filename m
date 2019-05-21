From: kbusch@kernel.org (Keith Busch)
Date: Tue, 21 May 2019 08:20:01 -0600
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
References: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
Message-ID: <20190521142000.GA350@localhost.localdomain>

On Mon, May 20, 2019@05:12:46PM -0500, Iv?n Chavero wrote:
> > Not see this issue with 5.1 kernel, may be addressed by the following
> > patches:
> > 
> > 4e6b26d23dc1 PCI/MSI: Remove obsolete sanity checks for multiple
> > interrupt sets
> > a6a309edba13 genirq/affinity: Remove the leftovers of the original
> > set support
> > 612b72862b4d nvme-pci: Simplify interrupt allocation
> > c66d4bd110a1 genirq/affinity: Add new callback for (re)calculating
> > interrupt sets
> > 9cfef55bb57e genirq/affinity: Store interrupt sets size in struct
> > irq_affinity
> > 0145c30e896d genirq/affinity: Code consolidation
> > 
> > 
> i've tested with the 5.1.3 Fedora kernel and still got the same
> behaviour.
> 
> I think this might be relevant to solve the problem but i'm not sure:
> 
> [    2.394967] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> 
> [    2.394982] Call Trace:
> [    2.394986]  blk_mq_pci_map_queues+0x30/0xc0
> [    2.394990]  nvme_pci_map_queues+0x80/0xb0 [nvme]
> [    2.394993]  blk_mq_alloc_tag_set+0x11c/0x2c0
> [    2.394996]  nvme_reset_work+0xfd6/0x1515 [nvme]
> [    2.395000]  ? __switch_to_asm+0x40/0x70
> [    2.395001]  ? __switch_to_asm+0x34/0x70
> [    2.395003]  ? __switch_to_asm+0x40/0x70
> [    2.395005]  ? __switch_to_asm+0x34/0x70
> [    2.395007]  process_one_work+0x19d/0x380
> [    2.395010]  worker_thread+0x1db/0x3b0
> [    2.395011]  kthread+0xfb/0x130
> [    2.395013]  ? process_one_work+0x380/0x380
> [    2.395014]  ? kthread_park+0x90/0x90
> [    2.395016]  ret_from_fork+0x35/0x40
> [    2.395018] ---[ end trace 3af2b3afa977ff9e ]---
> 
> 
> I think this is a timing problem because the other partitions don't get
> mounted ro.
> 
> What could i do to make this work? I'm stuck in kernel 4.16.11 and i
> would really like to use latest kernel.

The warning in itself is not necessarily fatal and may not explain why
the filesystem is having issues. It should just mean that you've only
a single MSI interrupt vector sharing with the admin queue, so it's an
unmanagged vector, creating this warning. It should otherwise be usable.

The following should work around the warning assuming the vector count
is really what's creating your warning: managed irqs should always have
an offset, so no offset should mean no pci irq affinity.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..d55e1d92cf59 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -464,7 +464,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL)
+		if (i != HCTX_TYPE_POLL && offset)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
--
