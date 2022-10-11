Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7129EC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+57ZqvNhATXLr/1cd2ohAamNcyquwTAjd/E20cKw2s=; b=oaczAeLCFFAWUA0AWPZT55i5A5
	Z4qzmlmilbNMBwJmBt19HNrm6EG6uviitmeVxI5Ovmcsy8HSbRq0puDfuQdiEIJWipM0aeJjRc7Po
	oCpAVj7IEMk4UUhQvwJBVI1oaPBoLeA913Esr906XANwVyVAVQpyED/rga57bsf7Ni/3XdzLdKxE9
	Va/XEvh8g0U4wqUeW1DO9osr1UoV4dlDzRIBvk5LIY5jYiv8IWQTowcHl48/nPhU7kBIu4ts1tpuW
	CwJMQsq1D52zs77WMTEcVPaWQPtKjSo8pTE8rIYcTL1PtHGgwD61FOp1XsxQ7c0N6YSCr0uWgUPFZ
	I0CzgksA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiD68-0044tX-Mu; Tue, 11 Oct 2022 11:06:56 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiD65-0044sY-Lk
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 11:06:55 +0000
Received: by mail-pl1-x632.google.com with SMTP id h10so12885696plb.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kingston-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+57ZqvNhATXLr/1cd2ohAamNcyquwTAjd/E20cKw2s=;
        b=VcFLBz+4MS1GumDcQtPFx6tVseQBByOcIHhTXPA82TisbjpEtb65HgNCMwG6u5+jnO
         YGgC3hTHIiRAi9EDKn69/5eRQkQ+4n8RuokPoV8062RX84Uk8nc3Jp5fvnl3PGNOtHzx
         aXTVo3aBmiDMQtF2Fk6wsz0Mdtxm2echPDrXw+hAnkLAFAaOzu2Vqwdt3G8OyWOfC+ss
         hUd13ApwQAeXVKvNONSN8id/jl6mT8AnBgltyO30rFDxMx8Oc+2nUWuQxIL6sBX3n6rq
         wcIP/yqE0G9R1ZHpAoYUfMyHN5xuNNdKFxZbGC0IEuuVMfUI2vBwPzrLqFJzV3nVBqze
         /3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+57ZqvNhATXLr/1cd2ohAamNcyquwTAjd/E20cKw2s=;
        b=GYHLdx/cUj/B8XflhPUsWG7kKqh+WYCroatXN8DfeQ24iGeURQROkPp6IHEErY2UcI
         OX4Viru/cXIoHW5+VwPiQpL7475LcC9XDbZP3Jbt/nDUVKC4is7sjCtNJjYca6TAZN6C
         fEQPaPauIRrwUpUOcZ00RFvY1Vh2eNlrFKrIugobDRhR7F6vMYOMqfGEsMnuZHGa3Yv7
         qnu5nh0t5qni9eT7YD/y7j9ReR9JUFJM/fqqALeWBCHoU33979jRVTKjP3IbCurFuWsS
         WIilRlQUXtL8x0r5NKEOUYOSdFHc1WYtQ3dhVP6/jknjQX/c3onIcUyEhWTsdVGGPcQ3
         hkoA==
X-Gm-Message-State: ACrzQf20NHtKs6aVt7rkAVkpstSLy1crCjFLiTRJGjmV99YCgNXjgIRK
	mMWfNbjytqvIl+h2xPKKmx1xD95AiDz2ag==
X-Google-Smtp-Source: AMsMyM4UQwQoNpu+6donIYg/lUKUPw1egJCzLRU1XqQhLs8AcQBG6QxtKsMhD7hX5G1bCWeC4Sd/ZA==
X-Received: by 2002:a17:902:f7c4:b0:182:25d6:fc4b with SMTP id h4-20020a170902f7c400b0018225d6fc4bmr11247623plw.63.1665486411414;
        Tue, 11 Oct 2022 04:06:51 -0700 (PDT)
Received: from sped.tw.kingston.corp ([123.51.141.8])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7940e000000b00562677968aesm8752001pfo.72.2022.10.11.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:06:50 -0700 (PDT)
From: Xander Li <xander_li@kingston.corp-partner.google.com>
To: bvanassche@acm.org,
	paulburton@kernel.org,
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
	vincent_wu@kingston.com,
	xander_li@kingston.com.tw,
	Xander Li <xander_li@kingston.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Date: Tue, 11 Oct 2022 04:06:42 -0700
Message-Id: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_040654_067271_C0DB40CF 
X-CRM114-Status: UNSURE (   9.51  )
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

signed-off-by: Xander Li <xander_li@kingston.com.tw>

Kingston SSDs do support NVMe Write_Zeroes cmd but take long time to process.
The firmware version is locked by these SSDs, we can not expect firmware improvement, so disable Write_Zeroes cmd.
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..d08c8c854f3a 100644
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


