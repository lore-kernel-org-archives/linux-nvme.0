Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D693C87FDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyff53E7cWTqYFn1aBHJtSBwhGzOEO7QV9Injq+Dikg=; b=RmHIhlE3583BVf+b6caQgILxPu
	MoqOBaXN2rd0svL7+5QtcGkhvwY/Q+9R8TQE48chC7NanHu/Zb4dy8ks8FSIeHDKycH7oNLt9+14m
	5tSigr8t1IvVmQ95WnRxVK7tLfoWtIwax2XXu609hXZ5xy0pFlarIy6smtuPV2zCC0nkYGUIJ0WKx
	KpK6nGY6IupVyFPQjeIH+VKcoFph3AFywLGb61+whMxqeDllH3YtkxkcpMt1dJs6jj60m/Z/KfaFx
	wnMtznSx6cTGEbNqzhVNxcY6jJgy5wVUC/1QGhnh3bMJE81PPctWGqyaNTgkFdG6Dx3OaVItecEeQ
	AukeKCXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTIC-00000007yxz-1SeX;
	Mon, 11 Aug 2025 14:14:28 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwT-00000007t5l-22Z5;
	Mon, 11 Aug 2025 13:52:03 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so3464942a12.2;
        Mon, 11 Aug 2025 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920321; x=1755525121; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyff53E7cWTqYFn1aBHJtSBwhGzOEO7QV9Injq+Dikg=;
        b=CM/stGqzEP7VniDXbJngaEm5kBN+RvDu6HISm01NMFDkyDZwtVmEpkJEIPT+A7X5oU
         6ilq+kjB2UIEvzC8z4gEKmH1COqsJsSBSkwL3gNj6H1hYSbSTVxJg5NSvssrYYtqV2wl
         WJobg2iNg33h8vZw4mEL5Hd5yZHFb7GWC8+4Tu4POidgSWCq+VOg1DiJFmF85niZEDHl
         v8N9APJvpFXJg9vQqRQSEzZ5WY0IknpRT9ynT2IgKoBiJ7KTsl8JaC6BIIFh2Xz4bYBY
         SFi3r93KG+PE6lkLH8Fy6TEIp08JgccSdz/QuQqdp5JFEmQNtO47ek/MRatjIRTmY5LE
         UltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920321; x=1755525121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyff53E7cWTqYFn1aBHJtSBwhGzOEO7QV9Injq+Dikg=;
        b=kbBpGd5PkfiBrjwy+V+pedEASvavMfIo83QcLBrZ8clOYSSxiRIBKvlhKxfDO1cYrv
         McHVcS6Q1vySnDJ462O1nAEA0Dx7+TdJ9Pm2dVdbVjxme4Oh/T0QZCqU7Li2kJ7Q/7FU
         ad0BRBouJTYyzYDFBXdHOn2UZLqtwqE/n/bb97cLdwZ/nQIr2ELwcxhnUzDL/2Duyaqw
         qDxFItwkTBivFv/KYm38ReZfb7j6Q2SuWjYtgIODvyX4DGSo+TQkRiD0dhAdnw1Dm5lA
         a5khgdGqOLOK0SFyxOSA1jDKIQVduio1Q+7ynSDjlagouqk05/0zxXwwDThZrhULrNYY
         7vnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVikg0uJ2+BYuDq2eOiPsaOemQQJYq7PdbEjtkyYvF8oYZwqc+H7MMGFz8BkuZGvvm+2xB6kRCafP4ZzQ==@lists.infradead.org, AJvYcCXK9MIC1ByR/8/BxP3hNF1LX3te3Gx002AJzzBV/KRnSDpUTAcZKSHOBimof8uuiaGFY1Y2gbQaAh+cgCqF7Vp+@lists.infradead.org
X-Gm-Message-State: AOJu0YzMBpRQZoXOv+juWVIsuAInKG3OF007htNhDkWRBrFD443wXtTx
	LfnpIzohHWElk++LMLoxANitcCLZfBh4fs6BxjlcopaXW0pVd+PVmIYw
