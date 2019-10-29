Return-Path: <SRS0=i+iK=YW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC14ECA9EAE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 14:42:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6A02087E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LWhSJFiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6A02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zKVZVgmGyBKcDhCvIt+poHWtY16vBWcCQhARzylzUX8=; b=LWhSJFiKCCtLbF
	2Qx3ccCIGplZUGg3CDHZC6LzeHd0inMARkui1Jk47Mqv3h7ajMftFVDmaEBkto5R7lcnvSXoTO4oJ
	EYaNFRYFIDaY0RrLviX0vDyIue739Be3sfN8+62q8ydewuP/LiwQpdhv8Ojc99tg8Z4w3YdHW6LJD
	rlVbgosq/3URtZdCNVFpqmbYDSCZHnjL2l6jacXcM9SNj7jy7bF57looNpEzAksLupH3PIA9W+AIq
	FrzZNz1+UaAzs7uJe6cNhlo5BRog/xC/MiEYyxAOg6jCJOxpWciuYflA4hGXvc1RaH1RLpI6WjaxD
	8cQUQrw9DSWOsAk+MyEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPShi-0008BL-2d; Tue, 29 Oct 2019 14:42:38 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPShf-0008AA-CO
 for linux-nvme@lists.infradead.org; Tue, 29 Oct 2019 14:42:37 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 29 Oct 2019 16:42:27 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9TEgRAP000989;
 Tue, 29 Oct 2019 16:42:27 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 1/1] nvme-rdma: fix a segmentation fault during module unload
Date: Tue, 29 Oct 2019 16:42:27 +0200
Message-Id: <20191029144227.108450-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_074235_824981_1444889E 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In case there are controllers that are not associated with any RDMA
device (e.g. during unsuccessful reconnection) and the user will unload
the module, these controllers will not be freed and will access already
freed memory. The same logic appears in other fabric drivers as well.

Fixes: 87fd125344d6 ("nvme-rdma: remove redundant reference between ib_device and tagset")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f19a28b..cb4c300 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2133,8 +2133,16 @@ static int __init nvme_rdma_init_module(void)
 
 static void __exit nvme_rdma_cleanup_module(void)
 {
+	struct nvme_rdma_ctrl *ctrl;
+
 	nvmf_unregister_transport(&nvme_rdma_transport);
 	ib_unregister_client(&nvme_rdma_ib_client);
+
+	mutex_lock(&nvme_rdma_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list)
+		nvme_delete_ctrl(&ctrl->ctrl);
+	mutex_unlock(&nvme_rdma_ctrl_mutex);
+	flush_workqueue(nvme_delete_wq);
 }
 
 module_init(nvme_rdma_init_module);
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
