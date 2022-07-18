Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02673C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dM3ghhgxnlkbwLJcoodqJDD9GZrEmP4tEOZ6Awr/a6g=; b=qdX58ZpXPwJldrMcXL6uOkk4Dw
	rZ1X2JIKCxn/tBxL/8biTNg/ztuwKSlqRUIhQ0DEfo6bIYk384GfmfNF9kbvsuhRdyqtvurUVWzn+
	AoEL+AeBpLIPkOFRzk8D5LpzhXPkeCOeuONqLupi2n+/CsYRCls5C+LjfHV1ZDOET2oD7fflqGuHB
	P//iUIAnhVoCDouShxcJ8UBQb7mPHCx2x5fVqWisBgJl0FbkDy56Kq1dLRKH7gAO+9KisDqC9UdV7
	kstSNd5BiGzmPOb1ne/9Li4gi3Ys4/AUx6j7byInfzdr11rtAgHeTqacUSGCqwYJxhRFzlxf9osKX
	6r7UyuJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJFq-00B2UU-8v; Mon, 18 Jul 2022 05:25:14 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJFl-00B2SZ-1x; Mon, 18 Jul 2022 05:25:09 +0000
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
Subject: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to nvme_scan_ns
Date: Mon, 18 Jul 2022 07:24:59 +0200
Message-Id: <20220718052503.235270-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220718052503.235270-1-hch@lst.de>
References: <20220718052503.235270-1-hch@lst.de>
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eabffbc708cd9..88b14fbb7a5a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4283,7 +4283,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
 	struct nvme_id_ns_cs_indep *id;
@@ -4391,7 +4391,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_validate_or_alloc_ns(ctrl, nsid);
+			nvme_scan_ns(ctrl, nsid);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
@@ -4414,7 +4414,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	kfree(id);
 
 	for (i = 1; i <= nn; i++)
-		nvme_validate_or_alloc_ns(ctrl, i);
+		nvme_scan_ns(ctrl, i);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.30.2


