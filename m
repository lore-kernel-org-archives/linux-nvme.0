From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:26:34 +0300
Subject: Host reconnecting need more than 60s to start after nvmetcli
 clear on target
In-Reply-To: <20170919141803.GA6216@infradead.org>
References: <506214967.5315130.1504869110572.JavaMail.zimbra@redhat.com>
 <402757886.5318604.1504871077415.JavaMail.zimbra@redhat.com>
 <20170918155822.GA9145@infradead.org>
 <1d56f10c-ca41-a594-9f88-8c8c5e2711a3@redhat.com>
 <20170919141803.GA6216@infradead.org>
Message-ID: <24514ea0-e301-fd38-9259-4e632ffb15ed@grimberg.me>


>>>> Hi
>>>>
>>>> I found this issue on latest 4.13, is it for designed?  I cannot reproduce it on 4.12.
>>>>
>>>> Here is the log from host:
>>>> 4.13
>>>> [  637.246798] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
>>>> [  637.436315] nvme nvme0: creating 40 I/O queues.
>>>> [  637.939988] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
>>>> [  645.319803] nvme nvme0: rescanning
>>>>
>>>> -->need more than 60 seconds to start reconnect
>>>>
>>>> [  706.073551] nvme nvme0: Reconnecting in 10 seconds...
>>> How did you initiate the reconnect?  Cable drop?
>>
>> Just execute "nvmetcli clear" on target side, and check the log on host
>> side.
> 
> Ok.  60 seconds is when the first commands will time out, so that's
> expected.   The NVMeoF protocol has no way to notify the host that
> a connection went away, so if you ren't on a protocol that supports
> link up/down notifications we'll have to wait for timeouts.

That's not entirely true.

Yes there is no clear indication, but the keep-alive should expire
faster than 60 seconds (it actually 5 seconds by default). The point
here is that its not really a cable pull, its removal of the subsystem
and the namespaces just before that trigger a rescan.

In rdma error recovery we first of all call nvme_stop_ctrl() which flush
the scan_work and that waits for the identify to exhaust (60 seconds
admin timeout). But in error recovery, we should really call full
stop_ctrl, we just need to stop the keep-alive so it will get out
of the way...

Does this fix your issue?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4460ec3a2c0f..2d2afb5e8102 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -966,7 +966,7 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
         struct nvme_rdma_ctrl *ctrl = container_of(work,
                         struct nvme_rdma_ctrl, err_work);

-       nvme_stop_ctrl(&ctrl->ctrl);
+       nvme_stop_keep_alive(ctrl);

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
--

This was the original code, I replaced it (incorrectly I think) when
introducing nvme_stop_ctrl.
