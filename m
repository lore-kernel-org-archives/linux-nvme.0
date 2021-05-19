Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E13C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BF2610A2
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BF2610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YJ+DAtaemnZS3DxwFp2vs9mxu9Jt+PzRWJ7XGukaLUM=; b=mogugmlLFNfxB9o+CldasGf/K
	9tGR1iP8Y9KLk3hAYul1LxMaoKZgNY4Ev3uUo75MWXcxEaeZtHszsH9S9fsfd56+VKtWHvgnRt0Nj
	NBvMCCmEk0UJ+s6J1JxySZmyKR8NBzgqfNBpZ8ZbCFdQlcocXRxOZM/ZpF4tX7j5SYjuh2bB74pWw
	RSIJU81mYch/hWe+gSo9KnYYviQ19VJ26U7rDAajUgUfQES0NlCx9Iubd7bxHM19LRpH6w3Kkojl6
	cdO+bpm/BckG3WBzyL0c+E25AtipmKsKdf9iMC6LjRrsdOJozrfy0tqnFCZ2+AkigVKyKwYUTWePB
	O7Sg1mp+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljQEk-004gER-Ny; Wed, 19 May 2021 17:44:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEW-004gAw-As
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 17:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=uUn+H16Em5FwSSFhevsCevsaRgI8fL1HG/g29FUKKNM=; b=m4mQpiJLY3zrV7NhKxLkWKJgMs
 PmY1i4orWpnLErgGnJg1pOXCMCBApe4AGLrF2x//dkSbc+ysf0K73+YOsSGClsFYyweb47Xm48rHh
 rXAIL2s/kv+S503Pe9TEUo5Fuzb3PSEVfVj3EZsIMnR2slitSYzMUvlp96lfKkViCNnLSsFLN3bOZ
 jl5XWRY7zrn7GkcOBtf0FXk1kfSmj0pUzT09F+oSVsl0riY5fr26AKYvKMfTpgK9RKVq4UpNsVgGf
 LUfy5mmMKFenKcdqpUywsLu3sME+jEUfZMw6WftipE2qLQnkZU4Mdhhzd6bhXSbzYr8syRToBSD9X
 pWf+TZHw==;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQET-00FfSv-Os
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 17:43:47 +0000
Received: by mail-pl1-f177.google.com with SMTP id s20so7458628plr.13
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 10:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uUn+H16Em5FwSSFhevsCevsaRgI8fL1HG/g29FUKKNM=;
 b=lVibtRzCyvzTCkldC/VMSVTkERpCOEqtue36ZVIqVu/ORxGJ8tcCJOQXpK42jdZ289
 j5vKsACQohWVa4RDOBPPid2wkvEnHdO/JZ8l0xJ6KGY/Yhc90At+T6ApIhxKWNN1l2T4
 VgDDnL6OaptK7SgsAIHieAdCsih0ZTvXAMUziHdrJaHyVko9HabfnL89lwDvDtdYJhC2
 k/MIOaw1iDreqcSEe7gRxzYOjF+oat7NnwWrxUPw5LT6ysfkoOQtU1xbMD8dPWOrRaMN
 PmbeSKwGo1Gb7RESMdDhY9goaWNZHkmt6CU92prOBw4UZBwO7nJ8x6/VcRZO75ezOu95
 3eEQ==
X-Gm-Message-State: AOAM532rcE8z8RQOXvS1PpgMyciEs3uLE/d/f9VZlZY388ZRFrGo0HIH
 fM17LyJ4etikB4uNnDrFdloiOqHnCSg=
X-Google-Smtp-Source: ABdhPJwID38e4FWA2ZQzk0CqjVW8TQWTT72rfdAEVqGQxGIkgXC+z/92pse7RtdK6wDTw+fTj6C0TQ==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id
 k10mr121214pjq.33.1621446224320; 
 Wed, 19 May 2021 10:43:44 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a498:37ce:5a01:2259])
 by smtp.gmail.com with ESMTPSA id l10sm46639pfc.125.2021.05.19.10.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 10:43:43 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/4] params: lift param_set_uint_minmax to common code
Date: Wed, 19 May 2021 10:43:37 -0700
Message-Id: <20210519174340.1144806-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519174340.1144806-1-sagi@grimberg.me>
References: <20210519174340.1144806-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_104345_826179_77F30FED 
X-CRM114-Status: GOOD (  14.86  )
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

It is a useful helper hence move it to common code so others can enjoy
it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/moduleparam.h |  3 +++
 kernel/params.c             | 19 +++++++++++++++++++
 net/sunrpc/xprtsock.c       | 18 ------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index eed280fae433..47bd89cd2580 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -432,6 +432,9 @@ extern const struct kernel_param_ops param_ops_uint;
 extern int param_set_uint(const char *val, const struct kernel_param *kp);
 extern int param_get_uint(char *buffer, const struct kernel_param *kp);
 #define param_check_uint(name, p) __param_check(name, p, unsigned int)
+int param_set_uint_minmax(const char *val,
+		const struct kernel_param *kp,
+		unsigned int min, unsigned int max);
 
 extern const struct kernel_param_ops param_ops_long;
 extern int param_set_long(const char *val, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 2daa2780a92c..db989a6aa281 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -243,6 +243,25 @@ STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
 STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
 
+int param_set_uint_minmax(const char *val,
+		const struct kernel_param *kp,
+		unsigned int min, unsigned int max)
+{
+	unsigned int num;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+	ret = kstrtouint(val, 0, &num);
+	if (ret)
+		return ret;
+	if (num < min || num > max)
+		return -EINVAL;
+	*((unsigned int *)kp->arg) = num;
+	return 0;
+}
+EXPORT_SYMBOL(param_set_uint_minmax);
+
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
 	if (strlen(val) > 1024) {
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e35760f238a4..737c0d983813 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3123,24 +3123,6 @@ void cleanup_socket_xprt(void)
 	xprt_unregister_transport(&xs_bc_tcp_transport);
 }
 
-static int param_set_uint_minmax(const char *val,
-		const struct kernel_param *kp,
-		unsigned int min, unsigned int max)
-{
-	unsigned int num;
-	int ret;
-
-	if (!val)
-		return -EINVAL;
-	ret = kstrtouint(val, 0, &num);
-	if (ret)
-		return ret;
-	if (num < min || num > max)
-		return -EINVAL;
-	*((unsigned int *)kp->arg) = num;
-	return 0;
-}
-
 static int param_set_portnr(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp,
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
