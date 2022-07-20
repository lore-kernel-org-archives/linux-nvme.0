Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A81FC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VhNKxd7eGerf4c+5t3pYtmGhfXzHJ5nwhennYjjpUDo=; b=doUdXbU4Z4bTNwd2R+RpEi/7V5
	TG1JSJs3j5D/wjSm3ZVz0cxZLhBbHx55adbxfGsq5xoJsAYKA7GsTQ67iW/fNjtaK2cNafDTe9LSx
	wP9ABsh9hz6L84GFo9WcE4uM3XNX1PKV5igVrjsRlfumfhOBDDTkMXd2+CduWns82Fe3qzU47efFN
	Ex1J/IOJXKajqn781DwQapwP8mj/WUhVbLQr3PhtPH0opGuNVu6CeNk7oLtzOJ2eP94n30mA+KWoy
	y12TQbn67UYMGhDk0GGHkvKLztSsYI777CynDNkjkmXhO6l+KThNEd8yPRD9t4n/sDb8+CEne1N9W
	E7HxgZMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE81I-004kLt-3D; Wed, 20 Jul 2022 11:37:36 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE81F-004kKJ-5u
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 11:37:34 +0000
Received: by mail-ej1-x630.google.com with SMTP id ss3so32469531ejc.11
        for <linux-nvme@lists.infradead.org>; Wed, 20 Jul 2022 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VhNKxd7eGerf4c+5t3pYtmGhfXzHJ5nwhennYjjpUDo=;
        b=LREApv6SCTimmIoeyyMIxSuDuqCkBoLOrfJdoFlApsadYrIudK6ZoRs+WCQFKVY3I7
         NhOuzfNfV1jtmtkHrkekaW7XfAlc9uWqj0PQXVZ1JN9IaZl9x8Av0jxuKYl4SuRmbd8q
         3D0Xhf+DXNVvbn1nY6beJwZXR2eziOOFGaTXrfdqGPm2KwmkYzPrZlMTZUk/TY6wh+Qj
         sED39mKCy/c/OvTT0ulSqSfuEtY1ar3+eJVymSVR2B9SOu/NRRn6ObHE196LWdmiQVx8
         XhJ899Mp6+MB1Izkmg8t4XWTxbSl/HAUEMKV22xuIocdLDA3ggshhGl6HoFgYqEvNIGB
         Qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VhNKxd7eGerf4c+5t3pYtmGhfXzHJ5nwhennYjjpUDo=;
        b=qSwwaByutvDICv1tix/voYbrYCNI0G5/wZAM959IBfDPtHXjzUq8uIBUF0Eygzga2q
         UTqanq+WfwTq99jcP7bu+wkGtJ0gi4tmLh2arxDQ+o1cu40lrq/KUYJLjeAd8ciuqg28
         KZc/ybHp6Nenb6PuFIF2NtIHoKKzipfvCURJl9keL3oZXBAO/j0e/WLrHP1S5X580T99
         N3D8qGm1BANTkpsbmmpQ6obf3lTkR3zvESpjhbyDe7YLPe7375kJtoHqIkEyxWryxXxV
         hKkxcGdjMjdLnh5FNk/hswzgNtD0u+gYs/lJ5Kiw0kpwXWK4/Oyv+kwd3Lm7SaFMUApY
         /sjw==
X-Gm-Message-State: AJIora8NrrknZ+5FKbLid6LD/weLAmz8pzyO9VGtR6vOBsK4R+1GSY3s
	3ltT8ipjAtN1HmLfz1Ui3FE=
X-Google-Smtp-Source: AGRyM1v56IMpALyBNMP7qyZnzAwBX1pyALHup1vbAOqh5W/Au42jnRRbwBUS9wBN8vmJ7honTsvuJA==
X-Received: by 2002:a17:907:72ce:b0:72f:7b3:b9c8 with SMTP id du14-20020a17090772ce00b0072f07b3b9c8mr22102249ejc.248.1658317049475;
        Wed, 20 Jul 2022 04:37:29 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b0043b9d4f7678sm2523731edq.96.2022.07.20.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:37:29 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS
Date: Wed, 20 Jul 2022 13:37:17 +0200
Message-Id: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_043733_241861_F93F89E4 
X-CRM114-Status: GOOD (  12.47  )
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

Commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
intends to select 'Support for RFC 7919 FFDHE group parameters' for using
FFDHE groups for NVMe In-Band Authentication.

It however selects CRYPTO_DH_GROUPS_RFC7919, instead of the intended
CRYPTO_DH_RFC7919_GROUPS; notice the swapping of words here.

Correct the select to the intended config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/nvme/target/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index f0c91f7686a3..79fc64035ee3 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -93,7 +93,7 @@ config NVME_TARGET_AUTH
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_DH
-	select CRYPTO_DH_GROUPS_RFC7919
+	select CRYPTO_DH_RFC7919_GROUPS
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
 
-- 
2.17.1


