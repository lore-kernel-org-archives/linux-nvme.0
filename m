From: jie.tang@xilinx.com (Jie Tang)
Date: Tue, 20 Jun 2017 02:14:41 +0000
Subject: Need help to get more information about "nvme_rdma: nvme completion
 status=0x4007"
Message-ID: <E3337C871CE37647B0ADF42B0154198F02E458D9@XAP-PVEXMBX02.xlnx.xilinx.com>

Using the standard 4.8.1 nvme-rdma model to do the NVMf testing. Always hit by 0x4007 in the host side for stress testing.
Check the 0x4007 define as: command abort. This command will generate by NVMe SSD on the target side and pass to host.

Anyone encounter similar error during the NVMf stress testing, need your insight about why we have this error, the SSD been confirmed good when this host failed by 0x4007.  Is any exist known bug of Host nvme driver related to this ?

Thanks
TJ

[  741.511259] nvme nvme0: queue_size 64 > ctrl maxcmd 1, clamping down
[  741.511263] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 12.12.12.12:4420
[  746.611906] nvme nvme0: Device shutdown incomplete; abort shutdown
[  752.659261] nvme_rdma: param.responder_resources: 16
[  752.666421] nvme nvme0: creating 4 I/O queues.
[  752.667527] nvme_rdma: param.responder_resources: 16
[  752.669024] nvme_rdma: param.responder_resources: 16
[  752.670375] nvme_rdma: param.responder_resources: 16
[  752.671740] nvme_rdma: param.responder_resources: 16
[  752.700869] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.test", addr 12.12.12.12:4420
[ 8226.418141] perf: interrupt took too long (2515 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
[10909.246852] perf: interrupt took too long (3153 > 3143), lowering kernel.perf_event_max_sample_rate to 63000
[14408.023327] nvme_rdma: nvme completion status=0x4007
[14408.023333] blk_update_request: I/O error, dev nvme0n7, sector 2244579880
[14408.023344] nvme_rdma: nvme completion status=0x4007
[14408.023345] nvme_rdma: nvme completion status=0x4007
[14408.023347] nvme_rdma: nvme completion status=0x4007
[14408.023348] nvme_rdma: nvme completion status=0x4007
[14408.023350] blk_update_request: I/O error, dev nvme0n6, sector 2253649344
[14408.023352] blk_update_request: I/O error, dev nvme0n8, sector 2245553720
[14408.023352] blk_update_request: I/O error, dev nvme0n7, sector 2244580040
[14408.023357] blk_update_request: I/O error, dev nvme0n5, sector 2224823152
[14408.023358] nvme_rdma: nvme completion status=0x4007
[14408.023358] nvme_rdma: nvme completion status=0x4007
[14408.023359] nvme_rdma: nvme completion status=0x4007



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
