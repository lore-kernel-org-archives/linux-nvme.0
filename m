Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADC0C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwMsktD4hq+FesGeBONU6Jsg5KeECHblj97iAJlMYTc=; b=BslR0tNzKalppJBaoO31kUJk9Y
	cPoxoaQQQbo4iytkauLVY2g/XJock9mQkSumWrfZtYb5hx8iPPvHH3iSqnytcuG9K7HUHyiP91ffZ
	qgx0M5W0dCIuugcUbXy2ljmAh6RJ7akRBdZuufYTkeyqg52DL4aYFNbiyX3CmmQwsFfJr6t8ToNtE
	GzYg+StXu3UMNsrTlveeqgXi4ZjIEsc0FjuQlSYFy4FGmZYtrNSsa7Jk8JV2fTd3nyA8wYbPaSmEJ
	MEZOGmNE3kM6+UTJVEivPR3fOUwtjemnhu4+tnVP6VEow8Zzmyw+fPdkhv1QqHwbNcrHiiw/Eo8cO
	YnBPCGtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc15-00AOMS-5L; Wed, 09 Nov 2022 03:44:43 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0n-00AOIE-Nx
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:27 +0000
Received: by mail-pf1-f177.google.com with SMTP id y13so15551228pfp.7
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwMsktD4hq+FesGeBONU6Jsg5KeECHblj97iAJlMYTc=;
        b=PpeB51fESDEZ35eN6SYqmXzFT2kYhJz1WpMU09DqacEr3SRwEvawdhMrSg1REo7C2K
         8T1/LcTeWV6OlK+aYLAuGlTnBaPRvdm727Rd7MPHi0rPC5YesDpgx2M2K9l6fq02l4IM
         XP8kF5bKdANuadTeQLgbfPxI4cRaAXo9TJ1d5CillM7kKmcKPNzohJlTQAjxI9RxaTDh
         ZDSQmsQh1ZgoZTKgTiQ/i3dUFaOXQph3z5iJeUqvy3HQzy36hSUvZghFWT7Lvg64OzQ2
         FG/DxSx72x7YRuplJOwPs43Gcc479nXExxo/0VXzsgKhPhQUf8rDm/PXyEK82fGgUzp2
         fYOg==
X-Gm-Message-State: ACrzQf1+jQiSthZwJfhgyei7xOPMwAKjScLp4wBgVEGbR6BuGVAVK4V+
	dg9LQa0lCf8AqkQOF4T7DwClG8Aoj862e05L
X-Google-Smtp-Source: AMsMyM4hNSPYU6+FBusfTKKroKRfTZmbGKGvq+YEy1xXqFCHUfQ6wAyH4/5QUspA1qfZzCMRr7QvzA==
X-Received: by 2002:a05:6a00:cc6:b0:56d:3028:23ea with SMTP id b6-20020a056a000cc600b0056d302823eamr54988078pfv.19.1667965464297;
        Tue, 08 Nov 2022 19:44:24 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:23 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 01/16] nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
Date: Wed,  9 Nov 2022 05:44:04 +0200
Message-Id: <20221109034420.1000086-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194425_794152_D4C9A2C8 
X-CRM114-Status: GOOD (  13.26  )
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

nvme_auth_[reset|free] operate on the controller while
__nvme_auth_[reset|free] operate on a chap struct (which maps to a queue
context). Rename it for clarity.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..d45333268fcf 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -654,7 +654,7 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
 	kfree_sensitive(chap->host_response);
 	chap->host_response = NULL;
@@ -676,9 +676,9 @@ static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 	memset(chap->c2, 0, sizeof(chap->c2));
 }
 
-static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	__nvme_auth_reset(chap);
+	nvme_auth_reset_dhchap(chap);
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
@@ -868,7 +868,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			flush_work(&chap->auth_work);
-			__nvme_auth_reset(chap);
+			nvme_auth_reset_dhchap(chap);
 			queue_work(nvme_wq, &chap->auth_work);
 			return 0;
 		}
@@ -928,7 +928,7 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		flush_work(&chap->auth_work);
-		__nvme_auth_reset(chap);
+		nvme_auth_reset_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
@@ -1002,7 +1002,7 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
 		list_del_init(&chap->entry);
 		flush_work(&chap->auth_work);
-		__nvme_auth_free(chap);
+		nvme_auth_free_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
-- 
2.34.1


