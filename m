From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Mar 2015 14:45:09 +0000 (UTC)
Subject: 4.0.0-rc4 NVMe NULL pointer dereference and hang
In-Reply-To: <E1Ya2zQ-00012y-Gh@feisty.vs19.net>
References: <E1Ya2zQ-00012y-Gh@feisty.vs19.net>
Message-ID: <alpine.LNX.2.00.1503231415030.32385@localhost.lm.intel.com>

On Sun, 22 Mar 2015, Steven Noonan wrote:
> This happens on boot, and then eventually results in an RCU stall.
>
> [    8.047533] nvme 0000:05:00.0: Device not ready; aborting initialisation
>
> Note that the above is expected with this hardware (long story).
> Although 3.19.x prints the above and then continues gracefully, 4.0-rc
> breaks immediately after the above message:

Thanks for the notice. I CC'ed the linux-nvme mailing list.

Since your device failed to become ready (this is expected, you say? ok,
I won't ask. :)), it triggered recovery action that assumed it's list
head was initialized once before. It's a one-line fix:

---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3b43897..ab7c847 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3007,6 +3007,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  	}
  	get_device(dev->device);

+	INIT_LIST_HEAD(&dev->node);
  	INIT_WORK(&dev->probe_work, nvme_async_probe);
  	schedule_work(&dev->probe_work);
  	return 0;
--

I'll coerce someone to merge this for rc6 today.

> [    8.054306] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [    8.062155] IP: [<ffffffffa025e614>] nvme_dev_list_remove+0x24/0xa0 [nvme]
> [    8.069043] PGD 0
> [    8.071067] Oops: 0002 [#1] SMP
> [    8.074332] Modules linked in: ahci libahci libata ehci_pci ehci_hcd scsi_mod usbcore usb_common nvme i915 intel_gtt i2c_algo_bit video drm_kms_helper drm i2c_core e1000e ptp pps_core ipmi_poweroff ipmi_msghandler button
> [    8.094244] CPU: 4 PID: 632 Comm: kworker/u288:1 Not tainted 4.0.0-rc4-00347-gb87444a2 #5
> [    8.109878] Workqueue: nvme nvme_reset_workfn [nvme]
> [    8.114852] task: ffff881f98271d70 ti: ffff881f982b8000 task.ti: ffff881f982b8000
> [    8.122321] RIP: 0010:[<ffffffffa025e614>]  [<ffffffffa025e614>] nvme_dev_list_remove+0x24/0xa0 [nvme]
> [    8.131624] RSP: 0000:ffff881f982bbd18  EFLAGS: 00010246
> [    8.136930] RAX: 0000000000000000 RBX: ffff883f63f84800 RCX: ffff88bf66e6a418
> [    8.144052] RDX: 0000000000000000 RSI: 0000000000000120 RDI: ffffffffa0269848
> [    8.151171] RBP: ffff881f982bbd28 R08: ffff881f982b8000 R09: 0000000000000001
> [    8.158288] R10: 0000000000000086 R11: 0000000000000020 R12: ffff883f63f84800
> [    8.165411] R13: ffff88bf66e6a400 R14: ffff88df627ff900 R15: 0000000000001000
> [    8.172530] FS:  0000000000000000(0000) GS:ffff883f7f880000(0000) knlGS:0000000000000000
> [    8.180600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.186337] CR2: 0000000000000008 CR3: 000001007ea0c000 CR4: 00000000001406e0
> [    8.193458] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    8.200574] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    8.207693] Stack:
> [    8.209705]  ffff881f982bbd28 ffff883f63f84978 ffff881f982bbdc8 ffffffffa026005e
> [    8.217150]  ffff883f7f894300 00000000ffff8de0 ffff881f982bbd98 ffffffff810a65e1
> [    8.224600]  ffff881f982bbdd8 ffffffff810a9943 ffff881f982bbd98 ffff881f982bbdd0
> [    8.232049] Call Trace:
> [    8.234500]  [<ffffffffa026005e>] nvme_dev_shutdown+0x1e/0x430 [nvme]
> [    8.240943]  [<ffffffff810a65e1>] ? put_prev_entity+0x31/0x350
> [    8.246772]  [<ffffffff810a9943>] ? pick_next_task_fair+0x103/0x4e0
> [    8.253046]  [<ffffffff81012605>] ? __switch_to+0x175/0x5c0
> [    8.258607]  [<ffffffffa0262a8e>] nvme_reset_failed_dev+0x1e/0x100 [nvme]
> [    8.265378]  [<ffffffffa025e1cf>] nvme_reset_workfn+0xf/0x20 [nvme]
> [    8.271649]  [<ffffffff810872fe>] process_one_work+0x14e/0x400
> [    8.277472]  [<ffffffff8108822b>] worker_thread+0x5b/0x530
> [    8.282943]  [<ffffffff810881d0>] ? rescuer_thread+0x3a0/0x3a0
> [    8.288778]  [<ffffffff8108d359>] kthread+0xc9/0xe0
> [    8.293649]  [<ffffffff8108d290>] ? kthread_stop+0x100/0x100
> [    8.299322]  [<ffffffff81541158>] ret_from_fork+0x58/0x90
> [    8.304711]  [<ffffffff8108d290>] ? kthread_stop+0x100/0x100
> [    8.310357] Code: 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb 48 c7 c7 48 98 26 a0 48 83 ec 08 e8 c3 23 2e e1 48 8b 13 48 8b 43 08 <48> 89 42 08 48 89 10 48 89 1b 48 81 3d 77 ae 00 00 a0 94 26 a0
> [    8.330295] RIP  [<ffffffffa025e614>] nvme_dev_list_remove+0x24/0xa0 [nvme]
> [    8.337258]  RSP <ffff881f982bbd18>
> [    8.340739] CR2: 0000000000000008
> [    8.344056] ---[ end trace 70831a936042aa41 ]---
