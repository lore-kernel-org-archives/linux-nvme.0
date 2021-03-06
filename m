Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194DAC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:43:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654FD64F52
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654FD64F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iEOJzvLaChG755WrTwzOHYBCQ2n+1CM0bIvIKZniaCU=; b=Q2rLRh/hVGDNudLFNfkIG+WRa
	Luq971AegZevEcsg0nCCt9n2iAMeKAqMoNONBXFNczBcz6WK7NLwp1uFo/spkYqkYt6l2994P47tK
	tMMnyVem0tOKAHs9MisywwcCAqAL5Ek8YEqfLNPEAAwSOvpcpMVnrZoeb1PPT/hE70pSP5nt9Qmxp
	6mcodnXIdMzfXyNF0wGSooC/OE+qYN7Ai5aSMDOHlBefTK68THh84kuUlI5p17neKse88Yh+CPmtB
	EU1fU35vSMxkLIa3Exe9bEUg+oKMdODQQPBFE5QBZ7WadUB+hV0/0BvPWc4tM3Cy+LahI1VHR9AJI
	x71U0MB+Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL2W-00HXlk-V7; Sat, 06 Mar 2021 00:43:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwZ-00HVg1-1G
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wimcJgCYQ+VeeMjupvZ+yuw8AsE007OpMrEI8wfux6U=;
 b=XS7ZYVsSww4ElzqagfmIyrf6/vABFIWMkbCwAhQMAfukFjiWs8nBvU0xq33J3PxXr5FDFs
 6fUIrgQRQ8WItWAbAutkv5tDdpqiTHFg0sdSzt2M4LTXImFN/sFoRd9BJpUh81D3UbBEMp
 8W6ToQ0FXPtOh5M9OQShp37BsapIhHE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 77BF3AF24;
 Sat,  6 Mar 2021 00:37:17 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 06/16] monitor: monitor_discovery(): try to reuse existing
 controllers
Date: Sat,  6 Mar 2021 01:36:49 +0100
Message-Id: <20210306003659.21207-7-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003719_592967_A4C072A8 
X-CRM114-Status: GOOD (  13.85  )
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

We need to pass cfg.device to do_discovery() if we want to re-use the
discovery controller device. Remember the instance number when
handling an AEN, and try to reuse this instance if the discovery
needs to be repeated.
---
 monitor.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/monitor.c b/monitor.c
index d724f6f..f7517cb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -204,12 +204,14 @@ static int monitor_get_fc_uev_props(struct udev_device *ud,
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
@@ -230,7 +232,15 @@ static int monitor_discovery(const char *transport, const char *traddr,
 		co->discovery_pending = 0;
 		co->status = CS_DISC_RUNNING;
 		co->discovery_task = pid;
+		if (devname) {
+			int instance = ctrl_instance(devname);
 
+			if (instance < 0) {
+				msg(LOG_ERR, "unexpected devname: %s\n",
+				    devname);
+			} else
+				co->discovery_instance = instance;
+		}
 		return 0;
 	}
 
@@ -238,12 +248,29 @@ static int monitor_discovery(const char *transport, const char *traddr,
 	free_dispatcher(mon_dsp);
 	conndb_free();
 
-	msg(LOG_NOTICE, "starting discovery\n");
+	conn_msg(LOG_NOTICE, co, "starting discovery in state %s\n",
+		 conn_status_str(co->status));
+
+	/*
+	 * Try to re-use existing controller. do_discovery() will check
+	 * if it matches the connection parameters.
+	 * fabrics_cfg.device must be allocated on the heap!
+	 */
+	if (devname)
+		device = strdup(devname);
+	else if (co->discovery_instance >= 0 &&
+		 asprintf(&device, "nvme%d", co->discovery_instance) == -1)
+		device = NULL;
+
+	if (device)
+		msg(LOG_INFO, "using discovery controller %s\n", device);
+
 	fabrics_cfg.nqn = NVME_DISC_SUBSYS_NAME;
 	fabrics_cfg.transport = transport;
 	fabrics_cfg.traddr = traddr;
-	fabrics_cfg.trsvcid = trsvcid;
-	fabrics_cfg.host_traddr = host_traddr;
+	fabrics_cfg.trsvcid = trsvcid && *trsvcid ? trsvcid : NULL;
+	fabrics_cfg.host_traddr = host_traddr && *host_traddr ? host_traddr : NULL;
+	fabrics_cfg.device = device;
 	/* Without the following, the kernel returns EINVAL */
 	fabrics_cfg.tos = -1;
 	fabrics_cfg.persistent = true;
@@ -252,6 +279,7 @@ static int monitor_discovery(const char *transport, const char *traddr,
 	msg(LOG_DEBUG, "%s\n", argstr);
 	rc = do_discover(argstr, mon_cfg.autoconnect, NORMAL);
 
+	free(device);
 	exit(-rc);
 	/* not reached */
 	return rc;
@@ -270,7 +298,7 @@ static void monitor_handle_fc_uev(struct udev_device *ud)
 				     host_traddr, sizeof(host_traddr)))
 		return;
 
-	monitor_discovery("fc", traddr, NULL, host_traddr);
+	monitor_discovery("fc", traddr, NULL, host_traddr, NULL);
 }
 
 static int monitor_get_nvme_uev_props(struct udev_device *ud,
@@ -338,7 +366,8 @@ static void monitor_handle_nvme_uev(struct udev_device *ud)
 		return;
 
 	monitor_discovery(transport, traddr,
-			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr);
+			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr,
+			  udev_device_get_sysname(ud));
 }
 
 static void monitor_handle_udevice(struct udev_device *ud)
@@ -433,7 +462,7 @@ static int handle_epoll_err(int errcode)
 		if (co->discovery_pending) {
 			msg(LOG_NOTICE, "new discovery pending - restarting\n");
 			monitor_discovery(co->transport, co->traddr,
-					  co->trsvcid, co->host_traddr);
+					  co->trsvcid, co->host_traddr, NULL);
 		}
 	};
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
