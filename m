Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6921322B3F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6921322B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=97Vk4CZuJ9kvrsOOyV8jMryonLrTZIzsMhf3jYqnnRA=; b=KSfBevwuNB0rI0WEIOUGulqnw
	a094Oul0VG0TNbFMkCnbgYPsia5IGrueuxZHQAIWYjESjBL5vzLyMtDpDK5OmJqfCho9Bgy2ZNpGB
	wAywdxSt5801duyXPYJmd9b5+G8VAWJczB6R/Q9IjMkNOtqCUyca8oaNPCB3xOKoBAuCrpfH3m7eY
	NWPGG919p1OC98hN0Uss4LLbfgQbcuEHJ5NVCXZ9BZNDPNs+ou2gio/W+BA7nvU1CZyERds5+7us0
	IwblbTcP1NzpWKB00SPBFCaFhnnCSb7v6mdygCfHH6jxpXER03AQV/onhjzj9BE/AzansYq9MSX99
	9+NqC3YSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V36-0001O7-SX; Tue, 26 Jan 2021 20:34:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V27-0000xr-OQ
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gawt+uZ5P44KcrlzDKrGoLvXhXdwcdexQ1CJ2cq7aVI=;
 b=TbmoVrFygjjylOnEZAT0GOpsmvY889Sdd+vueMxW8gBIhsK8nAfDrGTn1zeo2F+YH28FQv
 glofHq+c3WxvdCGvDpj8kO4+6FL0cd3D7bqnz6CQ+sNZtZIljb4tKYaGPVCPSaZQUvOUfD
 enoUd8sLe9OKO/zXxQSN2PoL5AquTvU=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5A50BB001;
 Tue, 26 Jan 2021 20:33:46 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 14/35] monitor: implement handling of fc_udev_device
Date: Tue, 26 Jan 2021 21:33:03 +0100
Message-Id: <20210126203324.23610-15-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153352_153125_D968F059 
X-CRM114-Status: GOOD (  20.11  )
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

The reason we fork off discovery tasks is two-fold: Firstly, we'd
otherwise be forced to make all discovery connections sequentially,
which would be slow, as connecting controllers can block on
the order of seconds even in successful cases.

Secondly, this allows us to use the some static variables like
cfg and tracked_ctrls in the discovery code path. Without forking,
we'd have to re-write much more code in fabrics.c. In general,
the alternative to forking would be creating threads, but the
that would probably require a large rewrite of our code base.

A single-threaded server that forks off the actual discovery makes
most sense at this point.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 2a906db..6547265 100644
--- a/monitor.c
+++ b/monitor.c
@@ -30,7 +30,9 @@
 
 #include "common.h"
 #include "nvme-status.h"
+#include "nvme.h"
 #include "util/argconfig.h"
+#include "fabrics.h"
 #include "monitor.h"
 #define LOG_FUNCNAME 1
 #include "log.h"
@@ -117,11 +119,113 @@ static int monitor_init_signals(void)
 	return 0;
 }
 
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
+		log(LOG_NOTICE, "%s: emtpy properties list\n", sysname);
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
+		log(LOG_DEBUG, "%s: FC_EVENT property missing or unsupported\n",
+		    sysname);
+		return -EINVAL;
+	}
+	if (!tra || !host_tra) {
+		log(LOG_WARNING, "%s: transport properties missing\n", sysname);
+		return -EINVAL;
+	}
+
+	if (!memccpy(traddr, tra, '\0', tra_sz) ||
+	    !memccpy(host_traddr, host_tra, '\0', htra_sz)) {
+		log(LOG_ERR, "traddr (%zu) or host_traddr (%zu) overflow\n",
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
+		log(LOG_ERR, "failed to fork discovery task: %m");
+		return -errno;
+	} else if (pid > 0)
+		return 0;
+
+	log(LOG_NOTICE, "starting %s discovery for %s==>%s(%s)\n",
+	    transport, host_traddr, traddr, trsvcid ? trsvcid : "none");
+	cfg.nqn = NVME_DISC_SUBSYS_NAME;
+	cfg.transport = transport;
+	cfg.traddr = traddr;
+	cfg.trsvcid = trsvcid;
+	cfg.host_traddr = host_traddr;
+	/* Without the following, the kernel returns EINVAL */
+	cfg.tos = -1;
+
+	rc = build_options(argstr, sizeof(argstr), true);
+	log(LOG_DEBUG, "%s\n", argstr);
+	rc = do_discover(argstr, mon_cfg.autoconnect);
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
 static void monitor_handle_udevice(struct udev_device *ud)
 {
-	log(LOG_INFO, "uevent: %s %s\n",
-		udev_device_get_action(ud),
-		udev_device_get_sysname(ud));
+	const char *subsys  = udev_device_get_subsystem(ud);
+
+	if (log_level >= LOG_INFO) {
+		const char *action = udev_device_get_action(ud);
+		const char *syspath = udev_device_get_syspath(ud);
+
+		log(LOG_INFO, "%s %s\n", action, syspath);
+	}
+	if (!strcmp(subsys, "fc"))
+		monitor_handle_fc_uev(ud);
 }
 
 static void monitor_handle_uevents(struct udev_monitor *monitor)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
