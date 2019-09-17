Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90ADC4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 22:41:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7899120678
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 22:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UTveXCjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B7xeFlXfg6T3ogAZew5dHXMdJlcD2ATDTJYo72Pz5fM=; b=UTveXCjoZTHgM9
	a5n8x/UdszOCTWY0Bnl98mYMplYdJALThiSjn6h35oR8/eK1oBk3uZ3Dqivb2EXcRP/m8lPMpfJgg
	isc6cADrVM+moiJqsttSaoTAQXRLmUuyIMKoIS5f7nVN84lyq/BkIlv3AA3SxJgzFPywyHsCYQA/g
	bBkHJcLwwuv6gqWyGSov0YECBRgqe4DQdKf1DDU2pdb8/PgBu5RRSsN0/MiT5oJRPce+u1k6FqgsI
	Uq88ZjJocwH7Amz2GacQTG3Pbz0H2V0O9Na1rbGl4Uc7tKjt/SrJ7Jv+A+GJ5+hT8jGc9HwZSfuUN
	PTu23oYyoMtDvir0NZ5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAMA1-0000YH-CL; Tue, 17 Sep 2019 22:41:25 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAM9x-0000Xc-KR
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 22:41:23 +0000
X-IronPort-AV: E=Sophos;i="5.64,518,1559520000"; d="scan'208";a="833533121"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
 email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.34])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 17 Sep 2019 22:41:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS
 id 50334C05BA; Tue, 17 Sep 2019 22:41:10 +0000 (UTC)
Received: from EX13D16UWB004.ant.amazon.com (10.43.161.170) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 22:41:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D16UWB004.ant.amazon.com (10.43.161.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 22:41:09 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 17 Sep 2019 22:41:09 +0000
From: Balbir Singh <sblbir@amzn.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme/host/core: Allow overriding of wait_ready timeout
Date: Tue, 17 Sep 2019 22:41:05 +0000
Message-ID: <20190917224105.6758-2-sblbir@amzn.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20190917224105.6758-1-sblbir@amzn.com>
References: <20190917224105.6758-1-sblbir@amzn.com>
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_154121_707530_02A47D72 
X-CRM114-Status: GOOD (  14.77  )
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

Largely for debugging purposes where controllers with large
timeouts get stuck during reset. In my case I have a simple
mirroring raid configuration on top of nvme using mdadm.
If one of the controller has IO timeouts and takes very long
(128 seconds worst case) during IO, I am happy to
use this debug option to drop that controller quickly and
let the system run.

Signed-off-by: Balbir Singh <sblbir@amzn.com>
---

Changelog:
 Implement simplifications suggested in the review

NOTE:

I am still sending this out for larger review because I think
this is helpful, there is some concern that the values might
be mis-used, a quirk does not meet my requirments and the
value of the timeout is global (as in it applies to all
controllers). I think it is still useful to have this for
my use case for the lack of a better solution

 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6ad1f1df9e44..798edc609d6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,6 +40,10 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
+static unsigned int nvme_wait_ready_timeout = 0;
+module_param_named(wait_ready_timeout, nvme_wait_ready_timeout, uint, 0644);
+MODULE_PARM_DESC(wait_ready_timeout, "timeout in seconds for ready on reset");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -1930,11 +1934,15 @@ const struct block_device_operations nvme_ns_head_ops = {
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 {
-	unsigned long timeout =
-		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	unsigned long timeout;
 	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
 	int ret;
 
+	if (unlikely(nvme_wait_ready_timeout))
+		timeout = (nvme_wait_ready_timeout * HZ) + jiffies;
+	else
+		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
