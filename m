Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119E4C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/DPfgumOzvAxRr7e1hpfOXa35M9RzhGDN6X58ePi36g=; b=sLZc+xFKadKS9vhfl8MJAhexD5
	TxPYd4rT8i9g8n2Py86ix0rYkqD8jhTcQ/Yup2Jhy2LEd7GBteJmRMo4QTVwpsUNxnGULCj4JMf1Y
	I62t+N2ZlPbT3r+UIDGhum3xsLY7cS0eJSNBwfL5lUKjAxZYUfpflw6oNZmO5LA0Xv88SAyqBVaLY
	m8U49LG/VZDevEfpN5U9aIHuqul84QnR7vM0ukVYAAliRnrUTwY3JTPbmE0tbUV7pfjOo0JRmDKvK
	f+s9hvWssFuFFV5Xp6ZqqJm07MvST0/9Mm8ATnr6dwjfGALZfvVHB0798GCR/R47Lphy7DFk2Rrey
	7rpyEftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB8X-00B7Pn-4g; Sun, 13 Nov 2022 11:26:53 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6R-00B6Ms-AW
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:44 +0000
Received: by mail-wr1-f53.google.com with SMTP id o4so12409434wrq.6
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DPfgumOzvAxRr7e1hpfOXa35M9RzhGDN6X58ePi36g=;
        b=kXVVMJ2kK4xT1z1tBfwVssKxWreJ/mbsfhtoRm7CdHbxVVz2A7XFp70l7359F75QEU
         MwEBHcA9n4hOk16hz32TlhxLvpVGSS9QGLxbeeMZZXHAIZYGfA2PR9+2q4VNlVNVXrHQ
         MdiKcpuLF4hBWLyTTT8x8Jqo36zzr4mExC/6rgR/8ISM/E/KIG4san/1ryCO2mhrmgA0
         nBHtgGw41CvstttkjMYgjCOVKkhKjnm4iIwcvezZc5vOMRd8zBSPEh++x63bXiMgrhwu
         o7cCcXRVa5WyDYoQN7t8i5A7h2buSl5S0inVUPStVRCImjiv+MlicRjC7jWIhZfMwwkR
         UBhw==
X-Gm-Message-State: ANoB5pmzJQNvws/Jxl/UfXakVKi7HTZfRklThDJJFeCLHQniOu/3a7dr
	fjj/ThBVjbdUECSNGD+m+OiAoGDH184=
X-Google-Smtp-Source: AA0mqf7OLSopEABDXzh9iqKmOFTgHTeV4m4FDiqPRAwGGPYojCToh1sVmY2KLhjn02XQDsV04XVerA==
X-Received: by 2002:a5d:6e8b:0:b0:22e:3610:1b3e with SMTP id k11-20020a5d6e8b000000b0022e36101b3emr5074649wrz.429.1668338682627;
        Sun, 13 Nov 2022 03:24:42 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:42 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 13/20] nvme-auth: no need to reset chap contexts on re-authentication
Date: Sun, 13 Nov 2022 13:24:17 +0200
Message-Id: <20221113112424.1049834-14-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032443_382184_97D64B4A 
X-CRM114-Status: GOOD (  12.55  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 13 -------------
 drivers/nvme/host/core.c |  4 ----
 drivers/nvme/host/nvme.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b1f9883ef8e5..a502e159e14e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -899,19 +899,6 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
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
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b75e8433c3b2..140e8ca0858a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3756,8 +3756,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		host_key = ctrl->host_key;
 		ctrl->host_key = key;
 		nvme_auth_free_key(host_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
@@ -3810,8 +3808,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl_key = ctrl->ctrl_key;
 		ctrl->ctrl_key = key;
 		nvme_auth_free_key(ctrl_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e8eff9edf7f5..136582c80ee8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1025,7 +1025,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
-void nvme_auth_reset(struct nvme_ctrl *ctrl);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
 int __init nvme_init_auth(void)
-- 
2.34.1


