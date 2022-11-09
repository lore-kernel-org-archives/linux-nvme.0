Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5D2C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ll84X4GVLdgTtEfmAb8H0YEnUInQUAQWvaWn3vlRYhQ=; b=mp/8PY1NvZvk7h1bIlgcrL9UJw
	P8fcCS8YNso3hfKVAV6JQvQZcEobFo8LeTYhVVBk9jVqLd+gXQKEnx8IWnwbTHDDzQq5S0IUB9h+w
	yCrFYSF8UMrH5jmqDHy4jbw7fuRN+kZfefJsBD5X3eQMK5sv/kIWyQktAdYRXAlBUqmi6b9wc32Tg
	xhioUDEa8pcmeFKkFFNiO0cwULwMDsEyBruNwqO3dm3bpPFCJDOacF8/pd4DQaL6y4oOn1O0bMsv1
	deEv0+WmbHcLJQryeg0BRoL+h8FyMlh8EI8GY18HPjfLeCf1nroxZDBe4/SAPGfvwlm1NYbk0+LzW
	2AKmQ/AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbmw-00AKRb-Qq; Wed, 09 Nov 2022 03:30:06 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbmr-00AKQz-6Z
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:30:02 +0000
Received: by mail-pg1-f174.google.com with SMTP id e129so15104021pgc.9
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ll84X4GVLdgTtEfmAb8H0YEnUInQUAQWvaWn3vlRYhQ=;
        b=rASV2umm3Am3GgU1J4n3jL0POowEKtw407PHcm9LDckXtaPt/Ou4j2hDxWvC4uD1XC
         bc9FDtpmPrHqGqfLbxIcRQpEGZ+gwrqdq35Dkg8AkN/tH+mZYpcdOJRzpQFE0yP2pzTX
         01VGJ/UkxLq6CjrrkqrgugyeOICwkJCaF9RCafbby25o4znL/lRpYKl+4ptWu3RSnzpd
         o2SwOf/d2IxjPCV6hKcKThIo+K2LgO/X0MiKlI5Hviuflb6mWiplpsVGoPqoZ5pCoimp
         bUSBarF6M7GNYZILmNyKpT5BW0ZbLcqNHBcQQklLZER/qHeS5nCEEY+hAPfxh++4/qnK
         E+TA==
X-Gm-Message-State: ACrzQf1ORsFyANMP9zTkT1zKFyW1oBFW+21jizDJX5lGVKkBM8FaeEib
	2mK3YY+OVi58xH13ibJnF0xmzwKwcIVI/Q==
X-Google-Smtp-Source: AMsMyM47MyMPTjMa840h/RxT+UKT0HYmL2rSwVeFtWt6Izjl0d2stGvXsPYrsB6FULGX9cw9NM1pgA==
X-Received: by 2002:a65:6d8a:0:b0:43c:9fcc:cb24 with SMTP id bc10-20020a656d8a000000b0043c9fcccb24mr51217995pgb.477.1667964599895;
        Tue, 08 Nov 2022 19:29:59 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id iw2-20020a170903044200b0018875b76945sm7006711plb.274.2022.11.08.19.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:29:59 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: Fix a memory leak
Date: Wed,  9 Nov 2022 05:29:57 +0200
Message-Id: <20221109032957.998128-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_193001_260439_41D2925F 
X-CRM114-Status: GOOD (  10.19  )
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

We need to also free the dhchap_ctrl_secret when releasing nvmet_host.
kmemleak complaint:
--
unreferenced object 0xffff99b1cbca5140 (size 64):
  comm "check", pid 4864, jiffies 4305092436 (age 2913.583s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 65 36 2b 41 63 44  DHHC-1:00:e6+AcD
    39 76 47 4d 52 57 59 78 67 54 47 44 51 59 47 78  9vGMRWYxgTGDQYGx
  backtrace:
    [<00000000c07d369d>] kstrdup+0x2e/0x60
    [<000000001372171c>] 0xffffffffc0cceec6
    [<0000000010dbf50b>] 0xffffffffc0cc6783
    [<000000007465e93c>] configfs_write_iter+0xb1/0x120
    [<0000000039c23f62>] vfs_write+0x2be/0x3c0
    [<000000002da4351c>] ksys_write+0x5f/0xe0
    [<00000000d5011e32>] do_syscall_64+0x38/0x90
    [<00000000503870cf>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9443ee1d4ae3..069b8e81f94c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1836,6 +1836,7 @@ static void nvmet_host_release(struct config_item *item)
 
 #ifdef CONFIG_NVME_TARGET_AUTH
 	kfree(host->dhchap_secret);
+	kfree(host->dhchap_ctrl_secret);
 #endif
 	kfree(host);
 }
-- 
2.34.1


