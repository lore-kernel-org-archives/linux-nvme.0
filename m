Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2722AC624B4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GDfm4qt8S0psZXBmQIeh0wAKIGN0pAlOy023J24MLXE=; b=Wpqv7myxAo1aJWN48hjEvKT3uJ
	dhlxKjky953yGuB3OyNL2ZAHILQBBVAMc6Y3URAoj+nXBa98dPQ3SFbGw1UarH7DEG1Rn0kVn2Xz6
	5K9LAqJZoZ8onsxi/Y+iEChzdPXDRaDUQHbf4X5+bSQcIIxnSbmmCMs1Er8xdwFIV1p7KDffXCYn4
	jdlcJ1CZL/sWwOAZSwPTrgvpU1D18piANlz38nOOJskWrXhPNtsoeQ6NGDZFTGLBKIH4pK48Sobxq
	gAzPBKOM/DbX4CzMEJWttUoRWcOR0Q3R8Q6MVldyRVEwXcan0MN7vzehJJV9nd8UkXzMV7Df+Cdww
	saPL1+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r66bn-004Kth-0T;
	Thu, 23 Nov 2023 10:06:55 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r66bj-004Krh-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 10:06:53 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d30d9f4549so433932a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Nov 2023 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700734009; x=1701338809; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDfm4qt8S0psZXBmQIeh0wAKIGN0pAlOy023J24MLXE=;
        b=VgTo4omQ/QScPU7hV7fzQcDl3l9krLEKcyPbsoUwslXn6GflrTFRhEGOHldDT7DOk0
         csY5gU4QooLjOL71L8bhE208tzQ8uqyDIwLwtGa5CTEUAZx82FqkuO5OvRNeFoPuym62
         yPRsh4q/wUEHhSX7OgIXvS/skZpW4P1nfyfd7Lw+8zVlzLXwBaHz9eUWa12M3ds1jbWB
         HIkEgS4UrpJSqBul8D20iZDILwWMsBwet9GJ206oR405qtD/YanJQ7eIXg3jGEW9Lfc0
         L8gAGCQe4K/Llujm7d9dQX1PwTbBzhBoZ1D63Wz1GYJK8BXDGyAHq9nQfmZ0PIy0CtAH
         rFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734009; x=1701338809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDfm4qt8S0psZXBmQIeh0wAKIGN0pAlOy023J24MLXE=;
        b=amsFy0DnJP4olnAqBAQZEOUhNUfxob9mlGp9FkR0Lw4afYtLV23a0daSkOD0MNt92q
         s4L6oy8WxTv8ssuvivQBinI9KntB6GdXLa4nEstm4WhgRymdDwo7PRqK5A4dMWwoEp4b
         ElIm96Au7aZRJa0Tp1k2c6/zBnJGFcuZNgEOC/Keh2Q4p6WB0bFII8kcNLfDF2u44oSv
         Yqt7o17elgzL4I9iVVWsiwnRTdhQmov0bQ7eoyX6mvHxwD9sYzbEDtz8kiQ55fc8M2yO
         baVwszusyXA+sMJ1bwo2P6KN6KhfrBwfOeOHLGfHCsdv0pIfla7JvohTT08r6ylcZRma
         UPXQ==
X-Gm-Message-State: AOJu0YwMyaWPCYyOZU7+7vIS4AqY9pHWCYH+1Rs1cwErs7X3dJs/I/eE
	i+3bCGPRLEoULifUGJVicqE=
X-Google-Smtp-Source: AGHT+IEutua3pI8NOni3oG8j1Dg9pd6f93LkwDUSkT4HyOKJkm22ZwndG7qOx6OzG+LoSkNfb7EdyA==
X-Received: by 2002:a9d:6b13:0:b0:6d6:33c7:802a with SMTP id g19-20020a9d6b13000000b006d633c7802amr5802221otp.2.1700734009319;
        Thu, 23 Nov 2023 02:06:49 -0800 (PST)
Received: from smi-System-Product-Name.tw.smi.ad (61-219-235-31.hinet-ip.hinet.net. [61.219.235.31])
        by smtp.gmail.com with ESMTPSA id d3-20020a63ed03000000b0058ee60f8e4dsm972473pgi.34.2023.11.23.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:06:48 -0800 (PST)
From: "Jim.Lin" <jim.chihjung.lin@gmail.com>
X-Google-Original-From: "Jim.Lin" <jim.lin@siliconmotion.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com,
	cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com,
	hardaway.tseng@sk.com
Subject: [PATCH] Merge tag: Fixed an issue where it takes more than 20 mins for SK Hynix BC901 to switch to developer mode on Chromebook
Date: Thu, 23 Nov 2023 18:06:42 +0800
Message-Id: <20231123100642.40923-1-jim.lin@siliconmotion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_020651_517283_31B62B93 
X-CRM114-Status: UNSURE (   9.80  )
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

SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
"disable wrtie zero" can fix this issue and Sk Hynix has been verified.

Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..f27202680741 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.25.1


