Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F6C48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4714613DE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4714613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L0V8RTa/B/1lYv1FVYf6z2iiQMDQsfcNUkHoqivF9ls=; b=OgmwP3+jIHlV7y
	yZVBS06RYZIUEu/XU3ON9aT5QWSf7ZRBnhVSUa11hdDmGvAi9hh89vwzISYbeOxv9VoeXMDzefPm7
	HtWlDGys8h89IdKCtyf5TBvQmVFPZ3ZZLR3TZQRCo1+pBAxQN0mAwSmhFHisr2SRMfTu5wLoUdx7X
	EJyKA/v1L3Ng75gM/RvvzeKCyZUsbCDw/ohKeVAiMaf3MDYJZF/s32YXiGM34e52nyZEfD/fdYux9
	LAGbqQdmjJ+fuLkoLAIlx9K4dDqmv6zcH55tt8PLKMAm4zaha/Y96RqdH7TBpHhBCTymC4g7h2QMO
	Pp8gD3+M/Cf6VjOJf1qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltcwz-007k36-Gt; Wed, 16 Jun 2021 21:19:53 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcwm-007jz6-Os
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:19:42 +0000
Received: by mail-pl1-f180.google.com with SMTP id e1so1784759plh.8
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yKApfHCV1764acZ5HvCiBkIPY5agrAKtYgv32tvri08=;
 b=ts0uXII7NIc5iSdVUYiTvWx8Kdu9r1Dz7XIVcjWN02/Jr5YRrLEOkZT1d7YJRwBI5t
 zZ42g+1z24w3M6IbHH9MippWHXLAZiGUENep3Am8N86BIjWg69HO6jlwwN06DLCZ5UpV
 cJkhCVmCmPp6PKznHX0AzAb9aRVkXp7kKQMBAfbQip2p9FjWFFbdmo+/EF0W5Ngm7qRj
 yPwcXs6GBO8VlI+t1o5v3KCJdzj0nFN9+Q5bQSUsytLxM+A351zRMP+HuZPWCB5Az7qo
 yAh/qBnCP2okD9KKE9UNN94kz7usFhNfDS3P/3sVZmZEza0dWhZ/EH3YY2ylxHxmwvFK
 Da2Q==
X-Gm-Message-State: AOAM530lCAHJRSgCg0/a9A/erCQdop6doYvLW4HVVMX3hVPx8jICaKoa
 mIMFPm96GRBevd0JDWNSHwdlWsA66yI=
X-Google-Smtp-Source: ABdhPJztxH9X4BENTtlI9XN88faD1qTd7opKGGXTCT+5YH3J+9n5nwy3utTXXF0+nUazxVsV8wk6mQ==
X-Received: by 2002:a17:90b:4905:: with SMTP id
 kr5mr1824669pjb.161.1623878379768; 
 Wed, 16 Jun 2021 14:19:39 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id e188sm3003046pfe.23.2021.06.16.14.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 14:19:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v3 1/4] params: lift param_set_uint_minmax to common code
Date: Wed, 16 Jun 2021 14:19:33 -0700
Message-Id: <20210616211936.451128-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210616211936.451128-1-sagi@grimberg.me>
References: <20210616211936.451128-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_141940_846101_0C84B127 
X-CRM114-Status: GOOD (  13.85  )
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/moduleparam.h |  3 +++
 kernel/params.c             | 19 +++++++++++++++++++
 net/sunrpc/xprtsock.c       | 18 ------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index eed280fae433..b36ece513616 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -432,6 +432,9 @@ extern const struct kernel_param_ops param_ops_uint;
 extern int param_set_uint(const char *val, const struct kernel_param *kp);
 extern int param_get_uint(char *buffer, const struct kernel_param *kp);
 #define param_check_uint(name, p) __param_check(name, p, unsigned int)
+int param_set_uint_minmax(const char *val,
+			  const struct kernel_param *kp,
+			  unsigned int min, unsigned int max);
 
 extern const struct kernel_param_ops param_ops_long;
 extern int param_set_long(const char *val, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 2daa2780a92c..7d3c61e64140 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -243,6 +243,25 @@ STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
 STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
 
+int param_set_uint_minmax(const char *val,
+			  const struct kernel_param *kp,
+			  unsigned int min, unsigned int max)
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
index 47aa47a2b07c..0cfbf618e8c2 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3130,24 +3130,6 @@ void cleanup_socket_xprt(void)
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
