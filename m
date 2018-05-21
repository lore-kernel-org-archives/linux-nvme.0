From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 21 May 2018 08:40:00 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <eb85e457-7f90-fce4-9d1b-bd3471f6b396@kernel.dk>
References: <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
 <20180518212849.GB31490@localhost.localdomain>
 <266ee916-b86a-c499-20ff-98cf716059b5@kernel.dk>
 <20180518214857.GC31490@localhost.localdomain>
 <6ca20e7c-0a0a-6dc4-e2d4-012b63a7ad0d@kernel.dk>
 <20180521142305.GD5528@localhost.localdomain>
 <eb85e457-7f90-fce4-9d1b-bd3471f6b396@kernel.dk>
Message-ID: <20180521144000.GF5528@localhost.localdomain>

On Mon, May 21, 2018@08:33:21AM -0600, Jens Axboe wrote:
> Just saw the pull, was writing the below. If you can ack/review it,
> then I'll queue it on top.

Oops, sorry about that.
 
> You forgot to fold the poll fix... Here it is as a separate patch, or
> fold it with "nvme-pci: handle completions outside of the queue lock"
> and kill the last section in the commit message on cqe_seen.
> 
> From: Jens Axboe <axboe at kernel.dk>
> Subject: [PATCH] nvme-pci: fix race between poll and IRQ completions
> 
> If polling completions are racing with the IRQ triggered by a
> completion, the IRQ handler will find no work and return IRQ_NONE.
> This can trigger complaints about spurious interrupts:
> 
> [  560.169153] irq 630: nobody cared (try booting with the "irqpoll" option)
> [  560.175988] CPU: 40 PID: 0 Comm: swapper/40 Not tainted 4.17.0-rc2+ #65
> [  560.175990] Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.00.01.0010.010920180151 01/09/2018
> [  560.175991] Call Trace:
> [  560.175994]  <IRQ>
> [  560.176005]  dump_stack+0x5c/0x7b
> [  560.176010]  __report_bad_irq+0x30/0xc0
> [  560.176013]  note_interrupt+0x235/0x280
> [  560.176020]  handle_irq_event_percpu+0x51/0x70
> [  560.176023]  handle_irq_event+0x27/0x50
> [  560.176026]  handle_edge_irq+0x6d/0x180
> [  560.176031]  handle_irq+0xa5/0x110
> [  560.176036]  do_IRQ+0x41/0xc0
> [  560.176042]  common_interrupt+0xf/0xf
> [  560.176043]  </IRQ>
> [  560.176050] RIP: 0010:cpuidle_enter_state+0x9b/0x2b0
> [  560.176052] RSP: 0018:ffffa0ed4659fe98 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
> [  560.176055] RAX: ffff9527beb20a80 RBX: 000000826caee491 RCX: 000000000000001f
> [  560.176056] RDX: 000000826caee491 RSI: 00000000335206ee RDI: 0000000000000000
> [  560.176057] RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000008
> [  560.176059] R10: ffffa0ed4659fe78 R11: 0000000000000001 R12: ffff9527beb29358
> [  560.176060] R13: ffffffffa235d4b8 R14: 0000000000000000 R15: 000000826caed593
> [  560.176065]  ? cpuidle_enter_state+0x8b/0x2b0
> [  560.176071]  do_idle+0x1f4/0x260
> [  560.176075]  cpu_startup_entry+0x6f/0x80
> [  560.176080]  start_secondary+0x184/0x1d0
> [  560.176085]  secondary_startup_64+0xa5/0xb0
> [  560.176088] handlers:
> [  560.178387] [<00000000efb612be>] nvme_irq [nvme]
> [  560.183019] Disabling IRQ #630
> 
> A previous commit removed ->cqe_seen that was handling this case,
> but we need to handle this a bit differently due to completions
> now running outside the queue lock. Return IRQ_HANDLED from the
> IRQ handler, if the completion ring head was moved since we last
> saw it.
> 
> Fixes: 5cb525c8315f ("nvme-pci: handle completions outside of the queue lock")
> Reported-by: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Reviewed-by: Keith Busch <keith.busch at intel.com>
Tested-by: Keith Busch <keith.busch at intel.com>
