Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C111C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8E221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8E221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yBehFsNOX9q4Ct9egL5SRkl9T/GAHyrK0USPfil/ZUU=; b=u5DQIE0EpMqV4vnzjktXn4pxg
	uDsSb+wFvpxAyYVCmBQb2+s3zztcDmp6l5aZvP+7VBhyYYA6mdjT9Gm2oxShl/BqITiaXIV2cqauW
	/dukJ5pgCD46GAic7SxWHCbQAsBUe/2Q//cifhs8bsEiPqfTK6ZVlC4r2bFIrLNlg9Aj8nqTO24RS
	Wgp4G+QPslHAXgYTiuN95VHSnyEozye9BJ9FtCcLfMassyYdb6a/lHUpTvyq8l66jdxZioXtJeIjb
	OMGSb9vAs4R8RsVCpdmNjwCIxLNyei/v4i0nxb1WI3gpYq+WrHxedTOr1zitvaEkAW0ak7ieTcGw/
	A9JSrF3NQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3l-0001jl-Sp; Tue, 26 Jan 2021 20:35:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00010e-A4
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiPRC2pbRs8UO2V47THux0Cge4QkeXhkmbgyZIo1T5I=;
 b=PXtYL3HUzwhB13HI8ziYvQ8V+xM8GgB2Jnj04xgGA0OuquuqFt2OkQHj8zMbsHKuEEVgO6
 aSY4eo4Yj4T7CSTULNBaQu3dkZGqOuUtea5203Qf/ziUDlO8XeLP6NEFgBwFfQzixT1ZbB
 5NrigQJ4UaGHV/MJUO1G/x4P2La3jS8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 15640AEAC;
 Tue, 26 Jan 2021 20:33:49 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 23/35] monitor: handle restart of pending discoveries
Date: Tue, 26 Jan 2021 21:33:12 +0100
Message-Id: <20210126203324.23610-24-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_529756_C4D3E45F 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

If a new discovery event is received while a discovery task is
running, no new task should be started in parallel to the previous
one. Rather, we should note that another event has happened,
and restart the discovery after the current task has finished.

There is no need to remember more than one pending discovery.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 419c5f5..b44ff7a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "util/argconfig.h"
 #include "fabrics.h"
 #include "monitor.h"
+#include "conn-db.h"
 #define LOG_FUNCNAME 1
 #include "log.h"
 
@@ -199,12 +200,22 @@ static int monitor_get_fc_uev_props(struct udev_device *ud,
 	return 0;
 }
 
-static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
-			     char *host_traddr)
+static int monitor_discovery(const char *transport, const char *traddr,
+			     const char *trsvcid, const char *host_traddr)
 {
 	char argstr[BUF_SIZE];
 	pid_t pid;
-	int rc;
+	int rc, db_rc;
+	struct nvme_connection *co = NULL;
+
+	db_rc = conndb_add(transport, traddr, trsvcid, host_traddr, &co);
+	if (db_rc != 0 && db_rc != -EEXIST)
+		return db_rc;
+
+	if (co->status == CS_DISC_RUNNING) {
+		co->discovery_pending = 1;
+		return -EAGAIN;
+	}
 
 	pid = fork();
 	if (pid == -1) {
@@ -212,17 +223,26 @@ static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
 		return -errno;
 	} else if (pid > 0) {
 		log(LOG_DEBUG, "started discovery task %ld\n", (long)pid);
+
+		co->discovery_pending = 0;
+		co->status = CS_DISC_RUNNING;
+		co->discovery_task = pid;
+
 		return 0;
 	}
 
 	child_reset_signals();
 
-	log(LOG_NOTICE, "starting %s discovery for %s==>%s(%s)\n",
-	    transport, host_traddr, traddr, trsvcid ? trsvcid : "none");
+	log(LOG_NOTICE, "starting discovery for <%s>: %s ==> %s(%s) in state %s\n",
+	    transport, host_traddr, traddr,
+	    trsvcid && *trsvcid ? trsvcid : "none",
+	    conn_status_str(co->status));
+
+
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 	cfg.transport = transport;
 	cfg.traddr = traddr;
-	cfg.trsvcid = trsvcid;
+	cfg.trsvcid = trsvcid && *trsvcid ? trsvcid : NULL;
 	cfg.host_traddr = host_traddr;
 	/* Without the following, the kernel returns EINVAL */
 	cfg.tos = -1;
@@ -351,6 +371,7 @@ static void monitor_handle_uevents(struct udev_monitor *monitor)
 static void handle_sigchld(void)
 {
 	while (true) {
+	struct nvme_connection *co;
 		int wstatus;
 		pid_t pid;
 
@@ -365,14 +386,33 @@ static void handle_sigchld(void)
 		default:
 			break;
 		}
-		if (!WIFEXITED(wstatus))
+		co = conndb_find_by_pid(pid);
+		if (!co) {
+			log(LOG_ERR, "no connection found for discovery task %ld\n",
+			    (long)pid);
+			continue;
+		}
+		if (!WIFEXITED(wstatus)) {
 			log(LOG_WARNING, "child %ld didn't exit normally\n",
 			    (long)pid);
-		else if (WEXITSTATUS(wstatus) != 0)
+			co->status = CS_FAILED;
+		} else if (WEXITSTATUS(wstatus) != 0) {
 			log(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
 			    (long)pid, strerror(WEXITSTATUS(wstatus)));
-		else
+			co->status = CS_FAILED;
+			co->did_discovery = 1;
+			co->discovery_result = WEXITSTATUS(wstatus);
+		} else {
 			log(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
+			co->status = CS_ONLINE;
+			co->successful_discovery = co->did_discovery = 1;
+			co->discovery_result = 0;
+		}
+		if (co->discovery_pending) {
+			log(LOG_NOTICE, "new discovery pending - restarting\n");
+			monitor_discovery(co->transport, co->traddr,
+					  co->trsvcid, co->host_traddr);
+		}
 	};
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
