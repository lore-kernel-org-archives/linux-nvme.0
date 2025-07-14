Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359DFC83F27
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZh04BvcdXof77idx7pqKds/KXt0Lv+QqBG939b7sdY=; b=rkfu3xQImwIVSGIQIxps2O3BxD
	VMnF2EjrVuXCg5rZzkUQIkMrXlv2Y/Q5AajWspOxJTqPTlsW3EPjGgxSK2bWFQPy3HT8Ku/LPEsa1
	hfUZNryGH/47ET4IBdbiFdf5AxwvSqQwvP6Ld5G3lQ9+o5zykck+vwVSAhYeveFQCXkMsxVSW66hW
	bL1FDbIkL7fK9uNb3+bFzkNpvlIGH4ZKr5/uGk1JAhjBj5/02fPaXd9BZ5cdQTUJsmjs5yy2eZUG6
	sat5tvTQ09AoPTq2Mn0Xfho2fClRW9cTSbZUCGrAo/zZ4MR3lHFj2Y5nCluvjEfy08LiJh3/MivI6
	ponXu7+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIe-00000001kcS-27WP;
	Mon, 14 Jul 2025 09:16:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXn-3mP3
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ECF494646D;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A805AC4CEFC;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=WsX7hcIyFm4dMbAOUYGrKt7OTqWvO82Aiuj8j74Pk2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gs4tMdyvdrRzvUzYONF33NlvkeriwOemS+NJ4wCckTPn17RzUebzIOeO99wCpx8d4
	 xNeZJv7aVZQ2zXOnvY4NwgLIchcyHvNAvyhxlnHdhEVxn0Cb3YPUlsUVMs0aClHchB
	 2h7LqiEbOSXbz8cAYXLYbcNe1T7DXF38OF3iVTR2YeUn1owym/ATKf1RqJxGdlEhpR
	 J06UUcb21yyh9ubmcY7tZkd3YHZ3JziKzpdkR75Pur32bCzx+zOQctsRO9i8wlaqyA
	 MYcPiRuCf4dE1AOwaXHizucDrnmsGVM4yzCuvIKt2EtKMfuogR/wmV4k3VqyH0pV4q
	 atkpG0HejxA/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F51C83F1B;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:35 +0200
Subject: [PATCH RFC 4/8] nvme: Add function to create a CDQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-4-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4559;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=WsX7hcIyFm4dMbAOUYGrKt7OTqWvO82Aiuj8j74Pk2Y=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yut+CRAAF2WeI+nxckU5chr/WGQv7bQHt
 FAOvSuXctaGz4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrrAAoJELqXzVK3
 lkFPqRoL/0XZbSFA0Z2nGnWPGUR+nDcg3bcZCUu7fGNOpcwQKJ5uipw/kkiNNcID9aSTLudHjs9
 0qg9zoaefDbkmNrEakQzuzvPqOM94GGfhBNx9KiiStNK0f1wFw9PP5MocKZAb6Hp5LMfkWFKmpx
 7gZkeyXjxGkXggB38G53jV31n8WuFfALwTuUGfTkYJWLaLresYSSZbPCeuip5TPoC4gw7K277bH
 d/xU5BMDwl/5GdDKDZDl1ebMwlX/ZVyxf6cbYsebTa4rusuaaYlX7N4Sv7wS+PXRp4eSyi4TkJh
 +ihoXlYKbNh9zEn50wFgsubKCJSu9MLHAvTNF3/dRW3qmL+d6TYJvDbQBXCvSd7U3/mokozFAEt
 LtmvhMfBtzfINKlbYzcUdT6agL4aHci7+1fhJKQmUCMFTQEVkYJmYoZbjPVxcim/DiYM99WkdGx
 8KPW1Ib5RRXDPEO0yiJ8WBr67ca/yRdxY5ruF5nYC1wJ3nzhacmGbMJ0R3c8s6xq0hKcC17AY55
 0I=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_021633_015093_9CCDCFDE 
X-CRM114-Status: GOOD (  16.90  )
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

On CDQ initialization:
* The memory holding the CDQ structure (struct cdq_nvme_queue) is
  allocated,
* DMAable memory for the entries is allocated.
* A CDQ create command is sent to the controller
* The newly created CDQ is stored in ctrl->cdqs
* A CDQ file descriptor is created
* The CDQ id returned by the controller and the file descriptor value
  are returned to the user

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   4 ++
 2 files changed, 120 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8517253002941e1f892e62bb7dacac40395b16d9..81b7183a4e3167290e68dc2eb26a8dbcd88c7924 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1319,6 +1319,122 @@ static const struct file_operations cdq_fops = {
 	.read		= nvme_cdq_fops_read,
 };
 
