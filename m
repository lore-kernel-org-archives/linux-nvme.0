Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6263C48BE6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:17:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF66613BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF66613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8R6f/40E6EFW5yosKlcdgUBIM7aonjQj757ULmw0QAI=; b=Yu2K2EoHBj+dKQ
	Ts8uYsvfY4HjmXUgM33cysxgcDZ0pHDfpaKfs7oG9TRERuSJ9LUrpqbqc0VDzLn8dW8XpViZqXA8Q
	XZHAPP1KkoJS3VlmplWxottBNU2OpNg3XIEIr4kOIya1XOPD1ofuiT0zZAnJJvMy29uXLP/KcKHES
	b1uZ42u2XkiGCR4FXNK4S3LUBu86zRhU2/quL8Rz1/ExmrMr9S6E13qYicZ+mcSkzXIEIeJi5+/qd
	pNqQj0xkELJCy03AWVc4DZ6tro0VevAvAsrkq51kXVMwzVnF8pti0idC+13vb8qbZSUfv+BDwxgOA
	B9o88ajLmzsDixvj71Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltdqB-007qca-No; Wed, 16 Jun 2021 22:16:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltdpp-007qY4-D2
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 22:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623881793; x=1655417793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t81tf2zOQGkfZt4qg3ZhNZjt0LV7Jp+rjA0wGJwT1FE=;
 b=ZpqNFFIsVsVkO0qAkyq0r1r8/Gtv2PkilDkzn9DP4LyTlA1x6TRJzGli
 dFqy/zmXcmwOi2UAn57jxg5Cl3jGqdTNQT4giGjM4CVkskSuxKiRwznwJ
 if11LO1JMb1MZMzo1bPikk2SXamskd/HBnQ8Wlraqt+YIJ93K5ODkEDrM
 Mnc7PqDLat84GWTAnpm2bYnQaLR07XH49L5jjnT4L3lssSAvFwW1nUe8I
 x8NlzX8P4TFyt0IZ6HDHUO+IRskZ5x7J1rchcASMg013ZJHMXeNs6Gmwt
 k2qvV/xYHh7QwtehPk/6MLfMyR7OPdb1ztNXcRfL4kAoAuJY4tS17EaEq Q==;
IronPort-SDR: Hv8uTHq2zr7cliMUBUSLHeFVB9+Q2r76LzfaUvpxc7COF2WWvd6SwVXBqC5rEyTjCdzy2uPczF
 MLbu5zNJfWRTqTOpsASiUKMznqUGpHpfqq03NaqJPB6INiRvmP3KyFyLpIMbka5UH+vZ8besmp
 F8pe8jAtjvaGXNWYB0ZuBtp+QBmEFpZEe82KwMewDw5HNfooT5e6ASzBnB/vybCe4pNiTjDzXk
 4dLkxOw+cyso5Npki1m0DxV1IBrT115sCcbSoDgq5g8ESNtep1EKLPl6aSAWn6RsjtzeLaW60Z
 gX8=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; d="scan'208";a="171400633"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2021 06:16:30 +0800
IronPort-SDR: o71GjD2fsPBR5gMbdb0Iyr+Ah1qZKdDE6BnjzgG5mJIsz0GGgNetkzOaQ92YEemPadvytX6qqZ
 X5spn8ouGwNI/USr3bUigbOKKX+RLj3c+g7io5K9wU7/UgGxbqlMFrNWMKK/hS5aIC/E3ZVIy+
 bluFp5vdRuht1/4IRx3lGg7ujpwYcdXJx9S9dOtfoPS+/AC1ejG+MnYzHDMuQddrg2KJT93pEN
 Z5gfffj/af3kchRuvcgxHO81YoLRONKXFN3IJ3yPWVyLi2WxrkbrFv4IVWIAqsBQ4zJtGGA188
 74pg4xzjQmqgfeNDIAhsJvkP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 14:55:20 -0700
