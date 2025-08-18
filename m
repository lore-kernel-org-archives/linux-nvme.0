Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E8ACA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqOtN4IH/xkxIsMcT4OL/9ZRyjFeoBWhcMonq91nfe8=; b=w9T+64iC8ITxxBdjQBuNFwWvk2
	hf07xCm7E5jBSLwCkg9/hDY3kjM/3jcVuSToyzh96lmlwLv4TozIPbVJqo532XEeRVx/FuL15xu/8
	Sd+yQWvRpHmEe2LVZhARymWoTmDos6yboqGsEWW1t6rXsKLccvRb25hj4e8H3DirgwqLOXQZ5SeWV
	sQ/0YQ1qQTC3TQqC7Zj+521BT5UNhhPXZUe17ZC41WsOAwBCMDEGk70in/UrtL54IiQeLx6itzvPf
	AuRKfaTwLSh6knSCBFdoFDLOOhTXN59cuyOhp9SlMNiwNTdgMyc1FgbUjAcctZN26LFMhUyoLWSgm
	+eU4kQ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo04F-00000007Vr4-3b7A;
	Mon, 18 Aug 2025 13:38:31 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unvTL-00000006xra-1MpF;
	Mon, 18 Aug 2025 08:44:08 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso2292334b3a.3;
        Mon, 18 Aug 2025 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506646; x=1756111446; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqOtN4IH/xkxIsMcT4OL/9ZRyjFeoBWhcMonq91nfe8=;
        b=QX8YMa5fTR32QPB0406zXsaadrxnwVP7HkoEcSE8vj0mBWUWkjb1QwVaedZV0mua0D
         6MMrmYkM/2irKRF7T0J3e30Uh8FIhWQmSIRkAuaN2m6IOszO69YH6DFhPGxpv8GJV0kv
         BiO8oOhl3PiuIZkAP9BJP3ZH6JDeZpTrFOS4KqeSzaykk6HHTrQjyZWg4MVDx80cl6Sb
         aGH91KILhSZ5+eqC0UZRC6FcoXxv+EI1D/M/nQcjqOAH24mHepy+jgPRY4Ax5e1PWBQm
         5SRcYj3A0+ZEv54jwiMH3laUXeV0ULkDZ9nCzP9xBQJqX9CrfDvyi8FIbTY/966uHDqD
         CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506646; x=1756111446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqOtN4IH/xkxIsMcT4OL/9ZRyjFeoBWhcMonq91nfe8=;
        b=Vg9m6fNQRFCRCm1BgI5kuMdiyGHbYlDwvsNcWrm0Y2cgCNz5SrABdEAZYWxS4OjA1Q
         l+JcyZxvEeAioaQv/noU3QvMVswNONUar/wAvX35RynLOTMo9FxDtJjmCxyRkrlVRDEb
         s2PcLdfD+QjcX9col4bDOmcXMn0LacfRNRva3bIRE3l/m3CNvk3mcfJStnMWc6YcqN2G
         BdOeYyhBBL1QgbXIfVZbQ+56ysB2DK3WsvtPp1Z3QBe5JIlOEK+JScPDDQjSaImsNDbZ
         Mx0ACdFQ8ypvTEpogk6dNRGRHfhdkxcwQJRVWWpbM9sa/56v3I7jF9n385ZAOGN36Mui
         4hZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYLFdlJhIpgLzIXqzLWTvl7Oj0HiiCNolwI8iMpW5NNENMgpzdg+CI+tResQnllg4EOVjHKPxOoWXLBQ==@lists.infradead.org, AJvYcCVX8hhMz9wlwmRZz+NNyI+3PUiyHcOlINERTrGgQruiFvH6Sazma3rVS/+YoignxLrnkSra/9ZSbENfWuMsmAiv@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7kkWL4Rx0tqAAHSHwQJtecPzaV6T5yarl3yXsXe9NE30eJPwP
	Xuamqyfq58h4kCjEgMUNwsk+1cf94pvnXkUkY53nA/6Yk/n8yGtFNQ0hmpjjnQ==
X-Gm-Gg: ASbGncu5evR/lcXj6E0X5xMtOLDp1VKuh27SdI8NwuSRA4M9g+U1XmmgqVHyJP2Q4et
	QVIeNnOnj3FTFLR5AOodhCGO9iY5tfRs4uGuQkYFtNoYWUTVyfUPmMvMX89oG5xUjwuNAQhT4mo
	G22VIotB/2d/x70tYyd1gwG8r3jcAEbm8lpF8JTS+eCIMdoagTcfUyRjEGtJa1uhwj9Jfk5VAXI
	exGnJBqz9RPwRJewZtyBYpSu/pG/4EoHLX93K0U1FbrHlOTF1Q9YI3mjFwWTngmnKZLc3fqoxaI
	B7cLUHPYlLVq4/4rZyQpeCYIoBHfHmRevlzNxnsXnoHZWl4ymnTiBgpJT49K9VKbAVC+0neVpxb
	aLiXeZfKnT9vaQC3O9Y16Dob1GmCnR+HDMLZCvzFS5PcmVcE=
X-Google-Smtp-Source: AGHT+IGSUtSzX20U6ELEtvflPkBQHdvy1+YFJKOKUK/QuBSW1fyN5z0BVTWBPbT/JL/DNgL5AqRIig==
X-Received: by 2002:a17:903:38c5:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-2446d7493a5mr131159275ad.20.1755506645977;
        Mon, 18 Aug 2025 01:44:05 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:00 +0800
