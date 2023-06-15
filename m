Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDBCEB64DB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kv5ma8JCQU6OxZQLk8fjDBLmmqzztFUTucazbbRH2Q=; b=GPfgwKPpHaw1JxrBl2I/NpNihY
	9aRNaKyE2Gi4rTe7GjIy9tfiKqOgvHDdJcdmFMazIGJCiJ4h6ja1UboeYWbNR2txIzLLJcDqNeK+N
	/5bnjc9LvP35wC/DCNhZNb+ZruM/jDQuSeKtP5poUDE6VcbjjLYdfzAyQQqgEMo3qXmWgSYaa2BZq
	FIbYLyWVEwsVKruZh4IHWdFhU2Tuwj0cqDCaMRxpRHPqTY737D5zxU4JjcvYFiMJtxGFQFfgDrOEq
	IwDIy5bFqK7ys5Up85TUqpoajYIIi/RcNHNi+4/niArnHMgP2MescAjjANtNTL5RvqrluyVyLYLEH
	6PdyjF1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2d-00F99M-2P;
	Thu, 15 Jun 2023 14:33:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2b-00F92i-0N
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 14:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686839602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kv5ma8JCQU6OxZQLk8fjDBLmmqzztFUTucazbbRH2Q=;
	b=Ms9kup98O5rITdxRCoHAJIUGTDoS8EUF61JrJGKQ43A3K6yYedaDRFfHXq8n1ZPV3lsZqb
	iI6AIkzUJw968uAPHaBTeMWGl6zeoLW0MAsu//GqrKJ+ZCIsYM5xVKs0Aodyy9eGaH0/cs
	Db0rTTExwTjG9LrijUaFgxCPFOLe85c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-Brtmmq4xPbCOOXIk3-ywew-1; Thu, 15 Jun 2023 10:33:16 -0400
X-MC-Unique: Brtmmq4xPbCOOXIk3-ywew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BE233C0DDDE;
	Thu, 15 Jun 2023 14:32:51 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEC771415102;
	Thu, 15 Jun 2023 14:32:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] nvme: add nvme_unfreeze_force()
Date: Thu, 15 Jun 2023 22:32:34 +0800
Message-Id: <20230615143236.297456-3-ming.lei@redhat.com>
In-Reply-To: <20230615143236.297456-1-ming.lei@redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_073337_333912_3C463CDB 
X-CRM114-Status: GOOD (  15.40  )
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

Add nvme_unfreeze_force() for fixing IO hang during removing namespaces
from error recovery.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3d72fc677f7..96785913845b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5220,17 +5220,32 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
-void nvme_unfreeze(struct nvme_ctrl *ctrl)
+static void __nvme_unfreeze(struct nvme_ctrl *ctrl, bool force)
 {
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unfreeze_queue(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (force)
+			blk_mq_unfreeze_queue_force(ns->queue);
+		else
+			blk_mq_unfreeze_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
+
+void nvme_unfreeze(struct nvme_ctrl *ctrl)
+{
+	__nvme_unfreeze(ctrl, false);
+}
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
+void nvme_unfreeze_force(struct nvme_ctrl *ctrl)
+{
+	__nvme_unfreeze(ctrl, true);
+}
+EXPORT_SYMBOL_GPL(nvme_unfreeze_force);
+
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 953e59f56139..33b740808e7b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -764,6 +764,7 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_unfreeze_force(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
-- 
2.40.1


