From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 22 May 2019 12:08:26 +0800
Subject: [PATCH] nvme-pci: use blk-mq mapping for unmanaged irqs
In-Reply-To: <20190521171745.4061-1-keith.busch@intel.com>
References: <20190521171745.4061-1-keith.busch@intel.com>
Message-ID: <CACVXFVO0Pyq-TVm5LMGk7HDm+w0YYj8-awZnWRre3pchVrF1cw@mail.gmail.com>

On Wed, May 22, 2019@1:22 AM Keith Busch <keith.busch@intel.com> wrote:
>
> If a device is providing a single IRQ vector, the IO queue will share that
> vector with the admin queue with a 0 offset. This is an unmanaged vector,
> so does not have a valid PCI IRQ affinity. Avoid trying to use managed
> affinity in this case and let blk-mq set up the cpu-queue mapping instead.
> Otherwise we'd hit the following warning when the device is using MSI:
>
>  WARNING: CPU: 4 PID: 7 at drivers/pci/msi.c:1272 pci_irq_get_affinity+0x66/0x80
>  Modules linked in: nvme nvme_core serio_raw
>  CPU: 4 PID: 7 Comm: kworker/u16:0 Tainted: G        W         5.2.0-rc1+ #494
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>  RIP: 0010:pci_irq_get_affinity+0x66/0x80
>  Code: 0b 31 c0 c3 83 e2 10 48 c7 c0 b0 83 35 91 74 2a 48 8b 87 d8 03 00 00 48 85 c0 74 0e 48 8b 50 30 48 85 d2 74 05 39 70 14 77 05 <0f> 0b 31 c0 c3 48 63 f6 48 8d 04 76 48 8d 04 c2 f3 c3 48 8b 40 30
>  RSP: 0000:ffffb5abc01d3cc8 EFLAGS: 00010246
>  RAX: ffff9536786a39c0 RBX: 0000000000000000 RCX: 0000000000000080
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9536781ed000
>  RBP: ffff95367346a008 R08: ffff95367d43f080 R09: ffff953678c07800
>  R10: ffff953678164800 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffff9536781ed000 R14: 00000000ffffffff R15: ffff95367346a008
>  FS:  0000000000000000(0000) GS:ffff95367d400000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fdf814a3ff0 CR3: 000000001a20f000 CR4: 00000000000006e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   blk_mq_pci_map_queues+0x37/0xd0
>   nvme_pci_map_queues+0x80/0xb0 [nvme]
>   blk_mq_alloc_tag_set+0x133/0x2f0
>   nvme_reset_work+0x105d/0x1590 [nvme]
>   process_one_work+0x291/0x530
>   worker_thread+0x218/0x3d0
>   ? process_one_work+0x530/0x530
>   kthread+0x111/0x130
>   ? kthread_park+0x90/0x90
>   ret_from_fork+0x1f/0x30
>  ---[ end trace 74587339d93c83c0 ]---
>
> Fixes: 22b5560195bd6 ("nvme-pci: Separate IO and admin queue IRQ vectors")
> Reported-by: Iv?n Chavero <ichavero at chavero.com.mx>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 599065ed6a32..f562154551ce 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -464,7 +464,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>                  * affinity), so use the regular blk-mq cpu mapping
>                  */
>                 map->queue_offset = qoff;
> -               if (i != HCTX_TYPE_POLL)
> +               if (i != HCTX_TYPE_POLL && offset)
>                         blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>                 else
>                         blk_mq_map_queues(map);
> --

At default, non-manged IRQs won't be assigned by cpumask, and
pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) actually falls back to
non-managed IRQ allocation if no vectors are available for managed IRQs,
so looks fine:

Reviewed-by: Ming Lei <ming.lei at redhat.com>


Thanks,
Ming Lei
