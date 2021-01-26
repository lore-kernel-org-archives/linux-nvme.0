Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ECBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3888522A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3888522A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n6HXKKRibVEnnq1M1C5npK10mHq5/4+Dk0BJvT4LL3A=; b=xWeCzO4MhqAkifIWJWMd04PAi
	HWWOqqgrY4DT/B1BjZ8Zp0+Ayb95sQb/Gaw8rsmTx1HOFb2OUk+x5m8uUhYJpdi/JyOnOVlY/o59e
	PLJgKFDx84sKGNrxZx2lRkr3/lskE6DRFeiCVZAJUcewEdpM2SVt2e1iR+zUBCp4kj4PXpl+y1qWj
	b+PK9Z/fPQs/CgQOiTM1mEj6Zc76XVdq2KSA07JspbHxuPEkoHENQm6eBAd7UQSgd8om2WGZJBr5O
	O5u8gdicAcwa2OshOHNo1QJ6xJ9Q6r4nJopLO3yOI29AoUIacbfmABDhEozE+uefD8wqTOhJ4ZH4+
	I2ADgZYpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2f-0001Ax-36; Tue, 26 Jan 2021 20:34:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V24-0000vS-38
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rGeY/axqdqx9OcR3QEvFnNju2+l64aA5HXdNqlK5Os=;
 b=P1EOLC7da+kmlEkltaMfUF+j5n4haXYYlBqRv5M6oRIl7QOwcQNm6nFtiGsbFwH/1n+Lm3
 df4dUblbeQCWzaVeD6+cGPHrLXZAnGf/T6Qa0gXp1aSVeEOR6Tyo3t+YrAddz9L8lbC/2F
 HZ67LY27Zk06Pn/GnEuI1BjMEjTdyWk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2880AF6C;
 Tue, 26 Jan 2021 20:33:44 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 08/35] monitor: add command line options to control logging
Date: Tue, 26 Jan 2021 21:32:57 +0100
Message-Id: <20210126203324.23610-9-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153348_414016_FD9E2C71 
X-CRM114-Status: GOOD (  18.03  )
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

Standard syslog loglevels are used.
Options:

 -S/--silent   to suppress LOG_NOTICE
 -v/--verbose  to enable LOG_INFO (overrides -S)
 -D/--debug    to enable LOG_DEBUG (overrides -S, -v)
 -C/--clockstamps to enable time stamps on log messages.

I tried to use short options that don't conflict with options
from nvme connect-all, because many of those options might be
useful for the monitor, too.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index a6c8905..a7afa1c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -21,10 +21,15 @@
 #include <errno.h>
 #include <libudev.h>
 #include <signal.h>
+#include <time.h>
+#include <syslog.h>
 #include <sys/epoll.h>
 
 #include "nvme-status.h"
+#include "util/argconfig.h"
 #include "monitor.h"
+#define LOG_FUNCNAME 1
+#include "log.h"
 
 static struct udev *udev;
 
@@ -103,7 +108,7 @@ static int monitor_init_signals(void)
 
 static void monitor_handle_udevice(struct udev_device *ud)
 {
-	fprintf(stderr, "uevent: %s %s\n",
+	log(LOG_INFO, "uevent: %s %s\n",
 		udev_device_get_action(ud),
 		udev_device_get_sysname(ud));
 }
@@ -146,33 +151,63 @@ static int monitor_main_loop(struct udev_monitor *monitor)
 
 		rc = epoll_pwait(ep_fd, events, MAX_EVENTS, -1, &ep_mask);
 		if (rc == -1 && errno == EINTR) {
-			fprintf(stderr, "monitor: exit signal received\n");
+			log(LOG_NOTICE, "monitor: exit signal received\n");
 			return 0;
 		} else if (rc == -1) {
-			fprintf(stderr, "monitor: epoll_wait: %m\n");
+			log(LOG_ERR, "monitor: epoll_wait: %m\n");
 			return -errno;
 		} else if (rc == 0 || rc > MAX_EVENTS) {
-			fprintf(stderr, "monitor: epoll_wait: unexpected rc=%d\n", rc);
+			log(LOG_ERR, "monitor: epoll_wait: unexpected rc=%d\n", rc);
 			continue;
 		}
 		for (i = 0; i < MAX_EVENTS; i++) {
 			if (events[i].data.ptr == monitor)
 				(void)monitor_handle_uevents(monitor);
 			else
-				fprintf(stderr, "monitor: unexpected event\n");
+				log(LOG_ERR, "monitor: unexpected event\n");
 		}
 	}
 	return ret;
 }
 
+static int monitor_parse_opts(const char *desc, int argc, char **argv)
+{
+	bool quiet = false;
+	bool verbose = false;
+	bool debug = false;
+	int ret;
+	OPT_ARGS(opts) = {
+		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
+		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
+		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
+		OPT_FLAG("clockstamps",    'C', &log_timestamp,       "print log timestamps"),
+		OPT_END()
+	};
+
+	ret = argconfig_parse(argc, argv, desc, opts);
+	if (ret)
+		return ret;
+	if (quiet)
+		log_level = LOG_WARNING;
+	if (verbose)
+		log_level = LOG_INFO;
+	if (debug)
+		log_level = LOG_DEBUG;
+
+	return ret;
+}
+
 int aen_monitor(const char *desc, int argc, char **argv)
 {
 	int ret;
 	struct udev_monitor *monitor;
 
+	ret = monitor_parse_opts(desc, argc, argv);
+	if (ret)
+		goto out;
 	ret = monitor_init_signals();
 	if (ret != 0) {
-		fprintf(stderr, "monitor: failed to initialize signals: %m\n");
+		log(LOG_ERR, "monitor: failed to initialize signals: %m\n");
 		goto out;
 	}
 	ret = create_udev_monitor(&monitor);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
