Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490CAC07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 21:15:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0181C61376
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 21:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181C61376
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pJwYXBAKha/zEl/Bm1eIcuLS1X76HkySPMpgwsaOOmY=; b=NJ8pNTOtMvwlI6
	l9VzRCBhxadzlOj0GivDVhkLbz4Rwmsdj7uZ5wkyaQyECeIrdGe/otH5IcXQhCBG/aVQNEEyrhHFa
	pRkkC9yZP+YCsx0CtGEQRjquGXaj4sy2scFsPozDWTrXDyuOk4rRUBwmJX0qK663QspQK3pSDa31y
	00cDhy6TKXvJuHiqHoZkgS9sVyts9sSO9DrR1XUrLdW1mc38vmllV38YKeqsMm0hmy/kdBfIQvgQL
	qXKgSHauL9B2fd+jUFHZjz17Mvx+sDg413gAuL/xR6Ch/3vJV2TTW9P/JbqRWBFGa/+mJiY+sVzab
	KbYNFuZASyo5DIypl/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1Esz-00FkIQ-GR; Wed, 07 Jul 2021 21:15:13 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1Esd-00FkFr-8h
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 21:14:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id w22so3432806pff.5
 for <linux-nvme@lists.infradead.org>; Wed, 07 Jul 2021 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9wJb9VBUuZ3cCACOen2f8fvG1DfJyqtg42dEB7fJHzI=;
 b=lWEIbdGxyM6cYRvBSHZ+omWvE3wJVN4TqvMJy0LIQloXdjgOMZT4em9SyaJV5PkPCh
 GWuQa4/SGHJVIH4yTBbWz/ZWm95jtop2Ui3D12mOat5C6Xb7ksACicuhGv6QUJZ4JQTk
 cWFRPsFn8nsbTAdBjXhi7Jnz1L/sJceIUoD18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9wJb9VBUuZ3cCACOen2f8fvG1DfJyqtg42dEB7fJHzI=;
 b=RicAxWGG6TYPeu647aOa2SYl8914DsZK+IeG9/Ro+dU4/rs6itUmLQD5iny0rTG84v
 NQHAHWkELbtRYEMxHPACI0qMdb0IShKcCfRJA3JuyC7SAAv6WowTn2O8kW/KxLgooKbv
 +aPImVBPEdcDvLwG1h0/cVti1UCPfb80THHHYvjOVpAcwHjuR8KM/hGmbwytyiO+FlES
 SG04THV0COsJZSK2CSJvOohNLnQ2aueLGAEJrFELNtSbDqOGBfREUM0MdRm3alvTR4q3
 CU3Llh99luQI8qmPANRjGaXE0dR9EUB7h0v5746TyFsJA/4mh3tCpxgyRBKSd4OHS+DM
 Nsmw==
X-Gm-Message-State: AOAM530yYXvSDpd1kVwc9XbW35AzimFLxWdvVE/XSN7RwG4LhcYRT4Xb
 ls5cEHCmMBE/IYw13NTibrYz5BIv7QWm5vsIBa1GIJKwPwyaqnUAAGiOxKNBdszmNq9G9fZS90z
 Gmpx7a+7tjnFemLd/nHlj/m3PXC+qfS8mNR7xI27yOO+qgoaorQkSXP6DseC8fQj2JvXmckvfu1
 J1oqQdtzs=
X-Google-Smtp-Source: ABdhPJxx1W41tyuJPcT9VESVGMRqPdcfk3FujVCf9ARdP+hZr6iSCOHy/9P0ukOjrFEV8hTgrWhOhA==
X-Received: by 2002:a63:1a4f:: with SMTP id a15mr27837032pgm.313.1625692490315; 
 Wed, 07 Jul 2021 14:14:50 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id i1sm7159001pjs.31.2021.07.07.14.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 14:14:50 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com, ashishk@purestorage.com,
 Casey Chen <cachen@purestorage.com>
Subject: [PATCHv2 2/2] nvme-pci: Fix UAF introduced by nvme_dev_remove_admin()
Date: Wed,  7 Jul 2021 14:14:32 -0700
Message-Id: <20210707211432.29536-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707211432.29536-1-cachen@purestorage.com>
References: <20210707211432.29536-1-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_141451_399250_F35E35EB 
X-CRM114-Status: GOOD (  11.80  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_dev_remove_admin() could free admin_q and admin_tagset while
they are being accessed by nvme_dev_disable(), which could come from
nvme_remove_dead_ctrl() by nvme_reset_work() during cleanup.

Commit cb4bfda62afa ("nvme-pci: fix hot removal during error handling")
was to avoid requests being stuck on a removed controller by killing
admin queue. But the later fix c8e9e9b7646e ("nvme-pci: unquiesce
admin queue on shutdown"), together with nvme_dev_disable(dev, true)
right before nvme_dev_remove_admin() could help dispatch requests and
fail them early, so we don't need nvme_dev_remove_admin() any more.

Fixes: cb4bfda62afa ("nvme-pci: fix hot removal during error handling")

Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f98dca6a4d32..d07634e28da7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3048,7 +3048,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
-		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
