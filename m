Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E3C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:37:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916B722228
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916B722228
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aV7SqQrGfKLuvc6eJZoJHRmBLuTZK3hTgS+R8Up3wp4=; b=POHKDylS/TFJQyAHXQQoPQj1q
	+liF1Im/aGslwrtRtI4WGnvcIlhgVd7mk4xfaw62yTIs+ze7w/VhYAkmSMscuAgPU+K6/B9GS0edg
	jyTysHJ5IwCBMeOAr4HrnBSiaOdU46YUZejcfMSLDbeRbVkEl+uyspTcLLWvAFulf0rJFEmKwetZR
	F8OWA24zuOAKOcFN3KcrsrrAZIeBC0ok6h40laFOSOPa8pEInJ2+x4d7mSD8wZ1Lu4wqvSPIq8HOV
	3dL++0ajIJpSf5kA5MAIzQkzAxds+qQxSOiJvR1w1a8bFA+9bFTEPcw9bsIJyBJY3fQN+p1Ghopf9
	c+snjKr1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V5W-0002XH-3X; Tue, 26 Jan 2021 20:37:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00010f-D7
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zezjKr0O6K33eSXicxb4wLUM+3e1b4ph4KPTsnayNHE=;
 b=QixZxnjrA9Cq8W0/GggEIsrfAJGTgEDtGZf/ls4pu+9d8XPu17uLvIgHltGF5zNRXa9nC2
 PLAN5RQlVlct7yU6bRfTjAI5dC4t9m0cuTWbcfgiJDPnxtjE1lLqlm92P7PeFCbjbZlVDs
 e/bco80dFRRjma7b/jxIwsv048RP6vw=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 56573B0D0;
 Tue, 26 Jan 2021 20:33:49 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 24/35] monitor: monitor_discovery(): try to reuse existing
 controllers
Date: Tue, 26 Jan 2021 21:33:13 +0100
Message-Id: <20210126203324.23610-25-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_723285_1DE5844F 
X-CRM114-Status: GOOD (  16.31  )
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

We need to pass cfg.device to do_discovery() if we want to re-use the
discovery controller device. Remember the instance number when
handling an AEN, and try to reuse this instance if the discovery
needs to be repeated.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index b44ff7a..ce772f3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -201,12 +201,14 @@ static int monitor_get_fc_uev_props(struct udev_device *ud,
 }
 
 static int monitor_discovery(const char *transport, const char *traddr,
-			     const char *trsvcid, const char *host_traddr)
+			     const char *trsvcid, const char *host_traddr,
+			     const char *devname)
 {
 	char argstr[BUF_SIZE];
 	pid_t pid;
 	int rc, db_rc;
 	struct nvme_connection *co = NULL;
+	char *device = NULL;
 
 	db_rc = conndb_add(transport, traddr, trsvcid, host_traddr, &co);
 	if (db_rc != 0 && db_rc != -EEXIST)
@@ -227,7 +229,15 @@ static int monitor_discovery(const char *transport, const char *traddr,
 		co->discovery_pending = 0;
 		co->status = CS_DISC_RUNNING;
 		co->discovery_task = pid;
+		if (devname) {
+			int instance = ctrl_instance(devname);
 
+			if (instance < 0) {
+				log(LOG_ERR, "unexpected devname: %s\n",
+				    devname);
+			} else
+				co->discovery_instance = instance;
+		}
 		return 0;
 	}
 
@@ -238,12 +248,26 @@ static int monitor_discovery(const char *transport, const char *traddr,
 	    trsvcid && *trsvcid ? trsvcid : "none",
 	    conn_status_str(co->status));
 
+	/*
+	 * Try to re-use existing controller. do_discovery() will check
+	 * if it matches the connection parameters.
+	 */
+	if (!devname && co->discovery_instance >= 0) {
+		if (asprintf(&device, "nvme%d", co->discovery_instance) == -1)
+			device = NULL;
+		else
+			devname = device;
+	}
+
+	if (devname)
+		log(LOG_INFO, "using discovery controller %s\n", devname);
 
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 	cfg.transport = transport;
 	cfg.traddr = traddr;
 	cfg.trsvcid = trsvcid && *trsvcid ? trsvcid : NULL;
-	cfg.host_traddr = host_traddr;
+	cfg.host_traddr = host_traddr && *host_traddr ? host_traddr : NULL;
+	cfg.device = devname;
 	/* Without the following, the kernel returns EINVAL */
 	cfg.tos = -1;
 
@@ -251,6 +275,7 @@ static int monitor_discovery(const char *transport, const char *traddr,
 	log(LOG_DEBUG, "%s\n", argstr);
 	rc = do_discover(argstr, mon_cfg.autoconnect);
 
+	free(device);
 	exit(-rc);
 	/* not reached */
 	return rc;
@@ -269,7 +294,7 @@ static void monitor_handle_fc_uev(struct udev_device *ud)
 				     host_traddr, sizeof(host_traddr)))
 		return;
 
-	monitor_discovery("fc", traddr, NULL, host_traddr);
+	monitor_discovery("fc", traddr, NULL, host_traddr, NULL);
 }
 
 static int monitor_get_nvme_uev_props(struct udev_device *ud,
@@ -337,7 +362,8 @@ static void monitor_handle_nvme_uev(struct udev_device *ud)
 		return;
 
 	monitor_discovery(transport, traddr,
-			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr);
+			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr,
+			  udev_device_get_sysname(ud));
 }
 
 static void monitor_handle_udevice(struct udev_device *ud)
@@ -411,7 +437,7 @@ static void handle_sigchld(void)
 		if (co->discovery_pending) {
 			log(LOG_NOTICE, "new discovery pending - restarting\n");
 			monitor_discovery(co->transport, co->traddr,
-					  co->trsvcid, co->host_traddr);
+					  co->trsvcid, co->host_traddr, NULL);
 		}
 	};
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
