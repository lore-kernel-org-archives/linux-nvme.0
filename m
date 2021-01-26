Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94324C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABBD22A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABBD22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AFQireQwMRbj2gD1WFEgFDFB+cUAP6d+Hx5rCRNYSzQ=; b=asmE4gVBFJM69mjYAZDRZuoTv
	8U284fQFvcfx5NBfDC6hDbxrFffKlZUqDu5m6mIJ0EWpSPwGEA0iImU5UxbohQOYx25l9W6uWnXeF
	6acBQpoWqiC0H4x0n0RDXlpJj60Kr41kpkC6Iunl4sbkalqI7vZLskguaLkqc0/pbd2j9EHRNkPjS
	FEocyxXFO03xGPU0MphSojiZUyFGprSJm8GdRlMp2gI7h0maHUqk06MBjkRNoOUzKp36XEvQeI04i
	aW2NnQYvuD+JUmA2Qua5FRzCYWHahgEnmvEMeLHGd/wx2tUUGU9KcUQ227aUOVN8o1C3CTZLudoiJ
	MH6ayYBkA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2x-0001JG-SH; Tue, 26 Jan 2021 20:34:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V27-0000xt-OC
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VK/l5zAvwm8inAMss6WOMX6X6G8CIrYH4Ctbz5VZy0A=;
 b=P4Kz9g+PpeO2tAZ0z+ztG8KzJxsYpJwnQDV94LVvAKPCv3C/kCv7QHiirHrecWLFw/PXz/
 4S0unpINXy6lACwrRj75RSimVEwekqOMs3mWPgg75OEEnKEZqgKoiyh+kPFEhetXs6IxtF
 B+pcNxt5rBtkX7f0FCrFjll4M12Besk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 02E70B04C;
 Tue, 26 Jan 2021 20:33:47 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 16/35] monitor: reset children's signal disposition
Date: Tue, 26 Jan 2021 21:33:05 +0100
Message-Id: <20210126203324.23610-17-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153351_950374_0847C485 
X-CRM114-Status: GOOD (  16.70  )
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
 monitor.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 69c8333..9375a14 100644
--- a/monitor.c
+++ b/monitor.c
@@ -100,6 +100,8 @@ static void monitor_int_handler(int sig)
 	must_exit = 1;
 }
 
+static sigset_t orig_sigmask;
+
 static int monitor_init_signals(void)
 {
 	sigset_t mask;
@@ -110,7 +112,7 @@ static int monitor_init_signals(void)
 	 * for events.
 	 */
 	sigfillset(&mask);
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+	if (sigprocmask(SIG_BLOCK, &mask, &orig_sigmask) == -1)
 		return -errno;
 	if (sigaction(SIGTERM, &sa, NULL) == -1)
 		return -errno;
@@ -119,6 +121,26 @@ static int monitor_init_signals(void)
 	return 0;
 }
 
+static int child_reset_signals(void)
+{
+	int err = 0;
+	struct sigaction sa = { .sa_handler = SIG_DFL, };
+
+	if (sigaction(SIGTERM, &sa, NULL) == -1)
+		err = errno;
+	if (sigaction(SIGINT, &sa, NULL) == -1 && !err)
+		err = errno;
+	if (sigaction(SIGCHLD, &sa, NULL) == -1 && !err)
+		err = errno;
+
+	if (sigprocmask(SIG_SETMASK, &orig_sigmask, NULL) == -1 && !err)
+		err = errno;
+
+	if (err)
+		log(LOG_ERR, "error resetting signal handlers and mask\n");
+	return -err;
+}
+
 static int monitor_get_fc_uev_props(struct udev_device *ud,
 				    char *traddr, size_t tra_sz,
 				    char *host_traddr, size_t htra_sz)
@@ -176,8 +198,12 @@ static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
 	if (pid == -1) {
 		log(LOG_ERR, "failed to fork discovery task: %m");
 		return -errno;
-	} else if (pid > 0)
+	} else if (pid > 0) {
+		log(LOG_DEBUG, "started discovery task %ld\n", (long)pid);
 		return 0;
+	}
+
+	child_reset_signals();
 
 	log(LOG_NOTICE, "starting %s discovery for %s==>%s(%s)\n",
 	    transport, host_traddr, traddr, trsvcid ? trsvcid : "none");
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
