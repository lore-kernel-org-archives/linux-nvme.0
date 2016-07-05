From: m.mizuma@jp.fujitsu.com (Masayoshi Mizuma)
Date: Tue, 5 Jul 2016 17:25:48 +0900
Subject: WARN_ON hit on __blk_mq_run_hw_queue followed by an Oops
In-Reply-To: <87wplqij40.fsf@linux.vnet.ibm.com>
References: <87wplqij40.fsf@linux.vnet.ibm.com>
Message-ID: <577B6F0C.4010506@jp.fujitsu.com>

  

On Wed, 15 Jun 2016 12:09:51 -0300 Gabriel Krisman Bertazi wrote:
> Hi,
>
> While doing stress test on a nvme device at the same time we offlined
> some cores to change the SMT configuration in a Power box, we started
> hitting this WARN_ON in __blk_mq_run_hw_queue:
>
> WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask));
>
> We can easily reproduce this by disabling a few CPUs via sysfs, while
> doing intensive IO to the device.  We start getting warnings like this:
>
> [  271.372565] WARNING: CPU: 0 PID: 7501 at ../block/blk-mq.c:739 __blk_mq_run_hw_queue+0x98/0x490
> [  271.643816] CPU: 0 PID: 7501 Comm: kworker/28:1H Tainted: G        W       4.7.0-rc2.mainline+ #10
> [  271.675180] Workqueue: kblockd blk_mq_run_work_fn
> [  271.700182] task: c0000078cda45800 ti: c0000078ce794000 task.ti: c0000078ce794000
> [  271.713909] NIP: c000000000568b68 LR: c0000000000eb6d0 CTR: c000000000569460
> [  271.732379] REGS: c0000078ce7978d0 TRAP: 0700   Tainted: G        W        (4.7.0-rc2.mainline+)
> [  271.753510] MSR: 900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24002824  XER: 20000000
> [  271.872673] CFAR: c000000000569498 SOFTE: 1
> [  272.052782] NIP [c000000000568b68] __blk_mq_run_hw_queue+0x98/0x490
> [  272.072649] LR [c0000000000eb6d0] process_one_work+0x1e0/0x590
> [  272.093302] Call Trace:
> [  272.093322] [c0000078ce797b50] [c000000000568d94] __blk_mq_run_hw_queue+0x2c4/0x490 (unreliable)
> [  272.144296] [c0000078ce797c50] [c0000000000eb6d0] process_one_work+0x1e0/0x590
> [  272.152311] [c0000078ce797ce0] [c0000000000ebdb0] worker_thread+0x330/0x660
> [  272.175452] [c0000078ce797d80] [c0000000000f4690] kthread+0x110/0x130
> [  272.196932] [c0000078ce797e30] [c000000000009570] ret_from_kernel_thread+0x5c/0x6c
> [  272.222188] Instruction dump:
> [  272.222218] 391e0188 eb1e0298 fb810088 fac10078 a12d0008 792ad182 792906a0 794a1f24
> [  272.266424] 7d48502a 7d494c36 792907e0 69290001 <0b090000> e93e0080 792a07e1 40820320
> [  272.310400] ---[ end trace b9ad111e6335f7e6 ]---

Is this WARN_ON still appear in 4.7-rc6 ?
If so, the following patch may fix this problem.

http://lists.infradead.org/pipermail/linux-nvme/2016-July/005303.html

The patch is a part of series of the following.

http://lists.infradead.org/pipermail/linux-nvme/2016-July/005294.html

- Masayoshi Mizuma

>
> Eventually, if we keep stressing the SMT settings, we hit an Oops for a
> bad memory access, in __blk_mq_complete_request, coming from the IRQ
> path of the nvme device.  the Oops happens because of a NULL
> dereference, since the request_queue pointer of the request (rq->q) is
> NULL.
>
> Sorry I don't have the full log of the Oops, it got truncated with other
> output.  But the stack trace is as follows:
>
> 58:mon> e
> cpu 0x58: Vector: 300 (Data Access) at [c000007fff4aba80]
>      pc: c000000000567e30: __blk_mq_complete_request+0x30/0x1b0
>      lr: d000000035d30714: __nvme_process_cq+0xb4/0x230 [nvme]
>      sp: c000007fff4abd00
>     msr: 9000000000009033
>     dar: b0
>   dsisr: 40000000
>    current = 0xc0000073de79e400
>    paca    = 0xc000000002c01800   softe: 0        irq_happened: 0x01
>      pid   = 3199, comm = aio-stress
> Linux version 4.7.0-rc2.mainline+ (root at iod76) (gcc version 5.3.1 20160413 (Ubuntu/IBM 5.3.1-14ubuntu2.1) ) #10 SMP Mon Jun 13 13:12:59 CDT 2016
> 58:mon> t
> [c000007fff4abd40] d000000035d30714 __nvme_process_cq+0xb4/0x230 [nvme]
> [c000007fff4abde0] d000000035d3097c nvme_irq+0x3c/0xb0 [nvme]
> [c000007fff4abe10] c000000000140690 handle_irq_event_percpu+0xa0/0x310
> [c000007fff4abed0] c000000000140968 handle_irq_event+0x68/0xc0
> [c000007fff4abf00] c000000000145d0c handle_fasteoi_irq+0xec/0x2a0
> [c000007fff4abf30] c00000000013f744 generic_handle_irq+0x54/0x80
> [c000007fff4abf60] c000000000011290 __do_irq+0x80/0x1d0
> [c000007fff4abf90] c000000000024f70 call_do_irq+0x14/0x24
> [c000007887457540] c000000000011478 do_IRQ+0x98/0x140
> [c000007887457590] c000000000002594 hardware_interrupt_common+0x114/0x180
> --- Exception: 501 (Hardware Interrupt) at c000000000068800 __copy_tofrom_user_power7+0x3ec/0x7cc
> [c000007887457980] c0000000005b56dc iov_iter_copy_from_user_atomic+0xac/0x2b0
> [c0000078874579d0] c00000000024431c generic_perform_write+0x13c/0x280
> [c000007887457a70] c000000000246650 __generic_file_write_iter+0x200/0x240
> [c000007887457ad0] c0000000003d5ff4 ext4_file_write_iter+0x284/0x430
> [c000007887457b90] c000000000385b50 aio_run_iocb+0x350/0x3e0
> [c000007887457ce0] c000000000387548 do_io_submit+0x368/0x750
> [c000007887457e30] c000000000009204 system_call+0x38/0xec
> --- Exception: c01 (System Call) at 00003fff99720818
> SP (3fff91cce4d0) is in userspace
>
> I've been working on this for a while now, but I haven't really gone
> anywhere, given I'm still very unfamiliar with the block layer.  My
> current understanding is that the Oops and the Warning are unrelated,
> even though they are both triggered by the same condition (SMT changes
> plus IO stress).
>
> At this point, I could use some help from you guys, whether you have
> ever observed a similar issue on x86, or any debugging suggestions.  I'm
> currently looking to understand why the thread was scheduled for the
> wrong core.
>
> Thanks,
>
