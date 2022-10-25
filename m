Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B45C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwMsktD4hq+FesGeBONU6Jsg5KeECHblj97iAJlMYTc=; b=wgct85FNaEwnHQ8mklfLPdJD40
	TUHDa2+FCV5n59jXXV7nRebxAd5g1idmrRqSBsG1furUua9aJyoLO71jLZs9GzrcEvYwJCTnEusCH
	KHeAbVOYMgwV3SoAmvYty9IsK9uRzXchBfmV6F6dcF7wOnUZDqCjRNrNxFE8Xyi9RHv2YGcSvunNj
	ZyamX3m0PCWGnQZk33bR5xUgqNHgrbbP0G51zCIXl6mYJRp/2n5MDivFLvHwAerZGp2yTIcj3DsBh
	SYorxNjtq5saKvGakDLftHahshAzJbZQe4feOEnhXcU53p+l5QeGGa6/XC+dBvDu5ZYpYEGO+Wc+t
	6wtzimcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDY-005Wfk-PD; Tue, 25 Oct 2022 13:43:44 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDS-005WdB-UP
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:40 +0000
Received: by mail-wr1-f53.google.com with SMTP id k8so12433400wrh.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwMsktD4hq+FesGeBONU6Jsg5KeECHblj97iAJlMYTc=;
        b=Voulj5NjcuaAsohu/KgA9OQAAW+TukiaiwBLeduX1WJwIRJahbfuArq1vuLH6vwf0J
         QY3R40bwPDUmGlWf8Wk/si3Wt56ZUN9mW7f3gmLWb/iarTqIgjm+i9vJqsxNqz0/Uwa6
         P8Z/EU0XIFWZIuwQC7M6Ws0sySYahpCZJEwlj5QOu6F7QijMKS1wrKQbZW1dD6o9R3bJ
         ZbuEqFb5LeFKYTwTiphGeL0lVBXVbLawEWpMcTJITCFk9XAHb8umus1aFmlaV0vkqR1Q
         UtKYBizSwoHctct4WsiLwu7dPL3TQkvSQcp89ge5dnoMMZzLoKwc6F5t4QbK3kfYcTlF
         IOSQ==
X-Gm-Message-State: ACrzQf0lkRYgiDxub9KYRJTqD4vYu0+WsWEI92gWAY4OMhXNMaHG3fgP
	AwhLHZ+jQOagro0WKHBBs7VWxCfT1ds=
X-Google-Smtp-Source: AMsMyM7KtKY53Lt2wp6MJeU7SBskLbriTBIPigeY4zntW0SPcDGukTjk/QqcOrCWU+WzDw4gbFXnSA==
X-Received: by 2002:a05:6000:80f:b0:234:6fe1:641a with SMTP id bt15-20020a056000080f00b002346fe1641amr20263964wrb.463.1666705416059;
        Tue, 25 Oct 2022 06:43:36 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
Date: Tue, 25 Oct 2022 16:43:25 +0300
Message-Id: <20221025134330.1028352-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064338_996496_C8C21B61 
X-CRM114-Status: GOOD (  13.37  )
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


