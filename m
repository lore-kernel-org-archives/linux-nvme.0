Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA32C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:38:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D38E65016
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38E65016
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S5R1fj4qjwEu5R1Y44evuSgBRwR0VEs07QXQuOhA1C8=; b=B+XAg51yG8x6B92Vfd/R0FmId
	Zyo5WbfgJamTl5aNIn8lFyDGW0IDHyCt2kVUcGKtI3KKrrt1BB2EP1cBDI1zjHRhQXCtezpRIfbXg
	ixSeYHMFk35jLurvK6yr06eTHmZHUFE6YII7gSR/U2pA1U8up2HE9Zz5gGQnPyNuE1SHLs2D54Mq1
	0IKpNDhiPMPvt+nHGGuFbKKdZliViMUFSs/KwfARrHjm3I0wYoRraKSS4VnALgHvHlRUHCQCQkyfv
	7uORmq9CBwSsGfEsO4I3Y2eFgq0wYKEqRKgqB4P1a70pqqRFMtFO0aUWfVNpjcLOAsZ1j/hRdC8y4
	MgX82JRtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKxO-00HW3r-D3; Sat, 06 Mar 2021 00:38:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKw2-00HVUN-8b
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVBMlMgBl7TAKgC+QKtLMe5NiPqle+3Bcf1MXaqtebU=;
 b=GVPqh3JdNgA+O9TsC+s/SlCjZl+UNRLRplry7OWBPJORDdlUlYZYionR+LqzPT3fxliHuI
 dGK/F/JNEvPX+xmhqcLhmzWShAUOdTewe5mRUcBIbLj70Z9g2NMWKR9p/AC98D7k3d+6dV
 H4+WBkPpSL/INXcheqgJ2Jmqyq2ODvE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CD768AF0D;
 Sat,  6 Mar 2021 00:36:40 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 06/10] nvme-cli: add generic logging functionality
Date: Sat,  6 Mar 2021 01:36:20 +0100
Message-Id: <20210306003624.21102-7-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003646_821474_E8A67567 
X-CRM114-Status: GOOD (  27.33  )
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

Add a msg() macro that allows more flexible customization of logging
both at build time and at run time. Allow several log levels, using
the well-known standard sylog levels. Also optionally allow printing
of log timestamps.

Put '#define LOG_FUNCNAME' before '#include "util/log.h"' to enable printing
the name of the calling function before the log message.

Use this functionality in the fabrics code for now, wherever fprintf(stderr, ...)
had been used.

