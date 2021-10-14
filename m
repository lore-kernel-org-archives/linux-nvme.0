Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CF161152
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79CF161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7G3UKlJlve/dAHeQ4aDLZgNL6CcToFOApymUAdlSpAM=; b=SfwsIPCz2M8YmYQgrRVw7v52fb
	OL/1ct2Wa7coxo/ia7MCYOFPHWhXO9GLi/XoGeKSokMXPLS7OIUnCNOd1iiGGskD3CyU9wAnh9M1g
	J3rd1bQXMgIlZepteDh97PwhCFrfxwCm8BXpv2B9xNfXY7WquuaSjwrvVPaSV8oGGvIy85aN2ktrh
	uCiXXPy9YbHAUnk/kjJcbsHaUGLaXME93VeNw4mbRMl1wLKCLbzzF02ujJTt4pr+GKFXuJ6BgQsdq
	oD7NZoO9NLyiPtGmvp1YVwFmLnswXRk4l1f25Ln7GFv38Bc3Qe1595SUEZS2mowSJeTWp58WSNqWR
	upPiyp9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mavwb-0029EE-Pp; Thu, 14 Oct 2021 08:18:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mavwF-00296a-1H
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 08:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634199486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7G3UKlJlve/dAHeQ4aDLZgNL6CcToFOApymUAdlSpAM=;
 b=h1HMPfmk/H4MrJJU8ix2EONF1x7JUFNOYIT+mv28ncx3aWlRSorSkzHsO8JtetKElPu5+h
 PZSIJ2L77+5yFkg6E+9Nnti7dk2M7u/WhwGEk6QplwV0tc3IIfU36LzNpNc2C/IKL94+cY
 0kdJUUi4v7AGWa1Ex/lyS6++ExlOVMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-6O7VCqKLP-qhVQh6D_HwOQ-1; Thu, 14 Oct 2021 04:18:01 -0400
X-MC-Unique: 6O7VCqKLP-qhVQh6D_HwOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73BBBA0CB6;
 Thu, 14 Oct 2021 08:17:59 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 823305F4E2;
 Thu, 14 Oct 2021 08:17:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/6] nvme: paring quiesce/unquiesce
Date: Thu, 14 Oct 2021 16:17:08 +0800
Message-Id: <20211014081710.1871747-5-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_011807_190197_5A8A57A5 
X-CRM114-Status: GOOD (  15.04  )
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


