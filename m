Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6BC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569DE206A5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+GFS4WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569DE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tUTTrDkcJhj0+LKQXm3rZrKD+Baud0IrqaBj8TLa+o8=; b=a+GFS4WZeY0KD/8Ml78drSq4Th
	SLDS3HVerFcj1A/h+uZct5imuZNAjN5mOfLp5FAdxGatmhXTVSmgucIGcSz77nSnnUHKq1dvx3N7K
	C9jBmACpkW31OPxbx5zDHD56Sz+WdBpR2qozNWQ8fx0nt8XYbyTNItGXdhBdYdgNe5VKznxy3F6Gz
	Wy6crYTWasjarp3rK+m4QddiGK9Rb2NW+H/mLF6xp8HmtAKuv6trUzBqynDUlL/0rexeGAPCaOPaD
	iWREUxZcOn/3XOlBXc7BaZIBSj51gltJwr0kr2pb2RlG8hgcn2BK5p+aUIswA1YETLCSMOno1ink5
	lz8+NEDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5sk6-0007It-Sc; Thu, 05 Sep 2019 14:28:10 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5sjs-0007D6-Vk
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 14:27:58 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 07:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="187991052"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
 by orsmga006.jf.intel.com with ESMTP; 05 Sep 2019 07:27:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/5] nvme: Prevent resets during paused states
Date: Thu,  5 Sep 2019 08:26:04 -0600
Message-Id: <20190905142607.24897-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190905142607.24897-1-kbusch@kernel.org>
References: <20190905142607.24897-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_072757_027710_FB73863B 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A paused controller is doing critical internal activation work. Don't
allow a reset to occur by setting it to the resetting state, preventing
any future reset from occuring during this time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91b1f0e57715..d42167d7594b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3705,20 +3705,23 @@ static void nvme_fw_act_work(struct work_struct *work)
 		fw_act_timeout = jiffies +
 				msecs_to_jiffies(admin_timeout * 1000);
 
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return;
+
 	nvme_stop_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
 				"Fw activation timeout, reset controller\n");
-			nvme_reset_ctrl(ctrl);
+			if (nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+				nvme_reset_ctrl(ctrl);
 			break;
 		}
 		msleep(100);
 	}
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
-
 	nvme_start_queues(ctrl);
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
-- 
2.14.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
