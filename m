Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Dec 2021 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6ZH5saaKfxSaYpfE2bE66/wf4OjFOfo93V/aM0vcjw=; b=bHaPHczwInjovOZSZnxGY2o6Od
	UkCZip54zI5LKhTUCoUhCnQxy7wrLM0VBKS4dELoWGMzpMiT24F5jDLzbsGfkjjVfw8415xMryEuD
	fouwQOkvEAFnrVzh9f/vyA3RpnLCSIIeucYrvJf9JmDOBqnbJ5sFgA9VSCote3LM7v695I3ZEhjAk
	HcYdyih3wb7xbeGYWlPzn6xpIz0vyVboxU+YWLGQ6v9rH9fh0lHHdZSB3ZzFcl+5cMgBY/WFZr9tW
	rROyoN44pyQnEUyJ3C3izHr7MoluCp2PDImSu5Ho0fOyZ/qZlKyF2PZKlAM6xtr9va5Una1Pi3o9+
	Ihgarepg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n1t4H-00H05C-S9; Mon, 27 Dec 2021 16:41:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1t4F-00H03v-2r
 for linux-nvme@lists.infradead.org; Mon, 27 Dec 2021 16:41:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8701A61125;
 Mon, 27 Dec 2021 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F53AC36AEB;
 Mon, 27 Dec 2021 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640623306;
 bh=WoHtcBMvvFU7VPovTMB/F8HHt+DyWm856xyUX8Ln0wA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AIRnfL6mDeOA4tAONDJCoSC8mHOEzPxUyyVL0+qruj8sWa6lp9Rn+DN+1kBj9jJIz
 wBO1kLM/FLY9QhQOGBlH7418g9AJETuAXIXkAEmOff+GhYj5cr3YyMBZe75EUP0bpK
 Mm4WhcaxIIL2rt4ua/l/tYYMG/37MwiL570Ny6KJ69m/ecXKwwlIOOa00D0RLqekyU
 IQeta4R/CDFTgV4fsGi2lnBHojPj60r003xoT9iZcpEOgzwqy1J1CX4c8L15padtfo
 ydmSHEqsBs7amTcQINXxC/nUFMF50mxwU6H/HLjI5IN0ANQoDK7qsJ0656OEUN+Zl4
 o8B+yoSaRi1Sg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/3] block: introduce rq_list_move
Date: Mon, 27 Dec 2021 08:41:37 -0800
Message-Id: <20211227164138.2488066-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211227164138.2488066-1-kbusch@kernel.org>
References: <20211227164138.2488066-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211227_084147_186878_5E91452F 
X-CRM114-Status: GOOD (  12.97  )
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

When iterating a list, a particular request may need to be moved for
special handling. Provide a helper function to achieve that so drivers
don't need to reimplement rqlist manipulation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 550996cf419c..0efa25abcc1c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -216,6 +216,25 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
 
+/**
+ * rq_list_move() - move a struct request from one list to another
+ * @src: The source list @rq is currently in
+ * @dst: The destination list that @rq will be appended to
+ * @rq: The request to move
+ * @prv: The request preceding @rq in @src (NULL if @rq is the head)
+ * @nxt: The request following @rq in @src (NULL if @rq is the tail)
+ */
+static void inline rq_list_move(struct request **src, struct request **dst,
+				struct request *rq, struct request *prv,
+				struct request *nxt)
+{
+	if (prv)
+		prv->rq_next = nxt;
+	else
+		*src = nxt;
+	rq_list_add(dst, rq);
+}
+
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
-- 
2.25.4


