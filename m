Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/K7q37+bFODf8Jeuny3qSyRmQ7MxizDThrRer2difyI=; b=2gVcYJRxKCWqB/nFljH1kFj9DS
	Rn/Vq0fo8hE59Ib/ecrAd3Fxi+VbRbfBYTJqYcFJZt9p+G1vpUkrclhN9+09gvUHztQ57j6ZhPCHe
	d//3scJDybMHdYzy+kt44Em0NkqUAOzNz280O6cQXMiD5p7yCtoKJHmIQsQShTJVBCBK+lWaTj7US
	2fnhFAJvDHq0ppWrHae+xkF8UmKRFjh+Q33Q1/q0eGKADyfZE2RIdFFZsJcJMwwji6mkz6OHqCAh6
	xANOWOTakLCI9KatdkwC6oGcfCLFUfI1/TOjwMgWuvrB6AdLsGd5NkiVvrk9g1yJSCF9o2Wb2ME9Q
	p2B0K/2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc2V-00AP2s-VH; Wed, 09 Nov 2022 03:46:11 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc10-00AOND-GO
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:39 +0000
Received: by mail-pj1-f51.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so693549pji.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K7q37+bFODf8Jeuny3qSyRmQ7MxizDThrRer2difyI=;
        b=4KNHRz/s6YNr9r95Jw+W4dvD4AQRyo14CT27OAW0EA6QPUpRCjPaolecNv2Q8hwCdc
         Ens3cpEJTxVNfdjTgXsOO/g0mKvJVRV+wPUjHpfEDgj8Y69iPkGdzy7wSUcg2HxFiNcw
         8b3RF/RGM9T3VIZ5nnSN9wVQAg2LLUazoPdJGzU7aDcrKDIbajxwDaBYybSmWW15IqTM
         aaLsIx0WoCu3ULnBlOqpseOyd0jT7PHxZynbs2x4+83BvvkSQEqUlB4eNxWxRf30YzgX
         IhYGmg5RpoFT0DV1psLIGVan3rS+fbKIhjwNLbFTzVQ9Caiqfi7YC9Xs8X5EVppXNRlZ
         5LLQ==
X-Gm-Message-State: ACrzQf2LljNvv2+Dvbj4n0ovKFnNOrHmqDMZh/70sH+6OuqJPSpLnjgo
	Ulhx6XnEzRGkd0TJax0DuF/Jtt2smojwq68j
X-Google-Smtp-Source: AMsMyM4Z6c7sRvcbepAz1L0xpD5eLcNmKFlkCx76e+upNqoRODDZJdGf3vOsxmCcbXV04tLnUgRpKg==
X-Received: by 2002:a17:902:7590:b0:187:29fe:bdb1 with SMTP id j16-20020a170902759000b0018729febdb1mr47306527pll.134.1667965476489;
        Tue, 08 Nov 2022 19:44:36 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:36 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 10/16] nvme-auth: remove redundant deallocations
Date: Wed,  9 Nov 2022 05:44:13 +0200
Message-Id: <20221109034420.1000086-11-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194438_573364_352BA39E 
X-CRM114-Status: GOOD (  12.20  )
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

These are now redundant as the dhchap context is
removed after authentication completes.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 484315efa0b2..9218f50d8be3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -197,12 +197,6 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
-	/* Reset host response if the hash had been changed */
-	if (chap->hash_id != data->hashid) {
-		kfree(chap->host_response);
-		chap->host_response = NULL;
-	}
-
 	chap->hash_id = data->hashid;
 	chap->hash_len = data->hl;
 	dev_dbg(ctrl->device, "qid %d: selected hash %s\n",
@@ -219,14 +213,6 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
-	/* Clear host and controller key to avoid accidental reuse */
-	kfree_sensitive(chap->host_key);
-	chap->host_key = NULL;
-	chap->host_key_len = 0;
-	kfree_sensitive(chap->ctrl_key);
-	chap->ctrl_key = NULL;
-	chap->ctrl_key_len = 0;
-
 	if (chap->dhgroup_id == data->dhgid &&
 	    (data->dhgid == NVME_AUTH_DHGROUP_NULL || chap->dh_tfm)) {
 		dev_dbg(ctrl->device,
@@ -621,9 +607,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	if (ret) {
 		dev_dbg(ctrl->device,
 			"failed to generate public key, error %d\n", ret);
-		kfree(chap->host_key);
-		chap->host_key = NULL;
-		chap->host_key_len = 0;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
@@ -643,9 +626,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	if (ret) {
 		dev_dbg(ctrl->device,
 			"failed to generate shared secret, error %d\n", ret);
-		kfree_sensitive(chap->sess_key);
-		chap->sess_key = NULL;
-		chap->sess_key_len = 0;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
-- 
2.34.1


