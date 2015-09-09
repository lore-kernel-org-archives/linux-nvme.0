From: mohana.goli@seagate.com (Mohana Goli)
Date: Wed, 9 Sep 2015 21:35:26 +0530
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
 <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
Message-ID: <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>

Keith,

I ran another test after creating filesystem on the nvme
devices.Unfortunately i have seen the IO Timeouts again.
I used the following steps:

1.Created the 2 different filesystems on 2 different drives
2.Mounted the both the devices to different mount points
3.Initiated DD write IOs on both the mount points
4.Pulled one of the drive then i could see the IO timeouts.

But issue is not seen if i use the my fix ,doing nvme_dev_shutdown
first and nvme_dev_remove in nvme_remove function.And calling
blk_cleanup_queue(ns->queue) before calling del_gendisk in
nvme_ns_remove function.


Probably this is uncovering another corner case.

Thanks & Regards,
Mohan.



-----------------------------------------------

[  381.133461] pciehp 0000:0e:09.0:pcie24: pending interrupts 0x0108
from Slot Status
[  381.133472] pciehp 0000:0e:09.0:pcie24: DPC Interrupt status is
set:status = 0x89
[  381.133475] pciehp 0000:0e:09.0:pcie24: DPC is triggered:status = 0x89
[  381.133483] pciehp 0000:0e:09.0:pcie24: Card not present on Slot(9)
[  381.133486] pciehp 0000:0e:09.0:pcie24: slot(9): Link Down event
[  381.133500] pciehp 0000:0e:09.0:pcie24: Handle DPC Event on the slot(9)
[  381.133503] pciehp 0000:0e:09.0:pcie24: handle_dpc_trigger_event:
allocated memory :info =0xffff88102e8cde00
[  381.133508] pciehp 0000:0e:09.0:pcie24: pciehp_unconfigure_device:
domain:bus:dev = 0000:15:00
[  381.133547] nvme_ns_remove :entry kill =1
[  381.133567] nvme 0000:15:00.0: Cancelling I/O 17 QID 7
[  381.133571] blk_update_request: I/O error, dev nvme0n1, sector 25651808
[  381.133749] Buffer I/O error on dev nvme0n1, logical block 3206476,
lost async page write
[  381.133755] Buffer I/O error on dev nvme0n1, logical block 3206477,
lost async page write
[  381.133757] Buffer I/O error on dev nvme0n1, logical block 3206478,
lost async page write
[  381.133758] Buffer I/O error on dev nvme0n1, logical block 3206479,
lost async page write
[  381.133760] Buffer I/O error on dev nvme0n1, logical block 3206480,
lost async page write
[  381.133762] Buffer I/O error on dev nvme0n1, logical block 3206481,
lost async page write
[  381.133763] Buffer I/O error on dev nvme0n1, logical block 3206482,
lost async page write
[  381.133765] Buffer I/O error on dev nvme0n1, logical block 3206483,
lost async page write
[  381.133766] Buffer I/O error on dev nvme0n1, logical block 3206484,
lost async page write
[  381.133768] Buffer I/O error on dev nvme0n1, logical block 3206485,
lost async page write
[  411.339718] nvme 0000:15:00.0: Timeout I/O 468 QID 1
[  411.339740] nvme 0000:15:00.0: Aborting I/O 468 QID 1
[  428.361007] nvme 0000:15:00.0: Timeout I/O 1 QID 67
[  428.361023] nvme 0000:15:00.0: Aborting I/O 1 QID 67
[  428.361029] nvme 0000:15:00.0: Timeout I/O 2 QID 67
[  428.361033] nvme 0000:15:00.0: Aborting I/O 2 QID 67
[  428.361038] nvme 0000:15:00.0: Timeout I/O 3 QID 67
[  428.361042] nvme 0000:15:00.0: Aborting I/O 3 QID 67
[  442.363914] nvme 0000:15:00.0: Timeout I/O 468 QID 1
[  442.363929] nvme 0000:15:00.0: I/O 468 QID 1 timeout, reset controller
[  442.366134] nvme 0000:15:00.0: Cancelling I/O 1 QID 67
[  442.366140] nvme 0000:15:00.0: completing aborted command with status:4007
[  442.366146] blk_update_request: I/O error, dev nvme0n1, sector 1
[  442.366160] nvme 0000:15:00.0: Cancelling I/O 2 QID 67
[  442.366163] nvme 0000:15:00.0: completing aborted command with status:4007
[  442.366165] blk_update_request: I/O error, dev nvme0n1, sector 8
[  442.366169] nvme 0000:15:00.0: Cancelling I/O 3 QID 67
[  442.366172] nvme 0000:15:00.0: completing aborted command with status:4007
[  442.366174] blk_update_request: I/O error, dev nvme0n1, sector 16
[  442.366187] nvme 0000:15:00.0: Cancelling I/O 468 QID 1
[  442.366189] nvme 0000:15:00.0: completing aborted command with status:4007
[  442.366192] blk_update_request: I/O error, dev nvme0n1, sector 390911849
[  442.366200] nvme 0000:15:00.0: Cancelling I/O 1 QID 0
[  442.366204] nvme 0000:15:00.0: Abort status:7 result:288cf000
[  442.366207] nvme 0000:15:00.0: Cancelling I/O 2 QID 0
[  442.366209] nvme 0000:15:00.0: Abort status:7 result:288cf000
[  442.366212] nvme 0000:15:00.0: Cancelling I/O 3 QID 0
[  442.366215] nvme 0000:15:00.0: Abort status:7 result:288cf000
[  442.366217] nvme 0000:15:00.0: Cancelling I/O 4 QID 0
[  442.366220] nvme 0000:15:00.0: Abort status:7 result:288cf000
[  442.366228] XFS (nvme0n1): metadata I/O error: block 0x174cd769
("xlog_iodone") error 5 numblks 64
[  442.366233] XFS (nvme0n1): xfs_do_force_shutdown(0x2) called from
line 1177 of file fs/xfs/xfs_log.c.  Return address =
0xffffffff8127cd00
[  442.366253] XFS (nvme0n1): Log I/O Error Detected.  Shutting down filesystem
[  442.366255] XFS (nvme0n1): Please umount the filesystem and rectify
the problem(s)
[  442.366292] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  442.366298] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  442.366665] device: 'nvme0n1': device_del
[  442.366828] nvme_ns_remove :gen disk removed
[  442.370177] device: '259:1': device_unregister
[  442.370181] device: '259:1': device_del
[  442.370231] device: '259:1': device_create_release
[  442.370239] nvme_ns_remove :exit
[  442.370264] nvme :Removed the namespaces
[  442.370317] device: 'nvme0': device_unregister
[  442.370319] device: 'nvme0': device_del
[  442.370565] nvme :nvme dev completly removed
[  442.370575] device: '0000:15:00.0': device_del
[  442.370645] pciehp 0000:0e:09.0:pcie24: pciehp_unconfigure_device:
domain:bus:dev = 0000:15:00
[  442.370663] pcieport 0000:0e:09.0: Clear the DPC trigger status = 0x89
[  442.376962] pci 0000:15:00.0: Refused to change power state, currently in D3
[  442.376971] pci 0000:15:00.0: can't enable device: BAR 0 [mem
0x95300000-0x95303fff 64bit] not claimed
[  442.376975] pci 0000:15:00.0: Device failed to resume
[  458.128229] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  488.231729] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  518.335223] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  548.438697] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  578.542194] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  608.645685] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  638.749164] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  668.852663] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  698.956143] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  729.059637] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  759.163119] XFS (nvme0n1): xfs_log_force: error -5 returned.
[  789.266620] XFS (nvme0n1): xfs_log_force: error -5 returned.

On Wed, Sep 9, 2015@7:09 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 9 Sep 2015, Mohana Goli wrote:
>>
>> Keith,
>>
>> Don't we need to take a queue spin lock  while processing the IOs on
>> each request queue like the way we are doing in nvme_clear_queue ?
>>
>>
>> >>>blk_mq_all_tag_busy_iter(hctx->tags,
>>                                              nvme_cancel_queue_ios,
>>                                               hctx->driver_data);
>
>
> You're right, thanks for the catch.
