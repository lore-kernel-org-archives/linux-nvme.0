Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3727CA5FAC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3hG7gAnNiiTfsBSi2PGyaiacLDUHRJtGARhFUalygOs=; b=x4T+YP+xUlaBX9OAEbDPYVzjfn
	ER6ISn/aqtKy/lWx4Ai4S+ZPBbm2C1xEjd6pwKcEym+Pc6Id96uixt2GuEAZt3scZp4cRfiJCUTsy
	4WojFQwbY9/KR5HEGQSxKXPj11CCJWG8EkvFI393b84ychUHTZp5kkPYvIXyGtdHn1d0r0Waky6f/
	OGS++egeLqDGAWQZMWchm54HL1MnnA27P5INzWMnp4/DeoBt1Ijef/nZsZR+e0z0x4avomD/XH0uf
	OFv97CyoSLp8xfZy7zdSmVvDVNWi8RPigDFZR53Bp+U5xTnKZeMtrTBQZc0ddkSuwrHh69zEeFD56
	Yp6BPitQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVqs-00000003O0t-2Y57;
	Tue, 29 Sep 2026 11:18:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVqr-00000003Nzy-33xL
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:18:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D0CE0601DB;
	Tue, 29 Sep 2026 11:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7EC1F000FF;
	Tue, 29 Sep 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680704;
	bh=3hG7gAnNiiTfsBSi2PGyaiacLDUHRJtGARhFUalygOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fIICU7005CFwRCBHi+lbdhnYaq4FPkr7yodrR2h1Ov3FQ1tTPttGNJthpWsDtbqAV
	 tjJEdM69F78T4NtCb40lKRwDl1ZdZqrh0LNrfzzSIJSIgU8SdIQp5y5m63QpgXsUE9
	 Dv1SgNC4Qa1hV7PXnw5BRO1HSeWC+AcHY+bpkXPNbhaiJoXZhZ1zzj/QckUGVLkT+d
	 cP6ffDA1hJJBShkgHNjFcjmmP8P7Af9nBcuwz1HeKVvRkkEo3w8PfSVt7CbYIw69ml
	 7r65Wr8T0BTrOI4+DLQ8wNn0Mg6xykBDf/uBzOtIQJDF9MnuTQ5isjy5X47uC5P8i0
	 Vc1q0FddD+TYw==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 29 Sep 2026 13:17:12 +0200
Subject: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
In-Reply-To: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
 GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790680695; l=2913;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=ICRR4ZKLi0xfq5AAqBpnEFS2ZLtGWi6BUEH3zlKIjXE=;
 b=9tJ3uoVXscekgfB3b6UA8dq41RLoQfrI0/xg+EWMtki8SacbsnO9trRjqEpS4OJcgncF5ZYPa
 46MWafMb8OgDYulq33E244oD5iSzyKs32nlvOozBr3p0oRDA7s8H25S
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
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

From: Daniel Gomez <da.gomez@samsung.com>

Add support for Multiple Atomicity Mode (MAM), a superset of Single
Atomicity Mode (SAM) where the controller divides a write command that
crosses the atomic boundaries into per-window atomic writes. Honoring
the mode lets contiguous atomic writes merge past the atomic unit
limits.

Set BLK_FEAT_ATOMIC_WRITE_MULTI when the namespace reports MAM and its
atomic parameters are compliant; otherwise fall back to SAM. Re-derive
the flag on every rescan, and skip the single-write unit_max and
boundary checks because a merged atomic carrier can exceed both.

Assisted-by: LLM
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/nvme.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..69a565ac0da97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
 	struct request_queue *q = req->q;
 	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
 
+	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
+		return true;
+
 	if (blk_rq_bytes(req) > queue_atomic_write_unit_max_bytes(q))
 		return false;
 
@@ -2038,12 +2041,24 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	}
 }
 
+static bool nvme_mam_compliant(struct nvme_id_ns *id)
+{
+	if (id->nabspf != id->nawupf)
+		return false;
+	if (id->nabsn && id->nabsn != id->nabspf)
+		return false;
+	if (id->nawun && id->nawun != id->nawupf)
+		return false;
+	return true;
+}
 
 static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		struct nvme_id_ns *id, struct queue_limits *lim, u32 bs)
 {
 	u32 atomic_bs, boundary = 0;
 
+	lim->features &= ~BLK_FEAT_ATOMIC_WRITE_MULTI;
+
 	/*
 	 * We do not support an offset for the atomic boundaries.
 	 */
@@ -2057,6 +2072,14 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+
+		if (id->nsfeat & NVME_NS_FEAT_MAM) {
+			if (nvme_mam_compliant(id))
+				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
+			else
+				dev_warn_once(ns->ctrl->device,
+					"Inconsistent MAM parameters, ignoring\n");
+		}
 	} else {
 		if (ns->ctrl->awupf)
 			dev_info_once(ns->ctrl->device,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d9..8fdc4b91cf906 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -602,6 +602,7 @@ enum {
 	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
 	/* Since version 2.1, OPTPERF is bits 4 and 5 of NSFEAT */
 	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
+	NVME_NS_FEAT_MAM	= 1 << 6,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,

-- 
2.55.0


