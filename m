Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9610CC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:44:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1416264F52
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1416264F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RpECC0I6eibFDNBFdd/vHeCKh1wScCFnwZElLNt4O/4=; b=IQRrOezi9nl1U8VNxhGCvxoA8
	8UH3h2Igwg8T4naOPsMqKee4TVDOS9FUTEs30AViqYrWVlTZWDDHvL4EU2LJ58koQgQcKTDGrjx3H
	GCRvH7LK7Y3uWliIITdJuK9s31FOq2WmavqsMDXOS5iNGBkg7EiHIlKJo27ewiBOPtqAF3SRb6yzc
	UsaE8ggtH/M0EwOa+TVR5QmzjBXkSnEvKBJsqhdMtEiJzIY7+3PlBFUYN3ikeEoGinjDM7CW/pm7i
	jVl2wZnxmjBVahI6lDztm4iRiac8Azj0BJf7MN7ser3GIpR7vd17HZXcaTFg/X61kmqiHqWFDdgd1
	yH5sC0cRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL3Q-00HY2Y-9G; Sat, 06 Mar 2021 00:44:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwZ-00HVg0-1G
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/rqdKF4gitzF4pmxTMqZfSe4EmzzMFeS6BZFuuIihM=;
 b=f1duoB9Ki7N1c+V90x7AwmiSYnwbVo4NxDMNOu1Rzxyf7UqmTPo2ZWgLFPD9SHO/k3ZvWX
 vQKTNeeaweDtSdIQBdKGvuYkeV4DezAOpr8lCpkb03VGrzA4KBbo/lJzHQdNKd9Ja5iRAE
 Vx7r2HoT9tX6zuP4EXX/xYohsHNaRag=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 26D83AF0D;
 Sat,  6 Mar 2021 00:37:17 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 05/16] conn-db: add simple connection registry
Date: Sat,  6 Mar 2021 01:36:48 +0100
Message-Id: <20210306003659.21207-6-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_690377_ABE07A3C 
X-CRM114-Status: GOOD (  32.08  )
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

The monitor works best if it maintains a discovery controller connection
to every transport address that provides a discovery subsystem.

While controllers are easily tracked in sysfs, addresses ("connections"),
i.e. (transport, traddr, trsvid, host_traddr) tuples, are not. Create
a simple registry that tracks the state of "connections" and their
associated discovery controllers.

A detailed description of the API is provided in the header file conn-db.h.

This patch also adds well-known "list.h" macros from the kernel. The file
was taken from multipath-tools, which got it from the kernel long ago.
---
 Makefile  |   2 +-
 conn-db.c | 424 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 conn-db.h | 170 ++++++++++++++++++++++
 list.h    | 349 ++++++++++++++++++++++++++++++++++++++++++++
 monitor.c |  49 ++++++-
 5 files changed, 987 insertions(+), 7 deletions(-)
 create mode 100644 conn-db.c
 create mode 100644 conn-db.h
 create mode 100644 list.h

diff --git a/Makefile b/Makefile
index 33441b1..7c7b3b9 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
 ifeq ($(HAVE_LIBUDEV),0)
-        OBJS += monitor.o
+	OBJS += monitor.o conn-db.o
 endif
 
 UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o util/log.o
