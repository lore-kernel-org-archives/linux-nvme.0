Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6143C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:40:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E849864F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E849864F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0U6Z6d53qZPXA+mj2G0Ny+xhCZ89oT49xfLMH7OCczk=; b=ICzAusJLVTH5eWWkSDqEmyezz
	PTnOVPaS8VEGOwhk4F+JaAYqA/yQYQpAKVwlWb2ztXG/JnqaennPtvxCJHK3NUpUynysEk2KfxX/H
	vvq6/ZoNO5kIsobQnsR+ZUFCb/yUG4mzT8JDexxmjA4TOhKOh5jYXsM4pd8IqloVftYgM6xyOL6UL
	U8zY2XrBLLvgfIL+//DiZ+sryTdY9wndkyPFhOec3a1Zjx1e2weds/W5H0ul1kMLZ1gVxtyNTQIbo
	S0xgyfEbB703A0Bip1j8EXsBhVBDjct3yYksK2nYU0XuyQC2HzNhujt58BeqU05cdBPob50j7PhZQ
	1ptHLJb1A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKzE-00HWos-Bt; Sat, 06 Mar 2021 00:40:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwX-00HVfc-3O
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xn9wLTvxb3NzqJWGTcGQTsosHpi3qLUNmWeaPtLlscc=;
 b=tPNmNMPz3neF4WsIWnlj1mWxyimGILIEb4gvtafxPDRpF92WtyxCBLN2Kc6ydDSmDoj9Ma
 zh2F7XMwB3FPemyIPV3Gk6Fz7FqRBMwha9qdS281a43Dgsc44vl8I7lvKgZQIh+j1E1hud
 C0VRPxMkdhQQyn46wI+BjK4PGalpAH4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B8BEBAEB3;
 Sat,  6 Mar 2021 00:37:16 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 04/16] monitor: implement uevent handling
Date: Sat,  6 Mar 2021 01:36:47 +0100
Message-Id: <20210306003659.21207-5-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_150252_FAD0050B 
X-CRM114-Status: GOOD (  23.55  )
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

This patch implements handling of events received via NVMe-FC
(fc_udev_device, detection of FC remote ports with NVMe support)
and AEN events from persistent discovery controller connections.

For actual discovery, we fork and basically run a "nvme connect-all"
process with for the newly detected discovery controller.
The reason for forking discovery tasks is twofold: Firstly, we'd
otherwise be forced to make all discovery connections sequentially,
which would be slow, as connecting controllers can block on
the order of seconds even in successful cases.

Secondly, this allows us to use the some global variables like
fabrics_cfg and tracked_ctrls in the discovery code path. Without forking,
we'd have to re-write much more code in fabrics.c. In general,
the alternative to forking would be creating threads, but the
that would require a large rewrite of our code base.

A single-threaded server that forks off the actual discovery makes
most sense at this point.

All options known from "nvme connect-all" can be passed to the discovery
processes as usual, with the exception of the "peristent" option, which
is always enabled: The monitor must try to create persistent discovery
connections in order to monitor them.
---
 monitor.c | 282 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 277 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 32f53a3..f544319 100644
--- a/monitor.c
+++ b/monitor.c
@@ -17,18 +17,24 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
 #include <libudev.h>
 #include <signal.h>
 #include <time.h>
 #include <syslog.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <sys/epoll.h>
 
 #include "nvme-status.h"
+#include "nvme.h"
 #include "util/argconfig.h"
 #include "util/cleanup.h"
 #include "common.h"
+#include "fabrics.h"
 #include "monitor.h"
 #define LOG_FUNCNAME 1
 #include "util/log.h"
@@ -87,12 +93,19 @@ static int create_udev_monitor(struct udev *udev, struct udev_monitor **pmon)
 }
 
 static sig_atomic_t must_exit;
+static sig_atomic_t got_sigchld;
+static sigset_t orig_sigmask;
 
 static void monitor_int_handler(int sig)
 {
 	must_exit = 1;
 }
 
+static void monitor_chld_handler(int sig)
+{
+	got_sigchld = 1;
+}
+
 static int monitor_init_signals(sigset_t *wait_mask)
 {
 	sigset_t mask;
@@ -103,26 +116,228 @@ static int monitor_init_signals(sigset_t *wait_mask)
 	 * for events.
 	 */
 	sigfillset(&mask);
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+	if (sigprocmask(SIG_BLOCK, &mask, &orig_sigmask) == -1)
 		return -errno;
 	if (sigaction(SIGTERM, &sa, NULL) == -1)
 		return -errno;
 	if (sigaction(SIGINT, &sa, NULL) == -1)
 		return -errno;
 
+	sa.sa_handler = monitor_chld_handler;
+	if (sigaction(SIGCHLD, &sa, NULL) == -1)
+		return -errno;
+
 	/* signal mask to be used in epoll_pwait() */
 	sigfillset(wait_mask);
 	sigdelset(wait_mask, SIGTERM);
 	sigdelset(wait_mask, SIGINT);
+	sigdelset(wait_mask, SIGCHLD);
 
 	return 0;
 }
 
