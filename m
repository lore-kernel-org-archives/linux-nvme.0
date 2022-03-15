Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE386C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U8P88lCh/VwB2wUul8vJe/3MyhfV7Zsin+/7eQmPKwE=; b=NrWYZ/sY//NfawLHlO8XbVrI0m
	q046MFEY1+xd9HqjwL5MWo8FZxJboAimHnAqtOShYXU6Bf7aWmPMFmZTlrReR3bA62p6M0RYamXph
	UaTgW3a1LxlmAdiDpCs/t64ntxZZETHxR4Bj+J36jog45Qz3XgZcGCAuKVua4fGOsAEGQW+TQdICr
	Bmd4k8b1JmhvUt4yOou1gEHDZl3XLKBt3vSxRMSbzFTNRmsujCryNQPNol6pLyKR5oBKvxnr1cV5T
	vsfmgkCsV9HIi1sr57PvR77C1hrZ0H3vimj3Gg7cGUPbcAOPct2AKlcXDHsMeIytAj3w+DDjF5D0A
	ywKLlnMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU76v-0099N8-2R; Tue, 15 Mar 2022 13:21:13 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU76p-0099LY-3D
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:21:10 +0000
Received: by mail-pf1-x433.google.com with SMTP id g19so19636574pfc.9
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=U8P88lCh/VwB2wUul8vJe/3MyhfV7Zsin+/7eQmPKwE=;
 b=CGNQE+Y7o6dJhK3Ix3rctbGZ3d7y/SZinSIvHEqwYEbv0L7LoDn+ercdgfN/W+ZgQy
 7JFKUiGx8JCTdQik3W60vE1OrEqjjYaMdJ5E6Jk9T4GZwdTvGEhSG6LLMx1jTcudPd2f
 tKBYNDjpqijSWglvm0zpj/Yiz/tec1ViKhxvkvHruZrsV77kj54np315IZoWtZ5nZCwn
 tkBGm67+CMaeBIdRxF4eCRjGpR7toHHIuIRw986IFaW0WurEB1K+pBC0vWDLQvSGUnk3
 hIzKfUv90b0FLO2bJETZYP5sjj9AMzpsnicpI/59dOhp/+z9SuWNKyDHQD1cpB/1MQNK
 1okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=U8P88lCh/VwB2wUul8vJe/3MyhfV7Zsin+/7eQmPKwE=;
 b=Gr9FKlrmLBrOJyWs5XpcXrZB8iTrZFYYkHlhvfmxyvrS8c4VRkOY8knjo2dt17bi16
 +n3RAhmQwSS+07Iql8Poq8h3/gf3bUOM+Cak3VXs85PyzJBLjxLk13STJh1VHT6Cvrlq
 NbrhF33a75V5aaQY/qIwT1eleT9X1yHZHPj3xjBHQ+k1f8IDzz6gYa+Wj/z9Pz5LKZo4
 kWXDRG4niyV9/bvcXyL4OTRKPmIG3QzAd8riuXBamRm7/6kzYSrMGGiTMQZs+ICq0FAQ
 pZegNAaS8GWJWSY95/us1Xc+PPH04wxYrS6o5mOgFKWBhODkDXAbPW3d7jFTd0h+MXMI
 VEAg==
X-Gm-Message-State: AOAM530hHaoZdPEvYVR1Dw4Mto14XHWUPa9rZ19d7JcY/nqHx1iHUFP1
 GT69BuRXAlO7/5Kat36l+0uAvg==
X-Google-Smtp-Source: ABdhPJyhzBKkWPvMhy/74LFEX3gJL3CN4TZBwIzQE+DlCZozw2t3UHKFnBLVOMEQZbyh7TivzeRfeQ==
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr17361593pgq.587.1647350466322; 
 Tue, 15 Mar 2022 06:21:06 -0700 (PDT)
Received: from localhost.localdomain (60-251-182-145.hinet-ip.hinet.net.
 [60.251.182.145]) by smtp.gmail.com with ESMTPSA id
 a22-20020a056a000c9600b004f7b8b3a44csm11589987pfv.29.2022.03.15.06.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 06:21:05 -0700 (PDT)
From: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, alsa-devel@alsa-project.org, Mark_Hsieh@wistron.com,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] [v2] nvme-pci: disable write zeros support on specific SSDs
Date: Tue, 15 Mar 2022 21:20:59 +0800
Message-Id: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_062107_346141_948326ED 
X-CRM114-Status: GOOD (  10.45  )
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


