Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15CC83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lejKEUJIW6Y+ZZwRs8roJXkOWbTC/Hg3Fc1xiSUTchI=; b=xQbKHBXmMfdAH2Abf8t6RRTZSO
	zP1wVJEoVUnh9I9PNBVC2RnWC7Qp49lImm8tGji/GhO4M9oCv70YzyvNU0tdu8bmmF+cJGawbaAF6
	/kyCCCp8cTpgu4qEbvYPjrCjIKmhJOHBmeutRJYuhzPgOJF3jxZ9D4SysMjjPOp0VKk/fVKHukZc4
	lNgW6H9iAPKgmRP6wKDc1qUrARH0bW6D6Zan9lSc1RyZzgNpoFo2fXDfBXWQFv20ZSzxvdZNzmadP
	pVGrnJQhX3CckNy3cJ7FG3JXIQuiZ1KDqeBF55Q5GoWPfbQtJymDDUpWjJJf5FGKj1pHtQ4Dq4+4M
	I6KxUyog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIb-00000001kae-2JAH;
	Mon, 14 Jul 2025 09:16:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXt-348x
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 26CE761434;
	Mon, 14 Jul 2025 09:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5C76C4AF0B;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=h/8HKJiIxonpUreNA5H+hoWGCKVY95KaVnm3Y8PyTeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SUroSGtRJ9z82LXiBynUM1EcVsoNxv2tVbZNstl1sgpg3pGkbEm0ON1hAR+PdZoV6
	 lCoIm6f6qGAEvuXn0xnP/A2L9wqrdCk88n3NAsyyHWNQF6vfLbD/9nvuZYQ7Z+nGNN
	 qcdiEEeCcuyIzqG9HQ9KsX7rTObExamHrYyRcZXUJrNiW6GQcnFa+5dMv94UzUHbxK
	 xzuCd4MMolbHj3uiVNNdobVWduzH1gi9gTp5/VdWvYLltiqTmvIuMkHK3Lw7FNBm2P
	 23agrba6zX/JyloeMS4f7cpHcKRAT+b6kLsxVjMkU85O5Vk1wQhHPJACQV20BfKwNR
	 xBWW2UKB9krUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75FC83F1A;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:36 +0200
Subject: [PATCH RFC 5/8] nvme: Add function to delete CDQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-5-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=h/8HKJiIxonpUreNA5H+hoWGCKVY95KaVnm3Y8PyTeQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuudcGZUR2uVvVZVbTvw7vHJi5lLEu15d
 lrtXTGNT5iAAYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrrAAoJELqXzVK3
 lkFPgA4MAJnh8BX1id2J+lN8ZFOg/K6xgneL3zZWCqjDcUOU1mvQsFqK1ymrCwSHqfA/4HcwV5A
 vdKcwXkvwNRfuEA7u7IsQG07hccZ1NKIVv0lwyPIlAjmoqL2RxrviO+RLOVRckf2ce4Dka4+N69
 eh3zYsfP2G0K9Gjc0kxt5PcZ4X+lgE0o1+m9fdS3R5smtjlfp33mmM0GpFqSadzML8HmmloMqdv
 9S2A0Ss8DVuK6HQl4j+ulYPUX+7l67hDSvM6m/PVNC6A6L7fCu/JdUnMQrjmeWn3nmJ1KXRDbEv
 LjMHmPDdftztDRvHLLuXvqvAxj1nEnNpWHqk1uPG3+A9fCC/HK8GAj9Z128CU8HuwgLJ6HEvOcO
 5a+S6YWfCi6hKsz/5vUhaVPQvhQbKCTNw+kWTaxQZL2B0z3yYzcmCzktP3xtCpeaMruF5R6m+8k
 FEZNOYkcX/c1spi/xH+npL322AklGng6uFcyd91Nf9GlU0CU9mUW69t7nNtLmxuJSF24u0oVv5+
 AE=
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

The delete function frees the memory held by the CDQ pointer, removes it
from the xarray and submits a NVME command informing the controller of
the delete. Call cdq delete on nvme_free_ctrl.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 81b7183a4e3167290e68dc2eb26a8dbcd88c7924..427e482530bdb5c7124d1230f35693ba756ce4d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1435,6 +1435,41 @@ int nvme_cdq_create(struct nvme_ctrl *ctrl, struct nvme_command *c,
 }
 EXPORT_SYMBOL_GPL(nvme_cdq_create);
 
+int nvme_cdq_delete(struct nvme_ctrl *ctrl, const u16 cdq_id)
+{
+	int ret;
+	struct cdq_nvme_queue *cdq;
+	struct nvme_command c = { };
+
+	cdq = xa_erase(&ctrl->cdqs, cdq_id);
+	if (!cdq)
+		return -EINVAL;
+
+	c.cdq.opcode = nvme_admin_cdq;
+	c.cdq.sel = NVME_CDQ_SEL_DELETE_CDQ;
+	c.cdq.delete.cdqid = cdq->cdq_id;
+
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, NULL, 0, NVME_QID_ANY, 0);
+	if (ret)
+		return ret;
+
+	nvme_cdq_free(ctrl, cdq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_cdq_delete);
+
+static void nvme_free_cdqs(struct nvme_ctrl *ctrl)
+{
+	struct cdq_nvme_queue *cdq;
+	unsigned long i;
+
+	xa_for_each(&ctrl->cdqs, i, cdq)
+		nvme_cdq_delete(ctrl, i);
+
+	xa_destroy(&ctrl->cdqs);
+}
+
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
@@ -5029,6 +5064,7 @@ static void nvme_free_ctrl(struct device *dev)
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
+	nvme_free_cdqs(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ddec5b44fe022831280458ed9fc1cb1ed11633b7..07a1a9e4772281d68d0ade0423372a35f9f7055e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1211,6 +1211,7 @@ int nvme_cdq_create(struct nvme_ctrl *ctrl, struct nvme_command *c,
 		    const u32 entry_nr, const u32 entry_nbyte,
 		    uint cdqp_offset, uint cdqp_mask,
 		    u16 *cdq_id, int *cdq_fd);
+int nvme_cdq_delete(struct nvme_ctrl *ctrl, const u16 cdq_id);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);

-- 
2.47.2



