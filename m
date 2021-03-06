Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED5C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:40:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584C464F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584C464F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7u8t4ZJ9xynLUZCvJEHmSQ7L9MCR8y+MARuho+kS/pU=; b=j4Fq+P3KknXffiYX2VCkaN5Cm
	bLzwnCpjGgq/ewTnbslCA4lSaNZo20Wyx1LAS5fIUY9KAhDwOxMb27Ds+hPo1gkXd/e/fnbnWwGxW
	tLw6wYhFBNuXItHK65NCa5lzDmGcIxz41i8tb0BvDOVRnZRxAEHjt2NhnI/bvFJls2/Qz6LQYr0gq
	iU5rrRLDAQK5YtwheqwATX3tgDDojxICZYDNEUGEAyTP8hZY9fItZnJH7LMdjUcN5www/t9VlXZbq
	vZKx5z64kUqCYJLHuiuilVrNcygjVxBzo4/nmfiw+nZHKApEhLTL/flEV8rAg0O4Gv9tI9yYzakg9
	CRxS4CXJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKza-00HWyp-Nn; Sat, 06 Mar 2021 00:40:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwW-00HVfL-04
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWcEygdlZnsyW0HgGnM6nuOfbguTmmNCGxgrdmDwDV8=;
 b=UbEQFGP9piBNWaRa9ZyBRqHjF9ZnLoLTfBwLcJU4X5k6MinboNzw0l7tJqHLbo1qc1lKzA
 SzFjH2A9mPkDjEuPA8k6WRS2vesgARazZuf6P5LJl/re75B6YqM8D4qnK8ccvJeI5ElwIj
 dSy0OGdjAALvJBsh+rqoOYvnIp4fyoQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9926FAE1B;
 Sat,  6 Mar 2021 00:37:15 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 01/16] fabrics: export symbols required for monitor
 functionality
Date: Sat,  6 Mar 2021 01:36:44 +0100
Message-Id: <20210306003659.21207-2-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_068128_B6FFBDF7 
X-CRM114-Status: GOOD (  20.30  )
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

These macros, functions and variables will be used by the "nvme monitor"
functionality. Convert them to globally visible symbols.

Being able to access struct config and the "cfg" variable
from fabrics.c is essential for the monitor to leverage the existing,
well tested code as much as possible. Rename "cfg" to "fabrics_cfg"
to make the global variable name less generic.
---
 fabrics.c | 384 +++++++++++++++++++++++++-----------------------------
 fabrics.h |  42 ++++++
 2 files changed, 222 insertions(+), 204 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 1fcc6cf..5012519 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -67,33 +67,8 @@ const char *conarg_traddr = "traddr";
 const char *conarg_trsvcid = "trsvcid";
 const char *conarg_host_traddr = "host_traddr";
 
