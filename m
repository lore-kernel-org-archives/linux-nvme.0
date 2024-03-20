Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A33C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qIjNti2RM2O1PLslBBRl/TdggFnifzzHK3EQ88lP6S4=; b=ex+B+j0QouKNKjbI+ZDBkMTB/+
	Ii/8ZArT7C1PrHQSP2ME1UI0L4QjuGq23hWcQrYA9RJBbQ42DkQOwYbi9d/Y96Sf4W+ho7a3WlE5K
	/SARusgvgdMxKwaJwRtuqb1KrI6J235FA+zpDbsVnlrOuP9cNXfD4seN9KWi7CcaOrJSiXlCVOuTd
	EzK8/k/rwixUQe0ybFE/bBxVr53RFPT9/gS0q3h6Q/u8MtedfKBN9Z0tdPsfNao5TOp/m2xrW3YeK
	5y0b4vs0NQWMgC2CW3Sg5kZ9agNX/EcO7Zu7+7WT3/cUHbsAqe8JNBn+Mu9p91UiQs/6FbjOC5lxE
	7M1YGagA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms7q-0000000GSE0-30Jp;
	Wed, 20 Mar 2024 09:20:46 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms7n-0000000GSCf-2YNt
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 09:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710926440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qIjNti2RM2O1PLslBBRl/TdggFnifzzHK3EQ88lP6S4=;
	b=oZHi7cnsZ86SJQS1PoWOD9hryeaVHk5T43XoU5m8+83woqfcCUINxFvI7YfXMqBmrQP/zPmM2gqHTV+ZV1VGJ/viBRP3oEyi3BPMnmaUNXaW0MhpTXuHSrlCUrXqOT8XRYqCdGnWOEt0pIpn/0gjVdrUp2o2KNFHy7CSbPc0xgo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2ws40s_1710926435;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2ws40s_1710926435)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 17:20:39 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Date: Wed, 20 Mar 2024 17:20:35 +0800
Message-ID: <20240320092035.22546-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_022043_956670_6A75108F 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

We can simply use invalidate_rkey to check instead of adding a flag.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/rdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f2bb9d95ecf4..d0bc72c75471 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -53,7 +53,6 @@ struct nvmet_rdma_cmd {
 
 enum {
 	NVMET_RDMA_REQ_INLINE_DATA	= (1 << 0),
-	NVMET_RDMA_REQ_INVALIDATE_RKEY	= (1 << 1),
 };
 
 struct nvmet_rdma_rsp {
@@ -722,7 +721,7 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	struct ib_send_wr *first_wr;
 
-	if (rsp->flags & NVMET_RDMA_REQ_INVALIDATE_RKEY) {
+	if (rsp->invalidate_rkey) {
 		rsp->send_wr.opcode = IB_WR_SEND_WITH_INV;
 		rsp->send_wr.ex.invalidate_rkey = rsp->invalidate_rkey;
 	} else {
@@ -905,10 +904,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 		goto error_out;
 	rsp->n_rdma += ret;
 
-	if (invalidate) {
+	if (invalidate)
 		rsp->invalidate_rkey = key;
-		rsp->flags |= NVMET_RDMA_REQ_INVALIDATE_RKEY;
-	}
 
 	return 0;
 
-- 
2.43.0


