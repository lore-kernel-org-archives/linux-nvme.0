Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7D4C531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yN0BHjSTHsA+bB6nUdXh/FQpOSTBsDUyYUP6yTBu078=; b=eawuT22I6UcwwbZR0vaYT4yn0e
	3FVmuBOfxDBAVk0Yc9krMqGeKfKWGgOBEz3x2s7QsF+lGfczC3TIasTW2FCNUySDA1vvFGgoGt35X
	ROJ/6b9O2bSHHJPD+1m5hSW7PkaiRgG76u+vKjiyzPzvjgY71VJ3lLGcOkEA8j2KvtryOq3holCQQ
	KWdc5mwQpxP889qQF6yyKRCtnhF+g1D7+gnn9/aGUoEJoGJhooyiMBeOz6GL7qA7kgWDXiClmVz67
	pInkxIKCPMGkNSzE9butvXv6C8pq7WW+Sgb5eut4mN9zFdck471S3nl+hYlcEmRW++sFwHagyH8aX
	S+z3w/1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoe-0000000GFL1-0k4y;
	Fri, 24 Jul 2026 11:11:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDob-0000000GFHP-0t3I
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4352E43C7D;
	Fri, 24 Jul 2026 11:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFDE1C4FF7E;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=TK6sw5sLChDD2H14umlWrgyrMjWvsU5BCPObipz5PyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RjxmS4CqdwWiztuwQyQaVTPT+F30dcu5+HHJLTx6NL2eiFaGbR95xKi4ueh4gY9hU
	 +NYCapdlVkMXSJGJtVaKNxL8U+zYmyCcuB6COfyLFkQi+mTXIZAwJRIjbhFXmfsM0V
	 5jAtj0SIsy5wk2Jbgt7Xf4OAmjlru0CRVTl7Y+VRuiil+aKY+m8SzqCjhE4fsQXkVg
	 tsZqvSPNXoUC9tK7no+OJcyRdMbUzOSzXxT1TQiwyAGpSBCCQyDDnvlqG/2ALj7+y2
	 HOa/PxS3nadhYm2I/vQwXzC5AW7zfVrzNs0bD1EmVvH2SttUDwB3M4a7GO6WxgGjRf
	 +L7p1nC1XypIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBCC53209;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:11:03 +0200
Subject: [PATCH RFC v2 09/14] nvme: Coordinate CDQ backing mem and CDQ FD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-9-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=TK6sw5sLChDD2H14umlWrgyrMjWvsU5BCPObipz5PyY=;
 b=owJ4nAHsARP+kA0DAAoBupfNUreWQU8ByyZiAGpjSF6CUSvlQHseGsKAdm427Y9qEzQ/VUWdO
 AR/T7ClZ+UfjokBsgQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0heAAoJELqXzVK3
 lkFPx2ML+NaqLg199fgUV85XEXgknviUKpS8KqSiDa4eaaEHsvqN6v4ho19xSXVj0daHjpTZ5Jk
 p+OMxfcBkhqO1pPq/hdxQqh0t9+Eh+jxtO7XMwcArbCVTT5TU8u3eQd9+a+UBN3y1aMNiiX95V+
 ozbooV4le3S0VuMYsHleuBpO/kCqua25ogMJAH10dlYh/1SWqfs3GadVE1pIk2jKbbAOnbVwkN4
 nVZclnt5e1edlrwrFRkP25d1SPfPtaOTbQQQzM5AgDWBXLjaiZpWkjyVAJi/dcHdUIVattGsP5V
 oGcnIm4dnMJU0dXofgsiZMZrZfIEuN/r07KiS9dVNKqkxZdPXCAB6tUAKDrJ8834vIy7NV3e6kX
 6kXhYhV5KVJ8MgYfOk65opzSCRwes4LnT342ev+J8uI5zL1XEblM06T7SdbiBYHpDKyxMheTv+o
 tNSWAjMAT8u9waUneiS6N6+jbDdpuQu3HIzYiPtxz8Zw9tbtRWfU2syBMP8hO7gikstWGUuTPrB
 A==
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

The user space file descriptor fails if the memory backing the
Controller Data Queue (CDQ) is not "valid". This can happen as part of
the controller tear-down procedure.

Test the valid_mem variable when reading the from the file descriptor.
Set on CDQ creation and unset when the CDQ is being deleted on the host
side.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/cdq.c | 20 ++++++++++++++++++--
 drivers/nvme/host/cdq.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/cdq.c b/drivers/nvme/host/cdq.c
index 0f01b58a9c3145faae83a81627fa5a93cfc03cf4..7fe08afa0d80db5f3d60993aba05624b5c59b309 100644
--- a/drivers/nvme/host/cdq.c
+++ b/drivers/nvme/host/cdq.c
@@ -184,6 +184,9 @@ static ssize_t nvme_cdq_fops_read(struct file *filep, char __user *buf,
 	if (nbytes > (cdq->size_nbyte))
 		return -EINVAL;
 
+	if (!READ_ONCE(cdq->valid_mem))
+		return -EINVAL;
+
 	/* CDQ traversal not implemented yet. */
 	return -EOPNOTSUPP;
 }
@@ -207,7 +210,16 @@ static const struct file_operations cdq_fops = {
 	.release	= nvme_cdq_fops_release,
 };
 
-__maybe_unused
+/* Should only handle cdq struct and ctrl kref */
+void nvme_free_cdq(struct kref *ref)
+{
+	struct cdq_nvme_queue *cdq = container_of(ref, struct cdq_nvme_queue, ref);
+
+	/* Drop the ctrl kref held since creation */
+	nvme_put_ctrl(cdq->ctrl);
+	kfree(cdq);
+}
+
 static int nvme_create_cdqfd(struct cdq_nvme_queue *cdq, int *cdq_fdno)
 {
 	int fdno;
@@ -276,8 +288,9 @@ static void nvme_delete_cdq_host(struct cdq_nvme_queue *cdq)
 	if (xa_erase(&ctrl->cdqs, cdq->id) != cdq)
 		return;
 
-	nvme_release_cdq_backing(cdq);
+	WRITE_ONCE(cdq->valid_mem, false);
 
+	nvme_release_cdq_backing(cdq);
 	nvme_cdq_put(cdq);
 }
 
@@ -342,11 +355,14 @@ int nvme_create_cdq(struct nvme_ctrl *ctrl, const u32 entry_nr, const u16 mc_id)
 	}
 
 	kref_init(&cdq->ref);
+	nvme_get_ctrl(cdq->ctrl);
 
 	ret = nvme_submit_create_cdq_cmd(cdq);
 	if (ret)
 		goto del_cdqmem;
 
+	WRITE_ONCE(cdq->valid_mem, true);
+
 	ret = xa_insert(&cdq->ctrl->cdqs, cdq->id, cdq, GFP_KERNEL);
 	if (ret)
 		goto del_cmd;
diff --git a/drivers/nvme/host/cdq.h b/drivers/nvme/host/cdq.h
index 773f93817d498784450eb0c8c9ab00a95f0657dc..aa9469af0c7ef08b9f8ebf93e468c7f892aee4b1 100644
--- a/drivers/nvme/host/cdq.h
+++ b/drivers/nvme/host/cdq.h
@@ -42,6 +42,9 @@ struct cdq_nvme_queue {
 	dma_addr_t prp_lists_dma[MAX_NR_CDQ_PRPS];
 	unsigned int nr_prp_lists;
 
+	/* True if mem for chunks and prps is valid */
+	bool valid_mem;
+
 	/* Manage refs for read FD and controller xarray */
 	struct kref ref;
 };

-- 
2.50.1



