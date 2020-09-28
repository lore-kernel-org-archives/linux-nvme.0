Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46141C47425
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE56F21548
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Shjd7m+y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZrVeGP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE56F21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UaBWZEUJiuJ0WeOB/1lohTv4HxS/oNrDUnFx+zGEZUo=; b=Shjd7m+yjii0fVeJwhKmD3v00
	Rn86cAglvTfPMEBGlndPkB7PGrMD2hPHa6xbdyb056rNU8ZPRC2qhn9eslCkmGnhsz46sppmn+oug
	xiEuLZaj95xRgZIbingwc/UqVSjU7ssdw+XyMy9b0uMafpW86H1rxH8IL6uajJCl/wwVn0e6ESSgU
	9hASfG+5NQD7TslkM9sxra2LCzYZ7yqNwSNK1MWyy+TaqGFlAYtstw1ETvKGuyPrkhl5VaY5RvIJY
	Ym9xdj+k7+53KTxHBluYDShDD1GMtLJ+7aDuVy0vVHJ1dTJ5RjBpJIP9KobQIgXe+B/rdmtQEwjen
	F1jF9WGOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsN9-0002M5-0m; Mon, 28 Sep 2020 12:35:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN5-0002Kg-4Y
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=z9YhGcnxFfemg4/IfCiW6+acRqOXyGyIJcCbaHUp14Q=; b=gZrVeGP4+rpHKlKqHnUsaRi3kL
 U2rfMlL7xR7SljxncBSnsaFzjp1cGk/7rKHYfsZfV6LjBlOCc/GI43KdsiVDnUsjE/YKJT9hP+Z8y
 xd0go26ZPNAKKkqqK270+4CUeG4fmGSofy/dvriJikJMBgqKQDTZWikve+W/0WZifeEuUiE0vmTOq
 JvNaeiN9WgDRd+S1tfw69MMcLMUrIYEDj6dc2GHjh0dMoUhGw4855toCnMRrP7n8ssf4BmdRFQPIa
 SEZUTwP+oNynKQN/Zn+2NoT16nZBYNCfqcNPaJBJORMuaro24LFYQMbDMPBjhIrhsv/4XpZEjpKJg
 jDqsCQsw==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN3-0004i4-Vc; Mon, 28 Sep 2020 12:35:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
Date: Mon, 28 Sep 2020 14:34:46 +0200
Message-Id: <20200928123502.435373-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use a slightly more descriptive name to enable reusing nvme_validate_ns
in the next patch for a lower level function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4b5032084972a..c5f2615bf58374 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4021,7 +4021,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -4083,7 +4083,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_validate_ns(ctrl, nsid);
+			nvme_validate_or_alloc_ns(ctrl, nsid);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
@@ -4106,7 +4106,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	kfree(id);
 
 	for (i = 1; i <= nn; i++)
-		nvme_validate_ns(ctrl, i);
+		nvme_validate_or_alloc_ns(ctrl, i);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
