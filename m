Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0709C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=; b=FYiIVqTrCY+Vq9t6N9IgAXqSL7
	4nLtdzMdfS9yIemcmfG6AQp2Wvmp/aO2Y1xgbX9fJtukHdycmvD+4SMoJRoqkK7+TLaiakO0W/YbR
	pWktZ2BfQ5WVkkcF2iuID1Uf41CIYN2vT6o24EF4Srbtjyppxus/kI1OZqBirvETbP6D1/wwJx0S2
	+h4t70aeP1eM8Hmdr0iCFxzzJgGUJ2jICaFCS451imnCLjcAdS2grIP0+agx/wpGieujShf+ZNP3V
	R6TO22EPGuSFM1JrP+TQ7e61C2cK9lTUIWt5ICDZfAIgT3m9FZ+C67gdEyOmOl3gARLdnPyDYfQf3
	Q0FyT2Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBVm-00FDdA-4X; Thu, 24 Mar 2022 00:39:34 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBVi-00FDca-P3
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:39:32 +0000
Received: by mail-wm1-x32f.google.com with SMTP id h16so1883154wmd.0
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=VP+e/nfLnPCvnJ69uuVZM5DonNfvC3pbrcb0XzLkcWDACMeOdRh2jPNfi/bRThlqNP
 7dVl6fD7xebZ/24Vrj5w2dwPYOd2byvqOP2UqOxKslXk9p+WryGs18GXRohgDXet43kO
 R5HJ+fZ7bEa3UTfnAYUcDK54VnSSuS71oRgmNmBzU+epW7NZxlSE8fK8zi9oBAi2rUai
 bACoJVnorWiU6g6WRgYlNYBqwfgU5UTEgW0gzS7RAOUkg8MyQnemUkmT1/wPCrweSTJg
 nYbY5FDMp2MTob4fHfNlCBr/pfdIt6C75wWWZFkJGJM7O2BctW0/rW7TY/2XD/g+dpFD
 FZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=OPuu3u8R4dp7vV3912lKnatQcZkAwEm9VXI5vOxpW5cx0UsDG7LKxtBQLkp227wIRw
 +u6syTawdIZnigye40dq6IR6T4MS3cYhY0mqkH/SgRICFynJAbqTKqEwqQaukryXEH9j
 dlwWRdGo4gkuBylYm/AL8qU3raqHCRpVnzmD7V/toXQnd/PGrw5T8F3ilvuTEHb6kYvD
 4m7upw6tJRvg9RNTENfqvxXYWR/Ruqh7uKfrycq4G4P5SonXpt8+u0BwOUyD8FFJbWAz
 pYAIlUUIsKhAba7pa4S/H/bltpnSrZV0u6O0czOOUJ3Vbi6W6A0Bq5RIlxKNwyH3iSSB
 o+/Q==
X-Gm-Message-State: AOAM533DGXU52asX2YM7vGlFdMguhBVKLzeVcMHBOuYVQWFJFhzN68Zq
 BTN7MjkYb/0j//obd6cDyxqBvgJxu/rxTg==
X-Google-Smtp-Source: ABdhPJxYhaddCPpGP/kP8TaIOOXx0Gk6ZG3xpghcMGdNvL2PHUTdYBfpBwVEDFAHXLvODGR3406Odw==
X-Received: by 2002:a05:600c:3588:b0:38c:6d7f:6fd8 with SMTP id
 p8-20020a05600c358800b0038c6d7f6fd8mr2386827wmq.25.1648082369097; 
 Wed, 23 Mar 2022 17:39:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 n8-20020a5d5988000000b00203d5f1f3e4sm1187937wri.105.2022.03.23.17.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:39:28 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] nvme: fix build error: nvme_mpath_update stub without
 static
Date: Wed, 23 Mar 2022 18:38:59 -0600
Message-Id: <20220324003900.1589124-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324003900.1589124-1-anton@lightbitslabs.com>
References: <20220324003008.1588225-3-anton@lightbitslabs.com>
 <20220324003900.1589124-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173930_824148_5DD2E62D 
X-CRM114-Status: GOOD (  13.12  )
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

Fix multiple definition of nvme_mpath_update() on
builds with CONFIG_NVME_MULTIPATH disabled:
the stub function is missing "static inline".

Fixes: d50c992edf10 ("nvme-multipath: fix hang when disk goes live over reconnect")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76f7a5f37379..8cf90c9ed667 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -853,7 +853,7 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
-void nvme_mpath_update(struct nvme_ctrl *ctrl)
+static inline void nvme_mpath_update(struct nvme_ctrl *ctrl)
 {
 }
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-- 
2.25.1


