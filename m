From: mlin@kernel.org (Ming Lin)
Date: Thu, 9 Jun 2016 15:26:17 -0700
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
Message-ID: <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>

On Thu, Jun 9, 2016@2:06 PM, Steve Wise <swise@opengridcomputing.com> wrote:

> Yes, I get the same crash after reproducing it twice.  At least the RIP is exactly the same:
>
> get_next_timer_interrupt+0x183/0x210
>
> The rest of the stack looked a little different but still had tick_nohz stuff in it.
>
> Does this look correct ("freeing queue 17" twice)?
>
> nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:6e01fbc9-49fb-4998-9522-df85a95f9ff7.
> nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.1.14:4420
> nvmet_rdma: freeing queue 17
> nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:6e01fbc9-49fb-4998-9522-df85a95f9ff7.
> nvme nvme1: creating 16 I/O queues.
> rdma_rw_init_mrs: failed to allocated 128 MRs
> failed to init MR pool ret= -12
> nvmet_rdma: failed to create_qp ret= -12
> nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).
> nvme nvme1: Connect rejected, no private data.
> nvme nvme1: rdma_resolve_addr wait failed (-104).
> nvme nvme1: failed to initialize i/o queue: -104
> nvmet_rdma: freeing queue 17
> general protection fault: 0000 [#1] SMP

I'll get a Chelsio card to try.

What's the step to reproduce?