-static struct config {
-	const char *nqn;
-	const char *transport;
-	const char *traddr;
-	const char *trsvcid;
-	const char *host_traddr;
-	const char *hostnqn;
-	const char *hostid;
-	int  nr_io_queues;
-	int  nr_write_queues;
-	int  nr_poll_queues;
-	int  queue_size;
-	int  keep_alive_tmo;
-	int  reconnect_delay;
-	int  ctrl_loss_tmo;
-	int  tos;
-	const char *raw;
-	char *device;
-	int  duplicate_connect;
-	int  disable_sqflow;
-	int  hdr_digest;
-	int  data_digest;
-	bool persistent;
-	bool matching_only;
-	const char *output_format;
-} cfg = {
-	.ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO,
+struct fabrics_config fabrics_cfg = {
+	.ctrl_loss_tmo = -1,
 	.output_format = "normal",
 };
 
@@ -109,7 +84,6 @@ struct connect_args {
 
 struct connect_args *tracked_ctrls;
 
-#define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
@@ -129,7 +103,7 @@ static const match_table_t opt_tokens = {
 	{ OPT_ERR,		NULL		},
 };
 
-static const char *arg_str(const char * const *strings,
+const char *arg_str(const char * const *strings,
 		size_t array_size, size_t idx)
 {
 	if (idx < array_size && strings[idx])
@@ -137,7 +111,7 @@ static const char *arg_str(const char * const *strings,
 	return "unrecognized";
 }
 
-static const char * const trtypes[] = {
+const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fc",
 	[NVMF_TRTYPE_TCP]	= "tcp",
@@ -228,14 +202,12 @@ static const char *cms_str(__u8 cm)
 	return arg_str(cms, ARRAY_SIZE(cms), cm);
 }
 
-static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags);
-
 /*
  * parse strings with connect arguments to find a particular field.
  * If field found, return string containing field value. If field
  * not found, return an empty string.
  */
-static char *parse_conn_arg(const char *conargs, const char delim, const char *field)
+char *parse_conn_arg(const char *conargs, const char delim, const char *field)
 {
 	char *s, *e;
 	size_t cnt;
@@ -279,7 +251,7 @@ empty_field:
 	return strdup("\0");
 }
 
-static int ctrl_instance(const char *device)
+int ctrl_instance(const char *device)
 {
 	char d[64];
 	const char *p;
@@ -542,7 +514,7 @@ out:
 	return ret;
 }
 
-static int remove_ctrl(int instance)
+int remove_ctrl(int instance)
 {
 	char *sysfs_path;
 	int ret;
@@ -802,10 +774,10 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	int fd;
 	int len, ret;
 
-	fd = open(cfg.raw, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
+	fd = open(fabrics_cfg.raw, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (fd < 0) {
 		msg(LOG_ERR, "failed to open %s: %s\n",
-			cfg.raw, strerror(errno));
+			fabrics_cfg.raw, strerror(errno));
 		return;
 	}
 
@@ -814,9 +786,9 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	ret = write(fd, log, len);
 	if (ret < 0)
 		msg(LOG_ERR, "failed to write to %s: %s\n",
-			cfg.raw, strerror(errno));
+			fabrics_cfg.raw, strerror(errno));
 	else
-		printf("Discovery log is saved to %s\n", cfg.raw);
+		printf("Discovery log is saved to %s\n", fabrics_cfg.raw);
 
 	close(fd);
 }
@@ -878,9 +850,9 @@ char *hostnqn_read(void)
 
 static int nvmf_hostnqn_file(void)
 {
-	cfg.hostnqn = hostnqn_read();
+	fabrics_cfg.hostnqn = hostnqn_read();
 
-	return cfg.hostnqn != NULL;
+	return fabrics_cfg.hostnqn != NULL;
 }
 
 static int nvmf_hostid_file(void)
@@ -896,8 +868,8 @@ static int nvmf_hostid_file(void)
 	if (fgets(hostid, sizeof(hostid), f) == NULL)
 		goto out;
 
-	cfg.hostid = strdup(hostid);
-	if (!cfg.hostid)
+	fabrics_cfg.hostid = strdup(hostid);
+	if (!fabrics_cfg.hostid)
 		goto out;
 
 	ret = true;
@@ -955,68 +927,71 @@ add_argument(char **argstr, int *max_len, char *arg_str, const char *arg)
 	return 0;
 }
 
-static int build_options(char *argstr, int max_len, bool discover)
+int build_options(char *argstr, int max_len, bool discover)
 {
 	int len;
 
-	if (!cfg.transport) {
+	if (!fabrics_cfg.transport) {
 		msg(LOG_ERR, "need a transport (-t) argument\n");
 		return -EINVAL;
 	}
 
-	if (strncmp(cfg.transport, "loop", 4)) {
-		if (!cfg.traddr) {
+	if (strncmp(fabrics_cfg.transport, "loop", 4)) {
+		if (!fabrics_cfg.traddr) {
 			msg(LOG_ERR, "need a address (-a) argument\n");
 			return -EINVAL;
 		}
+		/* Use the default ctrl loss timeout if unset */
+		if (fabrics_cfg.ctrl_loss_tmo == -1)
+			fabrics_cfg.ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 	}
 
 	/* always specify nqn as first arg - this will init the string */
-	len = snprintf(argstr, max_len, "nqn=%s", cfg.nqn);
+	len = snprintf(argstr, max_len, "nqn=%s", fabrics_cfg.nqn);
 	if (len < 0)
 		return -EINVAL;
 	argstr += len;
 	max_len -= len;
 
-	if (add_argument(&argstr, &max_len, "transport", cfg.transport) ||
-	    add_argument(&argstr, &max_len, "traddr", cfg.traddr) ||
-	    add_argument(&argstr, &max_len, "host_traddr", cfg.host_traddr) ||
-	    add_argument(&argstr, &max_len, "trsvcid", cfg.trsvcid) ||
-	    ((cfg.hostnqn || nvmf_hostnqn_file()) &&
-		    add_argument(&argstr, &max_len, "hostnqn", cfg.hostnqn)) ||
-	    ((cfg.hostid || nvmf_hostid_file()) &&
-		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
+	if (add_argument(&argstr, &max_len, "transport", fabrics_cfg.transport) ||
+	    add_argument(&argstr, &max_len, "traddr", fabrics_cfg.traddr) ||
+	    add_argument(&argstr, &max_len, "host_traddr", fabrics_cfg.host_traddr) ||
+	    add_argument(&argstr, &max_len, "trsvcid", fabrics_cfg.trsvcid) ||
+	    ((fabrics_cfg.hostnqn || nvmf_hostnqn_file()) &&
+		    add_argument(&argstr, &max_len, "hostnqn", fabrics_cfg.hostnqn)) ||
+	    ((fabrics_cfg.hostid || nvmf_hostid_file()) &&
+		    add_argument(&argstr, &max_len, "hostid", fabrics_cfg.hostid)) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "nr_io_queues",
-				cfg.nr_io_queues, false)) ||
+				fabrics_cfg.nr_io_queues, false)) ||
 	    add_int_argument(&argstr, &max_len, "nr_write_queues",
-				cfg.nr_write_queues, false) ||
+				fabrics_cfg.nr_write_queues, false) ||
 	    add_int_argument(&argstr, &max_len, "nr_poll_queues",
-				cfg.nr_poll_queues, false) ||
+				fabrics_cfg.nr_poll_queues, false) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "queue_size",
-				cfg.queue_size, false)) ||
+				fabrics_cfg.queue_size, false)) ||
 	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
