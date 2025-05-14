Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A652EC5475C
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zin9UdB1kGHf9472t90ClCu+DsenV3gklPBeEhXFkBk=; b=2hj2Xom9U/l0lUvhbxCH8bv6o0
	46T7kjueAMQyjyluTQ8ePBmVF28hXQpw/BFrjHUXVb+QdYc7Luy4Hvw77cQUqDOQ8WzVjk3gLKTyA
	2Unnr3zcbs5COHlSF1j/0yz8pToAf8bCMh5FauiNT5hnQcRVV24KWaAzZSSG0OGn+L4f6nCHdFVPK
	zZTbLONFQFSnRq5COL7oAbS3r93L33BAFaD3mBUnKBVsF/NasMjNNK4qRmZQ5ziZTHpdjqH18SHR9
	59fMsMUw8kMo1hpR4KoP3zSaTjdKFNiHYByyftZyzE+1BcFOCAfiN8jmfOISIBeXamPHlCkYD68Uw
	T+rcyktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGBN-0000000Ftix-3ue3;
	Wed, 14 May 2025 17:46:17 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDll-0000000FXDY-2PqG
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 15:11:43 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22e6880d106so48457045ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235501; x=1747840301; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zin9UdB1kGHf9472t90ClCu+DsenV3gklPBeEhXFkBk=;
        b=CsvIkINGhirk/8Gh4+SqirzytVuqvfQpqfswJGqyQ5SVChisBtFfE23Bb5drASVd9q
         LQbJy6yYwbXQ8USVvDIOtSh/j5htEkZqkPKA5xO4MDXLtCdMqxHY0riDGyIUbjhNR2p9
         1N4djeS+pumfY/AElYCqoXCn+S88UeDM66X8MnfLyGtE/l6I8boZyuUvX2lyFiM7hv70
         ceVRpZvU2hirTAuaQ91bD9cFeQzFbBGDafH3N8cdzNTb5fTRlJWFnEu1LCyrW3Oh3Sl5
         IXA+WUIPuDtUCzThZTdFCYCuC/Vax6WsTES0My4kyy2/LFXabdE2gN7vrlb531l56h6m
         yx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235501; x=1747840301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zin9UdB1kGHf9472t90ClCu+DsenV3gklPBeEhXFkBk=;
        b=gokzmNpAh/J+lOWsHT7DTN6xAh91VHh13JSndGJTxyeVplp/H0f7KOS3dWGRar2jxE
         U9oJhCvaeZt95MggMkjQl+D5NbnTNqaIN9JdoZu0KJlosba3DjRjd5LQTDqWCrgEfPeA
         DmtLAwioMeYgytU4lvg7qBNRVcd0Tecfj+CArmN2qr1QewL3OOKk7C7dU6lJQ8I+7DHg
         HWsPo7wj8GY2TtBRic/QlkrZ26LGH+xOoZzMHFn6lsa7BwyAGXbE+LCoLm0NSyAOOjMc
         A9DGqzyTF3g5atn4Z4wGDDNOej6GBFqEvkW1oB4+FP9jDr+ulaRx/O+rQ9P+eCE6OU69
         KXNw==
X-Gm-Message-State: AOJu0Yw0GGOB0TaOAR4yG0jRFOkyZ39Neo8kcPEhqh6LvKM2q2gaS+Pr
	V2BMjQRrlvuomFFFP9R8ovcaQA3JZefV3ytzvYjSDiXp6iI7QsL0
X-Gm-Gg: ASbGncsbmkLUNm3qW3N+sY7ovid51cAtPLBVHaAazNUq4v6J6CSZIubjJ7LmFVlZ5T6
	bfzmRrhbiqVgaFqLcJ6dkLqQYd00IGi24xUMqxzccSfbnH6u2KYzYe/pISiTJVu+/DzC1HSEOpl
	KxgRcQRV8fiQfbIaoY5uVEz+C/ajNdq06uEP6Bb0hK743opcem8g1G/ssgGVlfcfZP9MPaqhmPP
	Hqk8kyYIcuwcAFiDCU3ZiyLYTtEGVSsKhXDaaQXN8Z3CE9zmibRiI02lkvyixY5n65W11UhPNIF
	hzf7dX2aOO04SVgbGCVFwxu/mNtOv0fuoOd3iWoEelqfRwCumF1YwIzRNuHeFepEGDT1zMYW+/Z
	N9aMj
X-Google-Smtp-Source: AGHT+IGQ88drE0lWsNDyF4V9Vy8xJEiVqRdDdnIX5NlkZpbH8m9mBlqKat4+TBTu4eQ2Nf1yk/MQ3A==
X-Received: by 2002:a17:902:f647:b0:215:9bc2:42ec with SMTP id d9443c01a7336-231983d06d8mr50986825ad.47.1747235500628;
        Wed, 14 May 2025 08:11:40 -0700 (PDT)
Received: from ilya.linux (M106072195001.v4.enabler.ne.jp. [106.72.195.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829d668sm99836795ad.201.2025.05.14.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:11:40 -0700 (PDT)
From: ilya guterman <amfernusus@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilya Guterman <amfernusus@gmail.com>
Subject: [PATCH v2] drivers/nvme: Add quirks for device 025e:f1ac
Date: Thu, 15 May 2025 00:11:30 +0900
Message-ID: <20250514151130.701885-1-amfernusus@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <0250510102130.14710-1-amfernusus@gmail.com>
References: <0250510102130.14710-1-amfernusus@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_081141_612442_6B56E273 
X-CRM114-Status: GOOD (  12.93  )
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

Signed-off-by: ilya guterman <amfernusus@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1dc12784efaf..03a64bc77f7b 100644
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


