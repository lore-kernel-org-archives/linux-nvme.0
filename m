Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F7F6124B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1F7F6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i1hSV0czyRsZwTjozT+MLj+UaMLCTDm8K7DmLoCuPhI=; b=G2mUkbSbUUHNQK
	f3lMiGmzV08QFko+X6hjXhdRlR7mFpuEbOln75PY7pFKF/2bBuvZcqYXtW4HHdngyZ/cWIjGkCbVT
	J6qc09MAw8tdYH/l8AdtZjoUNa8eKuYrOehd0nlY7mVlJAx3xJ4Ljn8QIQav1Po6y7pfXOqvJD6zk
	FCkuWALYLWglWYlX/d/4d9YcGL1hnkbHdp1jjWujKsYsnVc/tlx1844KGVcnsQx2epKzjBZn/QlK2
	SHpS3UM2nRDJy5ZZ/y1DDycbDldgT5fpBtztf0bs/PSK2ABTJZWAfhGDk3QM7K80bxD62La2WC4Wo
	id3Z48rmEMcMBIA11HAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVvdC-00EK2b-CI; Thu, 30 Sep 2021 12:57:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvcl-00EJtS-Ol
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 12:57:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633006638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7G3UKlJlve/dAHeQ4aDLZgNL6CcToFOApymUAdlSpAM=;
 b=DNanz72XOJl8Fe2FLVszK1GxYvyoe8e2i3EgopkOcmYfueIkebJhRZX6dQhGdOFK5AA7Be
 rVd1D0pCgX/XFYqbqV2nia81ACWQMtI8MRSsPPqxQAvs4zA3w3WC6AM3IafmVfnrRgpEX9
 Cxl+dkbhgRqgkj6zjSlN53pSHOQLod4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-bl-FNJVcP8ykgg2FpwlVVQ-1; Thu, 30 Sep 2021 08:57:17 -0400
X-MC-Unique: bl-FNJVcP8ykgg2FpwlVVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110E4108998E;
 Thu, 30 Sep 2021 12:57:02 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 165408FF8A;
 Thu, 30 Sep 2021 12:56:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/5] nvme: paring quiesce/unquiesce
Date: Thu, 30 Sep 2021 20:56:20 +0800
Message-Id: <20210930125621.1161726-5-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-1-ming.lei@redhat.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_055719_906930_E9E78E31 
X-CRM114-Status: GOOD (  15.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
stops and starts the queue unconditionally. And there can be concurrent
quiesce/unquiesce coming from different unrelated code paths, so
unquiesce may come unexpectedly and start queue too early.

Prepare for supporting concurrent quiesce/unquiesce from multiple
contexts, so that we can address the above issue.

NVMe has very complicated quiesce/unquiesce use pattern, add one atomic
bit for makeiing sure that blk-mq quiece/unquiesce is always called in
pair.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++----
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23fb746a8970..4391760e2e9a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4452,12 +4452,14 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
 static void nvme_start_ns_queue(struct nvme_ns *ns)
 {
-	blk_mq_unquiesce_queue(ns->queue);
+	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
+		blk_mq_unquiesce_queue(ns->queue);
 }
 
 static void nvme_stop_ns_queue(struct nvme_ns *ns)
 {
-	blk_mq_quiesce_queue(ns->queue);
+	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
+		blk_mq_quiesce_queue(ns->queue);
 }
 
 /*
@@ -4575,13 +4577,15 @@ EXPORT_SYMBOL_GPL(nvme_start_queues);
 
 void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
 {
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
+		blk_mq_quiesce_queue(ctrl->admin_q);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
 
 void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
 {
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	if (test_and_clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
+		blk_mq_unquiesce_queue(ctrl->admin_q);
 }
 EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 47877a5f1515..0fa6fa22f088 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -336,6 +336,7 @@ struct nvme_ctrl {
 	int nr_reconnects;
 	unsigned long flags;
 #define NVME_CTRL_FAILFAST_EXPIRED	0
+#define NVME_CTRL_ADMIN_Q_STOPPED	1
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
@@ -457,6 +458,7 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
+#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