-				cfg.keep_alive_tmo, false) ||
+			     fabrics_cfg.keep_alive_tmo, false) ||
 	    add_int_argument(&argstr, &max_len, "reconnect_delay",
-				cfg.reconnect_delay, false) ||
-	    (strncmp(cfg.transport, "loop", 4) &&
+				fabrics_cfg.reconnect_delay, false) ||
+	    (strncmp(fabrics_cfg.transport, "loop", 4) &&
 	     add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
-				cfg.ctrl_loss_tmo, true)) ||
+			      fabrics_cfg.ctrl_loss_tmo, true)) ||
 	    add_int_argument(&argstr, &max_len, "tos",
-				cfg.tos, true) ||
+				fabrics_cfg.tos, true) ||
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
-				cfg.duplicate_connect) ||
+				fabrics_cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
-				cfg.disable_sqflow) ||
-	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
-	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
+				fabrics_cfg.disable_sqflow) ||
+	    add_bool_argument(&argstr, &max_len, "hdr_digest", fabrics_cfg.hdr_digest) ||
+	    add_bool_argument(&argstr, &max_len, "data_digest", fabrics_cfg.data_digest))
 		return -EINVAL;
 
 	return 0;
 }
 
-static void set_discovery_kato(struct config *cfg)
+static void set_discovery_kato(struct fabrics_config *cfg)
 {
 	/* Set kato to NVMF_DEF_DISC_TMO for persistent controllers */
 	if (cfg->persistent && !cfg->keep_alive_tmo)
@@ -1026,41 +1001,41 @@ static void set_discovery_kato(struct config *cfg)
 		cfg->keep_alive_tmo = 0;
 }
 
-static void discovery_trsvcid(struct config *cfg)
+static void discovery_trsvcid(struct fabrics_config *fabrics_cfg)
 {
-	if (!strcmp(cfg->transport, "tcp")) {
+	if (!strcmp(fabrics_cfg->transport, "tcp")) {
 		/* Default port for NVMe/TCP discovery controllers */
-		cfg->trsvcid = __stringify(NVME_DISC_IP_PORT);
-	} else if (!strcmp(cfg->transport, "rdma")) {
+		fabrics_cfg->trsvcid = __stringify(NVME_DISC_IP_PORT);
+	} else if (!strcmp(fabrics_cfg->transport, "rdma")) {
 		/* Default port for NVMe/RDMA controllers */
-		cfg->trsvcid = __stringify(NVME_RDMA_IP_PORT);
+		fabrics_cfg->trsvcid = __stringify(NVME_RDMA_IP_PORT);
 	}
 }
 
-static bool traddr_is_hostname(struct config *cfg)
+static bool traddr_is_hostname(struct fabrics_config *fabrics_cfg)
 {
 	char addrstr[NVMF_TRADDR_SIZE];
 
-	if (!cfg->traddr || !cfg->transport)
+	if (!fabrics_cfg->traddr || !fabrics_cfg->transport)
 		return false;
-	if (strcmp(cfg->transport, "tcp") && strcmp(cfg->transport, "rdma"))
+	if (strcmp(fabrics_cfg->transport, "tcp") && strcmp(fabrics_cfg->transport, "rdma"))
 		return false;
-	if (inet_pton(AF_INET, cfg->traddr, addrstr) > 0 ||
-	    inet_pton(AF_INET6, cfg->traddr, addrstr) > 0)
+	if (inet_pton(AF_INET, fabrics_cfg->traddr, addrstr) > 0 ||
+	    inet_pton(AF_INET6, fabrics_cfg->traddr, addrstr) > 0)
 		return false;
 	return true;
 }
 
-static int hostname2traddr(struct config *cfg)
+static int hostname2traddr(struct fabrics_config *fabrics_cfg)
 {
 	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
 	char addrstr[NVMF_TRADDR_SIZE];
 	const char *p;
 	int ret;
 
-	ret = getaddrinfo(cfg->traddr, NULL, &hints, &host_info);
+	ret = getaddrinfo(fabrics_cfg->traddr, NULL, &hints, &host_info);
 	if (ret) {
-		msg(LOG_ERR, "failed to resolve host %s info\n", cfg->traddr);
+		msg(LOG_ERR, "failed to resolve host %s info\n", fabrics_cfg->traddr);
 		return ret;
 	}
 
@@ -1077,17 +1052,17 @@ static int hostname2traddr(struct config *cfg)
 		break;
 	default:
 		msg(LOG_ERR, "unrecognized address family (%d) %s\n",
-			host_info->ai_family, cfg->traddr);
+			host_info->ai_family, fabrics_cfg->traddr);
 		ret = -EINVAL;
 		goto free_addrinfo;
 	}
 
 	if (!p) {
-		msg(LOG_ERR, "failed to get traddr for %s\n", cfg->traddr);
+		msg(LOG_ERR, "failed to get traddr for %s\n", fabrics_cfg->traddr);
 		ret = -errno;
 		goto free_addrinfo;
 	}
