Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFC3221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFC3221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0O+ybu0poxAGV0pXTzZaivF+u69MFNojhYHxJba7HTo=; b=1loF7JTZUdlzoUtezLZc51hJo
	Pf4idkLHAztkeylcOMTcWRJeXHZ/JnwZMvJpTl1QmJDOMqgJHbXuH7h+f/MaMaWsN3jXjX18w+n2Z
	2XgGMiQpirbOoJSCVvkI3l9lofVQqdyZlx/P/R0QokiHyVnbnr8r9Ja2pCq7QAvUn4t+Gr78y8dWo
	iuKuS6v+HkmajgW3s+aCoo+jf279YcYUcD4cXsRsjVXxn++vN4t6LBAp+5KlOms4tnBNceF5P0NEx
	5Envk3gbubi8/DFTh0NSinIONlst+7tfyGxxg2OG+pEoZEGXQsec3BKxECq/Sn3PRk5Z6qPKHAk82
	o3ITIYi7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3D-0001Rj-7l; Tue, 26 Jan 2021 20:34:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V27-0000xs-ON
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqYq6i+77Cc3/8pGBrBQIIJQy3ewKxUL6VSxVIAyWKg=;
 b=XNokWBEw9Zlldarw8DTZ/DYN0FroMBGYPJHvYkln7qwXAzLNlegenK7LkBA5wiICd453ib
 mb8oU89yfvkpVgVr/JW62YMiakXr7IcfkXaQk3ugvCdDKwQtw6KXy90YaCD5PpfQaS3H8+
 USCsQEZcrXNeK82VEoZmomzsFtrZAEg=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 13018AFFA;
 Tue, 26 Jan 2021 20:33:46 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 13/35] monitor: disable nvmf-autoconnect udev rules in
 autoconnect mode
Date: Tue, 26 Jan 2021 21:33:02 +0100
Message-Id: <20210126203324.23610-14-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153352_152326_FBE447DA 
X-CRM114-Status: GOOD (  21.30  )
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

If autoconnect is enabled, disable the respective udev rules
by symlinking /run/udev/rules.d to /dev/null, in order to avoid
the connections being set up by the monitor and the udev workers
at the same time. This is probably the preferred mode of operation
for the monitor.

Users can override this by copying 70-nvmf-autoconnect.rules
from /usr/lib/udev/rules.d to /etc/udev/rules.d (/etc/udev/rules.d
takes precedence over /run/udev/rules.d).

If the symlink can't be created for some reason, autoconnect will
be disabled. There is  only one exception: If
/run/udev/rules.d/70-nvmf-autoconnect.rules already points to
/dev/null at startup, autoconnect can be left on, but the symlink
isn't removed on exit.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index ecf3be2..2a906db 100644
--- a/monitor.c
+++ b/monitor.c
@@ -17,14 +17,18 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
 #include <libudev.h>
 #include <signal.h>
 #include <time.h>
+#include <limits.h>
 #include <syslog.h>
+#include <sys/stat.h>
 #include <sys/epoll.h>
 
+#include "common.h"
 #include "nvme-status.h"
 #include "util/argconfig.h"
 #include "monitor.h"
@@ -33,6 +37,7 @@
 
 static struct monitor_config {
 	bool autoconnect;
+	bool skip_udev_on_exit;
 } mon_cfg;
 
 static struct udev *udev;
@@ -45,6 +50,8 @@ static void close_ptr(int *p)
 	}
 }
 
+CLEANUP_FUNC(char)
+
 static void cleanup_monitor(struct udev_monitor **pmon)
 {
 	if (*pmon) {
@@ -174,12 +181,64 @@ static int monitor_main_loop(struct udev_monitor *monitor)
 	return ret;
 }
 
+static const char autoconnect_rules[] = "/run/udev/rules.d/70-nvmf-autoconnect.rules";
+
+static int monitor_disable_udev_rules(void)
+{
+	CLEANUP(char, path) = strdup(autoconnect_rules);
+	char *s1, *s2;
+	int rc;
+
+	if (!path)
+		return -ENOMEM;
+
+	s2 = strrchr(path, '/');
+	for (s1 = s2 - 1; s1 > path && *s1 != '/'; s1--);
+
+	*s2 = *s1 = '\0';
+	rc = mkdir(path, 0755);
+	if (rc == 0 || errno == EEXIST) {
+		*s1 = '/';
+		rc = mkdir(path, 0755);
+		if (rc == 0 || errno == EEXIST) {
+			*s2 = '/';
+			rc = symlink("/dev/null", path);
+		}
+	}
+	if (rc) {
+		if (errno == EEXIST) {
+			char target[PATH_MAX];
+
+			if (readlink(path, target, sizeof(target)) != -1 &&
+			    !strcmp(target, "/dev/null")) {
+				log(LOG_INFO,
+				    "symlink %s -> /dev/null exists already\n",
+				    autoconnect_rules);
+				return 1;
+			}
+		}
+		log(LOG_ERR, "error creating %s: %m\n", autoconnect_rules);
+	} else
+		log(LOG_INFO, "created %s\n", autoconnect_rules);
+
+	return rc ? (errno ? -errno : -EIO) : 0;
+}
+
+static void monitor_enable_udev_rules(void)
+{
+	if (unlink(autoconnect_rules) == -1 && errno != ENOENT)
+		log(LOG_ERR, "error removing %s: %m\n", autoconnect_rules);
+	else
+		log(LOG_INFO, "removed %s\n", autoconnect_rules);
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
 	bool verbose = false;
 	bool debug = false;
-	int ret;
+	int ret = 0;
+
 	OPT_ARGS(opts) = {
 		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
@@ -198,7 +257,17 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 		log_level = LOG_INFO;
 	if (debug)
 		log_level = LOG_DEBUG;
-
+	if (mon_cfg.autoconnect) {
+		ret = monitor_disable_udev_rules();
+		if (ret < 0) {
+			mon_cfg.autoconnect = false;
+			log(LOG_WARNING, "autoconnect disabled\n");
+			ret = 0;
+		} else if (ret > 0) {
+			mon_cfg.skip_udev_on_exit = true;
+			ret = 0;
+		}
+	}
 	return ret;
 }
 
@@ -221,6 +290,8 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		udev_monitor_unref(monitor);
 	}
 	udev = udev_unref(udev);
+	if (mon_cfg.autoconnect && !mon_cfg.skip_udev_on_exit)
+		monitor_enable_udev_rules();
 out:
 	return nvme_status_to_errno(ret, true);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
