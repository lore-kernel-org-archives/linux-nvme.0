Return-Path: <SRS0=Xmhu=GN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D43C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 12:09:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFA422D01
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 12:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFA422D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i6vTG7nLLaHkyoJSppw7IyoN0tVrJQW1gEE9RMm+DCY=; b=IY/sdrMxi4omIDT261AcMvurOz
	eMVDJtRVGmgZ3w/hLwFtBfhBf+nc5RWUmwQEoAnIG0JYzry1DGJzcp8f91Oempt5qP7dfyDNZOIS+
	HsfKMSCHxJmdsYzhnfkZfQYZf1N8tXH+UNR8vEGThdnUl1z84qqi6mYi+J+JZpHf2xiwGhr+fxDP1
	VjJqgZB7MbB1QJbRStsK+a/0dNeBmfRoCCb4ifL8wDmzVIrmzTP+sbLFjrx8ssTgrr2nhGW4WiVtA
	6uRp1bAHoFno4eJPoAr0qFnW41x6VEH+O16e5ZhWqTYuJKxhr0BfsHAsrQiJk+ZB0HogyRxbx2ldR
	Mm8yS9mw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyZXE-0007Ra-Ig; Sun, 10 Jan 2021 12:09:28 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyZX9-0007Pe-9R
 for linux-nvme@lists.infradead.org; Sun, 10 Jan 2021 12:09:26 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@nvidia.com) with SMTP; 10 Jan 2021 14:09:16 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.210.9.36])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 10AC9GSL005412;
 Sun, 10 Jan 2021 14:09:16 +0200
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvmet-rdma: Fix NULL deref when setting pi_enable and traddr
 INADDR_ANY
Date: Sun, 10 Jan 2021 14:09:05 +0200
Message-Id: <1610280545-57812-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210110_070923_675302_7BC29B11 
X-CRM114-Status: UNSURE (   9.87  )
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

When setting port traddr to INADDR_ANY, the listening cm_id->device
is NULL. The associate IB device is known only when a connect request
event arrives, so checking T10-PI device capability should be done
at this stage.

Fixes: b09160c3996c ("nvmet-rdma: add metadata/T10-PI support")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bdfc22eb2a10..06b6b742bb21 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1220,6 +1220,14 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	}
 	ndev->inline_data_size = nport->inline_data_size;
 	ndev->inline_page_count = inline_page_count;
+
+	if (nport->pi_enable && !(cm_id->device->attrs.device_cap_flags &
+				  IB_DEVICE_INTEGRITY_HANDOVER)) {
+		pr_warn("T10-PI is not supported by device %s. Disabling it\n",
+			cm_id->device->name);
+		nport->pi_enable = false;
+	}
+
 	ndev->device = cm_id->device;
 	kref_init(&ndev->ref);
 
@@ -1855,14 +1863,6 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 		goto out_destroy_id;
 	}
 
-	if (port->nport->pi_enable &&
-	    !(cm_id->device->attrs.device_cap_flags &
-	      IB_DEVICE_INTEGRITY_HANDOVER)) {
-		pr_err("T10-PI is not supported for %pISpcs\n", addr);
-		ret = -EINVAL;
-		goto out_destroy_id;
-	}
-
 	port->cm_id = cm_id;
 	return 0;
 
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
