Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E2EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:30:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE3364F0C
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE3364F0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DJ/QJfQSFrQbs66pOW7morXn2u8prJcQvf7nLS18JKA=; b=NOixw4djcu8zdcEhT4jZc9+75
	rS7Gu2M9/vOhQ2ZZQmFB2zU1B8Mxxoz3v0o7cG02wUGQ6duqbVbYiYNtApN83pbUuk9NFXYj8PBFL
	sfVHrIvSezs5cJE+hL01JW6HdVgmKgldQxBH/mK0GsXBoGscn8dQN2Mm5ULqBqStw9s+LJ9uMGcAZ
	UDBDEg3vDeLZdVMW2F8/SAbXv2oLS58x7Y15YFGGt8244wGrGtMm/8iWnpzKtx7JzbXdSlJDPuh+e
	r8tkaGWoYfpa4ws7xUmjyAfggheTKk3hEbYic118tIhvsBiHRzeAdDVhI/ytWoWfFHUySD9jy78lo
	FlbkCW+Cg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLviz-00H1zp-8T; Mon, 15 Mar 2021 22:30:14 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLvgE-00H1ob-Mz
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 22:27:29 +0000
Received: by mail-pf1-f176.google.com with SMTP id y13so7519176pfr.0
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 15:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lvP0/uOO6YnFeOLqzQouWL90AcBf+4SO5cUneGOd1fI=;
 b=PluRCqLPJMKItTMfQ1vabdbEt58/MK+oRjWpBkKWVS5HVjixbGFB8JdfgFY0h14rlz
 XuWGazeVtvB8mk20D+5jxgXlnpKttdehCjf+Ik9bjs1ecjSxsMHp/Sc3TYBeHVCQ4g7e
 Py9rdDgBTjuJUsiXKmf4GD8eVUAkQ5xj5FhL08a7UVS1S+ZHr6wBR4BcKwv2E+g1+DCd
 eUFeQy2x3UPzp5Iny1mXfgDz51OvQaKiecwjmrF66WBkfFRxNUppZji6ZDIDNhJpFVPI
 Pr9vDQbpPlI9MbFndOqiss4up8GIkYOLPzwVvSJJ/1ArnG21HObAXB20z4Pm8QGgNWkh
 d2GQ==
X-Gm-Message-State: AOAM531dIJol/SBt4+y9V+HLBT2tprKGywVEWLaSttfidkSeetc8K9qW
 9xex6TU+RlZihInLhuxUcFVN7jGv+fE=
X-Google-Smtp-Source: ABdhPJymOqOqpVlbompjqroZ3MBL26B6sr/3u1tq6KOov/XKoRuPkuJPGDWVacm2S/LLDmpPgxyJ9A==
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr12091622pfy.15.1615847236942; 
 Mon, 15 Mar 2021 15:27:16 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id r16sm14614526pfq.211.2021.03.15.15.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 15:27:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 1/3] nvme: introduce nvme_ctrl_is_mpath helper
Date: Mon, 15 Mar 2021 15:27:12 -0700
Message-Id: <20210315222714.378417-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315222714.378417-1-sagi@grimberg.me>
References: <20210315222714.378417-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_222727_891366_A927697A 
X-CRM114-Status: GOOD (  13.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Given that our error recovery and I/O failover logic semantics is
different for multipath vs. non-multipath controllers, transports
need a helper to distinguish how to react upon error recovery
or controller resets (i.e. fail I/O or to keep the queue
frozen/quiesced).

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
[sagi: added the fixes tag so this can also go to stable with its respective
fixes]
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c |  5 +++--
 drivers/nvme/host/nvme.h      | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..5c67a5e96738 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -8,10 +8,11 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
-static bool multipath = true;
+bool multipath = true;
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
+EXPORT_SYMBOL_GPL(multipath);
 
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
@@ -372,7 +373,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing data could
 	 * change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
+	if (!nvme_ctrl_is_mpath(ctrl))
 		return 0;
 
 	q = blk_alloc_queue(ctrl->numa_node);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..4f7c9970e3fc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -840,4 +840,19 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
 
+extern bool multipath;
+#ifdef CONFIG_NVME_MULTIPATH
+static inline bool nvme_ctrl_is_mpath(struct nvme_ctrl *ctrl)
+{
+	return !(!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath);
+
+}
+#else
+static inline bool nvme_ctrl_is_mpath(struct nvme_ctrl *ctrl)
+{
+	return false;
+
+}
+#endif
+
 #endif /* _NVME_H */
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
