From: rakesh@tuxera.com (Rakesh Pandit)
Date: Fri, 26 May 2017 18:28:09 +0300
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170526100613.GE24894@localhost.localdomain>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
 <20170526100613.GE24894@localhost.localdomain>
Message-ID: <20170526152809.GA18963@dhcp-216.srv.tuxera.com>

Added Andy Lutomirski to CC (APST related issue)

On Fri, May 26, 2017@06:06:14AM -0400, Keith Busch wrote:
> On Wed, May 24, 2017@05:26:25PM +0300, Rakesh Pandit wrote:
> > Commit c5f6ce97c1210 tries to address multiple resets but fails as
> > work_busy doesn't involve any synchronization and can fail.  This is
> > reproducible easily as can be seen by WARNING below which is triggered
> > with line:
> > 
> > WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)
> > 
> > Allowing multiple resets can result in multiple controller removal as
> > well if different conditions inside nvme_reset_work fail and which
> > might deadlock on device_release_driver.
> > 
> > This patch makes sure that work queue item (reset_work) is added only
> > if controller state != NVME_CTRL_RESETTING and that is achieved by
> > moving state change outside nvme_reset_work into nvme_reset and
> > removing old work_busy call.  State change is always synchronizated
> > using controller spinlock.
> 
> So, the reason the state is changed when the work is running rather than
> queueing is for the window when the state may be set to NVME_CTRL_DELETING,
> and we don't want the reset work to proceed in that case.
>
> What do you think about adding a new state, like NVME_CTRL_SCHED_RESET,
> then leaving the NVME_CTRL_RESETTING state change as-is?

Thanks.  I will give it a go as soon as I have hardware available
(have limited access and yesterday was a holiday here) and address
issues pointed by Christoph earlier.

Also there is a related (because I can reproduce it easily on same
device with nvme_remove) but separate issue with APST implementation.
PID (undergoing nvme_uninit_ctrl) waits for ever at
blk_execute_rq. Controller is in DEAD state and nvme_remove_namespaces
just before device_destroy call has killed all queues which seems to
eventually make blk_execute_rq sleep for ever as it tries to sync
updated latency (0 most likely).

[<ffffffff813c9716>] blk_execute_rq+0x56/0x80
[<ffffffff815cb6e9>] __nvme_submit_sync_cmd+0x89/0xf0
[<ffffffff815ce7be>] nvme_set_features+0x5e/0x90
[<ffffffff815ce9f6>] nvme_configure_apst+0x166/0x200
[<ffffffff815cef45>] nvme_set_latency_tolerance+0x35/0x50
[<ffffffff8157bd11>] apply_constraint+0xb1/0xc0
[<ffffffff8157cbb4>] dev_pm_qos_constraints_destroy+0xf4/0x1f0
[<ffffffff8157b44a>] dpm_sysfs_remove+0x2a/0x60
[<ffffffff8156d951>] device_del+0x101/0x320
[<ffffffff8156db8a>] device_unregister+0x1a/0x60
[<ffffffff8156dc4c>] device_destroy+0x3c/0x50
[<ffffffff815cd295>] nvme_uninit_ctrl+0x45/0xa0
[<ffffffff815d4858>] nvme_remove+0x78/0x110
[<ffffffff81452b69>] pci_device_remove+0x39/0xb0
[<ffffffff81572935>] device_release_driver_internal+0x155/0x210
[<ffffffff81572a02>] device_release_driver+0x12/0x20
[<ffffffff815d36fb>] nvme_remove_dead_ctrl_work+0x6b/0x70
[<ffffffff810bf3bc>] process_one_work+0x18c/0x3a0
[<ffffffff810bf61e>] worker_thread+0x4e/0x3b0
[<ffffffff810c5ac9>] kthread+0x109/0x140
[<ffffffff8185800c>] ret_from_fork+0x2c/0x40
[<ffffffffffffffff>] 0xffffffffffffffff
