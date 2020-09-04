Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14625C2BC11
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F6720767
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ay+3pZHD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mde0QTIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JiSk9X7dHCPgI3hCZz9rCsOcJhq/ABInsGRP4scKz90=; b=Ay+3pZHDoNu5C49a224dKDS6M
	VcmIU19BkBlqoCL/she/btTA2hai1ZGJIpl7OqJdkNqNnP/7oNKWvEWSyWGt5K4dSqZZZHulmg3YC
	PjNKBgNlzTcaHYH1XcllE+g31qnt21tuZ7OfRHgAFUIcLA/VcICZk46jfU7WV3JGNZnlUERl6wPDR
	HQpg745zyesPAR2FGd/1s2O4NMGCe2r7I1C6cUP2KylsPAk3pAceD/ioj9OPYlwATWQqX4wQfT8mS
	WI76ytt5AP82PdKGjyUBqbSCQ5IX91iKs3lAGIZcuei7bbq638WPYcAryBQnaLh+K0bJ2+cvmaqLm
	9HmRR1CQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzPV-0003uw-HO; Fri, 04 Sep 2020 00:16:57 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzPR-0003uP-Am
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178614; x=1630714614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=olcwgN36G1pNKLgIO1mW5ScApwPe4wA+ik4Mu48aPOI=;
 b=mde0QTIAd+uyQWfvG15tJ1L/MTLgp+GPdwQsiN/AkH7qC9gHM8i6QalU
 cOm3wLVvf2E73pm1PetK1R6qg/kTI4TVHZkpBzIHQ36ruqJRMG0E6S9X/
 RyHXxOAIsDymflmqnV0GhCNx1L6S5LbRIEmh7NjjXM/1S2NhVBUrSfpm3
 lIeAUfP2mmHbM8OCp6rS6QneHhbDaIwIF5eQWg87tMSoXrUYpfrD8Ug/r
 lRCjAYtflUDuJFI4wmB1HFCX9lNWCPZrt45nQo5Pw3UOELDVGiLuluZxh
 ITC4GP2L5vqj10yREi3cJAC01d42FaCp3trJOnZd7bmXRtbWjPIvbU/dQ g==;
IronPort-SDR: Ch1eDL35xeLA2agbqGtyKlPfLGnfYhvVtm3c8WpMs6xh0vQbDg5aOcN3FRzdPGebRViZ6HDJsO
 br8/7F007rMhiCbV3mTOCCQGFWC7TU6Inwk9PnKW4wm3udYf0B+BYmYLlSbUchM2T/NWbwZRFD
 qMG4I9ZqFs9nzTkwhSqyeVODZPM8Fy4tZAOOVZtOmuFdKMdziNMbRBHw0dWYqFhdR8mcb/XIoi
 13EP3LKzMxWV2bspYYi+rKOCqvvlEFOV4GFokEx6Rb8nib2S+/3fFoCRfodv7fh/1Zg7HlsU0A
 eoM=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146532558"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:16:53 +0800
IronPort-SDR: oGvEhW4kkPt5WBpHW2XyJH5//uLvFAWvObmKAkD7b6lzCWpc7eDmT0dpPvm/5EXuDxdMMftuAJ
 lOtCrWVRNE6w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 17:03:25 -0700
IronPort-SDR: 47K64g7MZbuacucDaioNUxxnnKUbptm55RUaUtNHxc1+mBPtDsMAZWlqnTKNaElq78ghwE/Osr
 a2Pimk3MKjng==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 17:16:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/6] nvme-core: use I/O timeout in submit sync cmd
Date: Thu,  3 Sep 2020 17:16:21 -0700
Message-Id: <20200904001626.5694-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_201653_514285_504B4B02 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function __nvme_submit_sync_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the NVMe commands contexts (nvme_pr_command()/
nvme_ns_report_zones()) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

When timeout is not specified based on the request queue's queuedata,
set Admin timeout else I/O timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5702a3843746..e6c980962d51 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -884,8 +884,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	req = nvme_alloc_request(q, cmd, flags, qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	/*
+	 * For now admin request queue's queue data == NULL, if that assumption
+	 * changes it should reflect here.
+	 */
+	if (!req->timeout)
+		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
