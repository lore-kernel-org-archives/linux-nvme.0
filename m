Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C782DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4yn8emLfREk1COy4AE3WZFZcfzWUQE+Lx9dVhnXUZMM=; b=g9pOAya41agYKUMbJKK/tGcx0E
	YlZ+g4YWJJxmirT++Fk4WpNd/4iyg3zd9dHIFc6Ltxcq3pq2w9VlroBRLGCVRHxrFx7x2GYpuEEW6
	PxBDNiUzWJAHiCToIBUX0ie01HskCyFDS7nsvTbaZVOKW1XYlgppehaRG9zmAtnCzuW5Vp/BsSM7w
	Q+tNM62E5kUY7wkeNJ94FoPs7t34TrtDdYdXNcSYf+KkJ8D5Jt+s16FDzrLSkbWwBdOu07grzzFY3
	N9zq1+MsmN2BYXMyBGpB9C3YWmY5SCSaiufnErYu960WXQyvT903oSSvGLgjg7ZV4ti9kqgYtcVC3
	bWFl43iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1b-00AOd0-He; Wed, 09 Nov 2022 03:45:15 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0s-00AOIZ-Hj
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:31 +0000
Received: by mail-pj1-f41.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso719203pjc.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yn8emLfREk1COy4AE3WZFZcfzWUQE+Lx9dVhnXUZMM=;
        b=Fo96ayyQPAOGCeG/PJRRLFnTLYR3AMQMyDgda/Unu0ZwQox0gPje51PAa9106KDMLC
         OIe6kfbiEviW3aqXZiFxbMzMBT5l/VyEt66XtdJWcE8V6yk9Cuzw4mNlwq8nIpkTMvMr
         AQ3+GjK8iKXfYCW6/XB8ptCDE4U3QzsmrJi7i6isM7LJbqXpUYX/Ynvd3Sw/RZp9+O14
         uG3gHRdlUoqT07YsCgCIPdSsSAOhzQ1bClqrp5kxzVSfOQykXk3ojFQ89kvoL9x5IqLv
         ZPlmFviBuJkhtDnyyZX5LAdeflxXgvRp0tVTmmgzYnvc4V7Cowmf+LNusP732E6mH9Ch
         BkEA==
X-Gm-Message-State: ACrzQf1fOHJwITP+4Stuf4oVm+Pk2mxev+fgBHLbo03er/I+zWX3Upwk
	rVibduhSDOgw1wiWyMU540pDInGmR5W+oHDN
X-Google-Smtp-Source: AMsMyM5HsJIQlvXsAOOhHnyBun2fkcFwThy5weRGIX23aXVQRVidhZgppkmGfGmmrBBY8YcQMR/GRw==
X-Received: by 2002:a17:902:b083:b0:187:146c:3170 with SMTP id p3-20020a170902b08300b00187146c3170mr54391067plr.112.1667965469878;
        Tue, 08 Nov 2022 19:44:29 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:29 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 05/16] nvme-auth: don't ignore key generation failures when initializing ctrl keys
Date: Wed,  9 Nov 2022 05:44:08 +0200
Message-Id: <20221109034420.1000086-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194430_600654_553A5E62 
X-CRM114-Status: GOOD (  14.33  )
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

nvme_auth_generate_key can fail, don't ignore it upon initialization.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 19 +++++++++++++++----
 drivers/nvme/host/core.c |  6 +++++-
 drivers/nvme/host/nvme.h |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 15cddc2bb14d..a6312a8846f8 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -972,15 +972,26 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 	 */
 }
 
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
+	int ret;
+
 	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	if (!ctrl->opts)
-		return;
-	nvme_auth_generate_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
-	nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key);
+		return 0;
+	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
+			&ctrl->host_key);
+	if (ret)
+		return ret;
+	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
+			&ctrl->ctrl_key);
+	if (ret) {
+		nvme_auth_free_key(ctrl->host_key);
+		ctrl->host_key = NULL;
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc4220600585..09f2b44fe771 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5078,9 +5078,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	nvme_auth_init_ctrl(ctrl);
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		goto out_free_cdev;
 
 	return 0;
+out_free_cdev:
+	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..cc314f45ddee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1019,7 +1019,7 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 }
 
 #ifdef CONFIG_NVME_AUTH
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
-- 
2.34.1


