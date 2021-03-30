Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B8C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:02:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FA8619C0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FA8619C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tKNMV8Gu5nM0mRw/e2YMTHMH523pE6AXF+vHddli10A=; b=H2fUwyotFC/ivlWQMEk7a9kZA
	2kaqJSIvk0t2S0w1auS4nlavEKdRRPCnl1Fn9XqbSYwQwjXrUbXMxbn2lLhugf6uiQS4lnRhVcC+j
	HsywyoOTPWbGFoaA01+/ULwYPVJVzWDm30aYiXkK1OsKr38wqsKv/bYuQ+/L5tIRuQcJfOW5U/oWF
	dI1VH5YM8ibRGipcPcGLVxSE0Tsg8lpaWsMJaYiQqd5hhD7MxsyIALtd1BJmvZ+F9tdgERQIuOilx
	xQuIt1kkik7S9yFdxcV1OLS1kNkk7iK7x68sswjMJIOlfrEbVwwWqnoKTQm9wbzvff2g1kstLAiDI
	r/Jo5Dp4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGp3-004Hzg-Ul; Tue, 30 Mar 2021 16:02:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGlr-004HTd-Sq
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ebeux6Mg6qVraTtf7EGyZBEvCvQvYfALbmgxgVxVZPU=;
 b=L3opCmlK10R4OINb70DaNLcGnJSTWbveD52n42/mGZjwIfvJG2sQekG8VHZ+l2FxuNH8MM
 YA+uKc/vDCsgTjLNchUYlf5ELSx4xxlZeeHLdkOTdN8HmJyPI+d6hRbRBGbcuBjOf/e7qD
 nhnVmDXHPWH6+7h18jYSnYhWlah3Eio=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6A207B32A;
 Tue, 30 Mar 2021 15:59:03 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 9/9] fabrics: fix invalid memory access in
 discover_from_conf_file()
Date: Tue, 30 Mar 2021 17:57:11 +0200
Message-Id: <20210330155711.8436-10-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165912_194336_A166E004 
X-CRM114-Status: GOOD (  10.73  )
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

From: Martin Wilck <mwilck@suse.com>

argconfig_parse() assigns pointers in cfg to point to memory allocated
in all_args. If this memory is freed, these pointers become dangling.
This is particularly dangerous if discovery.conf contains empty lines,
comment lines, or invalid lines.

Fix it by setting all transport parameter to NULL after processing each
line, and not proceeding if the basic parameters aren't set.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index f9e5dc6..c9324bb 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1506,6 +1506,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			goto free_and_continue;
 
+		if (!cfg.transport || !cfg.traddr)
+			goto free_and_continue;
+
 		err = flags = validate_output_format(cfg.output_format);
 		if (err < 0)
 			goto free_and_continue;
@@ -1533,6 +1536,8 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 free_and_continue:
 		free(all_args);
 		free(argv);
+		cfg.transport = cfg.traddr = cfg.trsvcid =
+			cfg.host_traddr = NULL;
 	}
 
 out:
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
