Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69959C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Nov 2023 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7yQ0x4JAgzz/V6XPhoTmeHuXxKQimQRFyVZVrWx5Gcs=; b=FXBku37VGZ6NljP4sOSabABzgB
	FN790B6uxOBx9fCbId9AuvmgBGQM9uB+V97DC3iWRiWr0Nc2sGN+lqHwnF3dB6Ry0vpLKeTEFtUSw
	yXibszYBJBXkyaRxYnzk4bT7MxgvR0Wiohocuwwj3rwNioXNrY3mjXNWeEayOICqAYkfCvpPZTGoR
	YmXonjyXBjHhVQjacBj7tlGVNR3th5YOI3CdQmhLUwc5yCtjlCtRDDPhALBL3BgnEqEFzhoPfW63L
	lelBeGtss8R+9gnGW3tf/M5wqb/KE0Kza4nZuMy+se/G9xDT6B2aL33Byg7VQtuERRxk1+V3LIsJ2
	lXm9hPpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXX-009cp9-2m;
	Thu, 02 Nov 2023 14:19:19 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXR-009cnz-3A
	for linux-nvme@lists.infradead.org;
	Thu, 02 Nov 2023 14:19:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E200421A48;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698934746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yQ0x4JAgzz/V6XPhoTmeHuXxKQimQRFyVZVrWx5Gcs=;
	b=RNqATwGjdq73BTjBCciDlqTXWt0IFV3UZesf2Fc0gCcoOYSSy0OQP5gj8RssK9v9BZwOn6
	rAW0nzVIS2XsmJa+k1oi3MunSsL4dUtCUWM2ZWEk+8UWhEPGxznT092Gg8crsAaRkUqQoR
	tBGlKwGRpZoU/YeC4bPvt6lp7e5+bXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698934746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yQ0x4JAgzz/V6XPhoTmeHuXxKQimQRFyVZVrWx5Gcs=;
	b=gvwMYBo4fKZl/OzH2Zy6zO0asVUygyePY6oS0lip6S8e2eHfeahTimzD5qDluCcTDrOUFs
	Q6YMT9ivdSpEAPAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 99F122CD95;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C9F5351ECABD; Thu,  2 Nov 2023 15:19:06 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on install_queue()
Date: Thu,  2 Nov 2023 15:19:02 +0100
Message-Id: <20231102141903.66515-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231102141903.66515-1-hare@suse.de>
References: <20231102141903.66515-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231102_071914_187633_454F4E97 
X-CRM114-Status: GOOD (  15.83  )
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

nvmet_rdma_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that move the check for any pending queue disconnects
to the 'install_queue()' callback. This replicates what the tcp
code is already doing, and also allows us to return a
'controller busy' connect response until all disconnects
are completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..8e011bdec3b0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1582,11 +1582,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		goto put_device;
 	}
 
-	if (queue->host_qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
-	}
-
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
 		/*
@@ -1975,6 +1970,24 @@ static void nvmet_rdma_remove_port(struct nvmet_port *nport)
 	kfree(port);
 }
 
+static u16 nvmet_rdma_install_queue(struct nvmet_sq *sq)
+{
+	if (sq->qid == 0) {
+		struct nvmet_rdma_queue *q;
+
+		mutex_lock(&nvmet_rdma_queue_mutex);
+		list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
+			if (q->state == NVMET_RDMA_Q_DISCONNECTING) {
+				mutex_unlock(&nvmet_rdma_queue_mutex);
+				/* Retry for pending controller teardown */
+				return NVME_SC_CONNECT_CTRL_BUSY;
+			}
+		}
+		mutex_unlock(&nvmet_rdma_queue_mutex);
+	}
+	return 0;
+}
+
 static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 		struct nvmet_port *nport, char *traddr)
 {
@@ -2014,6 +2027,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.remove_port		= nvmet_rdma_remove_port,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
+	.install_queue		= nvmet_rdma_install_queue,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
-- 
2.35.3


