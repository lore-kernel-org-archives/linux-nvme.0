Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EEC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:46:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7E664F52
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E664F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BEts6qQBelEJ/JxYz2Fe6u5NLZLJCIYtsEY2oHEpKSc=; b=mIZnkBP3jDq9nZ8Dcqi8D0R8Y
	VaNOgEndKwS/L6AtaSqFcPQrhGQ6eUD9lvNTZ9ITdVoVS+T9v/TNtmYtV8SJZN6L87ZyXG1uH8VYd
	5CRfKhPJTZ+aIfVOJqDMwMqZ9AUaF4VRQMa+3MFbPPFMTTe+EM7RUn41A269seAB9f0Tknn2lR4ck
	mEw574pFLgWmFz/C4GTB6ttyg0GwZ7Z5VFp70qFhgP2QSOepOqjsQJ47G1Pd4bAH0tn/UqGJ2wtwx
	zGLd5OjE6TPl+QSNxW/qHJRDxx+m0gCojNHAz1ZC2AA9+poVwcB0JxU53SHUxHS+zk4yP8nR997zC
	BkrUaccig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL5U-00HYhd-Pv; Sat, 06 Mar 2021 00:46:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwd-00HVjr-Pb
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCbpOYbAmVbLM6pLVKBtvGTBZR//x1BzjN2tKbbl8QQ=;
 b=B4j3YqRSqo0OOc+5OUbKtZhN9cPuNL3b6hRBQZ/bMN0ShmhD45gqOXWBNnurEYdH+U7vdw
 QPWgHIxCVAjOOVz+q/6FHSf/19vHeVAy/H9GsppI/9vIYRCx1uYkKF0L6eWrthvwJgnlAG
 O2kbAg9oGor8UWtA5+eleMjKV4uz+SQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 41CB8AF38;
 Sat,  6 Mar 2021 00:37:19 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 11/16] monitor: watch discovery.conf with inotify
Date: Sat,  6 Mar 2021 01:36:54 +0100
Message-Id: <20210306003659.21207-12-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003725_654063_50632161 
X-CRM114-Status: GOOD (  16.18  )
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

Watch discovery.conf, and re-start discovery from conf file
whenever it's created or changed.
---
 monitor.c      | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/cleanup.c |   2 +
 util/cleanup.h |   1 +
 3 files changed, 117 insertions(+)

diff --git a/monitor.c b/monitor.c
index 95dea19..a1229a7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <libudev.h>
 #include <signal.h>
 #include <time.h>
@@ -28,6 +29,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/epoll.h>
+#include <sys/inotify.h>
 
 #include "nvme-status.h"
 #include "nvme.h"
@@ -448,6 +450,14 @@ static int monitor_handle_uevents(struct event *ev,
 	return EVENTCB_CONTINUE;
 }
 
+static struct {
+	bool running;
+	bool pending;
+	pid_t pid;
+} discovery_conf_task;
+
+static int monitor_discover_from_conf_file(void);
+
 static int handle_epoll_err(int errcode)
 {
 	if (errcode != -EINTR)
@@ -488,6 +498,15 @@ static int handle_epoll_err(int errcode)
 				    (long)pid, strerror(WEXITSTATUS(wstatus)));
 			else
 				msg(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
+			if (discovery_conf_task.running &&
+			    discovery_conf_task.pid == pid) {
+				discovery_conf_task.running = false;
+				if (discovery_conf_task.pending) {
+					msg(LOG_NOTICE,
+					    "discovery from conf file pending - restarting\n");
+					monitor_discover_from_conf_file();
+				}
+			}
 			continue;
 		}
 
@@ -586,6 +605,13 @@ static int monitor_discover_from_conf_file(void)
 	pid_t pid;
 	int rc;
 
+	if (discovery_conf_task.running) {
+		msg(LOG_NOTICE, "discovery from conf file already running (%ld)\n",
+		    (long)discovery_conf_task.pid);
+		discovery_conf_task.pending = true;
+		return 0;
+	}
+
 	pid = fork();
 	if (pid == -1) {
 		msg(LOG_ERR, "failed to fork discovery task: %m");
@@ -593,6 +619,9 @@ static int monitor_discover_from_conf_file(void)
 	} else if (pid > 0) {
 		msg(LOG_DEBUG, "started discovery task %ld from conf file\n",
 		    (long)pid);
+		discovery_conf_task.pending = false;
+		discovery_conf_task.running = true;
+		discovery_conf_task.pid = pid;
 		return 0;
 	}
 
@@ -619,6 +648,89 @@ static int discovery_from_conf_file_cb(struct event *ev __attribute__((unused)),
 	return EVENTCB_CLEANUP;
 }
 
