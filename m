Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DEC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:55:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D8B65071
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D8B65071
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YVgiX0IPt6e1npQOfmXdOfB9OYsQsuIQTjWNHeo8zoM=; b=WtZnqre+9r7F2YN3v46PXQfUn
	7U/+2VSl9XvzG52eNOjF1x1BRAoPO0XB6nslhyLE5GBU9cv18N2mfv5mimwNyBzzDaoz/WxQbpQb0
	b4PmHK+M1iYZW0hdGdmcD0wzcUZGzrKbHg4a3SGrF9sfK7t/fJnycYMkEijulZT6nWl52gqrrBk1Q
	m+pHksZ7DR+e0OH2kFhZiUyMGubej8WpA1z4FExrEo47s4rblvce021rMEyrWGvEv8gntBtwZNekv
	l4sp3r+t4rGuEkGzzOMMRCdU+4LqM239sAErpVjwEjN/IBeuTx2834NA3jUK2aa1mNq7q+k0JE1LU
	1+bcWyiXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lILDd-0000Ou-5h; Sat, 06 Mar 2021 00:54:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwf-00HVkI-Mq
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXghCs/DyRc67PJXoNqfmk3lBpMECPwrgYMDYRioi/I=;
 b=FuHuX1IkzRZH4HLlqmcIM2XFOmy6wDHuj+eUnQo27JJxMnsWYrbnQ11LLAX1eiXYFgY8Eh
 r8nIptDVtgdZs9MTA1MvPXmivyGdLdI0U0vCamg+qeDigbwnCNm5fSjmLsDAIt/bK61DJ1
 7rzPByiqciNjIqY9rJEcNxyinbOYWAs=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EBA21AF54;
 Sat,  6 Mar 2021 00:37:19 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 13/16] monitor: add "query device" message exchange
Date: Sat,  6 Mar 2021 01:36:56 +0100
Message-Id: <20210306003659.21207-14-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003731_974970_D4F79C93 
X-CRM114-Status: GOOD (  21.33  )
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

This message exchange sends a message with the current connection
parameters to the parent monitor process and attempts to obtain
the instance number of an existing discovery controller for the
given connection.

For making this work, another callback is added to monitor_callbacks()
do be called before attempting a discovery connection.
---
 fabrics.c |   4 ++
 monitor.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 monitor.h |   2 +
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index a9e28d8..64468db 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1376,6 +1376,10 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags,
 		free(fabrics_cfg.device);
 		fabrics_cfg.device = NULL;
 	}
+
+	if (!fabrics_cfg.device && monitor && monitor->query_dev)
+		monitor->query_dev(argstr, &fabrics_cfg.device);
+
 	if (!fabrics_cfg.device)
 		fabrics_cfg.device = find_ctrl_with_connectargs(cargs);
 	free_connect_args(cargs);
diff --git a/monitor.c b/monitor.c
index 7f08772..f2d9512 100644
--- a/monitor.c
+++ b/monitor.c
@@ -236,6 +236,19 @@ static ssize_t monitor_child_message(char *buf, size_t size, size_t len)
  *      This exchange is initiated in notify_new_discovery(), which is passed
  *      as "notify" callback for do_discover().
  *    - parent responds with MON_MSG_ACK (or MON_MSG_ERR if an error occurs).
+ *
+ * "Query existing device" exchange:
+ *   - The child sends a MON_MSG_QDEV message to the parent after determining
+ *      transport connection parameters, but before attempting to create a
+ *      discovery controller.
+ *      Payload: the transport parameter string to be sent to /dev/nvme-fabrics.
+ *      This exchange is initiated in query_device(), which is passed as
+ *      "query_dev" callback for discover_from_conf_file().
+ *    - The parent responds:
+ *       * MON_MSG_SDEV ("send device") if an existing controller device was found
+ *         Payload: the instance number of the controller ("0" for /dev/nvme0").
+ *       * MON_MSG_ACK: if no existing controller device was found.
+ *       * MON_MSG_ERR: in case of an error.
  */
 
 static const char monitor_magic[] = "NVMM";
@@ -243,6 +256,8 @@ enum {
 	MON_MSG_ACK = 0,
 	MON_MSG_ERR,
 	MON_MSG_NEW,
+	MON_MSG_QDEV,
+	MON_MSG_SDEV,
 	__MAX_MON_MSG__,
 };
 
@@ -256,6 +271,8 @@ static const char *const monitor_opcode[] = {
 	[MON_MSG_ACK] = "ACK ",
 	[MON_MSG_ERR] = "ERR ",
 	[MON_MSG_NEW] = "NEW ",
+	[MON_MSG_QDEV] = "QDEV",
+	[MON_MSG_SDEV] = "SDEV",
 };
 
 static int monitor_msg_hdr(char *buf, size_t len, int opcode)
@@ -321,6 +338,11 @@ static int monitor_check_resp(const char *buf, size_t len, int req_opcode)
 		if (resp_opcode == MON_MSG_ACK && len == 0)
 			rc = 0;
 		break;
+	case MON_MSG_QDEV:
+		if ((resp_opcode == MON_MSG_ACK && len == 0) ||
+		    (resp_opcode == MON_MSG_SDEV && len > 0))
+			rc = 0;
+		break;
 	default:
 		break;
 	}
