Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9600C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZ+V7/fRPe3ui4JFtdLwuaB7uMhPYODLGW0sD52NKtA=; b=10T7DPcdBzNStiU6m6BhaDQCFL
	wKyH6kNxpQXaLke5MxIErYU6IKJLuKjomKkwyueXQtDppeBNkhIgzui8dhi60sKrVdllCU4qwNcC0
	7YuN2933Q+wbHi9+c54QSlbs9L4fjueKgrb1JiATI6QbblE4JW51KRRaYNjPR0CrBnU2QV6abDjoK
	KP6p1N0iLR1KoL+BgDa1RYnS5OWsMXduWapK4PVyxMpByZsb0CK37A9MPL/gbPoL7QTCyhOKlGAnw
	IYdHzOUFiE4zPWqeTt9nEKbEnigoBlJ7Ay/BiqLsR5TFFchE7b1SNSA+vSdFbR9s+xT90ZnrOmnCp
	q9AKirtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXYl-00EDaR-4M; Mon, 14 Feb 2022 09:22:15 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKe-00EAKX-P1
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:42 +0000
Received: by mail-wr1-f42.google.com with SMTP id k1so25632724wrd.8
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HZ+V7/fRPe3ui4JFtdLwuaB7uMhPYODLGW0sD52NKtA=;
 b=zAykRTpzonss6EWZLYlL7nZeONwa7hc3MnebYjD6SWzv6twXfLa0T92CTyNp7i2ZDx
 TjPa8YfGvg907/DQYNo8l+tqUOp1rHIlRtZDY7D6Pw2wK85UBKtvUhwbX5QSaOIZ+1bE
 36T4Xh/qWdCsru26I+PZofHaX3hb82ndubvGKiVbuyqBWJmRwWVNdZXgmSQW0h3iv8/u
 W+yXReYrhfheOBubvTGJvc+ktizCntK7avp/ZXdhEemseGeK2aXVMba6CC9O7F4okCdA
 Ou5cAiLZm9qiZ/Sy5LVjsPDP1m7X0LijuYuyBxBJbnqyIAd600htzZ4tcnDtDPiaWJLd
 cj6Q==
X-Gm-Message-State: AOAM5309nzE+EpeumhPI7doS1D2AXLGSEVb7fhKNYLYSoNyYt+afYy+B
 Uc/Gs4zpB52GLZD7+fHH5V2jTjtYYH4=
X-Google-Smtp-Source: ABdhPJz41paBubngauSQdXEModuNcqpxjuYXvleRIjyLKCpE8xPRMCmLggVVz+/Fb3nMMRSkZmcPqg==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr10357815wrf.519.1644829658838; 
 Mon, 14 Feb 2022 01:07:38 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:38 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 5/7] nvmet-fc: replace ida_simple[get|remove] with the simler
 ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:30 +0200
Message-Id: <20220214090732.479193-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010740_852473_6C9C5528 
X-CRM114-Status: GOOD (  12.29  )
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

ida_simple_[get|remove] are wrappers anyways.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/fc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 22b5108168a6..cb013516784c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1115,7 +1115,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (!assoc)
 		return NULL;
 
-	idx = ida_simple_get(&tgtport->assoc_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&tgtport->assoc_cnt, GFP_KERNEL);
 	if (idx < 0)
 		goto out_free_assoc;
 
@@ -1157,7 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 out_put:
 	nvmet_fc_tgtport_put(tgtport);
 out_ida:
-	ida_simple_remove(&tgtport->assoc_cnt, idx);
+	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
 	kfree(assoc);
 	return NULL;
@@ -1183,7 +1183,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* if pending Rcv Disconnect Association LS, send rsp now */
 	if (oldls)
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
-	ida_simple_remove(&tgtport->assoc_cnt, assoc->a_id);
+	ida_free(&tgtport->assoc_cnt, assoc->a_id);
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
@@ -1383,7 +1383,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 		goto out_regtgt_failed;
 	}
 
-	idx = ida_simple_get(&nvmet_fc_tgtport_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvmet_fc_tgtport_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_fail_kfree;
@@ -1433,7 +1433,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 out_free_newrec:
 	put_device(dev);
 out_ida_put:
-	ida_simple_remove(&nvmet_fc_tgtport_cnt, idx);
+	ida_free(&nvmet_fc_tgtport_cnt, idx);
 out_fail_kfree:
 	kfree(newrec);
 out_regtgt_failed:
@@ -1460,7 +1460,7 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	/* let the LLDD know we've finished tearing it down */
 	tgtport->ops->targetport_delete(&tgtport->fc_target_port);
 
-	ida_simple_remove(&nvmet_fc_tgtport_cnt,
+	ida_free(&nvmet_fc_tgtport_cnt,
 			tgtport->fc_target_port.port_num);
 
 	ida_destroy(&tgtport->assoc_cnt);
-- 
2.30.2


