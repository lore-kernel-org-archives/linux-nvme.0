Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F23C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKWW8GAQhmAtS8uQDZD6eBnK5TVSsGSEJitesv9am/I=; b=jfieQRTuVN2PoDa9owHB69il75
	QB/TIlod5UjEsiNTjl05X2tIUKv1XPuPu9WqCUu2AwOqZp9Wq61vyt7TCRoxwzFB9O5OfTNcJ8Ehd
	m3ZjhCQiE66e02l3cdX2/F7Iia7WA5fWG1dl8/R2J4Eq0+9dBtmMIOpB3KNNNods0wLbdyzqre9vM
	mTSvgvivsuxt9AH3x9+A3LPTPaScoCxhDxeUofVndmQdQjbtoJ9c+ZYKlacpslwbfNURniy386gQt
	gtXCq0ABr7ZDhRC5nmsXE/faH56MzKnRhPUXMsBf9bXHVJr9TyRZL9VgH8C6F4EwCVop+As/UN9IP
	F0Y07lxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vte-00DE14-08;
	Tue, 30 May 2023 09:44:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vtb-00DE02-0H
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 09:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685439842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKWW8GAQhmAtS8uQDZD6eBnK5TVSsGSEJitesv9am/I=;
	b=QEIpdXyRAk+NsCxU1+iaXUd0IljnvmxoHUxFE5RunbdBqFIY+Xf71QKkPvgHjPyeeF5N9R
	nfUWg9xNSe9HHwbgmAguKxCpWDRawcE8N4IBm+y3lsDMIf3SIf6b6yPDB8gc7yyOZ7khs3
	8M6Y6wsSIN7ZLCyIJW5ycVVmDgYUuQM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-LFG5OHVdOL6MQ9wCCVPA2g-1; Tue, 30 May 2023 05:43:55 -0400
X-MC-Unique: LFG5OHVdOL6MQ9wCCVPA2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90B9C2A59566;
	Tue, 30 May 2023 09:43:54 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87DCB492B00;
	Tue, 30 May 2023 09:43:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] nvme: add API of nvme_delete_dead_ctrl
Date: Tue, 30 May 2023 17:43:21 +0800
Message-Id: <20230530094322.258090-2-ming.lei@redhat.com>
In-Reply-To: <20230530094322.258090-1-ming.lei@redhat.com>
References: <20230530094322.258090-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_024403_198880_51F61358 
X-CRM114-Status: GOOD (  16.39  )
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

When driver confirms that the controller is dead, this controller should
be deleted with marking as DEAD. Otherwise, upper layer may wait forever
in __bio_queue_enter() since the disk won't be marked as DEAD.
Especially, in del_gendisk(), disk won't be marked as DEAD unless bdev
sync & invalidate returns. If any writeback IO waits in
__bio_queue_enter(), IO deadlock is caused.

Add nvme_delete_dead_ctrl() for avoiding such kind of io deadlock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f8..413213cfa417 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -227,16 +227,38 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 	nvme_do_delete_ctrl(ctrl);
 }
 
-int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
+static int __nvme_delete_ctrl(struct nvme_ctrl *ctrl,
+			      enum nvme_ctrl_state state)
 {
+	if (state != NVME_CTRL_DELETING && state != NVME_CTRL_DEAD)
+		return -EINVAL;
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
+	if (state == NVME_CTRL_DEAD) {
+		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD))
+			return -EBUSY;
+	}
 	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
 		return -EBUSY;
 	return 0;
 }
+
+int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
+{
+	return __nvme_delete_ctrl(ctrl, NVME_CTRL_DELETING);
+}
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
+/*
+ * Called when driver confirmed that the controller is really dead
+ */
+int nvme_delete_dead_ctrl(struct nvme_ctrl *ctrl)
+{
+	return __nvme_delete_ctrl(ctrl, NVME_CTRL_DEAD);
+}
+EXPORT_SYMBOL_GPL(nvme_delete_dead_ctrl);
+
 static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..8f62246a85be 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -828,6 +828,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
+int nvme_delete_dead_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
-- 
2.40.1