X-Gm-Gg: ASbGncu9P1qrRlkJx6FWPI7sVycHl7HCHb+kd5JPThHUN6kLb6M81RQXOrLJZZ0wf8s
	mOXRwWufaav6uogT0PCeHUXPwb1BQDn+fVYZfXrAHESE7CWcJD13Scz0kW0Kn78T8EhU5cd7+ZT
	gTYEaSpV9V9ppUNvDAv3646of3lYjK2LW6h/LHKGD8+4uVakzzI+G1EmzY3cfvUAUkavL6viAXz
	ZmQZyduzOBw5EPLOwjgtuRT0VmKxefxQMqrqpatUSGf5l6HFTYU/j/2sapUTUkagjkoTkGtTV34
	chplLLNXq5qFJLd+J8je0STRInPYjmSZt7l13lVCHvA73CMI8D+uEpvBD5LBu8WewvViUnj6uPJ
	Tc0/NwwVqdl8teoTAi1Q/aqzguZgmWTmUF/5vDnA+NBpS5y4=
X-Google-Smtp-Source: AGHT+IHMbJveXjM2OcAcfnj4O53TSkST5LudUWzFJqSL/qRs9GyJ97dCzGpdD0lUES1JXHr4QEqGeg==
X-Received: by 2002:a17:903:1106:b0:23f:cf96:3072 with SMTP id d9443c01a7336-242c21e08a1mr207855805ad.26.1754920320363;
        Mon, 11 Aug 2025 06:52:00 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:59 +0800
Subject: [PATCH 7/9] nvme: apple: Add Apple A11 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14196;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=xwGRhjwxZQn3QrQFndXM6wysZnFGir1FPx3rOGoUXeI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRxsBWYSVn++HlYiYcXBcmochf7pFxFb1Tq
 laF892nGMiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JLYgEACUhzuRTtfMzSJBXNrmBiQOGSLilZH5n2uKlysZZsMQ5iMwV2qXiGFRGT7Bfo50ns1k/tV
 rnti2qRZFV041tw8lNbm2/crk0HJ+n+4/1omHC3cE5NxPC4RtVQx/XiCqXxrbuPEXu/wrgfuUq4
 1Pvb7+qfcisI6fKz6WHeRnupDirnSHlHM9xFyAR0MUPr9CCfEqXzAWhiwVExPiixJHdAcuw9mCq
 OCHh9yf0NAqtrcQtvnjGC2rDKDU8hK4HNMZeNLeFzw0SgHIfrR3ppykYfAZGC4Vftv7NIO67eNR
 5OTHJ7V+Ssewi1nbj2bsZR0NHD+SEqG5xtMEq4wLrBc1VpmESg8kR5n0WcDbCAHN0fEkL1ugA0O
 l0XpbYguwSMmv7ICo20F2wErBC2IAf7dwxWUVurWvjyB4VvQEMfqngDcABAwotI2mPNdfkw5Ld4
 6nWbEd+rO40Fj1mKjX4A//vjmBY8xY5OoBHFKbnh9Wm3pUwO5BVcXI5YiRCwDJ3Ozg1h3pELeHB
 Djqh/WCdXxJxglsFHT+JbZCQZh9Qa30B4WrKp0Nu3D5Xhsck8ObBDd6g4fy+FN4SczylTtOWapE
 QEInhKTpCO5xD14g5kGOyD/F5g+oQKAxmxddXy7mQOdF0a8/Psw70CSD+TXno6MjODy26RyUPzp
 g8rxG0iEfwX4+ig==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065201_544114_58333A64 
X-CRM114-Status: GOOD (  29.67  )
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

Add support for ANS2 NVMe on Apple A11 SoC.

This version of ANS2 is less quirky than the one in M1, and does not have
NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
SQE.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------
 1 file changed, 154 insertions(+), 74 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..69f618c8f2e62e3b2dedf5fdf5cc8c3f189c6578 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -35,7 +35,6 @@
 #include "nvme.h"
 
 #define APPLE_ANS_BOOT_TIMEOUT	  USEC_PER_SEC
-#define APPLE_ANS_MAX_QUEUE_DEPTH 64
 
 #define APPLE_ANS_COPROC_CPU_CONTROL	 0x44
 #define APPLE_ANS_COPROC_CPU_CONTROL_RUN BIT(4)
@@ -75,6 +74,8 @@
 #define APPLE_NVME_AQ_DEPTH	   2
 #define APPLE_NVME_AQ_MQ_TAG_DEPTH (APPLE_NVME_AQ_DEPTH - 1)
 
