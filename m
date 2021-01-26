Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB67C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E3722A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3722A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W5ftAlyMs6Hx1zmvV/TsqJOqXnItL3JYRpsO1kXRltg=; b=yaron80Fk1ODOo0k9mbamdtil
	m93vtstSYxy/zp8mHMf+kMAVwTfawzmfiXqyV1fJ7W6HxQ3M4J1j0Xwoq7DvmSLxolX6ULjOuc/hc
	8hedVKhT0omHi4PhlWagKB058f0+4gsyWu03buV66jbkxXUJNJ3QlB+AV7sKagaO0F9F98XUGeojG
	eQ1lczARWXnQYzhPDwwTOq7EUuwvWX/Ly1iZy4TVlgl0136u6oTcZAw5d4WtXpdFf4+dmZzw+uCRW
	H/JJuXNX+VL+VLpyC+YGtXzhksbyV56WvgswTnVkysBoAju+tmaiWi7Q42nzOcx/GqTqDKU2gloO8
	WZv7oLYRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V4O-00022O-T9; Tue, 26 Jan 2021 20:36:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2A-0000zj-8K
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8MNSl+KA6CXIQkbXwx+UqMI1fa0w48URqnF/kCuMZU=;
 b=OjlfimANONgl7u/L64bf552lO4O/oGp0WJ8UYyUz556xLpZze4eejTx7mzfNXEPls5lz9e
 rBfUjr3cCTZ0uJ+hxwkR617FSmxlNncr8h5yHeIDv+XocGlUG+7RMALnFgasMixCm3rIcQ
 feBxI7cUERSEDY9kMpJqYqRLzoTd/4M=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CA70BAF1A;
 Tue, 26 Jan 2021 20:33:48 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 22/35] conn-db: add simple connection registry
Date: Tue, 26 Jan 2021 21:33:11 +0100
Message-Id: <20210126203324.23610-23-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153354_621532_222A4DB2 
X-CRM114-Status: GOOD (  34.66  )
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

The monitor works best if it maintains a discovery controller connection
to every transport address that provides a discovery subsystem.

While controllers are easily tracked in sysfs, addresses ("connections"),
i.e. (transport, traddr, trsvid, host_traddr) tuples, are not. Create
a simple registry that tracks the state of "connections" and their
associated discovery controllers.

A detailed description of the API is provided in the header file conn-db.h.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Makefile  |   2 +-
 conn-db.c | 340 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 conn-db.h | 140 ++++++++++++++++++++++
 3 files changed, 481 insertions(+), 1 deletion(-)
 create mode 100644 conn-db.c
 create mode 100644 conn-db.h

diff --git a/Makefile b/Makefile
index 21c9a23..6ac5030 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
 ifeq ($(HAVE_LIBUDEV),0)
-	OBJS += monitor.o
+	OBJS += monitor.o conn-db.o
 endif
 
 UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o
