From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 15:06:31 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <1526655155-4006-6-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
Message-ID: <20180518210630.GD27795@localhost.localdomain>

On Fri, May 18, 2018@08:52:33AM -0600, Jens Axboe wrote:
> Note that this kills the ->cqe_seen as well. I haven't been able to
> trigger any ill effects of this. If we do race with polling every so
> often, it should be rare enough NOT to trigger any issues.

Ah hell, running HIPRI tests on low latency devices is hitting spruious
interrupt detection:

[  560.169153] irq 630: nobody cared (try booting with the "irqpoll" option)
[  560.175988] CPU: 40 PID: 0 Comm: swapper/40 Not tainted 4.17.0-rc2+ #65
[  560.175990] Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.00.01.0010.010920180151 01/09/2018
[  560.175991] Call Trace:
[  560.175994]  <IRQ>
[  560.176005]  dump_stack+0x5c/0x7b
[  560.176010]  __report_bad_irq+0x30/0xc0
[  560.176013]  note_interrupt+0x235/0x280
[  560.176020]  handle_irq_event_percpu+0x51/0x70
[  560.176023]  handle_irq_event+0x27/0x50
[  560.176026]  handle_edge_irq+0x6d/0x180
[  560.176031]  handle_irq+0xa5/0x110
[  560.176036]  do_IRQ+0x41/0xc0
[  560.176042]  common_interrupt+0xf/0xf
[  560.176043]  </IRQ>
[  560.176050] RIP: 0010:cpuidle_enter_state+0x9b/0x2b0
[  560.176052] RSP: 0018:ffffa0ed4659fe98 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
[  560.176055] RAX: ffff9527beb20a80 RBX: 000000826caee491 RCX: 000000000000001f
[  560.176056] RDX: 000000826caee491 RSI: 00000000335206ee RDI: 0000000000000000
[  560.176057] RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000008
[  560.176059] R10: ffffa0ed4659fe78 R11: 0000000000000001 R12: ffff9527beb29358
[  560.176060] R13: ffffffffa235d4b8 R14: 0000000000000000 R15: 000000826caed593
[  560.176065]  ? cpuidle_enter_state+0x8b/0x2b0
[  560.176071]  do_idle+0x1f4/0x260
[  560.176075]  cpu_startup_entry+0x6f/0x80
[  560.176080]  start_secondary+0x184/0x1d0
[  560.176085]  secondary_startup_64+0xa5/0xb0
[  560.176088] handlers:
[  560.178387] [<00000000efb612be>] nvme_irq [nvme]
[  560.183019] Disabling IRQ #630
