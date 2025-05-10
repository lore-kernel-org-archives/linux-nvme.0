Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EBEC3ABCB
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5uq+Zst8YwtPGpsQlMHD4aGLCy+mUn3+jss35jpDE/s=; b=Ihe3+/OTbS5qIsgo7PBvLTGXo9
	AjsIdTicNmrw5x1hGFrJC8ay0c9r0JhGmdeQJQXo/SSGBPkNEYcl/amdAbSdwm3m7RcHieuK3fGU1
	UGcUfgHkJAkADYswjCxet2gmBs6zhsoUs+YBd6+g+XsAWx9BkckAmzOQKtV6AHJJh3aQeuHLvNtui
	ppLIK04cUIErLDnZukED8/kbV3t6sngWFarbK16wGb2ngoPnHlZ4jL4/Ky26FG3J+wwq9ChA6e+qe
	uEEr2ITmCa9HStiinNSP1SQjrNMO+M9eb44rxA2LN0w36jsRf4Lbn7/fqY0vcw/EODGScvvffCUch
	VwXFAHdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDhKx-00000005nR8-01WD;
	Sat, 10 May 2025 10:21:43 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDhKr-00000005nQf-1hDm
	for linux-nvme@lists.infradead.org;
	Sat, 10 May 2025 10:21:41 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-74248a3359fso1002588b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 10 May 2025 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872496; x=1747477296; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uq+Zst8YwtPGpsQlMHD4aGLCy+mUn3+jss35jpDE/s=;
        b=hn0AbLqMQroLRnBdCgqSP7wmbfftkHWuS+0xAo9hvWkD/rNwtOj3S7LuiDZIzgZLyS
         tCyuqTljoTeiEwfPDR0A7jzFAMrrLrcMXa6ar0LGJDOQWnw/tLnTQxCQa4xRh0f1inu5
         2dT+L92cqETR1LYtXZuvUpVhNVf0q6wjBn3vlMD3nCvdGl5jaJVgyv+0XkBQytYLNb4Z
         gYRxAXN1aTlo7Gzz1Uu1wZV1N8N1yVRefzCRHI4TJBk61F8yGY3st8sPJGvAhcEThaHQ
         NtmmpSzHUE7tx4knrBzHIqc4UYEig6TveJjyIgSogij3Jv1Ue6XYMX5CV2HUpxbwpflG
         jZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872496; x=1747477296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uq+Zst8YwtPGpsQlMHD4aGLCy+mUn3+jss35jpDE/s=;
        b=P7J5romQ34ZUy8PNgedaoQv6Xx6504p7xPOwl8acX0enuFSW7mTayx96KSvWOIUjF/
         IpmqULclKEvmajtVtILxIp/xbcoYYOUR6PFfbFxIFqQqAn1TTWSnkfaOSubIDY49UmTh
         o0k2CKt+15cAX9ya1+IlYI62xXqk/0vXJYQ6+iy+rftFQ1k7x0OkUh4s7biv5rZN6J1X
         thLO3cJghzF4PuhP6EEklqQcKgcdf4ma9IAa2HrAET/ZBI+FzqRu7mO/8RqRWxRHDez6
         1LEok7hdk4iPge5vnbRVCiaBhsu3zrLhKbcBoXbjzSbQiLcBqym3RU7xbZP1YC9zgb/u
         Uu6Q==
X-Gm-Message-State: AOJu0Yw07hY//XymJnEH9p+/xekfESKhM9U+a8jraahmKpgtAdOB5RR8
	dwRjGNM9+xNIuNRgwvDUPA8cj9FnIpChAW2KFY/ORFUaSSPrIAXP
X-Gm-Gg: ASbGncsvndmxJCw507ptwAELhBpeR4yr28OXBZI5hb4QcaFVeemTz7JQoWmCQo/6TD/
	BYE2pt5BJ70rXhniDlxjcZo9xbOH2oVaIi9lchXr2HZmGACQg7SLzRt+iGpPjs94KMMzsASwJGH
	VgKuX+6l/dKE9kMIi6iJDn6Vhk4gYKa98aqQc5uj/y2aR+gb2vO4hxR3lenVoZ798GDtK5yshQj
	grqVknVLQSB02NYv0k6FUSPjfwFI0EH8fhrOcNP/Ai+AD7p229vYvIoScTjGdWZCB5TWGqrVR7E
	qITfT5CkU3xhFPgJgnciJWZYP/Ar3Cm3p0UCNas/MC5eJDoB1h6LO3nZ
X-Google-Smtp-Source: AGHT+IGTyFC3y3txfPtKS8vmVFwlrXN1ldd56g5XK0RMzSCg6bJ2N10vkSvR4w29AgSFP+E0lUB6TQ==
X-Received: by 2002:a05:6a00:2d08:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-7423bfb9282mr8688337b3a.14.1746872496113;
        Sat, 10 May 2025 03:21:36 -0700 (PDT)
Received: from ilya.linux.jp ([240b:10:c301:9100:7db1:c9cc:c837:2394])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8efa2sm2978554b3a.165.2025.05.10.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:21:35 -0700 (PDT)
From: ilya guterman <amfernusus@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilya Guterman <amfernusus@gmail.com>
Subject: [PATCH] drivers/nvme: Add quirks for device 025e:f1ac
Date: Sat, 10 May 2025 19:21:30 +0900
Message-ID: <20250510102130.14710-1-amfernusus@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_032137_447880_CEF0D4AE 
X-CRM114-Status: GOOD (  11.74  )
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

From: Ilya Guterman <amfernusus@gmail.com>

This commit adds NVME_QUIRK_NO_DEEPEST_PS for
device [126f:2262], which belongs to device SOLIDIGM P44 Pro SSDPFKKW020X7

The device frequently have trouble exiting the deepest power state (5),
resulting in the entire disk unresponsive.

Verified by setting nvme_core.default_ps_max_latency_us=10000 and observing them behaving normally.
Also by running with the patch couldn't reproduce the issue after multiple wake up from sleeps.
Running without the patch again reprodcued the issue on the first wake from sleep.
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d49b69565d04..d62fef76cc07 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3734,6 +3734,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-- 
2.49.0


