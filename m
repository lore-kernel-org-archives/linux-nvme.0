Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D6C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:49:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AA064FDF
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AA064FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CvtNAK3nVP3pkti+IAQLnpHpUBFW1IqH2RxAYfe4OtA=; b=niQqK+1RqnsCCvC3uQISqSD+c
	ddFa246wSbU2jwPNgvyjaglTwQSsDfHPBIW/grSfvW4t0h86I107lVGiu4/l9P/jdIV95g0O1gsWD
	vHMwUYsU6AVSo4cl5nKpRNV20WUgAV8srdNxPcxwluoLHWfzz5mzWFXkx6vip6von54Gul7rgWbhG
	mxnIy0jXRjCNGeG7zpf2MginkBGAWBXu/jeNyKPL/yFmjliVJyCHc5mM8+LCvZU8xXagKud9bwwgR
	lHb2+DosRoDxIaIVthJP67MslBhj3KWuGjIHIoAhFOfYIuE517yX4Yt+Sg/drdIdzxxA8D75VTd5p
	NsTzV/r0Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL7b-00HZSb-3V; Sat, 06 Mar 2021 00:48:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwd-00HVja-Ls
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZPC0Q0K6+KIQLKk7PTcC5T34KC/PUzjUEwQl6XGED0=;
 b=rYGnvZrcEVvKztOpOBD69VP2++j+osDLUEIL0nJLlhzKWnjg6IV7Qq94dIgzIiqwmFOkWR
 4xh+K5P944r0n5zUyqexhw2Y6uKlmEjbr+g2k/PHCmlvf1z/atB18RHmifa4hUMk522JV+
 MMcsmeNiL+mN+dGNYW5d1eQFfa98XcE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9EDAAE05;
 Sat,  6 Mar 2021 00:37:18 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 10/16] monitor: discover from conf file on startup
Date: Sat,  6 Mar 2021 01:36:53 +0100
Message-Id: <20210306003659.21207-11-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003726_111913_C8D14526 
X-CRM114-Status: GOOD (  20.96  )
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

Implement discovery from /etc/nvme/discovery.conf on startup of
the monitor.

The monitor needs to call discover_from_conf_file() in order to
be able to do discovery at startup. discover_from_conf_file() takes
the argconfig_commandline_options argument from fabrics_discover().
By moving these options into a static variable, we can avoid passing
them as function argument. This makes it possible to use
discover_from_conf_file() from the monitor without making the
options for fabric_discover() globally visible.
---
 fabrics.c | 67 +++++++++++++++++++++++++++----------------------------
 fabrics.h |  5 +++++
 monitor.c | 58 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 36 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 5012519..b195d0e 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -85,7 +85,6 @@ struct connect_args {
 struct connect_args *tracked_ctrls;
 
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
-#define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
 #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
 #define MAX_DISC_ARGS		10
@@ -1439,8 +1438,9 @@ int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	return ret;
 }
 
-static int discover_from_conf_file(const char *desc, char *argstr,
-		const struct argconfig_commandline_options *opts, bool connect)
+static OPT_ARGS(discover_opts);
+
+int discover_from_conf_file(const char *desc, char *argstr, bool connect)
 {
 	FILE *f;
 	char line[256], *ptr, *all_args, *args, **argv;
@@ -1480,7 +1480,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		while ((ptr = strsep(&args, " =\n")) != NULL)
 			argv[argc++] = ptr;
 
-		err = argconfig_parse(argc, argv, desc, opts);
+		err = argconfig_parse(argc, argv, desc, discover_opts);
 		if (err)
 			goto free_and_continue;
 
@@ -1523,41 +1523,40 @@ out:
 	return ret;
 }
 
