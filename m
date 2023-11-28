Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E2C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZa2rbawZm9YETONcae7fFTCBGipq6vD0hlgjn4LWVk=; b=Mri8ey7I7YOLtayhJ6/xbpCgU3
	hQqyk+oIrJtg0IlD9aLNdDQOQ7QNhi/oNAGkdBfLj89W5Haph5m2szI7H0AjSi9MJktvYkVGGZEIx
	dDvRrZktEaprJHkn670i2gHLFFLvGM6wlcc/xbZ4LJ1wU7QPI3A12CSm2k+BZuBLDoTBxQgi8SXey
	IMKYwOkE84l6h3Yu6IZiN+EGEgcYWX7Rp2mNwBXmPszyEbM69jyUhqhMXrd9kzBrGIoWQMcOk5c2s
	pI/biZOAIAfJJExkGuT+jYsfBYTVV1FxrSJJqSvcMtl3Nb65mcR5X8toqjJd34OOQkOuoPNE+ieYq
	VVpvhueA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r82Ny-0062ey-1k;
	Tue, 28 Nov 2023 18:00:38 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r82Nv-0062e6-2F
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 18:00:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 3065CB83B89;
	Tue, 28 Nov 2023 18:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EC0C433C8;
	Tue, 28 Nov 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701194433;
	bh=/gFbOX4F6s+/kOnZpinHF5H/p/09WqRtksDYYY0r3d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYV2VFHp/dijSQG9xQiRQATmwkzl/4Q4UefhRaedMHB4yKrhw/ZKm5CobKmeG5+Jz
	 WXnTWvJDKtiFYaU5pl6sYW+wRbzlMWIcFMu8f7bnPXuIQ4JgmodElqyeR7rn8M7oaM
	 i7YMRYf4Vc/C4A2eSFT15X0gu4XfPoCWmkpoJVNVdWyM5Id/7KxX4PIcZ04rP++n8G
	 UfPsOnalrMVyYiv7aM8jnmFSjmZXBTVmhTpdvyENerqqoASAbTunzYeQxzTQbLaCSl
	 E6vdSel6v6OhKJ8Lz0fBOvbk12LJbgoBaCNMMAVh1drSNy/gh33KBODAQ400OV6sg5
	 Hcm6wctJ6LKOg==
Date: Tue, 28 Nov 2023 11:00:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: yaoma <yaoma@linux.alibaba.com>, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Message-ID: <ZWYqvo86PI6iHoXV@kbusch-mbp.dhcp.thefacebook.com>
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_100036_025096_8FA67AC7 
X-CRM114-Status: GOOD (  28.94  )
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

On Tue, Nov 28, 2023 at 12:13:59PM +0200, Sagi Grimberg wrote:
> 
> 
> On 11/28/23 08:22, yaoma wrote:
> > Hi Keith Busch
> > 
> > Thanks for your reply.
> > 
> > The idea to avoid such a deadlock between nvme_reset and nvme_scan is to
> > ensure that no namespace can be added to ctrl->namespaces after
> > nvme_start_freeze has already been called. We can achieve this goal by
> > assessing the ctrl->state after we have already acquired the
> > ctrl->namespaces_rwsem lock, to decide whether to add the namespace to
> > the list or not.
> > 1. After we determine that ctrl->state is LIVE, it may be immediately
> > changed to another state. However, since we have already acquired the
> > lock, other tasks cannot access ctrl->namespace, so we can still safely
> > add the namespace to the list. After acquiring the lock,
> > nvme_start_freeze will freeze all ns->q in the list, including any newly
> > added namespaces.
> > 2. Before the completion of nvme_reset, ctrl->state will not be changed
> > to LIVE, so we will not add any more namespaces to the list. All ns->q
> > in the list is frozen, so nvme_wait_freeze can exit normally.
> 
> I agree with the analysis, there is a hole between start_freeze and
> freeze_wait that a scan may add a ns to the ctrl ns list.
> 
> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
> to what we did with quiesce). Then the scan can check it before adding
> the new namespace (under the namespaces_rwsem).

Could we just make sure that scan_work isn't running? If we reset a live
controller, then we're not depending on reset_work to unblock scan_work,
and can let scan_work end gracefully. The scan_work can't be rescheduled
again while in the resetting state.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fad4cccce745c..5d6305475bad5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2701,8 +2701,10 @@ static void nvme_reset_work(struct work_struct *work)
         * If we're called to reset a live controller first shut it down before
         * moving on.
         */
-       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+       if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
+               flush_work(&dev->ctrl.scan_work);
                nvme_dev_disable(dev, false);
+       }
        nvme_sync_queues(&dev->ctrl);

        mutex_lock(&dev->shutdown_lock);
--