diff --git a/conn-db.c b/conn-db.c
new file mode 100644
index 0000000..99d88da
--- /dev/null
+++ b/conn-db.c
@@ -0,0 +1,340 @@
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
+#include "list.h"
+#include "nvme.h"
+#include "fabrics.h"
+#include "conn-db.h"
+
+#define LOG_FUNCNAME 1
+#include "log.h"
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
+CLEANUP_FUNC(char)
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
+#define _log_conn(lvl, msg, transport, traddr, trsvcid, host_traddr)	\
+	do {								\
+		const char *__trs = trsvcid;				\
+									\
+		log(lvl, "%s <%s>: %s ==> %s(%s)\n",			\
+		    msg, transport, host_traddr, traddr,		\
+		    __trs && *__trs ? __trs : "none");			\
+	} while (0)
+
+#define log_conn(lvl, msg, conn)					\
+	_log_conn(lvl, msg, (conn)->c.transport,			\
+		  (conn)->c.traddr, (conn)->c.trsvcid,			\
+		  (conn)->c.host_traddr)
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
+static void conn_free_p(struct conn_int **ci)
+{
+	if (*ci) {
+		conn_free(*ci);
+		*ci = NULL;
+	}
+}
+
+static int conn_del(struct conn_int *ci)
+{
+	if (!ci)
+		return -ENOENT;
+	if (list_empty(&ci->lst))
+		return -EINVAL;
+	log_conn(LOG_INFO, "forgetting connection", ci);
+	list_del(&ci->lst);
+	conn_free(ci);
+	return 0;
+}
+
+bool conndb_matches(const char *transport, const char *traddr,
+		    const char *trsvcid, const char *host_traddr,
+		    const struct nvme_connection *co)
+{
+	if (!co)
+		return false;
+	if (!transport || strcmp(transport, co->transport))
+		return false;
+	if (!traddr || strncmp(traddr, co->traddr, NVMF_TRADDR_SIZE))
+		return false;
+	if ((!trsvcid && co->trsvcid) ||
+	    (trsvcid && *trsvcid && (!co->trsvcid ||
+			 strncmp(trsvcid, co->trsvcid, NVMF_TRSVCID_SIZE))))
+		return false;
+	if (!host_traddr || (strncmp(host_traddr, co->host_traddr,
+				     NVMF_TRADDR_SIZE)))
+		return false;
+	return true;
+}
+
+static struct conn_int *conn_find(const char *transport, const char *traddr,
+				  const char *trsvcid, const char *host_traddr)
+{
+	struct conn_int *ci;
+
+	if (!transport || !traddr || !host_traddr)
+		return NULL;
+	list_for_each_entry(ci, &connections, lst) {
+		if (conndb_matches(transport, traddr, trsvcid, host_traddr, &ci->c))
+			return ci;
+	}
+	return NULL;
+}
+
+static bool is_supported_transport(const char *transport)
+{
+
+	return !strcmp(transport, "fc") || !strcmp(transport, "rdma") ||
+	       !strcmp(transport, "tcp") || !strcmp(transport, "loop");
+}
+
+static int _conn_add(const char *transport, const char *traddr,
+		     const char *trsvcid, const char *host_traddr,
+		     struct conn_int **new_ci)
+{
+	struct conn_int *ci __attribute__((cleanup(conn_free_p))) = NULL;
+
+	if (!transport || !is_supported_transport(transport) || !traddr)
+		return -EINVAL;
+
+	if (!(ci = calloc(1, sizeof(*ci))) ||
+	    !(ci->c.traddr = strndup(traddr, NVMF_TRADDR_SIZE)) ||
+	    !(ci->c.host_traddr = strndup(host_traddr, NVMF_TRADDR_SIZE)) ||
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
+		log_conn(LOG_DEBUG, "added connection", *new_ci);
+	else
+		_log_conn(LOG_ERR, "failed to add", transport, traddr,
+			  trsvcid, host_traddr);
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
+	if (!instance)
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
+		CLEANUP(char, transport) = NULL;
+		CLEANUP(char, address) = NULL;
+		CLEANUP(char, traddr) = NULL;
+		CLEANUP(char, trsvcid) = NULL;
+		CLEANUP(char, host_traddr) = NULL;
+		CLEANUP(char, subsysnqn) = NULL;
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
+			ret ++;
+		subsysnqn = nvme_get_ctrl_attr(syspath, "subsysnqn");
+		if (subsysnqn && !strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME)) {
+			int instance = ctrl_instance(devices[i]->d_name);
+
+			if (instance >= 0) {
+				ci->c.discovery_instance = instance;
+				log(LOG_DEBUG, "found discovery controller %s\n",
+				    devices[i]->d_name);
+			}
+		}
+		free(devices[i]);
+	}
+	free(devices);
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
+			log(LOG_ERR,
+			    "invalid return value 0x%x from callback\n", rc);
+			ret = -EINVAL;
+			continue;
+		}
+		if (rc & CD_CB_ERR) {
+			log(LOG_WARNING, "callback returned error\n");
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
index 0000000..c599c15
--- /dev/null
+++ b/conn-db.h
@@ -0,0 +1,140 @@
+#ifndef _CONN_DB_H
+#define _CONN_DB_H
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
+#endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
