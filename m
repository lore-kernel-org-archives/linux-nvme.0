Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B069C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JH5UaZbddQ4g4VUs9BSRG0P6JVrmr5wmmT+eZNqz3KY=; b=tg9TXHHVETXMWMl2l+Bi/ZHqC3
	yZmYHh45iBxF3iC7Ipz0zdD7/8QehAP8A8F8374Z6rwJHdvWEumSHIcGTpgJSxaAvpIM1CuW7SIM7
	s5YAe96OtWBGI4xMM7AB4FNZGA4gWcwv+Vsh5jHN18NBY784tSaiV7K1rZAm5L1s1Q/dS/Gqp1bT8
	ftD2N1qH9mjrUu43J0gDxBpQ+YEQgy7WIO4SUaFOYfTbf7NUxGwq0oV4WhnAujBWMv30rReXqi/0u
	irg4hXVsKGDAACYTOXHNBB5LCojGdU44WODDUf7fCycm/BiWIY33xGaj3q3ZJgMmJeGluuLKExsDg
	6WUEf1Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM5tg-00BQRg-31; Thu, 11 Aug 2022 10:58:40 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM5td-00BQPR-AR
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 10:58:38 +0000
Received: by mail-wm1-x334.google.com with SMTP id v5so9291722wmj.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JH5UaZbddQ4g4VUs9BSRG0P6JVrmr5wmmT+eZNqz3KY=;
        b=dvPqJvgtVa9djXx82FFMURarilTzXwJ2dvudwGnAfeJT5qF3cNY+I7iByszlPMzqwU
         83c8iXIJTXV+kUGHBQ5WYMJ+gyTaCMubzI2mhElRdMtUzEOimL+8GImzmeQgM3kXJ3YQ
         ewGY1AWUZHzo/3tMkZJQKFoJ6BCa8wmY2EU9GRTXp+yCBnJlHitM/QtJqyji7+kE/Edi
         GJu/Lupb0Y6NvEmTTs6iUTMBv60PYoX9auwHJXPx+5yru/rfF68fHRs39ZF8a3p/78go
         KbPoZtDDBM4nQgUiWLNWPiVUPTnh2CZ/xV087ZIqwCV25i83Mr9zVeKu2Mrb70bhYmWp
         tWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JH5UaZbddQ4g4VUs9BSRG0P6JVrmr5wmmT+eZNqz3KY=;
        b=rupxXl7L+SMacgGhj4qx31DuukacPSYd1rQxszKJZXPHyiwvQEHJQB1Wq9RsNJslzu
         uRDNbpw8sqhGugZ6eOwFqEmGwx5YjCmWIHEJDljBhrVsFTE6+dJ585NqINEk4PEcfh2R
         PAJuvcuLJ6gWD6FTtKHzquvbms2cTG2Jhw3/e5OjSG29xPoyB6mRDaJ2f7pc4AY7B8tx
         ZZmp4ZbePdFEfbBkMpNE8rXZVjabKNBM9+97CpLvaaGjsn4t81RX2hkGvLGedLFE+KRK
         qySHEZZ4NqLnb0ePcpX19IqHPRN2p+gMOi1htMK+GI0knZUmm2trrZH8A4m/NIlcqrXO
         L9dw==
X-Gm-Message-State: ACgBeo36thizRxFXeyWoNBpeVPHTUoIYINcctOwO3t/1sYOAoZ9NUgcR
	GWP/Dr7lkiLzFZnCrrcFaAM=
X-Google-Smtp-Source: AA6agR6Yg8UMDUmlVWnLvoXXKJmynwJ+Hqvl01x91NOO6VprUtkTrq/E3/SClpgI7rwB/UEPmsxhLg==
X-Received: by 2002:a05:600c:3593:b0:3a3:3a49:41a3 with SMTP id p19-20020a05600c359300b003a33a4941a3mr5362128wmq.166.1660215510923;
        Thu, 11 Aug 2022 03:58:30 -0700 (PDT)
Received: from dpk0r.fritz.box ([83.221.247.50])
        by smtp.googlemail.com with ESMTPSA id g10-20020a05600c4eca00b003a3199c243bsm8745992wmq.0.2022.08.11.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:58:30 -0700 (PDT)
From: "Dennis P. Kliem" <dpkliem@gmail.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dennis P. Kliem" <dpkliem@gmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70
Date: Thu, 11 Aug 2022 12:56:57 +0200
Message-Id: <20220811105657.9493-1-dpkliem@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_035837_401107_88D06A1F 
X-CRM114-Status: GOOD (  10.51  )
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

ADATA XPG GAMMIX S70 reports bogus eui64 values that appear to be the same
across all drives. Quirk them out so they are not marked as "non globally
unique" duplicates.

Signed-off-by: Dennis P. Kliem <dpkliem@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de1b44631..3a1c37f32 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3511,6 +3511,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.37.1