+static int child_reset_signals(void)
+{
+	int err = 0;
+	struct sigaction sa = { .sa_handler = SIG_DFL, };
+
+	if (sigaction(SIGTERM, &sa, NULL) == -1)
+		err = errno;
+	if (sigaction(SIGINT, &sa, NULL) == -1 && !err)
+		err = errno;
+	if (sigaction(SIGCHLD, &sa, NULL) == -1 && !err)
+		err = errno;
+
+	if (sigprocmask(SIG_SETMASK, &orig_sigmask, NULL) == -1 && !err)
+		err = errno;
+
+	if (err)
+		msg(LOG_ERR, "error resetting signal handlers and mask\n");
+	return -err;
+}
+
+static int monitor_get_fc_uev_props(struct udev_device *ud,
+				    char *traddr, size_t tra_sz,
+				    char *host_traddr, size_t htra_sz)
+{
+	const char *sysname = udev_device_get_sysname(ud);
+	const char *tra = NULL, *host_tra = NULL;
+	bool fc_event_seen = false;
+	struct udev_list_entry *entry;
+
+	entry = udev_device_get_properties_list_entry(ud);
+	if (!entry) {
+		msg(LOG_NOTICE, "%s: emtpy properties list\n", sysname);
+		return -ENOENT;
+	}
+
+	for (; entry; entry = udev_list_entry_get_next(entry)) {
+		const char *name = udev_list_entry_get_name(entry);
+
+		if (!strcmp(name, "FC_EVENT") &&
+		    !strcmp(udev_list_entry_get_value(entry), "nvmediscovery"))
+				fc_event_seen = true;
+		else if (!strcmp(name, "NVMEFC_HOST_TRADDR"))
+			host_tra = udev_list_entry_get_value(entry);
+		else if (!strcmp(name, "NVMEFC_TRADDR"))
+			tra = udev_list_entry_get_value(entry);
+	}
+	if (!fc_event_seen) {
+		msg(LOG_DEBUG, "%s: FC_EVENT property missing or unsupported\n",
+		    sysname);
+		return -EINVAL;
+	}
+	if (!tra || !host_tra) {
+		msg(LOG_WARNING, "%s: transport properties missing\n", sysname);
+		return -EINVAL;
+	}
+
+	if (!memccpy(traddr, tra, '\0', tra_sz) ||
+	    !memccpy(host_traddr, host_tra, '\0', htra_sz)) {
+		msg(LOG_ERR, "traddr (%zu) or host_traddr (%zu) overflow\n",
+		    strlen(traddr), strlen(host_traddr));
+		return -ENAMETOOLONG;
+	}
+
+	return 0;
+}
+
+static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
+			     char *host_traddr)
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
+		msg(LOG_DEBUG, "started discovery task %ld\n", (long)pid);
+		return 0;
+	}
+
+	child_reset_signals();
+	free_dispatcher(mon_dsp);
+
+	msg(LOG_NOTICE, "starting discovery\n");
+	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
+	fabrics_cfg.transport = transport;
+	fabrics_cfg.traddr = traddr;
+	fabrics_cfg.trsvcid = trsvcid;
+	fabrics_cfg.host_traddr = host_traddr;
+	/* Without the following, the kernel returns EINVAL */
+	fabrics_cfg.tos = -1;
+	fabrics_cfg.persistent = true;
+
+	rc = build_options(argstr, sizeof(argstr), true);
+	msg(LOG_DEBUG, "%s\n", argstr);
+	rc = do_discover(argstr, mon_cfg.autoconnect, NORMAL);
+
+	exit(-rc);
+	/* not reached */
+	return rc;
+}
+
+static void monitor_handle_fc_uev(struct udev_device *ud)
+{
+	const char *action = udev_device_get_action(ud);
+	const char *sysname = udev_device_get_sysname(ud);
+	char traddr[NVMF_TRADDR_SIZE], host_traddr[NVMF_TRADDR_SIZE];
+
+	if (strcmp(action, "change") || strcmp(sysname, "fc_udev_device"))
+		return;
+
+	if (monitor_get_fc_uev_props(ud, traddr, sizeof(traddr),
+				     host_traddr, sizeof(host_traddr)))
+		return;
+
+	monitor_discovery("fc", traddr, NULL, host_traddr);
+}
+
+static int monitor_get_nvme_uev_props(struct udev_device *ud,
+				      char *transport, size_t tr_sz,
+				      char *traddr, size_t tra_sz,
+				      char *trsvcid, size_t trs_sz,
+				      char *host_traddr, size_t htra_sz)
+{
+	const char *sysname = udev_device_get_sysname(ud);
+	bool aen_disc = false;
+	struct udev_list_entry *entry;
+
+	entry = udev_device_get_properties_list_entry(ud);
+	if (!entry) {
+		msg(LOG_NOTICE, "%s: emtpy properties list\n", sysname);
+		return -ENOENT;
+	}
+
+	*transport = *traddr = *trsvcid = *host_traddr = '\0';
+	for (; entry; entry = udev_list_entry_get_next(entry)) {
+		const char *name = udev_list_entry_get_name(entry);
+
+		if (!strcmp(name, "NVME_AEN") &&
+		    !strcmp(udev_list_entry_get_value(entry), "0x70f002"))
+				aen_disc = true;
+		else if (!strcmp(name, "NVME_TRTYPE"))
+			memccpy(transport, udev_list_entry_get_value(entry),
+				'\0', tr_sz);
+		else if (!strcmp(name, "NVME_TRADDR"))
+			memccpy(traddr, udev_list_entry_get_value(entry),
+				'\0', htra_sz);
+		else if (!strcmp(name, "NVME_TRSVCID"))
+			memccpy(trsvcid, udev_list_entry_get_value(entry),
+				'\0', trs_sz);
+		else if (!strcmp(name, "NVME_HOST_TRADDR"))
+			memccpy(host_traddr, udev_list_entry_get_value(entry),
+				'\0', tra_sz);
+	}
+	if (!aen_disc) {
+		msg(LOG_DEBUG, "%s: not a \"discovery log changed\" AEN, ignoring event\n",
+		    sysname);
+		return -EINVAL;
+	}
+
+	if (!*traddr || !*transport) {
+		msg(LOG_WARNING, "%s: transport properties missing\n", sysname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void monitor_handle_nvme_uev(struct udev_device *ud)
+{
+	char traddr[NVMF_TRADDR_SIZE], host_traddr[NVMF_TRADDR_SIZE];
+	char trsvcid[NVMF_TRSVCID_SIZE], transport[5];
+
+	if (strcmp(udev_device_get_action(ud), "change"))
+		return;
+
+	if (monitor_get_nvme_uev_props(ud, transport, sizeof(transport),
+				       traddr, sizeof(traddr),
+				       trsvcid, sizeof(trsvcid),
+				       host_traddr, sizeof(host_traddr)))
+		return;
+
+	monitor_discovery(transport, traddr,
+			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr);
+}
+
 static void monitor_handle_udevice(struct udev_device *ud)
 {
-	msg(LOG_INFO, "uevent: %s %s\n",
-		udev_device_get_action(ud),
-		udev_device_get_sysname(ud));
+	const char *subsys  = udev_device_get_subsystem(ud);
+
+	if (log_level >= LOG_INFO) {
+		const char *action = udev_device_get_action(ud);
+		const char *syspath = udev_device_get_syspath(ud);
+
+		msg(LOG_INFO, "%s %s\n", action, syspath);
+	}
+	if (!strcmp(subsys, "fc"))
+		monitor_handle_fc_uev(ud);
+	else if (!strcmp(subsys, "nvme"))
+		monitor_handle_nvme_uev(ud);
 }
 
 struct udev_monitor_event {
@@ -147,6 +362,49 @@ static int monitor_handle_uevents(struct event *ev,
 	return EVENTCB_CONTINUE;
 }
 
+static int handle_epoll_err(int errcode)
+{
+	if (errcode != -EINTR)
+		return errcode;
+	else if (must_exit) {
+		msg(LOG_NOTICE, "monitor: exit signal received\n");
+		return ELOOP_QUIT;
+	} else if (!got_sigchld) {
+		msg(LOG_WARNING, "monitor: unexpected interruption, ignoring\n");
+		return ELOOP_CONTINUE;
+	}
+
+	got_sigchld = 0;
+	while (true) {
+		int wstatus;
+		pid_t pid;
+
+		pid = waitpid(-1, &wstatus, WNOHANG);
+		switch(pid) {
+		case -1:
+			if (errno != ECHILD)
+				msg(LOG_ERR, "error in waitpid: %m\n");
+			goto out;
+		case 0:
+			goto out;
+		default:
+			break;
+		}
+		if (!WIFEXITED(wstatus))
+			msg(LOG_WARNING, "child %ld didn't exit normally\n",
+			    (long)pid);
+		else if (WEXITSTATUS(wstatus) != 0)
+			msg(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
+			    (long)pid, strerror(WEXITSTATUS(wstatus)));
+		else
+			msg(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
+	};
+
+out:
+	/* tell event_loop() to continue */
+	return ELOOP_CONTINUE;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -156,6 +414,19 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 	int ret;
 	OPT_ARGS(opts) = {
 		OPT_FLAG("no-connect",     'N', &noauto,              "dry run, do not autoconnect to discovered controllers"),
+		OPT_LIST("hostnqn",        'q', &fabrics_cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
+		OPT_LIST("hostid",         'I', &fabrics_cfg.hostid,          "user-defined hostid (if default not used)"),
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
+		OPT_FLAG("matching",       'm', &fabrics_cfg.matching_only,   "connect only records matching the traddr"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
 		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
 		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
@@ -163,6 +434,7 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 		OPT_END()
 	};
 
+	log_pid = true;
 	ret = argconfig_parse(argc, argv, desc, opts);
 	if (ret)
 		return ret;
@@ -238,7 +510,7 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		goto out;
 	}
 
-	ret = event_loop(mon_dsp, &wait_mask, NULL);
+	ret = event_loop(mon_dsp, &wait_mask, handle_epoll_err);
 
 out:
 	free_dispatcher(mon_dsp);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