-	cfg->traddr = strdup(addrstr);
+	fabrics_cfg->traddr = strdup(addrstr);
 
 free_addrinfo:
 	freeaddrinfo(host_info);
@@ -1121,78 +1096,78 @@ retry:
 		return -EINVAL;
 	p += len;
 
-	if (cfg.hostnqn && strcmp(cfg.hostnqn, "none")) {
-		len = sprintf(p, ",hostnqn=%s", cfg.hostnqn);
+	if (fabrics_cfg.hostnqn && strcmp(fabrics_cfg.hostnqn, "none")) {
+		len = sprintf(p, ",hostnqn=%s", fabrics_cfg.hostnqn);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.hostid && strcmp(cfg.hostid, "none")) {
-		len = sprintf(p, ",hostid=%s", cfg.hostid);
+	if (fabrics_cfg.hostid && strcmp(fabrics_cfg.hostid, "none")) {
+		len = sprintf(p, ",hostid=%s", fabrics_cfg.hostid);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.queue_size && !discover) {
-		len = sprintf(p, ",queue_size=%d", cfg.queue_size);
+	if (fabrics_cfg.queue_size && !discover) {
+		len = sprintf(p, ",queue_size=%d", fabrics_cfg.queue_size);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.nr_io_queues && !discover) {
-		len = sprintf(p, ",nr_io_queues=%d", cfg.nr_io_queues);
+	if (fabrics_cfg.nr_io_queues && !discover) {
+		len = sprintf(p, ",nr_io_queues=%d", fabrics_cfg.nr_io_queues);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.nr_write_queues) {
-		len = sprintf(p, ",nr_write_queues=%d", cfg.nr_write_queues);
+	if (fabrics_cfg.nr_write_queues) {
+		len = sprintf(p, ",nr_write_queues=%d", fabrics_cfg.nr_write_queues);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.nr_poll_queues) {
-		len = sprintf(p, ",nr_poll_queues=%d", cfg.nr_poll_queues);
+	if (fabrics_cfg.nr_poll_queues) {
+		len = sprintf(p, ",nr_poll_queues=%d", fabrics_cfg.nr_poll_queues);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.host_traddr && strcmp(cfg.host_traddr, "none")) {
-		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
+	if (fabrics_cfg.host_traddr && strcmp(fabrics_cfg.host_traddr, "none")) {
+		len = sprintf(p, ",host_traddr=%s", fabrics_cfg.host_traddr);
 		if (len < 0)
 			return -EINVAL;
 		p+= len;
 	}
 
-	if (cfg.reconnect_delay) {
-		len = sprintf(p, ",reconnect_delay=%d", cfg.reconnect_delay);
+	if (fabrics_cfg.reconnect_delay) {
+		len = sprintf(p, ",reconnect_delay=%d", fabrics_cfg.reconnect_delay);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if ((e->trtype != NVMF_TRTYPE_LOOP) && (cfg.ctrl_loss_tmo >= -1)) {
-		len = sprintf(p, ",ctrl_loss_tmo=%d", cfg.ctrl_loss_tmo);
+	if ((e->trtype != NVMF_TRTYPE_LOOP) && (fabrics_cfg.ctrl_loss_tmo >= -1)) {
+		len = sprintf(p, ",ctrl_loss_tmo=%d", fabrics_cfg.ctrl_loss_tmo);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.tos != -1) {
-		len = sprintf(p, ",tos=%d", cfg.tos);
+	if (fabrics_cfg.tos != -1) {
+		len = sprintf(p, ",tos=%d", fabrics_cfg.tos);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.keep_alive_tmo) {
-		len = sprintf(p, ",keep_alive_tmo=%d", cfg.keep_alive_tmo);
+	if (fabrics_cfg.keep_alive_tmo) {
+		len = sprintf(p, ",keep_alive_tmo=%d", fabrics_cfg.keep_alive_tmo);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
@@ -1210,14 +1185,14 @@ retry:
 		return -EINVAL;
 	p += len;
 
-	if (cfg.hdr_digest) {
+	if (fabrics_cfg.hdr_digest) {
 		len = sprintf(p, ",hdr_digest");
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.data_digest) {
+	if (fabrics_cfg.data_digest) {
 		len = sprintf(p, ",data_digest");
 		if (len < 0)
 			return -EINVAL;
@@ -1277,7 +1252,7 @@ retry:
 	if (discover) {
 		enum nvme_print_flags flags;
 
-		flags = validate_output_format(cfg.output_format);
+		flags = validate_output_format(fabrics_cfg.output_format);
 		if (flags < 0)
 			flags = NORMAL;
 		ret = do_discover(argstr, true, flags);
@@ -1300,7 +1275,7 @@ static bool cargs_match_found(struct nvmf_disc_rsp_page_entry *entry)
 	cargs.transport = strdup(trtype_str(entry->trtype));
 	cargs.subsysnqn = strdup(entry->subnqn);
 	cargs.trsvcid = strdup(entry->trsvcid);
-	cargs.host_traddr = strdup(cfg.host_traddr ?: "\0");
+	cargs.host_traddr = strdup(fabrics_cfg.host_traddr ?: "\0");
 
 	/* check if we have a match in the discovery recursion */
 	while (c) {
@@ -1324,11 +1299,11 @@ static bool should_connect(struct nvmf_disc_rsp_page_entry *entry)
 	if (cargs_match_found(entry))
 		return false;
 
-	if (!cfg.matching_only || !cfg.traddr)
+	if (!fabrics_cfg.matching_only || !fabrics_cfg.traddr)
 		return true;
 
 	len = space_strip_len(NVMF_TRADDR_SIZE, entry->traddr);
-	return !strncmp(cfg.traddr, entry->traddr, len);
+	return !strncmp(fabrics_cfg.traddr, entry->traddr, len);
 }
 
 static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
@@ -1375,13 +1350,13 @@ static void nvmf_get_host_identifiers(int ctrl_instance)
 
 	if (asprintf(&path, "%s/nvme%d", SYS_NVME, ctrl_instance) < 0)
 		return;
-	cfg.hostnqn = nvme_get_ctrl_attr(path, "hostnqn");
-	cfg.hostid = nvme_get_ctrl_attr(path, "hostid");
+	fabrics_cfg.hostnqn = nvme_get_ctrl_attr(path, "hostnqn");
+	fabrics_cfg.hostid = nvme_get_ctrl_attr(path, "hostid");
 }
 
 static DEFINE_CLEANUP_FUNC(cleanup_log, struct nvmf_disc_rsp_page_hdr *, free);
 
-static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
+int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 {
 	struct nvmf_disc_rsp_page_hdr *log __cleanup__(cleanup_log) = NULL;
 	char *dev_name;
@@ -1393,18 +1368,19 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	if (!cargs)
 		return -ENOMEM;
 
-	if (cfg.device && !ctrl_matches_connectargs(cfg.device, cargs, true)) {
-		free(cfg.device);
-		cfg.device = NULL;
+	if (fabrics_cfg.device &&
+	    !ctrl_matches_connectargs(fabrics_cfg.device, cargs, true)) {
+		free(fabrics_cfg.device);
+		fabrics_cfg.device = NULL;
 	}
-	if (!cfg.device)
-		cfg.device = find_ctrl_with_connectargs(cargs);
+	if (!fabrics_cfg.device)
+		fabrics_cfg.device = find_ctrl_with_connectargs(cargs);
 	free_connect_args(cargs);
 
-	if (!cfg.device) {
+	if (!fabrics_cfg.device) {
 		instance = add_ctrl(argstr);
 	} else {
-		instance = ctrl_instance(cfg.device);
+		instance = ctrl_instance(fabrics_cfg.device);
 		nvmf_get_host_identifiers(instance);
 	}
 	if (instance < 0)
@@ -1414,9 +1390,9 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 		return -errno;
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
 	free(dev_name);
-	if (cfg.persistent)
+	if (fabrics_cfg.persistent)
 		msg(LOG_NOTICE, "Persistent device: nvme%d\n", instance);
-	if (!cfg.device && !cfg.persistent) {
+	if (!fabrics_cfg.device && !fabrics_cfg.persistent) {
 		err = remove_ctrl(instance);
 		if (err)
 			return err;
@@ -1426,7 +1402,7 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	case DISC_OK:
 		if (connect)
 			ret = connect_ctrls(log, numrec);
-		else if (cfg.raw || flags == BINARY)
+		else if (fabrics_cfg.raw || flags == BINARY)
 			save_discovery_log(log, numrec);
 		else if (flags == JSON)
 			json_discovery_log(log, numrec);
@@ -1508,22 +1484,22 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			goto free_and_continue;
 
-		if (!cfg.transport || !cfg.traddr)
+		if (!fabrics_cfg.transport || !fabrics_cfg.traddr)
 			goto free_and_continue;
 
-		err = flags = validate_output_format(cfg.output_format);
+		err = flags = validate_output_format(fabrics_cfg.output_format);
 		if (err < 0)
 			goto free_and_continue;
-		set_discovery_kato(&cfg);
+		set_discovery_kato(&fabrics_cfg);
 
-		if (traddr_is_hostname(&cfg)) {
-			ret = hostname2traddr(&cfg);
+		if (traddr_is_hostname(&fabrics_cfg)) {
+			ret = hostname2traddr(&fabrics_cfg);
 			if (ret)
 				goto out;
 		}
 
-		if (!cfg.trsvcid)
-			discovery_trsvcid(&cfg);
+		if (!fabrics_cfg.trsvcid)
+			discovery_trsvcid(&fabrics_cfg);
 
 		err = build_options(argstr, BUF_SIZE, true);
 		if (err) {
@@ -1538,8 +1514,8 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 free_and_continue:
 		free(all_args);
 		free(argv);
-		cfg.transport = cfg.traddr = cfg.trsvcid =
-			cfg.host_traddr = NULL;
+		fabrics_cfg.transport = fabrics_cfg.traddr =
+			fabrics_cfg.trsvcid = fabrics_cfg.host_traddr = NULL;
 	}
 
 out:
@@ -1555,42 +1531,42 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	bool quiet = false;
 
 	OPT_ARGS(opts) = {
-		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
-		OPT_LIST("traddr",         'a', &cfg.traddr,          "transport address"),
-		OPT_LIST("trsvcid",        's', &cfg.trsvcid,         "transport service id (e.g. IP port)"),
-		OPT_LIST("host-traddr",    'w', &cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
-		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
-		OPT_LIST("hostid",         'I', &cfg.hostid,          "user-defined hostid (if default not used)"),
-		OPT_LIST("raw",            'r', &cfg.raw,             "raw output file"),
-		OPT_LIST("device",         'd', &cfg.device,          "use existing discovery controller device"),
-		OPT_INT("keep-alive-tmo",  'k', &cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
-		OPT_INT("reconnect-delay", 'c', &cfg.reconnect_delay, "reconnect timeout period in seconds"),
-		OPT_INT("ctrl-loss-tmo",   'l', &cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
-		OPT_INT("tos",             'T', &cfg.tos,             "type of service"),
-		OPT_FLAG("hdr_digest",     'g', &cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
-		OPT_FLAG("data_digest",    'G', &cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
-		OPT_INT("nr-io-queues",    'i', &cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
-		OPT_INT("nr-write-queues", 'W', &cfg.nr_write_queues, "number of write queues to use (default 0)"),
-		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
-		OPT_INT("queue-size",      'Q', &cfg.queue_size,      "number of io queue elements to use (default 128)"),
-		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connection"),
+		OPT_LIST("transport",      't', &fabrics_cfg.transport,       "transport type"),
+		OPT_LIST("traddr",         'a', &fabrics_cfg.traddr,          "transport address"),
+		OPT_LIST("trsvcid",        's', &fabrics_cfg.trsvcid,         "transport service id (e.g. IP port)"),
+		OPT_LIST("host-traddr",    'w', &fabrics_cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
+		OPT_LIST("hostnqn",        'q', &fabrics_cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
+		OPT_LIST("hostid",         'I', &fabrics_cfg.hostid,          "user-defined hostid (if default not used)"),
+		OPT_LIST("raw",            'r', &fabrics_cfg.raw,             "raw output file"),
+		OPT_LIST("device",         'd', &fabrics_cfg.device,          "existing discovery controller device"),
+		OPT_INT("keep-alive-tmo",  'k', &fabrics_cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
+		OPT_INT("reconnect-delay", 'c', &fabrics_cfg.reconnect_delay, "reconnect timeout period in seconds"),
+		OPT_INT("ctrl-loss-tmo",   'l', &fabrics_cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
+		OPT_INT("tos",             'T', &fabrics_cfg.tos,             "type of service"),
+		OPT_FLAG("hdr_digest",     'g', &fabrics_cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
+		OPT_FLAG("data_digest",    'G', &fabrics_cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+		OPT_INT("nr-io-queues",    'i', &fabrics_cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
+		OPT_INT("nr-write-queues", 'W', &fabrics_cfg.nr_write_queues, "number of write queues to use (default 0)"),
+		OPT_INT("nr-poll-queues",  'P', &fabrics_cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
+		OPT_INT("queue-size",      'Q', &fabrics_cfg.queue_size,      "number of io queue elements to use (default 128)"),
+		OPT_FLAG("persistent",     'p', &fabrics_cfg.persistent,      "persistent discovery connection"),
 		OPT_FLAG("quiet",          'S', &quiet,               "suppress already connected errors"),
-		OPT_FLAG("matching",       'm', &cfg.matching_only,   "connect only records matching the traddr"),
-		OPT_FMT("output-format",   'o', &cfg.output_format,   output_format),
+		OPT_FLAG("matching",       'm', &fabrics_cfg.matching_only,   "connect only records matching the traddr"),
+		OPT_FMT("output-format",   'o', &fabrics_cfg.output_format,   output_format),
 		OPT_END()
 	};
 
-	cfg.tos = -1;
+	fabrics_cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, opts);
 	if (ret)
 		goto out;
 
-	ret = flags = validate_output_format(cfg.output_format);
+	ret = flags = validate_output_format(fabrics_cfg.output_format);
 	if (ret < 0)
 		goto out;
-	if (cfg.device && strcmp(cfg.device, "none")) {
-		cfg.device = strdup(cfg.device);
-		if (!cfg.device) {
+	if (fabrics_cfg.device && strcmp(fabrics_cfg.device, "none")) {
+		fabrics_cfg.device = strdup(fabrics_cfg.device);
+		if (!fabrics_cfg.device) {
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -1599,24 +1575,24 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	if (quiet)
 		log_level = LOG_WARNING;
 
-	if (cfg.device && !strcmp(cfg.device, "none"))
-		cfg.device = NULL;
+	if (fabrics_cfg.device && !strcmp(fabrics_cfg.device, "none"))
+		fabrics_cfg.device = NULL;
 
-	cfg.nqn = NVME_DISC_SUBSYS_NAME;
+	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
-	if (!cfg.transport && !cfg.traddr) {
+	if (!fabrics_cfg.transport && !fabrics_cfg.traddr) {
 		ret = discover_from_conf_file(desc, argstr, opts, connect);
 	} else {
-		set_discovery_kato(&cfg);
+		set_discovery_kato(&fabrics_cfg);
 
-		if (traddr_is_hostname(&cfg)) {
-			ret = hostname2traddr(&cfg);
+		if (traddr_is_hostname(&fabrics_cfg)) {
+			ret = hostname2traddr(&fabrics_cfg);
 			if (ret)
 				goto out;
 		}
 
-		if (!cfg.trsvcid)
-			discovery_trsvcid(&cfg);
+		if (!fabrics_cfg.trsvcid)
+			discovery_trsvcid(&fabrics_cfg);
 
 		ret = build_options(argstr, BUF_SIZE, true);
 		if (ret)
@@ -1635,35 +1611,35 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 	int instance, ret;
 
 	OPT_ARGS(opts) = {
-		OPT_LIST("transport",         't', &cfg.transport,         "transport type"),
-		OPT_LIST("nqn",               'n', &cfg.nqn,               "nqn name"),
-		OPT_LIST("traddr",            'a', &cfg.traddr,            "transport address"),
-		OPT_LIST("trsvcid",           's', &cfg.trsvcid,           "transport service id (e.g. IP port)"),
-		OPT_LIST("host-traddr",       'w', &cfg.host_traddr,       "host traddr (e.g. FC WWN's)"),
-		OPT_LIST("hostnqn",           'q', &cfg.hostnqn,           "user-defined hostnqn"),
-		OPT_LIST("hostid",            'I', &cfg.hostid,            "user-defined hostid (if default not used)"),
-		OPT_INT("nr-io-queues",       'i', &cfg.nr_io_queues,      "number of io queues to use (default is core count)"),
-		OPT_INT("nr-write-queues",    'W', &cfg.nr_write_queues,   "number of write queues to use (default 0)"),
-		OPT_INT("nr-poll-queues",     'P', &cfg.nr_poll_queues,    "number of poll queues to use (default 0)"),
-		OPT_INT("queue-size",         'Q', &cfg.queue_size,        "number of io queue elements to use (default 128)"),
-		OPT_INT("keep-alive-tmo",     'k', &cfg.keep_alive_tmo,    "keep alive timeout period in seconds"),
-		OPT_INT("reconnect-delay",    'c', &cfg.reconnect_delay,   "reconnect timeout period in seconds"),
-		OPT_INT("ctrl-loss-tmo",      'l', &cfg.ctrl_loss_tmo,     "controller loss timeout period in seconds"),
-		OPT_INT("tos",                'T', &cfg.tos,               "type of service"),
-		OPT_FLAG("duplicate-connect", 'D', &cfg.duplicate_connect, "allow duplicate connections between same transport host and subsystem port"),
-		OPT_FLAG("disable-sqflow",    'd', &cfg.disable_sqflow,    "disable controller sq flow control (default false)"),
-		OPT_FLAG("hdr-digest",        'g', &cfg.hdr_digest,        "enable transport protocol header digest (TCP transport)"),
-		OPT_FLAG("data-digest",       'G', &cfg.data_digest,       "enable transport protocol data digest (TCP transport)"),
+		OPT_LIST("transport",         't', &fabrics_cfg.transport,         "transport type"),
+		OPT_LIST("nqn",               'n', &fabrics_cfg.nqn,               "nqn name"),
+		OPT_LIST("traddr",            'a', &fabrics_cfg.traddr,            "transport address"),
+		OPT_LIST("trsvcid",           's', &fabrics_cfg.trsvcid,           "transport service id (e.g. IP port)"),
+		OPT_LIST("host-traddr",       'w', &fabrics_cfg.host_traddr,       "host traddr (e.g. FC WWN's)"),
+		OPT_LIST("hostnqn",           'q', &fabrics_cfg.hostnqn,           "user-defined hostnqn"),
+		OPT_LIST("hostid",            'I', &fabrics_cfg.hostid,            "user-defined hostid (if default not used)"),
+		OPT_INT("nr-io-queues",       'i', &fabrics_cfg.nr_io_queues,      "number of io queues to use (default is core count)"),
+		OPT_INT("nr-write-queues",    'W', &fabrics_cfg.nr_write_queues,   "number of write queues to use (default 0)"),
+		OPT_INT("nr-poll-queues",     'P', &fabrics_cfg.nr_poll_queues,    "number of poll queues to use (default 0)"),
+		OPT_INT("queue-size",         'Q', &fabrics_cfg.queue_size,        "number of io queue elements to use (default 128)"),
+		OPT_INT("keep-alive-tmo",     'k', &fabrics_cfg.keep_alive_tmo,    "keep alive timeout period in seconds"),
+		OPT_INT("reconnect-delay",    'c', &fabrics_cfg.reconnect_delay,   "reconnect timeout period in seconds"),
+		OPT_INT("ctrl-loss-tmo",      'l', &fabrics_cfg.ctrl_loss_tmo,     "controller loss timeout period in seconds"),
+		OPT_INT("tos",                'T', &fabrics_cfg.tos,               "type of service"),
+		OPT_FLAG("duplicate-connect", 'D', &fabrics_cfg.duplicate_connect, "allow duplicate connections between same transport host and subsystem port"),
+		OPT_FLAG("disable-sqflow",    'd', &fabrics_cfg.disable_sqflow,    "disable controller sq flow control (default false)"),
+		OPT_FLAG("hdr-digest",        'g', &fabrics_cfg.hdr_digest,        "enable transport protocol header digest (TCP transport)"),
+		OPT_FLAG("data-digest",       'G', &fabrics_cfg.data_digest,       "enable transport protocol data digest (TCP transport)"),
 		OPT_END()
 	};
 
-	cfg.tos = -1;
+	fabrics_cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, opts);
 	if (ret)
 		goto out;
 
-	if (traddr_is_hostname(&cfg)) {
-		ret = hostname2traddr(&cfg);
+	if (traddr_is_hostname(&fabrics_cfg)) {
+		ret = hostname2traddr(&fabrics_cfg);
 		if (ret)
 			goto out;
 	}
@@ -1672,7 +1648,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 	if (ret)
 		goto out;
 
-	if (!cfg.nqn) {
+	if (!fabrics_cfg.nqn) {
 		msg(LOG_ERR, "need a -n argument\n");
 		ret = -EINVAL;
 		goto out;
@@ -1775,8 +1751,8 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	int ret;
 
 	OPT_ARGS(opts) = {
-		OPT_LIST("nqn",    'n', &cfg.nqn,    nqn),
-		OPT_LIST("device", 'd', &cfg.device, device),
+		OPT_LIST("nqn",    'n', &fabrics_cfg.nqn,    nqn),
+		OPT_LIST("device", 'd', &fabrics_cfg.device, device),
 		OPT_END()
 	};
 
@@ -1784,29 +1760,29 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	if (ret)
 		goto out;
 
-	if (!cfg.nqn && !cfg.device) {
+	if (!fabrics_cfg.nqn && !fabrics_cfg.device) {
 		msg(LOG_ERR, "need a -n or -d argument\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (cfg.nqn) {
-		ret = disconnect_by_nqn(cfg.nqn);
+	if (fabrics_cfg.nqn) {
+		ret = disconnect_by_nqn(fabrics_cfg.nqn);
 		if (ret < 0)
 			msg(LOG_ERR, "Failed to disconnect by NQN: %s\n",
-				cfg.nqn);
+				fabrics_cfg.nqn);
 		else {
-			printf("NQN:%s disconnected %d controller(s)\n", cfg.nqn, ret);
+			printf("NQN:%s disconnected %d controller(s)\n", fabrics_cfg.nqn, ret);
 			ret = 0;
 		}
 	}
 
-	if (cfg.device) {
-		ret = disconnect_by_device(cfg.device);
+	if (fabrics_cfg.device) {
+		ret = disconnect_by_device(fabrics_cfg.device);
 		if (ret)
 			msg(LOG_ERR,
 				"Failed to disconnect by device name: %s\n",
-				cfg.device);
+				fabrics_cfg.device);
 	}
 
 out:
diff --git a/fabrics.h b/fabrics.h
index f5b8eaf..41e6a2d 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -10,4 +10,46 @@ extern int fabrics_connect(const char *desc, int argc, char **argv);
 extern int fabrics_disconnect(const char *desc, int argc, char **argv);
 extern int fabrics_disconnect_all(const char *desc, int argc, char **argv);
 
+/* Symbols used by monitor.c */
+
+const char *arg_str(const char * const *strings, size_t array_size, size_t idx);
+
+struct fabrics_config {
+	const char *nqn;
+	const char *transport;
+	const char *traddr;
+	const char *trsvcid;
+	const char *host_traddr;
+	const char *hostnqn;
+	const char *hostid;
+	int  nr_io_queues;
+	int  nr_write_queues;
+	int  nr_poll_queues;
+	int  queue_size;
+	int  keep_alive_tmo;
+	int  reconnect_delay;
+	int  ctrl_loss_tmo;
+	int  tos;
+	const char *raw;
+	char *device;
+	int  duplicate_connect;
+	int  disable_sqflow;
+	int  hdr_digest;
+	int  data_digest;
+	bool persistent;
+	bool matching_only;
+	const char *output_format;
+};
+extern struct fabrics_config fabrics_cfg;
+
+extern const char *const trtypes[];
+
+#define BUF_SIZE 4096
+
+int build_options(char *argstr, int max_len, bool discover);
+int do_discover(char *argstr, bool connect, enum nvme_print_flags flags);
+int ctrl_instance(const char *device);
+char *parse_conn_arg(const char *conargs, const char delim, const char *field);
+int remove_ctrl(int instance);
+
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
