Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E74C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:01:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C72619C0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C72619C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vfdTJOHL8SdE+/o01+vlIb/eqiOcKxIeIRaMqWD2COQ=; b=En8G5VBIzXExHS9TLo3R6y72/
	wJRief8BuD4wvKFqVkSOOJCILjwcvnPUp1kWP9jUCAXG+46Y3mbcc7UNxgV9KOUQeSdslmrF8A6lt
	2bRsTqwsiropbSHDBN9wwmGBsFHokQq4b7+Beh1C2T48v1Y5BIQ1hfbBn5Nm2CqxMlFg7NDWlNXwp
	GHX+mObAy5NXczDMXoKIbiiTBIMFOuG/8vg9HHW5MFJIjMIMUtO0U3fquOCs+GcW/ZfD3oPeMle8y
	6y5bHnDj448PGe02R4lVTOw8esy8UN9PTP/RXtT8aNTq0Yh4/L2he6XTaq9q6FlKosdQzNNyUBm4v
	0B0CiinSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGoF-004HsK-7f; Tue, 30 Mar 2021 16:01:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGlo-004HSW-8y
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZeVI3t1tAPjtr48+sN+EjEX3SLruS4MT7bBiPNY3+o=;
 b=E+6e2Rb5/U/0Ub9/6PbhUfwKioh5UuaaIW49VFuchkTe/lWsykxNMAICRwPA2KD0ixykXE
 nu2VahgrLSymHKX5Z9WNXxd6nGKeMAAynkeqxubvM6xHIFp0K21ZPSMEuTOmeg7I4NeUdV
 tZ0zqQkQJqWiP3GfmhddZaYcEmpyYis=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 24463B320;
 Tue, 30 Mar 2021 15:59:03 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 8/9] fabrics: fix some memory leaks
Date: Tue, 30 Mar 2021 17:57:10 +0200
Message-Id: <20210330155711.8436-9-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165908_609741_5F23D649 
X-CRM114-Status: GOOD (  13.33  )
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

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 9a694bd..f9e5dc6 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -49,6 +49,7 @@
 
 #include "common.h"
 #include "util/log.h"
+#include "util/cleanup.h"
 
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -308,7 +309,7 @@ static bool ctrl_matches_connectargs(const char *name, struct connect_args *args
 {
 	struct connect_args cargs;
 	bool found = false;
-	char *path, *addr;
+	char *path = NULL, *addr;
 	int ret;
 	bool persistent = true;
 
@@ -366,6 +367,8 @@ static bool ctrl_matches_connectargs(const char *name, struct connect_args *args
 	free(cargs.traddr);
 	free(cargs.trsvcid);
 	free(cargs.host_traddr);
+	free(addr);
+	free(path);
 
 	return found;
 }
@@ -422,13 +425,18 @@ static struct connect_args *extract_connect_args(char *argstr)
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
 
@@ -1283,7 +1291,7 @@ retry:
 
 static bool cargs_match_found(struct nvmf_disc_rsp_page_entry *entry)
 {
-	struct connect_args cargs = {};
+	struct connect_args cargs __cleanup__(destruct_connect_args) = { NULL, };
 	struct connect_args *c = tracked_ctrls;
 
 	cargs.traddr = strdup(entry->traddr);
@@ -1369,9 +1377,11 @@ static void nvmf_get_host_identifiers(int ctrl_instance)
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
@@ -1455,7 +1465,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		const struct argconfig_commandline_options *opts, bool connect)
 {
 	FILE *f;
-	char line[256], *ptr, *args, **argv;
+	char line[256], *ptr, *all_args, *args, **argv;
 	int argc, err, ret = 0;
 
 	f = fopen(PATH_NVMF_DISC, "r");
@@ -1477,6 +1487,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 			ret = -ENOMEM;
 			goto out;
 		}
+		all_args = args;
 
 		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
 		if (!argv) {
@@ -1520,7 +1531,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 			ret = err;
 
 free_and_continue:
-		free(args);
+		free(all_args);
 		free(argv);
 	}
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