+static int nvme_cdq_fd(struct cdq_nvme_queue *cdq, int *fdno)
+{
+	int ret = 0;
+	struct file *filep;
+
+	*fdno = -1;
+
+	if (cdq->filep)
+		return -EINVAL;
+
+	filep = anon_inode_getfile("[cdq-readfd]", &cdq_fops, cdq, O_RDWR);
+	if (IS_ERR(filep)) {
+		ret = PTR_ERR(filep);
+		goto out;
+	}
+
+	*fdno = get_unused_fd_flags(O_CLOEXEC | O_RDONLY | O_DIRECT);
+	if (*fdno < 0) {
+		ret = *fdno;
+		goto out_fput;
+	}
+
+	fd_install(*fdno, filep);
+	cdq->filep = filep;
+
+	return 0;
+
+out_fput:
+	put_unused_fd(*fdno);
+	fput(filep);
+out:
+	return ret;
+}
+
+static int nvme_cdq_alloc(struct nvme_ctrl *ctrl, struct cdq_nvme_queue **cdq,
+			  u32 entry_nr, u32 entry_nbyte)
+{
+	struct cdq_nvme_queue *ret_cdq = kzalloc(sizeof(*ret_cdq), GFP_KERNEL);
+
+	if (!ret_cdq)
+		return -ENOMEM;
+
+	ret_cdq->entries = dma_alloc_coherent(ctrl->dev,
+					      entry_nr * entry_nbyte,
+					      &ret_cdq->entries_dma_addr,
+					      GFP_KERNEL);
+	if (!ret_cdq->entries) {
+		kfree(ret_cdq);
+		return -ENOMEM;
+	}
+
+	*cdq = ret_cdq;
+
+	return 0;
+}
+
+static void nvme_cdq_free(struct nvme_ctrl *ctrl, struct cdq_nvme_queue *cdq)
+{
+	dma_free_coherent(ctrl->dev, cdq->entry_nr * cdq->entry_nbyte,
+			  cdq->entries, cdq->entries_dma_addr);
+	kfree(cdq);
+}
+
+
+int nvme_cdq_create(struct nvme_ctrl *ctrl, struct nvme_command *c,
+		    const u32 entry_nr, const u32 entry_nbyte,
+		    uint cdqp_offset, uint cdqp_mask,
+		    u16 *cdq_id, int *cdq_fd)
+{
+	int ret, fdno;
+	struct cdq_nvme_queue *cdq, *xa_ret;
+	union nvme_result result = { };
+
+	ret = nvme_cdq_alloc(ctrl, &cdq, entry_nr, entry_nbyte);
+	if (ret)
+		return ret;
+	c->cdq.prp1 = cdq->entries_dma_addr;
+
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, c, &result, NULL, 0, NVME_QID_ANY, 0);
+	if (ret)
+		goto err_cdq_free;
+
+	cdq->cdq_id = le16_to_cpu(result.u16);
+	cdq->entry_nbyte = entry_nbyte;
+	cdq->entry_nr = entry_nr;
+	cdq->ctrl = ctrl;
+	cdq->cdqp_offset = cdqp_offset;
+	cdq->cdqp_mask = cdqp_mask;
+
+	xa_ret = xa_store(&ctrl->cdqs, cdq->cdq_id, cdq, GFP_KERNEL);
+	if (xa_is_err(xa_ret)) {
+		ret = xa_err(xa_ret);
+		goto err_cdq_free;
+	}
+
+	ret = nvme_cdq_fd(cdq, &fdno);
+	if (ret)
+		goto err_cdq_erase;
+
+	*cdq_id = cdq->cdq_id;
+	*cdq_fd = fdno;
+
+	return 0;
+
+err_cdq_erase:
+	xa_erase(&ctrl->cdqs, cdq->cdq_id);
+
+err_cdq_free:
+	cdq_id = NULL;
+	cdq_fd = NULL;
+	nvme_cdq_free(ctrl, cdq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_cdq_create);
+
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 800970a0bb87f7a3b6e855f56a2493a7deed1ecd..ddec5b44fe022831280458ed9fc1cb1ed11633b7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1207,6 +1207,10 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
+int nvme_cdq_create(struct nvme_ctrl *ctrl, struct nvme_command *c,
+		    const u32 entry_nr, const u32 entry_nbyte,
+		    uint cdqp_offset, uint cdqp_mask,
+		    u16 *cdq_id, int *cdq_fd);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);

-- 
2.47.2



