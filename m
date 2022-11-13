Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009CCC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YOXcZCiy4is5MlgZlEUcU/nzaCAhwfGos+3KqS1o4iQ=; b=uZay8yVgUgtKR2YcdrECpGmXqO
	n5n/mKtNxGUwC/K/rHXl9vsaEUqJOeDTMGSB6HJHTIHZToXR7hPFZCersRfiipEDZ9aJCXOtZg9V8
	vC1T4wTCFwzMZxbSV8XxC3fwovstl5j2RIQywod0JZWD3LaniztnIFQxBEBkcxMscdXREIfSOIyQP
	M2P83TaL8fnRasFA2Cxkf7rdnxyUlKNxF8mGq7yXPt8/pXadv2NwGmSNoiR1BB9qdFzzGSWleUiI5
	U9P3rZ/XaXlKV6K1s55+hxrkqtqv0bKbZ+okP1s9F3z8v23CHx6rQsJcW42012+Kie06KADgeIfDA
	gpspJK6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6O-00B6R2-Ry; Sun, 13 Nov 2022 11:24:40 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6E-00B6MG-KF
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:31 +0000
Received: by mail-wr1-f42.google.com with SMTP id a14so12408125wru.5
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOXcZCiy4is5MlgZlEUcU/nzaCAhwfGos+3KqS1o4iQ=;
        b=FY1LVHz2ivbIwZZuGTRB2iESZgi+NYNfgGKK65wjqFh5viiTac3KPcb3ZuJUt+fK+f
         68R14ZHtwv5kthDSGFC9Dk+AHdqRlUk0qDgN7WGAn5hD1yZhCe8XamJsMdm3jQz33Z5o
         NAqM4ACVVXtjjb3Hi9DBT5GJ8Pmsws7wFwfGvSb/jfhML7GPDu/5m4zpQYbQKDVcyH35
         t1Agsj3cuEo+ksD5NVfdXxdEecHDOjkwCsnGu/aNSNLPUvz9IxzIX+7XXa8hWoyFQcKO
         BubzwsOR3L7Au9vTT8vhPmJciEmdKBcha2XAE9yCNZ977HnMptP+9Kl5d02BDlLue0G3
         KAcw==
X-Gm-Message-State: ANoB5pnVqofN+qi0xs0AVDEfxEz3B3Az5uiCysXXJWZtQVBNH7V5i2xr
	QvGhmpciiBgLYGOmzV+K8bqa0McvlC4=
X-Google-Smtp-Source: AA0mqf70byAB/5lP4LY6ComrEKNHcRkv/MMgtfXA9+Bqr5RYao9SmuNIofQphiA6g73ZLoXwsieSIg==
X-Received: by 2002:a05:6000:47:b0:236:6dca:2582 with SMTP id k7-20020a056000004700b002366dca2582mr4883743wrx.105.1668338669296;
        Sun, 13 Nov 2022 03:24:29 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:28 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 02/20] nvme-auth: rename authentication work elements
Date: Sun, 13 Nov 2022 13:24:06 +0200
Message-Id: <20221113112424.1049834-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032430_678235_AAEC0A11 
X-CRM114-Status: GOOD (  11.72  )
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

Use nvme_ctrl_auth_work and nvme_queue_auth_work for better
readability.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d45333268fcf..e3e801e2b78d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -691,7 +691,7 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 	kfree(chap);
 }
 
-static void __nvme_auth_work(struct work_struct *work)
+static void nvme_queue_auth_work(struct work_struct *work)
 {
 	struct nvme_dhchap_queue_context *chap =
 		container_of(work, struct nvme_dhchap_queue_context, auth_work);
@@ -893,7 +893,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		return -ENOMEM;
 	}
 
-	INIT_WORK(&chap->auth_work, __nvme_auth_work);
+	INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	list_add(&chap->entry, &ctrl->dhchap_auth_list);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	queue_work(nvme_wq, &chap->auth_work);
@@ -934,7 +934,7 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_reset);
 
-static void nvme_dhchap_auth_work(struct work_struct *work)
+static void nvme_ctrl_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
@@ -973,7 +973,7 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
-	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
+	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	if (!ctrl->opts)
 		return;
-- 
2.34.1


