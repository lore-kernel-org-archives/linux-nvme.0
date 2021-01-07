Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C63C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E3323403
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E3323403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjoMmh7ntrUPLO0wjvd8wvlRQYKACikJe9fr5jZEPZc=; b=OwPVGdWik6j+0/oSI6VuhPznep
	qJU2b0XZh3rn52y0yTEceuYLCM8yt8bCICaU9m5tKj01zA+duD0WTb/IB06jzqO23wBzzDOp37Qi6
	cdgkOI5A2Kz8VytX2/NLBW3y31qatPZ7k0TMInB/VDJRfbuaFCduKB7iWdfHSnEf57IFgHT9nRlHN
	dcVoqKo2ZRFZ3uUi8kJAbujAxWW+nmVqo1sOceSJRb2o9l+9itg9X2TbyOl6b/WF8ngD83cDOlo9e
	6/wGA7YTtUDko6TUbQe87dvDrrRZILheO6HdpLPcPDRnYBoGjawPM4xu5QwpKk4fvlmlAFSh6Jyu5
	h5h4628Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxXJY-0001jw-K3; Thu, 07 Jan 2021 15:35:04 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxXJ7-0001gZ-JI
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 15:34:38 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@nvidia.com) with SMTP; 7 Jan 2021 17:34:28 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.210.9.36])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 107FYR4g016765;
 Thu, 7 Jan 2021 17:34:28 +0200
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/2] nvmet: Fix nvmet_is_port_enabled indentation
Date: Thu,  7 Jan 2021 17:34:14 +0200
Message-Id: <1610033654-25186-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1610033654-25186-1-git-send-email-israelr@nvidia.com>
References: <1610033654-25186-1-git-send-email-israelr@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_103437_947183_E56C90B1 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>,
 Nitzan Carmi <nitzanc@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove extra tab.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b2021bf6cee5..635a7cb45d0b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -45,7 +45,7 @@ static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
 		pr_err("Disable port '%u' before changing attribute in %s\n",
-				le16_to_cpu(p->disc_addr.portid), caller);
+		       le16_to_cpu(p->disc_addr.portid), caller);
 	return p->enabled;
 }
 
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