@@ -358,10 +380,54 @@ static void notify_new_discovery(const char *argstr, int instance)
 	monitor_check_resp(buf, rc, MON_MSG_NEW);
 }
 
+static void query_device(const char *argstr, char **device)
+{
+	char buf[MSG_SIZE];
+	size_t len = 0;
+	ssize_t rc;
+	int instance;
+	char dummy;
+	char *pbuf, *dev;
+
+	if ((rc = monitor_msg_hdr(buf, sizeof(buf), MON_MSG_QDEV)) < 0) {
+		msg(LOG_ERR, "failed to create msghdr: %s\n", strerror(-rc));
+		return;
+	}
+	len += rc;
+	if ((rc = safe_snprintf(buf + len, sizeof(buf) - len, "%s", argstr)) < 0) {
+		msg(LOG_ERR, "failed to create msg: %s\n", strerror(-rc));
+		return;
+	}
+	len += rc;
+	if ((rc = monitor_child_message(buf, sizeof(buf), len)) < 0)
+		return;
+
+	len = rc;
+	pbuf = buf;
+	if ((rc = monitor_check_resp(pbuf, len, MON_MSG_QDEV)) < 0)
+		return;
+
+	pbuf += rc;
+	len -= rc;
+	if (len == 0) {
+		msg(LOG_INFO, "monitor didn't report existing device\n");
+		return;
+	} else if (sscanf(pbuf, "%d%c", &instance, &dummy) != 1) {
+		msg(LOG_WARNING, "got bad device info: %s\n", pbuf);
+		return;
+	}
+
+	if (asprintf(&dev, "nvme%d", instance) < 0)
+		return;
+
+	msg(LOG_INFO, "monitor reported existing device %s\n", dev);
+	*device = dev;
+}
+
 static const struct monitor_callbacks discover_callbacks = {
 	.notify = notify_new_discovery,
+	.query_dev = query_device,
 };
-
 struct comm_event {
 	struct event e;
 	struct sockaddr_un addr;
@@ -399,6 +465,41 @@ static int handle_child_msg_new(char *buf, size_t size, ssize_t *len, ssize_t of
 	return MON_MSG_ACK;
 }
 
+static int handle_child_msg_qdev(char *buf, size_t size, ssize_t *len, ssize_t ofs)
+{
+	ssize_t rc = MON_MSG_ERR;
+	struct nvme_connection *co;
+	char *pbuf = buf;
+
+	if (*len <= ofs) {
+		msg(LOG_ERR, "short packet (len=%zd)\n", *len);
+		return MON_MSG_ERR;
+	}
+
+	pbuf += ofs;
+	rc = conndb_add_disc_ctrl(pbuf, &co);
+	if (rc != 0 && rc != -EEXIST) {
+		msg(LOG_WARNING, "invalid address: \"%s\"\n", buf);
+		return MON_MSG_ERR;
+	}
+
+	if (co->discovery_instance != -1) {
+		rc = monitor_msg_hdr(buf, size, MON_MSG_SDEV);
+		if (rc >= 0) {
+			buf += rc;
+			if ((rc = snprintf(buf, size - rc, "%d",
+					   co->discovery_instance)) >= 0) {
+				*len = ofs + rc;
+				return MON_MSG_SDEV;
+			}
+		}
+		msg(LOG_ERR, "failed to create SDEV message: %s\n",
+		    strerror(-rc));
+	}
+
+	return MON_MSG_ACK;
+}
+
 static int handle_child_msg(struct comm_event *comm, ssize_t len)
 {
 	ssize_t rc, ofs;
@@ -418,8 +519,14 @@ static int handle_child_msg(struct comm_event *comm, ssize_t len)
 						  sizeof(comm->message),
 						  &len, ofs);
 			break;
+		case MON_MSG_QDEV:
+			rc = handle_child_msg_qdev(comm->message,
+						   sizeof(comm->message),
+						   &len, ofs);
+			break;
 		case MON_MSG_ACK:
 		case MON_MSG_ERR:
+		case MON_MSG_SDEV:
 			msg(LOG_ERR, "unexpected message: %s\n", monitor_opcode[opcode]);
 			rc = MON_MSG_ERR;
 			break;
diff --git a/monitor.h b/monitor.h
index 01ae4de..3c2f6da 100644
--- a/monitor.h
+++ b/monitor.h
@@ -2,9 +2,11 @@
 #define _MONITOR_H
 
 typedef void (*disc_notify_cb)(const char *argstr, int instance);
+typedef void (*disc_query_dev_cb)(const char *argstr, char **device);
 
 struct monitor_callbacks {
 	disc_notify_cb notify;
+	disc_query_dev_cb query_dev;
 };
 
 extern int aen_monitor(const char *desc, int argc, char **argv);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
