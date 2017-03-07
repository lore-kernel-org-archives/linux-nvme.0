From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 Mar 2017 11:35:16 +0200
Subject: Fail to configure NVMe-fabric over soft-RoCE
In-Reply-To: <d3b98e03-47fb-defc-baf5-d845e0c34919@linux.vnet.ibm.com>
References: <d3b98e03-47fb-defc-baf5-d845e0c34919@linux.vnet.ibm.com>
Message-ID: <801e400e-d940-eb37-62c3-8a9d42f39fd9@mellanox.com>

adding Moni.

Youngjae Lee,

did you run some basic rdma tests before NVMEoF ?
This is a precondition.

Moni,
please advise.

Max.

On 3/7/2017 1:19 AM, Youngjae Lee wrote:
> Hi, all
>
> Has anyone succeeded to configure NVMe over Fabrics with soft-RoCE (rxe) ?
> I'm trying it with the latest rc kernel (4.11.0-rc1), but the discover
> operation (of nvme-cli) on the client side fails. (please see the
> attached nvme-cli/dmesg logs below..)
>
> I'm following the instructions from this page to configure it.
> https://community.mellanox.com/docs/DOC-2504
> A NVMe target seems to be perfectly set up on the target server side.
>
> Dmesg log on the target server,
> [ 5574.892787] nvmet: adding nsid 10 to subsystem test
> [ 5574.897461] nvmet_rdma: enabling port 1 (10.1.1.17:1023)
> [ 5612.369855] nvmet: creating controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN
> nqn.2014-08.org.nvmexpress:NVMf:uuid:15b61008-8a88-4d7b-b9be-66600269a9e7.
> [ 5673.040744] nvmet_rdma: freeing queue 0
>
> nvme-cli output and dmesg log on the client,
> root at rxe2:~/nvme-cli# ./nvme discover -t rdma -a 10.1.1.17 -s 1023
> Failed to write to /dev/nvme-fabrics: Input/output error
>
> [  386.091648] rdma_rxe: qp#17 moved to error state
> [  446.756855] nvme nvme0: Identify Controller failed (16391)
>
> I enabled debug msgs of rdma_rxe to see what happened in rdma_rxe and it
> looks like there were some errors in rdma communications during the nvme
> discover operation.
> ....
> [ 8908.806021] rdma_rxe: qp#17 state = GET_REQ
> [ 8908.806022] rdma_rxe: qp#17 state = CHK_PSN
> [ 8908.806023] rdma_rxe: qp#17 state = CHK_OP_SEQ
> [ 8908.806025] rdma_rxe: qp#17 state = CHK_OP_VALID
> [ 8908.806026] rdma_rxe: qp#17 state = CHK_RESOURCE
> [ 8908.806028] rdma_rxe: qp#17 state = CHK_LENGTH
> [ 8908.806030] rdma_rxe: qp#17 state = CHK_RKEY
> [ 8908.806033] rdma_rxe: qp#17 state = ERR_LENGTH
> [ 8908.806035] rdma_rxe: qp#17 state = COMPLETE
> [ 8908.806036] rdma_rxe: qp#17 state = CLEANUP
> [ 8908.806037] rdma_rxe: qp#17 state = DONE
> [ 8908.806039] rdma_rxe: qp#17 state = ERROR
> [ 8908.806040] rdma_rxe: qp#17 moved to error state
> .....
>
> Any advice to resolve this issue ???
>
> Thanks.
>
> - Youngjae Lee
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
