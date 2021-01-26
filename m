Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD36C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3B022A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3B022A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kKjvO5z/VvK6dHeTtwrheh7xjF0XJf9282dy15F/Fq0=; b=WnxKnhiiqiyO6I/R0GHvgohCr
	nQRXuYtXQCzOLHpWhRVRjo4MJ+3ejTSxPHU4AKpXn1UFt90g5OjigKuam2WcWyjr5oxnmq7Gc9wAO
	x8/Rr6+ewXePgx2xe4OU9WhmrWHyvkqj6okfsa4P9Doh7uXUvod86EjJ9A/QqHGQ3Hm9SEDtVg/HS
	OxjBIwqY4EH1PKFUoDI3tzUp8qON3pYMSYw59GdVev9WOR3jn5wtCNg431adr+IBITeMIocGop5Mj
	lCkEgvH/TpWxPL80nk8IJE+mQAAlLY0+RGFOp+DN4md6m8syvdoZk3zFTCBTZ50FeDoladFpnbo/4
	LHX/Y3SDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2p-0001F4-8s; Tue, 26 Jan 2021 20:34:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V24-0000vR-0q
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5H5ryMqbNOJYd72OC9n9gwJM1/6rkubnAMPzYANkTfg=;
 b=EZqIF7KdVDQH8tZ42r48DtH43tV3yeE14Tn/tYH8RlxiWBmtZRoC2P0vOZi0yR/UdEIDm1
 I+Vd4zqOAuOM9fj4D6ktY3S3/+wd01SnFkdsO8e5PwrqH5wTG2XBuIijh5/HW8pTQ6g+rI
 M6qQd88tYoAzytMez1TurPlJp3ZkxLY=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 73FD6AF61;
 Tue, 26 Jan 2021 20:33:44 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 07/35] fabrics: use log() macro
Date: Tue, 26 Jan 2021 21:32:56 +0100
Message-Id: <20210126203324.23610-8-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153348_290326_42574C90 
X-CRM114-Status: GOOD (  20.76  )
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

Fabrics functionality will be used by the monitor code, we
need consistent logging. This patch causes no functional change
for the fabrics module.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 83 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 17711cf..555b6b4 100644
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
@@ -46,6 +48,10 @@
 #include "util/argconfig.h"
 
 #include "common.h"
+#include "log.h"
+
+int log_level = LOG_NOTICE;
+bool log_timestamp;
 
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
@@ -86,7 +92,6 @@ static struct config {
 	int  hdr_digest;
 	int  data_digest;
 	bool persistent;
-	bool quiet;
 	bool matching_only;
 } cfg = { .ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO };
 
@@ -345,7 +350,7 @@ static char *find_ctrl_with_connectargs(struct connect_args *args)
 
 	n = scandir(SYS_NVME, &devices, scan_ctrls_filter, alphasort);
 	if (n < 0) {
-		fprintf(stderr, "no NVMe controller(s) detected.\n");
+		log(LOG_ERR, "no NVMe controller(s) detected.\n");
 		return NULL;
 	}
 
