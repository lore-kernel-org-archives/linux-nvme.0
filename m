Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D99C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC1D23406
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC1D23406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=08kvvcm/73rsUMi9U0tFNnhD9pmw5NrZDZttdamvf3M=; b=DKiO+hmVr/u4pmg+8dsaX5JUu9
	+p8c5o6Fw5JZhSvRy0D8CEw07bnDTzZTGVa1LClRITiqLQPJNd1RQyjRuCWbgDjPQQ549tC239BB/
	NmKMfTQQHvEpWPz1bp792e0FCBPMKjenY0CdR6PgjIrn8o261hNLUIL47dPnkBKAu2YUU3qG5XQ9K
	3yJntU5znBRaesc6Jmu2kn3e48gGI2dP1CNsFZ2NKbaowyS2Yp9x9isVddGJDRsIhFn4N4Tyzfwby
	ieWEe0UyYZaUbWDjZYP/xbQKyeCvJK7v/xQ4bkFDIw3SaUZPtlsgCz7c+7mjwPjiNW+CjcfU8XRZg
	lkD+1pBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxXJX-0001hE-PG; Thu, 07 Jan 2021 15:35:03 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxXJ6-0001ga-6J
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 15:34:37 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@nvidia.com) with SMTP; 7 Jan 2021 17:34:27 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.210.9.36])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 107FYR4f016765;
 Thu, 7 Jan 2021 17:34:27 +0200
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/2] nvmet: Use nvmet_is_port_enabled helper for pi_enable
Date: Thu,  7 Jan 2021 17:34:13 +0200
Message-Id: <1610033654-25186-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_103436_548971_C25E8430 
X-CRM114-Status: UNSURE (   7.68  )
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

Remove code duplication.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index c61ffd767062..b2021bf6cee5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -266,10 +266,8 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 	if (strtobool(page, &val))
 		return -EINVAL;
 
-	if (port->enabled) {
-		pr_err("Disable port before setting pi_enable value.\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	port->pi_enable = val;
 	return count;
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
