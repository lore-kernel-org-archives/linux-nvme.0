Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F0AF4385D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iwYEvoWPNU4wJ1f7Z/lPcakm4IjMOci+dyhroI9DTzc=; b=sYdBkED1HwMu7eq8gZuWeoLpgQ
	XbmjA894wgq1EayJ/v8wbNZQR1ILRvwibIX/Dd1evLNRNECStN83t3n4LMIIBcBD/IoUNx/Ryteeu
	mIvKUuaEmkwGr4ZTAAmvvo7lqqrWiggGX06FG7jN6BeM2oypI6slidSOQNGvZ+r+u/nFy3WX5Afcz
	jdp6sqaPwDiSDvHpqiZ/uos6XQFiDuh5fSGwaSiczOO/Y6Zhvj2YRSazG/5mExsGBLWHaghLyeaKg
	NruckJhygnBvx3ovaUIcTWqdElf6ry8mz3vv6kVp/SAL6RW4TC+ulC3ihM/Bve3uD0UdBZVGKkpaE
	ncCRgbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD44G-00000001SXX-08IZ;
	Wed, 15 Apr 2026 17:30:24 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD44D-00000001SXC-1Rjl
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 17:30:22 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82c70e4654eso3043674b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274220; x=1776879020; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwYEvoWPNU4wJ1f7Z/lPcakm4IjMOci+dyhroI9DTzc=;
        b=Rv5Bnk0OJlvlR6VLHHvn1HBda+CMo1y7XPDKi4AbPdIzANFszVqPqqoYAVpzLMTpGM
         GyW653H0pKfr/ETgNJSpa8U9vZrlLUZN60Mx7jxtoLRmwo3NxT3Ti2a65UmX0ZcPYNuc
         7Rpjj70P+QgNx491Mnj9yZ9LjqpI6HCzHmC0UGSdU2OLpKaS5/5BTZALUk8a4IqBJJsh
         1BfZzYsYhLqBcOtDjwn/zF3TgfCDV9gCx/RrU0pgvEYGE286RkaouPSDtxcyUbtFHn/y
         Cez2F/fL4Qbpy9UPx+YxnEE9uLD/sZckmFF6Ygnw8ujYcGQW1yvFqsokXuhT7QbPZqHP
         jRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274220; x=1776879020;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwYEvoWPNU4wJ1f7Z/lPcakm4IjMOci+dyhroI9DTzc=;
        b=SI3bxj0WgsgIL43mGTwOUc90r1AHrhkSsnZbbnHdXia40uk662WUYCH491Y0FS9IEn
         vyyBX0V9NhuV2JxQInC1QwAXMaQVGIvS8M5ilW/yM818MYeSPLQI5M0Hg0Xm6aZM8RP2
         TtNWMRQW4YSuyobs2ScnM58yBiR0xY79MdyYkqlMh9n8WsQGCodbq/GsacT+K0o/EhR5
         Nfn40LVcMuv4CXPfYfhf4qf56+QtsycEqmgyjEoRj88d7kv53UxZQBb668cXItjNEmxA
         xfSEl7jsIaF3P8+j1P5qEhCV85kqZ/D3CM9HunrCl4HJcN2HM4USZKTOIn66NbTeRyZu
         ayUw==
X-Gm-Message-State: AOJu0YyzfxCg7M6p3DPf2HGA9z0OqiSZxvsjw/vjbIBTa9M3TSY7aLdC
	Hhd/Egk5+v/mDtnW3UUABNDatlWSwXkNpscAJ7dt/69UVLv8iQd1Fu4bebHcUA==
X-Gm-Gg: AeBDiesbbJ2F/ZAZL783bif/o4LP8ihc6Q6k/qJA5n8eliVcTL3+jISknghQRTdl5ad
	03ZVwmi+cQI/jJHmUmGygNZDdNvOcy//yCGTPcGg4WpCpExbUWqjekisDtuD28OScgFMKatjIDv
	SkMHG7ve3Gzdaw4XdswVp+hZxwruw2WQCBNSd8S53iO+pAnXtVZkkhUXU7k4E5o91vm/K5TEZUi
	+xQkZQNfwfFiO5yeo3Fsy6EhHESIkLDzceJ9uKNm+bNB7Bm1GmxFicZhSG3TSo1bsLRjqV6rPLI
	j6xPiZysDzy+XOjPOlWv4A+CydEO9/r3CNufj5G48HXZhsLmIi6R0FUYB408pyIpCrpXhCeGec9
	7GiSHdyT+9NwuBJQ0rn7kASclexTq4l4/8DXTIPK57VFTxrR7tnOQAGLD3cFY2ITmJ+cf0DbBNf
	XotQ0ym0PunGyqfz33hhikkIQ90TDwjwWQ0k7XjE+foerHDtk4wSurZ7CMjkKE7LWKV6qbO67vG
	Odo
X-Received: by 2002:a05:6a00:a1b:b0:82f:5c3f:94c6 with SMTP id d2e1a72fcca58-82f5c3fa2bemr6018236b3a.28.1776274219672;
        Wed, 15 Apr 2026 10:30:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([23.226.227.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f7166a837sm1000751b3a.40.2026.04.15.10.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 10:30:18 -0700 (PDT)
From: Tao Jiang <tanroame.kyle@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	tanroame.kyle@gmail.com
Subject: [PATCH] nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)
Date: Thu, 16 Apr 2026 01:27:15 +0800
Message-Id: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_103021_406375_53DDA910 
X-CRM114-Status: GOOD (  12.41  )
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

The Memblaze Pblaze5 NVMe device (PCI ID 0x1c5f:0x0555)
is detected as a controller on recent kernels (tested on 5.15.85
and 6.8.4), but no namespace is exposed.

Tools like lsblk and fdisk do not report any block device.

dmesg shows:
  nvme nvme0: missing or invalid SUBNQN field.

The device works correctly on older kernels (e.g. 4.19), suggesting
a compatibility issue with newer namespace handling.

This indicates the device does not properly support the
Namespace Descriptor List feature.

Applying NVME_QUIRK_NO_NS_DESC_LIST allows the namespace to be
discovered correctly.

Signed-off-by: Tao Jiang <tanroame.kyle@gmail.com>

---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9b..0f747ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4104,6 +4104,8 @@ static void nvme_error_resume(struct pci_dev *pdev)
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x1c5f, 0x0555),	/* Memblaze Pblaze5 adapter */
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
-- 
1.8.3.1


