Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20AC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC2C65016
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC2C65016
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iKbKT97UAIvx1jYvdWE6N13criRgOtPd8f+ZBULqsJ4=; b=MUxjPy5ppgjcmVe/YR9wT1k6F
	ovejiprBGJFVDuUVb/ZBC3+/qFtOgRLhWT9bHwDrfKExueNfzrD/Rpnwu5ssKlVsqOcwFUD0AF7hV
	Y6RKHmHV2WVW3Av8JdnRJYDxU33oMwlXkHvsnkznAXDmo0KebNDTIOGV65mvvaAhPXsRs6Km6DKy5
	73NOlqnOC72hBRMCN1OJpDiPzMEPBQ4DVF3ZuRMitqIDVk9vxfra2d9odeAO8Prjp9zt7PA6mrDGa
	61tyx/A9wwJtbMH4jMHtUyrjLCL4BSKhnLErK+aNmbqBx2g+gVuG2GILETKtN6csTm42MCYWd8/yL
	xObGFhEWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKw6-00HVVw-Kw; Sat, 06 Mar 2021 00:36:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKvy-00HVRP-G2
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614990999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V++eBuPax+iX8IgKWr9YSW56Mws71vdpp2NwY1jp1TE=;
 b=ZP+WsKcpS/uUb6QDOgd5lJT5Qy8wRhujXfSVokt+VT3aDF2JGl2WYFuYHiW9+1ppCWOaov
 4M54XrkxJNiCH2yywdmxZRYeyd3NnOXGM5HV2oC1BLuON0s2iJtvI333DfgkndgJ3caFS2
 9v1YMwBomlFt7OeIsjyu8CGOSA9xw88=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9EFBCAE89;
 Sat,  6 Mar 2021 00:36:39 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 02/10] nvme-discover: assume device given on command line is
 persistent
Date: Sat,  6 Mar 2021 01:36:16 +0100
Message-Id: <20210306003624.21102-3-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003643_970429_2694D8F2 
X-CRM114-Status: GOOD (  15.77  )
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

After commit "nvme-discover: lookup existing persistent controllers",
controllers without the "kato" sysfs attribute will never be used by
do_discover(). This makes sense for controllers found while traversing
sysfs in find_ctrl_with_connectargs(), but if the user passed a
device explicitly, it should be used, even on older kernels that
don't support the "kato" attribute.

Furthermore, make sure allocated memory in ctrl_matches_connectargs()
is freed.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 14899cc..dcee0c4 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -297,12 +297,14 @@ static int ctrl_instance(char *device)
  * given.
  * Return true/false based on whether it matches
  */
-static bool ctrl_matches_connectargs(char *name, struct connect_args *args)
+static bool ctrl_matches_connectargs(char *name, struct connect_args *args,
+				     bool assume_persistent)
 {
 	struct connect_args cargs;
 	bool found = false;
 	char *path, *addr;
 	int ret;
+	bool persistent = true;
 
 	ret = asprintf(&path, "%s/%s", SYS_NVME, name);
 	if (ret < 0)
@@ -331,17 +333,21 @@ static bool ctrl_matches_connectargs(char *name, struct connect_args *args)
 		 * underneath us as they are owned by another program.
 		 *
 		 * The 'kato' attribute might not be present; assume a
-		 * non-persistent controller for these installations.
+		 * non-persistent controller for these installations,
+		 * unless assume_persistent is set.
 		 */
 		if (kato_str) {
 			kato = strtoul(kato_str, &p, 0);
 			if (p == kato_str)
 				kato = 0;
-		}
-		if (kato == 0)
-			return found;
+			free(kato_str);
+			persistent = (kato != 0);
+		} else if (!assume_persistent)
+			persistent = false;
 	}
-	if (!strcmp(cargs.subsysnqn, args->subsysnqn) &&
+
+	if (persistent &&
+	    !strcmp(cargs.subsysnqn, args->subsysnqn) &&
 	    !strcmp(cargs.transport, args->transport) &&
 	    (!strcmp(cargs.traddr, args->traddr) ||
 	     !strcmp(args->traddr, "none")) &&
@@ -380,7 +386,7 @@ static char *find_ctrl_with_connectargs(struct connect_args *args)
 	}
 
 	for (i = 0; i < n; i++) {
-		if (ctrl_matches_connectargs(devices[i]->d_name, args)) {
+		if (ctrl_matches_connectargs(devices[i]->d_name, args, false)) {
 			devname = strdup(devices[i]->d_name);
 			if (devname == NULL)
 				fprintf(stderr, "no memory for ctrl name %s\n",
@@ -1372,7 +1378,7 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	if (!cargs)
 		return -ENOMEM;
 
-	if (!cfg.device || !ctrl_matches_connectargs(cfg.device, cargs))
+	if (!cfg.device || !ctrl_matches_connectargs(cfg.device, cargs, true))
 		cfg.device = find_ctrl_with_connectargs(cargs);
 	free_connect_args(cargs);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
