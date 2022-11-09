Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F3CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2MqjM5KlbB0xlYgPS4Kf6zYG2aVjnEUMof8WYpBSg0=; b=Kgu/fiSRw9yhYUKgNWkGKvD81b
	tNtthTnDiQYVpA+bsyQmaOF93B3EeKKTMDJxqagA0s9z0OuyzaXnYwkl/lg4CrlKxoyoPeFZI3sY0
	si873SCMOlskfMHAHoRMT87lOdgz/myPrfGB1FYGHP3bC82A5RI0HsIl7dApPpXc1YxnGDP0BqaD6
	81bQ7naPTznay21Irr3BCRDz/GLMKBajHUi27f9b3eKTXN4oaDoVDe7EGsqNLnD/60GNeFnaPFibl
	8LR+qPhBBg6XoEN/3WoXShTjNAfoJK72cJoIqEgE61QZJgCDpFWH2Le1C46dCyqkOIwdfvUVDKLPB
	aBAzWUSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1l-00AOho-8C; Wed, 09 Nov 2022 03:45:25 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0t-00AOIE-Ny
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:33 +0000
Received: by mail-pf1-f177.google.com with SMTP id y13so15551397pfp.7
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2MqjM5KlbB0xlYgPS4Kf6zYG2aVjnEUMof8WYpBSg0=;
        b=eygyAnLWG9QFcK6WGYYROky55ujCXrTVqft8fQM0+nLbEWCkJUOH3H/YcAND9I/bxC
         LOskbw/u1dk9z1SmLjVWSJFQxiJ456LQn8RdaXpYjf1QUZGTkhFC1hdOv86FTfbIum+K
         iJIBtp1ZESUSkkPXoFdZb36/edpWYMMCEtNlfxBiExkh4biK/PS9xxoJU5/vJMHYgepZ
         iBCcYECyIyJs2dKiZHwQ0qqFvpLEPD77KBT0eWpK0PubSKXDIVJhPzKeUy+7ZRK6K/6N
         Cz3za0n2DxRS8u/UVav2wPhSk9v28qnkufZcS/Eg1My6juzeP1FKMEZIcSwTTsS2iPX9
         AQyw==
X-Gm-Message-State: ACrzQf3J8Qs6kkjB4cJ63hQp+n5GGEYehilUkxaC9x55w/7cOrK3JeSy
	vw41cUfkyFj1pVa02FowTidQJkbSYu7WSEki
X-Google-Smtp-Source: AMsMyM4524RwP15X2qNP/k5YjfDtzTNtz1gGdbImvCOeRbryPe22fklY4atR6daYY3Cc/uy1HKdvjQ==
X-Received: by 2002:a63:5702:0:b0:44b:290:f24f with SMTP id l2-20020a635702000000b0044b0290f24fmr50425165pgb.558.1667965471115;
        Tue, 08 Nov 2022 19:44:31 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:30 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 06/16] nvme-auth: don't override ctrl keys before validation
Date: Wed,  9 Nov 2022 05:44:09 +0200
Message-Id: <20221109034420.1000086-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194431_812948_4FE41330 
X-CRM114-Status: GOOD (  12.10  )
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

Replace ctrl ctrl_key/host_key only after nvme_auth_generate_key is successful.
Also, this fixes a bug where the keys are leaked.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09f2b44fe771..4aa855a4839a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3746,13 +3746,17 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		struct nvme_dhchap_key *key, *host_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
+		host_key = ctrl->host_key;
+		ctrl->host_key = key;
+		nvme_auth_free_key(host_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
@@ -3796,13 +3800,17 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		struct nvme_dhchap_key *key, *ctrl_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
+		ctrl_key = ctrl->ctrl_key;
+		ctrl->ctrl_key = key;
+		nvme_auth_free_key(ctrl_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
-- 
2.34.1


