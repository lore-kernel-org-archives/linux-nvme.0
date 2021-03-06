Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98EC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:39:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AE965077
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AE965077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qumWMaIfB8HVKez2tthJXfH4isQQndxRKXZDdcNHglg=; b=C57PiSze+21EMR4Y0uydrLFGP
	smxEtVrSY5HV11Z2wkZRB1k9oK1nfhoB5RWpyhcRW6TrNiRfSg5M8tMCIJGc9lWxRwnenjDSI6Z9v
	6TnDQ0ClxTTi3g5yc0l33JqsLm7Ehz/fiZVa3T5YDZ33PXIWGN9ibcicNAGU3O2XK+yileQEDS5ZZ
	A2aQJg6dnfZbYZQ7/t6Ur51sZx8lZllQKbjWwdERv2AQUMccStWEsSIpWcbLTNXh2PWA8ZfiCSnQ+
	SaO7RQyeSvG9BmGFYEQKDk4g9ig/SN1lSIKLVuJ5tS790kZvKtrMxbwbOKYOWjY2Ai+cOxCc7RMSb
	9K94TtjXQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKyG-00HWVk-2h; Sat, 06 Mar 2021 00:39:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKw3-00HVVm-OA
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKtrcgGtXL7NkyAfgpxh3UG7BLWGlb8X2UERz0yfTtE=;
 b=FazbNB8d3C1TCte8yMbkLB8nG9adBGnKQ60u++sKfIfM8JemaqCnvPWe72J7c2Zx91kXX0
 5t/m2am6umpiH9N3sECpq3Elw+0Jget1hqnuGmhoSSdWeXhBaKoCdXoteZjTNZ9fjxKbiy
 /la05m0IdoYfx4Kl7xHlF7fZKg2IoKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2E9BAF32;
 Sat,  6 Mar 2021 00:36:41 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 09/10] fabrics: fix some memory leaks
Date: Sat,  6 Mar 2021 01:36:23 +0100
Message-Id: <20210306003624.21102-10-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003649_395604_7599E485 
X-CRM114-Status: GOOD (  12.55  )
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

None of these are critical for "nvme discover" or "nvme connect-all".
Still, silencing valgrind's error messages by fixing them gives some
peace of mind, and a longer-running program like the forthcomint
nvme monitor, leak checks are more important.

Use the previously introduced cleanup macros for this purpose.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index c965beb..f2ff511 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -49,6 +49,7 @@
 
 #include "common.h"
 #include "util/log.h"
+#include "util/cleanup.h"
 
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -309,7 +310,7 @@ static bool ctrl_matches_connectargs(const char *name, struct connect_args *args
 {
 	struct connect_args cargs;
 	bool found = false;
-	char *path, *addr;
+	char *path = NULL, *addr;
 	int ret;
 	bool persistent = true;
 
@@ -369,6 +370,8 @@ static bool ctrl_matches_connectargs(const char *name, struct connect_args *args
 	free(cargs.traddr);
 	free(cargs.trsvcid);
 	free(cargs.host_traddr);
+	free(addr);
+	free(path);
 
 	return found;
 }
@@ -425,13 +428,18 @@ static struct connect_args *extract_connect_args(char *argstr)
 	return cargs;
 }
 
-static void free_connect_args(struct connect_args *cargs)
+static void destruct_connect_args(struct connect_args *cargs)
 {
 	free(cargs->subsysnqn);
 	free(cargs->transport);
 	free(cargs->traddr);
 	free(cargs->trsvcid);
 	free(cargs->host_traddr);
+}
+
+static void free_connect_args(struct connect_args *cargs)
+{
+	destruct_connect_args(cargs);
 	free(cargs);
 }
 
@@ -1285,7 +1293,7 @@ retry:
 
 static bool cargs_match_found(struct nvmf_disc_rsp_page_entry *entry)
 {
-	struct connect_args cargs = {};
+	struct connect_args cargs __cleanup__(destruct_connect_args) = { NULL, };
 	struct connect_args *c = tracked_ctrls;
 
 	cargs.traddr = strdup(entry->traddr);
@@ -1371,9 +1379,11 @@ static void nvmf_get_host_identifiers(int ctrl_instance)
 	cfg.hostid = nvme_get_ctrl_attr(path, "hostid");
 }
 
+static DEFINE_CLEANUP_FUNC(cleanup_log, struct nvmf_disc_rsp_page_hdr *, free);
+
 static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 {
-	struct nvmf_disc_rsp_page_hdr *log = NULL;
+	struct nvmf_disc_rsp_page_hdr *log __cleanup__(cleanup_log) = NULL;
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
 	int status = 0;
@@ -1457,7 +1467,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		const struct argconfig_commandline_options *opts, bool connect)
 {
 	FILE *f;
-	char line[256], *ptr, *args, **argv;
+	char line[256], *ptr, *all_args, *args, **argv;
 	int argc, err, ret = 0;
 
 	f = fopen(PATH_NVMF_DISC, "r");
@@ -1479,6 +1489,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 			ret = -ENOMEM;
 			goto out;
 		}
+		all_args = args;
 
 		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
 		if (!argv) {
@@ -1522,7 +1533,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 			ret = err;
 
 free_and_continue:
-		free(args);
+		free(all_args);
 		free(argv);
 	}
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
