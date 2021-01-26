Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE7C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BCF22A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BCF22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y9Sk8At00Dt3T5F2Mrszd3nloYhh30Rgu9W8bfq19iI=; b=DGQjMLQ84TctoaWoFVtSoCHFx
	C3Nj0I83ap5iBX1ALZD8OO0m+ax/8oYhb8nSuuT3m7b5WsFHfesp6wYAZ03MQk1vIETMPnV+SWLoX
	NwWhFLin8qJo9OTXnDxX9N//hcTDdPALT3VCPiP7DpqptoOIEMFmasWKUSpdB8/DDQs62oWZxCqRY
	GK8lFuoGAE/I3W+EU1wCSwmIvnz1gLFpPfPXRfZF5nz63KpZAauNh/OwpMywgHkG6Au+nlTS9px0B
	KEZLH5ItOUhUiXN8+35OLd9FXUgufS3jjcc4WTz9CQSpfBB0Rp65DL0Mbdz5Osc90pjkzSzHnBk/I
	Xi1lKzTEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V48-0001v3-LG; Tue, 26 Jan 2021 20:35:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00010x-JS
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Upz/xj+kEm+bDtTDQ8gYJ+jZqN76O8SPp9zuTavGZM0=;
 b=hYoLj5yCfG3dgI632iyxBDIsiyJoRpF+Wx/WtKqCN4q3NDV/3tRYx+yivlrpJ4TeUV2aBs
 OzEhZ9fKGeltOvlzYoeR9gOn6Qi5pz+IShJ5OF6Mk/Dy9BcVeLe/yUToFnWijGc7fg6AdB
 CPL71QVFIWf7ewX53GK8lF2+QdiCs78=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D56BCB13A;
 Tue, 26 Jan 2021 20:33:49 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 26/35] monitor: implement starting discovery controllers on
 startup
Date: Tue, 26 Jan 2021 21:33:15 +0100
Message-Id: <20210126203324.23610-27-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_701837_86D78318 
X-CRM114-Status: GOOD (  15.63  )
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

If the -U/--startup option is used, nvme monitor looks for exsiting
nvme controllers on startup, and runs a discovery on the associated
transport address (connection); i.e. tries to connect to a discovery
subsystem on the same address, retrieve the discovery log pages,
and (if --autoconnect is given) connect all listed controllers.

It depends on the --persistent option whether the discovery controllers
created in this process will be persistent after startup.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/monitor.c b/monitor.c
index 5bd900b..e5d1982 100644
--- a/monitor.c
+++ b/monitor.c
@@ -43,6 +43,7 @@
 static struct monitor_config {
 	bool autoconnect;
 	bool skip_udev_on_exit;
+	bool start_ctrls;
 } mon_cfg;
 
 static struct udev *udev;
@@ -544,6 +545,20 @@ static void monitor_enable_udev_rules(void)
 		log(LOG_INFO, "removed %s\n", autoconnect_rules);
 }
 
+static int monitor_setup_discovery_ctrl(struct nvme_connection *co,
+					void *arg __attribute__((unused)))
+{
+	int rc;
+
+	if (co->discovery_instance >= 0)
+		return CD_CB_OK;
+
+	rc = monitor_discovery(co->transport, co->traddr, co->trsvcid,
+			       co->host_traddr, NULL);
+
+	return rc ? CD_CB_ERR : CD_CB_OK;
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -553,6 +568,7 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 
 	OPT_ARGS(opts) = {
 		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
+		OPT_FLAG("startup",        'U', &mon_cfg.start_ctrls, "start discovery controllers on startup"),
 		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connections"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
 		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
@@ -604,6 +620,8 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	ret = create_udev_monitor(&monitor);
 	if (ret == 0) {
 		conndb_init_from_sysfs();
+		if (mon_cfg.start_ctrls)
+			conndb_for_each(monitor_setup_discovery_ctrl, NULL);
 		ret = monitor_main_loop(monitor);
 		udev_monitor_unref(monitor);
 	}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
