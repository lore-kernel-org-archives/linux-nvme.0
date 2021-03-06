Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B34C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:52:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2A665092
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A665092
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j3xQ5hi2IrmtO4v01ChXS9/w7OFEbBPv7Jk0G4e3gsc=; b=B2CKPBvujZ23wF7FHOmrlxPet
	TcY0MEVbHD11OLKAVZ5XsxiJ9hJVs/DOZ568Ogn+WFYoz3KVqMnWRJh/vlKmqTvzV1tkTd5S06N2K
	63ulpdd3uXoR3Bou8t2Epnn+PIVHvp71GlQn4ISj2ZCvNz9kdmxyKOgoVh52xNuFIe60cgIDVWN2N
	9Np5aSLg8Nyq9GI2xAB7l4SGg2N+zuRv5O/tVCC5nejWbElazA/ndVU0mMG3DnxmfQAXp3l0wQWKB
	gRHnCTOnk9WREXf21GkpTubUSv+U9d6aC8iiy+eSCofE3iElDsylcK7xnFFtLmGsJ/JGTI2IEfd2I
	3YBiDE6nA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lILAb-00HaX7-Ue; Sat, 06 Mar 2021 00:51:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwd-00HVjs-Pf
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:30 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsGVfwTpQ2JrDPxaSCieFFvzta5eZo7Tmz06KDCfQJg=;
 b=jxKfuMzn8citK0/008ICoY3lGXWHQiXyNN51DFE5oKqi1ktPXSLlwufwkRQaLS8K/o5B9z
 /Z97H+qb78lbWY942GJuUGXbUAYr6WYhTqrU23o2Hj583iF5GU+Q5uDsGLuVi+QdX2Xk2w
 UjVcdlRe/n03W/37+452tdJXsyhg774=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 982C8AF4F;
 Sat,  6 Mar 2021 00:37:19 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 12/16] monitor: add parent/child messaging and "notify"
 message exchange
Date: Sat,  6 Mar 2021 01:36:55 +0100
Message-Id: <20210306003659.21207-13-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003726_153018_50AB3824 
X-CRM114-Status: GOOD (  28.98  )
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

Persistent discovery controllers are set up in forked children,
possibly using recursion via referrals in do_discover(). The simplest
way to keep the parent's connection registry up to date is to communicate
freshly created controllers directly from child to parent.

To make this work, a callback function is passed to do_discover(),
which (if non-null) will be called after setting up a discovery
controller to initiate the message exchange. The callback is then
passed down to connect_ctrl() for recursive discoveries (referrals).
---
 fabrics.c |  29 ++--
 fabrics.h |   9 +-
 monitor.c | 405 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 monitor.h |   6 +
 4 files changed, 435 insertions(+), 14 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index b195d0e..a9e28d8 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -50,6 +50,7 @@
 #include "common.h"
 #include "util/log.h"
 #include "util/cleanup.h"
+#include "monitor.h"
 
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -1068,7 +1069,8 @@ free_addrinfo:
 	return ret;
 }
 
-static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
+static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e,
+			const struct monitor_callbacks *monitor)
 {
 	char argstr[BUF_SIZE], *p;
 	const char *transport;
@@ -1254,7 +1256,7 @@ retry:
 		flags = validate_output_format(fabrics_cfg.output_format);
 		if (flags < 0)
 			flags = NORMAL;
-		ret = do_discover(argstr, true, flags);
+		ret = do_discover(argstr, true, flags, monitor);
 	} else
 		ret = add_ctrl(argstr);
 	if (ret == -EINVAL && e->treq & NVMF_TREQ_DISABLE_SQFLOW) {
@@ -1305,7 +1307,8 @@ static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 	return !strncmp(fabrics_cfg.traddr, entry->traddr, len);
 }
 
