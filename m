Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FAC38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF89420836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTlp8RMx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiNM13uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF89420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7HyMhgzeCZDBKGdsR3uDf1oYZ/XPjgaL5HmjTeDMzr0=; b=jTlp8RMxjf2yrJENGYVMbN+Uf/
	FVFgiP03OOmMhe3gAD0lmb0vaLCQ2KzsLRN1Pb5cRMF/2hJfG5r+7dHDpCBPRIrWb7UnS+lbYK3Kl
	mT4nXqp30jmUbyv1wXmiKyMdFTIK9HNu9rUyoBQWnMm9CFx5Nwlhwbvya7Q36p6Ng3lB/k9hagxas
	BDw1U30AkJAp2tVEgS/PYkTEIGYMIht+n8Yr20m9JGMWDQoaMMwoy9La2dOXZOuEEp3kOllvXeqUi
	bn3Bc+bOTt35lfCrfzBKdqnISc4jKL8ButBGZPdPNpeRyjFKeAaN9C4pJq5io8NGFjvEcjUkjKG+m
	Gz+DAZAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6InK-0007a7-B2; Mon, 24 Feb 2020 18:49:30 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6In2-0007FG-Pq
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:14 +0000
Received: by mail-wr1-x442.google.com with SMTP id m16so11621447wrx.11
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nq3pVT0n31P0HNjyqI7S+6BiEoQ7qBGuBzgDGWdgNEs=;
 b=UiNM13uU+K9HsLUXjKc6+oBQnfsUwAiibswCIFLtazS8uCzc8FJzY9hzxeogD5Lvts
 csYLxvGNDXZN+nAlB5RDamZkB+TpGYYmN6v7rJTYwt20suFRGoffckPHtnECgROgdNMp
 caLfPzCkW0LMJwVlZ98wq0m+QTg44vI9DQWoz46edvtBuTwWirmNfQlx4OuwTr+XlvLz
 swsuIfUoTPhKekKXzD29KeLCzwDVwL7Mc0LZ7q9XzF2d063C4TolXhp60VZnNsWw5/jC
 KRtrdW+KWDpNu/BWAhSZ6pBzg1rY8uYOODDafepd4c2qM9Uvxv0lkvT6CX7md/ESolmW
 S9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nq3pVT0n31P0HNjyqI7S+6BiEoQ7qBGuBzgDGWdgNEs=;
 b=mJVtzuY4pOcdWC7MwZab4lyVnP0nl7ciizzChJxP210kt0lPBdVRf6yUJV26nxpERW
 hz0qTSRdCxa/dfBYJaj7cn0PDpMNFPSE3m9tFzOSQT5mGiYyqPlJutKtp3ov+7tQW2ZK
 CqTMcJJAUkI4muwBuA3OB1dKsXQ8cE2/JG5M5TnDEhCBwhlZubI8xfcmzJhhyeo017rL
 wmPoiX4q+mdrQ8kv7qN59CRSNxK8R0gj4qglGlpR/dMBagpiN7qWiAgh/rfJdfWDX+lP
 ba7fiw4eUMhj25FNf3Uf59FP7QreK1ylEtFaIb0qznQKFzKnc/d+I+E7QStFa1Og8n/S
 hALA==
X-Gm-Message-State: APjAAAVzbgsQCHsbKN4TOuhxGW1r1B1PFsHjoBGsPstHKWP4LaXNNwZ2
 NQfHmDzeHnaDhNsrjM6C/8zwpW6T
X-Google-Smtp-Source: APXvYqzgT2UxlP7KDAO6dzds3Bm8zHlXoxETGK33HncJ+99uAGtVDERxZMCPSg7rppwBdKjQ4qx0xw==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr71613634wrv.77.1582570151446; 
 Mon, 24 Feb 2020 10:49:11 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:11 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 2/6] nvme: make nvme_ns_has_pi accessible to transports
Date: Mon, 24 Feb 2020 10:48:55 -0800
Message-Id: <20200224184859.20995-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104912_833986_2075195F 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the nvme_ns_has_pi() inline from core.c to the nvme.h header.
This allows use by the transports

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/core.c | 6 ------
 drivers/nvme/host/nvme.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a42c0ab37ef4..4f08c637ec2e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -18,7 +18,6 @@
 #include <linux/pr.h>
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
-#include <linux/t10-pi.h>
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
@@ -209,11 +208,6 @@ static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-{
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 11336ec6d27b..0725cc7c7a7a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
+#include <linux/t10-pi.h>
 
 #include <trace/events/block.h>
 
@@ -394,6 +395,11 @@ struct nvme_ns {
 
 };
 
+static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
+{
+	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
+}
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
