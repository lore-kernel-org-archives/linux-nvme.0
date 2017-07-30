From: Victor.Gladkov@taec.toshiba.com (Victor Gladkov)
Date: Sun, 30 Jul 2017 16:31:45 +0000
Subject: [PATCH] nvme-rdma: "nvme disconnect" stuck after remove a target
Message-ID: <77FF42D3D537D24484F0BF5E2458C0C08507BCF3@EXMAIL1.taec.toshiba.com>

When host tries reconnect to deleted target, but port at the target side still exists, admin queue flags NVME_RDMA_Q_CONNECTED bit is sets into nvme_rdma_init_queue() routine and nvmf_connect_admin_queue() failed.
"nvme disconnect" command is stuck, because host is trying  shutdown controller over unconnected queue.

[  957.040236] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "target01"
[  957.040289] nvme nvme0: Failed reconnect attempt, requeueing...
[  967.280687] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "target01"
[  967.280740] nvme nvme0: Failed reconnect attempt, requeueing...
[ 1107.058745] INFO: task nvme:3802 blocked for more than 120 seconds.
[ 1107.058793]       Tainted: G           OE   4.9.28 #1
[ 1107.058829] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1107.058882] nvme            D    0  3802   3517 0x00000080
[ 1107.058888]  ffff88083a3a4d80 0000000000000000 ffff88085ba0ac00 ffff88085fc59380
[ 1107.058892]  ffff880856c58000 ffffc9000920fbd0 ffffffff816d6875 0000000000000000
[ 1107.058896]  ffffc9000920fbe0 ffffffff810c0d25 ffff880856c58000 7fffffffffffffff
[ 1107.058899] Call Trace:
[ 1107.058909]  [<ffffffff816d6875>] ? __schedule+0x195/0x630
[ 1107.058914]  [<ffffffff810c0d25>] ? check_preempt_wakeup+0x115/0x200
[ 1107.058917]  [<ffffffff816d6d46>] schedule+0x36/0x80
[ 1107.058920]  [<ffffffff816d9f5c>] schedule_timeout+0x21c/0x3a0
[ 1107.058925]  [<ffffffff810b0eef>] ? ttwu_do_activate+0x6f/0x80
[ 1107.058928]  [<ffffffff810b1999>] ? try_to_wake_up+0x59/0x380
[ 1107.058931]  [<ffffffff810b1999>] ? try_to_wake_up+0x59/0x380
[ 1107.058933]  [<ffffffff816d7822>] wait_for_completion+0xf2/0x130
[ 1107.058936]  [<ffffffff810b1d60>] ? wake_up_q+0x80/0x80
[ 1107.058941]  [<ffffffff8109e3c0>] flush_work+0x110/0x190
[ 1107.058944]  [<ffffffff8109c4b0>] ? destroy_worker+0x90/0x90
[ 1107.058951]  [<ffffffffa094e9c1>] nvme_rdma_del_ctrl+0x61/0x80 [nvme_rdma]
[ 1107.058959]  [<ffffffffa0922b8a>] nvme_sysfs_delete+0x2a/0x40 [nvme_core]
[ 1107.058965]  [<ffffffff81485138>] dev_attr_store+0x18/0x30
[ 1107.058971]  [<ffffffff812a1d4a>] sysfs_kf_write+0x3a/0x50
[ 1107.058974]  [<ffffffff812a187b>] kernfs_fop_write+0x10b/0x190
[ 1107.058978]  [<ffffffff812202e7>] __vfs_write+0x37/0x140
[ 1107.058984]  [<ffffffff81240931>] ? __fd_install+0x31/0xd0
[ 1107.058987]  [<ffffffff81221212>] vfs_write+0xb2/0x1b0
[ 1107.058992]  [<ffffffff81003510>] ? syscall_trace_enter+0x1d0/0x2b0
[ 1107.058995]  [<ffffffff81222665>] SyS_write+0x55/0xc0
[ 1107.058998]  [<ffffffff81003a47>] do_syscall_64+0x67/0x180
[ 1107.059001]  [<ffffffff816db4eb>] entry_SYSCALL64_slow_path+0x25/0x25


Scenario for reproduce the bug:
_____________________________________________
@target
	1. ./target_create_portal.sh 1 50.10.126.11 4420
	2. ./target_add.sh /dev/nvme1n1 target01 1
@host 
	3. nvme connect -t rdma -a 50.10.126.11 -s 4420 -n target01

@target
	4. ifdown enp136s0 
	5. Wait 10 sec for start reconnect on host
	6 ./target_release_all.sh target01
	7. ifup enp136s0
	8. ./target_create_portal.sh 1 50.10.126.11 4420
	9. ./target_add.sh /dev/nvme1n1 target02 1

@host 
	10. nvme disconnect -n target01

Result: "nvme disconnect" is stuck
_____________________________________________

PATCH: 

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3d25add..44316bc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1637,7 +1637,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
                nvme_rdma_free_io_queues(ctrl);
        }

-       if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
+       if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
                nvme_shutdown_ctrl(&ctrl->ctrl);

        blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
