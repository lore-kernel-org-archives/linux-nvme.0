Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DCCC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B196722A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B196722A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qswr9DXuBp27rPogZ91YI0JUKlvJKQtr4AlZcXgQ6rw=; b=wWWyLI/b3DA/pz5y/SBHngXyr
	/a3ndZL2I15leWRG4eA5TH4wA1ssSqcSzxgSQzqZ63UVHV7lg7r7bfj3gv4s8f1+CGKJ9/iBk6e+W
	gZpb4xPE4K1Fgj5BFtI2OjtFGIpjTRRl3C/KDqvZ70uxAczH+tVvwKFVbL9pcuTP1x88C/esN2NAO
	mIFYTizneqff+MEPHlwYx3G1H19T2bjv0jdxlj8Op4tSnFUPbqViUOFRGTeO5ae0HbhJh2b2pjdQM
	vzj4yAffJBKrlAeRZOTsjBAsn68RRoD7iEHU1tRdIDuufSiRyFvd4kBFr9xhDUOrrUmgzRkvckRuF
	T/zMc4MKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V4X-00026j-Mt; Tue, 26 Jan 2021 20:36:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-000114-Mm
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+ZHIsMVARn5AqqO3YzDKLHUbf898TTsdxHcu1aJ58I=;
 b=QbYARQsLRDzRbrLfp16vxxLlXwapc1Kti/IduBkQPdWtI63RMA8AfS1MfY8h5M/f3YSxKf
 qiiexUIMhX79Pb26FKW1V1A+6m0UpxL13l+2dSRN80hmRoeQURe2ShRsn6sMsiwsBPLAg+
 6mrur3uZNdi+BUKQhodNAS+jCRL2GnM=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 25E7BB13D;
 Tue, 26 Jan 2021 20:33:50 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 27/35] monitor: implement cleanup of created discovery
 controllers
Date: Tue, 26 Jan 2021 21:33:16 +0100
Message-Id: <20210126203324.23610-28-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_726721_EF50E4D4 
X-CRM114-Status: GOOD (  14.87  )
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

If -A or -U was in use, try to clean up discovery controllers we set
up during runtime. Discovery connections that were already up when
the monitor started will not be teared down.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/monitor.c b/monitor.c
index e5d1982..e3fee55 100644
--- a/monitor.c
+++ b/monitor.c
@@ -559,6 +559,39 @@ static int monitor_setup_discovery_ctrl(struct nvme_connection *co,
 	return rc ? CD_CB_ERR : CD_CB_OK;
 }
 
+static int monitor_remove_discovery_ctrl(struct nvme_connection *co,
+					void *arg __attribute__((unused)))
+{
+	char syspath[PATH_MAX];
+	int len;
+	CLEANUP(char, subsysnqn) = NULL;
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
+			log(LOG_ERR,
+			    "failed to remove discovery controller /dev/nvme%d: %m\n",
+			    co->discovery_instance);
+			return CD_CB_ERR;
+		} else
+			log(LOG_INFO,
+			    "removed discovery controller /dev/nvme%d\n",
+			    co->discovery_instance);
+	} else
+		log(LOG_WARNING,
+		    "unexpected NQN %s on /dev/nvme%d, not removing controller\n",
+		    subsysnqn, co->discovery_instance);
+	return CD_CB_OK;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -625,6 +658,8 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		ret = monitor_main_loop(monitor);
 		udev_monitor_unref(monitor);
 	}
+	if (mon_cfg.autoconnect || mon_cfg.start_ctrls)
+		conndb_for_each(monitor_remove_discovery_ctrl, NULL);
 	conndb_free();
 	udev = udev_unref(udev);
 	if (mon_cfg.autoconnect && !mon_cfg.skip_udev_on_exit)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
