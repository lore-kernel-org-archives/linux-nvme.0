Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB97EB64DA
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 01:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDCU23Tg71ixu26B1Q5DI34+DtwzuYkE4QTPUCZ8gbM=; b=If5Jx2J5IFN55Ex/F/GRlJAi/Q
	HXSLh0Ipm3rlcOhcwTmkusevyA/MZLidSCiMJq3xqJyXw1RQjpIKAB1JcLFi4o2lR6mEH6o+boli2
	wEWFHRMpRNQWxrcbNJy7HqCxy5gwUVhtEXGAbqqCKr9omA5K9fTxco/mX1k1+PnESm3r6inbLJAir
	03VVrKXOpw0JdWiejQ7FMc6nYDpu5RTXCdD+1JBHkBSmbL28qvmHrJBymi7UHRnGZ/Ihcvh25oyE5
	wh2JffE06MUfsBMUL3kT7mEcoAJJQCw3uhHYxvCiCJlFO3NegCoN7FcCJzLhBC/SiLpoR45B0AFbP
	oL+Zaccw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQGQ-009tFG-12;
	Tue, 20 Jun 2023 01:34:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQGN-009tDt-1F
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 01:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687224870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDCU23Tg71ixu26B1Q5DI34+DtwzuYkE4QTPUCZ8gbM=;
	b=D/o/5Wuifs9P1hbaocsYZplQzLeQzYkIqdPMEN9dSu8j2sJXeLakrDpH55uwDAIUS6WYu9
	61rmLWGueLLTutWG0AjjH6gvn8Ni5Thj7pxwqpb8hKaY0a5PlmEKDJZjEXHpcTgHSfneUE
	ND7m5zZcmzBvh/fvKhdsHOOltvwLWsg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-sPBOnxV0Mv6z7FTqZz490Q-1; Mon, 19 Jun 2023 21:34:26 -0400
X-MC-Unique: sPBOnxV0Mv6z7FTqZz490Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 156CC1C08DB8;
	Tue, 20 Jun 2023 01:34:26 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A402112132C;
	Tue, 20 Jun 2023 01:34:06 +0000 (UTC)
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
Subject: [PATCH V2 2/4] nvme: add nvme_unfreeze_force()
Date: Tue, 20 Jun 2023 09:33:47 +0800
Message-Id: <20230620013349.906601-3-ming.lei@redhat.com>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_183431_499041_CCC24834 
X-CRM114-Status: GOOD (  14.93  )
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
index 76e8f8b4098e..6b3f12368196 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4579,17 +4579,32 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
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
index 78308f15e090..b583bab985c3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -765,6 +765,7 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_unfreeze_force(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
-- 
2.40.1


