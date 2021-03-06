Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87675C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:41:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FB265077
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FB265077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EH/75/u6pfcEbwOo9jJxFpfGEGiFWU5WCaZ6t3bhvGo=; b=BDKtR0Fjxi5rhvCjaj7kbYsvm
	+Zcd57+Ojrg3zJWZitmW4SWFTrseGCWgg6xKu93Dj300HcpnbMV2PtNZuwleFrM2NMiGINCcE97t5
	7AUQ3HM0aMlCpXgpu1hsHSeWh88R/6Gtha94BAIKIc5tpmwcLxp9ZEIcFINxOA2Xb9uCeOPTCdgwM
	0Q/3IdIwvHDwWPFmlRMllV8Iq8OIj64ulnQNw7wIySFF0+1fjo1waBq+Q0ZBN7ezGFf1LADlYclX/
	Js7C/bUZDlo67pyV/cqXaUUMHYeeRqZZ0FjSjn+8fDRn8F6WnaQnBRX+ZHsHuD50vJ5r3MQlQaziz
	sU1CrbwgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL07-00HX6W-HH; Sat, 06 Mar 2021 00:40:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwW-00HVfb-OB
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMhfhWynV1ibquFqnkIvGUPbdPffuHGh55Y6WOKITjY=;
 b=iBv9i/6HaQu+xlYX7fspXE3LKL+r1KlvVB6qMLL9R2uggPUIT1f6GCDzl1a5ad8r9ThL4R
 tmlaC1dl3WUCpV95lZ6GJ2kVDK+kN6A9h6X2fOE0MiUhZQQCpmY+6uLbvHs8HguD5mp47r
 ba+WEgebjlYFGVkiEkcypFdT7K30dHY=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5F3D1AE42;
 Sat,  6 Mar 2021 00:37:16 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 03/16] monitor: add basic "nvme monitor" functionality
Date: Sat,  6 Mar 2021 01:36:46 +0100
Message-Id: <20210306003659.21207-4-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_246046_301F2778 
X-CRM114-Status: GOOD (  32.21  )
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

"nvme monitor" listens for uevents related to NVMe discovery
and attemtps to auto-connect newly discovered controllers.
Currently NVMeFC events via fc_udev_device and AEN events from
NVMe discovery controllers are supported.

This patch adds the main event listening functionality. Actual
event handling will be added in the forthcoming patches.

Options:

 -N/--no-connect for "dry run" mode
 -S/--silent   to suppress LOG_NOTICE
 -v/--verbose  to enable LOG_INFO (overrides -S)
 -D/--debug    to enable LOG_DEBUG (overrides -S, -v)
 -t/--timestamps to enable time stamps on log messages.

I tried to use short options that don't conflict with options
from nvme connect-all, because many of those options will be added
to the monitor later, too.
---
 .github/workflows/c-cpp.yml |   4 +
 Makefile                    |  10 ++
 monitor.c                   | 246 ++++++++++++++++++++++++++++++++++++
 monitor.h                   |   6 +
 nvme-builtin.h              |   1 +
 nvme.c                      |  13 ++
 6 files changed, 280 insertions(+)
 create mode 100644 monitor.c
 create mode 100644 monitor.h

diff --git a/.github/workflows/c-cpp.yml b/.github/workflows/c-cpp.yml
index d2f94e9..555edca 100644
--- a/.github/workflows/c-cpp.yml
+++ b/.github/workflows/c-cpp.yml
@@ -13,6 +13,10 @@ jobs:
 
     steps:
     - uses: actions/checkout@v2
+    - name: update
+      run: sudo apt-get update
+    - name: dependencies
+      run: sudo apt-get install --yes libudev-dev
     - name: make
       run: sudo apt-get install gcc-10-powerpc* && make clean && make && make clean && make LD=powerpc64le-linux-gnu-ld CC=powerpc64le-linux-gnu-gcc-10 CFLAGS='-O2 -g -Wall -Wformat-security -Werror -m64 -mcpu=power8 -mtune=power8 -I -I/usr/powerpc64-linux-gnu/include/'
 
diff --git a/Makefile b/Makefile
index ad18d47..33441b1 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,7 @@ override CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
 LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
 LIBHUGETLBFS = $(shell $(LD) -o /dev/null -lhugetlbfs >/dev/null 2>&1; echo $$?)
 HAVE_SYSTEMD = $(shell pkg-config --exists libsystemd  --atleast-version=242; echo $$?)
+HAVE_LIBUDEV = $(shell pkg-config --exists libudev; echo $$?)
 NVME = nvme
 INSTALL ?= install
 DESTDIR =
@@ -32,6 +33,11 @@ endif
 
 INC=-Iutil
 
+ifeq ($(HAVE_LIBUDEV),0)
+	override LDFLAGS += -ludev
+	override CFLAGS += -DHAVE_LIBUDEV
+endif
+
 ifeq ($(HAVE_SYSTEMD),0)
 	override LDFLAGS += -lsystemd
 	override CFLAGS += -DHAVE_SYSTEMD
