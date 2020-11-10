Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F881C4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:54:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9F720870
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kUYAh+ad";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+dBO5WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CV3XNBcIP095S7RZsWNrs0k5nSkd+COZ/oU1TlzZivw=; b=kUYAh+ad3gvXYU4rAZJX9UJGI
	+oUmYtYExhHHHZ5w+E8/23mOdGd6ijOQGI9buoIXX3FJR0BthhO4TWl6h4RXGFMJRtcu/olbZ096T
	CDAVgBmWoa1goVnN77FjhdQ12kmu7fG0PgEw/fXbr3aTC9lmyzZTNj4I4/dywHh0dnVQkCn+RRYWJ
	7dy5BXWA2GRA3YTra6n/INrAFfUR7krs0cNNDmvzjhHkqJkgHrtW6Cy4EPTagDoL/AAS00BYGb4fo
	fWAUJLXWoa0IjKyUb19n9mX0QR6bqY/fC2aNEtr/7EYdqWaSwhtmirhIRgqPtxASYZadrHZgDl/fs
	VoAGwmAjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcKjL-0001ck-0d; Tue, 10 Nov 2020 03:54:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcKjH-0001aP-EI
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 03:54:00 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0672A207BC;
 Tue, 10 Nov 2020 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980438;
 bh=6IoiOFJUKOcUhztuRrXe9uOyWyzAOJU/nq/G7DDNUvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r+dBO5WR/M6rUsT3noxVNqk060j4t149FqY5FcewyLvFPQ50VPWJMqZqt91z2GiDM
 mpIZsnEYfbAnLFn0lnGDGaUBR8QccGk9saATHWs3oKQYBKHgjbiV1zdslQ0Ggjh3B6
 kb33pdEBBKNIpHntvpJJsv1/hpX2gxWO3LabYM48=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 28/55] Revert "nvme-pci: remove last_sq_tail"
Date: Mon,  9 Nov 2020 22:52:51 -0500
Message-Id: <20201110035318.423757-28-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035318.423757-1-sashal@kernel.org>
References: <20201110035318.423757-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_225359_582469_562950A9 
X-CRM114-Status: GOOD (  15.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 "B.L. Jones" <brandon.gustav@googlemail.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 38210800bf66d7302da1bb5b624ad68638da1562 ]

Multiple CPUs may be mapped to the same hctx, allowing mulitple
submission contexts to attempt commit_rqs(). We need to verify we're
not writing the same doorbell value multiple times since that's a spec
violation.

Revert commit 54b2fcee1db041a83b52b51752dade6090cf952f.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1878596
Reported-by: "B.L. Jones" <brandon.gustav@googlemail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8984796db0c80..a6af96aaa0eb7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -198,6 +198,7 @@ struct nvme_queue {
 	u32 q_depth;
 	u16 cq_vector;
 	u16 sq_tail;
+	u16 last_sq_tail;
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
@@ -455,11 +456,24 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
+/*
+ * Write sq tail if we are asked to, or if the next command would wrap.
+ */
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 {
+	if (!write_sq) {
+		u16 next_tail = nvmeq->sq_tail + 1;
+
+		if (next_tail == nvmeq->q_depth)
+			next_tail = 0;
+		if (next_tail != nvmeq->last_sq_tail)
+			return;
+	}
+
 	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
+	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
 /**
@@ -476,8 +490,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	if (write_sq)
-		nvme_write_sq_db(nvmeq);
+	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -486,7 +499,8 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
 	spin_lock(&nvmeq->sq_lock);
-	nvme_write_sq_db(nvmeq);
+	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -1496,6 +1510,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 
 	nvmeq->sq_tail = 0;
+	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
