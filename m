Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C44AC433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F26C22B2C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F26C22B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xGaWDArn5L5SxM1NNLnZLpA/S5fpZz4bAVulweS9y44=; b=WuonSH1HIhr0iYg7MvgjHnPfM
	pxgu8UKqRMpEAo42/aqD2x5hMsEO0+dkuo1W5YGRZb/fbh4kAlI3dC8UD6XI+Lq1G1yg5UKfLXW3t
	NhScr9axGQE0MmxDD6Q51ajqkwSP6fPZ3xr2bX82d/B6b2vJh2HYjFeJ5FD/jRx5nWGmrxzXImbex
	X8/vl3lfCT5J6+fYHmycT1VJI9AEeghpBn0d0vfMdp1no3gwlHzMqP+JMaQXjHlaTLKz7l96ZqwJG
	vfrtIg5XY8LRXJI3SPsfgRox3cKZIxbfnMdlZy4hblOBcKCkz1TSAl31SWZHRUOZvuf1TsLqLSPM9
	oME0WGTOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2r-0001Fu-07; Tue, 26 Jan 2021 20:34:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V25-0000wc-Ol
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9IsCxXcHFLm1099xm4TVGG3wgrlY+AD0dwq2fFCBn0=;
 b=TGgXl0JeQ0vyg6Gd3ftZzmtXkzYU1jSgDd0WPo7ZDb7p+Ud8p2GHXFdtVoAyKmTX/XZbFg
 VBLtFQ60P38wIQfHQ7+wYf+0R1wg8+4x251Idzw6PIkwucz3PW6iy8TqzkhprX8L1RSEUj
 x1DkZsHXTqgDRGL+Jv9A/dmqFfRmiX0=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7E432AFF3;
 Tue, 26 Jan 2021 20:33:45 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 11/35] monitor: add option -A / --autoconnect
Date: Tue, 26 Jan 2021 21:33:00 +0100
Message-Id: <20210126203324.23610-12-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153349_986694_17ED40EB 
X-CRM114-Status: GOOD (  12.73  )
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

With this option, the monitor will try to connect to newly discovered
controllers.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor.c b/monitor.c
index a7afa1c..ecf3be2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -31,6 +31,10 @@
 #define LOG_FUNCNAME 1
 #include "log.h"
 
+static struct monitor_config {
+	bool autoconnect;
+} mon_cfg;
+
 static struct udev *udev;
 
 static void close_ptr(int *p)
@@ -177,6 +181,7 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 	bool debug = false;
 	int ret;
 	OPT_ARGS(opts) = {
+		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
 		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
 		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
