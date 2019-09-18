Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F1DC4CECD
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 00:27:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34710206C2
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 00:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TF+sDs0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34710206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ISa47YBbQXw6HwLXvQRAbtzXxZOWfGQiAc8HIhHhJvU=; b=TF+sDs0KJXbeYp
	/iXP2aoieIeivU086jhxmZwMv2UgCZIXT9+VPY8TTINnz8gLDfEPH38pkcakC4AikehERomhpJLaZ
	RTI3WD5A1CiXzFpielLBV7saVwVE/K98AjuB6pphMTAn8u04Ztmzs3mvCwb4H+jqdGxGFVXG2Std0
	PUqm9QPec0WhOrzOV6WR+U939P/+k4JtW26IGLRlNZbKVijiKOcGrlZdhGrJSLbUrrfykE9cCXklG
	aIL7JBKcl4Q7H0dkDbUk80JMND2ISNA6RFq3BUWzYZNlEc85Z+P4zyz1GxAxI56G+OOWh932M6q49
	NQ48nEO8JGAyKS2+t4CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iANop-0007c8-Lm; Wed, 18 Sep 2019 00:27:39 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iANom-0007bb-40
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 00:27:37 +0000
X-IronPort-AV: E=Sophos;i="5.64,518,1559520000"; d="scan'208";a="833569971"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
 email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.34])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 18 Sep 2019 00:27:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS
 id 9E9AEA2226; Wed, 18 Sep 2019 00:27:23 +0000 (UTC)
Received: from EX13D23UWC001.ant.amazon.com (10.43.162.196) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Sep 2019 00:27:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D23UWC001.ant.amazon.com (10.43.162.196) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Sep 2019 00:27:22 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 18 Sep 2019 00:27:22 +0000
From: Balbir Singh <sblbir@amzn.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v4] nvme/host/pci: Fix a race in controller removal
Date: Wed, 18 Sep 2019 00:27:20 +0000
Message-ID: <20190918002720.18330-1-sblbir@amzn.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_172736_204035_464A8D16 
X-CRM114-Status: GOOD (  10.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, Balbir Singh <sblbir@amzn.com>, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

User space programs like udevd may try to read to partitions at the
same time the driver detects a namespace is unusable, and may deadlock
if revalidate_disk() is called while such a process is waiting to
enter the frozen queue. On detecting a dead namespace, move the disk
revalidate after unblocking dispatchers that may be holding bd_butex.

changelog Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
---
Changelov v4
 - Simplify the changelog
Changelog v3
 - Simplify the comment about moving revalidate_disk
Changelog v2
 - Rely on blk_set_queue_dying to do the wake_all()

 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b45f82d58be8..6ad1f1df9e44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,10 +103,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	/*
+	 * Revalidate after unblocking dispatchers that may be holding bd_butex
+	 */
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
