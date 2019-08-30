Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6056C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8432B23429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JhF3JL8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8432B23429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IQso3cYlklRJ+pEs0jhNFtD4gTLRgqEiXvC6B6bzBuI=; b=JhF3JL8jq6nFnPkc5Vw9axHBrP
	JnablSRH9FjD3SqfWhwbI4nz2po5lv7haCgELaWqGlXRSbFYCMCct27+L9YXOf+b8zxHPwvEHcloe
	vcxFYNrIJCqdVVv06ihT6ppA3CzipS0AtpoQo6goKAfBie9widNWVJvgp6n0rtV7LqXUk1t3LPBg1
	veEq0tNi595t+qfE4yyjowmZOSvJ9i04xOqO2TH43FSDzenTlXuWQFGWhb3vKZR5v/znTeulW/PgH
	z4Zw6C/TgCQxMtR6FjVYMwSr2Ho8wozPtbhrTq7GAnobCiuguvaxS4rKlkb314bn2Dkrvt3eZWLum
	I/1VgqLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mRu-0005Zb-2Q; Fri, 30 Aug 2019 19:20:42 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mQW-00030j-HN; Fri, 30 Aug 2019 19:19:16 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v10 7/7] nvme: fix ns removal hang when failing to revalidate
 due to a transient error
Date: Fri, 30 Aug 2019 12:19:14 -0700
Message-Id: <20190830191914.29713-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830191914.29713-1-sagi@grimberg.me>
References: <20190830191914.29713-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If a controller reset is racing with a namespace revalidation, the
revalidation (admin) I/O will surely fail, but we should not remove the
namespace as we will execute the I/O when the controller is back up.
Same for spurious allocation errors (return -ENOMEM).

Fix this by checking the specific error code in nvme_revalidate_disk and
if it is a transient error (for example non DNR nvme statuses or
a negative ENOMEM as allocation failure), do not remove the namespace as
it will either recover when the controller is back up and schedule
a subsequent scan, or the controller is going away and the namespaces
will be removed anyways.

This fixes a hang namespace scanning racing with a controller reset and
also sporious I/O errors in path failover coditions where the
controller reset is racing with the namespace scan work with multipath
enabled.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84ff3b12ed50..bb685af53960 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1768,7 +1768,13 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 free_id:
 	kfree(id);
 out:
-	if (ret > 0)
+	/*
+	 * Only fail the function if we got a fatal error back from the
+	 * device, otherwise ignore the error and just move on.
+	 */
+	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
+		ret = 0;
+	else if (ret > 0)
 		ret = blk_status_to_errno(nvme_error_status(ret));
 	return ret;
 }
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