@@ -62,6 +68,10 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-lightnvm.o fabrics.o nvme-models.o plugin.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
+ifeq ($(HAVE_LIBUDEV),0)
+        OBJS += monitor.o
+endif
+
 UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o util/log.o
 EVENT_OBJS := event/event.o event/timeout.o event/ts-util.o
 
diff --git a/monitor.c b/monitor.c
new file mode 100644
index 0000000..32f53a3
--- /dev/null
+++ b/monitor.c
@@ -0,0 +1,246 @@
+/*
+ * Copyright (C) 2021 SUSE LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file implements a simple monitor for NVMe-related uevents.
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <libudev.h>
+#include <signal.h>
+#include <time.h>
+#include <syslog.h>
+#include <sys/epoll.h>
+
+#include "nvme-status.h"
+#include "util/argconfig.h"
+#include "util/cleanup.h"
+#include "common.h"
+#include "monitor.h"
+#define LOG_FUNCNAME 1
+#include "util/log.h"
+#include "event/event.h"
+
+static struct monitor_config {
+	bool autoconnect;
+} mon_cfg = {
+	.autoconnect = true,
+};
+
+static struct dispatcher *mon_dsp;
+
+static DEFINE_CLEANUP_FUNC(cleanup_monitorp, struct udev_monitor *, udev_monitor_unref);
+
+static int create_udev_monitor(struct udev *udev, struct udev_monitor **pmon)
+{
+	struct udev_monitor *mon __cleanup__(cleanup_monitorp) = NULL;
+	int ret;
+	bool use_udev;
+	static const char *const monitor_name[] = {
+		[false] = "kernel",
+		[true]  = "udev",
+	};
+
+	/* Check if udevd is running, same test that libudev uses */
+	use_udev = access("/run/udev/control", F_OK) >= 0;
+	msg(LOG_DEBUG, "using %s monitor for uevents\n", monitor_name[use_udev]);
+
+	mon = udev_monitor_new_from_netlink(udev, monitor_name[use_udev]);
+	if (!mon)
+		return errno ? -errno : -ENOMEM;
+
+	/* Add match for NVMe controller devices */
+	ret = udev_monitor_filter_add_match_subsystem_devtype(mon, "nvme", NULL);
+	/* Add match for fc_udev_device */
+	ret = udev_monitor_filter_add_match_subsystem_devtype(mon, "fc", NULL);
+
+	/*
+	 * If we use the "udev" monitor, the kernel filters out the interesting
+	 * uevents for us using BPF. A single event is normally well below 1kB,
+	 * so 1MiB is sufficient for queueing more than 1000 uevents, which
+	 * should be plenty for just nvme.
+	 *
+	 * For "kernel" monitors, the filtering is done by libudev in user space,
+	 * thus every device is received in the first place, and a larger
+	 * receive buffer is needed. Use the same value as udevd.
+	 */
+	udev_monitor_set_receive_buffer_size(mon, (use_udev ? 1 : 128) * 1024 * 1024);
+	ret = udev_monitor_enable_receiving(mon);
+	if (ret < 0)
+		return ret;
+	*pmon = mon;
+	mon = NULL;
+	return 0;
+}
+
+static sig_atomic_t must_exit;
+
+static void monitor_int_handler(int sig)
+{
+	must_exit = 1;
+}
+
+static int monitor_init_signals(sigset_t *wait_mask)
+{
+	sigset_t mask;
+	struct sigaction sa = { .sa_handler = monitor_int_handler, };
+
+	/*
+	 * Block all signals. They will be unblocked when we wait
+	 * for events.
+	 */
+	sigfillset(&mask);
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		return -errno;
+	if (sigaction(SIGTERM, &sa, NULL) == -1)
+		return -errno;
+	if (sigaction(SIGINT, &sa, NULL) == -1)
+		return -errno;
+
+	/* signal mask to be used in epoll_pwait() */
+	sigfillset(wait_mask);
+	sigdelset(wait_mask, SIGTERM);
+	sigdelset(wait_mask, SIGINT);
+
+	return 0;
+}
+
+static void monitor_handle_udevice(struct udev_device *ud)
+{
+	msg(LOG_INFO, "uevent: %s %s\n",
+		udev_device_get_action(ud),
+		udev_device_get_sysname(ud));
+}
+
+struct udev_monitor_event {
+	struct event e;
+	struct udev_monitor *monitor;
+};
+
+static int monitor_handle_uevents(struct event *ev,
+				  uint32_t __attribute__((unused)) ep_events)
+{
+	struct udev_monitor_event *udev_event =
+		container_of(ev, struct udev_monitor_event, e);
+	struct udev_monitor *monitor = udev_event->monitor;
+	struct udev_device *ud;
+
+	for (ud = udev_monitor_receive_device(monitor);
+	     ud;
+	     ud = udev_monitor_receive_device(monitor)) {
+		monitor_handle_udevice(ud);
+		udev_device_unref(ud);
+	}
+	return EVENTCB_CONTINUE;
+}
+
+static int monitor_parse_opts(const char *desc, int argc, char **argv)
+{
+	bool quiet = false;
+	bool verbose = false;
+	bool debug = false;
+	bool noauto = false;
+	int ret;
+	OPT_ARGS(opts) = {
+		OPT_FLAG("no-connect",     'N', &noauto,              "dry run, do not autoconnect to discovered controllers"),
+		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
+		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
+		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
+		OPT_FLAG("timestamps",     't', &log_timestamp,       "print log timestamps"),
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
+	if (noauto)
+		mon_cfg.autoconnect = false;
+
+	return ret;
+}
+
+static DEFINE_CLEANUP_FUNC(cleanup_udevp, struct udev *, udev_unref);
+
+static void cleanup_udev_event(struct event *evt)
+{
+	struct udev_monitor_event *ue;
+
+	ue = container_of(evt, struct udev_monitor_event, e);
+	if (ue->monitor)
+		ue->monitor = udev_monitor_unref(ue->monitor);
+}
+
+int aen_monitor(const char *desc, int argc, char **argv)
+{
+	int ret;
+	struct udev *udev __cleanup__(cleanup_udevp) = NULL;
+	struct udev_monitor *monitor __cleanup__(cleanup_monitorp) = NULL;
+	struct udev_monitor_event udev_event = { .e.fd = -1, };
+	sigset_t wait_mask;
+
+	ret = monitor_parse_opts(desc, argc, argv);
+	if (ret)
+		goto out;
+
+	ret = monitor_init_signals(&wait_mask);
+	if (ret != 0) {
+		msg(LOG_ERR, "monitor: failed to initialize signals: %m\n");
+		goto out;
+	}
+
+	mon_dsp = new_dispatcher(CLOCK_REALTIME);
+	if (!mon_dsp) {
+		ret = errno ? -errno : -EIO;
+		goto out;
+	}
+
+	udev = udev_new();
+	if (!udev) {
+		msg(LOG_ERR, "failed to create udev object: %m\n");
+		ret = errno ? -errno : -ENOMEM;
+		goto out;
+	}
+
+	ret = create_udev_monitor(udev, &monitor);
+	if (ret != 0)
+		goto out;
+
+	udev_event.e = EVENT_ON_STACK(monitor_handle_uevents,
+				      udev_monitor_get_fd(monitor), EPOLLIN);
+	if (udev_event.e.fd == -1)
+		goto out;
+	udev_event.e.cleanup = cleanup_udev_event;
+	udev_event.monitor = monitor;
+	monitor = NULL;
+
+	if ((ret = event_add(mon_dsp, &udev_event.e)) != 0) {
+		msg(LOG_ERR, "failed to register udev monitor event: %s\n",
+		    strerror(-ret));
+		goto out;
+	}
+
+	ret = event_loop(mon_dsp, &wait_mask, NULL);
+
+out:
+	free_dispatcher(mon_dsp);
+	return nvme_status_to_errno(ret, true);
+}
diff --git a/monitor.h b/monitor.h
new file mode 100644
index 0000000..e79d3a6
--- /dev/null
+++ b/monitor.h
@@ -0,0 +1,6 @@
+#ifndef _MONITOR_H
+#define _MONITOR_H
+
+extern int aen_monitor(const char *desc, int argc, char **argv);
+
+#endif
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 296afd6..5be7827 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -83,6 +83,7 @@ COMMAND_LIST(
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
 	ENTRY("rpmb", "Replay Protection Memory Block commands", rpmb_cmd)
+	ENTRY("monitor", "Monitor NVMeoF AEN events", monitor_cmd)
 );
 
 #endif
diff --git a/nvme.c b/nvme.c
index 9064e83..7beaeb8 100644
--- a/nvme.c
+++ b/nvme.c
@@ -57,6 +57,7 @@
 
 #include "argconfig.h"
 #include "fabrics.h"
+#include "monitor.h"
 
 #define CREATE_CMD
 #include "nvme-builtin.h"
@@ -5561,6 +5562,18 @@ static int disconnect_all_cmd(int argc, char **argv, struct command *command, st
 	return fabrics_disconnect_all(desc, argc, argv);
 }
 
+static int monitor_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+#ifdef HAVE_LIBUDEV
+	const char *desc = "Monitor NVMeoF AEN events";
+
+	return aen_monitor(desc, argc, argv);
+#else
+	fprintf(stderr, "nvme-cli built without libudev doesn't support the \"monitor\" subcommand\n");
+	return EOPNOTSUPP;
+#endif
+}
+
 void register_extension(struct plugin *plugin)
 {
 	plugin->parent = &nvme;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
