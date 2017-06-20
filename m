From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Jun 2017 09:33:54 +0300
Subject: Need help to get more information about "nvme_rdma: nvme
 completion status=0x4007"
In-Reply-To: <E3337C871CE37647B0ADF42B0154198F02E458D9@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <E3337C871CE37647B0ADF42B0154198F02E458D9@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <6dbff2f9-13bd-42cd-db1a-2e1c4219fb04@grimberg.me>


> Using the standard 4.8.1 nvme-rdma model to do the NVMf testing. Always hit by 0x4007 in the host side for stress testing.
> Check the 0x4007 define as: command abort. This command will generate by NVMe SSD on the target side and pass to host.

Do you mean kernel 4.8.1?

Any chance to test with latest upstream kernel? We try our best to
backport stable fixes but no one is assigned to make sure that stable
kernels actually work.

> Anyone encounter similar error during the NVMf stress testing, need your insight about why we have this error, the SSD been confirmed good when this host failed by 0x4007.  Is any exist known bug of Host nvme driver related to this ?
> 
> Thanks
> TJ
> 
> [  741.511259] nvme nvme0: queue_size 64 > ctrl maxcmd 1, clamping down
> [  741.511263] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 12.12.12.12:4420
> [  746.611906] nvme nvme0: Device shutdown incomplete; abort shutdown

Seems like the target is not responding to shutdown.

> [  752.659261] nvme_rdma: param.responder_resources: 16
> [  752.666421] nvme nvme0: creating 4 I/O queues.

That is strange, why is a discovery controller is creating I/O queues?
Could it be that a fix in this area has missed stable?

> [  752.667527] nvme_rdma: param.responder_resources: 16
> [  752.669024] nvme_rdma: param.responder_resources: 16
> [  752.670375] nvme_rdma: param.responder_resources: 16
> [  752.671740] nvme_rdma: param.responder_resources: 16

I assume these are your prints?

> [  752.700869] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.test", addr 12.12.12.12:4420
> [ 8226.418141] perf: interrupt took too long (2515 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
> [10909.246852] perf: interrupt took too long (3153 > 3143), lowering kernel.perf_event_max_sample_rate to 63000
> [14408.023327] nvme_rdma: nvme completion status=0x4007

This appears to be the target failing the command from what it received
from its backend device. Can you please atach the target log?