Subject: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13406;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=o5LJJMwTtsVbnSLH+/OYa2s6s1EHDZCy8cdlkUZK1bQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelwsb0pmI91h4tRAJZQLkQ/2RfpVE0dLR6F
 MsjwPO4ppOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JCcOD/9THCgOxFPQg3b9sHpbsdDJJcBjPJ0/odCTfAtNr1UcwDpJWTTsuQomtLpoy20gHRMdES7
 sP1N6jV0fOBriqxZFfFUDGYobUTk3aMCDXBXZL5oKTF0GVJ5uEzVr3hXCCk/XdIOe39B19XzI4m
 JHzmMRo6N375vUSSp4anO5a8ggrOtOLl1TUOYjTPzn2EpiEIQhUGj+TaCMmsTRn89ku+A4rv72F
 mPi/rSYJIILdZUGftuVjnS0Y66mNDyr8odAws6vZpalyHdf8sJjfv0QSrixCV1DGiY2z63wOKI6
 6QFJxj4NqyAwhTHk1aY9lSLWfW2MFUrx8YiPO2+1mzExgvTWhOKW2mg9mzwxNVKPJpdgJ8PBeNy
 bzkhYh/eA/DjUNA73ZUr8rWlHNcrj+oujh7qnFFlICeXsmNBxXzAUnFCjwenSlKUBitSZZqTI4s
 IbkNRV9NSotNv4miN3Z12PNM+OH6n4Lc+CzHlv+I+PUiLD7Rs+oS7qc2tpLEHhU70+Pyv5mxuKq
 XAc8NgwYHto88xewx+e4I7OADDaNDlXKlYq7BW1hx8bKyCZ9aJLaFIHFim40lCvzGnMCbzYD6Wz
 z1DDGjSIpZkCsaET29FnN7cCtHCdXBKY/8lbtd4Gvq+B1SVGx1RgRjZ1wKaJDOmOurmlXhw/67F
 sN91YDIglzxKIyw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_014407_376173_886B227B 
X-CRM114-Status: GOOD (  29.88  )
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
 drivers/nvme/host/apple.c | 198 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 59 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..f3999b8ef7ab759fe7b6d14bfc03671c51f21e82 100644
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
 
@@ -166,11 +168,18 @@ struct apple_nvme_iod {
 	struct scatterlist *sg;
 };
 
+struct apple_nvme_hw {
+	bool has_lsq_nvmmu;
+	u32 max_queue_depth;
+	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);
+};
+
 struct apple_nvme {
 	struct device *dev;
 
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
+	const struct apple_nvme_hw *hw;
 
 	struct device **pd_dev;
 	struct device_link **pd_link;
@@ -215,10 +224,12 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
 
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
@@ -280,7 +291,31 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 				     "NVMMU TCB invalidation failed\n");
 }
 
-static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
+static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
+				  struct nvme_command *cmd)
+{
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+	u32 tag;
+
+	spin_lock_irq(&anv->lock);
+
+	tag = q->sq_tail;
+	q->sq_tail += 1;
+
+	if (q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
+
+	if (q->is_adminq)
+		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+	else
+		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
+
+	writel(q->sq_tail, q->sq_db);
+	spin_unlock_irq(&anv->lock);
+}
+
+
+static void apple_nvme_submit_cmd_t8103(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
@@ -590,7 +625,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
-	apple_nvmmu_inval(q, command_id);
+	if (anv->hw->has_lsq_nvmmu)
+		apple_nvmmu_inval(q, command_id);
 
 	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
 	if (unlikely(!req)) {
@@ -685,7 +721,7 @@ static int apple_nvme_create_cq(struct apple_nvme *anv)
 	c.create_cq.opcode = nvme_admin_create_cq;
 	c.create_cq.prp1 = cpu_to_le64(anv->ioq.cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(1);
-	c.create_cq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_cq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED);
 	c.create_cq.irq_vector = cpu_to_le16(0);
 
@@ -713,7 +749,7 @@ static int apple_nvme_create_sq(struct apple_nvme *anv)
 	c.create_sq.opcode = nvme_admin_create_sq;
 	c.create_sq.prp1 = cpu_to_le64(anv->ioq.sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(1);
-	c.create_sq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_sq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG);
 	c.create_sq.cqid = cpu_to_le16(1);
 
@@ -765,7 +801,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	nvme_start_request(req);
-	apple_nvme_submit_cmd(q, cmnd);
+	anv->hw->submit_cmd(q, cmnd);
 	return BLK_STS_OK;
 
 out_free_cmd:
@@ -970,11 +1006,13 @@ static const struct blk_mq_ops apple_nvme_mq_ops = {
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
@@ -1069,49 +1107,56 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
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
@@ -1282,8 +1327,9 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
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
@@ -1307,6 +1353,7 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 				  struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	size_t iosq_size;
 
 	q->cqes = dmam_alloc_coherent(anv->dev,
 				      depth * sizeof(struct nvme_completion),
@@ -1314,22 +1361,29 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
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
@@ -1413,6 +1467,12 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
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
@@ -1444,10 +1504,17 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
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
@@ -1625,8 +1692,21 @@ static int apple_nvme_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 				apple_nvme_resume);
 
+static const struct apple_nvme_hw apple_nvme_t8015_hw = {
+	.has_lsq_nvmmu = false,
+	.max_queue_depth = 16,
+	.submit_cmd = &apple_nvme_submit_cmd_t8015,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8103_hw = {
+	.has_lsq_nvmmu = true,
+	.max_queue_depth = 64,
+	.submit_cmd = &apple_nvme_submit_cmd_t8103,
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


