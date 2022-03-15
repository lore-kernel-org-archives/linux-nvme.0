Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33252C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L0zB6xiTLN7TUWW0GnFoc7P7DsjjNa+huYBviFNpk/k=; b=RXSedZrMuzLm53/RsP/Z5O/d5Z
	5A5FMSbtLqqA3h3r8abmJMtkAvraayNP/A0J/prFLNym1GCht+B5B46tC5VGxJRY0OHMKd/zt9v4n
	JMn83HwPaZwtdisw48HSgTUJva2HR/1d77+HC7W8OelZIJVubO6l3AOHogF5SH+Hwou5W/9vI62yi
	W17zcHktxGXC0huyPFjT0qg1Sk4bQ46A5bXwzouNWvnaTz1RNTeR22thEknnxbvrO2yINZD9amP6B
	2qz7EzMMFWYC4qi5fJWJzbF83Yc3vsmy9YzftAdVQuDeV8Vmuef6MadGUsFEKFCBeWXgzcqBf0/+n
	794rVBSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU4hs-008lzI-JE; Tue, 15 Mar 2022 10:47:12 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU4hp-008ly9-NB
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:47:11 +0000
Received: by mail-pf1-x42f.google.com with SMTP id s42so19017287pfg.0
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=L0zB6xiTLN7TUWW0GnFoc7P7DsjjNa+huYBviFNpk/k=;
 b=kurHOyncJijHKQ/3NU/w4TnCG4BMWG7pbxNOcYWuXQ/xXSBjk8A4LBzinXx6+nXYo8
 ddg5aBlyeH2nOKElyxrDjgcTu9bP5Uu9tFZ1sbRaIFmrLJtvQYtd9W8WJ97iLZ64r+nB
 WxSa+5pA6UakEfS4S8StqdQNAtzBK7VQtx8gp0pBDetC/cgD5BHm0tZx9yUgrUkvCVhL
 kr6symltjySqL7Cwfx6URza/fxWatbf50CmTo3HDDxE2a7Q6CY13J0T542TeVSThMAzF
 3bUIpiSW5KL9MAIdFZkpjCi9fPQRtWiicn8HwyFBIoI0+wCIqngNm76PmSf2VdUhnK2W
 1rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=L0zB6xiTLN7TUWW0GnFoc7P7DsjjNa+huYBviFNpk/k=;
 b=GJ7ropvcN13NH899UR8AZcog8RMUNDIksa6JzU/jY5bNDDyB1ZutUicdTM72NyPSpP
 LCSfOVyyzvZIlf7P6FYJLQvwIm0f5d8M+wH1TE5/yUYz1X8NRSbx/QDeiGb+WT1jHA/h
 XQu3J18DDkJcM/IaMnBRprxUtWoVwsHeDnxbKm3/zojgDK30yXxrPO24zEaErdHfHT2m
 gufyooPmTdml9psKQkcIlk0mTqXw2flEowtUdobyVLNbDJTDQqUfKSK0Le6ikVYU+cGb
 iEw1kstPOKkFd+5QsbxYAAc3k7JL1bixqGdTqGYw81H7EsxFDBX6SwUl5qYootn+2mFf
 Eyhw==
X-Gm-Message-State: AOAM533/u2UXGJM9U1IHjc7oEnfXfXVg0+a16mHTfKrwz3jduqjl/A6m
 CUdbZK3BWwEYllz+E8+NH33wlQ==
X-Google-Smtp-Source: ABdhPJxA2V6ApdodQ8a2vNaSyz81PLMVWnDWdh3IHXNxCSKTXOy7wpqb+nBs6S14gJeSDmqUCo2VtQ==
X-Received: by 2002:a62:7793:0:b0:4f6:27a8:ae6d with SMTP id
 s141-20020a627793000000b004f627a8ae6dmr28183056pfc.65.1647341227975; 
 Tue, 15 Mar 2022 03:47:07 -0700 (PDT)
Received: from localhost.localdomain (60-251-182-145.hinet-ip.hinet.net.
 [60.251.182.145]) by smtp.gmail.com with ESMTPSA id
 il7-20020a17090b164700b001bfc017a0adsm2740346pjb.37.2022.03.15.03.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 03:47:07 -0700 (PDT)
From: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, Mark_Hsieh@wistron.com,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Date: Tue, 15 Mar 2022 18:47:02 +0800
Message-Id: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_034709_904466_AB93692A 
X-CRM114-Status: GOOD (  10.44  )
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

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), Micron has the same issue:
[ 6305.633887] blk_update_request: operation not supported error, dev
nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0

So also disable Write Zeroes command on Micron.

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Change-Id: Ic6ebfe141702d1869490bbf210627055b5b4d80f
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7a502a5b2b5..68745e1d7b6a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3245,6 +3245,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x500d),   /* Kingston OM3PDP3256B-AH 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1344, 0x5411),   /* Micron 2450 MTFDKCD256TFK 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
-- 
2.17.1