diff --git a/conn-db.c b/conn-db.c
new file mode 100644
index 0000000..cfdc208
--- /dev/null
+++ b/conn-db.c
@@ -0,0 +1,424 @@
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
+ * This file implements a simple registry for NVMe connections, i.e.
+ * (transport type, host_traddr, traddr, trsvcid) tuples.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <syslog.h>
+#include <time.h>
+
+#include "common.h"
+#include "util/cleanup.h"
+#include "list.h"
+#include "nvme.h"
+#include "fabrics.h"
+#include "conn-db.h"
+
+#define LOG_FUNCNAME 1
+#include "util/log.h"
+
+struct conn_int {
+	struct nvme_connection c;
+	struct list_head lst;
+};
+
+#define conn2internal(co) container_of(co, struct conn_int, c)
+
+static LIST_HEAD(connections);
+
+static const char * const _status_str[] = {
+	[CS_NEW] = "new",
+	[CS_DISC_RUNNING] = "discovery-running",
+	[CS_ONLINE] = "online",
+	[CS_FAILED] = "failed",
+};
+
+const char *conn_status_str(int status)
+{
+	return arg_str(_status_str, ARRAY_SIZE(_status_str), status);
+}
+
+void __attribute__((format(printf, 4, 5)))
+_conn_msg(int lvl, const char *func, const struct nvme_connection *c,
+	  const char *fmt, ...)
+{
+	char *fbuf __cleanup__(cleanup_charp) = NULL;
+	char *cbuf __cleanup__(cleanup_charp) = NULL;
+	char *mbuf __cleanup__(cleanup_charp) = NULL;
+	va_list ap;
+
+	if (asprintf(&cbuf, "[%s]%s->%s(%s): ",
+		     c->transport,
+		     c->host_traddr ? c->host_traddr : "localhost",
+		     c->traddr ? c->traddr : "<no traddr>",
+		     c->trsvcid ? c->trsvcid : "") == -1) {
+		cbuf = NULL;
+		return;
+	}
+
+	va_start(ap, fmt);
+	if (vasprintf(&mbuf, fmt, ap) == -1)
+		mbuf = NULL;
+	va_end(ap);
+	__msg(lvl, func, "%s%s\n", cbuf, mbuf);
+}
+
+static void conn_free(struct conn_int *ci)
+{
+	if (!ci)
+		return;
+	if (ci->c.traddr)
+		free(ci->c.traddr);
+	if (ci->c.trsvcid)
+		free(ci->c.trsvcid);
+	if (ci->c.host_traddr)
+		free(ci->c.host_traddr);
+	free(ci);
+}
+
+static int conn_del(struct conn_int *ci)
+{
+	if (!ci)
+		return -ENOENT;
+	if (list_empty(&ci->lst))
+		return -EINVAL;
+	conn_msg(LOG_DEBUG, &ci->c, "forgetting connection\n");
+	list_del(&ci->lst);
+	conn_free(ci);
+	return 0;
+}
+
+static int get_trtype(const char *transport)
+{
+	if (!transport)
+		return -EINVAL;
+	if (!strcmp(transport, trtypes[NVMF_TRTYPE_RDMA]))
+		return NVMF_TRTYPE_RDMA;
+	else if (!strcmp(transport, trtypes[NVMF_TRTYPE_FC]))
+		return NVMF_TRTYPE_FC;
+	else if (!strcmp(transport, trtypes[NVMF_TRTYPE_TCP]))
+		return NVMF_TRTYPE_TCP;
+	else if (!strcmp(transport, trtypes[NVMF_TRTYPE_LOOP]))
+		return NVMF_TRTYPE_LOOP;
+	else
+		return -ENOENT;
+}
+
+static bool transport_params_ok(const char *transport, const char *traddr,
+				const char *host_traddr)
+{
+	int trtype = get_trtype(transport);
+
+	/* same as "required_opts" in the kernel code */
+	switch(trtype) {
+	case NVMF_TRTYPE_FC:
+		return traddr && *traddr && host_traddr && *host_traddr;
+	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
+		return traddr && *traddr;
+	case NVMF_TRTYPE_LOOP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool prop_matches(const char *p1, const char *p2, size_t len)
+{
+	/* treat NULL and empty string as equivalent */
+	if ((!p1 && !p2) || (!p1 && !*p2) || (!p2 && !*p1))
+		return true;
+	if (p1 && p2 && !strncmp(p1, p2, len))
+		return true;
+	return false;
+}
+
+bool conndb_matches(const char *transport, const char *traddr,
+		    const char *trsvcid, const char *host_traddr,
+		    const struct nvme_connection *co)
+{
+	if (!co)
+		return false;
+	if (!transport_params_ok(transport, traddr, host_traddr))
+		return NULL;
+	if (strcmp(transport, co->transport))
+		return false;
+	if (!prop_matches(traddr, co->traddr, NVMF_TRADDR_SIZE))
+		return false;
+	if (!prop_matches(trsvcid, co->trsvcid, NVMF_TRSVCID_SIZE))
+		return false;
+	if (!prop_matches(host_traddr, co->host_traddr, NVMF_TRADDR_SIZE))
+		return false;
+	return true;
+}
+
+static struct conn_int *conn_find(const char *transport, const char *traddr,
+				  const char *trsvcid, const char *host_traddr)
+{
+	struct conn_int *ci;
+
+	if (!transport_params_ok(transport, traddr, host_traddr))
+		return NULL;
+	list_for_each_entry(ci, &connections, lst) {
+		if (conndb_matches(transport, traddr, trsvcid, host_traddr, &ci->c))
+			return ci;
+	}
+	return NULL;
+}
+
+static DEFINE_CLEANUP_FUNC(conn_free_p, struct conn_int *, conn_free);
+
+static int _conn_add(const char *transport, const char *traddr,
+		     const char *trsvcid, const char *host_traddr,
+		     struct conn_int **new_ci)
+{
+	struct conn_int *ci __cleanup__(conn_free_p) = NULL;
+
+	if (!transport_params_ok(transport, traddr, host_traddr)) {
+		msg(LOG_ERR, "invalid %s transport parameters: traddr=%s host_traddr=%s\n",
+		    transport, traddr, host_traddr);
+		return -EINVAL;
+	}
+
+	if (!(ci = calloc(1, sizeof(*ci))) ||
+	    (traddr && *traddr &&
+	     !(ci->c.traddr = strndup(traddr, NVMF_TRADDR_SIZE))) ||
+	    (host_traddr && *host_traddr &&
+	     !(ci->c.host_traddr = strndup(host_traddr, NVMF_TRADDR_SIZE))) ||
+	    (trsvcid && *trsvcid &&
+	     !(ci->c.trsvcid = strndup(trsvcid, NVMF_TRSVCID_SIZE))))
+		return -ENOMEM;
+	memccpy(ci->c.transport, transport, '\0', sizeof(ci->c.transport));
+	ci->c.status = CS_NEW;
+	ci->c.discovery_instance = -1;
+	list_add(&ci->lst, &connections);
+	*new_ci = ci;
+	ci = NULL;
+	return 0;
+}
+
+static int conn_add(const char *transport, const char *traddr,
+		    const char *trsvcid, const char *host_traddr,
+		    struct conn_int **new_ci)
+{
+	struct conn_int *ci = conn_find(transport, traddr, trsvcid, host_traddr);
+	int rc;
+
+	if (ci) {
+		*new_ci = ci;
+		return -EEXIST;
+	}
+	rc = _conn_add(transport, traddr, trsvcid, host_traddr, new_ci);
+	if (!rc)
+		conn_msg(LOG_DEBUG, &(*new_ci)->c, "added connection\n");
+	else
+		msg(LOG_ERR, "failed to add %s connection\n", transport);
+	return rc;
+}
+
+int conndb_add(const char *transport, const char *traddr,
+	       const char *trsvcid, const char *host_traddr,
+	       struct nvme_connection **new_conn)
+{
+	struct conn_int *ci = NULL;
+	int rc = conn_add(transport, traddr, trsvcid, host_traddr, &ci);
+
+	if (rc != 0 && rc != -EEXIST)
+		return rc;
+	if (new_conn)
+		*new_conn = &ci->c;
+	return rc;
+}
+
+int conndb_add_disc_ctrl(const char *addrstr, struct nvme_connection **new_conn)
+{
+	char *subsysnqn __cleanup__(cleanup_charp) = NULL;
+	char *transport __cleanup__(cleanup_charp) = NULL;
+	char *traddr __cleanup__(cleanup_charp) = NULL;
+	char *trsvcid __cleanup__(cleanup_charp) = NULL;
+	char *host_traddr __cleanup__(cleanup_charp) = NULL;
+
+	subsysnqn = parse_conn_arg(addrstr, ',', "nqn");
+	if (strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME)) {
+		msg(LOG_WARNING, "%s is not a discovery subsystem\n", subsysnqn);
+		return -EINVAL;
+	}
+	transport = parse_conn_arg(addrstr, ',', "transport");
+	traddr = parse_conn_arg(addrstr, ',', "traddr");
+	trsvcid = parse_conn_arg(addrstr, ',', "trsvcid");
+	host_traddr = parse_conn_arg(addrstr, ',', "host_traddr");
+	return conndb_add(transport, traddr, trsvcid, host_traddr, new_conn);
+}
+
+struct nvme_connection *conndb_find(const char *transport, const char *traddr,
+				    const char *trsvcid, const char *host_traddr)
+{
+	struct conn_int *ci;
+
+	ci = conn_find(transport, traddr, trsvcid, host_traddr);
+	if (ci)
+		return &ci->c;
+	else
+		return NULL;
+}
+
+struct nvme_connection *conndb_find_by_pid(pid_t pid)
+{
+	struct conn_int *ci;
+
+	list_for_each_entry(ci, &connections, lst) {
+		if (ci->c.status == CS_DISC_RUNNING &&
+		    ci->c.discovery_task == pid)
+			return &ci->c;
+	}
+	return NULL;
+}
+
+struct nvme_connection *conndb_find_by_ctrl(const char *devname)
+{
+	struct conn_int *ci;
+	int instance;
+
+	instance = ctrl_instance(devname);
+	if (instance < 0)
+		return NULL;
+
+	list_for_each_entry(ci, &connections, lst) {
+		if (ci->c.discovery_instance == instance)
+			return &ci->c;
+	}
+	return NULL;
+}
+
+int conndb_delete(struct nvme_connection *co)
+{
+	if (!co)
+		return -ENOENT;
+	return conn_del(conn2internal(co));
+}
+
+void conndb_free(void)
+{
+	struct conn_int *ci, *next;
+
+	list_for_each_entry_safe(ci, next, &connections, lst)
+		conn_del(ci);
+}
+
+int conndb_init_from_sysfs(void)
+{
+	struct dirent **devices;
+	int i, n, ret = 0;
+	char syspath[PATH_MAX];
+
+	n = scandir(SYS_NVME, &devices, scan_ctrls_filter, alphasort);
+	if (n <= 0)
+		return n;
+
+	for (i = 0; i < n; i++) {
+		int len, rc;
+		struct conn_int *ci;
+		char *transport __cleanup__(cleanup_charp) = NULL;
+		char *address __cleanup__(cleanup_charp) = NULL;
+		char *traddr __cleanup__(cleanup_charp) = NULL;
+		char *trsvcid __cleanup__(cleanup_charp) = NULL;
+		char *host_traddr __cleanup__(cleanup_charp) = NULL;
+		char *subsysnqn __cleanup__(cleanup_charp) = NULL;
+
+		len = snprintf(syspath, sizeof(syspath), SYS_NVME "/%s",
+			       devices[i]->d_name);
+		if (len < 0 || len >= sizeof(syspath))
+			continue;
+
+		transport = nvme_get_ctrl_attr(syspath, "transport");
+		address = nvme_get_ctrl_attr(syspath, "address");
+		if (!transport || !address)
+			continue;
+		traddr = parse_conn_arg(address, ' ', "traddr");
+		trsvcid = parse_conn_arg(address, ' ', "trsvcid");
+		host_traddr = parse_conn_arg(address, ' ', "host_traddr");
+
+		rc = conn_add(transport, traddr, trsvcid, host_traddr, &ci);
+		if (rc != 0 && rc != -EEXIST)
+			continue;
+
+		if (rc == 0)
+			ret++;
+
+		subsysnqn = nvme_get_ctrl_attr(syspath, "subsysnqn");
+		if (subsysnqn && !strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME)) {
+			int instance;
+			char *kato_attr __cleanup__(cleanup_charp) = NULL;
+
+			kato_attr = nvme_get_ctrl_attr(syspath, "kato");
+			if (kato_attr) {
+				char dummy;
+				unsigned int kato;
+				/*
+				 * The kernel supports the "kato" attribute, and
+				 * this controller isn't persistent. Skip it.
+				 */
+				if (sscanf(kato_attr, "%u%c", &kato, &dummy) == 1
+				    && kato == 0)
+					continue;
+			}
+
+			instance =ctrl_instance(devices[i]->d_name);
+			if (instance >= 0) {
+				ci->c.discovery_instance = instance;
+				msg(LOG_DEBUG, "found discovery controller %s\n",
+				    devices[i]->d_name);
+			}
+		}
+	}
+
+	for (i = 0; i < n; i++)
+		free(devices[i]);
+	free(devices);
+
+	return ret;
+}
+
+int conndb_for_each(int (*callback)(struct nvme_connection *co, void *arg),
+		    void *arg)
+{
+	struct conn_int *ci, *next;
+	int ret = 0;
+
+	list_for_each_entry_safe(ci, next, &connections, lst) {
+		int rc = callback(&ci->c, arg);
+
+		if (rc & ~(CD_CB_ERR|CD_CB_DEL|CD_CB_BREAK)) {
+			msg(LOG_ERR,
+			    "invalid return value 0x%x from callback\n", rc);
+			ret = -EINVAL;
+			continue;
+		}
+		if (rc & CD_CB_ERR) {
+			msg(LOG_WARNING, "callback returned error\n");
+			if (!ret)
+				ret = errno ? -errno : -EIO;
+		}
+		if (rc & CD_CB_DEL)
+			conn_del(ci);
+		if (rc & CD_CB_BREAK)
+			break;
+	}
+	return ret;
+}
diff --git a/conn-db.h b/conn-db.h
new file mode 100644
index 0000000..e2a5827
--- /dev/null
+++ b/conn-db.h
@@ -0,0 +1,170 @@
+#ifndef _CONN_DB_H
+#define _CONN_DB_H
+#include "log.h"
+
+struct nvme_connection {
+	char transport[5];
+	char *traddr;
+	char *trsvcid;
+	char *host_traddr;
+
+	int status;
+	int discovery_pending:1;
+	int did_discovery:1;
+	int successful_discovery:1;
+	union {
+		pid_t discovery_task;
+		int discovery_result;
+	};
+	int discovery_instance;
+};
+
+/* connection status */
+enum {
+	CS_NEW = 0,
+	CS_DISC_RUNNING,
+	CS_ONLINE,
+	CS_FAILED,
+	__CS_LAST,
+};
+
+/**
+ * conn_status_str() - return string representation of connection status
+ */
+const char *conn_status_str(int status);
+
+/**
+ * conndb_add() - add a connection with given parameters
+ *
+ * @new_conn: if non-NULL and the function succeeds, will receive a pointer
+ *            to the either existing or newly created connection object.
+ *
+ * Looks up the given connection parameters in the db and adds a new connection
+ * unless found. All input parameters except trsvcid must be non-NULL.
+ *
+ * Return: 0 if controller was added, -EEXIST if controller existed in the db
+ *         (this is considered success), or other negative error code in
+ *         the error case.
+ *
+ */
+int conndb_add(const char *transport, const char *traddr,
+	       const char *trsvcid, const char *host_traddr,
+	       struct nvme_connection **new_conn);
+
+/**
+ * conndb_add_disc_ctrl - add connection from kernel parameters
+ *
+ * @addrstr: kernel connect parameters as passed to /dev/nvme-fabrics
+ * @new_conn: see conndb_add()
+ *
+ * Extracts connection parameters from @addrstr and calls conndb_add().
+ *
+ * Return: see conndb_add().
+ */
+int conndb_add_disc_ctrl(const char *addrstr, struct nvme_connection **new_conn);
+
+/**
+ * conndb_find() - lookup a connection with given parameters
+ *
+ * Return: NULL if not found, valid connection object otherwise.
+ */
+struct nvme_connection *conndb_find(const char *transport, const char *traddr,
+				    const char *trsvcid, const char *host_traddr);
+
+
+/**
+ * conndb_find_by_pid() - lookup connection by discovery task pid
+ *
+ * Return: valid connetion object if successful, NULL otherwise.
+ */
+struct nvme_connection *conndb_find_by_pid(pid_t pid);
+
+
+/**
+ * conndb_find_by_pid() - lookup connection from controller instance
+ *
+ * Return: valid connetion object if a connection was found that has
+ * the given device as discovery controller. NULL otherwise.
+ */
+struct nvme_connection *conndb_find_by_ctrl(const char *devname);
+
+enum {
+	CD_CB_OK    = 0,
+	CD_CB_ERR   = (1 << 0),
+	CD_CB_DEL   = (1 << 1),
+	CD_CB_BREAK = (1 << 2),
+};
+
+/**
+ *  conndb_for_each() - run a callback for each connection
+ *
+ * @callback: function to be called
+ * @arg:      user argument passed to callback
+ *
+ * The callback must return a bitmask created from the CD_CB_* enum
+ * values above. CD_CB_ERR signals an error condition in the callback.
+ * CD_CB_DEL causes the connection to be deleted after the callback
+ * returns. CD_CB_BREAK stops the iteration. Returning a value that
+ * is not an OR-ed from these values is an error.
+ *
+ * Return: 0 if all callbacks completed successfully.
+ *         A negative error code if some callback failed.
+ */
+int conndb_for_each(int (*callback)(struct nvme_connection *co, void *arg),
+		    void *arg);
+
+/**
+ * conndb_matches - check if connection matches given parameters
+ *
+ * The arguments @transport and @traddr must be non-null and non-empty.
+ * @trscvid and @host_traddr may be NULL, in which case they match
+ * connections that don't have these attributes set, either.
+ *
+ * Return: true iff the given connection matches the given attributes.
+ */
+bool conndb_matches(const char *transport, const char *traddr,
+		    const char *trsvcid, const char *host_traddr,
+		    const struct nvme_connection *co);
+
+/**
+ * conndb_delete() - remove a given nvme connection object
+ *
+ * Removes the object from the data base and frees it.
+ *
+ * Return: 0 if successful, negative error code otherwise
+ */
+int conndb_delete(struct nvme_connection *co);
+
+/**
+ * conndb-free() - free internal data structures
+ */
+void conndb_free(void);
+
+/**
+ * conndb_init_from_sysfs() - check existing NVMe connections
+ *
+ * Populates the connection db from existing contoller devices in sysfs.
+ *
+ * Return: (positive or zero) number of found connections on success.
+ *         Negative error code on failure.
+ */
+int conndb_init_from_sysfs(void);
+
+/**
+ * conn_msg() - print a log message prepended by a connection params
+ * @lvl: standard syslog log level
+ * @c: nvme connection to print information
+ * @fmt: format string
+ * ...: parameters for format
+ */
+void __attribute__((format(printf, 4, 5)))
+_conn_msg(int lvl, const char *func, const struct nvme_connection *c,
+	  const char *fmt, ...);
+
+#define conn_msg(lvl, c, fmt, ...) \
+do {									\
+	if ((lvl) <= MAX_LOGLEVEL)					\
+		_conn_msg(lvl, _log_func, c, fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#endif
diff --git a/list.h b/list.h
new file mode 100644
index 0000000..f87c84f
--- /dev/null
+++ b/list.h
@@ -0,0 +1,349 @@
+/*
+ * Copied from the Linux kernel source tree, version 2.6.0-test1.
+ *
+ * Licensed under the GPL v2 as per the whole kernel source tree.
+ *
+ */
+
+#ifndef _LIST_H
+#define _LIST_H
+
+#include <stddef.h>
+
+/*
+ * These are non-NULL pointers that will result in page faults
+ * under normal circumstances, used to verify that nobody uses
+ * non-initialized list entries.
+ */
+#define LIST_POISON1  ((void *) 0x00100100)
+#define LIST_POISON2  ((void *) 0x00200200)
+
+/*
+ * Simple doubly linked list implementation.
+ *
+ * Some of the internal functions ("__xxx") are useful when
+ * manipulating whole lists rather than single entries, as
+ * sometimes we already know the next/prev entries and we can
+ * generate better code by using them directly rather than
+ * using the generic single-entry routines.
+ */
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+#define INIT_LIST_HEAD(ptr) do { \
+	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
+} while (0)
+
+/*
+ * Insert a new entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+/**
+ * list_add - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
+/**
+ * list_add_tail - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static inline void list_add_tail(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head->prev, head);
+}
+
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_del(struct list_head * prev, struct list_head * next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
+}
+
+/**
+ * list_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static inline void list_del_init(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	INIT_LIST_HEAD(entry);
+}
+
+/**
+ * list_move - delete from one list and add as another's head
+ * @list: the entry to move
+ * @head: the head that will precede our entry
+ */
+static inline void list_move(struct list_head *list, struct list_head *head)
+{
+	__list_del(list->prev, list->next);
+	list_add(list, head);
+}
+
+/**
+ * list_move_tail - delete from one list and add as another's tail
+ * @list: the entry to move
+ * @head: the head that will follow our entry
+ */
+static inline void list_move_tail(struct list_head *list,
+				  struct list_head *head)
+{
+	__list_del(list->prev, list->next);
+	list_add_tail(list, head);
+}
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static inline int list_empty(struct list_head *head)
+{
+	return head->next == head;
+}
+
+static inline void __list_splice(const struct list_head *list,
+				 struct list_head *prev,
+				 struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+/**
+ * list_splice - join two lists
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice(struct list_head *list, struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head, head->next);
+}
+
+/**
+ * list_splice_tail - join two lists, each list being a queue
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice_tail(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head->prev, head);
+}
+
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head, head->next);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_splice_tail_init - join two lists and reinitialise the emptied list
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * Each of the lists is a queue.
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_tail_init(struct list_head *list,
+					 struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head->prev, head);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+/**
+ * list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; pos != (head); \
+		pos = pos->next)
+
+/**
+ * __list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ *
+ * This variant differs from list_for_each() in that it's the
+ * simplest possible list iteration code.
+ * Use this for code that knows the list to be very short (empty
+ * or 1 entry) most of the time.
+ */
+#define __list_for_each(pos, head) \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+/**
+ * list_for_each_prev	-	iterate over a list backwards
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev(pos, head) \
+	for (pos = (head)->prev; pos != (head); pos = pos->prev)
+
+/**
+ * list_for_each_safe	-	iterate over a list safe against removal of list entry
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, n = pos->next)
+
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_entry((head)->next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = list_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_reverse - iterate backwards over list of given type.
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_reverse(pos, head, member)			\
+	for (pos = list_entry((head)->prev, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_for_each_entry_reverse_safe - iterate backwards over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_reverse_safe(pos, n, head, member)          \
+	for (pos = list_entry((head)->prev, typeof(*pos), member),      \
+		 n = list_entry(pos->member.prev, typeof(*pos), member);\
+	     &pos->member != (head);                                    \
+	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
+
+/**
+ * list_for_some_entry_safe - iterate list from the given begin node to the given end node safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @from:	the begin node of the iteration.
+ * @to:		the end node of the iteration.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_some_entry_safe(pos, n, from, to, member)              \
+	for (pos = list_entry((from)->next, typeof(*pos), member),      \
+	     n = list_entry(pos->member.next, typeof(*pos), member);    \
+	     &pos->member != (to);                                      \
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_for_some_entry_reverse_safe - iterate backwards list from the given begin node to the given end node safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @from:	the begin node of the iteration.
+ * @to:		the end node of the iteration.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_some_entry_reverse_safe(pos, n, from, to, member)      \
+	for (pos = list_entry((from)->prev, typeof(*pos), member),      \
+	     n = list_entry(pos->member.prev, typeof(*pos), member);    \
+	     &pos->member != (to);                                      \
+	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
+
+#endif /* _LIST_H */
diff --git a/monitor.c b/monitor.c
index f544319..d724f6f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "common.h"
 #include "fabrics.h"
 #include "monitor.h"
+#include "conn-db.h"
 #define LOG_FUNCNAME 1
 #include "util/log.h"
 #include "event/event.h"
@@ -202,12 +203,22 @@ static int monitor_get_fc_uev_props(struct udev_device *ud,
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
@@ -215,11 +226,17 @@ static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
 		return -errno;
 	} else if (pid > 0) {
 		msg(LOG_DEBUG, "started discovery task %ld\n", (long)pid);
+
+		co->discovery_pending = 0;
+		co->status = CS_DISC_RUNNING;
+		co->discovery_task = pid;
+
 		return 0;
 	}
 
 	child_reset_signals();
 	free_dispatcher(mon_dsp);
+	conndb_free();
 
 	msg(LOG_NOTICE, "starting discovery\n");
 	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
@@ -376,6 +393,7 @@ static int handle_epoll_err(int errcode)
 
 	got_sigchld = 0;
 	while (true) {
+	struct nvme_connection *co;
 		int wstatus;
 		pid_t pid;
 
@@ -390,14 +408,33 @@ static int handle_epoll_err(int errcode)
 		default:
 			break;
 		}
-		if (!WIFEXITED(wstatus))
+		co = conndb_find_by_pid(pid);
+		if (!co) {
+			msg(LOG_ERR, "no connection found for discovery task %ld\n",
+			    (long)pid);
+			continue;
+		}
+		if (!WIFEXITED(wstatus)) {
 			msg(LOG_WARNING, "child %ld didn't exit normally\n",
 			    (long)pid);
-		else if (WEXITSTATUS(wstatus) != 0)
+			co->status = CS_FAILED;
+		} else if (WEXITSTATUS(wstatus) != 0) {
 			msg(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
 			    (long)pid, strerror(WEXITSTATUS(wstatus)));
-		else
+			co->status = CS_FAILED;
+			co->did_discovery = 1;
+			co->discovery_result = WEXITSTATUS(wstatus);
+		} else {
 			msg(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
+			co->status = CS_ONLINE;
+			co->successful_discovery = co->did_discovery = 1;
+			co->discovery_result = 0;
+		}
+		if (co->discovery_pending) {
+			msg(LOG_NOTICE, "new discovery pending - restarting\n");
+			monitor_discovery(co->transport, co->traddr,
+					  co->trsvcid, co->host_traddr);
+		}
 	};
 
 out:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
