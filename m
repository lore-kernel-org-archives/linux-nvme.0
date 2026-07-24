Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9287C53216
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfAHP1CoDFQ3xJNdW+4dmdb+d8fktbABd1fue+t8Y+o=; b=nvmGiSBd5NcL2C9RvWH5HLQAKa
	cgF6dPg7hBvXTp8zAJW1WCzfJgaqPLTqs5gjEHn/jXJtrmKSjRHi2CPikFRE9vYrz+1WNWz6B0q1G
	PQsU599cgalDS3SL6PmUvTxw4Ki+Emda7Rfq8NUDKfqvfGTEY2bpMaCHKw+Gqn0orFQPHKx98K9LS
	kGmPQxHoT+mGjqDHNYyqzNEwAnr9ogzRHTcfp6yvrlOeD0I7118JmM817rqcclEAW49+XbrDcD3l+
	0POOkGquuNOOZcD4Kgs0HGi961PmX/yNfsMiLha6iMDZvQvIddID/CHkSvS0w30l3bgtWhAecFfTe
	YfEuEaTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoX-0000000GFAc-22XO;
	Fri, 24 Jul 2026 11:11:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF7F-0JLd
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 637E460A61;
	Fri, 24 Jul 2026 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A848DC4FF75;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=OBk+pHhS1EgYqmXtorRqQcAHABFfQD7THUrxKhZ6gqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YYUW9CwRTCTPXefWsjQXc8vKhcDI/MjpuPST/2wKQDsHGt8U8d+j73b5X7wjrPkRS
	 6c4s75gB+gfOfarRVLM/2G0FJo7Uatr6R2XwFbtTUOV6AYsWe/Q4DC5Fj3KnOhUazP
	 p3mDKrCq07/IoBXUOPFhKMI7Jyo1tXyNBBXKdzQKIqTYfPl7vQII0B6sa+lUhclF1h
	 AiSy8ssyDgXOEF23V+hIlgmu68i/syCQ1RR2F09p7vRxpQ6J2VqYfjXSlLRDa8CJ5I
	 OEaeupLArEn25ebfInyNvHSZa38rcLp7zl8poUuWHmblFOGnH3lwHRycI83YJlYvVn
	 mReG6Z0UtPI6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D8C531FA;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:11:01 +0200
Subject: [PATCH RFC v2 07/14] nvme: Add the create CDQ functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-7-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5058;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=OBk+pHhS1EgYqmXtorRqQcAHABFfQD7THUrxKhZ6gqc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFzcopeYI1fdpWY2cOMQOB0l6oBmK7S2p
 yxrYkxBIAn3GYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0hcAAoJELqXzVK3
 lkFPWxoL/irh/wA6FJ5rtOyyCO8vmaIeVuRLIE1U4zKdetp0Bp+CJrsHgG/5qXRihGwDCNsaOXM
 zxADKVsK2Umms2vxXiiYndtxXxNCoOW5QasGzfzhBHKCrT5Icsez5On/7BAE2Zpa/VzlPqgBkXR
 j5aKInfTsu/GvSFDgp3VJxftM0WjWcGAhNBv8io89/qP5FTK6T945LwmP+B6zQJ5FlFre9vkjNh
 /j0EHALpoZ4Zyqlpi+rVw6apyzb9Oa4S2Z2Xi8++qIHI8SMKR2H1E5vQcP7mNztTP/IuhHF5hj2
 GnqOidLiMvxKHhwOWiM6XHTYU0nZdirBHmN3Tih7TDuwDC/d/Un37LJvJ4vbPebA2h8e2jXqnkp
 +ptz6z+nz2YBKZlpH+vAbj8ARFGHFcLJowk9zMB/uAkI6Rbzm28ehAazGmz8y0Y9FT2bVnoNmgg
 7R4J6IbQxXTMcMLsFWvxrSjwncx60nqeqSJKWDlv6gUDeJUu93K2Na8rf7fK8uSph0L+cXyJMP5
 PM=
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

The CDQ create allocates the struct cdq_nvme_queue, allocates the memory
for the CDQ entries, sends the nvme command to create the CDQ at the
controller side, creates the file descriptor for user space and inserts
the CDQ struct in the controller cdqs xarray.

Note that:
* All memory that is to be shared with the controller needs to be setup
  before calling nvme_submit_create_cdq_cmd.
* Initializing the refcount before sending the create cmd to the
  controller "assigns" the reference to the controller. In other words,
  that cdq is being used by that controller.
* The creation of the cdq file descriptor is at the end because
  everything needs to be in place for when the user calls read. The FD
  will be "installed" once nvme_create_cdqfd returns.
* nvme_submit_create_cdq_cmd must come before xa_insert as the cdq is
  inserted to the xarray with the id returned by the controller

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/cdq.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/cdq.h |  4 ++-
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/cdq.c b/drivers/nvme/host/cdq.c
index 63c0852e0ba17a17227b9a0189be5123358a2262..b1776637191db5747053bdcf4bdf97ef44a66566 100644
--- a/drivers/nvme/host/cdq.c
+++ b/drivers/nvme/host/cdq.c
@@ -154,9 +154,6 @@ static inline int nvme_create_cdq_backing(struct cdq_nvme_queue *cdq)
 			goto err_chunks;
 	}
 
