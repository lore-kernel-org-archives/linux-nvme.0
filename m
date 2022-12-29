Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB57C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbrQz0kg29Xa0GDRC8ClbCWM8goTDo4dB/HNu/0RBic=; b=UC9brrJVbesr1kDb6X3dfb5Zkh
	NS4JeP1SrrI52noljZx8W54FIwLFFOJ9xQTB5lnlq2jJLoQBdYK4VwF90ii8qRQE/JeR2Cc1fHCAv
	qDPWpleh129a/43BwlVOz45hV8x2vyXL59vsM6BfofHgAlZmvSbrMt5g30+4h0TYypLh8qsd6l/CS
	ipfzFBhReEPGShQ0HE02EMJoNtrAwnKeZ7Rjc2nW7MvfvU8vWGy4bhPc32/+rOsDdFv9mjKEcKrP4
	j0fqd46zhv+dSCpS+Mn9xHGMPn+jxMSKsglAVonsZ7g/UV5fro/KwQBmvoUwFD5o3njIrkYop2vEO
	IVB6u/dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAyGn-0015zV-9J; Thu, 29 Dec 2022 19:08:49 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxn9-000rG6-Cy
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 18:38:12 +0000
Received: by mail-pl1-x634.google.com with SMTP id m4so19699125pls.4
        for <linux-nvme@lists.infradead.org>; Thu, 29 Dec 2022 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbrQz0kg29Xa0GDRC8ClbCWM8goTDo4dB/HNu/0RBic=;
        b=Iom+BzmpkbCSWAfxsPg0W4sRHVtvaB49EFLSRxp6WXmDIsMs/FCKosy/c0Ek7UxrRv
         FLF/loNKG5Km4+1PXzUZxquGpVxkUOVz1ohxTghfGbXGnEPk+V0xnjW2wRYqp+0LtzK7
         xTeTNEPWCbJICWJjKsz5VJ4z/yqQLJeSE/lJ/rMv8JSR0unV5xXU+9lhPFt6nlAvkH2c
         jrzF7fBGQPH6DIgtAuGT7DUNhpx8nKKUTmsrm1c5VlzbtSh/zt3g0UpIZ8ZzZ8ATZOfb
         UPElKwBp7h7+DqdNOfHqbxLL5uaBGf8/4OJ+BV0oCkBrKmvoGc879fepMO7/Phnggbgd
         BNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbrQz0kg29Xa0GDRC8ClbCWM8goTDo4dB/HNu/0RBic=;
        b=6tCK+xMB1yFU4M82G+OD3Dv906QcojYA4HcUG9GQB9xPLcacQuvtmme41Wy7y9D++q
         vL+dJ4SLxvAIVkg43U+WOm0sJRPebg+K1HYE3XKJ3Cm1cMZ43zGNMXZmJb+bsCKoAngq
         UczRpmI/rjopTBGMrDqP5xLTQFwT6t4aV33cyqeBP7aPyw+9b7ADRpumGNSaMYRnKktm
         g2sOeapzeymcdv3koL9lZmowe5X/kuaDDhrU63f2P7dzLd4dRlbvkjgtyY4Sixp9Pggt
         h8TLF8LalFSp2zZJtLlVL1RgL+4Cktb9CQFYILNl7QPsmnTeXz8oFkEk0nkKyLWYVCgL
         r/2Q==
X-Gm-Message-State: AFqh2kr1Pyhpk+g9/hdnYn+Bg+Kii1x/j1ndoFsKFZeu8C2aPzZmBzC6
	bBfvRdEJev9vLalpNohXuWI=
X-Google-Smtp-Source: AMrXdXup1GjWb1k9WrctBbG+G+m+lAL5Ir5yQzr14N98Zgy349FFZFUwqsocNJ4OvcCpEjpTKmrRiQ==
X-Received: by 2002:a17:90b:2791:b0:226:3a7c:f97a with SMTP id pw17-20020a17090b279100b002263a7cf97amr1192193pjb.26.1672339089943;
        Thu, 29 Dec 2022 10:38:09 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:61cf:da7:ef83:e43e])
        by smtp.googlemail.com with ESMTPSA id mq18-20020a17090b381200b001df264610c4sm11852655pjb.0.2022.12.29.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:38:09 -0800 (PST)
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
Subject: [PATCH v2] nvme-pci: fix error handling in nvme_pci_enable()
Date: Thu, 29 Dec 2022 10:37:31 -0800
Message-Id: <20221229183731.4013056-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
References: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_103811_544305_19224B5D 
X-CRM114-Status: GOOD (  13.66  )
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

There are two issues in nvme_pci_enable()
1) If pci_alloc_irq_vectors() fails, device is left enabled. Fix this by
adding a goto disable statement.
2) nvme_pci_configure_admin_queue could return -ENODEV, in this case,
we will need to free IRQ properly. Otherwise following warning could be
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
Co-developed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: handle pci_alloc_irq_vectors() error

 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bb..3255e7a6f643 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2530,7 +2530,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 */
 	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (result < 0)
-		return result;
+		goto disable;
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
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


