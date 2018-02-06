From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Tue, 06 Feb 2018 12:00:18 -0600
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <20180206171550.GA764@localhost.localdomain>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>
 <20180206170200.GA658@localhost.localdomain>
 <0cc8ee246d548b5bf2b397591419e7b6@linux.vnet.ibm.com>
 <20180206171550.GA764@localhost.localdomain>
Message-ID: <6a3f6945136089c0883c4900e66ed11e@linux.vnet.ibm.com>

On 2018-02-06 11:15, Keith Busch wrote:
> 
> Are these using the registered pci_err_handler callbacks? If so, it
> may be okay to return NOT_HANDLED from the timeout handler.
> 
Yes. I changed to return BLK_EH_NOT_HANDLED. EEH got recovery but nvme 
list command hung. I did this:

#nvme subsystem-reset /dev/nvme0 --->trigger EEH on ppc.

#nvme list --------->give some traffic to trigger EEH


nvme            D    0  9916   8538 0x00040082
[ 1316.727442] Call Trace:
[ 1316.727488] [c000000f6deaf740] [c00000000001ccc0] 
__switch_to+0x330/0x660
[ 1316.727620] [c000000f6deaf7a0] [c000000000c5b724] 
__schedule+0x354/0xaf0
[ 1316.727692] [c000000f6deaf870] [c000000000c5bf08] schedule+0x48/0xc0
[ 1316.727813] [c000000f6deaf8a0] [c000000000c62664] 
schedule_timeout+0x374/0x580
[ 1316.727891] [c000000f6deaf990] [c000000000c5b398] 
io_schedule_timeout+0x68/0xa0
[ 1316.727988] [c000000f6deaf9c0] [c000000000c5d968] 
wait_for_common_io.constprop.6+0x178/0x280
[ 1316.728130] [c000000f6deafa40] [c000000000634d0c] 
blk_execute_rq+0x9c/0xf0
[ 1316.728196] [c000000f6deafab0] [c008000015ca2e48] 
nvme_submit_user_cmd+0xf8/0x3a0 [nvme_core]
[ 1316.728346] [c000000f6deafb30] [c008000015ca78d0] 
nvme_user_cmd+0x250/0x3f0 [nvme_core]
[ 1316.728440] [c000000f6deafc70] [c0000000006496d8] 
blkdev_ioctl+0x7d8/0x1120
[ 1316.728522] [c000000f6deafce0] [c0000000004b9494] 
block_ioctl+0x64/0xd0
[ 1316.728635] [c000000f6deafd20] [c000000000467500] 
do_vfs_ioctl+0xe0/0xa80
[ 1316.728749] [c000000f6deafde0] [c000000000467f74] 
SyS_ioctl+0xd4/0x130
[ 1316.728831] [c000000f6deafe30] [c00000000000b184] 
system_call+0x58/0x6c
