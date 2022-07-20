Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C12EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BK1L4V38YhAbN4/MZyi2i12Eos1avha1OqhciKp5PUk=; b=SbhzzKy4p70tIKRShxIwIzwUnU
	nhk4Y0j1GnOpNVf0nDxjAzfOiQF4gBfhfi+8JcVQUPbqp6yweR65Q34QcY7ak9MUmQczC7lChjyjT
	w97+jC5ZvTsyljhw6VNGcQrOhcBMgW8OeHY4PQBDJsqVN9EChpdT3lGXjR+VSTAKTWBWYPV8W199f
	MQIHnFWg0VqapY+0YQ1K2RzmNlm6Qh0DNgAd4c9MSeYyUoC05S+cDWCu54p3RM1+qZIGc6E1NcSsG
	rVld+Q87naaxSXIre50n0TKYc1NUOXwlvtcV6cHx7N8Q5kI1G0p58/0pwZTvMAikbwF+Y62Xf468B
	+GjMt1vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE7x6-004hyZ-Ay; Wed, 20 Jul 2022 11:33:16 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE7x3-004hvB-21
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 11:33:15 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJwqKAp_1658316782;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VJwqKAp_1658316782)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 19:33:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: use pm_sleep_ptr macro to declare nvme_dev_pm_ops
Date: Wed, 20 Jul 2022 19:33:02 +0800
Message-Id: <1658316782-69848-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_043313_292378_2EA08EEA 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the proper macro instead of the brace of "#ifdef CONFIG_PM_SLEEP"

and "#endif".

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1eb1899..85afe06 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3544,11 +3544,9 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
-#ifdef CONFIG_PM_SLEEP
 	.driver		= {
-		.pm	= &nvme_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&nvme_dev_pm_ops),
 	},
-#endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };
-- 
1.8.3.1