@@ -353,7 +358,7 @@ static char *find_ctrl_with_connectargs(struct connect_args *args)
 		if (ctrl_matches_connectargs(devices[i]->d_name, args)) {
 			devname = strdup(devices[i]->d_name);
 			if (devname == NULL)
-				fprintf(stderr, "no memory for ctrl name %s\n",
+				log(LOG_ERR, "no memory for ctrl name %s\n",
 						devices[i]->d_name);
 			goto cleanup_devices;
 		}
@@ -415,7 +420,7 @@ static int add_ctrl(const char *argstr)
 
 	fd = open(PATH_NVME_FABRICS, O_RDWR);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open %s: %s\n",
+		log(LOG_ERR, "Failed to open %s: %s\n",
 			 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out;
@@ -423,8 +428,8 @@ static int add_ctrl(const char *argstr)
 
 	ret = write(fd, argstr, len);
 	if (ret != len) {
-		if (errno != EALREADY || !cfg.quiet)
-			fprintf(stderr, "Failed to write to %s: %s\n",
+		if (errno != EALREADY)
+			log(LOG_NOTICE, "Failed to write to %s: %s\n",
 				 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out_close;
@@ -432,7 +437,7 @@ static int add_ctrl(const char *argstr)
 
 	len = read(fd, buf, BUF_SIZE);
 	if (len < 0) {
-		fprintf(stderr, "Failed to read from %s: %s\n",
+		log(LOG_ERR, "Failed to read from %s: %s\n",
 			 PATH_NVME_FABRICS, strerror(errno));
 		ret = -errno;
 		goto out_close;
@@ -459,7 +464,7 @@ static int add_ctrl(const char *argstr)
 	}
 
 out_fail:
-	fprintf(stderr, "Failed to parse ctrl info for \"%s\"\n", argstr);
+	log(LOG_ERR, "Failed to parse ctrl info for \"%s\"\n", argstr);
 	ret = -EINVAL;
 out_close:
 	close(fd);
@@ -474,7 +479,7 @@ static int remove_ctrl_by_path(char *sysfs_path)
 	fd = open(sysfs_path, O_WRONLY);
 	if (fd < 0) {
 		ret = -errno;
-		fprintf(stderr, "Failed to open %s: %s\n", sysfs_path,
+		log(LOG_ERR, "Failed to open %s: %s\n", sysfs_path,
 				strerror(errno));
 		goto out;
 	}
@@ -528,7 +533,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	fd = open(dev_path, O_RDWR);
 	if (fd < 0) {
 		error = -errno;
-		fprintf(stderr, "Failed to open %s: %s\n",
+		log(LOG_ERR, "Failed to open %s: %s\n",
 				dev_path, strerror(errno));
 		goto out;
 	}
@@ -699,7 +704,7 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 	fd = open(cfg.raw, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (fd < 0) {
-		fprintf(stderr, "failed to open %s: %s\n",
+		log(LOG_ERR, "failed to open %s: %s\n",
 			cfg.raw, strerror(errno));
 		return;
 	}
@@ -708,7 +713,7 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 			numrec * sizeof(struct nvmf_disc_rsp_page_entry);
 	ret = write(fd, log, len);
 	if (ret < 0)
-		fprintf(stderr, "failed to write to %s: %s\n",
+		log(LOG_ERR, "failed to write to %s: %s\n",
 			cfg.raw, strerror(errno));
 	else
 		printf("Discovery log is saved to %s\n", cfg.raw);
@@ -855,13 +860,13 @@ static int build_options(char *argstr, int max_len, bool discover)
 	int len;
 
 	if (!cfg.transport) {
-		fprintf(stderr, "need a transport (-t) argument\n");
+		log(LOG_ERR, "need a transport (-t) argument\n");
 		return -EINVAL;
 	}
 
 	if (strncmp(cfg.transport, "loop", 4)) {
 		if (!cfg.traddr) {
-			fprintf(stderr, "need a address (-a) argument\n");
+			log(LOG_ERR, "need a address (-a) argument\n");
 			return -EINVAL;
 		}
 	}
@@ -945,7 +950,7 @@ static int hostname2traddr(struct config *cfg)
 
 	ret = getaddrinfo(cfg->traddr, NULL, &hints, &host_info);
 	if (ret) {
-		fprintf(stderr, "failed to resolve host %s info\n", cfg->traddr);
+		log(LOG_ERR, "failed to resolve host %s info\n", cfg->traddr);
 		return ret;
 	}
 
@@ -961,14 +966,14 @@ static int hostname2traddr(struct config *cfg)
 			addrstr, NVMF_TRADDR_SIZE);
 		break;
 	default:
-		fprintf(stderr, "unrecognized address family (%d) %s\n",
+		log(LOG_ERR, "unrecognized address family (%d) %s\n",
 			host_info->ai_family, cfg->traddr);
 		ret = -EINVAL;
 		goto free_addrinfo;
 	}
 
 	if (!p) {
-		fprintf(stderr, "failed to get traddr for %s\n", cfg->traddr);
+		log(LOG_ERR, "failed to get traddr for %s\n", cfg->traddr);
 		ret = -errno;
 		goto free_addrinfo;
 	}
@@ -996,7 +1001,7 @@ retry:
 	case NVME_NQN_NVME:
 		break;
 	default:
-		fprintf(stderr, "skipping unsupported subtype %d\n",
+		log(LOG_ERR, "skipping unsupported subtype %d\n",
 			 e->subtype);
 		return -EINVAL;
 	}
@@ -1085,7 +1090,7 @@ retry:
 
 	transport = trtype_str(e->trtype);
 	if (!strcmp(transport, "unrecognized")) {
-		fprintf(stderr, "skipping unsupported transport %d\n",
+		log(LOG_ERR, "skipping unsupported transport %d\n",
 				 e->trtype);
 		return -EINVAL;
 	}
@@ -1131,7 +1136,7 @@ retry:
 			p += len;
 			break;
 		default:
-			fprintf(stderr, "skipping unsupported adrfam\n");
+			log(LOG_ERR, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
 		break;
@@ -1146,7 +1151,7 @@ retry:
 			p += len;
 			break;
 		default:
-			fprintf(stderr, "skipping unsupported adrfam\n");
+			log(LOG_ERR, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
 		break;
@@ -1231,9 +1236,7 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		if (instance == -EALREADY) {
 			const char *traddr = log->entries[i].traddr;
 
-			if (!cfg.quiet)
-				fprintf(stderr,
-					"traddr=%.*s is already connected\n",
+			log(LOG_NOTICE, "traddr=%.*s is already connected\n",
 					space_strip_len(NVMF_TRADDR_SIZE,
 							traddr),
 					traddr);
@@ -1321,12 +1324,12 @@ static int do_discover(char *argstr, bool connect)
 			print_discovery_log(log, numrec);
 		break;
 	case DISC_GET_NUMRECS:
-		fprintf(stderr,
+		log(LOG_ERR,
 			"Get number of discovery log entries failed.\n");
 		ret = status;
 		break;
 	case DISC_GET_LOG:
-		fprintf(stderr, "Get discovery log entries failed.\n");
+		log(LOG_ERR, "Get discovery log entries failed.\n");
 		ret = status;
 		break;
 	case DISC_NO_LOG:
@@ -1338,12 +1341,12 @@ static int do_discover(char *argstr, bool connect)
 		ret = -EAGAIN;
 		break;
 	case DISC_NOT_EQUAL:
-		fprintf(stderr,
+		log(LOG_ERR,
 		"Numrec values of last two get discovery log page not equal\n");
 		ret = -EBADSLT;
 		break;
 	default:
-		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
+		log(LOG_ERR, "Get discovery log page failed: %d\n", ret);
 		break;
 	}
 
@@ -1359,7 +1362,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 
 	f = fopen(PATH_NVMF_DISC, "r");
 	if (f == NULL) {
-		fprintf(stderr, "No discover params given and no %s conf\n",
+		log(LOG_ERR, "No discover params given and no %s conf\n",
 			PATH_NVMF_DISC);
 		return -EINVAL;
 	}
@@ -1370,14 +1373,14 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 
 		args = strdup(line);
 		if (!args) {
-			fprintf(stderr, "failed to strdup args\n");
+			log(LOG_ERR, "failed to strdup args\n");
 			ret = -ENOMEM;
 			goto out;
 		}
 
 		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
 		if (!argv) {
-			fprintf(stderr, "failed to allocate argv vector\n");
+			log(LOG_ERR, "failed to allocate argv vector\n");
 			free(args);
 			ret = -ENOMEM;
 			goto out;
@@ -1428,6 +1431,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
 	int ret;
+	bool quiet = false;
 
 	OPT_ARGS(opts) = {
 		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
@@ -1449,7 +1453,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
 		OPT_INT("queue-size",      'Q', &cfg.queue_size,      "number of io queue elements to use (default 128)"),
 		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connection"),
-		OPT_FLAG("quiet",          'S', &cfg.quiet,           "suppress already connected errors"),
+		OPT_FLAG("quiet",          'S', &quiet,               "suppress already connected errors"),
 		OPT_FLAG("matching",       'm', &cfg.matching_only,   "connect only records matching the traddr"),
 		OPT_END()
 	};
@@ -1459,6 +1463,9 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	if (ret)
 		goto out;
 
+	if (quiet)
+		log_level = LOG_WARNING;
+
 	if (cfg.device && !strcmp(cfg.device, "none"))
 		cfg.device = NULL;
 
@@ -1534,7 +1541,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		goto out;
 
 	if (!cfg.nqn) {
-		fprintf(stderr, "need a -n argument\n");
+		log(LOG_ERR, "need a -n argument\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1572,7 +1579,7 @@ static int disconnect_subsys(char *nqn, char *ctrl)
 
 	fd = open(sysfs_nqn_path, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open %s: %s\n",
+		log(LOG_ERR, "Failed to open %s: %s\n",
 				sysfs_nqn_path, strerror(errno));
 		goto free;
 	}
@@ -1646,7 +1653,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 		goto out;
 
 	if (!cfg.nqn && !cfg.device) {
-		fprintf(stderr, "need a -n or -d argument\n");
+		log(LOG_ERR, "need a -n or -d argument\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1654,7 +1661,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	if (cfg.nqn) {
 		ret = disconnect_by_nqn(cfg.nqn);
 		if (ret < 0)
-			fprintf(stderr, "Failed to disconnect by NQN: %s\n",
+			log(LOG_ERR, "Failed to disconnect by NQN: %s\n",
 				cfg.nqn);
 		else {
 			printf("NQN:%s disconnected %d controller(s)\n", cfg.nqn, ret);
@@ -1665,7 +1672,7 @@ int fabrics_disconnect(const char *desc, int argc, char **argv)
 	if (cfg.device) {
 		ret = disconnect_by_device(cfg.device);
 		if (ret)
-			fprintf(stderr,
+			log(LOG_ERR,
 				"Failed to disconnect by device name: %s\n",
 				cfg.device);
 	}
@@ -1689,7 +1696,7 @@ int fabrics_disconnect_all(const char *desc, int argc, char **argv)
 
 	err = scan_subsystems(&t, NULL, 0, NULL);
 	if (err) {
-		fprintf(stderr, "Failed to scan namespaces\n");
+		log(LOG_ERR, "Failed to scan namespaces\n");
 		goto out;
 	}
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
