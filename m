Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07044C38A02
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Oct 2022 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zw9CjljdymJxQA8GSqf36K/IXuBD8Q74dv97X7w68n4=; b=g79gUwtGY89ycXotsyfkc8yuxB
	4Xoc+cusAZrnur4P01Q64NDmlL0XUVKLLOKWFyeXb7h062OH3WbcQ0Dtk/3eA19rydGjtBKgZM6Gk
	cQ320aogxU85KQdq0RH+JEHF9tysXYjlz3WK5X+XhQSznf6PEUUJ4sVV/6aDEQeW1IkFuRSMFteUK
	iA1oHeq1Wu8tJ4B08k6wmAjLxdq4x34yrWB5F/Fxj30xTL8oDANFCgDtJ8lxvhaSoRG1YtJ5165fM
	ncFRfiOejc8MWotu7mn1s6IDu5snTncrVq2uSRSO2ucMO5zcz4IaKS9wNJoUGWloxnTUeLhsv2nsJ
	wVvoRqDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooifw-005lCz-MG; Sat, 29 Oct 2022 10:02:48 +0000
Received: from mail.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooifn-005lAL-56
	for linux-nvme@lists.infradead.org; Sat, 29 Oct 2022 10:02:41 +0000
Received: from localhost.localdomain (unknown [10.14.30.251])
	by mail-app3 (Coremail) with SMTP id cC_KCgCHjQwl+lxjdEpxCA--.43876S4;
	Sat, 29 Oct 2022 18:02:33 +0800 (CST)
From: Jinlong Chen <nickyc975@zju.edu.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nickyc975@zju.edu.cn
Subject: [PATCH 2/3] blk-mq: remove blk_freeze_queue
Date: Sat, 29 Oct 2022 18:02:10 +0800
Message-Id: <2e75f23dbefec4c7f056ee1d867fa00b7172c3cd.1667035519.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667035519.git.nickyc975@zju.edu.cn>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgCHjQwl+lxjdEpxCA--.43876S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3AF4rXr18ZrWruFyrtFb_yoW8Zr1xpF
	ZxJF47Cw1Iqr4UXrW8Jw47Xr9Iga18Kry7C3ySy3yYvrnIkFn2vF18A3W8uF40yrZ5JFsr
	ZrWqgrZxAr18CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
	AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgwSB1ZdtcJ3NwADsk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_030239_554006_914FE5A9 
X-CRM114-Status: GOOD (  11.18  )
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

Nobody is calling blk_freeze_queue except its alias, so remove it.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 18 +-----------------
 block/blk.h    |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 14c4165511b9..e0654a2e80b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -194,27 +194,11 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
  */
-void blk_freeze_queue(struct request_queue *q)
+void blk_mq_freeze_queue(struct request_queue *q)
 {
-	/*
-	 * In the !blk_mq case we are only calling this to kill the
-	 * q_usage_counter, otherwise this increases the freeze depth
-	 * and waits for it to return to zero.  For this reason there is
-	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
-	 * exported to drivers as the only user for unfreeze is blk_mq.
-	 */
 	blk_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
-
-void blk_mq_freeze_queue(struct request_queue *q)
-{
-	/*
-	 * ...just an alias to keep freeze and unfreeze actions balanced
-	 * in the blk_mq_* namespace
-	 */
-	blk_freeze_queue(q);
-}
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
diff --git a/block/blk.h b/block/blk.h
index 7f9e089ab1f7..e9addea2838a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -37,7 +37,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-- 
2.31.1


