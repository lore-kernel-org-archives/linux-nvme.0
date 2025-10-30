Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA0BCCF9EE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 00:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bQogtN7+Q/lJNGIWymROZx+wULl+1igdZtI6scj+kg=; b=gc4VKj21AJGCJB8H61SwzgLOtb
	PgQVKTPur43eysBhRQVrin58C3tIxPXYozhvfXJ2Au74VMwhA3T7boLB3z/j7zUQbZ4zt2uaxiH5u
	8uxXTe/uZX3ks1NsMS0Gi5O00LWQCIBnkT4W1Tq3MI63LKLrh5GmIBsE0AD5wzjBeg1B+6AjyV/Nh
	ReN6e6X1g2WBzE+apSkkPJeQgsPTTP+wDFPsbtMgU0G3NiTo320LE/ixH6s6vDGYFGDjjUe+Fv+pb
	Ezfxo2wBTacqCoIeIgsVyJUqG4YVHvT1152SLk1FVlU5aThkj96Pf5WvbczD0PYCKuqiyZKKoM1uH
	g+CoeynA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEGhZ-00000003IS1-2Rx8;
	Thu, 30 Oct 2025 00:39:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEGhX-00000003IRd-2DQ7
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 00:39:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B6FC740529;
	Thu, 30 Oct 2025 00:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46871C4CEF7;
	Thu, 30 Oct 2025 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784776;
	bh=CnEBZQLAc8cKEsXxRjn2QzGr6G7p5UCV6c+c0O3l0Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrI898Y7tOKBfBa4Wrp2ScPkZXoBjkea2djc++1sf/4MLsNAfTtL1CqzjMQkXSMAM
	 dYSvyRTukX9kZleHnSCdE05yqAOhVu/nZ7BSDMrUVD3NS9sCup4XmbB06/qwWh9RCM
	 mct/bEF8RfLXfZ4fOM83B6r48YkPvMf0fbVZ+DVBroLu/PNBZnfSQ1iMAvUazCfoXL
	 Kv41FiXzsH1W63AJx0/E4T/rOTUG1hsqZiaoYTbLjLbavGMeyuMWpnYxWO4qFJFzwK
	 w89+ESdxUej6J5S2UukWRegMalKqcp1DcsDlFuqJYVNVuGjyy6OFroCcs2yNPEyRxV
	 /Vx1F0aoVEnYA==
Date: Wed, 29 Oct 2025 18:39:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	yzhong@purestorage.com, sconnor@purestorage.com, axboe@kernel.dk,
	mkhalfella@purestorage.com
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQKzxpJp98Po_pch@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029210853.20768-2-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_173939_587704_9FCE3846 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> 
> Fix this by taking an additional reference on the admin queue during
> namespace allocation and releasing it during namespace cleanup.

Since the namespaces already hold references on the controller, would it
be simpler to move the controller's final blk_put_queue to the final
ctrl free? This should have the same lifetime as your patch, but with
simpler ref counting:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de736..0b83d82f67e75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
         */
        nvme_stop_keep_alive(ctrl);
        blk_mq_destroy_queue(ctrl->admin_q);
-       blk_put_queue(ctrl->admin_q);
        if (ctrl->ops->flags & NVME_F_FABRICS) {
                blk_mq_destroy_queue(ctrl->fabrics_q);
                blk_put_queue(ctrl->fabrics_q);
@@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
                container_of(dev, struct nvme_ctrl, ctrl_device);
        struct nvme_subsystem *subsys = ctrl->subsys;

+       blk_put_queue(ctrl->admin_q);
        if (!subsys || ctrl->instance != subsys->instance)
                ida_free(&nvme_instance_ida, ctrl->instance);
        nvme_free_cels(ctrl);
--

