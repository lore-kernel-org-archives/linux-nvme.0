Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB2BC55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tur8zxfAJZqkHi1FFdRTb797VuaFIxL1CU+5nZF205Y=; b=kI1ZlkK/gBn4oCF0nmEab/6pNG
	l4lDxiANQ5EZir8RI1F8H6aUqJj+byl7EZgcOyoogB83uzCvisARM5Dujb4WEQR9xlsaQZ7OrTAN1
	yCSCprvEVQZzLm820XxQm9XWwNsikgWr7u4piMKVqePKofWgfc60PGsaRUhtBNLuJQt0QmpaprU8N
	ob60wgMgFqf+6Veinv9GTH8GjXcQxNjK2ISFETS3XpJ4zV0t45qENCvz/O/w4LjQUb32Ln5g2ds+6
	oh4D8i0+25JEgCx8R8E676NecQedpwpt0Ra2TGLG5NR+Xp5kvE3ypobToQyX5+ClGsjrtuM8ESlqm
	tENpEkFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kU-00000000pOq-0e4w;
	Tue, 04 Aug 2026 02:19:22 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kM-00000000pJU-1ktu
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 02:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785809952; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Tur8zxfAJZqkHi1FFdRTb797VuaFIxL1CU+5nZF205Y=;
	b=k5ZWnNlFQgiQDIs+sNAdyo3hRlxUso3JaGXRxoPVPRjRiYDV+qzifX+8eLYkxxcaGKCB4Mn9jZS0ciYNIvE+fW2N3yEVQYdo2+hH5ZDulQmIjmn+OZU79Fc9n/WpfDD6gE8vkIRvPWjKAGC9BvKF0rAAaP0RxIBbmNaSFd4bx2Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8MDIzj_1785809950;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MDIzj_1785809950 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:19:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 5/5] nvme: raise FDP placement handle cap to U8_MAX and warn on overflow
Date: Tue,  4 Aug 2026 10:19:01 +0800
Message-ID: <20260804021901.3777326-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260804021901.3777326-1-kanie@linux.alibaba.com>
References: <20260804021901.3777326-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_191915_214409_AE291147 
X-CRM114-Status: GOOD (  13.46  )
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

The RUH status buffer and the placement-handle clamp used S8_MAX - 1
(126) as the maximum descriptor count. That value was picked only so the
io-mgmt-receive result fit in a page, not because of any protocol or
driver restriction.

The meaningful upper bound is U8_MAX: write hints (bio->bi_write_stream)
are u8, so placement handles beyond U8_MAX can never be selected. Size
the buffer and clamp nr_plids to U8_MAX, and emit a dev_warn() when the
device reports more handles than the driver tracks so the truncation is
observable.

Suggested-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1f444cd3daf..14832be67779 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -33,6 +33,13 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+/*
+ * Write hints (bio->bi_write_stream) are u8, so FDP placement handles beyond
+ * U8_MAX can never be selected. Cap the handle count to bound both the RUH
+ * status buffer and the per-head plids array.
+ */
+#define NVME_MAX_PLIDS		U8_MAX
+
 struct nvme_ns_info {
 	struct nvme_ns_ids ids;
 	u32 nsid;
@@ -2342,7 +2349,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	if (!info->runs)
 		return ret;
 
-	size = struct_size(ruhs, ruhsd, S8_MAX - 1);
+	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
 	ruhs = kzalloc(size, GFP_KERNEL);
 	if (!ruhs)
 		return -ENOMEM;
@@ -2358,10 +2365,16 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
-	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
 	if (!head->nr_plids)
 		goto free;
 
+	if (head->nr_plids > NVME_MAX_PLIDS) {
+		dev_warn(ctrl->device,
+			 "FDP RUH status reports %u placement handles, capping at %u\n",
+			 head->nr_plids, NVME_MAX_PLIDS);
+		head->nr_plids = NVME_MAX_PLIDS;
+	}
+
 	head->plids = kcalloc(head->nr_plids, sizeof(*head->plids),
 			      GFP_KERNEL);
 	if (!head->plids) {
-- 
2.43.7