+#define APPLE_NVME_IOSQES	7
+
 /*
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
@@ -142,6 +143,7 @@ struct apple_nvme_queue {
 	u32 __iomem *sq_db;
 	u32 __iomem *cq_db;
 
+	u16 sq_tail;
 	u16 cq_head;
 	u8 cq_phase;
 
@@ -166,11 +168,17 @@ struct apple_nvme_iod {
 	struct scatterlist *sg;
 };
 
+struct apple_nvme_hw {
+	bool has_lsq_nvmmu;
+	u32 max_queue_depth;
+};
+
 struct apple_nvme {
 	struct device *dev;
 
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
+	const struct apple_nvme_hw *hw;
 
 	struct device **pd_dev;
 	struct device_link **pd_link;
@@ -215,10 +223,12 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
 
 static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 {
-	if (q->is_adminq)
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+
+	if (q->is_adminq && anv->hw->has_lsq_nvmmu)
 		return APPLE_NVME_AQ_DEPTH;
 
-	return APPLE_ANS_MAX_QUEUE_DEPTH;
+	return anv->hw->max_queue_depth;
 }
 
 static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
@@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
-	u32 tag = nvme_tag_from_cid(cmd->common.command_id);
-	struct apple_nvmmu_tcb *tcb = &q->tcbs[tag];
-
-	tcb->opcode = cmd->common.opcode;
-	tcb->prp1 = cmd->common.dptr.prp1;
-	tcb->prp2 = cmd->common.dptr.prp2;
-	tcb->length = cmd->rw.length;
-	tcb->command_id = tag;
-
-	if (nvme_is_write(cmd))
-		tcb->dma_flags = APPLE_ANS_TCB_DMA_TO_DEVICE;
-	else
-		tcb->dma_flags = APPLE_ANS_TCB_DMA_FROM_DEVICE;
-
-	memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+	struct apple_nvmmu_tcb *tcb = NULL;
+	u32 tag;
 
 	/*
 	 * This lock here doesn't make much sense at a first glance but
@@ -311,7 +308,41 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 	 * and the final CQ update.
 	 */
 	spin_lock_irq(&anv->lock);
-	writel(tag, q->sq_db);
+
+	if (anv->hw->has_lsq_nvmmu) {
+		tag = nvme_tag_from_cid(cmd->common.command_id);
+	} else {
+		tag = q->sq_tail;
+		q->sq_tail += 1;
+
+		if (q->sq_tail == anv->hw->max_queue_depth)
+			q->sq_tail = 0;
+	}
+
+	if (anv->hw->has_lsq_nvmmu) {
+		tcb = &q->tcbs[tag];
+
+		tcb->opcode = cmd->common.opcode;
+		tcb->prp1 = cmd->common.dptr.prp1;
+		tcb->prp2 = cmd->common.dptr.prp2;
+		tcb->length = cmd->rw.length;
+		tcb->command_id = tag;
+
+		if (nvme_is_write(cmd))
+			tcb->dma_flags = APPLE_ANS_TCB_DMA_TO_DEVICE;
+		else
+			tcb->dma_flags = APPLE_ANS_TCB_DMA_FROM_DEVICE;
+	}
+
+	if (anv->hw->has_lsq_nvmmu || q->is_adminq)
+		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+	else
+		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
+
+	if (anv->hw->has_lsq_nvmmu)
+		writel(tag, q->sq_db);
+	else
+		writel(q->sq_tail, q->sq_db);
 	spin_unlock_irq(&anv->lock);
 }
 
