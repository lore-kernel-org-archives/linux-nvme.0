Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B731C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jd9ClsZn8dY52Thwduiwucevo5VuBYcc8qo3tnNAMNw=; b=JdkRgEEVNK00N0XMvNDnLMNglY
	7Xg3BIZ3+Nflqab7+8id+FIRzsZPY06jckxloVManEgUPtS9s96UVp3o8/PYFWmha6XVosypSVF67
	4QaHZWT3SMZl7SaYCSA010/mcRZ+3kDW4M0srBX/dwzgC/GJgh04rtG0VxJeQRgORC0tXo3LE1EQv
	oa0uZ7tLuxeOGzI0xmQpV0T57eTKamM5Bwr0rZgADP6LqoP3MI2cu9mAE9uxowQCGUfY7qZk2WMcx
	fTi8UQJHI4Sm/uPx5iOa3g7IvjHNH8G4rII45OIYEFLniYB1kp0qYYZNuq2RQjCxBaLdmtsrXPFCy
	bMiQ38uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7SUr-000doa-LQ; Wed, 12 Jan 2022 01:32:17 +0000
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7SUn-000dmP-II
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 01:32:15 +0000
Received: from HP-EliteBook-840-G7.. (36-229-237-100.dynamic-ip.hinet.net
 [36.229.237.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DD30541941; 
 Wed, 12 Jan 2022 01:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641951123;
 bh=Jd9ClsZn8dY52Thwduiwucevo5VuBYcc8qo3tnNAMNw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Xb1Bjh4x9tA2CLxIgjsBPbs9Bfk5iWUaVfSZVwZn8dwF7XkY55BasZkGZxs760GS7
 Jy+iix38ttC+Q50SvYSEKojrLhLpY84Io23p8mhf2wsx0lGrzdiX+qpxkS1sS7WaMT
 qe8id+jmJDUJhJqtrEeRg9XU2WlJBswbbu534i0mO6KIv8LYzuldV3JvSya72b8mRy
 esBma+1J+W6+I1dXuI2UzDmuFQJrZaIpGcWXXIER7XN7dG+RNASqv5NCTul9vu+rRC
 GE0IGAuOESTBrH1NqW2dtSCjK6MOpimcTmo/a4dC5a7VJ1cKze1LgiZCTE3qlM/V7C
 gsNcoCbXRlo5Q==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Mark external NVMe devices as removable
Date: Wed, 12 Jan 2022 09:31:54 +0800
Message-Id: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_173213_808856_9285547F 
X-CRM114-Status: UNSURE (   8.18  )
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

Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
entire Thunderbolt hierarchy as removable, if system firmware provides
correct attribute.

So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
userspace daemon like Udisks knows it can be automount.

Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1af8a4513708a..1c3b04883965f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3851,6 +3851,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
+	if (dev_is_removable(ctrl->dev))
+		ns->disk->flags |= GENHD_FL_REMOVABLE;
+
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
-- 
2.33.1