+static OPT_ARGS(discover_opts) = {
+	OPT_LIST("transport",      't', &fabrics_cfg.transport,       "transport type"),
+	OPT_LIST("traddr",         'a', &fabrics_cfg.traddr,          "transport address"),
+	OPT_LIST("trsvcid",        's', &fabrics_cfg.trsvcid,         "transport service id (e.g. IP port)"),
+	OPT_LIST("host-traddr",    'w', &fabrics_cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
+	OPT_LIST("hostnqn",        'q', &fabrics_cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
+	OPT_LIST("hostid",         'I', &fabrics_cfg.hostid,          "user-defined hostid (if default not used)"),
+	OPT_LIST("raw",            'r', &fabrics_cfg.raw,             "raw output file"),
+	OPT_LIST("device",         'd', &fabrics_cfg.device,          "use existing discovery controller device"),
+	OPT_INT("keep-alive-tmo",  'k', &fabrics_cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
+	OPT_INT("reconnect-delay", 'c', &fabrics_cfg.reconnect_delay, "reconnect timeout period in seconds"),
+	OPT_INT("ctrl-loss-tmo",   'l', &fabrics_cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
+	OPT_INT("tos",             'T', &fabrics_cfg.tos,             "type of service"),
+	OPT_FLAG("hdr_digest",     'g', &fabrics_cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
+	OPT_FLAG("data_digest",    'G', &fabrics_cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+	OPT_INT("nr-io-queues",    'i', &fabrics_cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
+	OPT_INT("nr-write-queues", 'W', &fabrics_cfg.nr_write_queues, "number of write queues to use (default 0)"),
+	OPT_INT("nr-poll-queues",  'P', &fabrics_cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
+	OPT_INT("queue-size",      'Q', &fabrics_cfg.queue_size,      "number of io queue elements to use (default 128)"),
+	OPT_FLAG("persistent",     'p', &fabrics_cfg.persistent,      "persistent discovery connection"),
+	OPT_FLAG("quiet",          'S', &fabrics_cfg.quiet,           "suppress already connected errors"),
+	OPT_FLAG("matching",       'm', &fabrics_cfg.matching_only,   "connect only records matching the traddr"),
+	OPT_FMT("output-format",   'o', &fabrics_cfg.output_format,   "Output format: normal|json|binary"),
+	OPT_END()
+};
+
 int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
 	int ret;
 	enum nvme_print_flags flags;
-	bool quiet = false;
-
-	OPT_ARGS(opts) = {
-		OPT_LIST("transport",      't', &fabrics_cfg.transport,       "transport type"),
-		OPT_LIST("traddr",         'a', &fabrics_cfg.traddr,          "transport address"),
-		OPT_LIST("trsvcid",        's', &fabrics_cfg.trsvcid,         "transport service id (e.g. IP port)"),
-		OPT_LIST("host-traddr",    'w', &fabrics_cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
-		OPT_LIST("hostnqn",        'q', &fabrics_cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
-		OPT_LIST("hostid",         'I', &fabrics_cfg.hostid,          "user-defined hostid (if default not used)"),
-		OPT_LIST("raw",            'r', &fabrics_cfg.raw,             "raw output file"),
-		OPT_LIST("device",         'd', &fabrics_cfg.device,          "existing discovery controller device"),
-		OPT_INT("keep-alive-tmo",  'k', &fabrics_cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
-		OPT_INT("reconnect-delay", 'c', &fabrics_cfg.reconnect_delay, "reconnect timeout period in seconds"),
-		OPT_INT("ctrl-loss-tmo",   'l', &fabrics_cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
-		OPT_INT("tos",             'T', &fabrics_cfg.tos,             "type of service"),
-		OPT_FLAG("hdr_digest",     'g', &fabrics_cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
-		OPT_FLAG("data_digest",    'G', &fabrics_cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
-		OPT_INT("nr-io-queues",    'i', &fabrics_cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
-		OPT_INT("nr-write-queues", 'W', &fabrics_cfg.nr_write_queues, "number of write queues to use (default 0)"),
-		OPT_INT("nr-poll-queues",  'P', &fabrics_cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
-		OPT_INT("queue-size",      'Q', &fabrics_cfg.queue_size,      "number of io queue elements to use (default 128)"),
-		OPT_FLAG("persistent",     'p', &fabrics_cfg.persistent,      "persistent discovery connection"),
-		OPT_FLAG("quiet",          'S', &quiet,               "suppress already connected errors"),
-		OPT_FLAG("matching",       'm', &fabrics_cfg.matching_only,   "connect only records matching the traddr"),
-		OPT_FMT("output-format",   'o', &fabrics_cfg.output_format,   output_format),
-		OPT_END()
-	};
 
 	fabrics_cfg.tos = -1;
-	ret = argconfig_parse(argc, argv, desc, opts);
+	ret = argconfig_parse(argc, argv, desc, discover_opts);
 	if (ret)
 		goto out;
 
@@ -1572,7 +1571,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		}
 	}
 
-	if (quiet)
+	if (fabrics_cfg.quiet)
 		log_level = LOG_WARNING;
 
 	if (fabrics_cfg.device && !strcmp(fabrics_cfg.device, "none"))
@@ -1581,7 +1580,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!fabrics_cfg.transport && !fabrics_cfg.traddr) {
-		ret = discover_from_conf_file(desc, argstr, opts, connect);
+		ret = discover_from_conf_file(desc, argstr, connect);
 	} else {
 		set_discovery_kato(&fabrics_cfg);
 
diff --git a/fabrics.h b/fabrics.h
index 41e6a2d..128f251 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -38,6 +38,7 @@ struct fabrics_config {
 	int  data_digest;
 	bool persistent;
 	bool matching_only;
+	bool quiet;
 	const char *output_format;
 };
 extern struct fabrics_config fabrics_cfg;
@@ -45,11 +46,15 @@ extern struct fabrics_config fabrics_cfg;
 extern const char *const trtypes[];
 
 #define BUF_SIZE 4096
+#define PATH_NVMF_CFG_DIR	"/etc/nvme"
+#define FILE_NVMF_DISC		"discovery.conf"
+#define PATH_NVMF_DISC		PATH_NVMF_CFG_DIR "/" FILE_NVMF_DISC
 
 int build_options(char *argstr, int max_len, bool discover);
 int do_discover(char *argstr, bool connect, enum nvme_print_flags flags);
 int ctrl_instance(const char *device);
 char *parse_conn_arg(const char *conargs, const char delim, const char *field);
 int remove_ctrl(int instance);
+int discover_from_conf_file(const char *desc, char *argstr, bool connect);
 
 #endif
diff --git a/monitor.c b/monitor.c
index 43d3084..95dea19 100644
--- a/monitor.c
+++ b/monitor.c
@@ -477,12 +477,20 @@ static int handle_epoll_err(int errcode)
 		default:
 			break;
 		}
+
 		co = conndb_find_by_pid(pid);
 		if (!co) {
-			msg(LOG_ERR, "no connection found for discovery task %ld\n",
-			    (long)pid);
+			if (!WIFEXITED(wstatus))
+				msg(LOG_WARNING, "child %ld didn't exit normally\n",
+				    (long)pid);
+			else if (WEXITSTATUS(wstatus) != 0)
+				msg(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
+				    (long)pid, strerror(WEXITSTATUS(wstatus)));
+			else
+				msg(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
 			continue;
 		}
+
 		if (!WIFEXITED(wstatus)) {
 			msg(LOG_WARNING, "child %ld didn't exit normally\n",
 			    (long)pid);
@@ -572,6 +580,45 @@ static int monitor_remove_discovery_ctrl(struct nvme_connection *co,
 	return CD_CB_OK;
 }
 
+static int monitor_discover_from_conf_file(void)
+{
+	char argstr[BUF_SIZE];
+	pid_t pid;
+	int rc;
+
+	pid = fork();
+	if (pid == -1) {
+		msg(LOG_ERR, "failed to fork discovery task: %m");
+		return -errno;
+	} else if (pid > 0) {
+		msg(LOG_DEBUG, "started discovery task %ld from conf file\n",
+		    (long)pid);
+		return 0;
+	}
+
+	child_reset_signals();
+
+	msg(LOG_NOTICE, "starting discovery from conf file\n");
+
+	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
+	fabrics_cfg.tos = -1;
+	fabrics_cfg.persistent = true;
+
+	rc = discover_from_conf_file("Discover NVMeoF subsystems from " PATH_NVMF_DISC,
+				     argstr, mon_cfg.autoconnect);
+
+	exit(-rc);
+	/* not reached */
+	return rc;
+}
+
+static int discovery_from_conf_file_cb(struct event *ev __attribute__((unused)),
+					unsigned int __attribute__((unused)) ep_events)
+{
+	monitor_discover_from_conf_file();
+	return EVENTCB_CLEANUP;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -638,6 +685,7 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	struct udev *udev __cleanup__(cleanup_udevp) = NULL;
 	struct udev_monitor *monitor __cleanup__(cleanup_monitorp) = NULL;
 	struct udev_monitor_event udev_event = { .e.fd = -1, };
+	struct event startup_discovery_event = { .fd = -1, };
 	sigset_t wait_mask;
 
 	ret = monitor_parse_opts(desc, argc, argv);
@@ -663,6 +711,12 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		goto out;
 	}
 
+	startup_discovery_event =
+		TIMER_EVENT_ON_STACK(discovery_from_conf_file_cb, 0);
+	if ((ret = event_add(mon_dsp, &startup_discovery_event)) != 0)
+		msg(LOG_ERR, "failed to register initial discovery timer: %s\n",
+		    strerror(-ret));
+
 	ret = create_udev_monitor(udev, &monitor);
 	if (ret != 0)
 		goto out;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
