From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Mon, 16 Nov 2015 22:33:34 +0100
Subject: nvme: controller resets
In-Reply-To: <CAKajsGPAsZorLkmGmA8VF46-5ic9ER4Lduu8Z2AFuH2DzT-_xA@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
 <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
 <20151111221433.GA11250@localhost.localdomain>
 <CAKajsGPAsZorLkmGmA8VF46-5ic9ER4Lduu8Z2AFuH2DzT-_xA@mail.gmail.com>
Message-ID: <2ab2128bc922157e2be4e6cda1e1f5a3@localhost>

On 2015/November/12 03:15, Vedant Lath wrote:
> On Thu, Nov 12, 2015@3:44 AM, Keith Busch <keith.busch@intel.com> wrote:
> > On Thu, Nov 12, 2015@03:26:04AM +0530, Vedant Lath wrote:
> >> [  235.496753] nvme: submit: QID 1 CMD opcode 2 flags 0 cid 1 NSID 1
> >> [  235.496755] nvme: submit: rsvd2 0 metadata 0 prp1 5897535488 prp2
> >> 2318221568 slba 41495303 length 0 control 0 dsmgmt 0 reftag 0 apptag 0
> >> appmask 0
> >
> > Let's examine the above command.
> >
> > You've got PRP1 set to 0x15f854000, and length set to 0 (1 block). Based
> > on other info provided on this device, a block is 4k.
> >
> > Seeing PRP1 is 4k aligned and you're transferring 4k of data should
> > mean you only need one PRP. Your command however shows PRP2 is used and
> > pointing to a list (must be a list rather than data since the offset is
> > 0x100 aligned).
> >
> > Either your new prints are incomplete, or there's a nasty bug somewhere.
> 
> The print statements seem fine:
> @ -389,6 +402,22 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>  {
>         u16 tail = nvmeq->sq_tail;
> 
> +       pr_debug("nvme: submit: QID %X CMD opcode %X flags %X cid %X
> NSID %X\012", nvmeq->qid, cmd->common.opcode, cmd->common.flags,
> cmd->common.command_id, cmd->common.nsid);
> +       if (cmd->common.opcode == 2) {
> +               pr_debug("nvme: submit: rsvd2 %llu metadata %llu prp1
> %llu prp2 %llu slba %llu length %u control %u dsmgmt %d reftag %d
> apptag %u appmask %u\012",
> +                        cmd->rw.rsvd2,
> +                        cmd->rw.metadata,
> +                        cmd->rw.prp1,
> +                        cmd->rw.prp2,
> +                        cmd->rw.slba,
> +                        cmd->rw.length,
> +                        cmd->rw.control,
> +                        cmd->rw.dsmgmt,
> +                        cmd->rw.reftag,
> +                        cmd->rw.apptag,
> +                        cmd->rw.appmask);
> +       }
> +
>         if (nvmeq->sq_cmds_io)
>                 memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
>         else
> 
> So it must be a bug somewhere.
> 
> This does not look like a device-specific bug so it should be
> reproducible on other systems as well. The step to reproduce is:
> mkfs.btrfs /dev/nvme0n1px (where x is a partition number on the SSD).
> All WRITE commands done due to mkfs.btrfs have non-zero values for
> both prp1 and prp2 regardless of length. All of them succeed except
> the last one which is just after a FLUSH.

For the time being I propose the patch below. I tested it over the
weekend and seems to work better than disabling FLUSHs as I had propose
previously.

Although that is probably not a final fix, it is the best we can do
right now to both support the Apple controller and to avoid data loss to
the best of what we know.


Background: that Apple NVMe seems to quite compliant to NVMe, except for
two things:

1) It does not handle 64bit transfers, which has recently been
addressed.

2) There is a serious problem regarding the combination of queue depth
and FLUSH commands. Either we disable FLUSHs at all (and loose data on
panics or power loss) or we limit the queue depth to 2, which is
obviously not desirable but seems to have way less impact on performance
than I suspected.

As time is running short I propose that fix for now. Should it become
persistent, it should probably become a quirk. If we come up with new
results (or an apple falls on our heads), it will be replaced soon.


Signed-off-by: Stephan G?nther <guenther at tum.de>
Signed-off-by: Maurice Leclaure <leclaire at in.tum.de
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..15bbedb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2701,6 +2701,14 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+
+	/*
+	 * Hotfix for the Apple controller found in the MacBook8,1 and some
+	 * MacBook7,1 to avoid controller resets and data loss.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001)
+		dev->q_depth = 2;
+
 	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
