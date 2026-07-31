Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45977C55162
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/gF6v6qt0g8jeFLvxWZgJVhzF0AJ9p62WX7VfZB06A=; b=zLknTpj6ZaTnXE7Uzd+FS6mpll
	/d9YldM5nYG8z9UTvKFrysOaQTceJNWVtoT5p6CsRtNotkZOc+/aMmUKJebFLI3fOyW/CoBhkNu6Y
	sSb3+lhNyFPpxjJWwAdUnk2GF1Ocdul+Z1TPIZ4j+V6hD3chh9nFthcRZxtgjP/aQ8R6NDigBYLif
	uji5F4B+VywZgQjC2zKmnxFJIKAqt9ITc8elY3utcuBfGGmECcZsf5rgUwGmRBmiMu2tcKTRLlFdY
	W9mYKsDxNQ9WFiGzakRPh42/L8M/RkEE1hLeXe747KG2jhlwXxIiCXIwqq1gtaSKWbFuUWdyeTb7g
	bdlJRHSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdno-0000000BfkS-3ci4;
	Fri, 31 Jul 2026 03:20:52 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnh-0000000Bffi-3bQy
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468044; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l/gF6v6qt0g8jeFLvxWZgJVhzF0AJ9p62WX7VfZB06A=;
	b=ppoLwQZ1srnG6AnP4yLxnpOF/h6lSgv4uxSPvJJCMqW2lIAMaBGMnQZmbIcvj+GbJftCnEgXSShOCr/9jBDPvF6ykJTg84hMiZxelWk1hBo+L7TixrRwL/fgNeJ9mAQqtOA2lL/OZiM3a1XPfbyYbN1ssCXQsJFcHmyaAfmmWFo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86jPn3_1785468041;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86jPn3_1785468041 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:41 +0800
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
Subject: [PATCH v2 5/5] nvme: raise FDP placement handle cap to U8_MAX and warn on overflow
Date: Fri, 31 Jul 2026 11:20:31 +0800
Message-ID: <20260731032031.1090755-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260731032031.1090755-1-kanie@linux.alibaba.com>
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202046_195365_99B6C191 
X-CRM114-Status: GOOD (  13.00  )
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
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1f444cd3daf..19c2fcc0923b 100644
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
@@ -2318,6 +2325,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	struct nvme_fdp_config fdp;
 	struct nvme_command c = {};
 	size_t size;
+	u16 nr_plids;
 	int i, ret;
 
 	/*
@@ -2342,7 +2350,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	if (!info->runs)
 		return ret;
 
-	size = struct_size(ruhs, ruhsd, S8_MAX - 1);
+	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
 	ruhs = kzalloc(size, GFP_KERNEL);
 	if (!ruhs)
 		return -ENOMEM;
@@ -2357,8 +2365,13 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		goto free;
 	}
 
-	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
-	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
+	nr_plids = le16_to_cpu(ruhs->nruhsd);
+	if (nr_plids > NVME_MAX_PLIDS)
+		dev_warn(ctrl->device,
+			 "FDP RUH status reports %u placement handles, capping at %u\n",
+			 nr_plids, NVME_MAX_PLIDS);
+
+	head->nr_plids = min_t(u16, nr_plids, NVME_MAX_PLIDS);
 	if (!head->nr_plids)
 		goto free;
 
-- 
2.43.7


