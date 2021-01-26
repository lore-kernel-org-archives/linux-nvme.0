Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0EDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C62E22A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C62E22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lErWjUWH+zsijbeWpixlIleO+thU8g4Hxbn70QibisQ=; b=TUZ+oZmlscFddH3TKlr5D6gV6
	gE8aTgYE9fnuMC6sxDw5a3KNF71aEH05zLdwvVZDN86iJH5cGxTc0ZLMdoPvlUpcJWXMQOx7gQogG
	wv8OvKhXt8gbA2KUThxlpdJIpax+UiBjoy8BsewQGWha5lF3PolKA1cLHy0cyfOoYWXqzlo8RZNsj
	GwM0W3ng5YIc+YPRiHryoknlMaK9ItE0g7wJEl7vpM3bNaV0Vmomhstq6zgYZveDep3Tat1WAkrcA
	lQXzDzCThMAlemGNTPhsd3lY2LpeOgc6bORR/igFPZrrMa6O83XZe1GieBryUwitQfgwQ8ca78bKq
	ADS6cmI/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V24-0000vT-Cv; Tue, 26 Jan 2021 20:33:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V21-0000tp-Ge
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDPxmb7N5GPyJVG6bHvefP4y3DKjjdR/CMPICNm6KGA=;
 b=P7D6Y79lGiF5nloqjvYfMt44DtM7DOAQ5aLIm654Numyspe1a8cSB2z5VPL83ix4Zrumms
 uk+PBxjg26kFspPKglk4g1XJmjoRU7OePO8VtX9PtoTQdrPxK0jtnlC9xBguS3wmWWdb4s
 0wXLbb8K8YDixf3b22G9XmPUIMfBaJM=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0DA9CAF00;
 Tue, 26 Jan 2021 20:33:43 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 02/35] monitor: create udev socket
Date: Tue, 26 Jan 2021 21:32:51 +0100
Message-Id: <20210126203324.23610-3-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153345_747994_FEC08385 
X-CRM114-Status: GOOD (  16.16  )
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
 monitor.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index dae4975..626827c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -15,14 +15,58 @@
  * This file implements a simple monitor for NVMe-related uevents.
  */
 
+#include <stddef.h>
 #include <errno.h>
+#include <libudev.h>
 
 #include "nvme-status.h"
 #include "monitor.h"
 
-int aen_monitor(const char *desc, int argc, char **argv)
+static struct udev *udev;
+
+static void cleanup_monitor(struct udev_monitor **pmon)
 {
-	/* Handle as unimplemented for now */
-	return nvme_status_to_errno(-ENOTTY, true);
+	if (*pmon) {
+		udev_monitor_unref(*pmon);
+		*pmon = NULL;
+	}
 }
 
+static int create_udev_monitor(struct udev_monitor **pmon)
+{
+	struct udev_monitor *mon __attribute((cleanup(cleanup_monitor))) = NULL;
+	int ret;
+
+	if (!udev) {
+		udev = udev_new();
+		if (!udev)
+			return -ENOMEM;
+	}
+	mon = udev_monitor_new_from_netlink(udev, "kernel");
+	if (!mon)
+		return errno ? -errno : -ENOMEM;
+
+	/*
+	 * This fails in unpriviliged mode. Use the same value as udevd.
+	 * We may able to decrease this buffer size later.
+	 */
+	(void)udev_monitor_set_receive_buffer_size(mon, 128*1024*1024);
+	ret = udev_monitor_enable_receiving(mon);
+	if (ret < 0)
+		return ret;
+	*pmon = mon;
+	mon = NULL;
+	return 0;
+}
+
+int aen_monitor(const char *desc, int argc, char **argv)
+{
+	int ret;
+	struct udev_monitor *monitor;
+
+	ret = create_udev_monitor(&monitor);
+	if (ret == 0)
+		udev_monitor_unref(monitor);
+	udev = udev_unref(udev);
+	return nvme_status_to_errno(ret, true);
+}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
