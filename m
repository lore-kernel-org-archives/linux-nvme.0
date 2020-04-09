Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFAC2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC428217D8
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UCpElqhU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqzI1vzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC428217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3lVfSTa0qWA7uXYc2x2DUuCCyiUYD2up+Mz3nVoY3Eg=; b=UCpElqhUvc2nrd
	GUjk9VV7E3SOAbqEtJDiLhdGzekIxB4ipOn8N/nRcR8m4lZBwADFoG1so5XNKn3eUeKvLhxzcLDIq
	++GBkxr5MjLoi3tuCYJ7YmE3M9b66nL35gUXtXZSlnFKdDFht/ba5GXc1a+F3W4zq8qdJDlEoqXiS
	WbAmEAllwI6INGvt7TTpzb/qJCLAbdqcTppF1fmYVDr2hDAvwHN+ALEwYSHghMRpJi/hEF2hbVstI
	IQ6SJu8/ep/+55KbarodZGHIfUq4JurXSVhCmPu01ldW6oRF1dJRBP2VkxsKEqWAFDuCtzR/46y3o
	umvWvWSsUMXbC55NhHJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZl6-00051j-9c; Thu, 09 Apr 2020 16:10:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZjt-0001Ry-Te
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:15 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49C41214D8;
 Thu,  9 Apr 2020 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448553;
 bh=kq+1Wg6Cm05n2ElfE5rTrr/xRri+QUG36vjp4nRq8M0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yqzI1vzsvv3r50G+JAcqSVr8s+pt6AWBXfq5wdjI3926+9SkISsatHuV2g8sT5Fb8
 guGRkKJ6SjmOF/I7a0Wv3ZSoJZA4frH1GMnKtJ2X6s7Yr+Fmn6zMwLJ1nwXElh73Ml
 uKt96Ef17Zt85jTpFtPkvAjefJnRnkxnfJLb7S3g=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 07/10] nvme: revalidate after verifying identifiers
Date: Thu,  9 Apr 2020 09:09:05 -0700
Message-Id: <20200409160908.1889471-8-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409160908.1889471-1-kbusch@kernel.org>
References: <20200409160908.1889471-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090913_976833_C869A911 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the namespace identifiers have changed, skip updating the disk
information, as that will register parameters from a mismatched
namespace.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a27dcb7fac7..081c9d47fb41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1935,7 +1935,6 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto free_id;
 	}
 
-	__nvme_revalidate_disk(disk, id);
 	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (ret)
 		goto free_id;
@@ -1944,8 +1943,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		dev_err(ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		ret = -ENODEV;
+		goto free_id;
 	}
 
+	__nvme_revalidate_disk(disk, id);
 free_id:
 	kfree(id);
 out:
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