-	/* FIXME: put this on the create_cdq function*/
-	kref_init(&cdq->ref);
-
 	return 0;
 
 err_chunks:
@@ -273,6 +270,93 @@ void nvme_delete_cdq(struct cdq_nvme_queue *cdq)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_cdq);
 
+static int nvme_submit_create_cdq_cmd(struct cdq_nvme_queue *cdq)
+{
+	int ret;
+	union nvme_result result = {};
+	struct nvme_command c = {
+		.cdq.opcode = nvme_admin_cdq,
+		.cdq.sel = NVME_CDQ_CMD_MGMT_CREATE,
+		.cdq.mos = cpu_to_le16(NVME_CDQ_CMD_MGMT_CREATE_MOS_QT_UDMQ),
+		.cdq.dw11.cqs = cpu_to_le16(cdq->mc_id),
+		.cdq.cdqsize = cpu_to_le32(cdq->size_nbyte >> 2) // size is in dwords
+	};
+
+	if (cdq->nr_chunks < 2) {
+		c.cdq.dw11.flags = cpu_to_le16(NVME_CDQ_CMD_MGMT_CREATE_PC_CONT);
+		c.cdq.prp1 = cpu_to_le64(cdq->chunks[0].dma_addr);
+	} else {
+		c.cdq.dw11.flags = cpu_to_le16(NVME_CDQ_CMD_MGMT_CREATE_PC_DISCONT);
+		c.cdq.prp1 = cpu_to_le64(cdq->prp_lists_dma[0]);
+	}
+
+	ret = __nvme_submit_sync_cmd(cdq->ctrl->admin_q, &c, &result, NULL, 0, NVME_QID_ANY, 0);
+	if (ret)
+		return ret;
+
+	cdq->id = le16_to_cpu(result.u16);
+
+	return ret;
+}
+
+int nvme_create_cdq(struct nvme_ctrl *ctrl, const u32 entry_nr, const u16 mc_id)
+{
+	u64 size_nbyte = (u64)entry_nr * NVME_CDQ_MQ_ENTRY_NRBYTES;
+	struct cdq_nvme_queue *cdq = NULL;
+	int ret, cdq_fd;
+
+	/* The backing size and the CDQSIZE field are both u32 (bytes). */
+	if (size_nbyte > U32_MAX)
+		return -EINVAL;
+
+	cdq = kzalloc_obj(*cdq);
+	if (!cdq)
+		return -ENOMEM;
+
+	cdq->mc_id = mc_id;
+	cdq->ctrl = ctrl;
+	cdq->size_nbyte = (u32)size_nbyte;
+
+	ret = nvme_create_cdq_backing(cdq);
+	if (ret) {
+		kfree(cdq);
+		return ret;
+	}
+
+	kref_init(&cdq->ref);
+
+	ret = nvme_submit_create_cdq_cmd(cdq);
+	if (ret)
+		goto del_cdqmem;
+
+	ret = xa_insert(&cdq->ctrl->cdqs, cdq->id, cdq, GFP_KERNEL);
+	if (ret)
+		goto del_cmd;
+
+	ret = nvme_create_cdqfd(cdq, &cdq_fd);
+	if (ret)
+		goto del_xarray;
+
+	return 0;
+
+del_xarray:
+	nvme_delete_cdq(cdq);
+	/*nvme_delete_cdq, has everything */
+	return ret;
+
+del_cmd:
+	if (nvme_submit_delete_cdq_cmd(cdq))
+		WARN_ONCE(1, "Failed delete CDQ (id: %d)", cdq->id);
+
+del_cdqmem:
+	/* puts the ref acquired by kref_init */
+	nvme_release_cdq_backing(cdq);
+	nvme_cdq_put(cdq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_create_cdq);
+
 /* Will NOT send a CDQ delete NVMe cmd. */
 void nvme_delete_cdqs_host(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/cdq.h b/drivers/nvme/host/cdq.h
index 8c003aa75bd3e4df9a5f8af7ff21d1957dd43923..773f93817d498784450eb0c8c9ab00a95f0657dc 100644
--- a/drivers/nvme/host/cdq.h
+++ b/drivers/nvme/host/cdq.h
@@ -11,7 +11,7 @@
 #define NVME_CDQ_MQ_ENTRY_NRBYTES	32
 
 /*
- * The CDQ backing is a set of coherent DMA chunks. Chunk size expressed in
+ * The CDQ backing is a set of coherent DMA chunks expressed in
  * host pages to match dma_alloc_coherency granularity.
  */
 #define NVME_CDQ_CHUNK_ORDER		2
@@ -31,6 +31,7 @@ struct cdq_nvme_queue {
 	u16 id;
 	struct nvme_ctrl *ctrl;
 	u32 size_nbyte;
+	u16 mc_id; // migratable controller id
 
 	/* Coherent backing store. */
 	struct nvme_cdq_chunk *chunks;
@@ -62,6 +63,7 @@ static inline void nvme_cdq_put(struct cdq_nvme_queue *cdq)
 }
 
 void nvme_delete_cdq(struct cdq_nvme_queue *cdq);
+int nvme_create_cdq(struct nvme_ctrl *ctrl, const u32 entry_nr, const u16 mc_id);
 void nvme_delete_cdqs_host(struct nvme_ctrl *ctrl);
 void nvme_free_cdqs(struct nvme_ctrl *ctrl);
 

-- 
2.50.1



