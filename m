Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C17C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:42:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559D364F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559D364F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rlHDgx9rhvu3AtIR6FhSFWv6nyv6uWmLNenuXe5aDIw=; b=HGzm7GouQxl1zLeCl9+zRKTDt
	dmaD8l+dSeLI/YFJwsemKB4CzjFeBPGcFQjylM/VsXeeSlUrZ/Jk5qhbXA9WvhZKYavIbXCRf9q0r
	gwkMMzNt9ohVpo2RmNA325ZrWzDEHWlnOAyCYRvfqgXZBTFMxTI1Yg2UKFdQYaQRXBvf9Rks/INlE
	PYkenfJAuvsXWBFi9IhVILNznW7V/5CDd8oJTK+NmxXo2DwR21MGMWOxgJCNGwWZxX3vGhIEr2zah
	T+5c+KG2sgDJ4z+ZzsVXUNSiWYxOfLf00rE9s5OFU+XVZY6Mxnp2DP5oc70eZ53Isydmnu/p+RoAI
	zmqj+CW/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL1h-00HXWf-M7; Sat, 06 Mar 2021 00:42:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwb-00HViY-Lx
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAuWOY0oUJRQ9Nqv7Ng9VaIc2T7/K4hq14a0KbI216o=;
 b=KWETOT/OAvKS5VRiMPInxifiMUBA5VLYp1lItsfkolAjcEUGPx7cj4NnT+Vwq15e1RSHel
 nRW052jGEcKeJsDwJtfkSu+CHILRBdbdyjIl/6mHK+I2ACUHoc7grazbNLHXT84hDpd9Ss
 uh9zkznva2pQFcGSJomIRhnwm6TiWno=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2A3E7AF32;
 Sat,  6 Mar 2021 00:37:18 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 08/16] monitor: add option --cleanup / -C
Date: Sat,  6 Mar 2021 01:36:51 +0100
Message-Id: <20210306003659.21207-9-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003723_126580_EC93F73A 
X-CRM114-Status: GOOD (  13.23  )
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

With this option, "nvme monitor" will remove created discovery controllers
after it exits. To avoid shutting down connections that were created
independently, check existing connections on startup and track them with
the discovery_ctrl_existed flag.
---
 conn-db.c |  1 +
 conn-db.h |  1 +
 monitor.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/conn-db.c b/conn-db.c
index cfdc208..93eae4a 100644
--- a/conn-db.c
+++ b/conn-db.c
@@ -382,6 +382,7 @@ int conndb_init_from_sysfs(void)
 			instance =ctrl_instance(devices[i]->d_name);
 			if (instance >= 0) {
 				ci->c.discovery_instance = instance;
+				ci->c.discovery_ctrl_existed = 1;
 				msg(LOG_DEBUG, "found discovery controller %s\n",
 				    devices[i]->d_name);
 			}
diff --git a/conn-db.h b/conn-db.h
index e2a5827..8f5b400 100644
--- a/conn-db.h
+++ b/conn-db.h
@@ -12,6 +12,7 @@ struct nvme_connection {
 	int discovery_pending:1;
 	int did_discovery:1;
 	int successful_discovery:1;
+	int discovery_ctrl_existed:1;
 	union {
 		pid_t discovery_task;
 		int discovery_result;
diff --git a/monitor.c b/monitor.c
index b17fca0..e7e91f9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -43,8 +43,10 @@
 
 static struct monitor_config {
 	bool autoconnect;
+	bool keep_ctrls;
 } mon_cfg = {
 	.autoconnect = true,
+	.keep_ctrls = true,
 };
 
 static struct dispatcher *mon_dsp;
@@ -499,15 +501,50 @@ static int monitor_kill_discovery_task(struct nvme_connection *co,
 	}
 }
 
+static int monitor_remove_discovery_ctrl(struct nvme_connection *co,
+					void *arg __attribute__((unused)))
+{
+	char syspath[PATH_MAX];
+	int len;
+	char *subsysnqn __cleanup__(cleanup_charp) = NULL;
+
+	if (co->discovery_instance == -1 || co->discovery_ctrl_existed)
+		return CD_CB_OK;
+
+	len = snprintf(syspath, sizeof(syspath), SYS_NVME "/nvme%d",
+		       co->discovery_instance);
+	if (len < 0 || len >= sizeof(syspath))
+		return CD_CB_ERR;
+
+	subsysnqn = nvme_get_ctrl_attr(syspath, "subsysnqn");
+	if (subsysnqn && !strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME)) {
+		if (remove_ctrl(co->discovery_instance)) {
+			msg(LOG_ERR,
+			    "failed to remove discovery controller /dev/nvme%d: %m\n",
+			    co->discovery_instance);
+			return CD_CB_ERR;
+		} else
+			msg(LOG_INFO,
+			    "removed discovery controller /dev/nvme%d\n",
+			    co->discovery_instance);
+	} else
+		msg(LOG_WARNING,
+		    "unexpected NQN %s on /dev/nvme%d, not removing controller\n",
+		    subsysnqn ? subsysnqn : "(NULL)", co->discovery_instance);
+	return CD_CB_OK;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
 	bool verbose = false;
 	bool debug = false;
 	bool noauto = false;
+	bool cleanup = false;
 	int ret;
 	OPT_ARGS(opts) = {
 		OPT_FLAG("no-connect",     'N', &noauto,              "dry run, do not autoconnect to discovered controllers"),
+		OPT_FLAG("cleanup",        'C', &cleanup,                     "remove created discovery controllers on exit"),
 		OPT_LIST("hostnqn",        'q', &fabrics_cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
 		OPT_LIST("hostid",         'I', &fabrics_cfg.hostid,          "user-defined hostid (if default not used)"),
 		OPT_INT("keep-alive-tmo",  'k', &fabrics_cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
@@ -540,6 +577,8 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 		log_level = LOG_DEBUG;
 	if (noauto)
 		mon_cfg.autoconnect = false;
+	if (cleanup)
+		mon_cfg.keep_ctrls = false;
 
 	return ret;
 }
@@ -604,9 +643,12 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		goto out;
 	}
 
+	conndb_init_from_sysfs();
 	ret = event_loop(mon_dsp, &wait_mask, handle_epoll_err);
 
 	conndb_for_each(monitor_kill_discovery_task, NULL);
+	if (mon_cfg.autoconnect && !mon_cfg.keep_ctrls)
+		conndb_for_each(monitor_remove_discovery_ctrl, NULL);
 	conndb_free();
 out:
 	free_dispatcher(mon_dsp);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
