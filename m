Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A626C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EDF61468
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EDF61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mjyte5hDVKhjsONQsdYEjROfPfH0MGgKfCeCYr1BzIg=; b=D8nh37CntgDCDrPvQ9wRlYFHB
	leFivuL6DuJmnBk1wROEdgT6eLGN+uLcpeoFHmPlHUpBaqzDgavfOp931S5VlNHIxy93j3uG8W13+
	xzhjOdfTZlSoQ820r1qyVoB+GLf2ujNmCzt81K1VQDjYYo5mgh+WVbzm7HxpKVh/MwbLq/KpQhHms
	UmlOHvGLvnPrD2G7psK2uz3KLkiloeCCC1KWSupc/sGzDhXy3YdR5pGVth+z6P7IIo9HZxTN8z/bA
	s7tG8TRzVWeQTuq5wV7tlN6nXa/1DexPBTsHNdFVpVGxWa1yx6/YV2I8hMASYkV/DU88wxb2WQiS6
	FJPYubr+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3wK-002TFp-Er; Fri, 23 Apr 2021 22:06:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w4-002TDY-DE
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=J/dMmdW+iVvwyTpM2onmGaS7jBAOwWpdGXnCEKVSxu8=; b=Rj7jI7Ceqq8LndKA4Osdb/Hkch
 KuH6szgnec8hDfzFIlm7CpsmcZGFM+cu+sRJWOfSrPr2v6jZSOqHBeTA062rndzsfO8BLK72t/HW8
 blcyNdL1btHOQD+2fhHRND+vcgmH252c1ca41L90Q+pVsPcLCaC8bXmJjRirGkXa7bXdhCsySdL0U
 pax3ykFvdgv1tD9tlYgtAqMsyfxnC4zh5xPzdfgqyP2u/crdEHBZf+Zi2jMJSfwq1SBHtCfFtXRUo
 tAaovIbK//EvHeP23b8H1hngrb4tsiS/+b6RX9WtTpOT6O3RTOswPRmlQJ+iTO92c5p2uzmjqhNC+
 v0V27ibw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w2-00Ej83-3A
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:06:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 373A9613AB;
 Fri, 23 Apr 2021 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215561;
 bh=W6iSvtmcGry1oGNwCHkbmf8AJ6FjkkxhjYdlYI6DiKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SEK+OeK4LP79mREz/vtHtLxP6evSWlgetgB3oPi98zYDr9A4qIRm/ZlXHKER93LyZ
 bKQmG29duJ3brVA0uQnFNRHsfns48RkkwNvOkfntzWDmhABi81kox58u2G0njNFS/m
 kE/nzwNlkzmopyfz058boUv9jW2qps3ETAKcyGcAKrOA0E708dyW+hlt4A7tEVdcmk
 qZeFJEgUPg5Y3yeiQ9QYNgmMU+446gLji+GSGiF2++1M/Zk4dxAEuKjkVFaDUCXZC7
 z7lfb3NTOR71RRrKQVx97d7FLUUrnpxEgFeHTAaNGtWZpnTSpnNDdy2JaryPl9FWgn
 22c7vEE79mFNg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/5] block: support polling through blk_execute_rq
Date: Fri, 23 Apr 2021 15:05:54 -0700
Message-Id: <20210423220558.40764-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150602_170329_C0B589CF 
X-CRM114-Status: GOOD (  10.57  )
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

Poll for completions if the request's hctx is a polling type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..b960ad187ba5 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+static bool blk_rq_is_poll(struct request *rq)
+{
+	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+}
+
 /**
  * blk_execute_rq - insert a request into queue for execution
  * @bd_disk:	matching gendisk
@@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
+	if (blk_rq_is_poll(rq)) {
+		do {
+			blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+			cond_resched();
+		} while (!completion_done(&wait));
+	} else if (hang_check)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