No functional change except changing the output channel of 554db7d ("print
device name when creating a persistent device") from stdout to stderr.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Makefile   |  2 +-
 fabrics.c  | 85 ++++++++++++++++++++++++++++-----------------------
 util/log.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 util/log.h | 34 +++++++++++++++++++++
 4 files changed, 171 insertions(+), 40 deletions(-)
 create mode 100644 util/log.c
 create mode 100644 util/log.h

diff --git a/Makefile b/Makefile
index 3412e5d..1fe693c 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ OBJS := nvme-print.o nvme-ioctl.o nvme-rpmb.o \
 	nvme-lightnvm.o fabrics.o nvme-models.o plugin.o \
 	nvme-status.o nvme-filters.o nvme-topology.o
 
-UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o
+UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o util/log.o
 
 PLUGIN_OBJS :=					\
 	plugins/intel/intel-nvme.o		\
diff --git a/fabrics.c b/fabrics.c
index 223bd04..04f0aef 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -32,6 +32,8 @@
 #include <libgen.h>
 #include <sys/stat.h>
 #include <stddef.h>
+#include <syslog.h>
+#include <time.h>
 
 #include <sys/types.h>
 #include <arpa/inet.h>
@@ -46,6 +48,7 @@
 #include "util/argconfig.h"
 
 #include "common.h"
+#include "util/log.h"
 
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -86,7 +89,6 @@ static struct config {
 	int  hdr_digest;
 	int  data_digest;
 	bool persistent;
-	bool quiet;
 	bool matching_only;
 	char *output_format;
 } cfg = {
@@ -381,7 +383,7 @@ static char *find_ctrl_with_connectargs(struct connect_args *args)
 
 	n = scandir(SYS_NVME, &devices, scan_ctrls_filter, alphasort);
 	if (n < 0) {
-		fprintf(stderr, "no NVMe controller(s) detected.\n");
+		msg(LOG_ERR, "no NVMe controller(s) detected.\n");
 		return NULL;
 	}
 
@@ -389,7 +391,7 @@ static char *find_ctrl_with_connectargs(struct connect_args *args)
 		if (ctrl_matches_connectargs(devices[i]->d_name, args, false)) {
 			devname = strdup(devices[i]->d_name);
 			if (devname == NULL)
-				fprintf(stderr, "no memory for ctrl name %s\n",
+				msg(LOG_ERR, "no memory for ctrl name %s\n",
 						devices[i]->d_name);
 			goto cleanup_devices;
 		}
@@ -451,7 +453,7 @@ static int add_ctrl(const char *argstr)
 
 	fd = open(PATH_NVME_FABRICS, O_RDWR);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open %s: %s\n",
+		msg(LOG_ERR, "Failed to open %s: %s\n",
 			 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out;
@@ -459,8 +461,8 @@ static int add_ctrl(const char *argstr)
 
 	ret = write(fd, argstr, len);
 	if (ret != len) {
-		if (errno != EALREADY || !cfg.quiet)
-			fprintf(stderr, "Failed to write to %s: %s\n",
+		if (errno != EALREADY)
+			msg(LOG_NOTICE, "Failed to write to %s: %s\n",
 				 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out_close;
@@ -468,7 +470,7 @@ static int add_ctrl(const char *argstr)
 
 	len = read(fd, buf, BUF_SIZE);
 	if (len < 0) {
-		fprintf(stderr, "Failed to read from %s: %s\n",
+		msg(LOG_ERR, "Failed to read from %s: %s\n",
 			 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out_close;
@@ -495,7 +497,7 @@ static int add_ctrl(const char *argstr)
 	}
 
 out_fail:
-	fprintf(stderr, "Failed to parse ctrl info for \"%s\"\n", argstr);
+	msg(LOG_ERR, "Failed to parse ctrl info for \"%s\"\n", argstr);
 	ret = -EINVAL;
 out_close:
 	close(fd);
@@ -510,7 +512,7 @@ static int remove_ctrl_by_path(char *sysfs_path)
 	fd = open(sysfs_path, O_WRONLY);
 	if (fd < 0) {
 		ret = -errno;
-		fprintf(stderr, "Failed to open %s: %s\n", sysfs_path,
+		msg(LOG_ERR, "Failed to open %s: %s\n", sysfs_path,
 				strerror(errno));
 		goto out;
 	}
@@ -564,7 +566,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	fd = open(dev_path, O_RDWR);
 	if (fd < 0) {
 		error = -errno;
-		fprintf(stderr, "Failed to open %s: %s\n",
+		msg(LOG_ERR, "Failed to open %s: %s\n",
 				dev_path, strerror(errno));
 		goto out;
 	}
@@ -789,7 +791,7 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 	fd = open(cfg.raw, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (fd < 0) {
-		fprintf(stderr, "failed to open %s: %s\n",
+		msg(LOG_ERR, "failed to open %s: %s\n",
 			cfg.raw, strerror(errno));
 		return;
 	}
@@ -798,7 +800,7 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 			numrec * sizeof(struct nvmf_disc_rsp_page_entry);
 	ret = write(fd, log, len);
 	if (ret < 0)
-		fprintf(stderr, "failed to write to %s: %s\n",
+		msg(LOG_ERR, "failed to write to %s: %s\n",
 			cfg.raw, strerror(errno));
 	else
 		printf("Discovery log is saved to %s\n", cfg.raw);
@@ -945,13 +947,13 @@ static int build_options(char *argstr, int max_len, bool discover)
 	int len;
 
 	if (!cfg.transport) {
-		fprintf(stderr, "need a transport (-t) argument\n");
+		msg(LOG_ERR, "need a transport (-t) argument\n");
 		return -EINVAL;
 	}
 
 	if (strncmp(cfg.transport, "loop", 4)) {
 		if (!cfg.traddr) {
-			fprintf(stderr, "need a address (-a) argument\n");
+			msg(LOG_ERR, "need a address (-a) argument\n");
 			return -EINVAL;
 		}
 	}
@@ -1045,7 +1047,7 @@ static int hostname2traddr(struct config *cfg)
 
 	ret = getaddrinfo(cfg->traddr, NULL, &hints, &host_info);
 	if (ret) {
-		fprintf(stderr, "failed to resolve host %s info\n", cfg->traddr);
+		msg(LOG_ERR, "failed to resolve host %s info\n", cfg->traddr);
 		return ret;
 	}
 
@@ -1061,14 +1063,14 @@ static int hostname2traddr(struct config *cfg)
 			addrstr, NVMF_TRADDR_SIZE);
 		break;
 	default:
-		fprintf(stderr, "unrecognized address family (%d) %s\n",
+		msg(LOG_ERR, "unrecognized address family (%d) %s\n",
 			host_info->ai_family, cfg->traddr);
 		ret = -EINVAL;
 		goto free_addrinfo;
 	}
 
 	if (!p) {
-		fprintf(stderr, "failed to get traddr for %s\n", cfg->traddr);
+		msg(LOG_ERR, "failed to get traddr for %s\n", cfg->traddr);
 		ret = -errno;
 		goto free_addrinfo;
 	}
@@ -1096,7 +1098,7 @@ retry:
 	case NVME_NQN_NVME:
 		break;
 	default:
-		fprintf(stderr, "skipping unsupported subtype %d\n",
+		msg(LOG_ERR, "skipping unsupported subtype %d\n",
 			 e->subtype);
 		return -EINVAL;
 	}
@@ -1185,7 +1187,7 @@ retry:
 
 	transport = trtype_str(e->trtype);
 	if (!strcmp(transport, "unrecognized")) {
-		fprintf(stderr, "skipping unsupported transport %d\n",
+		msg(LOG_ERR, "skipping unsupported transport %d\n",
 				 e->trtype);
 		return -EINVAL;
 	}
@@ -1231,7 +1233,7 @@ retry:
 			p += len;
 			break;
 		default:
-			fprintf(stderr, "skipping unsupported adrfam\n");
+			msg(LOG_ERR, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
 		break;
@@ -1246,7 +1248,7 @@ retry:
 			p += len;
 			break;
 		default:
-			fprintf(stderr, "skipping unsupported adrfam\n");
+			msg(LOG_ERR, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
 		break;
@@ -1336,9 +1338,7 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		if (instance == -EALREADY) {
 			const char *traddr = log->entries[i].traddr;
 
-			if (!cfg.quiet)
-				fprintf(stderr,
-					"traddr=%.*s is already connected\n",
+			msg(LOG_NOTICE, "traddr=%.*s is already connected\n",
 					space_strip_len(NVMF_TRADDR_SIZE,
 							traddr),
 					traddr);
@@ -1400,7 +1400,7 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
 	free(dev_name);
 	if (cfg.persistent)
-		printf("Persistent device: nvme%d\n", instance);
+		msg(LOG_NOTICE, "Persistent device: nvme%d\n", instance);
 	if (!cfg.device && !cfg.persistent) {
 		err = remove_ctrl(instance);
 		if (err)
@@ -1419,12 +1419,12 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 			print_discovery_log(log, numrec);
 		break;
 	case DISC_GET_NUMRECS:
-		fprintf(stderr,
+		msg(LOG_ERR,
 			"Get number of discovery log entries failed.\n");
 		ret = status;
 		break;
 	case DISC_GET_LOG:
-		fprintf(stderr, "Get discovery log entries failed.\n");
+		msg(LOG_ERR, "Get discovery log entries failed.\n");
 		ret = status;
 		break;
 	case DISC_NO_LOG:
@@ -1436,12 +1436,12 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 		ret = -EAGAIN;
 		break;
 	case DISC_NOT_EQUAL:
-		fprintf(stderr,
+		msg(LOG_ERR,
 		"Numrec values of last two get discovery log page not equal\n");
 		ret = -EBADSLT;
 		break;
 	default:
-		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
+		msg(LOG_ERR, "Get discovery log page failed: %d\n", ret);
 		break;
 	}
 
@@ -1457,7 +1457,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 
 	f = fopen(PATH_NVMF_DISC, "r");
 	if (f == NULL) {
-		fprintf(stderr, "No discover params given and no %s\n",
+		msg(LOG_ERR, "No discover params given and no %s\n",
 			PATH_NVMF_DISC);
 		return -EINVAL;
 	}
@@ -1470,14 +1470,14 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 
 		args = strdup(line);
 		if (!args) {
-			fprintf(stderr, "failed to strdup args\n");
+			msg(LOG_ERR, "failed to strdup args\n");
 			ret = -ENOMEM;
 			goto out;
 		}
 
 		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
 		if (!argv) {
-			perror("failed to allocate argv vector\n");
+			msg(LOG_ERR, "failed to allocate argv vector: %m\n");
 			free(args);
 			ret = -ENOMEM;
 			goto out;
@@ -1531,6 +1531,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	char argstr[BUF_SIZE];
 	int ret;
 	enum nvme_print_flags flags;
+	bool quiet = false;
 
 	OPT_ARGS(opts) = {
 		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
@@ -1552,7 +1553,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
 		OPT_INT("queue-size",      'Q', &cfg.queue_size,      "number of io queue elements to use (default 128)"),
 		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connection"),
-		OPT_FLAG("quiet",          'S', &cfg.quiet,           "suppress already connected errors"),
+		OPT_FLAG("quiet",          'S', &quiet,               "suppress already connected errors"),
 		OPT_FLAG("matching",       'm', &cfg.matching_only,   "connect only records matching the traddr"),
 		OPT_FMT("output-format",   'o', &cfg.output_format,   output_format),
 		OPT_END()
@@ -1574,6 +1575,12 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		}
 	}
 
+	if (quiet)
+		log_level = LOG_WARNING;
+
+	if (cfg.device && !strcmp(cfg.device, "none"))
+		cfg.device = NULL;
+
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!cfg.transport && !cfg.traddr) {
@@ -1645,7 +1652,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		goto out;
 
 	if (!cfg.nqn) {
-		fprintf(stderr, "need a -n argument\n");
+		msg(LOG_ERR, "need a -n argument\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1683,7 +1690,7 @@ static int disconnect_subsys(char *nqn, char *ctrl)
 
 	fd = open(sysfs_nqn_path, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open %s: %s\n",
+		msg(LOG_ERR, "Failed to open %s: %s\n",
 				sysfs_nqn_path, strerror(errno));
 		goto free;
 	}
@@ -1757,7 +1764,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 		goto out;
 
 	if (!cfg.nqn && !cfg.device) {
-		fprintf(stderr, "need a -n or -d argument\n");
+		msg(LOG_ERR, "need a -n or -d argument\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1765,7 +1772,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	if (cfg.nqn) {
 		ret = disconnect_by_nqn(cfg.nqn);
 		if (ret < 0)
-			fprintf(stderr, "Failed to disconnect by NQN: %s\n",
+			msg(LOG_ERR, "Failed to disconnect by NQN: %s\n",
 				cfg.nqn);
 		else {
 			printf("NQN:%s disconnected %d controller(s)\n", cfg.nqn, ret);
@@ -1776,7 +1783,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	if (cfg.device) {
 		ret = disconnect_by_device(cfg.device);
 		if (ret)
-			fprintf(stderr,
+			msg(LOG_ERR,
 				"Failed to disconnect by device name: %s\n",
 				cfg.device);
 	}
@@ -1800,7 +1807,7 @@ int fabrics_disconnect_all(const char *desc, int argc, char **argv)
 
 	err = scan_subsystems(&t, NULL, 0, NULL);
 	if (err) {
-		fprintf(stderr, "Failed to scan namespaces\n");
+		msg(LOG_ERR, "Failed to scan namespaces\n");
 		goto out;
 	}
 
diff --git a/util/log.c b/util/log.c
new file mode 100644
index 0000000..4a22354
--- /dev/null
+++ b/util/log.c
@@ -0,0 +1,90 @@
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
+ * This file implements basic logging functionality.
+ */
+
+#include <sys/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <time.h>
+#define LOG_FUNCNAME 1
+#include "log.h"
+#include "cleanup.h"
+
+#ifndef LOG_CLOCK
+#define LOG_CLOCK CLOCK_MONOTONIC
+#endif
+
+int log_level = DEFAULT_LOGLEVEL;
+bool log_timestamp;
+bool log_pid;
+
+void __attribute__((format(printf, 3, 4)))
+__msg(int lvl, const char *func, const char *format, ...)
+{
+	va_list ap;
+	char pidbuf[16];
+	char timebuf[32];
+	static const char *const formats[] = {
+		"%s%s%s",
+		"%s%s%s: ",
+		"%s<%s>%s ",
+		"%s<%s> %s: ",
+		"[%s] %s%s ",
+		"[%s]%s %s: ",
+		"[%s] <%s>%s ",
+		"[%s] <%s> %s: ",
+	};
+	char *header __cleanup__(cleanup_charp) = NULL;
+	char *message __cleanup__(cleanup_charp) = NULL;
+	int idx;
+
+	if (lvl > log_level)
+		return;
+
+	if (log_timestamp) {
+		struct timespec now;
+
+		clock_gettime(LOG_CLOCK, &now);
+		snprintf(timebuf, sizeof(timebuf), "%6ld.%06ld",
+			 (long)now.tv_sec, now.tv_nsec / 1000);
+	} else
+		*timebuf = '\0';
+
+	if (log_pid)
+		snprintf(pidbuf, sizeof(pidbuf), "%ld", (long)getpid());
+	else
+		*pidbuf = '\0';
+
+	idx = ((log_timestamp ? 1 : 0) << 2) |
+		((log_pid ? 1 : 0) << 1) | (func ? 1 : 0);
+
+	if (asprintf(&header, formats[idx], timebuf, pidbuf, func ? func : "")
+	    == -1)
+		header = NULL;
+
+	va_start(ap, format);
+	if (vasprintf(&message, format, ap) == -1)
+		message = NULL;
+	va_end(ap);
+
+	fprintf(stderr, "%s%s", header ? header : "<error>",
+		message ? message : "<error>");
+
+}
diff --git a/util/log.h b/util/log.h
new file mode 100644
index 0000000..15107a5
--- /dev/null
+++ b/util/log.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2021 Martin Wilck, SUSE LLC
+ * SPDX-License-Identifier: LGPL-2.1-or-newer
+ */
+#ifndef _LOG_H
+#define _LOG_H
+
+#ifndef MAX_LOGLEVEL
+#  define MAX_LOGLEVEL LOG_DEBUG
+#endif
+#ifndef DEFAULT_LOGLEVEL
+#  define DEFAULT_LOGLEVEL LOG_NOTICE
+#endif
+
+#if (LOG_FUNCNAME == 1)
+#define _log_func __func__
+#else
+#define _log_func NULL
+#endif
+
+extern int log_level;
+extern bool log_timestamp;
+extern bool log_pid;
+
+void __attribute__((format(printf, 3, 4)))
+__msg(int lvl, const char *func, const char *format, ...);
+
+#define msg(lvl, format, ...)						\
+	do {								\
+		if ((lvl) <= MAX_LOGLEVEL)				\
+			__msg(lvl, _log_func, format, ##__VA_ARGS__);	\
+	} while (0)
+
+#endif /* _LOG_H */
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
