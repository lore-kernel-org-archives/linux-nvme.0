Return-Path: <SRS0=Gd08=O5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABFCC433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F55060FD7
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F55060FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rAaasakPLLq82XSNYeGpIXiHJdlxG6lrqT8ozs2q7LI=; b=J62PJnOH1k8vDL
	B2smHLI3PGD6o4Qp4xwgl5js4711BTaTB1njt/+H8eECKgI+AeCQlgTcPjBGWdJvW/NlVy8Xi7l/3
	SUFXozfWO0Lr+qZURhvR9waopSEJbhxXpKs7phLXRSU18ypD5r0gOXXIROPtWt+EUekdJkObFfe3q
	6ejaaJZPnBW+LXMy2TZbgBgaB4Vn5FcQPheeXPJDbHEkm8zBzjJb/3uGBpiQWCbUihJw1sAzmsBJC
	p9g0burSSrNqMcMj/XfNWbZdRrrlhTZCZIHTbZQxTErDJ+Ij1WxirGGEOjXDbYrhYc0qjsVhvXWAN
	1Ul+lzO0TbsVqs14gpKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZ3Kz-00522b-1i; Sat, 09 Oct 2021 03:47:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ3Kp-00521G-Jh
 for linux-nvme@lists.infradead.org; Sat, 09 Oct 2021 03:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633751262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6EPpWJMM1oEudtfCAFWs0O0JIxg1Z+CB9nptxSUO/I=;
 b=WOaJg0ZB2QcfzubLVlNyZh8wjEFpZfBtOq3A50rOyCgHHKsL4bT5Dad3wgwoiaqYhIDIVT
 5ZdTzF3mAqOJ2xP5GHoQHG343mcVdVEA1svAJ1ErPYGCsS0xpC2nZqUEf89HHL8pcAf3qq
 U0nYZmlHqQE0HJWwPiW2DKBGgzo+XMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Kb9BUKgGM7yfBe5_31K97A-1; Fri, 08 Oct 2021 23:47:41 -0400
X-MC-Unique: Kb9BUKgGM7yfBe5_31K97A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 245F4801A93;
 Sat,  9 Oct 2021 03:47:40 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A227E5F4F3;
 Sat,  9 Oct 2021 03:47:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/6] nvme: add APIs for stopping/starting admin queue
Date: Sat,  9 Oct 2021 11:47:08 +0800
Message-Id: <20211009034713.1489183-2-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_204743_746750_5B50921B 
X-CRM114-Status: GOOD (  11.71  )
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
