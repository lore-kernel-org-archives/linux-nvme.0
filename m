Return-Path: <SRS0=x4Ox=5H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD2C4332B
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4026A2072E
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="neyDT7X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4026A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WVivjL6Urv+Oi/nwjAnVUVayf54yj2Zpr54fMOjbfIU=; b=neyDT7X2fccF8gN0XuXAdha5Fg
	wrVvAfkr5toFWlug0UdysFPOmzNz3sIoc0vMTcz+rdYejjYdPRaDRf2VPqUzYQauR0gPXeaTDOgRh
	x6rnbNNYBeVYNSkqO6JAxvPcSOaC0qBIzssZBOotc3SZETNGt/3mJtzazo3p963FCoHHAxbqxprex
	nO99HH9hWaSoSxo8OFgHhZPTpZxSIFQXKCbzRkzpAlQdZ8tpeZZAeNKxAwv+0mzEvdpJUWkBD7LOo
	aXeB6B7gimio81EUbWaJsM/H9eoSOpGrBmBOsmErhVMWJ2Z7QFqnYoskrBlHkoTEkrrEzxcfvcsUd
	ELYkE1bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jG4tQ-0007Ye-84; Sun, 22 Mar 2020 18:00:12 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jG4tK-0006Yu-3x
 for linux-nvme@lists.infradead.org; Sun, 22 Mar 2020 18:00:08 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 22 Mar 2020 19:59:57 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02MHxvSB004810;
 Sun, 22 Mar 2020 19:59:57 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/6] nvme-pci: Make nvme_pci_free_ctrl symmetric to nvme_probe
Date: Sun, 22 Mar 2020 19:59:45 +0200
Message-Id: <1584899989-14623-3-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200322_110006_585491_4034C3BD 
X-CRM114-Status: UNSURE (   7.59  )
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

Destroy the resources in the same order like in nvme_probe() error flow.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6fa0c7..eb65b3b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2470,13 +2470,15 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	nvme_dbbuf_dma_free(dev);
-	put_device(dev->dev);
 	nvme_free_tagset(dev);
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
-	kfree(dev->queues);
 	free_opal_dev(dev->ctrl.opal_dev);
 	mempool_destroy(dev->iod_mempool);
+	nvme_release_prp_pools(dev);
+	nvme_dev_unmap(dev);
+	put_device(dev->dev);
+	kfree(dev->queues);
 	kfree(dev);
 }
 
@@ -2875,8 +2877,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_uninit_ctrl(&dev->ctrl);
-	nvme_release_prp_pools(dev);
-	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
