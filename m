Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEFFC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 06:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WvHrnh6Kzoj0nWwyaMrKvOTOMFA+VSrJVZRapH+1ngs=; b=MKwRLA2exeRpnabotm/3exUl9s
	nHmvnX9szYT5D2JGPvTIZmnVRgmawTiVY2VOWk9mCxYafRpSVOr0ZOxSwIVP9rrOFHu5YL9jJUsIA
	gU6Ljlw+B5homUDVDGeIi3kCIN/7pRRaqhLcXbphVAJZDYOFAQtFStRTp+ITKBLqZnF8wTEgmXk5m
	G2pgdDoELx19XIC4UGX2JsyBHMkTKcUxQn8H0Dls7PFQOkm38sUGWvLMMEGdzRl4UsH87fSKRsz2Q
	VwqSNdakV3Puh7DGNmvpVJM18zsklP+Sp2KfTUxCGExBYdFHcEN5IBr/1AzxKqGTDg4oo2d31kUWz
	2qHgi10w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAm3F-00Cbl6-84; Thu, 29 Dec 2022 06:06:01 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAm3B-00Cbgv-1W
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 06:05:58 +0000
Received: by mail-pl1-x629.google.com with SMTP id t2so18070769ply.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Dec 2022 22:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvHrnh6Kzoj0nWwyaMrKvOTOMFA+VSrJVZRapH+1ngs=;
        b=gHeW4JYgRqPC62v7wcEHkWIpBU/G/V9W2+kEV3nbqnVkgqU/4StLE+Tb4qZ7gsgxMa
         fOCKMPaszpVfHWa90O+eHOeKrfSUBdRIN86L+OxE4TiDFmo8dw36HAvua3UEIHGb8Pv7
         RV8kaJTJnd9eq4+rYYTngrMHmCMqZ5V3uKKDjDgse9ghe3zAJdqLvacnwL7Eujxkp3KB
         0u54DvQQKjTzBMdQ1yU0Cjvb98JBLQwq/nNPnz3Bk3dcW+BeSzgmDTfaDD4myPwuSpyD
         6zkQrxiuXuQXNuzZnmJzoKjQAwFu6HJCc54xqoyOs+wDa0hJOYyHY39wF8txyvFMepYy
         2PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvHrnh6Kzoj0nWwyaMrKvOTOMFA+VSrJVZRapH+1ngs=;
        b=CaDPN+hNBxVkqJ4l3ocd1JhhpcdKpx1WUSL47DGDAvoZKxlc2DSMuvicy1GCHnSwAz
         8eR64XizYJAxuvqdmiNE7qKpIWxGTK9krqYX+boFHmFVlRj5UaHPtCNAnHXQcIDTvxoJ
         7/D1DOHul+HP6pZ6UYDyiMpuczfC9VhcL7RCTNfZl1pZ8fKrwjKkC2K2B2bT6fnMTgXF
         R8OTd6hYnkKQHWLhRpBjVPZib2M14Ap6DwITqirtxmSjD490VjAB5Q4+sLrCdseq0pFm
         fbSIbrqDm81NUjcyKFeJ4AxkF6vUU1UmMlb2WaGsHwS5N9GQ9n1V1LnXEcD4sRQqNSFu
         cEKQ==
X-Gm-Message-State: AFqh2ko97dlEUFJklTmfFBSZpArPGWlbfuvNnainpqpGZ3smwVt5mihm
	hegwXt42EosUXUe2ToXk06E=
X-Google-Smtp-Source: AMrXdXu7gFAQsreFVb70AT8TyMkIkhPD8Mj81ZOfKm926upQi0YDWXAVYlwQHOwZEMDKq8E01rdEPg==
X-Received: by 2002:a17:902:a717:b0:188:640f:f41e with SMTP id w23-20020a170902a71700b00188640ff41emr29193354plq.4.1672293953727;
        Wed, 28 Dec 2022 22:05:53 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:61cf:da7:ef83:e43e])
        by smtp.googlemail.com with ESMTPSA id u9-20020a1709026e0900b0018699e6afd8sm7316431plk.265.2022.12.28.22.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 22:05:53 -0800 (PST)
From: Tong Zhang <ztong0001@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: t.zhang2@samsung.com,
	Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] nvme-pci: free irq properly when cannot create adminq
Date: Wed, 28 Dec 2022 22:05:49 -0800
Message-Id: <20221229060549.3976570-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_220557_331913_32A481CF 
X-CRM114-Status: GOOD (  11.08  )
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

nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
will need to free IRQ properly. Otherwise following warning could be
triggered

[    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
[    5.290547] Call Trace:
[    5.290626]  <TASK>
[    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
[    5.290843]  msi_device_data_release+0x15/0x80
[    5.290978]  release_nodes+0x58/0x90
[    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
[    5.297573] Call Trace:
[    5.297651]  <TASK>
[    5.297719]  release_nodes+0x58/0x90
[    5.297831]  devres_release_all+0xef/0x140
[    5.298339]  device_unbind_cleanup+0x11/0xc0
[    5.298479]  really_probe+0x296/0x320

Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bb..1fc2a2e130ab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 
-	return nvme_pci_configure_admin_queue(dev);
+	result = nvme_pci_configure_admin_queue(dev);
+	if (result)
+		goto free_irq;
+	return result;
 
+ free_irq:
+	pci_free_irq_vectors(pdev);
  disable:
 	pci_disable_device(pdev);
 	return result;
-- 
2.25.1


