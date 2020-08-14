Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A6C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B5F206C0
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oo8d+pQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B5F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JpUUN1TCd4ULJOova6w08+RQt2JG/Zy3mlnWSTw+7A=; b=Oo8d+pQq295RqjIxnD2lqqCz1N
	t3FBC09i+ibCdcgqRKy+cT/EI+uxWVQSw4+2zFNpzj/qu+wgHUsvIibMtBo6lkM2bLu9OzFom3fHM
	reCzmop+SRgTD+LhTOAhBypNLZPhxhTtYM94r34pyG/7+wT6i8YmFePzer3dLR4bMrX65vPojvMvO
	Ipmeb9uZIDlXD63WyHy/yOdGJrtp/4nRWCvow/mxTDrp15LK5Xw7c21RAlo1IwyLYSdQlg2MW/yNh
	UthGXFBeI3hgu9OJeiZc+4omrThauJ55bmzfYG1hfqodFCZyhyIN04t3TzLa8+QmDmHj0xNjU+9SD
	1TqpdRzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gXN-00038T-3I; Fri, 14 Aug 2020 20:42:53 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gXI-000377-VE
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:42:50 +0000
Received: by mail-pf1-f193.google.com with SMTP id m8so5124884pfh.3
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uIc25cECo3Qfdh8pBLlpblQgcUEKwxHX7Zf+zrn1zYA=;
 b=QYiuuoXKvKx6Z0n/DyBAEHDyMFUqeg3KThiGnUzHxKoGuptBMUDPvF8EkooT7BvOtw
 fOVqQnYXb3ZtoBB1JXuQpSg3wZEBRy1sPnlCMMiappJ5oB3OO1MkqQR5brzMHJw3IFqb
 cJCFMmzjYXb8blQ1YIyQZRN89isci/tv+lUO2H5yyWzZI5yt4VxsZP0ZAjmn/pdA7aYV
 w644wsBrgAWBaf7Exys1KdfO56NgBbILKBTX2u0Y6zLMA+YBXWu39B7SUO7vwz69+tFe
 DYwEE3FximX38Z0lhobp0fb1OSxFQ5gD9Az/dPZPW2BSGUM3lcWl8cGZ05oNqoNnIiRI
 iRBQ==
X-Gm-Message-State: AOAM530s6W1Fkq9HaAnd09ojZ+xv4Mf3dIoY5DUc07f/VfxnxoiVmdTk
 qUD9DQxrrnFWgMtUgYFVX5wrUSidjaG4lQ==
X-Google-Smtp-Source: ABdhPJyb+jZ7avcfsNRwwJCL2nBUVMkaztkuOXDFQyjIZhYWXxV1/SfD8aV5qyRJMZtQGa+ixgtETg==
X-Received: by 2002:a62:8001:: with SMTP id j1mr3144105pfd.45.1597437767448;
 Fri, 14 Aug 2020 13:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l63sm9141125pgl.24.2020.08.14.13.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:42:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH rfc 3/3] fabrics: fix infinite loop is discovery recursion
 contains a loop
Date: Fri, 14 Aug 2020 13:42:39 -0700
Message-Id: <20200814204239.751787-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814204239.751787-1-sagi@grimberg.me>
References: <20200814204239.751787-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164249_113637_29983E3C 
X-CRM114-Status: GOOD (  16.58  )
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

It's possible that different discovery controllers may refer to
each other. In this case, we will get into an infinite loop as
we don't track that we have already connected and seen this.

The kernel doesn't protect us from this for discovery controllers
because it always allows duplicate discovery controllers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 6d6b3b5a3ca7..73bb37529448 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -93,8 +93,12 @@ struct connect_args {
 	char *traddr;
 	char *trsvcid;
 	char *host_traddr;
+	struct connect_args *next;
+	struct connect_args *tail;
 };
 
+struct connect_args *tracked_ctrls;
+
 #define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
@@ -385,6 +389,21 @@ static void free_connect_args(struct connect_args *cargs)
 	free(cargs);
 }
 
+static void track_ctrl(char *argstr)
+{
+	struct connect_args *cargs;
+
+	cargs = extract_connect_args(argstr);
+	if (!cargs)
+		return;
+
+	if (!tracked_ctrls)
+		tracked_ctrls = cargs;
+	else
+		tracked_ctrls->tail->next = cargs;
+	tracked_ctrls->tail = cargs;
+}
+
 static int add_ctrl(const char *argstr)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -428,6 +447,7 @@ static int add_ctrl(const char *argstr)
 			if (match_int(args, &token))
 				goto out_fail;
 			ret = token;
+			track_ctrl((char *)argstr);
 			goto out_close;
 		default:
 			/* ignore */
@@ -1148,10 +1168,39 @@ retry:
 	return ret;
 }
 
+static bool cargs_match_found(struct nvmf_disc_rsp_page_entry *entry)
+{
+	struct connect_args cargs = {};
+	struct connect_args *c = tracked_ctrls;
+
+	cargs.traddr = strdup(entry->traddr);
+	cargs.transport = strdup(trtype_str(entry->trtype));
+	cargs.subsysnqn = strdup(entry->subnqn);
+	cargs.trsvcid = strdup(entry->trsvcid);
+	cargs.host_traddr = strdup(cfg.host_traddr ?: "\0");
+
+	/* check if we have a match in the discovery recursion */
+	while (c) {
+		if (!strcmp(cargs.subsysnqn, c->subsysnqn) &&
+		    !strcmp(cargs.transport, c->transport) &&
+		    !strcmp(cargs.traddr, c->traddr) &&
+		    !strcmp(cargs.trsvcid, c->trsvcid) &&
+		    !strcmp(cargs.host_traddr, c->host_traddr))
+			return true;
+		c = c->next;
+	}
+
+	/* check if we have a matching existing controller */
+	return find_ctrl_with_connectargs(&cargs) != NULL;
+}
+
 static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 {
 	int len;
 
+	if (cargs_match_found(entry))
+		return false;
+
 	if (!cfg.matching_only || !cfg.traddr)
 		return true;
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
