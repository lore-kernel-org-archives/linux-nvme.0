Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC70C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMFHOD4v7bvF8sXYatGfYNtS6OVb1WGf41w2p9L8PBo=; b=yVlHGR44mlqmJ+Pfdrn85dKwRL
	oiOPWABPinVvo112H1d+ZSZRlRh1gtZO2YQ3kOPbaIq5PtYhhCcdnfZXBLik12cApCe8F/sgz+p+E
	Wju+T5+qalf3ilHKj4eYq7vSXjVijwtPzHzTT9RPbLQVxP6eF1h5y8jbjGqDEF3ym2lMswEFgOL25
	dh7SHnq91UHsAfEpcKJ2FiiNRP/gqM81fWvNa5EuDSscN+hCzDJNynXw7axFcTS0KvFfHwPorBMgW
	U0BUL4g/XqRchaNhO2n+nubnZf7wb+X+W1z+BiiGqbzCVC00OLGmGQU+TYsaiLuHH/RbIWAGS5hWC
	jtBYuPVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKZ-00000003SMP-2Ry8;
	Wed, 22 May 2024 15:56:43 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKW-00000003SKy-1Ob9
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:56:41 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so2229084b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716393398; x=1716998198; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMFHOD4v7bvF8sXYatGfYNtS6OVb1WGf41w2p9L8PBo=;
        b=YqEjvf4wYuVpvWdDbWZvqGEiWBrXhbaDXVye633EIJLWNFQkg6VdT95PJ6VA6GwT7J
         LJMWkvq8kaCLycBllveO6cyp7OnVJBq9nzL00z7Mal3lacLhpFiZlyHJbTKentr9Gzre
         gld1/A+anprDF0mgpI+gkuebqGwWjTlden/pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716393398; x=1716998198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMFHOD4v7bvF8sXYatGfYNtS6OVb1WGf41w2p9L8PBo=;
        b=BVynaLcN0IhJAe3u3Y3HWHxs+rjpTXiYZGEDdxFc3dJQfRVTj58ZrBQDDkDSRo/aie
         qyLAmG+2CduNbpQHN8XlspZYmqGPrhKJXw84VXwAOhvRg4LuDP7QVIzXF8lshtx/E9ao
         DV4L1BoIEl8FOmIqOrjkGQqy5LGTalIp4oyOqXHqVMzOZOoxrfRwbYPNbhDFA/2OFe20
         gYQ7QX0G+hvaaPixLnL518Eb7UNZYinomjUi2Ar6BErO1giLOGTz3DQjHmVl3PE5j2ot
         4w+rXTWfMAsdoLE7+zfXAYY2o5jxA+PelBMopIBI3SfM+2feNw2jerkZ8MMysExQmu7r
         isMw==
X-Gm-Message-State: AOJu0YxD/yYDBHaLdpQcfwyEhU4B0ZkiBbJmttoeQ+fQrY1Vi1u0qyak
	g9lDjtrhN42OEv8ty6TBGW70L+UsJUyoO0zNNhxDMF45eg3ofnQQ6rxdkIrU+k8=
X-Google-Smtp-Source: AGHT+IGoScfH1A8pH2pzVs+rWPKvKSVp+WxR/kdUN6ZJR+tBGYxm3dQ8V2gDqQdvNSix8GEApKnunw==
X-Received: by 2002:a17:903:2444:b0:1f3:604:4b18 with SMTP id d9443c01a7336-1f31c95c159mr26313435ad.9.1716393398576;
        Wed, 22 May 2024 08:56:38 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30c9239d2sm34951375ad.53.2024.05.22.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:56:38 -0700 (PDT)
From: Jason Nader <dev@kayoway.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH 1/1] nvme-pci: add quirks for Lexar NM790
Date: Thu, 23 May 2024 00:56:14 +0900
Message-ID: <20240522155614.191849-2-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522155614.191849-1-dev@kayoway.com>
References: <20240522155614.191849-1-dev@kayoway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_085640_392617_5ADF25C8 
X-CRM114-Status: GOOD (  11.52  )
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

NVME device 'Lexar SSD NM790 2TB', which shows in `lspci -nn` as
Shenzhen Longsys Electronics Co., Ltd. Lexar NM790 NVME SSD (DRAM-less) [1d97:1602] (rev 01),
shows the following warnings in dmesg:

nvme nvme1: missing or invalid SUBNQN field.
block nvme1n1: No UUID available providing old NGUID

To fix this, add IGNORE_DEV_SUBNQN and BOGUS_NID quirks for this device.

Signed-off-by: Jason Nader <dev@kayoway.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..8ca831cb2f79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3490,6 +3490,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-- 
2.45.1


