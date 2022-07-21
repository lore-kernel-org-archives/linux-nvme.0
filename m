Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D425DC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oNEKJ01gu1v01HT4fpQH4aFpZPdp1k9f8c5a3pevRG4=; b=lyfzs+m41V8spxLzKf0rTAuMVp
	hPpujXMj1ZKRJGOlr4nKSfuCb7xcRFZijDJKJG/NGErQ0oA4SVrLWyE5lH/7joMl1VwCQLRW3hq/L
	5xvYuiVpMXd8v3++01Imr9JCkOuvEJBgnVT0XORmi3PmiddboXWWqNSyWwSzCNK31t5jsuEWZOKZn
	d7bl03QEsxhEqSQNzGaRzmv4uedIc34FxpTlP7xigD2+ObDlQW2yZ/wNi+M9PdqTsCaqcK6iGFndP
	7vLBEB3liN+j67vw1vnC+hJprs72CfLo48LzgXxLclgi2Y8PzqLO0lkNNrFwYtIKmtHTUzlkvtrhb
	qI3/xdpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPPQ-000mz3-Gx; Thu, 21 Jul 2022 06:11:40 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHV-000dcz-55; Thu, 21 Jul 2022 06:03:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/6] nvme: rename nvme_validate_or_alloc_ns to nvme_scan_ns
Date: Thu, 21 Jul 2022 08:03:16 +0200
Message-Id: <20220721060320.1704646-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
References: <20220721060320.1704646-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This shorter name much better fits what this function does in
the scanning process.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Javier González <javier.gonz@samsung.com>
Reviewed-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2e1af9b5c8a91..af3b90ca9131d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4285,7 +4285,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
 	struct nvme_id_ns_cs_indep *id;
@@ -4393,7 +4393,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_validate_or_alloc_ns(ctrl, nsid);
+			nvme_scan_ns(ctrl, nsid);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
@@ -4416,7 +4416,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	kfree(id);
 
 	for (i = 1; i <= nn; i++)
-		nvme_validate_or_alloc_ns(ctrl, i);
+		nvme_scan_ns(ctrl, i);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.30.2


