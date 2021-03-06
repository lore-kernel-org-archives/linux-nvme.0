Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40831C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:42:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34F464F5F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34F464F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lQxc/1bJSEhRNhX8MSKeuzQB3d46/A1iigx4DpGq1mo=; b=oOT2KF0/POumRpRfpCHIi1E0X
	f5h9KFJxqM8QMe03ow57M2g/gqCvSDG62S22k6VfK0ZJKhei7g6ZWOho+UUXMLoJxV4Z8pt6AziAu
	YVxXUk8xSwj49P8rE7y5xqCPQPG7T6qSM8Dkf20BpqF8mALmJJq18nSjZFxg5ukpBYMriV7CvGFTW
	ZYwtxpYWh3eUvfPKhlBztboLCjghNHaKwYjx59dbgCqOzhQMNCabYSbLOoIjxv0crT3bwVLArYqc2
	4QjPgqtVOtYY1cwbbdMf3DE0PicwsP7XQQKqQFK5ALgQWuoUt8gn/83ahl3Kv9/LuOKX0ZtuO4oHF
	k0axf51cw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL0u-00HXIx-RU; Sat, 06 Mar 2021 00:41:53 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwb-00HViX-Lr
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UybllqgxXtxItkcj4jW5WcxN7mHRfTY4YqRzMyvwnac=;
 b=t2TZ/I1JE4Fof1YD+lo49YocLs7yGT949cQO6wZsDOJ8Vuz3xVwwAv7WNb/A/qq51FDyiL
 tymt902Ph1J2aZG8ODDt40NainVPewL+JSXRJf/2SufEjmEBoemz4YeEFEhwNMnfTU63C0
 XQUpdSoxmhbUYNiZy+SlK0+TSR295qo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C9A28AF26;
 Sat,  6 Mar 2021 00:37:17 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 07/16] monitor: kill running discovery tasks on exit
Date: Sat,  6 Mar 2021 01:36:50 +0100
Message-Id: <20210306003659.21207-8-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003722_684816_F2344C9D 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

Make sure running discovery tasks terminate when the main process terminates.
---
 monitor.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/monitor.c b/monitor.c
index f7517cb..b17fca0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -471,6 +471,34 @@ out:
 	return ELOOP_CONTINUE;
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
+		msg(LOG_ERR, "failed to send SIGTERM to pid %ld: %m\n",
+		    (long)pid);
+		wpid = waitpid(pid, &wstatus, WNOHANG);
+	} else {
+		msg(LOG_DEBUG, "sent SIGTERM to pid %ld, waiting\n", (long)pid);
+		wpid = waitpid(pid, &wstatus, 0);
+	}
+	if (wpid != pid) {
+		msg(LOG_ERR, "failed to wait for %ld: %m\n", (long)pid);
+		return CD_CB_ERR;
+	} else {
+		msg(LOG_DEBUG, "child %ld terminated\n", (long)pid);
+		return CD_CB_OK;
+	}
+}
+
 static int monitor_parse_opts(const char *desc, int argc, char **argv)
 {
 	bool quiet = false;
@@ -578,6 +606,8 @@ int aen_monitor(const char *desc, int argc, char **argv)
 
 	ret = event_loop(mon_dsp, &wait_mask, handle_epoll_err);
 
+	conndb_for_each(monitor_kill_discovery_task, NULL);
+	conndb_free();
 out:
 	free_dispatcher(mon_dsp);
 	return nvme_status_to_errno(ret, true);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