@@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 	struct nvme_completion *cqe = &q->cqes[idx];
-	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
-	apple_nvmmu_inval(q, command_id);
+	if (!anv->hw->has_lsq_nvmmu)
+		cqe->command_id--;
+
+	__u16 command_id = READ_ONCE(cqe->command_id);
+
+	if (anv->hw->has_lsq_nvmmu)
+		apple_nvmmu_inval(q, command_id);
+	else
+		command_id++;
 
 	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
 	if (unlikely(!req)) {
@@ -685,7 +723,7 @@ static int apple_nvme_create_cq(struct apple_nvme *anv)
 	c.create_cq.opcode = nvme_admin_create_cq;
 	c.create_cq.prp1 = cpu_to_le64(anv->ioq.cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(1);
-	c.create_cq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_cq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED);
 	c.create_cq.irq_vector = cpu_to_le16(0);
 
@@ -713,7 +751,7 @@ static int apple_nvme_create_sq(struct apple_nvme *anv)
 	c.create_sq.opcode = nvme_admin_create_sq;
 	c.create_sq.prp1 = cpu_to_le64(anv->ioq.sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(1);
-	c.create_sq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_sq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG);
 	c.create_sq.cqid = cpu_to_le16(1);
 
@@ -970,11 +1008,13 @@ static const struct blk_mq_ops apple_nvme_mq_ops = {
 static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
 	q->cq_head = 0;
 	q->cq_phase = 1;
-	memset(q->tcbs, 0,
-	       APPLE_ANS_MAX_QUEUE_DEPTH * sizeof(struct apple_nvmmu_tcb));
+	if (anv->hw->has_lsq_nvmmu)
+		memset(q->tcbs, 0,
+			anv->hw->max_queue_depth * sizeof(struct apple_nvmmu_tcb));
 	memset(q->cqes, 0, depth * sizeof(struct nvme_completion));
 	WRITE_ONCE(q->enabled, true);
 	wmb(); /* ensure the first interrupt sees the initialization */
@@ -1069,49 +1109,56 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	dma_set_max_seg_size(anv->dev, 0xffffffff);
 
-	/*
-	 * Enable NVMMU and linear submission queues.
-	 * While we could keep those disabled and pretend this is slightly
-	 * more common NVMe controller we'd still need some quirks (e.g.
-	 * sq entries will be 128 bytes) and Apple might drop support for
-	 * that mode in the future.
-	 */
-	writel(APPLE_ANS_LINEAR_SQ_EN,
-	       anv->mmio_nvme + APPLE_ANS_LINEAR_SQ_CTRL);
+	if (anv->hw->has_lsq_nvmmu) {
+		/*
+		 * Enable NVMMU and linear submission queues.
+		 * While we could keep those disabled and pretend this is slightly
+		 * more common NVMe controller we'd still need some quirks (e.g.
+		 * sq entries will be 128 bytes) and Apple might drop support for
+		 * that mode in the future.
+		 */
+		writel(APPLE_ANS_LINEAR_SQ_EN,
+			anv->mmio_nvme + APPLE_ANS_LINEAR_SQ_CTRL);
 
-	/* Allow as many pending command as possible for both queues */
-	writel(APPLE_ANS_MAX_QUEUE_DEPTH | (APPLE_ANS_MAX_QUEUE_DEPTH << 16),
-	       anv->mmio_nvme + APPLE_ANS_MAX_PEND_CMDS_CTRL);
+		/* Allow as many pending command as possible for both queues */
+		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),
+			anv->mmio_nvme + APPLE_ANS_MAX_PEND_CMDS_CTRL);
 
-	/* Setup the NVMMU for the maximum admin and IO queue depth */
-	writel(APPLE_ANS_MAX_QUEUE_DEPTH - 1,
-	       anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
+		/* Setup the NVMMU for the maximum admin and IO queue depth */
+		writel(anv->hw->max_queue_depth - 1,
+			anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
 
-	/*
-	 * This is probably a chicken bit: without it all commands where any PRP
-	 * is set to zero (including those that don't use that field) fail and
-	 * the co-processor complains about "completed with err BAD_CMD-" or
-	 * a "NULL_PRP_PTR_ERR" in the syslog
-	 */
-	writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
-		       ~APPLE_ANS_PRP_NULL_CHECK,
-	       anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
+		/*
+		 * This is probably a chicken bit: without it all commands where any PRP
+		 * is set to zero (including those that don't use that field) fail and
+		 * the co-processor complains about "completed with err BAD_CMD-" or
+		 * a "NULL_PRP_PTR_ERR" in the syslog
+		 */
+		writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
+			~APPLE_ANS_PRP_NULL_CHECK,
+			anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
+	}
 
 	/* Setup the admin queue */
-	aqa = APPLE_NVME_AQ_DEPTH - 1;
+	if (anv->hw->has_lsq_nvmmu)
+		aqa = APPLE_NVME_AQ_DEPTH - 1;
+	else
+		aqa = anv->hw->max_queue_depth - 1;
 	aqa |= aqa << 16;
 	writel(aqa, anv->mmio_nvme + NVME_REG_AQA);
 	writeq(anv->adminq.sq_dma_addr, anv->mmio_nvme + NVME_REG_ASQ);
 	writeq(anv->adminq.cq_dma_addr, anv->mmio_nvme + NVME_REG_ACQ);
 
-	/* Setup NVMMU for both queues */
-	writeq(anv->adminq.tcb_dma_addr,
-	       anv->mmio_nvme + APPLE_NVMMU_ASQ_TCB_BASE);
-	writeq(anv->ioq.tcb_dma_addr,
-	       anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
+	if (anv->hw->has_lsq_nvmmu) {
+		/* Setup NVMMU for both queues */
+		writeq(anv->adminq.tcb_dma_addr,
+			anv->mmio_nvme + APPLE_NVMMU_ASQ_TCB_BASE);
+		writeq(anv->ioq.tcb_dma_addr,
+			anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
+	}
 
 	anv->ctrl.sqsize =
-		APPLE_ANS_MAX_QUEUE_DEPTH - 1; /* 0's based queue depth */
+		anv->hw->max_queue_depth - 1; /* 0's based queue depth */
 	anv->ctrl.cap = readq(anv->mmio_nvme + NVME_REG_CAP);
 
 	dev_dbg(anv->dev, "Enabling controller now");
@@ -1282,8 +1329,9 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * both queues. The admin queue gets the first APPLE_NVME_AQ_DEPTH which
 	 * must be marked as reserved in the IO queue.
 	 */
-	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
-	anv->tagset.queue_depth = APPLE_ANS_MAX_QUEUE_DEPTH - 1;
+	if (anv->hw->has_lsq_nvmmu)
+		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
+	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;
 	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
@@ -1307,6 +1355,7 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 				  struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	size_t iosq_size;
 
 	q->cqes = dmam_alloc_coherent(anv->dev,
 				      depth * sizeof(struct nvme_completion),
@@ -1314,22 +1363,29 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 	if (!q->cqes)
 		return -ENOMEM;
 
+	if (anv->hw->has_lsq_nvmmu)
+		iosq_size = depth * sizeof(struct nvme_command);
+	else
+		iosq_size = depth << APPLE_NVME_IOSQES;
+
 	q->sqes = dmam_alloc_coherent(anv->dev,
-				      depth * sizeof(struct nvme_command),
+				      iosq_size,
 				      &q->sq_dma_addr, GFP_KERNEL);
 	if (!q->sqes)
 		return -ENOMEM;
 
-	/*
-	 * We need the maximum queue depth here because the NVMMU only has a
-	 * single depth configuration shared between both queues.
-	 */
-	q->tcbs = dmam_alloc_coherent(anv->dev,
-				      APPLE_ANS_MAX_QUEUE_DEPTH *
-					      sizeof(struct apple_nvmmu_tcb),
-				      &q->tcb_dma_addr, GFP_KERNEL);
-	if (!q->tcbs)
-		return -ENOMEM;
+	if (anv->hw->has_lsq_nvmmu) {
+		/*
+		 * We need the maximum queue depth here because the NVMMU only has a
+		 * single depth configuration shared between both queues.
+		 */
+		q->tcbs = dmam_alloc_coherent(anv->dev,
+			anv->hw->max_queue_depth *
+				sizeof(struct apple_nvmmu_tcb),
+			&q->tcb_dma_addr, GFP_KERNEL);
+		if (!q->tcbs)
+			return -ENOMEM;
+	}
 
 	/*
 	 * initialize phase to make sure the allocated and empty memory
@@ -1413,6 +1469,12 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 	anv->adminq.is_adminq = true;
 	platform_set_drvdata(pdev, anv);
 
+	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);
+	if (!anv->hw) {
+		ret = -ENODEV;
+		goto put_dev;
+	}
+
 	ret = apple_nvme_attach_genpd(anv);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach power domains");
@@ -1444,10 +1506,17 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 		goto put_dev;
 	}
 
-	anv->adminq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_ASQ_DB;
-	anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
-	anv->ioq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_IOSQ_DB;
-	anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	if (anv->hw->has_lsq_nvmmu) {
+		anv->adminq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_ASQ_DB;
+		anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
+		anv->ioq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_IOSQ_DB;
+		anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	} else {
+		anv->adminq.sq_db = anv->mmio_nvme + NVME_REG_DBS;
+		anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
+		anv->ioq.sq_db = anv->mmio_nvme + NVME_REG_DBS + 8;
+		anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	}
 
 	anv->sart = devm_apple_sart_get(dev);
 	if (IS_ERR(anv->sart)) {
@@ -1625,8 +1694,19 @@ static int apple_nvme_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 				apple_nvme_resume);
 
+static const struct apple_nvme_hw apple_nvme_t8015_hw = {
+	.has_lsq_nvmmu = false,
+	.max_queue_depth = 16,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8103_hw = {
+	.has_lsq_nvmmu = true,
+	.max_queue_depth = 64,
+};
+
 static const struct of_device_id apple_nvme_of_match[] = {
-	{ .compatible = "apple,nvme-ans2" },
+	{ .compatible = "apple,t8015-nvme-ans2", .data = &apple_nvme_t8015_hw },
+	{ .compatible = "apple,nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{},
 };
 MODULE_DEVICE_TABLE(of, apple_nvme_of_match);

-- 
2.50.1


