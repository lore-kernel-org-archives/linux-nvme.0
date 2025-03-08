Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC61C282EC
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Mar 2025 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J10QeskcT12v/UsxJ7EeUY65TUXqux1i/qCJaeu/e6Q=; b=vMEDv3dbnhqdxzGeZFU3JqYnBH
	vowvDqZKQUF7TqzKuEwaXiSrrzPQTA8ywtjH/jcTVO7dxWI7ci56hoo+khDsqlCikqEI04ziM4/Sn
	6soC0XTjKFoSSx8TtxevHwu88MqLn9ztt5KXc5njvg75DnAr7h2Vcya2AubYqFnkqoo0VeSBDFM5i
	ONwNZYJt7k2btbiruRJeryshm9yvJUx4yPfnBFd6cbhCkHKaed2rXuBJy1b68DGJ+086HWDAcI+U4
	eVUNFliuVBWlfUpjjO5J1kOVc0gpGiK1r4PHyAMbmafWrZrZV7X4JRWZJmz02Ao9Qd2xwNzSMn5rs
	E5byKAvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqutd-0000000GiFB-422p;
	Sat, 08 Mar 2025 14:11:21 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqutY-0000000GiEj-1kFM
	for linux-nvme@lists.infradead.org;
	Sat, 08 Mar 2025 14:11:17 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so624272a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 08 Mar 2025 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741443074; x=1742047874; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J10QeskcT12v/UsxJ7EeUY65TUXqux1i/qCJaeu/e6Q=;
        b=KAquorFNgPZrDCMuexGxu9WpxHtIn+C8GMB7xUNHNqWC0CC8lWeo6CZX9pMTOSQWba
         8BZFvj7WKQgXV4hYuVrrAuuOcJl/n53xHjHjNjrkW0PYacdp8IF3A0tLUFhTBLUwhjkK
         3HnEuWqPXvGWATse31/nDjjmgsWXf87pgZZ3gtv6ukBzoNT/F6l/XL3PLCo4SpzOGZaA
         LkcMAzOMrWWCZJEtMZt7TaiDLdt2DcZgoxSNYeU2+DRjzs1pxrM8RrMkigLvghSWDwcU
         rV9VQwlbZkO20jFsCmGIkF4EC7bQ6m66gDPWaMg7fh92n9UHdJLD2MQirOXBhtlXUh8S
         r3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741443074; x=1742047874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J10QeskcT12v/UsxJ7EeUY65TUXqux1i/qCJaeu/e6Q=;
        b=DaNSk6zASYc2kJO9wE6Q8tEE1gzqAG9nu2UsDgBPJGJWM52Va+JfyjKoSpD6idbrk6
         k/brIGWj0GkVJPxNe1hBmIDRq0hB8CuNTjGTkHF51gdmONMRaV+oEmgjkF8oTa2QLV8T
         qVRCZuPwvtvpXO/aTGgYMjMNGFZXrEENRy+sxc7PVDBqaYV9r/6BVcr4tt9rCS3Z4DeH
         QRgMAUmSpRfFYtLLNf+73WI/QA/8dAI1OU9a/R4pBmij4K2Ku8DlEooxoJ8SwVKhn6Sa
         qjS8VMfedNd2m9cdSSntlizqxB1x0huZOLhvRVCI5giwpl5MXoVspOocdUhz0IpxNIcf
         xT9g==
X-Gm-Message-State: AOJu0Yw3wm5Qvccq4LwBpgQInrVsSttUAADgB1B2MfVbr2NHPp72jk20
	6kTzxKEAoUN4Gin8OA5X9s5QMI0UceoMU9RjAEO9KDyyVGzBJw/y
X-Gm-Gg: ASbGncuScnzAeq8dBmRObeQrIuz8Zj7AJLkOTV0b3InhDfLvgmhp2MOADBfQavn2aQt
	IpZfDOzyMggGJyJ4Vn0tZLBihrlrk9yfbryRl/+05exrbdNbdmR4pd6WQBA+2pOJn3CxKZiuV0t
	d09EuSZyoxzXHLo9b3j0bBRz6TLzZ/xTPYTZVnlJ8nBC568q1+6yk3056zX8ATf3sXoeOqSiq+F
	sTC7PeBejlO/Qyu4Ixpu7HX8EfGRPkFmu4Ms6xLrV1idQAR6NoZg2TZIwbJJyuAp3AQruABH08f
	SMJaRG+79xHU7STWKlQ/Ik29TCQgwQy5N8a4HQuvI+nBG3CkVeoZdxJfNsG4tPLKokqz0Q==
X-Google-Smtp-Source: AGHT+IHqBRpCNb80mXfZUuRQWsM9GihdP0zcIfVkkOqy7vCFy0maAPK3KAGzt53Ys1ENCYGGMsrzRQ==
X-Received: by 2002:a05:6a00:2e97:b0:730:915c:b77 with SMTP id d2e1a72fcca58-736becaf415mr1616500b3a.1.1741443074169;
        Sat, 08 Mar 2025 06:11:14 -0800 (PST)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-736c11ba2cfsm1193034b3a.122.2025.03.08.06.11.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Mar 2025 06:11:13 -0800 (PST)
From: Jianlin Lv <iecedge@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianlv@ebay.com,
	iecedge@gmail.com
Subject: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device vendors
Date: Sat,  8 Mar 2025 22:11:02 +0800
Message-Id: <20250308141102.34101-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250308_061116_456827_BF11E3FC 
X-CRM114-Status: GOOD (  12.72  )
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

After commit ac522fc6c316 ("nvme: don't reject probe due to duplicate IDs
for single-ported PCIe devices") merged, vendors no longer need to use
quirks in the PCI ID entry to work around the issue of duplicate IDs.
The NVME_QUIRK_BOGUS_NID flag changes the format of device attribute file
names under /dev/disk/by-id/.
For example, /dev/disk/by-id/nvme-eui.xxx -> /dev/disk/by-id/nvme-nvme.xxx.

Considering that naming formats need to have high stability and
recognizability, it is more prudent to make changes only for rare,
sporadic cases rather than implementing comprehensive changes. Therefore,
this patch remove default setting of NVME_QUIRK_BOGUS_NID flag for vendors,
and the flag is added dynamically only when duplicate IDs is detected,
as implemented in ac522fc6c3165f.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 drivers/nvme/host/pci.c | 63 +++++------------------------------------
 1 file changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b21728..9ae73224d4d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3592,8 +3592,7 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
@@ -3612,11 +3611,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
-		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
-		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
@@ -3634,11 +3631,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI },
-	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5019),  /* phison E19 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1987, 0x5021),   /* Phison E21 */
@@ -3646,24 +3640,15 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-	{ PCI_DEVICE(0x1cc1, 0x33f8),   /* ADATA IM2P33F8ABR1 1 TB */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x10ec, 0x5763),  /* ADATA SX6000PNP */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
-	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
-		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
@@ -3671,12 +3656,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
@@ -3697,43 +3679,12 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
-	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
-		.driver_data = NVME_QUIRK_BOGUS_NID |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.34.1


