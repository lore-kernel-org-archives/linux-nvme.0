From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 15 May 2018 01:46:49 +0300
Subject: Cannot Connect NVMeoF At Certain NR_IO_Queues Values
In-Reply-To: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>
Message-ID: <743c4b33-2bf8-7c76-95af-62043c2aaeeb@mellanox.com>

Hi Joseph,


On 5/14/2018 8:46 PM, Gruher, Joseph R wrote:
> I'm running Ubuntu 18.04 with the included 4.15.0 kernel and Mellanox CX4 NICs and Intel P4800X SSDs.  I'm using NVMe-CLI v1.5 and nvmetcli v0.6.
> 
> I am getting a connect failure even at a relatively moderate nr_io_queues value such as 8:
> 
> rsa at tppjoe01:~$ sudo nvme connect -t rdma -a 10.6.0.16 -i 8 -n NQN1
> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> 
> However, it works just fine if I use a smaller value, such as 4:
> 
> rsa at tppjoe01:~$ sudo nvme connect -t rdma -a 10.6.0.16 -i 4 -n NQN1
> rsa at tppjoe01:~$
> 
> Target side dmesg from a failed attached with -i 8:
> 
> [425470.899691] nvmet: creating controller 1 for subsystem NQN1 for NQN nqn.2014-08.org.nvmexpress:uuid:8d0ac789-9136-4275-a46c-8d1223c8fe84.
> [425471.081358] nvmet: adding queue 1 to ctrl 1.
> [425471.081563] nvmet: adding queue 2 to ctrl 1.
> [425471.081758] nvmet: adding queue 3 to ctrl 1.
> [425471.110059] nvmet_rdma: freeing queue 3
> [425471.110946] nvmet_rdma: freeing queue 1
> [425471.111905] nvmet_rdma: freeing queue 2
> [425471.382128] nvmet_rdma: freeing queue 4
> [425471.522836] nvmet_rdma: freeing queue 5
> [425471.640105] nvmet_rdma: freeing queue 7
> [425471.669427] nvmet_rdma: freeing queue 6
> [425471.670107] nvmet_rdma: freeing queue 0
> [425471.692922] nvmet_rdma: freeing queue 8
> 
> Initiator side dmesg from same attempt:
> 
> [862316.209664] nvme nvme1: creating 8 I/O queues.
> [862316.391411] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
> [862316.406271] nvme nvme1: failed to connect queue: 4 ret=-18

IMO this issue was fixed in mlx5_core function mlx5_get_vector_affinity.
It was a long discussion regarding this fix and it will be fixed again 
in 4.17. After the final fix, it should go to stable kernel as well.
Meanwhile I can suggest a fast workaround for you if needed (or other 
solutions as well):

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0f840ec..dd92cb9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2236,7 +2236,7 @@ static int nvme_rdma_map_queues(struct 
blk_mq_tag_set *set)
         .init_hctx      = nvme_rdma_init_hctx,
         .poll           = nvme_rdma_poll,
         .timeout        = nvme_rdma_timeout,
-       .map_queues     = nvme_rdma_map_queues,
  };



-Max.
