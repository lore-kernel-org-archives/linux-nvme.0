Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C735C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A7A221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A7A221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+WV0JgI3w69fZuH9XAxCR5e+tVStezyDbmc3OqCRFX8=; b=uKUjdOxa/VBI+shfdX+Hsfk4H
	asoc/ur1hRUqfU1EAls83NM6Aagg29vwRP0nuPqCTCf1qWw1KLzdRt2vzg8XZUdscHUEGnJLEVGPc
	E7a/1KSbUO3dj+1uf+J3q6yQzkj0TumN8AsVifutj952rWJpLqcZd1f8prqun92pyaRNPpOIISqQJ
	ATcyY1OCXmc4FN8z7x/SavHgTnq2jIJ5GdttlaBB5X0/6dfZiUiJbmpp8T37mxgS9qrseSCAHnyYS
	CeboaBWuVydrnii5PyWInoNuPfjr2w1QiOLoGS4PWKblNARtpgZPnYITlQIMzV47VoZruhlvM4obt
	PmYFDGXnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V39-0001Pn-NJ; Tue, 26 Jan 2021 20:34:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V28-0000yC-KS
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+l55K/GBuORPHy5zf+uqeI00xYSOSv2JaHnkP31Gsc8=;
 b=dmZRnHtiAN2ViKvTHKqO7dIK2OnT8sV7fJdY86jLeiJcZ0IBnxpbLlScsDQS0W5rJi8F6D
 W127KGmHY7KIV51hw68poeWyxnUWZB4j4Cj0RADvei4NSpUGE9+qfTVKsp8x6uhfVAov6H
 WTajShgtZA7E52ptOuEB4aLbd+6xC84=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A5E82AF00;
 Tue, 26 Jan 2021 20:33:47 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 17/35] monitor: handle SIGCHLD for terminated child processes
Date: Tue, 26 Jan 2021 21:33:06 +0100
Message-Id: <20210126203324.23610-18-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153352_856971_AC98D19D 
X-CRM114-Status: GOOD (  17.27  )
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

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9375a14..8db40e6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -26,6 +26,8 @@
 #include <limits.h>
 #include <syslog.h>
 #include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <sys/epoll.h>
 
 #include "common.h"
@@ -100,6 +102,13 @@ static void monitor_int_handler(int sig)
 	must_exit = 1;
 }
 
+static sig_atomic_t got_sigchld;
+
+static void monitor_chld_handler(int sig)
+{
+	got_sigchld = 1;
+}
+
 static sigset_t orig_sigmask;
 
 static int monitor_init_signals(void)
@@ -118,6 +127,9 @@ static int monitor_init_signals(void)
 		return -errno;
 	if (sigaction(SIGINT, &sa, NULL) == -1)
 		return -errno;
+	sa.sa_handler = monitor_chld_handler;
+	if (sigaction(SIGCHLD, &sa, NULL) == -1)
+		return -errno;
 	return 0;
 }
 
@@ -336,6 +348,34 @@ static void monitor_handle_uevents(struct udev_monitor *monitor)
 	}
 }
 
+static void handle_sigchld(void)
+{
+	while (true) {
+		int wstatus;
+		pid_t pid;
+
+		pid = waitpid(-1, &wstatus, WNOHANG);
+		switch(pid) {
+		case -1:
+			if (errno != ECHILD)
+				log(LOG_ERR, "error in waitpid: %m\n");
+			return;
+		case 0:
+			return;
+		default:
+			break;
+		}
+		if (!WIFEXITED(wstatus))
+			log(LOG_WARNING, "child %ld didn't exit normally\n",
+			    (long)pid);
+		else if (WEXITSTATUS(wstatus) != 0)
+			log(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
+			    (long)pid, strerror(WEXITSTATUS(wstatus)));
+		else
+			log(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
+	};
+}
+
 #define MAX_EVENTS 1
 static int monitor_main_loop(struct udev_monitor *monitor)
 {
@@ -357,13 +397,19 @@ static int monitor_main_loop(struct udev_monitor *monitor)
 	sigfillset(&ep_mask);
 	sigdelset(&ep_mask, SIGTERM);
 	sigdelset(&ep_mask, SIGINT);
+	sigdelset(&ep_mask, SIGCHLD);
 	while (1) {
 		int rc, i;
 
 		rc = epoll_pwait(ep_fd, events, MAX_EVENTS, -1, &ep_mask);
 		if (rc == -1 && errno == EINTR) {
-			log(LOG_NOTICE, "monitor: exit signal received\n");
-			return 0;
+			if (must_exit) {
+				log(LOG_NOTICE, "monitor: exit signal received\n");
+				return 0;
+			} else if (got_sigchld) {
+				got_sigchld = 0;
+				handle_sigchld();
+			}
 		} else if (rc == -1) {
 			log(LOG_ERR, "monitor: epoll_wait: %m\n");
 			return -errno;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
