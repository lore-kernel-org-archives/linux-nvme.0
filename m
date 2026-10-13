Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AADCC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ktaJr2DM5Zu0cnAztDTvIMhfnw3Hsx1asRS1ecJrXeg=; b=V5yiTBYR0sMHYG5jgrP5fYZ+dV
	8304FwRqf5uY1cx7XqFwswdqwu7lYsgdWZGTj8qE8GwJs0ma02ncmyfSMMR7a8aK4fv/H2yn38moZ
	FAQ1rtRAdMYqMPU43iTkTYLZ7V1cH4mugWPYQfJ3Q7qkKjhHndzp+2GFZs5xyJA0Ipq7FctHwtaul
	pTYlEcrF8Us9l+OEsZwNvhAXF/6tw1FdfLq8axI129K+U6lG52e9a2WAgVEggXwRUA/Sy/dj0NEDP
	kRCIroEDfoSUIFPBYF9GzjjEDOvKyLwlmWVQNYNJ8qkS0RREem5KwP5KnATWFPn76diNyKFw4wEJw
	4HmDtebQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGgNV-0000000Dhcw-1jFl;
	Tue, 13 Oct 2026 17:33:29 +0000
Received: from mail-yx2-x09.google.com ([2607:f8b0:4864:41::9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGgNP-0000000Dhac-3uvf
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 17:33:25 +0000
Received: by mail-yx2-x09.google.com with SMTP id 956f58d0204a3-6757067f4e9so1339581d50.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912802; x=1792517602; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktaJr2DM5Zu0cnAztDTvIMhfnw3Hsx1asRS1ecJrXeg=;
        b=Zwb08+Oor/VEZhEwO9p8Ea4DCdGFXW9i2onv/01Esd4PrXbZYN+jgh10ck4zEwG9ZS
         VyPbziIash87p6iyqszFSQuOVCT3bGACgdFE+W5AqIa8Gb5k2HDLROPlAMpP2HVlXKCP
         PxlkIbTPDuxgaTqTEA1DCYjkC+Rk1zecY2pfYRt4d/3Zg11QLF79wgTspF17UwJMghs1
         nP+lwzePE1f8sJC1kWEgCTBv7jNL/w9iIANX531VwsOiAWnolLynwZAv6B2fQ7osDZ2s
         cmkOW1A3cSQKuVHVh/6epUn4VJkCOZuN7lYLKraVjFOz8OP2ZR1wZ0vHtyYJfb9zpSgZ
         mEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912802; x=1792517602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktaJr2DM5Zu0cnAztDTvIMhfnw3Hsx1asRS1ecJrXeg=;
        b=XkuOLdzstoZIohaHHfHpmKxeeRgd/1b9FcCk3hE+Cb7EV3+xYV1HVlcIv/Ix1+ryQN
         ESC0U4C9U/PbGeaP97d9zmnT/slHB/GIyRhD0ruf5PtFJfBV0cMCYLuj6WtKJy2FKlQH
         6EhVP7+Xv3jO5zbuOlFtkAqLhj3isrI47twEjNFgIewShuROqSNEHNUW4hbSzJgsVzfw
         Y7G4kHfvm6Y6EbI0zL/FJ/iXvp2pPFr3au9l6wFXBCXqbTYPMmbehHxR4bb4zasv8TyS
         9Lin9glFgdg9491CNwkJeTY/4jR8dqiaYP9LNcEcnhi6hHAmX1t0nARPv5ZAa73eq5wI
         xRlg==
X-Gm-Message-State: AFq9FYKv4wNSisj2+vlqwGKRTpvni98WF5hwjDur/t+rUBhghf9PVVB0
	OzH3pAUm3N7NLXiFyQ+N3LoztM47IE7R+mu29g3E0JGqOhkZZxaDGEi0ThnV2MVZNXX4Ag==
X-Gm-Gg: AYBFou0Ba2AouzCFRfSBEtaz1svtAuQpsmGK+ELXF8Rk1EOsqoF46E5Ch5d2UQCJkPH
	6zkTgLq3UU8ttXHIoIzQ07LjuEeavHzI+mvGcIiov2aawf17LYn6y7ktR8AzTC0fLXYALtqpNDQ
	klMGc2M7H7HKg7PfG205C1UyEE5ZFW5FyER3uQPHY4UbRRBo12wMRPt8E9jGFYf0wKYhzIxRwZg
	v5WvVWkUO5oBOYJpr6X3iuowuQgldWeqPvOe/v8eGENZCtlbwrWcH1VDiw15LWPQWy84ICHuMyH
	c3lRyEMzUgrkCiVC4Ozl1w9mG1JqT0R3gAamu2QGPEinhJF/qIFkIl2CmPLZ2QRaQqdebutnAhE
	f7ZzzXHe74oUn5jhbvAZaUH4u8WE7hl6YEsa1H6qV+v9uwIfYJ82DWqVvB76je98VVyiWoi6nzA
	pWKP09gy6qwHbf2+0kEz4WJ0W0kTV2Ybexb6UHA89nENCn8eggtl8SFg++Avz8UHJbMp4a/buK
X-Received: by 2002:a05:690e:14c1:b0:675:40a6:142c with SMTP id 956f58d0204a3-67935f1c770mr4649463d50.22.1791912801676;
        Tue, 13 Oct 2026 10:33:21 -0700 (PDT)
Received: from paradox ([98.122.223.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ecbfbsm46571567b3.23.2026.10.13.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:33:21 -0700 (PDT)
From: Martin Belanger <martin.nvme.dev@gmail.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: axboe@kernel.dk,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>,
	stable@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: [PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable by root only
Date: Tue, 13 Oct 2026 13:32:41 -0400
Message-ID: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_103323_978771_7A5221AD 
X-CRM114-Status: GOOD (  11.47  )
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

The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
0644. Their show functions return the secret, so any local user can
read the DH-HMAC-CHAP secrets of a connected controller.

Change the mode to 0600. Writing the attributes was already limited to
root and is not changed.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1e3dcfd084b..e0cb34545b97 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -864,7 +864,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(dhchap_secret, 0600,
 	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
 
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
@@ -922,7 +922,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(dhchap_ctrl_secret, 0600,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
-- 
2.53.0


