Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D6D3C52B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8ISfHARy/Ugggq5dYxbtC7mO8HKBsdW3mPmFUjhtJw=; b=P9syD/ruPQ5S7HHa1ZQyoj6HlE
	Lafi7fhvOwo7lL6iEV5pPx3YG0L4zCU/rtBeEmaY10PVJ2BhGcIb4R9mrSwPTtYPZ505PXWCPTKeP
	wk7nifoMMpxhR2ta6B16mMNDG9CxtD1xBAfzbDB19F3QEJLRm3RyU0Jtr8kLEi5H6k6fSzEQ+Hi64
	uDB0qguYWXhEo3F/LkUjPpiZeoFhBvwAzVJGoHYGcdL3cqPWaa1M3+j9OWavCZZgG5bXyvnLq2Fy5
	A1q4XFo+v6xL5pnwXkgI/GLGYiaMXfzMRKHY8IkO6wIc9NIuwChCZlK+x8mU/Mnk2oOU2C3HITdJJ
	L0ykhF8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1V2a-0000000Fqfr-1W4F;
	Thu, 17 Oct 2024 18:16:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Tug-0000000Fddc-2ElM
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 17:03:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F4445C54C6;
	Thu, 17 Oct 2024 17:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD4EC4CEC3;
	Thu, 17 Oct 2024 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729184629;
	bh=gPe+kEmANhuFuYUQ5sUvsmclaYtt9S2JNZXyBvm8r08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUqLwRgsHUcgq1bL31MPRFh0f8fbHTeLTjmFxP2HIovVXxXlmyzeTG/YrVC7bbtSR
	 1wRwnTrCO+Il91dMRxeFU6BnsEg9mr/R/lPdN6fTnUdHPcgTF4c0TCgLaJHg6Fd8Uy
	 E691HIPpFSfnKDWHO/Vg4a4GhSF0hPabBxUJupKJRs026RlBXvqso531gqc9Hbw4TY
	 2w0e5pGuxBEzpWHBqdE2TaV/60zqAy7tuPNaYPsKLAuldkMZU0kpy0EvaylYqMxZfh
	 DZN1uzhEr3KLgW1KsSMuZCT0tE0BvTy6GIVOliO8zWAZnsn3rUWdoyTd3OP2yayjV2
	 zpZHTEM01qINw==
Date: Thu, 17 Oct 2024 11:03:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [bug report] "BUG: Invalid wait context" at blktests nvme/052
Message-ID: <ZxFDcveKyk-7-4O7@kbusch-mbp.dhcp.thefacebook.com>
References: <tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_100350_639735_2A983941 
X-CRM114-Status: GOOD (  19.92  )
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

On Thu, Oct 17, 2024 at 07:49:33AM +0000, Shinichiro Kawasaki wrote:
> I observed the failure of blktests test case nvme/052 with the kernel v6.12-rc3.
> The failure cause was the "BUG: Invalid wait context" [1]. I have no idea how to
> fix this. Help for fix will be appreciated.
> 
> Here I share my observations. The test case repeats namespace creation and
> removal for a nvme loop target. The BUG was reported for a udev-worker process.
> I guess udev is trying to read a namespace in the removal process. The BUG
> message notes that "RCU nest depth: 1, expected: 0". From the call trace, I
> think the "Invalid wait" in the RCU reader was in the function call chain for
> the read operation by udev as follows:
> 
> blk_mq_flush_plug_list
>  blk_mq_run_dispatch_ops
>   __blk_mq_run_dispatch_ops
>    rcu_read_lock                               ... RCU reader starts
>    blk_mq_plug_issue_direct
>     blk_mq_request_issue_directly
>      __blk_mq_request_issue_directly
>       q->mq_ops->queue_rq = nvme_loop_queue_rq
>        nvmet_req_init
>         nvmet_req_find_ns
>          nvmet_subsys_nsid_exists
> 	  mutex_lock                           ... waits in the RCU reader
> 
> I found the mutex_lock was added by the commit 505363957fad ("nvmet: fix nvme
> status code when namespace is disabled") for the kernel v6.9. So, this commit
> might be related to the cause.
> 
> The failure is 100% reproducible on my test node at this moment. I bisected and
> found that the trigger commit is 4e893ca81170 ("nvme_core: scan namespaces
> asynchronously"), which was merged to the kernel v6.12-rc1.

Oof, good fine. I think the easiest thing to do is add the
NVME_F_BLOCKING flag to the loop controller ops.

---
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e32790d8fc260..77dd809fe4507 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -479,7 +479,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
        .name                   = "loop",
        .module                 = THIS_MODULE,
-       .flags                  = NVME_F_FABRICS,
+       .flags                  = NVME_F_FABRICS | NVME_F_BLOCKING,
        .reg_read32             = nvmf_reg_read32,
        .reg_read64             = nvmf_reg_read64,
        .reg_write32            = nvmf_reg_write32,
--

