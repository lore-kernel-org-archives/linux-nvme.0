Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF0FA3743
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Oct 2022 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGe4w43M2a0oq4Ikf/Ib05MiFqBwbHwvAGC5iWZ9OrQ=; b=cOcKEcgbZFhuzGOyNS9B29qALg
	7vkNSYa+oo2RQH54aVWaktI9DMRtvhtpQOR1SXfsQJfyodwfDGXuyVY7gsJvFiuuMXF5XQ9FBTexC
	Nrvu4QifIo0xvXDBptzqz8Mk2xVYCZNj79kZwdhFDDlBYgxp0TyVNm/lSzxMwcVB9XPIDYOWkZVk4
	eV3UGg4FmL+3SMrJDB7/HTRIouau8q+asAClLkgO+DCzwOzk9jRjjWxSB2CNAYGduZfoV9DkrKuxl
	fs03l6UUFsSlxFsvsnD0UsO8Y5hj4HhJBs1u9AqxS5xxPUuSmrLoYIh0He/j4lF9gjSWlN3SZiGs/
	zU7DHaJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooig0-005lDn-Kz; Sat, 29 Oct 2022 10:02:52 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooifn-005lAG-G2
	for linux-nvme@lists.infradead.org; Sat, 29 Oct 2022 10:02:42 +0000
Received: from localhost.localdomain (unknown [10.14.30.251])
	by mail-app3 (Coremail) with SMTP id cC_KCgCHjQwl+lxjdEpxCA--.43876S3;
	Sat, 29 Oct 2022 18:02:29 +0800 (CST)
From: Jinlong Chen <nickyc975@zju.edu.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nickyc975@zju.edu.cn
Subject: [PATCH 1/3] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
Date: Sat, 29 Oct 2022 18:02:09 +0800
Message-Id: <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667035519.git.nickyc975@zju.edu.cn>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgCHjQwl+lxjdEpxCA--.43876S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1xtw4xGw1xAF4Dtr43Jrb_yoWfWFc_Wa
	4UCFy2yFZ8GF15ur1jkF15ZFn2kw1kJFy7GFWDW3srJwn5AanIyw47Cr1rCr4DW3y2kasr
	Wr1DG397Jr40gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
	xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgwSB1ZdtcJ3NwABsm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_030239_870439_95BBF7C2 
X-CRM114-Status: UNSURE (   8.40  )
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

Calling blk_freeze_queue results in a redundant call to
blk_freeze_queue_start as it has been called in blk_queue_start_drain.

Replace blk_freeze_queue with blk_mq_freeze_queue_wait to avoid the
redundant call.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cecf281123f..14c4165511b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4005,7 +4005,12 @@ void blk_mq_destroy_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	blk_queue_start_drain(q);
-	blk_freeze_queue(q);
+
+	/*
+	 * blk_freeze_queue_start has been called in blk_queue_start_drain, we just
+	 * need to wait.
+	 */
+	blk_mq_freeze_queue_wait(q);
 
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
-- 
2.31.1


