Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECDC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FDA20771
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9XbBLxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FDA20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEsOJpUwXQIT/ymgkXiydwxH33CzrWkqBUEyHaH4Bik=; b=g9XbBLxzb5yNm8Aa9yViCTPHFq
	wxG3j1VaiKaRgziqiA7KZeon3g70szx8F2ke3rE3MfVA7R3ZJiToTykaUhgm7lG402V8PSw6el2vM
	9NS8OiKm4PQQKlYfE6r10maKCwPfeuxQy5pv98De3XV6cO9L3gv0vsFLBF+QtWbC0xKya9OAZn60J
	hwP/e1d/5M2hod0c4qBNLPlJqirBQ+HVUdYQ+1LQPh2yZXOLk83a3P1f6ErW+1ShH0Zv+/347+8e3
	PyNzV8TVAA/9/mzerxg1yXQzsPz97XQEgEMYsI9H8TCjHsXsriGUUHg1j765jXgYhZgThE24a6E0X
	pWmuQD0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gXL-00037x-1M; Fri, 14 Aug 2020 20:42:51 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gXH-00036V-Ud
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:42:48 +0000
Received: by mail-pl1-f194.google.com with SMTP id q19so4715647pll.0
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vxnuXmBa2tT3DJPjrr81uX1X4ryXyP/J5gupNr8RlFE=;
 b=sEzHVTdja1o59zp8Hb2glRwkqAR6a/2eUjtKlU+Q1MkAV20+ewd9GNgvmvFPClcxmj
 YYlXe/ZLXJyYJZQ+owogyM14/+UbbhjVsf7AaY2qKxuMCD8NJBaYkhIXT2E5TYzBFrgU
 5W/F9hWjisAdEh+PknxwS6KtTEjGVmU8UY7WiM4xi6hcoDQxvrC1ozMi2BL+PNCOvHRf
 hhqWI+sJmozVfKhxl8ll9bKpy2LbqU6Gf9+b8ot4lO97j5+CCS4JIav7RZt/J7VrNdWU
 QS1TexEdMig5Drg5AAohuFGwpwqjCRUUL6PlQRD51wNptW00jsM4BUsxu5nVvHKQ+53y
 MjRA==
X-Gm-Message-State: AOAM531ch8cg5MSbr+DJ8sHhgWCxah1GeS1ssl728fginK9Pyv4068o5
 IlPlwG2FcB+H5On/fq75uQYaiMqcrJYVug==
X-Google-Smtp-Source: ABdhPJzObe0rNbHNg04cKPX331CcOHHAiOsAOsY1LijVEp6mq3ZTqXHlpnx9KPFA1RL4pBmigjcixA==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id
 gt23mr3747721pjb.0.1597437765606; 
 Fri, 14 Aug 2020 13:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l63sm9141125pgl.24.2020.08.14.13.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:42:45 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH rfc 2/3] fabrics: move connect_args extraction to a dedicated
 routine
Date: Fri, 14 Aug 2020 13:42:38 -0700
Message-Id: <20200814204239.751787-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814204239.751787-1-sagi@grimberg.me>
References: <20200814204239.751787-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164248_017354_C9CC23C6 
X-CRM114-Status: GOOD (  13.98  )
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

We will need it to track controllers as we are iterating over
nested discovery log pages recursion.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 17d969b17dd5..6d6b3b5a3ca7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -360,6 +360,31 @@ cleanup_devices:
 	return devname;
 }
 
+static struct connect_args *extract_connect_args(char *argstr)
+{
+	struct connect_args *cargs;
+
+	cargs = calloc(1, sizeof(*cargs));
+	if (!cargs)
+		return NULL;
+	cargs->subsysnqn = parse_conn_arg(argstr, ',', conarg_nqn);
+	cargs->transport = parse_conn_arg(argstr, ',', conarg_transport);
+	cargs->traddr = parse_conn_arg(argstr, ',', conarg_traddr);
+	cargs->trsvcid = parse_conn_arg(argstr, ',', conarg_trsvcid);
+	cargs->host_traddr = parse_conn_arg(argstr, ',', conarg_host_traddr);
+	return cargs;
+}
+
+static void free_connect_args(struct connect_args *cargs)
+{
+	free(cargs->subsysnqn);
+	free(cargs->transport);
+	free(cargs->traddr);
+	free(cargs->trsvcid);
+	free(cargs->host_traddr);
+	free(cargs);
+}
+
 static int add_ctrl(const char *argstr)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -1192,14 +1217,11 @@ static int do_discover(char *argstr, bool connect)
 	int status = 0;
 
 	if (cfg.device) {
-		struct connect_args cargs;
+		struct connect_args *cargs;
 
-		memset(&cargs, 0, sizeof(cargs));
-		cargs.subsysnqn = parse_conn_arg(argstr, ',', conarg_nqn);
-		cargs.transport = parse_conn_arg(argstr, ',', conarg_transport);
-		cargs.traddr = parse_conn_arg(argstr, ',', conarg_traddr);
-		cargs.trsvcid = parse_conn_arg(argstr, ',', conarg_trsvcid);
-		cargs.host_traddr = parse_conn_arg(argstr, ',', conarg_host_traddr);
+		cargs = extract_connect_args(argstr);
+		if (!cargs)
+			return -ENOMEM;
 
 		/*
 		 * if the cfg.device passed in matches the connect args
@@ -1212,14 +1234,10 @@ static int do_discover(char *argstr, bool connect)
 		 *    create a new ctrl.
 		 * endif
 		 */
-		if (!ctrl_matches_connectargs(cfg.device, &cargs))
-			cfg.device = find_ctrl_with_connectargs(&cargs);
-
-		free(cargs.subsysnqn);
-		free(cargs.transport);
-		free(cargs.traddr);
-		free(cargs.trsvcid);
-		free(cargs.host_traddr);
+		if (!ctrl_matches_connectargs(cfg.device, cargs))
+			cfg.device = find_ctrl_with_connectargs(cargs);
+
+		free_connect_args(cargs);
 	}
 
 	if (!cfg.device) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
