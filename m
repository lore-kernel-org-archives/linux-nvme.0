Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABDC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D4165074
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4165074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=76CV3WquFl6eJOI94UHlFakDaqKh46xYr3FArxb9Amk=; b=OTdWQH6tecZSGHLtpaePq2R0n
	panfvj3mQIy9pMwNqHIJHDUUgfRyax435ontACT99CPK/x8i7oTiB+DcRSZQpjTec4BRPfHSvzj5k
	5XBNxb0XY6gIieEXZuMlsaWL/dTMpKfXFIbEg76UfUAWAkFYdou7igfuvs0gY5w2ryGpLjr9cGQS3
	qajOSZ8KG67EHxBT+ihIzntoeQ1RleafjWgtY9AiOaItWWj5rpG9YWtBHvUWyrtgxiNOfFbBTykBt
	pWS7rrfe6mIB73YaIsMolfqQam5XM6sis0B45sfikmBxmxgIjTmVDe/bJoqSy9p+GO7zlUAkRxsOn
	jKld/9Xxw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKwU-00HVeR-Iz; Sat, 06 Mar 2021 00:37:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKvy-00HVRQ-Tf
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614990999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orKFbK0vExdbmQIMxk8iH839l6J17YmM7CgmSbCqOiE=;
 b=qa2JSKhOd/6vgvKDrKy6WktJSBJoUVqXtU/H0jn+LdZYm0fnGMX3qqqaAghIdqUeJo9W2A
 jPMNEbWTPN+eafl3heWkCs3WfQlLeU6PVBYNBYdq++LpMK24Z5BHIpatnrH51ED+4J7P0L
 +qkuvkRpDP2+aH5jvbP9z8lMC3pPJ38=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 55DD6AE42;
 Sat,  6 Mar 2021 00:36:39 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH 01/10] nvme-discover: lookup existing persistent controllers
Date: Sat,  6 Mar 2021 01:36:15 +0100
Message-Id: <20210306003624.21102-2-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003644_181731_03EF24B8 
X-CRM114-Status: GOOD (  16.09  )
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

From: Hannes Reinecke <hare@suse.de>

If persistent controller connections are present they should be
preferred even if no --device option is given on the commandline.
To avoid selecting a temporary non-persistent controller the
'kato' attribute is checked; any controller which does not have
this attribute or for which the attribute is '0' will be skipped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index f84c45b..14899cc 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -320,6 +320,27 @@ static bool ctrl_matches_connectargs(char *name, struct connect_args *args)
 	cargs.trsvcid = parse_conn_arg(addr, ' ', conarg_trsvcid);
 	cargs.host_traddr = parse_conn_arg(addr, ' ', conarg_host_traddr);
 
+	if (!strcmp(cargs.subsysnqn, NVME_DISC_SUBSYS_NAME)) {
+		char *kato_str = nvme_get_ctrl_attr(path, "kato"), *p;
+		unsigned int kato = 0;
+
+		/*
+		 * When looking up discovery controllers we have to skip
+		 * any non-persistent controllers (ie those with a zero
+		 * kato value). Otherwise the controller will vanish from
+		 * underneath us as they are owned by another program.
+		 *
+		 * The 'kato' attribute might not be present; assume a
+		 * non-persistent controller for these installations.
+		 */
+		if (kato_str) {
+			kato = strtoul(kato_str, &p, 0);
+			if (p == kato_str)
+				kato = 0;
+		}
+		if (kato == 0)
+			return found;
+	}
 	if (!strcmp(cargs.subsysnqn, args->subsysnqn) &&
 	    !strcmp(cargs.transport, args->transport) &&
 	    (!strcmp(cargs.traddr, args->traddr) ||
@@ -1345,30 +1366,15 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
 	int status = 0;
+	struct connect_args *cargs;
 
-	if (cfg.device) {
-		struct connect_args *cargs;
+	cargs = extract_connect_args(argstr);
+	if (!cargs)
+		return -ENOMEM;
 
-		cargs = extract_connect_args(argstr);
-		if (!cargs)
-			return -ENOMEM;
-
-		/*
-		 * if the cfg.device passed in matches the connect args
-		 *    cfg.device is left as-is
-		 * else if there exists a controller that matches the
-		 *         connect args
-		 *    cfg.device is the matching ctrl name
-		 * else if no ctrl matches the connect args
-		 *    cfg.device is set to null. This will attempt to
-		 *    create a new ctrl.
-		 * endif
-		 */
-		if (!ctrl_matches_connectargs(cfg.device, cargs))
-			cfg.device = find_ctrl_with_connectargs(cargs);
-
-		free_connect_args(cargs);
-	}
+	if (!cfg.device || !ctrl_matches_connectargs(cfg.device, cargs))
+		cfg.device = find_ctrl_with_connectargs(cargs);
+	free_connect_args(cargs);
 
 	if (!cfg.device) {
 		instance = add_ctrl(argstr);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
