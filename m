Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0529C25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gse2qJoDSssgUsyapAxBp4Ben7E1zAXFAgVJ+vm5wYY=; b=ffjA4iwz84AZRtSd0lwMenaPup
	7uluCKaxTHp0umUOyJWob47a9Vs+wsmRFboY+3BccJW0HAFHP5bzyT2Qo0sc0t1PfLxUvDO8LtW0K
	73UPI0sccQAhCnEnR7TBt0wjl6QfLu82yZgUTI5H/hyLCM6jkSkuvxDpwY3XRc9gTtBoO/2cyVnJm
	H/SgZWgDstOT5yKrQdaaYj9QSk/cANB+X0GQdBmm/nNRCcIwhrcbsai0LAVSDrXcUz9SFTYcnk3Vl
	tWCqZo8gx7Lzl39iV1c+dlsVUAIPjEODmQCcIR4YUCn+CsWQwp3dPFODr2g9WaAdGs3+8f3imV91X
	TRLQQL4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7k-0000000GgNh-0B5x;
	Tue, 14 May 2024 17:39:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7c-0000000GgH1-3DYG
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A5EB612FC;
	Tue, 14 May 2024 17:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C5C32782;
	Tue, 14 May 2024 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708367;
	bh=DovLNH0jWI5RgqORRkqm9l+XJ5AhX39zkvbiQ0Futvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlIQnAwcsHIjT3vGrkL2MlHhLWPBsGvCvVPdf6YEH0DurwDMzPZyTREBMAnohIoP8
	 MZSoLqMRqgEssNu+YSn/1n7lIxcjuMsNnBL0yvywsDlRye3O/VdiPXt4qXLXVsqsHN
	 Eq81/ab+itMx9Hc6sz9gas+Sn27iOmTGNHqwEVcUBwbJJb2W4DKiK467ozO+aVHs+z
	 FWQQ8IgOr9Fvb2Z2ssAuWhx1DLNw9stxLrNLxBSQd1vOpu1ELd1whGrnENf0DI+wDD
	 e0DL7xodgbMjwHDoD4p+TRYtNAkbjMcvNAAi4FIH/634i08v8lLwvqIE+WJCSdOirJ
	 h63mxYXobFr2A==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/6] nvme: enable logical block size > PAGE_SIZE
Date: Tue, 14 May 2024 19:39:00 +0200
Message-Id: <20240514173900.62207-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103928_962654_D96F12FD 
X-CRM114-Status: GOOD (  11.47  )
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

From: Pankaj Raghav <p.raghav@samsung.com>

Don't set the capacity to zero for when logical block size > PAGE_SIZE
as the block device with iomap aops support allocating block cache with
a minimum folio order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 828c77fa13b7..111bf4197052 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,11 +1963,11 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	bool valid = true;
 
 	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
-	 * allow block I/O.
+	 * The block layer can't support LBA sizes larger than
+	 * MAX_PAGECACHE_ORDER or smaller than a sector size, so catch this
+	 * early and don't allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (get_order(bs) > MAX_PAGECACHE_ORDER || head->lba_shift < SECTOR_SHIFT) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.35.3


