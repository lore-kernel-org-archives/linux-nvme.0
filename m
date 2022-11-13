Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E2C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vV/2r3cnMFHABiAAK93Om7H2XPrnnAw7u2TbiEcBlyU=; b=qH+AkVkree7evGk2/QGgXuBRvs
	Do8UX+BUO7nZ0RYrhhNJcNvpFqAjbzaITNArBS/7RuI/ZQ5JKpi/Eex8AM2OCl2CJ+61i13ihIcma
	LcYyxMB+5NVZVVUxvSUmrQ42hQ7z8oo0p9wplyPXmvmHzqoGWj4W3fXlKm8R84lzH2T6GwKAyxxWE
	EWAlctt2FxU9oVGt4fPivb/u68hWYMOQBixrPdh76geXIX/KBSxABlM6LBZcpVQFyf4bNWGOJdNdW
	eFXgcSs41Fd/MW825IMYquHTwbdB2J7dHeSbIcOTP0Oc/EBMlo2rQpOvVJ4EP9LXvcuo6Nn2hgnEC
	AcjCdvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6l-00B6br-Qr; Sun, 13 Nov 2022 11:25:03 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6J-00B6O0-F3
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:36 +0000
Received: by mail-wr1-f41.google.com with SMTP id cl5so12388757wrb.9
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV/2r3cnMFHABiAAK93Om7H2XPrnnAw7u2TbiEcBlyU=;
        b=oX9C+m3DMhfwjmOTm9cWuCtZRo7r2mOHlqwpn76bK+5NTCop/z2c9aMVAqbyLiVkle
         i+xUi+T1R98d7q/GvmUqrdNqVW3QSfODZwujFiHgel45K3IWCP1zT16zG64BBG+lVsOo
         gcxVYaPxrDIp/thFAXqBW5CNCD+PRgsoTwQy2qbJuGVSaq4QmtcaZM3/pw1/SlNFmroy
         HjdpUJGjxEn0IMgcJ1u/+kpgCSs22pOoDJYRNVJ+QiLVoEw2paCSSix+k5osO2yR5h72
         gsWA3DAH7Z7/fKD9RDf1xWi31lUlN3phag3ISaUp1q/PbPFs00AKEOUr/CDivf8NcSh7
         8lWg==
X-Gm-Message-State: ANoB5pmu7HxMRgTs2AtQxOIpUyobSRoeoQAiQHmWjPA0zXwjzxgyxEDJ
	GedFQs27Ts7PnCHUGxQ7jqdPvLy1d/w=
X-Google-Smtp-Source: AA0mqf5Lqb/xNNrY5KFee9UpTaZIOkTRxukDCvJ1B09zhxsGriVJfx3PX7xwhRokfnIoK34vYQ8L2g==
X-Received: by 2002:a5d:5225:0:b0:23a:2311:b72 with SMTP id i5-20020a5d5225000000b0023a23110b72mr4955114wra.147.1668338674090;
        Sun, 13 Nov 2022 03:24:34 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:33 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 06/20] nvme-auth: don't ignore key generation failures when initializing ctrl keys
Date: Sun, 13 Nov 2022 13:24:10 +0200
Message-Id: <20221113112424.1049834-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032435_516239_3C1A77F0 
X-CRM114-Status: GOOD (  14.01  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 19 +++++++++++++++----
 drivers/nvme/host/core.c |  6 +++++-
 drivers/nvme/host/nvme.h |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 0d0542e33484..d62862ef5b3f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -972,15 +972,26 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 	 */
 }
 
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
+	int ret;
+
 	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
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
index da55ce45ac70..1f3513938f94 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5077,9 +5077,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
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