+static void handle_inotify_event(struct inotify_event *iev)
+{
+	if ((iev->mask & (IN_CLOSE_WRITE|IN_MOVED_TO)) == 0) {
+		msg(LOG_DEBUG, "ignoring event mask 0x%"PRIx32"\n", iev->mask);
+		return;
+	}
+
+	if (!iev->name || strcmp(iev->name, FILE_NVMF_DISC)) {
+		msg(LOG_DEBUG, "ignoring event mask 0x%"PRIx32" for %s\n",
+		    iev->mask, iev->name ? iev->name : "(null)");
+		return;
+	}
+
+	msg(LOG_INFO, "discovery.conf changed, re-reading\n");
+	monitor_discover_from_conf_file();
+}
+
+static int inotify_cb(struct event *ev, unsigned int ep_events)
+{
+	char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
+	int rc;
+
+	if (ev->reason != REASON_EVENT_OCCURED || (ep_events & EPOLLIN) == 0)
+		return EVENTCB_CONTINUE;
+
+	while (true) {
+		struct inotify_event *iev;
+
+		rc = read(ev->fd, buf, sizeof(buf));
+		if (rc == -1) {
+			if (errno != EAGAIN)
+				msg(LOG_ERR, "error reading from inotify fd: %m\n");
+			return EVENTCB_CONTINUE;
+		}
+
+		iev = (struct inotify_event *)buf;
+		if (iev->mask & (IN_DELETE_SELF|IN_MOVE_SELF)) {
+			if (inotify_rm_watch(ev->fd, iev->wd) == -1)
+				msg(LOG_ERR, "failed to remove watch %d: %m\n",
+				    iev->wd);
+			msg(LOG_WARNING, "inotify watch %d removed\n", iev->wd);
+			return EVENTCB_CLEANUP;
+		}
+		handle_inotify_event(iev);
+	}
+	return EVENTCB_CONTINUE;
+}
+
+static DEFINE_CLEANUP_FUNC(cleanup_event, struct event *, free);
+
+static void add_inotify_event(struct dispatcher *dsp)
+{
+	struct event *inotify_event __cleanup__(cleanup_event) = NULL;
+	int fd __cleanup__(cleanup_fd) = -1;
+	int rc;
+
+	inotify_event = calloc(1, sizeof *inotify_event);
+	if (!inotify_event)
+		return;
+
+	fd = inotify_init1(IN_NONBLOCK|IN_CLOEXEC);
+	if (fd == -1) {
+		msg(LOG_ERR, "failed to init inotify: %m\n");
+		return;
+	}
+
+	*inotify_event = EVENT_ON_HEAP(inotify_cb, fd, EPOLLIN);
+	rc = inotify_add_watch(inotify_event->fd, PATH_NVMF_CFG_DIR,
+			       IN_CLOSE_WRITE|IN_MOVED_TO|
+			       IN_DELETE_SELF|IN_MOVE_SELF);
+	if (rc == -1)
+		msg(LOG_ERR, "failed to add inotify watch for %s: %m\n",
+		    PATH_NVMF_CFG_DIR);
+
+	if ((rc = event_add(dsp, inotify_event)) < 0) {
+		msg(LOG_ERR, "failed to add inotify event: %s\n",
+		    strerror(-rc));
+		return;
+	}
+	fd = -1;
+	inotify_event = NULL;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -735,7 +847,9 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		goto out;
 	}
 
+	add_inotify_event(mon_dsp);
 	conndb_init_from_sysfs();
+
 	ret = event_loop(mon_dsp, &wait_mask, handle_epoll_err);
 
 	conndb_for_each(monitor_kill_discovery_task, NULL);
diff --git a/util/cleanup.c b/util/cleanup.c
index 0d5d910..3101e1a 100644
--- a/util/cleanup.c
+++ b/util/cleanup.c
@@ -1,4 +1,6 @@
 #include <stdlib.h>
+#include <unistd.h>
 #include "cleanup.h"
 
 DEFINE_CLEANUP_FUNC(cleanup_charp, char *, free);
+DEFINE_CLEANUP_FUNC(cleanup_fd, int, close);
diff --git a/util/cleanup.h b/util/cleanup.h
index 89a4984..b039488 100644
--- a/util/cleanup.h
+++ b/util/cleanup.h
@@ -14,5 +14,6 @@ DECLARE_CLEANUP_FUNC(name, type)		\
 }
 
 DECLARE_CLEANUP_FUNC(cleanup_charp, char *);
+DECLARE_CLEANUP_FUNC(cleanup_fd, int);
 
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
