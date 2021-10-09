Return-Path: <SRS0=Gd08=O5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B782C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:49:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC1D6105A
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EC1D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i1hSV0czyRsZwTjozT+MLj+UaMLCTDm8K7DmLoCuPhI=; b=Q23fKKxAVpisF5
	6iNvftYV8VjM+pty4g88a7TQDBcVFzMpCtnyqEciXNtbdk6aA9SDdzfPTYEddowfl0X/Fck2OjG2B
	Qw3viraeqCr59uo8laE7abFALO64RKoQoXS5enbHmh1zV6g1Y3Cp3jDXCLhxkS8dkwDh75U0tQtUY
	+7c5Ufj7XWFTlAJuYelgOdkCHmU+Jvg1knEVI319URhqgc5lImvI5kCuk2FG2Fcs9uSKMlYjQovas
	vaqkCv4/jkaBJBKjQYIlc8cqpkW6cTdlQjZYa44Yb1Di6ioCyjRCS/kQWgCmtGXR+FcXPXqQkD+jI
	fiyYxMdHYdSOe7BGpU4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZ3Lb-0052B7-HO; Sat, 09 Oct 2021 03:48:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ3LX-00529U-Ui
 for linux-nvme@lists.infradead.org; Sat, 09 Oct 2021 03:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633751307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7G3UKlJlve/dAHeQ4aDLZgNL6CcToFOApymUAdlSpAM=;
 b=EQMjwHYfxfayfgOPMhuM7VvtP4ib9OEs+Co7a2ZThGgQDchBHv5wkrcd3PC8zk606I7Eeq
 j3NJbUjBDkGyiTtyXqEyZiGCTkPIMyCGj1HuFPMWQkwK9y6pFDFkgIgJfq6cbubK64mCSw
 bdcsKKy7W1SgD7gaP2Zoi/mBS4PVZyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-A_lTVrghNU6S2JdWdBhHag-1; Fri, 08 Oct 2021 23:48:14 -0400
X-MC-Unique: A_lTVrghNU6S2JdWdBhHag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D381F1006AA2;
 Sat,  9 Oct 2021 03:48:12 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E985F100763C;
 Sat,  9 Oct 2021 03:48:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Date: Sat,  9 Oct 2021 11:47:11 +0800
Message-Id: <20211009034713.1489183-5-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_204828_121371_5E0A8DEB 
X-CRM114-Status: GOOD (  14.37  )
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