IronPort-SDR: Q3ScAehYoGB2F0Qr9rKqprVxKwZGGlei18ZRVU+epVRejTtdIxlwDsAPoBS7TGyRjgR+9e3jHX
 WUgmaPF9X5E3Go0hx6UQCeR2oJnwR4oUqmVeOufH0WTQB1iUyTlqW7PZygwBulPngctPtCz8pT
 0eQQxqYBF0i0odMLJ9usf8S49djxu7x2Ans0idmzsoum+hy0Jp5jOV7dONZJTWXcn/mQDO1xy2
 V7LbkcxwBbpqvhe1ERgxMRjwpRs2ldxcZrvzB6tM4nF3lhn48N5Z7q+ruw9x5bubOSbw0lmGaw
 gqo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2021 15:16:31 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/3] nvme-pci: remove zeroout memset call for struct
Date: Wed, 16 Jun 2021 15:15:53 -0700
Message-Id: <20210616221553.55914-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
References: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_151633_550335_2AE71ACE 
X-CRM114-Status: GOOD (  13.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Declare and initialize structure variables to zero values so that we can
remove zeroout memset calls in the host/pci.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9cdf2099027a..c20acaeac3d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -307,13 +307,12 @@ static void nvme_dbbuf_free(struct nvme_queue *nvmeq)
 
 static void nvme_dbbuf_set(struct nvme_dev *dev)
 {
-	struct nvme_command c;
+	struct nvme_command c = { };
 	unsigned int i;
 
 	if (!dev->dbbuf_dbs)
 		return;
 
-	memset(&c, 0, sizeof(c));
 	c.dbbuf.opcode = nvme_admin_dbbuf;
 	c.dbbuf.prp1 = cpu_to_le64(dev->dbbuf_dbs_dma_addr);
 	c.dbbuf.prp2 = cpu_to_le64(dev->dbbuf_eis_dma_addr);
@@ -1112,9 +1111,8 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = &dev->queues[0];
-	struct nvme_command c;
+	struct nvme_command c = { };
 
-	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 	nvme_submit_cmd(nvmeq, &c, true);
@@ -1122,9 +1120,8 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
-	struct nvme_command c;
+	struct nvme_command c = { };
 
-	memset(&c, 0, sizeof(c));
 	c.delete_queue.opcode = opcode;
 	c.delete_queue.qid = cpu_to_le16(id);
 
@@ -1134,7 +1131,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 		struct nvme_queue *nvmeq, s16 vector)
 {
-	struct nvme_command c;
+	struct nvme_command c = { };
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags))
@@ -1144,7 +1141,6 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
-	memset(&c, 0, sizeof(c));
 	c.create_cq.opcode = nvme_admin_create_cq;
 	c.create_cq.prp1 = cpu_to_le64(nvmeq->cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(qid);
@@ -1159,7 +1155,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
 	struct nvme_ctrl *ctrl = &dev->ctrl;
-	struct nvme_command c;
+	struct nvme_command c = { };
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	/*
@@ -1174,7 +1170,6 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
-	memset(&c, 0, sizeof(c));
 	c.create_sq.opcode = nvme_admin_create_sq;
 	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(qid);
@@ -1255,7 +1250,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_queue *nvmeq = iod->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 	/* If PCI error recovery process is happening, we cannot reset or
@@ -1335,7 +1330,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 	iod->aborted = 1;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = req->tag;
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
@@ -1886,10 +1880,9 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 {
 	u32 host_mem_size = dev->host_mem_size >> NVME_CTRL_PAGE_SHIFT;
 	u64 dma_addr = dev->host_mem_descs_dma;
-	struct nvme_command c;
+	struct nvme_command c = { };
 	int ret;
 
-	memset(&c, 0, sizeof(c));
 	c.features.opcode	= nvme_admin_set_features;
 	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
 	c.features.dword11	= cpu_to_le32(bits);
@@ -2263,9 +2256,8 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 {
 	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
 	struct request *req;
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
