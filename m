Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DCFC433E3
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220C12086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CjZV2bCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220C12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tgVSuVxZth//iRFHovs0MRlPdSRmRmg+E/JOUN9HoU=; b=CjZV2bCOe4JgcZXsvkV2BLe6le
	ZtnZ5ZJNEEJckBobZZVnevPOeN2SHtBYNGAzYLRVtdL2kJTGa5W9d3vOkRdotB6TvsKjfXbuiMLTK
	DhMQLrdiDBoCkhw+DvLVFFUtCI0H6FAx9XQNSP49IPqSOatvSSujFiBsmedzfxx+KHELgKPgZR/Hp
	RSyrKgnxbCIMM7goKoq+XVbcAPSULkoINgpWvkCupC+KLnb8+AoILxqm8uk7dAeOBXAyIefMCfBIw
	kwP2r1jfJZ+d2TgatTG1RJJfrSjAZSqdIgnJ7sTpDxKjxDbfx2ROJ2Yrx63yUbmB3gHfHiuH6eB5r
	moPIo3qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIi-0008Bg-Gk; Thu, 06 Aug 2020 19:11:40 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIe-00088s-3a
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:37 +0000
Received: by mail-pj1-f67.google.com with SMTP id c10so5124575pjn.1
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7lOx1NKUjyA48c1HJ6UMtfILsFPQ7TUxKxaSnBY6Rjo=;
 b=pt8Sc3/5Sj/ecMwwYG90szI21UD0iHXWeFi+5KGWLT6eLcPb49Hld8iAOs2xeMNFe8
 CUQOmrFRxeBe+G+9bjG+//saC9TYiHffCOImGqdkp6+U0IJz7+HaRS8tADcX+t+ahXYX
 zvWq6irL/ANc6UpfZ/7KlApdN2J01JAf1Vhy7FJMkH6OqR9I5qniS5jmng4TLmyFAbek
 pWqcjpCnL7JIb6TtiPRj8PfSIi7N+6xXYUS5WbpZvwklATVS93iFJit/FgG6kD8ZxAp6
 FtChl7I9T42MLjgLc4k8HjjOag6XWkoK53JPLn6nYM31zefhgIik8wlZR4pPq7JljYm6
 Dg/A==
X-Gm-Message-State: AOAM533h/b/ZfyToqzMYpQi819Lfj/WcP17Eg0Py/71sIezcfSukv3PA
 3tKirTs6hrLnUf09bA8C1ThGlLxB
X-Google-Smtp-Source: ABdhPJzByBjRwWthNI6J8K3deA41uyE+Lv410wgJGxVd0dZ0GQiPuVu2mibEMN/5xqBu5wu7PM1TgQ==
X-Received: by 2002:a17:90a:9e7:: with SMTP id 94mr9434802pjo.97.1596741093087; 
 Thu, 06 Aug 2020 12:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:32 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 2/8] nvme: have nvme_wait_freeze_timeout return if it timed
 out
Date: Thu,  6 Aug 2020 12:11:21 -0700
Message-Id: <20200806191127.592062-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151136_182129_62AEAA15 
X-CRM114-Status: GOOD (  13.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

users can detect if the wait has completed or not

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e8cc728dee46..fd99ec0118a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4519,7 +4519,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
@@ -4530,6 +4530,7 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
+	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c5c1bac797aa..e82744de3cd3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -574,7 +574,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
