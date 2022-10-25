Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2950C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PtcH4S9J1OUbQZmlWl4X07tF3BN0peDsOXhWBnW9VU=; b=NmekHAhY48zm2nzA35Qjn4XKBO
	RiZtkxp7SiXOO+sRGLhtbrqgKpMiVLCddo5kZ8NPEfTNdnN6XSN49CAC0XBvGxwmXWObA2BoenBIC
	lPQBqtyIabk5N9DywOZUMD6R9tTXx91jtI6TBh/X/YtU1j8WVITm75qVxhA6DBXOPDGQpHefi6FI9
	9EszqLw3gtS+zt9ihlqOsyz6/85MxmfdIT9s4nSIt8DMU5SBzPKavGLvKQTOsD8YYC0NOKhcDe85g
	C917grBVcvReNUlhDx4XlVz1Lki3FkjeAP7bWWnPXr2IdCQe+cMm0FJUo4kdy+86CKHe3fW4X9Gkv
	pyZ+TgVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDt-005WmF-Fm; Tue, 25 Oct 2022 13:44:05 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDX-005Wf2-RS
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:45 +0000
Received: by mail-wr1-f53.google.com with SMTP id g12so8305017wrs.10
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PtcH4S9J1OUbQZmlWl4X07tF3BN0peDsOXhWBnW9VU=;
        b=ndYNOOwNpKP2CX1r9jUZWFnm+awPuSlOdY1cs6884LGUIcrllWQAHsnsuO5UxP8rMU
         P+5q2ryz4earUyyQ3fPtZeJlM5pjrHXcI0Fp+c5NeLIUj3udANxUWwYcXHwdB6XbKTp+
         9bZlT+dTjF7oRmLecOuFIL7d1FrDKqAzbKSWh+h98Vj6RNlzT4ri4p4aXzWzuG4FRn4d
         uNTyrMmcIsU3X1Qm+BM0ChF3IEmWPBvgcNmHoz81ReZOleeVBqbGwh3Tm/oGcOInZ4uW
         sxqqawzHDnP8PmhK6xIslw8+cxaR7qJDVXR8wcSjuYsLbJ3iEBJw2D1cApcXTOymeGDj
         jnIQ==
X-Gm-Message-State: ACrzQf3ks4nFfembWK/RAJSlgk9R1CWI1do6BCjfchLdRI347QgQz4/8
	XF/WI51X0Dpl7v8GJpC9jz+nScCFD0U=
X-Google-Smtp-Source: AMsMyM6MmuomVAyjboojp6eoc4EtKhK/wA7N6yJtctAltcyNO0jwTzFX5aafB17/Vw5nepowUYSi5g==
X-Received: by 2002:a5d:5983:0:b0:236:7a7e:e62e with SMTP id n3-20020a5d5983000000b002367a7ee62emr4528711wri.38.1666705422417;
        Tue, 25 Oct 2022 06:43:42 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] nvme-auth: don't ignore key generation failures when initializing ctrl keys
Date: Tue, 25 Oct 2022 16:43:29 +0300
Message-Id: <20221025134330.1028352-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064343_912135_F8B4C7C2 
X-CRM114-Status: GOOD (  14.51  )
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
index b92da6155773..9b0b11191ed9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5088,9 +5088,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
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
index d250efe93c8d..8d9973b00547 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1032,7 +1032,7 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 }
 
 #ifdef CONFIG_NVME_AUTH
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
-- 
2.34.1


