Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9BAD1171E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=43Z+6YU1jcdWT/ySItftgvu9uMoMRRIwlJCZgUIbD6k=; b=tvIy8A7yJGR6djmLBe3XRW1n5z
	xVoIJtFtZZUzVxZi1/tTQL6Dpdw5+kS6h+SIPM7t6d2q31EnSiG9o2gi38v6A96Lk0WZDRAO7GCeI
	Zx1MOG2dPxYMZvnyiVL3w3bpBRIXunMz0AHvJ2JGc6fcKZwfbETkMXgj6NV9bDvwM5UAJQKNOGcdu
	ucLhidpCKMrrDCpcB6bugOUkZYnGzcb2hDfTntBM0XFc78rwUxdNm9sPToMw8MqDWtnTihb3KJDKR
	WlbsUPxh5Zvlo3MExM0BdomJ7MBZC9Iu5QZk+B4VzLqv8JVwXVAP1H2rp144X/3vYz5sS8RlF3zn6
	1qntlnDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQV17-00000005iQd-33zp;
	Tue, 02 Dec 2025 18:22:25 +0000
Received: from out30-84.freemail.mail.aliyun.com ([115.124.30.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQV15-00000005iQF-0VrF
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 18:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764699739; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=43Z+6YU1jcdWT/ySItftgvu9uMoMRRIwlJCZgUIbD6k=;
	b=TUrY6u9NIPE1TW1uTUXtmkSieLLORKUMuW6nwh6M8OI/B4f55L9MFPAp6Ptl6xF8KI+7Bhz9rc3aQfCWTqTH1FT1ydFApTWVFFIXBC0Y6lmRPMwaKwEMNggjK8eAVM4Q1NSrNIaiJfysnnbpdCs7ANSXJbxc581LQTD0qhWeY7k=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtxZP9a_1764699736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 02:22:18 +0800
Date: Tue, 2 Dec 2025 21:22:13 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aS8uVVBz_n4lI3bM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_102223_325042_C3FB1EA9 
X-CRM114-Status: GOOD (  11.91  )
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

Broken or malicious controller can send invalid ns id.
Out-of-band memory access may occur if remaining buffer size
is less than .nidl (ns id length) field of `struct nvme_ns_id_desc`

Fix this issue by checking (header size + .nidl) against
remaining buffer length.

Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
---
v1->v2:
 * Simplification: do not touch nvme_process_ns_desc()
 * Update commit description
v2->v3:
 * Even more simplification
 * Replace while with do-while as first pre-loop condition
   check is pointless
 * Change `pos` type: int -> size_t
 * Update commit description
v3->v4:
 * Replace do-while with for. A bit exceeded 80 hard limit but still in
   100 soft limit
 * Restore `pos` type. This is subject of another patch if we prefer
   minimalism
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1f719351f3f..253d35937f03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1540,6 +1540,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	bool csi_seen = false;
 	int status, pos, len;
 	void *data;
+	struct nvme_ns_id_desc *cur;
 
 	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
 		return 0;
@@ -1563,11 +1564,14 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 		goto free_data;
 	}
 
-	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
-		struct nvme_ns_id_desc *cur = data + pos;
+	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur); pos += len) {
+		cur = data + pos;
 
 		if (cur->nidl == 0)
 			break;
+		/* check ns id desc does not exceed remaining buffer by size */
+		if (cur->nidl + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE - pos)
+			break;
 
 		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
 		if (len < 0)
-- 
2.47.3


