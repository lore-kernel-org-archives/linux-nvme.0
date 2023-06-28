Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C87EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 03:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DVsWegYjQWBK//10guVuuDzuiAXpy0fbkXve8qAAlEc=; b=RSZ3BN4YAiZzH0isVhRxDavK2a
	IGFzKozydb7pSF9qEvlIgMQNnSXn4QEyIvUPcx3uqvoGjv6m0yhBEX+oBvlJLH+du78dhu6eQEQ6b
	PhNpVoO1bIvBkEAAUyKWSnf5aSR3h4HzDWaJ8KVvh3Fk6j/kkW6i1EiyLDSPRNW/t7m60TrbBT/qj
	ZG1lah/7UUhcLIYUrZPIVVH27mF1FSfxNqHAsV8MjrFKrmkN65VkT5iGMR8758bWLE4HkAFL7WxDX
	71GcZqMA2oEr0DN61Ahl1TJrFhVj1aamJ9xgQLXC8a/jckJ0kT+LzY1OGZAVrSq8IGxYUsSjAILH9
	CnVBPBUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qELc1-00EftE-0Z;
	Wed, 28 Jun 2023 03:12:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qELby-00EfsS-1W
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 03:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687921972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVsWegYjQWBK//10guVuuDzuiAXpy0fbkXve8qAAlEc=;
	b=IuaNgkxPPonMBbG5mhxVz/n2PMptSdiNQgqLwvG3i7kc8LbkzSp3ggcTYgCQs3QdSypWWV
	qDnxAMOdLcNUE6b5rBPr5rUlYLP9NgnezWYGkng4sMJL5ipCm0kJpCCaRaA2nE6/0td7M6
	pXaHu5EukL8VioluHHOSHBrD4/O6eDQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-0H5x98pnMT2Xg8oz0TzGBg-1; Tue, 27 Jun 2023 23:12:48 -0400
X-MC-Unique: 0H5x98pnMT2Xg8oz0TzGBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945161C05151;
	Wed, 28 Jun 2023 03:12:45 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA840401061;
	Wed, 28 Jun 2023 03:12:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Date: Wed, 28 Jun 2023 11:12:34 +0800
Message-Id: <20230628031234.1916897-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_201254_582399_6B66C517 
X-CRM114-Status: GOOD (  15.55  )
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

namespace's request queue is frozen and quiesced during error recovering,
writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- del_gendisk()
can't move on, and causes IO hang. Removal could be from sysfs, hard
unplug or error handling.

Fix this kind of issue by marking controller as DEAD if removal breaks
error recovery.

This ways is reasonable too, because controller can't be recovered any
more after being removed.

Cc: stable@vger.kernel.org
Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdfcf2781c85..b4cebc01cc00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -567,6 +567,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
+		ctrl->old_state = ctrl->state;
 		ctrl->state = new_state;
 		wake_up_all(&ctrl->state_wq);
 	}
@@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD ||
+			ctrl->old_state != NVME_CTRL_LIVE) {
 		nvme_mark_namespaces_dead(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a98c14c552a..ce67856d4d4f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -254,6 +254,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
 	enum nvme_ctrl_state state;
+	enum nvme_ctrl_state old_state;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
-- 
2.40.1


