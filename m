Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40020EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hPvuAAm3tIsvzZqwXQpG7D9fP9x0u3xCzy3W397eHSk=; b=otuw4oMARU8m7ADf19HopemMPD
	CqXika42N7ntw84iNmZ+d3NOF5zpTLRCnpPVsW+XNuMuG0t8iGJUyZGOLaeaXQN2/ahPiFO6T8WY3
	adkJXGhA8yafXPdCP9WfZh+T+O1NWqEVuUaYmvliH9Zw+s31dVP9Hohlvg5iUmXVqFcBforPwFxhH
	xufiOwrCQrG1TpFeZIsCaWQLhEbxC2QE+opF510AVBGdl9ULxt+hYbqZrTLFaC5kEDNgirmXke6g1
	pX4QN4SS5yEeRUJKqLh0ZVY+3mmu8EqTlNy+ox78379iFAm6l14LXzpbJMramevJocXH3wx4oeZfI
	sfszIZzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qElSG-0008IK-2z;
	Thu, 29 Jun 2023 06:48:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qElSD-0008Hq-39
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688021311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hPvuAAm3tIsvzZqwXQpG7D9fP9x0u3xCzy3W397eHSk=;
	b=ANTUhvQaxp9D51BMbBIiD9BN3WQ74YOHEV8mTeiDBZXxaJwvQSmDu79wSO7QMgp8XkSxKO
	VgOLRmR1cc/6xjgk5G8hHuQHXm2YNJ7fVzxzRZZbPCzm6kubcghMicNLE2nGT/Y+bNqkpx
	eHbF/5BMTCg8ztUYT9gS45KXu317LOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-DTpJf1FyMd2wDSL1UeWtkw-1; Thu, 29 Jun 2023 02:48:28 -0400
X-MC-Unique: DTpJf1FyMd2wDSL1UeWtkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 931ED1044591;
	Thu, 29 Jun 2023 06:48:27 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8857492C13;
	Thu, 29 Jun 2023 06:48:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH V2] nvme: mark ctrl as DEAD if removing from error recovery
Date: Thu, 29 Jun 2023 14:48:18 +0800
Message-Id: <20230629064818.2070586-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_234834_352186_D803BB24 
X-CRM114-Status: GOOD (  16.65  )
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
V2:
	- patch style fix, as suggested by Christoph
	- document this handling

 drivers/nvme/host/core.c | 9 ++++++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdfcf2781c85..1419eb35b47a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -567,6 +567,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
+		ctrl->old_state = ctrl->state;
 		ctrl->state = new_state;
 		wake_up_all(&ctrl->state_wq);
 	}
@@ -4054,8 +4055,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * disconnected. In that case, we won't be able to flush any data while
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
+	 *
+	 * If this removal happens during error recovering, resetting part
+	 * may not be started, or controller isn't be recovered completely,
+	 * so we have to treat controller as DEAD for avoiding IO hang since
+	 * queues can be left as frozen and quiesced.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD ||
+	    ctrl->old_state != NVME_CTRL_LIVE) {
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


