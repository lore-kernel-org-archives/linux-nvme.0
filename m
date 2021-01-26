Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F093C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C968B22A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C968B22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ECE90ububJTZItM+HUm9NQ1o0U7QiM+rcbYP/edXV7g=; b=GXnxyiSLV5Hx5tgEJrz2HzRf7
	nPKdp/chKWi60ZWlN09VTnn4wn7aGh0IQhft53OgHebmK/lSdpYNfPWSpOL8Vc6sXFiO01qpiUpFm
	sEH3PlhAnWtgmV+3CkxJG/QG9jHf8nbtt8eKB17RYc89tKq/cxfaB6wod6mD4PyUgeTGw2EG1uQMm
	s/KudTnjlM+GsA/+PlYHidsMCQrCU9InKYROy0pWT2XpLycp2OHFfAwrt9r4pAPs4tL7cZEvbdKFF
	8SXLJ00acoaOR4ypGY/uyLqJxqIPVpdIKmaX+hexs9GxaCYXD5my9v9Xtlq/oKy19+HCPXXbehteH
	/bmIk4/Pw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V27-0000xk-HR; Tue, 26 Jan 2021 20:33:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V21-0000tq-HU
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prTdWZQjrs7iWVeyA/qvEZg708fI7kNTEvBhs/yqJOA=;
 b=kuuGsEsw7id7ylnnyJC7JGNsr2r3U/RkJ8RFA9p2kTRxWq1tW5n47gaO0VHr0f0dJPoqLr
 Txr/7xEeAcpcJ/dk9K1VWYrnaNJPCGc9QAJTfjUTsb5EHSLOt71Pc3Np4+cRM1CQmRQH6U
 4RFAHxHqAQ5zeWfk4bu9na12exbmTw8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4BDFBAF4D;
 Tue, 26 Jan 2021 20:33:43 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 03/35] monitor: initialize signal handling
Date: Tue, 26 Jan 2021 21:32:52 +0100
Message-Id: <20210126203324.23610-4-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153345_748586_C0258778 
X-CRM114-Status: GOOD (  16.11  )
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

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/monitor.c b/monitor.c
index 626827c..c7f4d85 100644
--- a/monitor.c
+++ b/monitor.c
@@ -16,8 +16,10 @@
  */
 
 #include <stddef.h>
+#include <stdio.h>
 #include <errno.h>
 #include <libudev.h>
+#include <signal.h>
 
 #include "nvme-status.h"
 #include "monitor.h"
@@ -59,14 +61,46 @@ static int create_udev_monitor(struct udev_monitor **pmon)
 	return 0;
 }
 
+static sig_atomic_t must_exit;
+
+static void monitor_int_handler(int sig)
+{
+	must_exit = 1;
+}
+
+static int monitor_init_signals(void)
+{
+	sigset_t mask;
+	struct sigaction sa = { .sa_handler = monitor_int_handler, };
+
+	/*
+	 * Block all signals. They will be unblocked when we wait
+	 * for events.
+	 */
+	sigfillset(&mask);
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		return -errno;
+	if (sigaction(SIGTERM, &sa, NULL) == -1)
+		return -errno;
+	if (sigaction(SIGINT, &sa, NULL) == -1)
+		return -errno;
+	return 0;
+}
+
 int aen_monitor(const char *desc, int argc, char **argv)
 {
 	int ret;
 	struct udev_monitor *monitor;
 
+	ret = monitor_init_signals();
+	if (ret != 0) {
+		fprintf(stderr, "monitor: failed to initialize signals: %m\n");
+		goto out;
+	}
 	ret = create_udev_monitor(&monitor);
 	if (ret == 0)
 		udev_monitor_unref(monitor);
 	udev = udev_unref(udev);
+out:
 	return nvme_status_to_errno(ret, true);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