-static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
+static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec,
+			 const struct monitor_callbacks *monitor)
 {
 	int i;
 	int instance;
@@ -1315,7 +1318,7 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		if (!should_connect(&log->entries[i]))
 			continue;
 
-		instance = connect_ctrl(&log->entries[i]);
+		instance = connect_ctrl(&log->entries[i], monitor);
 
 		/* clean success */
 		if (instance >= 0)
@@ -1355,7 +1358,8 @@ static void nvmf_get_host_identifiers(int ctrl_instance)
 
 static DEFINE_CLEANUP_FUNC(cleanup_log, struct nvmf_disc_rsp_page_hdr *, free);
 
-int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
+int do_discover(char *argstr, bool connect, enum nvme_print_flags flags,
+		const struct monitor_callbacks *monitor)
 {
 	struct nvmf_disc_rsp_page_hdr *log __cleanup__(cleanup_log) = NULL;
 	char *dev_name;
@@ -1384,6 +1388,9 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	}
 	if (instance < 0)
 		return instance;
+	else if (monitor && monitor->notify &&
+		 (fabrics_cfg.device || fabrics_cfg.persistent))
+		monitor->notify(argstr, instance);
 
 	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
 		return -errno;
@@ -1391,6 +1398,7 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	free(dev_name);
 	if (fabrics_cfg.persistent)
 		msg(LOG_NOTICE, "Persistent device: nvme%d\n", instance);
+
 	if (!fabrics_cfg.device && !fabrics_cfg.persistent) {
 		err = remove_ctrl(instance);
 		if (err)
@@ -1400,7 +1408,7 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	switch (ret) {
 	case DISC_OK:
 		if (connect)
-			ret = connect_ctrls(log, numrec);
+			ret = connect_ctrls(log, numrec, monitor);
 		else if (fabrics_cfg.raw || flags == BINARY)
 			save_discovery_log(log, numrec);
 		else if (flags == JSON)
@@ -1440,7 +1448,8 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 
 static OPT_ARGS(discover_opts);
 
-int discover_from_conf_file(const char *desc, char *argstr, bool connect)
+int discover_from_conf_file(const char *desc, char *argstr, bool connect,
+			    const struct monitor_callbacks *monitor)
 {
 	FILE *f;
 	char line[256], *ptr, *all_args, *args, **argv;
@@ -1507,7 +1516,7 @@ int discover_from_conf_file(const char *desc, char *argstr, bool connect)
 			goto free_and_continue;
 		}
 
-		err = do_discover(argstr, connect, flags);
+		err = do_discover(argstr, connect, flags, monitor);
 		if (err)
 			ret = err;
 
@@ -1580,7 +1589,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!fabrics_cfg.transport && !fabrics_cfg.traddr) {
-		ret = discover_from_conf_file(desc, argstr, connect);
+		ret = discover_from_conf_file(desc, argstr, connect, NULL);
 	} else {
 		set_discovery_kato(&fabrics_cfg);
 
@@ -1597,7 +1606,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		if (ret)
 			goto out;
 
-		ret = do_discover(argstr, connect, flags);
+		ret = do_discover(argstr, connect, flags, NULL);
 	}
 
 out:
diff --git a/fabrics.h b/fabrics.h
index 128f251..f2f19d1 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -50,11 +50,16 @@ extern const char *const trtypes[];
 #define FILE_NVMF_DISC		"discovery.conf"
 #define PATH_NVMF_DISC		PATH_NVMF_CFG_DIR "/" FILE_NVMF_DISC
 
+struct monitor_callbacks;
+
 int build_options(char *argstr, int max_len, bool discover);
-int do_discover(char *argstr, bool connect, enum nvme_print_flags flags);
+int do_discover(char *argstr, bool connect, enum nvme_print_flags flags,
+		const struct monitor_callbacks *);
 int ctrl_instance(const char *device);
 char *parse_conn_arg(const char *conargs, const char delim, const char *field);
 int remove_ctrl(int instance);
-int discover_from_conf_file(const char *desc, char *argstr, bool connect);
+int discover_from_conf_file(const char *desc, char *argstr, bool connect,
+			    const struct monitor_callbacks *);
+
 
 #endif
diff --git a/monitor.c b/monitor.c
index a1229a7..7f08772 100644
--- a/monitor.c
+++ b/monitor.c
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <libudev.h>
 #include <signal.h>
@@ -30,6 +31,8 @@
 #include <sys/wait.h>
 #include <sys/epoll.h>
 #include <sys/inotify.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
 #include "nvme-status.h"
 #include "nvme.h"
@@ -43,6 +46,13 @@
 #include "util/log.h"
 #include "event/event.h"
 
+#define MSG_SIZE 1024
+#define SOCK_PATH "nvme-monitor"
+static const struct sockaddr_un monitor_sa = {
+	.sun_family = AF_UNIX,
+	.sun_path = "\0" SOCK_PATH
+};
+
 static struct monitor_config {
 	bool autoconnect;
 	bool keep_ctrls;
@@ -161,6 +171,395 @@ static int child_reset_signals(void)
 	return -err;
 }
 
+
+static ssize_t monitor_child_message(char *buf, size_t size, size_t len)
+{
+	int fd __cleanup__(cleanup_fd) = -1;
+	struct sockaddr_un clt_addr = { .sun_family = AF_UNIX, };
+	ssize_t rc;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd == -1) {
+		msg(LOG_ERR, "failed to create socket: %m\n");
+		return -errno;
+	}
+
+	snprintf(&clt_addr.sun_path[1], sizeof(clt_addr.sun_path) - 1,
+		 SOCK_PATH ".%ld", (long)getpid());
+
+	if ((rc = bind(fd, (struct sockaddr *)&clt_addr, sizeof(clt_addr))) == -1) {
+		msg(LOG_ERR, "failed in bind(): %m\n");
+		return -errno;
+	}
+
+	if ((rc = sendto(fd, buf, len, 0,
+			 (struct sockaddr *)&monitor_sa, sizeof(monitor_sa))) == -1) {
+		msg(LOG_ERR, "failed to send client message: %m\n");
+		return -errno;
+	}
+	msg(LOG_DEBUG, "sent %zd bytes to server\n", rc);
+
+	memset(buf, 0, size);
+	if ((rc = recv(fd, buf, size, MSG_TRUNC)) == -1) {
+		msg(LOG_ERR, "failed to receive response: %m\n");
+		return -errno;
+	} else if (rc >= size) {
+		msg(LOG_ERR, "response truncated: %zu bytes missing\n",
+		    rc - (size - 1));
+		return -EOVERFLOW;
+	}
+
+	return rc;
+}
+
+#define safe_snprintf(var, size, format, args...)			\
+({									\
+	size_t __size = size;						\
+	int __ret;							\
+									\
+	__ret = snprintf(var, __size, format, ##args);			\
+	__ret < 0 || (size_t)__ret < __size ? __ret : -EOVERFLOW;	\
+})
+
+/*
+ * Monitor parent <-> child message exchange protocol
+ *
+ * Every exchange consists of a single message sent from child (discovery
+ * process) to parent (monitor main program) and a single response from
+ * the parent to the child.
+ *
+ * "New discovery controller" exchange:
+ *    - The child sends a MON_MSG_NEW message to the parent after establishing
+ *      the connection to a new persistent discovery controller.
+ *      Payload: the instance number and the the connection parameter string
+ *      as sent to /dev/nvme-fabrics.
+ *      This exchange is initiated in notify_new_discovery(), which is passed
+ *      as "notify" callback for do_discover().
+ *    - parent responds with MON_MSG_ACK (or MON_MSG_ERR if an error occurs).
+ */
+
+static const char monitor_magic[] = "NVMM";
+enum {
+	MON_MSG_ACK = 0,
+	MON_MSG_ERR,
+	MON_MSG_NEW,
+	__MAX_MON_MSG__,
+};
+
+enum {
+	MAGIC_LEN = 4,
+	OPCODE_LEN = 4,
+	HEADER_LEN = MAGIC_LEN + OPCODE_LEN,
+};
+
+static const char *const monitor_opcode[] = {
+	[MON_MSG_ACK] = "ACK ",
+	[MON_MSG_ERR] = "ERR ",
+	[MON_MSG_NEW] = "NEW ",
+};
+
+static int monitor_msg_hdr(char *buf, size_t len, int opcode)
+{
+	memset(buf, 0, len);
+	return safe_snprintf(buf, len, "%s%s",
+			     monitor_magic, monitor_opcode[opcode]);
+}
+
+static int monitor_check_hdr(const char *buf, size_t len, int *opcode)
+{
+	int i;
+
+	if (len < HEADER_LEN) {
+		msg(LOG_ERR, "short packet\n");
+		return -EINVAL;
+	}
+
+	if (memcmp(buf, monitor_magic, MAGIC_LEN) != 0) {
+		msg(LOG_ERR, "bad magic\n");
+		return -EINVAL;
+	}
+
+	buf += MAGIC_LEN;
+	for (i = 0; i < ARRAY_SIZE(monitor_opcode); i ++) {
+		if (memcmp(buf, monitor_opcode[i], OPCODE_LEN) == 0)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(monitor_opcode)) {
+		msg(LOG_ERR, "invalid opcode\n");
+		return -EINVAL;
+	}
+
+	*opcode = i;
+	return HEADER_LEN;
+}
+
+static int monitor_ack_msg(char *buf, size_t len)
+{
+	return monitor_msg_hdr(buf, len, MON_MSG_ACK);
+}
+
+static __attribute__((unused))
+int monitor_err_msg(char *buf, size_t len)
+{
+	return monitor_msg_hdr(buf, len, MON_MSG_ERR);
+}
+
+static int monitor_check_resp(const char *buf, size_t len, int req_opcode)
+{
+	int resp_opcode, rc, done;
+
+	if ((done = monitor_check_hdr(buf, len, &resp_opcode)) < 0)
+		return done;
+
+	buf += done;
+	len -= done;
+	rc = -EINVAL;
+
+	switch (req_opcode) {
+	case MON_MSG_NEW:
+		if (resp_opcode == MON_MSG_ACK && len == 0)
+			rc = 0;
+		break;
+	default:
+		break;
+	}
+
+	msg(rc == 0 ? LOG_DEBUG : LOG_ERR,
+	    "%s response: %s => %s, len=%zu\n",
+	    rc == 0 ? "good" : "bad",
+	    monitor_opcode[req_opcode], monitor_opcode[resp_opcode], len);
+
+	return rc == 0 ? done : rc;
+}
+
+static void notify_new_discovery(const char *argstr, int instance)
+{
+	char buf[MSG_SIZE];
+	size_t len = 0;
+	ssize_t rc;
+
+	if ((rc = monitor_msg_hdr(buf, sizeof(buf), MON_MSG_NEW)) < 0) {
+		msg(LOG_ERR, "failed to create msghdr: %s\n", strerror(-rc));
+		return;
+	}
+	len += rc;
+
+	if ((rc = safe_snprintf(buf + len, sizeof(buf) - len, "%d %s",
+				instance, argstr)) < 0) {
+		msg(LOG_ERR, "failed to create msg: %s\n", strerror(-rc));
+		return;
+	}
+	len += rc;
+
+	if ((rc = monitor_child_message(buf, sizeof(buf), len)) < 0)
+		return;
+
+	monitor_check_resp(buf, rc, MON_MSG_NEW);
+}
+
+static const struct monitor_callbacks discover_callbacks = {
+	.notify = notify_new_discovery,
+};
+
+struct comm_event {
+	struct event e;
+	struct sockaddr_un addr;
+	char message[MSG_SIZE];
+	int msglen;
+};
+
+static int handle_child_msg_new(char *buf, size_t size, ssize_t *len, ssize_t ofs)
+{
+	int rc, instance, n;
+	struct nvme_connection *co = NULL;
+
+	if (*len - ofs < 2) {
+		msg(LOG_ERR, "short packet (len=%zu)\n", *len);
+		return MON_MSG_ERR;
+	}
+	buf += ofs;
+	if (sscanf(buf, "%d %n", &instance, &n) != 1) {
+		msg(LOG_ERR, "no instance number found\n");
+		return MON_MSG_ERR;
+	}
+	buf += n;
+
+	rc = conndb_add_disc_ctrl(buf, &co);
+	if (rc == 0 || rc == -EEXIST) {
+		if (co->discovery_instance != instance) {
+			co->discovery_instance = instance;
+			conn_msg(LOG_INFO, co,
+				 "discovery instance set to %d\n", instance);
+		} else
+			conn_msg(LOG_DEBUG, co, "discovery instance unchanged\n");
+	} else
+		msg(LOG_ERR, "failed to add connection: %s\n", strerror(-rc));
+
+	return MON_MSG_ACK;
+}
+
+static int handle_child_msg(struct comm_event *comm, ssize_t len)
+{
+	ssize_t rc, ofs;
+	int opcode = MON_MSG_ERR;
+	char *buf =  comm->message;
+
+	msg(LOG_DEBUG, "got message from %s: %s\n",
+	    &comm->addr.sun_path[1], buf);
+
+	if ((ofs = monitor_check_hdr(comm->message, sizeof(comm->message),
+				     &opcode)) < 0)
+		rc = MON_MSG_ERR;
+	else {
+		switch (opcode) {
+		case MON_MSG_NEW:
+			rc = handle_child_msg_new(comm->message,
+						  sizeof(comm->message),
+						  &len, ofs);
+			break;
+		case MON_MSG_ACK:
+		case MON_MSG_ERR:
+			msg(LOG_ERR, "unexpected message: %s\n", monitor_opcode[opcode]);
+			rc = MON_MSG_ERR;
+			break;
+		default:
+			msg(LOG_ERR, "bogus message\n");
+			rc = MON_MSG_ERR;
+			break;
+		};
+	}
+
+	switch (rc) {
+	case MON_MSG_ACK:
+		if ((rc = monitor_ack_msg(comm->message, sizeof(comm->message))) > 0)
+			len = rc;
+		break;
+	case MON_MSG_ERR:
+		if ((rc = monitor_err_msg(comm->message, sizeof(comm->message))) > 0)
+			len = rc;
+		break;
+	default:
+		/* other messages must be filled in by handlers above */
+		break;
+	}
+	if (rc < 0)
+		msg(LOG_ERR, "failed to create response\n");
+	else {
+		comm->msglen = len;
+		msg(LOG_DEBUG, "response (%zd): %s\n", len, comm->message);
+	}
+	return rc;
+}
+
+static int parent_comm_cb(struct event *evt, uint32_t events)
+{
+	struct comm_event *comm = container_of(evt, struct comm_event, e);
+	ssize_t rc;
+
+	if (events & EPOLLHUP) {
+		msg(LOG_WARNING, "socket disconnect\n");
+		return EVENTCB_CLEANUP;
+
+	} else if (events & EPOLLOUT) {
+		rc = sendto(evt->fd, comm->message, comm->msglen, 0,
+			    (struct sockaddr *)&comm->addr, sizeof(comm->addr));
+		if (rc == -1) {
+			msg(LOG_ERR, "sendto: %m\n");
+			return EVENTCB_CLEANUP;
+		}
+		evt->ep.events = EPOLLIN|EPOLLHUP;
+
+	} else if (events & EPOLLIN) {
+		socklen_t len;
+
+		memset(&comm->addr, 0, sizeof(comm->addr));
+		len = sizeof(comm->addr);
+		rc = recvfrom(evt->fd, comm->message, sizeof(comm->message),
+			      MSG_TRUNC, (struct sockaddr*)&comm->addr, &len);
+		if (rc <= 0) {
+			msg(LOG_ERR, "error receiving child message: %m\n");
+			return EVENTCB_CONTINUE;
+		} else if (rc >= sizeof(comm->message)) {
+			msg(LOG_ERR, "child message truncated: %zd bytes missing\n",
+			    rc - (sizeof(comm->message) - 1));
+			return EVENTCB_CONTINUE;
+		}
+		if (handle_child_msg(comm, rc) < 0)
+			return EVENTCB_CONTINUE;
+
+		evt->ep.events = EPOLLOUT|EPOLLHUP;
+	}
+
+	if ((rc = event_modify(evt)) < 0) {
+		msg(LOG_ERR, "event_modify: %s\n", strerror(-rc));
+		return EVENTCB_CLEANUP;
+	}
+
+	return EVENTCB_CONTINUE;
+}
+
+static int set_socketflags(int fd)
+{
+	int flags;
+
+	if ((flags = fcntl(fd, F_GETFL, 0)) == -1) {
+		msg(LOG_ERR, "F_GETFL failed: %m\n");
+		return -errno;
+	}
+	if (fcntl(fd, F_SETFL, flags|O_NONBLOCK) == -1) {
+		msg(LOG_ERR, "F_SETFL failed: %m\n");
+		return -errno;
+	}
+	if ((flags = fcntl(fd, F_GETFD, 0)) == -1) {
+		msg(LOG_ERR, "F_GETFD failed: %m\n");
+		return -errno;
+	}
+	if (fcntl(fd, F_SETFD, flags|FD_CLOEXEC) == -1) {
+		msg(LOG_ERR, "F_SETFD failed: %m\n");
+		return -errno;
+	}
+	return 0;
+}
+
+static DEFINE_CLEANUP_FUNC(cleanup_comm, struct comm_event *, free);
+
+static void add_parent_comm_event(struct dispatcher *dsp)
+{
+	struct comm_event *comm __cleanup__(cleanup_comm) = NULL;
+	int fd __cleanup__(cleanup_fd) = -1;
+	int rc;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd == -1) {
+		msg(LOG_ERR, "failed to create socket: %m\n");
+		return;
+	}
+
+	if ((rc = set_socketflags(fd)) < 0)
+		return;
+
+	if (bind(fd, (struct sockaddr *)&monitor_sa,
+		 sizeof(monitor_sa)) == -1) {
+		msg(LOG_ERR, "bind() failed: %m\n");
+		return;
+	}
+
+	comm = calloc(1, sizeof(*comm));
+	if (!comm)
+		return;
+
+	comm->e = EVENT_ON_HEAP(parent_comm_cb, fd, EPOLLIN);
+
+	if ((rc = event_add(dsp, &comm->e)) < 0) {
+		msg(LOG_ERR, "failed to add child communication event: %s\n",
+		    strerror(-rc));
+		return;
+	}
+	fd = -1;
+	comm = NULL;
+}
+
 static void monitor_handle_nvme_add(struct udev_device *ud)
 {
 	const char *syspath = udev_device_get_syspath(ud);
@@ -311,7 +710,7 @@ static int monitor_discovery(const char *transport, const char *traddr,
 
 	rc = build_options(argstr, sizeof(argstr), true);
 	msg(LOG_DEBUG, "%s\n", argstr);
-	rc = do_discover(argstr, mon_cfg.autoconnect, NORMAL);
+	rc = do_discover(argstr, mon_cfg.autoconnect, NORMAL, &discover_callbacks);
 
 	free(device);
 	exit(-rc);
@@ -634,7 +1033,8 @@ static int monitor_discover_from_conf_file(void)
 	fabrics_cfg.persistent = true;
 
 	rc = discover_from_conf_file("Discover NVMeoF subsystems from " PATH_NVMF_DISC,
-				     argstr, mon_cfg.autoconnect);
+				     argstr, mon_cfg.autoconnect,
+				     &discover_callbacks);
 
 	exit(-rc);
 	/* not reached */
@@ -848,6 +1248,7 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	}
 
 	add_inotify_event(mon_dsp);
+	add_parent_comm_event(mon_dsp);
 	conndb_init_from_sysfs();
 
 	ret = event_loop(mon_dsp, &wait_mask, handle_epoll_err);
diff --git a/monitor.h b/monitor.h
index e79d3a6..01ae4de 100644
--- a/monitor.h
+++ b/monitor.h
@@ -1,6 +1,12 @@
 #ifndef _MONITOR_H
 #define _MONITOR_H
 
+typedef void (*disc_notify_cb)(const char *argstr, int instance);
+
+struct monitor_callbacks {
+	disc_notify_cb notify;
+};
+
 extern int aen_monitor(const char *desc, int argc, char **argv);
 
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
