Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C17C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxSZyJJDxasZjgleP7MawZuWq3YRJZyQRGUQCGsVhFU=; b=fe8x6Iy9rxT9gIjn8CRUAjFj9e
	2yFoP94PmTwfclg6PbXHpReQf/6uULd+cCImksM3xNVQmgWHEYF+gfpfLbnD/lRxof2a2A0rpRyCs
	DvcpCVefjJqFAXlAn6WbPDSwmru4esvEfq/V07Zw5R6qTEnhydy/tK3t/4u5JAvALzGcNGkuShm9l
	FKnFfewFZFWzK6UCb40wHc7V/hlDim5tG1A5QftpwPvlhXmIwYBhe5ELATI7DpmDRLG/XLsSmkMB8
	q3IAGqgM4WQsNbuC9/+9Qo/o3qYFpd/lwmERRZphpK3LPCZmcFV/O5GMi3XaZFQnYmbCQV74IWQWf
	Sebyw8Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDpMh-000uJH-0g;
	Thu, 14 Dec 2023 17:19:15 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDpMe-000uIv-0b
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 17:19:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6E158B822EF;
	Thu, 14 Dec 2023 17:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B03EC433C7;
	Thu, 14 Dec 2023 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574349;
	bh=XIz+Sq2C2tDlbR/C7Waf67C3XvmYCZr8YkKnq+SbFEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5rd5C7MPAxC0yOHcPlW1FK+r+kNuWmPiQ7t9tx0YskU+ystnzfvZWstBIMgUToJU
	 Xh8cn83URg/4C+jzF7tqgMch/pUjIARFoGxJXUv0URJTDIGC2QzyOMnsIGQuYOiXyj
	 PDBG9ghRE5Ob+tD/MEYjPy/P3o3Yif1X9xQPJU5Ahl//fNbKH3CMt6kUUDJkzoSchJ
	 HQPrBt+NmTpillwq1nblo3ooIqSKxvrMimlbzO87cAd47mHyVzwz+c1q7WDKyOdfj9
	 IXnkBwoRBx55HwNrJpdScss1NE33fE9IiFLgLLARNDpNmczEpjoWdP1FmdxlB+vxWY
	 LKaDJnUu8J8LA==
