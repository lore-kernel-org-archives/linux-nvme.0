Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ECBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B822B2C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B822B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CSADaNZEIIvZDzrgE5nOHBplpt6YHc2FOGj0deY4Z7M=; b=xkCT/E/jPVoybzDTPcm894hdl
	0YYft3YAQT9OVeDUOnlIjL9yqIHiXAhH8B5jxaTe3l5a8ecAiqyVYrA9LPXjDeFe/TqXlRm1qE2Ct
	GxTo66VkWUkvIGBuYl/5121W0I+2dvPT2s9su6sjX0oXE2myEfsOEPJ5MvA/fCu7Pg1SEfZ3NucKZ
	vLzdNSqh5HcwBzreth4E2UTUlbyepgPYiyxnQiYOnTGCKbNt74dCkFdOqS6y16xH4eR4g0rhvoRvZ
	08yzZO5IA+VdewMhkRpoq6ce+aFj4iTI3eW/RN2NMtWl1hOQCK3MPDB9bNb947wIPcYmbk3mqCcw8
	XJ9AcJ66A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V4g-0002Ac-9v; Tue, 26 Jan 2021 20:36:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00011D-UB
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRbaWDwEhqpHjKft3lvTna/hZXxpZSl27HWcomxOhEQ=;
 b=r9d/lCY3RYy0WYwI5n9wUW+eeZBhuGFD2VhuZBfNDuROzRK2ezW5x8F3igpe3+kaytq3Pq
 aUl4f7czPBoDGrPoq1jpEKT3j9MQeqzWOq31XVKl3VL45GdEicYf79DNQfjO2a7EW3TP4k
 i5DdbBx+esJpOP0DbzVRkMnrrdx+EC4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B9752B153;
 Tue, 26 Jan 2021 20:33:50 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 29/35] monitor: kill running discovery tasks on exit
Date: Tue, 26 Jan 2021 21:33:18 +0100
Message-Id: <20210126203324.23610-30-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_725032_5E24E510 
X-CRM114-Status: GOOD (  14.73  )
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

Make sure discovery tasks terminate when the main process terminates.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/monitor.c b/monitor.c
index e2c2568..37c9ace 100644
--- a/monitor.c
+++ b/monitor.c
@@ -630,6 +630,34 @@ static int monitor_remove_discovery_ctrl(struct nvme_connection *co,
 	return CD_CB_OK;
 }
 
+static int monitor_kill_discovery_task(struct nvme_connection *co,
+				       void *arg __attribute__((unused)))
+{
+	int wstatus;
+	pid_t pid, wpid = -1;
+
+	if (co->status != CS_DISC_RUNNING)
+		return CD_CB_OK;
+
+	pid = co->discovery_task;
+	co->status = CS_FAILED;
+	if (kill(co->discovery_task, SIGTERM) == -1) {
+		log(LOG_ERR, "failed to send SIGTERM to pid %ld: %m\n",
+		    (long)pid);
+		wpid = waitpid(pid, &wstatus, WNOHANG);
+	} else {
+		log(LOG_DEBUG, "sent SIGTERM to pid %ld, waiting\n", (long)pid);
+		wpid = waitpid(pid, &wstatus, 0);
+	}
+	if (wpid != pid) {
+		log(LOG_ERR, "failed to wait for %ld: %m\n", (long)pid);
+		return CD_CB_ERR;
+	} else {
+		log(LOG_DEBUG, "child %ld terminated\n", (long)pid);
+		return CD_CB_OK;
+	}
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -696,9 +724,12 @@ int aen_monitor(const char *desc, int argc, char **argv)
 		ret = monitor_main_loop(monitor);
 		udev_monitor_unref(monitor);
 	}
+
+	conndb_for_each(monitor_kill_discovery_task, NULL);
 	if (mon_cfg.autoconnect || mon_cfg.start_ctrls)
 		conndb_for_each(monitor_remove_discovery_ctrl, NULL);
 	conndb_free();
+
 	udev = udev_unref(udev);
 	if (mon_cfg.autoconnect && !mon_cfg.skip_udev_on_exit)
 		monitor_enable_udev_rules();
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
