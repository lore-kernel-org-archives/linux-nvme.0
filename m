Return-Path: <SRS0=76sU=ZI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B35C33C8C
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DA220700
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/TKpML8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1RKbQTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DA220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NN+2XEHs9WDcLc6wu3jVA2oeQ3bCOf4s8X8J5XoP9rc=; b=H/TKpML8W7Zih5
	mnsbRi0ICqkeWBauzRHKbzgKu6ZQeYcAbhBxOdg3vuPfAspntS/kspSRV3dxQLt2qfz1qPmFuGoV3
	ZIlu/G3C7KninjfCMQGaroqzMZVKi2VdpQU152Pwh3EuPZzfylNJazn4KRQQjTk74uOGMtP0Dp2PZ
	wrWstY4XQkZiNvmnXXKsU7VlwFpJoChXB1FzubSQcQbV/7yXYA32cd7Us2NZ3Cwjl387A/aUM09Sg
	kn+lijUyE34T3RXV2B3rMis7GOk3mhzjcH9mqYDcb/TpAl3+ppTV8rQ38Lw2LnibA2te7VxBPpeUg
	uBK2tmfCWg03ydXQgd5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iW0DU-0007or-W1; Sat, 16 Nov 2019 15:42:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iW0DD-0007V6-BX
 for linux-nvme@lists.infradead.org; Sat, 16 Nov 2019 15:42:12 +0000
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC51D2082E;
 Sat, 16 Nov 2019 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573918931;
 bh=+5WDG++5xSQuxpiwkJ1J9wYvQqH+k4jLnKBFQ/nlJIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P1RKbQTjvb6I2NNQ9JWoQftmIXz7VOXPmr7gbrRJk4XNNzHssLYpUx8arqVWUBxzI
 6FObe5xmC4M8kM/QzG+ldb3fvmGsLg3+lS6qQQJ6Xlp4d/7TvXAfNI7b7zfqOQaW0O
 WDlROR09eGAGA2Eh/eoqpc17GgnoAHR3GqYvaR+M=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 058/237] nvme-pci: fix hot removal during error
 handling
Date: Sat, 16 Nov 2019 10:38:13 -0500
Message-Id: <20191116154113.7417-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191116_074211_426808_E6825DB6 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: Keith Busch <keith.busch@intel.com>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit cb4bfda62afa25b4eee3d635d33fccdd9485dd7c ]

A removal waits for the reset_work to complete. If a surprise removal
occurs around the same time as an error triggered controller reset, and
reset work happened to dispatch a command to the removed controller, the
command won't be recovered since the timeout work doesn't do anything
during error recovery. We wouldn't want to wait for timeout handling
anyway, so this patch fixes this by disabling the controller and killing
admin queues prior to syncing with the reset_work.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a64a8bca0d5b9..9479c0db08f62 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2583,13 +2583,12 @@ static void nvme_remove(struct pci_dev *pdev)
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-
-	cancel_work_sync(&dev->ctrl.reset_work);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
+		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
