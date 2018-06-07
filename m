From: yi.zhang@redhat.com (Yi Zhang)
Date: Thu, 7 Jun 2018 11:20:08 +0800
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <be1b6056-1da6-9902-749e-fed9b1cc2fc1@mellanox.com>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
 <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
 <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>
 <1952603032.5635954.1528044389779.JavaMail.zimbra@redhat.com>
 <CACVXFVM4JAYd79EPMBNg_0NcMg+y2_6s+UcDBgt_8GsEXb-vWA@mail.gmail.com>
 <1dd52330-93db-a89a-e1d8-fbda9060d2bd@redhat.com>
 <be1b6056-1da6-9902-749e-fed9b1cc2fc1@mellanox.com>
Message-ID: <61f70436-dc1c-2176-4f38-9b789e4d096b@redhat.com>


On 06/06/2018 05:48 PM, Max Gurtovoy wrote:
>
>
> On 6/6/2018 11:32 AM, Yi Zhang wrote:
>> Hi Ming
>>
>> I just tried 4.17.0 + Isreal's patch, but with bad luck, still can 
>> reproduce the issue bellow.
>
> can you try Israel's patch + Christoph's "drop abort sequence, kill 
> BLK_EH_HANDLED" series ?
Hi Max
Still can reproduce the target " keep-alive timer (15 seconds) expired" 
and host IO blocked issue.
Here is the log:
Target:
[? 356.473764] nvmet: creating controller 1 for subsystem testnqn for 
NQN nqn.2014-08.org.nvmexpress:uuid:95d13919-162e-48e4-8f00-da8a15ba7522.
[? 359.298784] nvmet: creating controller 1 for subsystem testnqn for 
NQN nqn.2014-08.org.nvmexpress:uuid:95d13919-162e-48e4-8f00-da8a15ba7522.
[? 374.408151] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[? 374.416204] nvmet: ctrl 1 fatal error occurred!
Host:
[? 390.853777] nvme nvme0: creating 40 I/O queues.
[? 393.660763] nvme nvme0: Property Set error: 7, offset 0x14
[? 393.713160] nvme nvme0: creating 40 I/O queues.
[? 615.429133] INFO: task kworker/u82:0:21 blocked for more than 120 
seconds.
[? 615.437464]?????? Not tainted 4.17.0-rc4.test+ #1
[? 615.443243] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.452517] kworker/u82:0?? D??? 0??? 21????? 2 0x80000000
[? 615.459184] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work 
[nvme_rdma]
[? 615.467406] Call Trace:
[? 615.470682]? ? __schedule+0x290/0x870
[? 615.475306]? ? select_task_rq_fair+0x9dd/0xce0
[? 615.480812]? schedule+0x32/0x80
[? 615.484858]? schedule_timeout+0x1d8/0x300
[? 615.489872]? ? blk_finish_plug+0x27/0x40
[? 615.494787]? wait_for_completion+0x123/0x190
[? 615.500091]? ? wake_up_q+0x70/0x70
[? 615.504426]? flush_work+0x11a/0x1a0
[? 615.508849]? ? wake_up_worker+0x30/0x30
[? 615.513664]? nvme_stop_ctrl+0x37/0x60 [nvme_core]
[? 615.519442]? nvme_rdma_reset_ctrl_work+0x22/0xb0 [nvme_rdma]
[? 615.526294]? process_one_work+0x158/0x360
[? 615.531299]? worker_thread+0x1cf/0x3e0
[? 615.536005]? kthread+0xf8/0x130
[? 615.540036]? ? max_active_store+0x80/0x80
[? 615.545035]? ? kthread_bind+0x10/0x10
[? 615.549647]? ret_from_fork+0x35/0x40
[? 615.554174] INFO: task kworker/u81:8:673 blocked for more than 120 
seconds.
[? 615.562478]?????? Not tainted 4.17.0-rc4.test+ #1
[? 615.568261] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.577554] kworker/u81:8?? D??? 0?? 673????? 2 0x80000000
[? 615.584234] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[? 615.590806] Call Trace:
[? 615.594087]? ? __schedule+0x290/0x870
[? 615.598725]? schedule+0x32/0x80
[? 615.602777]? schedule_preempt_disabled+0xa/0x10
[? 615.608384]? __mutex_lock.isra.7+0x1cd/0x510
[? 615.613698]? ? bdget+0x3f/0x140
[? 615.617745]? revalidate_disk+0x47/0x80
[? 615.622474]? nvme_validate_ns+0x49/0x7c0 [nvme_core]
[? 615.628563]? ? wake_up_q+0x70/0x70
[? 615.632903]? ? __blk_mq_free_request+0x6d/0x80
[? 615.638407]? nvme_scan_work+0x2f4/0x3b0 [nvme_core]
[? 615.644400]? process_one_work+0x158/0x360
[? 615.649422]? worker_thread+0x47/0x3e0
[? 615.654041]? kthread+0xf8/0x130
[? 615.658086]? ? max_active_store+0x80/0x80
[? 615.663096]? ? kthread_bind+0x10/0x10
[? 615.667717]? ret_from_fork+0x35/0x40
[? 615.672237] INFO: task kworker/u81:9:674 blocked for more than 120 
seconds.
[? 615.680553]?????? Not tainted 4.17.0-rc4.test+ #1