Date: Thu, 14 Dec 2023 09:19:03 -0800
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: parallel nvme format
Message-ID: <ZXs5B8pYKTBLD1NH@kbusch-mbp>
References: <ZXsJdJxDXEbCmSec@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsJdJxDXEbCmSec@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_091912_505507_CE51D062 
X-CRM114-Status: GOOD (  33.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 14, 2023 at 01:56:05PM +0000, Niklas Cassel wrote:
> Hello guys,
> 
> We have observed the following on linux stable v6.6.x.
> 
> (We tried to backport commit 839a40d1e730 ("nvme: fix deadlock between reset
> and scan"), but it didn't fix the problem.)
> 
> 
> What happens is that we are formatting 8 different namespaces in parallel.
> 
> [Wed Nov 29 16:43:56 2023] INFO: task nvme:18411 blocked for more than 120 seconds.
> [Wed Nov 29 16:43:56 2023]       Not tainted 6.6.2 #1
> [Wed Nov 29 16:43:56 2023] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> +disables this message.
> [Wed Nov 29 16:43:56 2023] task:nvme            state:D stack:0     pid:18411
> +ppid:18405  flags:0x00004000
> [Wed Nov 29 16:43:56 2023] Call Trace:
> [Wed Nov 29 16:43:56 2023]  <TASK>
> [Wed Nov 29 16:43:56 2023]  __schedule+0x34a/0xef0
> [Wed Nov 29 16:43:56 2023]  ? preempt_count_add+0x7c/0xc0
> [Wed Nov 29 16:43:56 2023]  ? _raw_spin_lock_irqsave+0x29/0x60
> [Wed Nov 29 16:43:56 2023]  schedule+0x6b/0xf0
> [Wed Nov 29 16:43:56 2023]  schedule_timeout+0x233/0x290
> [Wed Nov 29 16:43:56 2023]  ? __timer_delete_sync+0x31/0x50   
> [Wed Nov 29 16:43:56 2023]  ? schedule_timeout+0x1a3/0x290
> [Wed Nov 29 16:43:56 2023]  wait_for_completion+0x8b/0x140
> [Wed Nov 29 16:43:56 2023]  __flush_work+0x139/0x240
> [Wed Nov 29 16:43:56 2023]  ? __pfx_wq_barrier_func+0x10/0x10
> [Wed Nov 29 16:43:56 2023]  flush_work+0x10/0x20
> [Wed Nov 29 16:43:56 2023]  nvme_passthru_end+0x60/0x170 [nvme_core]
> [Wed Nov 29 16:43:56 2023]  nvme_submit_user_cmd+0x162/0x170 [nvme_core]
> [Wed Nov 29 16:43:56 2023]  nvme_user_cmd.constprop.0+0x156/0x1d0 [nvme_core]
> [Wed Nov 29 16:43:56 2023]  nvme_dev_ioctl+0x12c/0x2a0 [nvme_core]
> [Wed Nov 29 16:43:56 2023]  __x64_sys_ioctl+0x95/0xd0
> [Wed Nov 29 16:43:56 2023]  do_syscall_64+0x38/0x90
> [Wed Nov 29 16:43:56 2023]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> flush_work() waits for more that 120 seconds on scan_work getting completed,
> but even after 120 seconds, scan_work hasn't completed.
> 
> Inspecting nvme_scan_work(), the only thing that can cause it to not return
> after 120 seconds, is if it is waiting on mutex_lock() to get the scan mutex.
> 
> 
> What appears to be happening is:
> 
> format command #1 completes and calls nvme_passthru_end(),
> nvme_passthru_end() calls:
> 
> mutex_unlock(&ctrl->scan_lock);
> ...
> nvme_queue_scan(ctrl);
> flush_work(&ctrl->scan_work);
> 
> 
> Directly after format command #1 unlocks the mutex,
> format command #2 will get the mutex in nvme_passthru_start().
> 
> Format command #2 will release the mutex in nvme_passthru_end(),
> but only after the format command has completed.
> 
> The default timeout for the nvme format command via nvme-cli is 600 seconds,
> so it is easy to imagine that the format command will take longer than 120
> seconds.
> 
> 
> So the scan work at the end of format command #1 will eventually get to run,
> but only after the second nvme format command has completed.
> (nvme_queue_scan() will finally be able to get the mutex, once
> nvme_passthru_end() for the second format command has released the mutex.)
> 
> 
> I don't think that formatting multiple namespaces in parallel is an
> unreasonable thing to do, so I do not think that we should scare our
> users with "hung task timeouts".
> 
> 
> 
> My first though was that perhaps we could do something like:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 46a4c9c5ea96..811d40cf23f6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1113,6 +1113,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>          * effects say only one namespace is affected.
>          */
>         if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
> +               flush_work(&ctrl->scan_work);
>                 mutex_lock(&ctrl->scan_lock);
>                 mutex_lock(&ctrl->subsys->lock);
>                 nvme_mpath_start_freeze(ctrl->subsys);
> 
> 
> But that will not work, because it will still have a race window between the
> time nvme_passthru_end() has unlocked the mutex, and before
> nvme_passthru_end() has queued the scan work.
> 
> I guess, in the case that nvme_passthru_end() has to perform a scan, we want
> to unlock the scan mutex after nvme_passthru_end() has performed the scan,
> but right now nvme_queue_scan() will acquire the mutex (and is running on the
> workqueue)...
> 
> Thoughts?

Hi Niklas!

Thanks for the report and detailed analysis. What do you think about
this idea: if scan_lock is already locked, then some other thread is
expecting to requeue scan_work shortly, so no need to proceed with the
scan.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 590cd4f097c22..c6317489022c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3945,7 +3945,13 @@ static void nvme_scan_work(struct work_struct *work)
 		nvme_clear_changed_ns_log(ctrl);
 	}
 
-	mutex_lock(&ctrl->scan_lock);
+	/*
+	 * Failure to aquire scan_lock means another thread will requeue this
+	 * work shortly, so abandon the current scan.
+	 */
+	if (!mutex_trylock(&ctrl->scan_lock))
+		return;
+
 	if (nvme_ctrl_limited_cns(ctrl)) {
 		nvme_scan_ns_sequential(ctrl);
 	} else {
--

