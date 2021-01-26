Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027EC433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B0722B2C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B0722B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AL/PKXSZ66uY+OR5eu7kRgDL3NsUgk3hMw3I9C8NahQ=; b=vHBE1tgVrqe3aYhhTPV47AHVt
	9qzEutgP397faqAJb6Ie+mGoXpdTNa5Ovd32pVcSgBfr82AnqVb7pKwYY8w9JbE6M+f30ErOfgJhv
	7J05dsKh4K+9QouW4eqft0+0rP/vaQf4f00XZf+O1n7/sXe9n1E1CpsxI5/htODCGpk4iZDX017zv
	8jHAWdClQnkJT9GORLMZDmemuy6vsGTBMbm0LUj15Wk92g4Qv3dc1HEUSnE19vUxqaDYBxLiVLK9O
	ombmnih3+3h3oAS5L89R9oYj2NY2XY2J2iqpK7NYpfvcQlhvdn7bNOA68OgypZqHeMQ0ME680H6iW
	8TH5UlJpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2G-00014b-Mf; Tue, 26 Jan 2021 20:34:01 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V22-0000to-Ip
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+y9AaRgjVWbJXPu7eypF3gXhWwqx6NDId8k+bKO1o0=;
 b=fNJa6zGHXgQnAuEDAAxyb8An5H3QTMFPogXsEDKFFKb/sNJnDnOg+y2reJ/tCXNmMmqAdY
 /Y+Mad7Mb4SlE885p3KfPc9cNyIGPSpjAPljMwQswi5bq//abxt3AGzUOy0U1vIuxV7kbZ
 0gyelITGOFwX073FjN3EjV5AR1UXxQE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CFB4DAEAC;
 Tue, 26 Jan 2021 20:33:42 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 01/35] nvme-monitor: add new stub
Date: Tue, 26 Jan 2021 21:32:50 +0100
Message-Id: <20210126203324.23610-2-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153346_841845_49CDC2A3 
X-CRM114-Status: GOOD (  22.24  )
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

This stub will become the nvme AEN monitor in follow-up commits.
monitor functionality depends on libudev.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Makefile       | 10 ++++++++++
 monitor.c      | 28 ++++++++++++++++++++++++++++
 monitor.h      |  6 ++++++
 nvme-builtin.h |  1 +
 nvme.c         | 13 +++++++++++++
 5 files changed, 58 insertions(+)
 create mode 100644 monitor.c
 create mode 100644 monitor.h

diff --git a/Makefile b/Makefile
index 3ea17b5..21c9a23 100644
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
+	OBJS += monitor.o
+endif
+
 UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o
 
 PLUGIN_OBJS :=					\
diff --git a/monitor.c b/monitor.c
new file mode 100644
index 0000000..dae4975
--- /dev/null
+++ b/monitor.c
@@ -0,0 +1,28 @@
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
+#include <errno.h>
+
+#include "nvme-status.h"
+#include "monitor.h"
+
+int aen_monitor(const char *desc, int argc, char **argv)
+{
+	/* Handle as unimplemented for now */
+	return nvme_status_to_errno(-ENOTTY, true);
+}
+
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
index 59896dc..74f9a3e 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -80,6 +80,7 @@ COMMAND_LIST(
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
 	ENTRY("rpmb", "Replay Protection Memory Block commands", rpmb_cmd)
+	ENTRY("monitor", "Monitor NVMeoF AEN events", monitor_cmd)
 );
 
 #endif
diff --git a/nvme.c b/nvme.c
index d1ef6e9..d2004a2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -57,6 +57,7 @@
 
 #include "argconfig.h"
 #include "fabrics.h"
+#include "monitor.h"
 
 #define CREATE_CMD
 #include "nvme-builtin.h"
@@ -5320,6 +5321,18 @@ static int disconnect_all_cmd(int argc, char **argv, struct command *command, st
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
