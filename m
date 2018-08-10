From: jsmart2021@gmail.com (James Smart)
Date: Fri, 10 Aug 2018 16:04:19 -0700
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <1533934229.7802.149.camel@localhost.localdomain>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <1533934229.7802.149.camel@localhost.localdomain>
Message-ID: <40e676e2-4dc8-a419-52eb-ab2c4b30e62d@gmail.com>

On 8/10/2018 1:50 PM, Ewan D. Milne wrote:
> OK, so with this patch applied on the target, I'm seeing undesirable
> behavior on the NVMe/FC initiator side when the target is not configured.
> 
> Without this patch, if the NVMe/FC initiator and the NVMe/FC soft target
> are booted, but the target is not configured, an attempt to connect on
> the initiator via "nvme connect" will return from the CLI immediately,
> and the connection attempts will commence, e.g.:
> 
> [  191.233854] nvme nvme1: Connect Invalid Data Parameter, subsysnqn "testnqn"
> [  191.241650] nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> [  191.249421] nvme nvme1: NVME-FC{0}: Reconnect attempt in 10 seconds
> 
> then if I configure the target, it will connect.  Great.
> 
> [  241.612730] nvme nvme1: NVME-FC{0}: controller connect complete
> 
> --
> 
> However, with this patch applied on the target, the nvme-cli connect
> command on the intiator (with an unconfigured target) hangs:

ok - but I'd like to be very clear:  This has to be a case where the 
nvmet target wasn't configured since boot (thus you see the above, and 
will see the same with and without patch), then was configured, then 
wasn't (via a "nvmetcli clear").  In other words, I believe you only see 
this point if nvmetcli clears the config after there's been a prior 
binding with a fc port.

> 
> [ 1516.041039] nvme            D ffff942449a1e970     0  1850   1849 0x00000080
> [ 1516.048924] Call Trace:
> [ 1516.051650]  [<ffffffffa46e1a88>] ? enqueue_task_fair+0x208/0x6c0
> [ 1516.058451]  [<ffffffffa4d5fea9>] schedule+0x29/0x70
> [ 1516.063989]  [<ffffffffa4d5d7f1>] schedule_timeout+0x221/0x2d0
> [ 1516.070498]  [<ffffffffa46d1e2f>] ? ttwu_do_activate+0x6f/0x80
> [ 1516.077017]  [<ffffffffa46d55b0>] ? try_to_wake_up+0x190/0x390
> [ 1516.083525]  [<ffffffffa4d6025d>] wait_for_completion+0xfd/0x140
> [ 1516.090228]  [<ffffffffa46d5870>] ? wake_up_state+0x20/0x20
> [ 1516.096446]  [<ffffffffa46b902d>] flush_work+0xfd/0x190
> [ 1516.102276]  [<ffffffffa46b5e20>] ? move_linked_works+0x90/0x90
> [ 1516.108882]  [<ffffffffa46b92ef>] flush_delayed_work+0x3f/0x50
> [ 1516.115429]  [<ffffffffc00c0cbd>] nvme_fc_create_ctrl+0x72d/0x7a0 [nvme_fc]
> [ 1516.123201]  [<ffffffffc011c5b6>] nvmf_dev_write+0xa26/0xbef [nvme_fabrics]
> [ 1516.130981]  [<ffffffffa48f6307>] ? security_file_permission+0x27/0xa0
> [ 1516.138265]  [<ffffffffa483eba0>] vfs_write+0xc0/0x1f0
> [ 1516.143997]  [<ffffffffa483f9bf>] SyS_write+0x7f/0xf0
> [ 1516.149633]  [<ffffffffa4d6cdef>] system_call_fastpath+0x1c/0x21
> 
> [ 1508.006831] kworker/u384:3  D ffff94244dcad7e0     0   578      2 0x00000000
> [ 1508.014736] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
> [ 1508.021642] Call Trace:
> [ 1508.024368]  [<ffffffffa4d5fea9>] schedule+0x29/0x70
> [ 1508.029907]  [<ffffffffa4d5d738>] schedule_timeout+0x168/0x2d0
> [ 1508.036422]  [<ffffffffa46a83f0>] ? __internal_add_timer+0x130/0x130
> [ 1508.043515]  [<ffffffffa46ffc02>] ? ktime_get_ts64+0x52/0xf0
> [ 1508.049847]  [<ffffffffa4d5f3bd>] io_schedule_timeout+0xad/0x130
> [ 1508.056551]  [<ffffffffa4d603a5>] wait_for_completion_io_timeout+0x105/0x140
> [ 1508.064421]  [<ffffffffa46d5870>] ? wake_up_state+0x20/0x20
> [ 1508.070674]  [<ffffffffa494869b>] blk_execute_rq+0xab/0x150
> [ 1508.076897]  [<ffffffffc00cd8cf>] __nvme_submit_sync_cmd+0x6f/0xf0 [nvme_core]
> [ 1508.084958]  [<ffffffffc011b908>] nvmf_connect_admin_queue+0x128/0x1a0 [nvme_fabrics]
> [ 1508.093718]  [<ffffffffc00bfac0>] nvme_fc_create_association+0x3a0/0x9c0 [nvme_fc]
> [ 1508.102167]  [<ffffffffc00c00fe>] nvme_fc_connect_ctrl_work+0x1e/0x60 [nvme_fc]
> [ 1508.110323]  [<ffffffffa46b88af>] process_one_work+0x17f/0x440
> [ 1508.116831]  [<ffffffffa46b9a98>] worker_thread+0x278/0x3c0
> [ 1508.123050]  [<ffffffffa46b9820>] ? manage_workers.isra.24+0x2a0/0x2a0
> [ 1508.130333]  [<ffffffffa46c0a31>] kthread+0xd1/0xe0
> [ 1508.135774]  [<ffffffffa46c0960>] ? insert_kthread_work+0x40/0x40
> [ 1508.142574]  [<ffffffffa4d6cc37>] ret_from_fork_nospec_begin+0x21/0x21
> [ 1508.149859]  [<ffffffffa46c0960>] ? insert_kthread_work+0x40/0x40

I believe this to be the case which was added in v2 which has the 
transport abort the newly received command, as the abort should be the
notification back to the host.  And I'm guessing there's a bug in the 
lldd for the abort (assume lpfc?).

what doesn't make sense: this shouldn't be much different from the 
without patch case, as the port pointer in the fc port should be at
best stale and could be doing any number of things.

> 
> configuring the target does not help at this point.
> 
> I've haven't figured out exactly what is wrong yet, but thought I'd
> bring this up...
> 
> Clearly, separate from the target side issue, having the initiator hang
> regardless of what the target code is doing is a bad thing.  There's
> supposed to be an admin queue timeout, but it didn't work here.
> 
> -Ewan

I agree - the admin queue timeout should be what works around this as it 
would then have the host send it's own abort to recover. We do need to 
see why it didn't occur.

I'll put it through some additional testing and will post any findings.

-- james
