From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 23 May 2018 11:00:59 +0800
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180523030057.GF31196@ming.t460p>

On Tue, May 22, 2018@04:03:24PM -0600, Keith Busch wrote:
> While some substantial changes to the blk-mq's timeout handling are
> under consideration, the following should be compatible with existing
> implementation, and current proposals for the future.
> 
> v1 -> v2:
> 
>   Reverse the sync/disable sequence on nvme reset in case a request was
>   prevented from completing in the timeout work, then unconditionally
>   disable the device to reclaim any remaining outstanding tags.
> 
>   Ensure we're not incorrectly clearing the new queue freeze flag.
> 
>   Do not start IO queues within the CONNECTING state. The queues will be
>   started after entering the LIVE state.
> 
>   Fixed the ratelimit to the intended print.
> 
>   A new fix for a very unlikely race where an IO was blocked from
>   completing prior to a reset, timing out yet again in CONNECTING state.
> 
>   A fix for a failed controller recovery that could leave queues quiesced
>   when trying to unbind the driver.
> 
>   Whitespace fixes
> 
> Keith Busch (8):
>   nvme: Sync request queues on reset
>   nvme-pci: Fix queue freeze criteria on reset
>   nvme: Move all IO out of controller reset
>   nvme: Allow reset from CONNECTING state
>   nvme-pci: Attempt reset retry for IO failures
>   nvme-pci: Rate limit the nvme timeout warnings
>   nvme-pci: End IO requests immediately in CONNECTING state
>   nvme-pci: Ensure queues are not quiesced on dead controller
> 
>  drivers/nvme/host/core.c |  24 +++++++++-
>  drivers/nvme/host/nvme.h |   2 +
>  drivers/nvme/host/pci.c  | 117 +++++++++++++++++++++++++++++++++--------------
>  3 files changed, 106 insertions(+), 37 deletions(-)

Hi Keith,

Looks V2 still may trigger IO hang warning:

[  246.812170] INFO: task kworker/u16:12:493 blocked for more than 120 seconds.
[  246.813483]       Tainted: G        W         4.17.0-rc5.mp_bvec_v5+ #508
[  246.814545] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.816350] kworker/u16:12  D    0   493      2 0x80000000
[  246.816359] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  246.816362] Call Trace:
[  246.816368]  ? __schedule+0x660/0x764
[  246.816370]  ? __accumulate_pelt_segments+0x29/0x3a
[  246.816372]  schedule+0x88/0x9b
[  246.816375]  blk_mq_freeze_queue_wait+0x5a/0x9d
[  246.816377]  ? wait_woken+0x6d/0x6d
[  246.816382]  nvme_wait_freeze+0x2d/0x3f [nvme_core]
[  246.816385]  nvme_pci_update_hw_ctx+0x36/0xa6 [nvme]
[  246.816389]  nvme_scan_work+0x42/0x234 [nvme_core]
[  246.816392]  ? check_preempt_curr+0x2a/0x63
[  246.816394]  ? ttwu_do_wakeup.isra.18+0x19/0x134
[  246.816395]  ? _raw_spin_unlock_irqrestore+0x20/0x31
[  246.816397]  ? try_to_wake_up+0x311/0x39e
[  246.816399]  process_one_work+0x18f/0x2e6
[  246.816402]  worker_thread+0x1e3/0x2ab
[  246.816404]  ? rescuer_thread+0x293/0x293
[  246.816406]  kthread+0x113/0x11b
[  246.816407]  ? kthread_create_on_node+0x62/0x62
[  246.816409]  ret_from_fork+0x35/0x40


Thanks,
Ming
