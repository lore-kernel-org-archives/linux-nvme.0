Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FDAC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mX0bHl6mbw9MFfqkIfCDSeyRKsyySrZ1jBnxtWddAYA=; b=BSLxmPYwc13Z3eQ5rDRtFZHdo3
	csNyUP53yWYKNADm6MvXd/z7YNdCcESLg7UDkyQS/1rzgxP7lnfyhynjVSl1IQXasfbTqpWAETWjV
	7eSmg9Qss4Y65gJl+7OcYZRbe02v//y2XK6dY54usXC9IadZHiYagISNV+n72WxJNAgaLXkDSUCcw
	34lVWG/BMphVwgRzDsG2e54+mDbRFcTuCkogdR0DaDmr/bj6+LYFNCnawvbZf65As0fhcNkJ67ueD
	kvul0adTD0b9HQuT3wOBmf18QuMdE75k0M2dvn43VkYzNn1+226E4exnDh9cIqhT9pOD1LhACtL+P
	1YM0TTMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc2v-00APBq-Pv; Wed, 09 Nov 2022 03:46:37 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc11-00AONF-5A
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:40 +0000
Received: by mail-pl1-f175.google.com with SMTP id p12so10445170plq.4
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX0bHl6mbw9MFfqkIfCDSeyRKsyySrZ1jBnxtWddAYA=;
        b=XotxP81eACmAHKCW1lOjbfGnQAqa1mWyb+5mEODdZ3EuckbnTE2lM9WEtVVi+pGJhn
         yBm95uA3U85CyWS1i4KDHNMOqJHQ0fGOuEBmtjYXHwTRzL8QOy1h+oKuAAA9HcEuJSsf
         urw1X8xg0iYjB+yy1X7ck6jLjuHBdRLIx2Cml+zT7xWcH/fHNqjeR/YOwS1RrEONm9xi
         KtVPT4Sz2lgpmB2hkPeDFSJxxmYyjwpWrRMG0TpelGWEJ/omq0Pt/PhDVIQBDBPwMx09
         w7a3w945EpJYN148VS+iRNnXgw+CvLDuhEjeDJAlAs7ojFV2Zeio0Y1h45g2/BruOuYc
         9SKA==
X-Gm-Message-State: ACrzQf2eAitfgveK4yG8YXJfYuxkEOLdpkYZKsX2xfweJWIHQDebsRxm
	UHUckb1YBKToOAQuOlFOuxBa+3Hw9V7bIXtW
X-Google-Smtp-Source: AMsMyM6bjjjl+KOPVTbV2Hvdg8P4s+eNNVAO/4U4WVpoYRWA3SkJvQ0Z4r90hFuRtKR3r204gCgTqA==
X-Received: by 2002:a17:902:7688:b0:187:403c:7a2b with SMTP id m8-20020a170902768800b00187403c7a2bmr40071605pll.85.1667965477796;
        Tue, 08 Nov 2022 19:44:37 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:37 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 11/16] nvme-auth: no need to reset chap contexts on re-authentication
Date: Wed,  9 Nov 2022 05:44:14 +0200
Message-Id: <20221109034420.1000086-12-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194439_209852_634A04A8 
X-CRM114-Status: GOOD (  12.52  )
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

Now that the chap context is reset upon completion, this is no longer
needed. Also remove nvme_auth_reset as no callers are left.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 13 -------------
 drivers/nvme/host/core.c |  4 ----
 drivers/nvme/host/nvme.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9218f50d8be3..23d486284da9 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -897,19 +897,6 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
-void nvme_auth_reset(struct nvme_ctrl *ctrl)
-{
-	struct nvme_dhchap_queue_context *chap;
-
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		flush_work(&chap->auth_work);
-		nvme_auth_reset_dhchap(chap);
-	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
-}
-
 static void nvme_dhchap_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4aa855a4839a..c15dbbe509f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3757,8 +3757,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		host_key = ctrl->host_key;
 		ctrl->host_key = key;
 		nvme_auth_free_key(host_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
@@ -3811,8 +3809,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl_key = ctrl->ctrl_key;
 		ctrl->ctrl_key = key;
 		nvme_auth_free_key(ctrl_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc314f45ddee..f9708825aa24 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1023,7 +1023,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
-void nvme_auth_reset(struct nvme_ctrl *ctrl);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
 static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
-- 
2.34.1


