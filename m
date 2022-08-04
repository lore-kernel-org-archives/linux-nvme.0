Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF059C25B06
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Aug 2022 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmBBFDa8viSxpPQpBpI5r5o8eGZg1iz71bG9i7ZvV+k=; b=kj2vLnBAAxbxam7QtvEJIrUSty
	E/YwxRnYjngb09MDNlhtRXNtW08A3RuP12K4Lov/v1EdQ6kVX3qYWxPNnYfkvV3QuV/exYJKC0t+w
	Rt0VwF5SsI35ogcSG0bhCHC5sU3gMG/G/8+wicerNtyWEgWJyvPRkj/ii9TEvvWNWsYbaJhFeHYg4
	nT/ZbFPVUlu9cL5rsNrmRFWly8yXKNmbMso+nJnaMLkN3paLf08jzibkQEhbfilUigqXYSp766Rqm
	Oin9xn7YSULL/kSVSi4AjW2Q6zO5NCd5Y0z7Grc/McrQK2wzTbwLCriY7Adg4RR9gKMJ7ISzUjtDa
	7hBZlhCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJioN-009Mpn-8y; Thu, 04 Aug 2022 21:55:23 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJioJ-009Mog-Vk
	for linux-nvme@lists.infradead.org; Thu, 04 Aug 2022 21:55:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8C265B82762;
	Thu,  4 Aug 2022 21:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC044C433C1;
	Thu,  4 Aug 2022 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659650117;
	bh=7aqqWtn4Oifik33o2/ub9qLVrNocomrJndifORrmJYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nINCqD2cWGdQX9axqq9cBuF5MhXH8t8tgHmAeI4AGc/mOlJj8MYx8GlTOypKIc2S0
	 RvHPPZRXLA3Olz33On+GicskejZjyb44XvWjFvlGB0zRCKxtvuUKdbF2PyiKG/Cfpx
	 8FqYoUtfiROJdHREoAlkJiB1Zwu9ZVIYr/Hw6l4vtaIaUSQehEVzqzftluuYh51LiK
	 zlDu6ykk4UgVxtJ6drXcIOd1qILJo4viY2NT2sLEX2tgUffssWfZN+Uafc1iBe/eH8
	 hvgk8SUywIuSZi1qNce820W4rmBI89JrbnJHI6Y07niQ9YYp/aoVPpOyCEVIt0kAej
	 w4Pqt2eEZMKhw==
Date: Thu, 4 Aug 2022 15:55:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Message-ID: <YuxAQmHrwLGL4Wap@kbusch-mbp.dhcp.thefacebook.com>
References: <20220801125753.1434024-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801125753.1434024-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220804_145520_349294_1FF569F2 
X-CRM114-Status: GOOD (  19.84  )
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

On Mon, Aug 01, 2022 at 08:57:53PM +0800, Ming Lei wrote:
> After nvme_probe() returns, device lock is released, and PCI reset
> handler may come, meantime reset work is just scheduled and should
> be in-progress.
> 
> When nvme_reset_prepare() is run, all NSs may not be allocated yet
> and each NS's request queue won't be frozen by nvme_dev_disable().
> 
> But when nvme_reset_done() is called for resetting controller, all
> NSs may have been scanned successfully, and nvme_wait_freeze() is
> called on un-frozen request queues, then wait forever.
> 
> Fix the issue by holding device lock for resetting from nvme probe.

Beyond the issues with locking the pci device, I think the problem you're
describing is generic to any rescan that alters the namespace inventory, so we
can't resolve it only on probe.

Is it enough to track the frozen status within the namespace flags? Something
like the following:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2429b11eb9a8..befd156d57c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5027,8 +5027,11 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_and_clear_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		blk_mq_unfreeze_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -5039,6 +5042,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
@@ -5053,8 +5058,11 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
+			continue;
 		blk_mq_freeze_queue_wait(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
@@ -5064,8 +5072,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		set_bit(NVME_NS_FREEZE, &ns->flags);
 		blk_freeze_queue_start(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bdc0ff7ed9ab..872237b4b65d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -484,6 +484,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
 #define NVME_NS_STOPPED		5
+#define NVME_NS_FREEZE		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
--

