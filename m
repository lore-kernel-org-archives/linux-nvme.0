Return-Path: <SRS0=x4Ox=5H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F2C4332E
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BA72072E
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t7slUJ4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BA72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wS+sBfiAJbUzRmMWE6gjYrQBKN0rQCCmLHQH1D8pYF0=; b=t7slUJ4x3nHChmSP9iK6l1poMk
	poexDn0VbX4yg9UJMPPqAwdSHB9OKyPpoGTq2JUHe7PD5c1JMzuq0GilYryPaeoGiPwHarQ8KCTbJ
	eA+7kW4FFrI739Zu8DNPyW5StUVcT0TLzJL8TXk+UG2h2HZ38dJdKCk3FoX1mQaDr6ytG/y3F5J9t
	1pWj+fmTdF7Vs7FvEI0rVyWTXmd4/jLINH0omwhmGm8x9zWLfT8s4B/NwF55rLkiUp6ZrY7MQRSbq
	KO6W/6BVJFaTKXFI4qcuL0eB67JmpQh2WixuBL2GBIhoZ7JysrkoW7DWfXlibG+VznzKEYvfp1g6i
	3TQDChiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jG4td-0007qc-99; Sun, 22 Mar 2020 18:00:25 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jG4tK-0006Z8-8p
 for linux-nvme@lists.infradead.org; Sun, 22 Mar 2020 18:00:10 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 22 Mar 2020 19:59:57 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02MHxvSA004810;
 Sun, 22 Mar 2020 19:59:57 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] nvme: Remove unused return code from nvme_delete_ctrl_sync
Date: Sun, 22 Mar 2020 19:59:44 +0200
Message-Id: <1584899989-14623-2-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200322_110006_751448_7ADD9C9C 
X-CRM114-Status: UNSURE (   7.70  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The return code of nvme_delete_ctrl_sync is never used, so change it to
void.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 68e7c75..a461220 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -192,21 +192,16 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
-static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
+static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
-	int ret = 0;
-
 	/*
 	 * Keep a reference until nvme_do_delete_ctrl() complete,
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		ret = -EBUSY;
-	if (!ret)
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
-	return ret;
 }
 
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
