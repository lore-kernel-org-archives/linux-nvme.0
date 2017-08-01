From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 1 Aug 2017 15:58:10 +0300
Subject: Bug Report: can't unload nvme module in case of disabled device
Message-ID: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>

Hi all,

I would like to report a bug that reproduced by the following steps (I'm 
using 4.13.0-rc3+):

1. modprobe nvme
2. echo 0 >  /sys/block/nvme0n1/device/device/enable
3. nvme list (stuck for more than 1-2 mins)
4. modprobe -r nvme (stuck forever)

log:

[ 1342.388888] nvme nvme0: controller is down; will reset: CSTS=0x3, 
PCI_STATUS=0x10
[ 1476.021392] INFO: task kworker/u98:1:436 blocked for more than 120 
seconds.
[ 1476.029072]       Not tainted 4.13.0-rc3+ #19
[ 1476.033878] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1476.042505] kworker/u98:1   D    0   436      2 0x00000000
[ 1476.048569] Workqueue: nvme-wq nvme_reset_work [nvme]
[ 1476.054133] Call Trace:
[ 1476.056862]  __schedule+0x1dc/0x780
[ 1476.060706]  schedule+0x36/0x80
[ 1476.064180]  blk_mq_freeze_queue_wait+0x4b/0xb0
[ 1476.069175]  ? remove_wait_queue+0x60/0x60
[ 1476.073693]  nvme_wait_freeze+0x33/0x50 [nvme_core]
[ 1476.079068]  nvme_reset_work+0x6b9/0xc40 [nvme]
[ 1476.084075]  ? __switch_to+0x23e/0x4a0
[ 1476.088209]  process_one_work+0x149/0x360
[ 1476.092625]  worker_thread+0x4d/0x3c0
[ 1476.096692]  kthread+0x109/0x140
[ 1476.100247]  ? rescuer_thread+0x380/0x380
[ 1476.104664]  ? kthread_park+0x60/0x60
[ 1476.108698]  ret_from_fork+0x25/0x30



[ 1598.901883] INFO: task kworker/u98:1:436 blocked for more than 120 
seconds.
[ 1598.909557]       Not tainted 4.13.0-rc3+ #19
[ 1598.914362] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1598.923004] kworker/u98:1   D    0   436      2 0x00000000
[ 1598.929063] Workqueue: nvme-wq nvme_reset_work [nvme]
[ 1598.934637] Call Trace:
[ 1598.937348]  __schedule+0x1dc/0x780
[ 1598.941208]  schedule+0x36/0x80
[ 1598.944682]  blk_mq_freeze_queue_wait+0x4b/0xb0
[ 1598.949675]  ? remove_wait_queue+0x60/0x60
[ 1598.954189]  nvme_wait_freeze+0x33/0x50 [nvme_core]
[ 1598.959574]  nvme_reset_work+0x6b9/0xc40 [nvme]
[ 1598.964580]  ? __switch_to+0x23e/0x4a0
[ 1598.968723]  process_one_work+0x149/0x360
[ 1598.973192]  worker_thread+0x4d/0x3c0
[ 1598.977240]  kthread+0x109/0x140
[ 1598.980797]  ? rescuer_thread+0x380/0x380
[ 1598.985226]  ? kthread_park+0x60/0x60
[ 1598.989262]  ret_from_fork+0x25/0x30
[ 1721.782347] INFO: task kworker/u98:1:436 blocked for more than 120 
seconds.
[ 1721.790026]       Not tainted 4.13.0-rc3+ #19
[ 1721.795326] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.804425] kworker/u98:1   D    0   436      2 0x00000000
[ 1721.810958] Workqueue: nvme-wq nvme_reset_work [nvme]
[ 1721.816999] Call Trace:
[ 1721.820161]  __schedule+0x1dc/0x780
[ 1721.824470]  schedule+0x36/0x80
[ 1721.828389]  blk_mq_freeze_queue_wait+0x4b/0xb0
[ 1721.833835]  ? remove_wait_queue+0x60/0x60
[ 1721.838781]  nvme_wait_freeze+0x33/0x50 [nvme_core]
[ 1721.844596]  nvme_reset_work+0x6b9/0xc40 [nvme]
[ 1721.850208]  ? __switch_to+0x23e/0x4a0
[ 1721.854756]  process_one_work+0x149/0x360
[ 1721.859606]  worker_thread+0x4d/0x3c0
[ 1721.864035]  kthread+0x109/0x140
[ 1721.867985]  ? rescuer_thread+0x380/0x380
[ 1721.872805]  ? kthread_park+0x60/0x60
[ 1721.877222]  ret_from_fork+0x25/0x30
[ 1721.881589] INFO: task modprobe:12986 blocked for more than 120 seconds.

Any thoughts ?

-Max.
