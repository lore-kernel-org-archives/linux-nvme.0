Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C82BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJTu/JCQSjjlWqidz1FUVhOS08fjv+3eUwu8sdq9JeI=; b=Tw4lXEV0LLZQN/Ubufj10bTkRI
	nbVYtKkCd4VasWhTTSy8XZpJW+ijAhaeITqW/pEl2uRX9OltR87drM7WsP+/eubQu5nqpmpes2AkP
	sgFI7F9k/cGCQ4iiBRbTnWmkvo6B6KR8uo6BtaAZN6Tl4LhvJqLYZFfuc8xX1+NKtJNyPs8vJEMoW
	bsOfhzdgK9H1PA97rGyZoKO6UK4lhxOrVaOqQIGmqchWVMM9cI4EzUiQdZA04jFRVlykaJoVwjrlL
	kPa7IIPCDrGWh/wznuoNHg/me3Gx1bcL9J4lpB+IvL83rUBhGIC8jlxfN2rmjMTM1L4TJ7CBQtQxH
	+TnlgOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXXE-00EDMR-8W; Mon, 14 Feb 2022 09:20:40 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKe-00EAJu-3h
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:41 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 d14-20020a05600c34ce00b0037bf4d14dc7so9706118wmq.3
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DJTu/JCQSjjlWqidz1FUVhOS08fjv+3eUwu8sdq9JeI=;
 b=yngDRAg6C97bMxzYgZ/Tmq9M6xJhjwAfPOZZdSXoKu6F+umT8P9HlxSfGPrMH/kK25
 e2K1ll9NAKRkEPUppA+UzgR7vK7mis1vXkyIOk+RMf/ratYemb6MUiCQclO+TezIEmYa
 zVuSnf314hvCalRwSSB1XQ61IeasboYMfSBmxU4D1AF2BtTi9zFPrxR4qg7ukv7GuSG7
 9+lBHb4BBvbBlRYlpd9CJw0fdV6XgM+3lAw7a7qMQZbP8kvd4HC7YF7Ga2DPbSBrhuRP
 K0bFSTrMrclT4D9vpPMJikuF6R9r9fGw002czsMSu/Hg7Y/E1w5BtAbuo43dQ1xuOWEK
 pH2Q==
X-Gm-Message-State: AOAM53328RtyhllBdapK5oK7eoNMENb2JUKb9KSQ0bCIItE5E0GN/r/b
 bhcsBe+eK4eCtFeElec/tSIs8kgrgyE=
X-Google-Smtp-Source: ABdhPJwWh18/O/YhJST7FbG5gThNOcr/bdcbXJitnBbWKblJS+u/btY7E+OCARHr7umNti1HkYdGIg==
X-Received: by 2002:a7b:c942:: with SMTP id i2mr10470290wml.113.1644829657898; 
 Mon, 14 Feb 2022 01:07:37 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:37 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 4/7] nvmet: replace ida_simple[get|remove] with the simler
 ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:29 +0200
Message-Id: <20220214090732.479193-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010740_207393_24BB45A7 
X-CRM114-Status: GOOD (  13.23  )
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
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..724a6d373340 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1400,7 +1400,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (subsys->cntlid_min > subsys->cntlid_max)
 		goto out_free_sqs;
 
-	ret = ida_simple_get(&cntlid_ida,
+	ret = ida_alloc_range(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
@@ -1459,7 +1459,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	ida_free(&cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
-- 
2.30.2


