Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CE3C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+6YT/lrR90qGYj6fVt2al0AL49sJ5Z5pY1GIbM9vgM=; b=t+Q93ULRfYUjuwANVtUQhbuZLZ
	xZZi7TKWubFfKl9QncIit828EvIfNbOjyUlXz23Z8Cb37U7wtAEQ3lHpo66rAZPKGJxZmcMSez2HY
	rC9zdNZTYaTU5nMMzj5OlqTlBo+sf1THL0itTIouZPgQRA/1OewQlA9GqtKGdtjfvvGMf9O2qBW4e
	h2alZpvS5Lg9OD7D/OMzu1DXvyy7tWqrCvm5Z4cEGnXEOAsTGifGiaZpOj+NXFb0axLZPJj/KlB0h
	7wiXoA8OU2PL7rADGA1SYUqolH3T30b38xDYj3uK9QpiKchbX/4w8pYUCrh2HiBeg0NITu1II/o4L
	1OSLm9fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaMF-00Fdpa-2i;
	Fri, 08 Dec 2023 12:53:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaMD-00FdoW-0M
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 12:53:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 528E3623A7;
	Fri,  8 Dec 2023 12:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF07C433C8;
	Fri,  8 Dec 2023 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702040008;
	bh=PyOqw+mI7DbcHgW+W2XJ+966h8roYtG6Qr4dqAhI6u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nd3yII+CNJw7Vtcx+fpnoyEGzDsg7iCekE8I7929WCR+/aU8tclhHqS9iFXntqqJM
	 ooxgX09aQQqM7cofzLUHxsanqS1m6/e70J4F+Pq6Gx2aGRSM3VBj/avQcTL1W9pDNb
	 CLRwB31x2I4Mce8AcT30Px14wTRCv1SPzanp7PXeo1D4ix0Z65Btp1LQ+C7wtlwB3w
	 U+hyBiuhc+YCWl2IRizcyKgf7oq7NyluPmhPHhwujpMXSmuuTtP5cPUyqZoPVNQ/Kv
	 N+iNy72znOTh0is4x5NP1vdz2lF8CJaCI/INpxajtnMy+y/RnrvLW4E6vGVf21+ZUN
	 BbUUYXa07dzOA==
From: hare@kernel.org
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvmet-rdma: avoid circular locking dependency on install_queue()
Date: Fri,  8 Dec 2023 13:53:21 +0100
Message-Id: <20231208125321.165819-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231208125321.165819-1-hare@kernel.org>
References: <20231208125321.165819-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_045329_187086_BB2E568A 
X-CRM114-Status: GOOD (  14.15  )
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

From: Hannes Reinecke <hare@suse.de>

nvmet_rdma_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that check for pending queue in disconnecting status,
and return 'controller busy' when we reached a certain threshold.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..667f9c04f35d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -37,6 +37,8 @@
 #define NVMET_RDMA_MAX_MDTS			8
 #define NVMET_RDMA_MAX_METADATA_MDTS		5
 
+#define NVMET_RDMA_BACKLOG 128
+
 struct nvmet_rdma_srq;
 
 struct nvmet_rdma_cmd {
@@ -1583,8 +1585,19 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	}
 
 	if (queue->host_qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
+		struct nvmet_rdma_queue *q;
+		int pending = 0;
+
+		/* Check for pending controller teardown */
+		mutex_lock(&nvmet_rdma_queue_mutex);
+		list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
+			if (q->nvme_sq.ctrl == queue->nvme_sq.ctrl &&
+			    q->state == NVMET_RDMA_Q_DISCONNECTING)
+				pending++;
+		}
+		mutex_unlock(&nvmet_rdma_queue_mutex);
+		if (pending > NVMET_RDMA_BACKLOG)
+			return NVME_SC_CONNECT_CTRL_BUSY;
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
@@ -1880,7 +1893,7 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 		goto out_destroy_id;
 	}
 
-	ret = rdma_listen(cm_id, 128);
+	ret = rdma_listen(cm_id, NVMET_RDMA_BACKLOG);
 	if (ret) {
 		pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
 		goto out_destroy_id;
-- 
2.35.3


