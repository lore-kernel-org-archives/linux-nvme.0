Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012FFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:01:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C8A207F7
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SojqI3R8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UD0VLXTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C8A207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nPulcImdiYfIoZfkOwS+6yv51tPw9ICEjnp8C1YsjfM=; b=SojqI3R8/h7g4ETBp7PfCpppML
	OPkRM2AMsMx+aI1HtN3XRLMT6nMj4p/gdyFOOx2B2kUGRdcnJ9VhKEXXalDL9SjFcnHHYQRT8gp1x
	SdNSQ5cTQXtKrA/XrxBy0qCm7tuaM+dPyBdq6lSR5l9e2pmpiTLB28nil5AVf6gKe2533Sa9iFRDD
	bT75Lzkk5yPMxac1MMXVlDvS0rIULjrY3IPAq5Pbf8Kxm+pRShzhDOO/IU6fegf7+lT9MJf7uHpkU
	DosC6tTFI12to+15YW270QYA+gGqXRDgU9ZS+xSFDZwhhFQHT74Q6Qk2ZZammP5vZyPS47lnYk8K5
	n+I5vVcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5xsJ-0008Bb-U7; Wed, 12 Aug 2020 21:01:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5xsG-0008Ac-RL
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 21:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kGiEj/z+vdf+Ey+9R6ahin3vijWbPQNp/8asyFRpxHo=; b=UD0VLXTjuHTts8bUCzA8XKl0vD
 15m73oV6oKBtjBUKkziwo3hSYECesrbvwqPYp9djMlLGyslrSKAxU41EK1ODx8Ekc4p3mIhqLTs1Y
 YR8jzADiMdicWWk/tvdBdAnWJ3AJCx+jfyrg+qvXjnRH51kRl9PEUb8rKHYhGPNK7zGzYrbezcdDv
 PzOCj/b0gV5S2k2kFG7etvvYkBGFqSFKBg99x13NG5bO7WODqzzqITOLr55JGuWFH3p/UuhAClPX2
 +ZwllEa+NSgwbF5v+ZY8j2Oukezs+lKG6qB5cXBfJUkn9rrLRP4HsBe9q9ozcMW2HHKbmzX8PpH2R
 rmQkjdNQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1k5xsD-0003Wb-D4; Wed, 12 Aug 2020 15:01:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1k5xsB-0001s9-84; Wed, 12 Aug 2020 15:01:23 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Date: Wed, 12 Aug 2020 15:01:19 -0600
Message-Id: <20200812210119.7155-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 keith.busch@wdc.com, axboe@kernel.dk, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the
 ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_170128_897700_7BBB60D2 
X-CRM114-Status: GOOD (  13.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When locking the ctrl->lock spinlock IRQs need to be disabled to avoid a
dead lock. The new spin_lock() calls recently added produce the
following lockdep warning when running the blktest nvme/003:

    ================================
    WARNING: inconsistent lock state
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ksoftirqd/2/22 [HC0[0]:SC1[1]:HE0:SE0] takes:
    ffff888276a8c4c0 (&ctrl->lock){+.?.}-{2:2}, at: nvme_keep_alive_end_io+0x50/0xc0
    {SOFTIRQ-ON-W} state was registered at:
      lock_acquire+0x164/0x500
      _raw_spin_lock+0x28/0x40
      nvme_get_effects_log+0x37/0x1c0
      nvme_init_identify+0x9e4/0x14f0
      nvme_reset_work+0xadd/0x2360
      process_one_work+0x66b/0xb70
      worker_thread+0x6e/0x6c0
      kthread+0x1e7/0x210
      ret_from_fork+0x22/0x30
    irq event stamp: 1449221
    hardirqs last  enabled at (1449220): [<ffffffff81c58e69>] ktime_get+0xf9/0x140
    hardirqs last disabled at (1449221): [<ffffffff83129665>] _raw_spin_lock_irqsave+0x25/0x60
    softirqs last  enabled at (1449210): [<ffffffff83400447>] __do_softirq+0x447/0x595
    softirqs last disabled at (1449215): [<ffffffff81b489b5>] run_ksoftirqd+0x35/0x50

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(&ctrl->lock);
      <Interrupt>
        lock(&ctrl->lock);

     *** DEADLOCK ***

    no locks held by ksoftirqd/2/22.

    stack backtrace:
    CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 5.8.0-rc4-eid-vmlocalyes-dbg-00157-g7236657c6b3a #1450
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
    Call Trace:
     dump_stack+0xc8/0x11a
     print_usage_bug.cold.63+0x235/0x23e
     mark_lock+0xa9c/0xcf0
     __lock_acquire+0xd9a/0x2b50
     lock_acquire+0x164/0x500
     _raw_spin_lock_irqsave+0x40/0x60
     nvme_keep_alive_end_io+0x50/0xc0
     blk_mq_end_request+0x158/0x210
     nvme_complete_rq+0x146/0x500
     nvme_loop_complete_rq+0x26/0x30 [nvme_loop]
     blk_done_softirq+0x187/0x1e0
     __do_softirq+0x118/0x595
     run_ksoftirqd+0x35/0x50
     smpboot_thread_fn+0x1d3/0x310
     kthread+0x1e7/0x210
     ret_from_fork+0x22/0x30

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15abc00db3d3..312614467adb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
 {
 	struct nvme_cel *cel, *ret = NULL;
+	unsigned long flags;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_for_each_entry(cel, &ctrl->cels, entry) {
 		if (cel->csi == csi) {
 			ret = cel;
 			break;
 		}
 	}
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);

 	return ret;
 }
@@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
 	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
+	unsigned long flags;
 	int ret;

 	if (cel)
@@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,

 	cel->csi = csi;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_add_tail(&cel->entry, &ctrl->cels);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 out:
 	*log = &cel->log;
 	return 0;

base-commit: 4d3c0eaf0d44a4f8f7d53b7835e670eafc96c450
--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
