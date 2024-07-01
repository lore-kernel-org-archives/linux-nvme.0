Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A31C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 05:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CijqbYlkFh+sW64CWr9CSIh+vK9hGYl7zQAQz0uqRY=; b=MX8AMkLJZL4fujr839JVIZOEyw
	0ogJKrpn7IKUfTIS4o5B3tkj6sTUbFBJBLEuXpdDWCagfLPmecSVWeuNz/7zoKhOlrAciCREhaP0p
	qR9Q1Ayt/X/HFD2uyn3SDDplxrLeNwDTI8E1+96GVr6iVJVdRMt97M0Kqia3c6zgT8rWJ0WRT2EyA
	Lq44qAO9s0x/4YU92bu/Xj4IVdBLm0Z4sPoxfBrVs5KSG7eypMjqHatwfN13HEOKxyNHzLISGwp+u
	3iUyFoT2XRFNplKeBFAoRwe6sRpAl9Xbj9Hd2gWjczOweO3U5ph5EhEbMRKc7d47tmWIIWDzq5ydj
	WY9w2BRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9Qa-00000001iyi-2Re0;
	Mon, 01 Jul 2024 05:18:12 +0000
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QY-00000001iwr-07vB;
	Mon, 01 Jul 2024 05:18:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Date: Mon,  1 Jul 2024 07:17:52 +0200
Message-ID: <20240701051800.1245240-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
and we thus can't detect if it isn't set.  Thus a NOWS value of 0 means
that the Namespace Optimal Write Size is a single LBA, which is clearly
bogus.  Ignore the value in that case and don't propagate an io_opt
value to the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab0429644fe378..6784fc6e95625e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2025,7 +2025,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
-		io_opt = bs * (1 + le16_to_cpu(id->nows));
+		if (id->nows)
+			io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
 	/*
-- 
2.43.0


