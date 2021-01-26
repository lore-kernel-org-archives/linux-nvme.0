Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3904C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6964B22B2C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6964B22B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7I6PTGQyVqL8EjdyVIwvRo1p6GSE7LbYVqt0eS3Na1s=; b=EsDvI5FMqihgzAvqXrr+t39SB
	GSxJe9JYyNkEydg+BbYdSmVY9ykEo7vMik1IzIP92xtBRr9cgHJ3N8z4PytrFTX9q9ZjOyz7+dKeK
	9we0RfsZ7zercrvuzp05bJF5lcCOAaM3NpeXxjOz4KPigd5r1AiBGPyI/gOPfx+tSv3QIIKaT8U5n
	l2upNlHL0RkMqUdnJVO4F/ZKJpRWS4aB9jP5MVhGLgkaj4vIHIVNp5ClLaQssS59969tVCM8fBwN7
	TzAtYufsiSTWiQz2YOFk5wZhHimUl46zteA8yhQUxJiOAjBlw5Ws5vzebAWArNj1igC5hgyKFSE1Q
	cJrjspZ9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2B-00010d-7z; Tue, 26 Jan 2021 20:33:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V21-0000ty-PH
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MW6jarzl0Mb8d0ivB3XjKoNHVqkK6Kxfg+Sf7bXWy4s=;
 b=PZB61Y4d4u/dHp3hbh11nMlXdt/UHm5aqfx+U7QP429HPY7KXJ+jYgHgpGeVmXnugSZB6J
 +ECn5lQgN8gkKX86tk6PgMS94h9vUQWk6BaReQirnXxmuRynYjPV7LF/fBG3wh9CTkyjv3
 wUkYNiDTWMjyiP22YorEdyogE5c3lFU=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 905CFAF1A;
 Tue, 26 Jan 2021 20:33:43 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 04/35] monitor: add main loop for uevent monitoring
Date: Tue, 26 Jan 2021 21:32:53 +0100
Message-Id: <20210126203324.23610-5-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153346_043059_1F7058BA 
X-CRM114-Status: GOOD (  18.89  )
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
 monitor.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index c7f4d85..63e26bc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -17,15 +17,25 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <errno.h>
 #include <libudev.h>
 #include <signal.h>
+#include <sys/epoll.h>
 
 #include "nvme-status.h"
 #include "monitor.h"
 
 static struct udev *udev;
 
+static void close_ptr(int *p)
+{
+	if (*p != -1) {
+		close(*p);
+		*p = -1;
+	}
+}
+
 static void cleanup_monitor(struct udev_monitor **pmon)
 {
 	if (*pmon) {
@@ -87,6 +97,70 @@ static int monitor_init_signals(void)
 	return 0;
 }
 
+static void monitor_handle_udevice(struct udev_device *ud)
+{
+	fprintf(stderr, "uevent: %s %s\n",
+		udev_device_get_action(ud),
+		udev_device_get_sysname(ud));
+}
+
+static void monitor_handle_uevents(struct udev_monitor *monitor)
+{
+	struct udev_device *ud;
+
+	for (ud = udev_monitor_receive_device(monitor);
+	     ud;
+	     ud = udev_monitor_receive_device(monitor)) {
+		monitor_handle_udevice(ud);
+		udev_device_unref(ud);
+	}
+}
+
+#define MAX_EVENTS 1
+static int monitor_main_loop(struct udev_monitor *monitor)
+{
+	int ep_fd __attribute__((cleanup(close_ptr))) = -1;
+	int ret;
+	struct epoll_event ep_ev = { .events = EPOLLIN, };
+	struct epoll_event events[MAX_EVENTS];
+	sigset_t ep_mask;
+
+	ep_fd = epoll_create1(0);
+	if (ep_fd == -1)
+		return -errno;
+	ep_ev.data.ptr = monitor;
+	ret = epoll_ctl(ep_fd, EPOLL_CTL_ADD,
+			udev_monitor_get_fd(monitor), &ep_ev);
+	if (ret == -1)
+		return -errno;
+
+	sigfillset(&ep_mask);
+	sigdelset(&ep_mask, SIGTERM);
+	sigdelset(&ep_mask, SIGINT);
+	while (1) {
+		int rc, i;
+
+		rc = epoll_pwait(ep_fd, events, MAX_EVENTS, -1, &ep_mask);
+		if (rc == -1 && errno == EINTR) {
+			fprintf(stderr, "monitor: exit signal received\n");
+			return 0;
+		} else if (rc == -1) {
+			fprintf(stderr, "monitor: epoll_wait: %m\n");
+			return -errno;
+		} else if (rc == 0 || rc > MAX_EVENTS) {
+			fprintf(stderr, "monitor: epoll_wait: unexpected rc=%d\n", rc);
+			continue;
+		}
+		for (i = 0; i < MAX_EVENTS; i++) {
+			if (events[i].data.ptr == monitor)
+				(void)monitor_handle_uevents(monitor);
+			else
+				fprintf(stderr, "monitor: unexpected event\n");
+		}
+	}
+	return ret;
+}
+
 int aen_monitor(const char *desc, int argc, char **argv)
 {
 	int ret;
@@ -98,8 +172,10 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		goto out;
 	}
 	ret = create_udev_monitor(&monitor);
-	if (ret == 0)
+	if (ret == 0) {
+		ret = monitor_main_loop(monitor);
 		udev_monitor_unref(monitor);
+	}
 	udev = udev_unref(udev);
 out:
 	return nvme_status_to_errno(ret, true);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
