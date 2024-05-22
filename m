Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF6C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnHOsYGo/knFXFD/bpfAbnTOmosgWGTLFgD/SsA0Yl8=; b=IiySYGSRMcI7xCROoEFVzX/DBy
	FIvfbLartETcWkmP02nyWcDOmB4c36IIAe61fLPI+kAWP8Ib8Mf7UJZGY2DMQnrJNxOEq8i0YbUv0
	Zktn7LT/mF9CfRMPuXMyGDh3NKwFlviyUJNr+H6VGiitsI2xGHYhemx7Rf87L3kaA9zrsmB3l0QDn
	MFhPaLGtmEh5UN153+6pWYGdio1JVZ46TR4u0GEEHhXNDYEgRJ57BAbWi06GSXj7zKzdunGed2/pT
	zb51+K88wvBYKRaHa1k00jvDi8tTqerrX55W0mkH8mmAx3ulE2q0CA1XZTK4rNY9J+iiJZt0XqzM+
	OYPws3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oCX-00000003Qje-2eQN;
	Wed, 22 May 2024 15:48:25 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oCU-00000003Qi5-2sdH
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:48:23 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1f333e7a669so2212305ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716392899; x=1716997699; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnHOsYGo/knFXFD/bpfAbnTOmosgWGTLFgD/SsA0Yl8=;
        b=V7n+KbnfewjbygEGjjF7+hfgSR+DrgMGQCKlfetd8WsuGWduygMDJyCJGxDwzOaALD
         GK8BXHalHslIC1otA89R/nJNp8goEoY6T6cArget5kgnpndvxkLN+mJXwy/Dc7wJvuNe
         94vqt0xvWR12KozQ6L+w2/BWxnbhXG30GwLP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392899; x=1716997699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnHOsYGo/knFXFD/bpfAbnTOmosgWGTLFgD/SsA0Yl8=;
        b=ObLnSKCWHRai5dA0sf9U7oKdOkMti/3/gdVNzf1Nh8yIfFSUGgVl3t2jlb3OCjynbb
         B8BzYQCCi6rwVJMDqG/9m8BGpg81N8EIJv6XehohfizHrbUEo7k7D5n0kROPLUck1dOw
         1lASH9iJUP51tU2i6EaNOY4LOoOt9jejOKn42rHEbLib0KFdl1Nqgyludc2qoIxC+zTy
         KYyKzeeh+eH0JnvXS5vqAvizWLBDqKSIBl9tl32/qNksdIPiVjOCOy7TYTI99Wpp5Xrq
         b06jlaiseTojTcEU0MTa+PwMxXdNBnO24c/PyubPofcwxTgqUjonEWg8kuj/kl8q2Mrj
         OQPw==
X-Gm-Message-State: AOJu0Yyf5CHDLdLxGOeK51cOPWuwB2gPEhIS0jWRKdYdMnlw/aQphMf5
	uDmDWZWc5city4jv9tBseY1UNG7F3uCzceolwVLAJ4Iw5bitzBvEraz3vixRcxM=
X-Google-Smtp-Source: AGHT+IEDf1lTROeOM4AAn61F0suuYPCJ2uRu8/RGnzAV+e+So0nFajqYOOW+SXptpBRNuMh4NeJZbQ==
X-Received: by 2002:a17:903:5ce:b0:1f2:fb28:9d2c with SMTP id d9443c01a7336-1f31c9dbcaamr19217635ad.44.1716392898975;
        Wed, 22 May 2024 08:48:18 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137fc2sm240913245ad.258.2024.05.22.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:48:18 -0700 (PDT)
From: Jason Nader <dev@kayoway.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH 1/1] nvme-pci: add IGNORE_DEV_SUBNQN quirk for device 1987:5012
Date: Thu, 23 May 2024 00:47:16 +0900
Message-ID: <20240522154716.156018-2-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522154716.156018-1-dev@kayoway.com>
References: <20240522154716.156018-1-dev@kayoway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_084822_747575_D7B68E18 
X-CRM114-Status: GOOD (  12.36  )
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

The NVME drive 'Corsair Force MP510' which shows in `lspci -nn` as
Phison Electronics Corporation E12 NVMe Controller [1987:5012] (rev 01),
shows the following warning in dmesg:

nvme nvme0: missing or invalid SUBNQN field.

To fix this, add NVME_QUIRK_IGNORE_DEV_SUBNQN for this device.

Signed-off-by: Jason Nader <dev@kayoway.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..fd9982a7e3c6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3399,7 +3399,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.45.1


