From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 26 Dec 2018 18:25:13 +0800
Subject: [PATCH v2 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <1545624739-9848-1-git-send-email-shan.hai@oracle.com>
References: <1545624739-9848-1-git-send-email-shan.hai@oracle.com>
Message-ID: <20181226102512.GB32113@ming.t460p>

On Mon, Dec 24, 2018@12:12:18PM +0800, Shan Hai wrote:
> The num_possible_cpus() number of io queues by default would cause
> irq vector shortage problem on a large system when hotplugging cpus,
> add a module parameter to set number of io queues according to the
> system configuration to fix the issue.
> 
> Below is a log of CPU hotplug failure:
> 
> [  422.878400] WARNING: CPU: 94 PID: 0 at net/sched/sch_generic.c:334
> dev_watchdog+0x228/0x22c
> [  422.878522] CPU: 94 PID: 0 Comm: swapper/94 Not tainted
> [  422.878526] task: ffff9672c0c9bd80 task.stack: ffffa7b18c964000
> [  422.878533] RIP: 0010:dev_watchdog+0x228/0x22c
> [  422.878535] RSP: 0018:ffff96b13f583e58 EFLAGS: 00010246
> [  422.878539] RAX: 0000000000000040 RBX: 0000000000000005 RCX: 000000000000083f
> [  422.878541] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000083f
> [  422.878543] RBP: ffff96b13f583e88 R08: 0000000000000000 R09: 0000000000000db6
> [  422.878546] R10: 0000000000000004 R11: 0000000000000db5 R12: ffff967131c3dbc0
> [  422.878548] R13: ffff96713a714000 R14: 000000000000005e R15: 000000000000004a
> [  422.878551] FS:  0000000000000000(0000) GS:ffff96b13f580000(0000) knlGS:0000000000000000
> [  422.878554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  422.878556] CR2: 00007fbfcc2ca000 CR3: 0000006e7040a004 CR4: 00000000007606e0
> [  422.878559] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  422.878561] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  422.878563] PKRU: 55555554
> [  422.878564] Call Trace:
> [  422.878567]  <IRQ>
> [  422.878576]  ? dev_deactivate_queue.constprop.31+0x60/0x59
> [  422.878581]  ? dev_deactivate_queue.constprop.31+0x60/0x59
> [  422.878590]  call_timer_fn+0x3c/0x148
> [  422.878596]  ? dev_deactivate_queue.constprop.31+0x60/0x59
> [  422.878601]  run_timer_softirq+0x20d/0x48f
> [  422.878610]  ? tick_sched_handle+0x37/0x5f
> [  422.878616]  ? ktime_get+0x3e/0x95
> [  422.878627]  __do_softirq+0xd9/0x28d
> [  422.878639]  irq_exit+0xdf/0xe5
> [  422.878644]  smp_apic_timer_interrupt+0x91/0x155
> [  422.878649]  apic_timer_interrupt+0x1a2/0x1a7
> [  422.878652]  </IRQ>
> [  422.878660] RIP: 0010:cpuidle_enter_state+0xdd/0x2a5
> [  422.878662] RSP: 0018:ffffa7b18c967e68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [  422.878666] RAX: ffff96b13f5a2bc0 RBX: ffffc7b17fd85800 RCX: 000000000000001f
> [  422.878668] RDX: 0000000000000000 RSI: fffeb090fc6ad980 RDI: 0000000000000000
> [  422.878670] RBP: ffffa7b18c967ea0 R08: 0000000000008c35 R09: 000000000000c72f
> [  422.878672] R10: 000000000000c6de R11: 0000000000000018 R12: 0000000000000003
> [  422.878674] R13: 000000000000005e R14: ffffffff8756ebc0 R15: 00000062735ea43f
> [  422.878684]  ? cpuidle_enter_state+0xcc/0x2a5
> [  422.878690]  cpuidle_enter+0x17/0x19
> [  422.878698]  call_cpuidle+0x23/0x3a
> [  422.878702]  do_idle+0x172/0x1d5
> [  422.878698]  call_cpuidle+0x23/0x3a
> [  422.878702]  do_idle+0x172/0x1d5
> [  422.878708]  cpu_startup_entry+0x73/0x75
> [  422.878718]  start_secondary+0x1b9/0x208
> [  422.878736]  secondary_startup_64+0xa5/0xa5
> [  422.878738] Code: 60 04 00 00 eb 8f 4c 89 ef c6 05 d8 fb eb 00 01 e8 1e f4
> fc ff 89 d9 48 89 c2 4c 89 ee 48 c7 c7 b8 2f 26 87 31 c0 e8 8b c5 9b ff <0f>
> 0b eb bb 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41 57 49 89
> [  422.878758] ---[ end trace ee8cf33f8467fd66 ]---
> [  422.878761] bnxt_en 0000:46:00.0 enp70s0f0: TX timeout detected, starting
> reset task!
> [  423.795776] bnxt_en 0000:46:00.0 enp70s0f0: Resp cmpl intr err msg: 0x51
> [  423.803390] bnxt_en 0000:46:00.0 enp70s0f0: hwrm_ring_free type 1 failed.
> rc:ffffffff err:0
> [  424.671580] bnxt_en 0000:46:00.0 enp70s0f0: Resp cmpl intr err msg: 0x51
> [  424.679087] bnxt_en 0000:46:00.0 enp70s0f0: hwrm_ring_free type 1 failed.
> rc:ffffffff err:0
> [  425.562749] bnxt_en 0000:46:00.0 enp70s0f0: Resp cmpl intr err msg: 0x51
> 
> Signed-off-by: Shan Hai <shan.hai at oracle.com>
> ---
> 
> v1 -> v2:
> 	Add a cpu hotplug failure log
> 
>  drivers/nvme/host/pci.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c33bb20..0d60451 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -64,6 +64,16 @@ MODULE_PARM_DESC(sgl_threshold,
>  		"Use SGLs when average request segment size is larger or equal to "
>  		"this size. Use 0 to disable SGLs.");
>  
> +static int io_queue_number_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops io_queue_number_ops = {
> +	.set = io_queue_number_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int io_queue_number = UINT_MAX;
> +module_param_cb(io_queue_number, &io_queue_number_ops, &io_queue_number, 0644);
> +MODULE_PARM_DESC(io_queue_number, "set io queue number, should >= 2");
> +

I suggest to name it as 'default_queues', and 'queue_count_ops' can be
reused too, just like 'write_queues' and 'poll_queues'.


Thanks,
Ming
