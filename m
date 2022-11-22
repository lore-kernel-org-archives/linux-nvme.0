Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA7DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jweppLDhW3+CgMLZ3CjkklyN0LTeBCxMB3xBbVVeVn0=; b=p/1227URrIaxjJYT24i1DEz8ZK
	oxhdAtVJnIjkmvhufHOGeKxZddqdb+0D55FMkYfxzJNtffQN3LK0UiHy6iIdHpe6SDyKVrtslR/Tx
	BjSn3fWRJ1lq6itBL6V7SCOkcWXo2O6P8lqi8h0aU0D+uR0awmK3Q8FMoicnI36AQ9v2HsyRfHRSm
	KEdBmTRButqq0fmEVWjKL3BWqQsYxA2jy5iknNlP+c03WrnN1f6qMH2Syl1EUJlpSD+DqEMfohCQ7
	ATFvOSD8U1+QxCQEqTOqRHGWtGGjE4sdO7XhRzaAw2nSsS3/nOjy89RIt54spaO2Fr8dLYM38K68T
	YrOSJs1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxROG-008Llg-Vz; Tue, 22 Nov 2022 11:24:37 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxROD-008Lit-JJ
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 11:24:35 +0000
Received: by mail-wr1-f50.google.com with SMTP id z4so9635393wrr.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 03:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jweppLDhW3+CgMLZ3CjkklyN0LTeBCxMB3xBbVVeVn0=;
        b=MEzc7zRzQASd1hWtCWamtJW+L/d6S+DPkXXozuteoT6kBDntOwBWCQoqP/AyJMqW9Y
         dm5o8RCi3qWq4NIny2DcKtzBZJOveIBaFmev84gode6+t8xgKx5sL4oM/bu4WJYkkxNy
         R9+RNSef/a71pJNbROBdbphCH51V9DlFz4D6UXKKSXeFtQM6RifR2yPdbwMa9XBHYAgQ
         LtVNNAW3Z2s1t29fizFZQjg6uaH0047nEGEmPMr5kicet9WCVKfz3k1BROi/6QeQjaYl
         GC0ZyDMP4afV1WnM7v8MVm71vFKErzRNHnIeN7NU/e9pekw6ifXsU/pCRw+vRP+TeHUf
         A7Nw==
X-Gm-Message-State: ANoB5pkdrMmyEBLInCaWDB/zxFgQeSyenQGd8Uh/y5zAchybcs7zDCtG
	Uckh0vc9c668eIOZ+5dU8rAe7QSGeTI=
X-Google-Smtp-Source: AA0mqf74SvuXmRhN6IfZpkjGaZqsWvTQrQFiapvp+mFUB7RSgb68q65Gh11XA9ua0elX/ACKE+EnPg==
X-Received: by 2002:a05:6000:1042:b0:22e:3f37:fdc with SMTP id c2-20020a056000104200b0022e3f370fdcmr13572795wrx.665.1669116270816;
        Tue, 22 Nov 2022 03:24:30 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id y7-20020adff6c7000000b002368f6b56desm15993405wrp.18.2022.11.22.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:24:30 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvme-pci: Netac has bogus namespace ids
Date: Tue, 22 Nov 2022 13:24:28 +0200
Message-Id: <20221122112428.1573353-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_032433_662602_57F1B9A5 
X-CRM114-Status: GOOD (  11.18  )
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

Add the quirk.

Reported-by: Andrey God <andreygod83@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216724
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bd5fcdc9211c..de42b7eeca0a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3535,6 +3535,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1f40, 0x5236), /* Netac NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.34.1


