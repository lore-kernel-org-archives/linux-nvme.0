From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 24 May 2018 14:52:55 +0800
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180523224946.GF11037@localhost.localdomain>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
 <20180523224946.GF11037@localhost.localdomain>
Message-ID: <c34a81d6-14cb-430a-da2d-810ef03f9aa6@oracle.com>

Hi Keith and Ming

On 05/24/2018 06:49 AM, Keith Busch wrote:
> On Wed, May 23, 2018@10:16:14AM -0600, Keith Busch wrote:
>> On Wed, May 23, 2018@11:00:59AM +0800, Ming Lei wrote:
>>> Looks V2 still may trigger IO hang warning:
>>
>> Anything in particular that triggered this?
>>
>> I'm running IO with io-timeout fault injection, with resets and rescans
>> randomly running in the background, so I'm guessing that's not enough.
> 
> At the very least, I can see allowing CONNECTING->RESETTING transitions
> was a terrible idea. I can get other failures because of that, but not
> quite what you're seeing.
> 

I reproduce this issue on my local.

A simulated io timeout and a script which bind and unbind the nvme card repeatedly.

The dmesg log:
[ 1898.968131] nvme nvme0: Reset failure status: -4, failures:1
[ 1898.988273] queue 8 cq_vector is -1
[ 1898.990369] queue 7 cq_vector is -1
[ 1898.992463] queue 6 cq_vector is -1
[ 1898.993761] queue 5 cq_vector is -1
[ 1898.994264] queue 4 cq_vector is -1
[ 1898.994766] queue 3 cq_vector is -1
[ 1898.995269] queue 2 cq_vector is -1
[ 1898.995801] queue 1 cq_vector is -1
[ 1898.996343] queue 0 cq_vector is -1

this is printed by the nvme_dev_disable, it is added by myself.
from the time, the io 137 on ioq 4 should be timed out when nvme_pci_update_hw_ctx->nvme_wait_freeze

[ 1929.836296] nvme nvme0: I/O 137 QID 4 timeout, aborting
[ 1929.838932] nvme nvme0: Abort status: 0x0
[ 1959.916465] nvme nvme0: I/O 137 QID 4 timeout, reset controller
[ 2040.796290] INFO: task kworker/u16:2:2231 blocked for more than 120 seconds.
[ 2040.799178]       Not tainted 4.17.0-rc5+ #72
[ 2040.801582] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2040.802347] kworker/u16:2   D    0  2231      2 0x80000080
[ 2040.803076] Workqueue: nvme-wq nvme_scan_work
[ 2040.803815] Call Trace:
[ 2040.807052]  schedule+0x52/0xe0
[ 2040.807854]  blk_mq_freeze_queue_wait+0xad/0x150
[ 2040.810548]  nvme_wait_freeze+0x42/0x60
[ 2040.811445]  nvme_pci_update_hw_ctx+0x7c/0x150
[ 2040.812407]  nvme_scan_work+0xb0/0x3f0
[ 2040.821562]  process_one_work+0x3ca/0xaa0
[ 2040.824848]  worker_thread+0x89/0x6c0
[ 2040.826050]  kthread+0x18d/0x1e0
[ 2040.829603]  ret_from_fork+0x24/0x30


And some debugfs and sysfs information:

root at will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat state
SAME_COMP|NONROT|IO_STAT|DISCARD|INIT_DONE|NO_SG_MERGE|POLL|WC|FUA|STATS|REGISTERED|QUIESCED
root at will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat hctx3/cpu3/rq_list 
00000000e78405ab {.op=READ, .cmd_flags=, .rq_flags=DONTPREP|IO_STAT|STATS|MQ_TIMEOUT_EXPIRED, .state=idle, .tag=137, .internal_tag=-1}
root at will-ThinkCentre-M910s:/sys/kernel/debug/block/nvme0n1# cat /sys/block/nvme0n1/device/state
deleting

I suspect that, when the nvme_timeout handle io 137 and queue the reset_work, the nvme_remove cancels the reset work at the same time.
Then nvme queue is left in quiesced state.


Thanks
Jianchao
