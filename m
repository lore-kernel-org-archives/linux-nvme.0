Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60764C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QPd9eEXSDM4l8sHCKdklGbGGizcbCpDO0CxV5alpHdk=; b=imbNuzEK/TlMDl5u+/rXSJAr/c
	zZaTvWzeYhtoY5zTLx3NeJ8Pn6wWAx213MpGZUdkc1GMHSIrFBPS10+QyShj3KGyn4jLdd6guzdKy
	XzsDCGZwtgUyjahs3Kt8Bw4WdmcDq6WGQDMMb7eaIZaEAIF4bOXVr7YSo9R4ZOwaLS+f02Hkg0xoF
	wMG5tK4zMwhaBJQRPITzljVykArYp0sSnYOboS+UIQ6o6BslXcJ/PkOndQZkST8lHRLKxoKlqw9l6
	MXF8LUD7WaNufXojTJJcpQP8dqMtUq+qk5Ua91WCVZ7fAWlzLHRYmMyRPMX9m0WJV10A1RSLnCENl
	a3yjdLZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeC6m-008Icf-2H; Fri, 30 Sep 2022 09:15:00 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeC6j-008Ias-CN
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 09:14:58 +0000
Received: by mail-pl1-x62f.google.com with SMTP id w20so3442847ply.12
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kingston-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QPd9eEXSDM4l8sHCKdklGbGGizcbCpDO0CxV5alpHdk=;
        b=yjfnBkSz5gPsFoCQBPNRLWkEwc6Yj5gcU4LKGWGBFlg5gtjLPPpePyI824obQTjKGj
         /ip+LMsvmM8XESkCOwtta10++yxWpMv07x78xVZ10PE+dkqM0lWSksIXqO74eMIxCoR2
         cvqPCjYwBO0Dulq21r7d4bydGf8pWlV3GgfkS2uJDIjhx1OujgaB2d7un3o+DNCnpABT
         vZA9nbxCN3CLIoZLf6JKle6lbaaW2zgZH8EuMH15Opn6A/G6gtGQwugteIS8L9FpMaHR
         4YST30Z+1uDXJhD3M5N97qzp9LsF+U9u6ZKs3+mOmVuz/+NnyPB6iCskwiqF4HXNQj9/
         NM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QPd9eEXSDM4l8sHCKdklGbGGizcbCpDO0CxV5alpHdk=;
        b=egciwBjOYZlFLMe0r0RppJZ7NHLHGunwWJdx453FgRhdTHYwFH1uV4ntbgBsCw2UJc
         fRyIsN0lUsCq8ch6gHYYBGWeQGvu55oh8mF1MlBfEYkXbqPzVWMkv9LyuYMQ4yuFeoI4
         M7Z9s7W1zV4iv97px/EF0PjWLjnmr41ynv47N2u4Ov/a8ze1IqbZkyOu5qeL8Iom5r1E
         iYVI2gxYIRO8F8aaE4+WLFK9rifkuGGulmkwnuUESSpVP76yMFl0lXqxx3Zj8BnUePhU
         OfuB825iQAL9kdUnpBDOmTkYJknPXUOoNIsnjBAzyeKrz2m9arKUyrIP3VbbtiJBFIRA
         uIEQ==
X-Gm-Message-State: ACrzQf2M4Na1SH/nNKr3lT9bz2VEB2MY6/euQR5BzCusRjWb1j61CFDU
	Uaeruc93+c9ULpzTYhpC8czpQQ==
X-Google-Smtp-Source: AMsMyM7wf9/ARhY4ybWJ/gXUgwD2rR6i0+3Q89cvvDVTMieCiUCoYlL1XsoklGRjdjWIVtL2NF3xDg==
X-Received: by 2002:a17:902:e5c9:b0:178:5a6f:6eb8 with SMTP id u9-20020a170902e5c900b001785a6f6eb8mr8076240plf.42.1664529294615;
        Fri, 30 Sep 2022 02:14:54 -0700 (PDT)
Received: from sped.tw.kingston.corp ([123.51.141.8])
        by smtp.gmail.com with ESMTPSA id u19-20020a634713000000b0043c84559f1bsm1221409pga.66.2022.09.30.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:14:54 -0700 (PDT)
From: Xander Li <xander_li@kingston.corp-partner.google.com>
To: paulburton@kernel.org,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org,
	jhogan@kernel.org,
	christian@brauner.io,
	jeff_yang@kingston.corp-partner.google.com,
	dora_chueh@kingston.corp-partner.google.com,
	james_liu@kingston.corp-partner.google.com,
	vincent_wu@kingston.com.tw,
	xander_li@kingston.com.tw,
	Xander Li <xander_li@kingston.corp-partner.google.com>
Subject: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Date: Fri, 30 Sep 2022 02:14:01 -0700
Message-Id: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_021457_793700_1E87EC09 
X-CRM114-Status: UNSURE (   8.68  )
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

---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 drivers/nvme/host/pci.c

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
old mode 100644
new mode 100755
index 98864b853eef..d08c8c854f3a
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3503,6 +3503,16 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501A),   /* KINGSTON OM8PGP4xxxxP OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501B),   /* KINGSTON OM8PGP4xxxxQ OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-- 
2.25.1


