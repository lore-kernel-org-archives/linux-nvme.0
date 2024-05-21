Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B20C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Se8C5AHw/nAA0+Nq2GZD2GeTlSdmgnSOoYKljZe8uWY=; b=ucNM2DKwsMIVVY30DVh+oVho3W
	XUWxh6AcRCmil9aJJP2OxaSQEBXTZRiML9+8cEbG4UDcRbPt+gMGcPN07z3h56XpEIPKkNwPtin6C
	3EMkdh2697tDMdx7NAI43cqzi7lg7I5ohhxnPQGdwF8Y/0HwozhapTAlmGQZVvxMx8Y7LamkJ2oor
	bjDv8y+2elutAE6Rvnoepetijz4IHq9cyGD6fmbghfVQYqwJK6e6/1ZC7/A/aOxzMwsjrC4lpKsYw
	hivF8afd/kmJmuCTugTUrSBdn4RijQFV1+0QTx1j+d8mAtZtIic0bdZTXC3wNrvX9V3iv9wzEXUVg
	TTSauBDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9LIO-0000000GppZ-1EEy;
	Tue, 21 May 2024 08:56:32 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9LIL-0000000Gpob-1Rnt
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 08:56:30 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-351c2c48effso741652f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716281787; x=1716886587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se8C5AHw/nAA0+Nq2GZD2GeTlSdmgnSOoYKljZe8uWY=;
        b=bL9cw5qs5hZOJxEEzwwPAzvQ6XK2S8p5Z8PfcVPRqJ0MRP0nb/ced1r+tR7WN6ex+i
         KL9bRiOKDEXuIRceUt0t4FuU0e4XkforpZAvQTbzdYpdd6fDB6LN3SlpZ/QSKBdMWASC
         CaqcN901q0feXSoWu9cNclT6NUy7ANzCwj9iK07ajhJoIEMFkhuJLbWlqzTDcfy9sfXB
         aKawASx2A6sU+69rLjiA2SUfHU5lsRX8Ksen/ki66N6QFf9FHwMnQQ2V/+6IIFCBqZeN
         z+5MCitHbcGf1Wx4DHmiq1IEu8ky5GbhNTnbevFdSKrEqqZ/ulOiX/IprkHZe1AUC24r
         VlcQ==
X-Gm-Message-State: AOJu0Yzqa6jkYQpr9xMe24+1pE56mly17XgG1m39+BqEL62AJq+fgELK
	UFTitYTw43ErU8YjVZrfHIdwBHh430mlm6+HkGCDejA+wnm+zjHodlaBcg==
X-Google-Smtp-Source: AGHT+IEDY7MiuYfRprmKKrI1tES3X849JO0ZhOOKBlQrPUuGSwzrueiMgJrh7YvIA84MN2PVhmH0LQ==
X-Received: by 2002:adf:9bd3:0:b0:347:d167:1094 with SMTP id ffacd0b85a97d-3504aa6894cmr19666424f8f.5.1716281786863;
        Tue, 21 May 2024 01:56:26 -0700 (PDT)
Received: from localhost.localdomain (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a1dsm31219337f8f.32.2024.05.21.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:56:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: fix ns enable/disable possible hang
Date: Tue, 21 May 2024 11:56:23 +0300
Message-Id: <20240521085623.87681-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521085623.87681-1-sagi@grimberg.me>
References: <20240521085623.87681-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_015629_413859_288CCEB2 
X-CRM114-Status: GOOD (  11.94  )
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

When disabling an nvmet namespace, there is a period where
the subsys->lock is released, as the ns disable waits for
backend IO to complete, and the ns percpu ref to be properly
killed. The original intent was to avoid taking the subsystem
lock for a prolong period as other processes may need to acquire
it (for example new incoming connections).

However, it opens up a window where another process may come in
and enable the ns, (re)intiailizing the ns percpu_ref, causing
the disable sequence to hang.

Solve this by taking the global nvmet_config_sem over the entire
configfs enable/disable sequence.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6a736d28d767..b38097acc605 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -676,10 +676,12 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
+	down_write(&nvmet_config_sem);
 	if (enable)
 		ret = nvmet_ns_enable(ns);
 	else
 		nvmet_ns_disable(ns);
+	up_write(&nvmet_config_sem);
 
 	return ret ? ret : count;
 }
-- 
2.40.1


