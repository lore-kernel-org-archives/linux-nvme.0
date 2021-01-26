Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCADC4332B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374E222228
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374E222228
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VcKWJkrAOb7MxLzZDn7eD006gYNqsIdUA420ZmOdflY=; b=DhDG3ibONrlwVDK2bxnva0qXz
	ccTqdKQn1FSUSExkm4ubu7WysJSjhFoP3tXUVT4FeVuLSyIXZK6gOVlx5T0HwXMwJJFYEPRpdK7al
	HhtmqpP8CxGLWNw8GifXxMXiiMKicdcMOBLAspzQBYjdfT76Hr958cagF9mVSntIme4IMH0EWrAMi
	aUTXORBLvY69X3YacTGcNoccaXA40/I8aFeYtyAhO4S7omJvlKdWeFQGHngJGE1Biflho759ioNxl
	z6RmbdrdMKKhCb4jSTY4TLSlceLAiekqa/JRzKLXRjnZI/r/VPwwCTcOk2hiARiNi37b25zeWrMAp
	w9G1rwC1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V4y-0002J5-MH; Tue, 26 Jan 2021 20:36:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00010y-MT
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIm4NGobn36YzMRwUvueztV7gCHzCb+iGWwS+JqEd/c=;
 b=PVxt9J8QF7/pyNQ9x1eCAp8lkoagCHqeD/gvmNSoif6kCIjwvnCameePG3LQ1QBA+2FSuu
 E3KWFQADScwnAkMqhiqLZLVexFsyZwHkBYErjvx9V1MnJXEFPuKLC0rfCmJk60taIH0tWM
 5dvCvFg/XtMpUEvAN09ZZjooBRVIkBA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 93C1AB113;
 Tue, 26 Jan 2021 20:33:49 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 25/35] monitor: read existing connections on startup
Date: Tue, 26 Jan 2021 21:33:14 +0100
Message-Id: <20210126203324.23610-26-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_727903_6DC6C1CC 
X-CRM114-Status: GOOD (  14.59  )
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

Add discovery_ctrl_existed flag to the connection, to determine
whether a given (discovery) controller should be shut down on exit.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 conn-db.c | 1 +
 conn-db.h | 1 +
 monitor.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/conn-db.c b/conn-db.c
index 99d88da..07e4dde 100644
--- a/conn-db.c
+++ b/conn-db.c
@@ -301,6 +301,7 @@ int conndb_init_from_sysfs(void)
 
 			if (instance >= 0) {
 				ci->c.discovery_instance = instance;
+				ci->c.discovery_ctrl_existed = 1;
 				log(LOG_DEBUG, "found discovery controller %s\n",
 				    devices[i]->d_name);
 			}
diff --git a/conn-db.h b/conn-db.h
index c599c15..11c3502 100644
--- a/conn-db.h
+++ b/conn-db.h
@@ -11,6 +11,7 @@ struct nvme_connection {
 	int discovery_pending:1;
 	int did_discovery:1;
 	int successful_discovery:1;
+	int discovery_ctrl_existed:1;
 	union {
 		pid_t discovery_task;
 		int discovery_result;
diff --git a/monitor.c b/monitor.c
index ce772f3..5bd900b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -603,9 +603,11 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	}
 	ret = create_udev_monitor(&monitor);
 	if (ret == 0) {
+		conndb_init_from_sysfs();
 		ret = monitor_main_loop(monitor);
 		udev_monitor_unref(monitor);
 	}
+	conndb_free();
 	udev = udev_unref(udev);
 	if (mon_cfg.autoconnect && !mon_cfg.skip_udev_on_exit)
 		monitor_enable_udev_rules();
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
