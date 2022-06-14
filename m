Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A649C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QA+6zqPfpknDlOYAQ8mQVKw6wFTP9MDVA9zNZsWiDes=; b=idruIZ2UNdJpjEVILQBrUipCzV
	CQKPm9UyriN8UGz+fZnk0R8QujcFw6i2IwTi+UpjRcrXBQP2/QwXOXQ/0x3IodfPkqTjLTNjJehjP
	GI4MHySdgBHLNGU1H+hkcdD0BIPKmY7kqLG9Qv05jT2R64MKHFiZJYJylTIxNLC2j8+F4J3YotWmS
	aW93HwIewHFdMhtbM4gZBJ1/xGlK6EnxLOAx8190+WRuotdR3Njyegiuh9gSUwD4yD00X+hmF0Qsd
	xPD1oknpW71lDjv3z9lpHDVWehO4HVs1LjKlmGqJ8mDLbhAME2PkVQNymI1S2ObqFap0Vj4rqFKEj
	zMB7sF0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Dmn-00BKkN-Un; Tue, 14 Jun 2022 21:09:17 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Dmk-00BKii-Un
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 21:09:16 +0000
Received: by mail-wr1-x429.google.com with SMTP id m24so12797205wrb.10
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jun 2022 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA+6zqPfpknDlOYAQ8mQVKw6wFTP9MDVA9zNZsWiDes=;
        b=ocIvtOKy2TmZef3STpknKFoF2mH6tq6wXdvwJRomcq1MQinFdxYqxgnSd2Z9eF6j7S
         oi4swQzizTOuugao+BKi+OU1o29wH6nm8weAUjXDs/n4unapQOt6+ovGJhZu5LwBGxrQ
         Aa9XufIAodoHJY5K2syAdWnztRaC7g6Iyc5EX7mmUek0KcDRHxKBeXNmT1mZql6csQLo
         +l5IXZ/Vgf8IfWFY+08M6R+UbFVgboLF0ROCYtq1z/XafQr8EhI7dneouX20uIEz00ND
         iZiryEcqfPneYyKU1ro5qsE0q1i9VzsreWWiYA5X5aZhIE0CkJoT6YAKDtPF9DLZGoF5
         ZH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA+6zqPfpknDlOYAQ8mQVKw6wFTP9MDVA9zNZsWiDes=;
        b=zSbB7UfTniDJI4IKFeRacmvl2Am7OsbGk/IvygPcWJJLNeG6PAD3NE9j/gruUAOxJ5
         evKcqPTJ55wt5p5ilU7iLIML5ovNzwV3L63/TV5upVGfExPbt2giqQsUJefRSTdPCip7
         rTbZ0mTqdu7Hb2LZhrdQQnE/Veq9zaT5wM6izRdAfdIBZqSFJ3oGh5nIEqhW5gM0BJG9
         5SMSxjf5kPbCrAMyHXXp7MMtK7O8ivlRWUUtlAP7Bme9Z8cCvDLvmHTWFplEd84ol9jb
         WYW7HFx5kqqxb8SXUPM2X8H+5VbH6zzeJmKj+JrDEcY8xZLsNzLcPE+7kXqWZesQGq6e
         h7Kw==
X-Gm-Message-State: AJIora+vfWa7H47+Sf9JS0Pni21D5ITsOpFvMpyI0nk6cdq+BJdR4t/r
	gV0PIpxIWV7iutHmv0rRfyA=
X-Google-Smtp-Source: AGRyM1uWTLjcqmhhytRYteL0y3Djy6Xdt4X3+CiwfadO9nxLc59O7U8pC/fSIwBd2wO5k3vXLZao8w==
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id b5-20020a05600003c500b002190d096fcemr6578565wrg.197.1655240953159;
        Tue, 14 Jun 2022 14:09:13 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056000080f00b002183cedbf34sm3546649wrb.73.2022.06.14.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:09:12 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] nvme: Report model,sn,fw,pci device information during init
Date: Tue, 14 Jun 2022 23:09:02 +0200
Message-Id: <20220614210902.744318-2-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614210902.744318-1-e.velu@criteo.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_140915_030465_C5E965E0 
X-CRM114-Status: GOOD (  13.05  )
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

SCSI-based device get their identify properties being printed when initialized like :

[    1.245357] scsi 0:0:0:0: Direct-Access     ATA      HGST HTE721010A9 A3M0 PQ: 0 ANSI: 5

When initializing nvme devices, no identification message is reported
making difficult to identify them during the boot process. If the system
crashes during boot process or if the init phase fail, it could be very diffcult
to identify the faulty disk.

This patch reports model, serial, firmware version and pci information
as soon as possible making this early identifying task possible.

A typical output looks like:
[    0.383353] nvme nvme0: pci function 0000:00:03.0
[    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
[    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f7e625e8bd0..f73ca92412a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2982,6 +2982,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	/* Reporting model, serial, firmware and pci info */
+	dev_info(ctrl->device, "MODEL:%s SN:%s FW:%s PCI_ID:%04x:%04x\n",
+			id->mn,
+			id->sn,
+			id->fr,
+			le16_to_cpu(id->vid),
+			le16_to_cpu(id->ssvid));
+
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
 		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
 		if (ret < 0)
-- 
2.35.3


