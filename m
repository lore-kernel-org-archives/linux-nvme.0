Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3656124B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF3656124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rAaasakPLLq82XSNYeGpIXiHJdlxG6lrqT8ozs2q7LI=; b=HG6tbO6yfhYHMS
	hZ8xI26EzLIcUjSv2d5aH3TUT9nn8jshHhniqQTRDYdMPNy42RsXaui9LMQQkJJcbkoek4LCBExIJ
	FTiVC6omEKVMT8RpInrZCxHwFXbu7tNcMdRZ6oEcZ//IlH3l487kVIZPipoCKDG0NRhP6qLU8+xNq
	ufIP9nfYJN5jhOsY+4FkIfH0VSWyRCHaiElPMSOZsYEsQ46Kt6sgi2ehynmY1qYSe2lz+ofbxKq0H
	FTwrNfEmY2ViWUvkQqzomGr1bX4mrC5s+Pq0Z5BLHl58n5R7JHeqcpIL7jNlz1WBDuFKuq9vY1Evq
	o8EbS9yo8CpwjLCXY0WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVvcP-00EJoL-9o; Thu, 30 Sep 2021 12:56:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvcF-00EJj4-GW
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 12:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633006606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6EPpWJMM1oEudtfCAFWs0O0JIxg1Z+CB9nptxSUO/I=;
 b=HmuMJIt195wSJaqDCcnzxFqPnUZgBB8LyUMivxFgkZFewJlKA1Emd3RxxJahGjlNgvdKTv
 mmwoy3ltFjG7W+7tYnIWGD48ZTh4JwjbRs/2qN3FkBrHaL0eZ+GgWTQS1LihtPfX08MJQ+
 dBB7qKoaLKD20XNCYfJCBgCFaB1l/BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-wZb5arZYNqu_9zk9FQAF8A-1; Thu, 30 Sep 2021 08:56:45 -0400
X-MC-Unique: wZb5arZYNqu_9zk9FQAF8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D48B8145EE;
 Thu, 30 Sep 2021 12:56:44 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7E380940;
 Thu, 30 Sep 2021 12:56:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Date: Thu, 30 Sep 2021 20:56:17 +0800
Message-Id: <20210930125621.1161726-2-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-1-ming.lei@redhat.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_055647_650075_89AE2072 
X-CRM114-Status: GOOD (  12.43  )
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

Add two APIs for stopping and starting admin queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fa75433c036..c675eef70a63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4563,6 +4563,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_quiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
+
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
+
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..47877a5f1515 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -659,6 +659,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
