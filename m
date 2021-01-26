Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28466C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C884E22B3F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C884E22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JV74aTN9z3T/NrmT43HJZnMJpJRZ7mKE+ivxcULbetE=; b=uKX+sgblPRGSxIi4wKS2nUdGs
	wUxUYcG+ro3tO0dbdfnCM4WwfSk3/DIm89YO+87M4EY6btgoazXjHen3LuoHJRPi7j87lhSKBxePS
	XcZUMy0ZKShN/QH14Qqw1r3vrQcuiff4WdJK19XKy+djCTt6OjFeKrA9SWp6RL67x7TMIQD4SUwpK
	5CW1WH+QHcNwN6HxQDyCQX/55uaO2n+2TcdyvlPmORoJaj1cFYpRLxGqH2Rcc+ieP3yQHIlqxOw+c
	VVDjVT6/YT6S2G/uBPnaGi2WrZ/dWFZ49JqCOjWogG2bSMEyAo55C7jDFJcK2S/5XDDPN0IzBIORA
	tIfln1b8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2n-0001EW-SL; Tue, 26 Jan 2021 20:34:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V25-0000wV-DR
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bwj8X+aW4qSPCfiUhnva86a55sOzLPMtMo4i5cKlmgg=;
 b=oRi2/MJqRLnV+Cux3r4m90k41Pr7pv4Dki46LLdF95vnuHm9AnHeykO3jQBVXShQUpZyZ8
 jhMOPXX8F5CWSv6jhCOp4lRqHBnRfxkMifpZTmr93pCrUe5HlHVmAPVotlFBqsPjTTQZpz
 nGVdDFwBhjwXxS7r2tMuY9J5fPeCmDA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3C044AFF2;
 Tue, 26 Jan 2021 20:33:45 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 10/35] fabrics: export do_discover(),
 build_options() and config
Date: Tue, 26 Jan 2021 21:32:59 +0100
Message-Id: <20210126203324.23610-11-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153349_748927_189EC0CB 
X-CRM114-Status: GOOD (  15.69  )
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

These functions will be called by the monitor code.
Also export BUF_SIZE as the size of argstr.

Being able to access struct config and the "cfg" variable
from fabrics.c is essential for the monitor to leverage the existing,
well tested code as much as possible.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 33 ++++-----------------------------
 fabrics.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 555b6b4..c1a4bb5 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -69,31 +69,7 @@ const char *conarg_traddr = "traddr";
 const char *conarg_trsvcid = "trsvcid";
 const char *conarg_host_traddr = "host_traddr";
 
-static struct config {
-	char *nqn;
-	char *transport;
-	char *traddr;
-	char *trsvcid;
-	char *host_traddr;
-	char *hostnqn;
-	char *hostid;
-	int  nr_io_queues;
-	int  nr_write_queues;
-	int  nr_poll_queues;
-	int  queue_size;
-	int  keep_alive_tmo;
-	int  reconnect_delay;
-	int  ctrl_loss_tmo;
-	int  tos;
-	char *raw;
-	char *device;
-	int  duplicate_connect;
-	int  disable_sqflow;
-	int  hdr_digest;
-	int  data_digest;
-	bool persistent;
-	bool matching_only;
-} cfg = { .ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO };
+struct config cfg = { .ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO };
 
 struct connect_args {
 	char *subsysnqn;
@@ -107,7 +83,6 @@ struct connect_args {
 
 struct connect_args *tracked_ctrls;
 
-#define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
@@ -226,7 +201,7 @@ static const char *cms_str(__u8 cm)
 	return arg_str(cms, ARRAY_SIZE(cms), cm);
 }
 
-static int do_discover(char *argstr, bool connect);
+int do_discover(char *argstr, bool connect);
 
 /*
  * parse strings with connect arguments to find a particular field.
@@ -855,7 +830,7 @@ add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
 	return 0;
 }
 
-static int build_options(char *argstr, int max_len, bool discover)
+int build_options(char *argstr, int max_len, bool discover)
 {
 	int len;
 
@@ -1264,7 +1239,7 @@ static void nvmf_get_host_identifiers(int ctrl_instance)
 	cfg.hostid = nvme_get_ctrl_attr(path, "hostid");
 }
 
-static int do_discover(char *argstr, bool connect)
+int do_discover(char *argstr, bool connect)
 {
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
 	char *dev_name;
diff --git a/fabrics.h b/fabrics.h
index f5b8eaf..ce965a3 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -10,4 +10,38 @@ extern int fabrics_connect(const char *desc, int argc, char **argv);
 extern int fabrics_disconnect(const char *desc, int argc, char **argv);
 extern int fabrics_disconnect_all(const char *desc, int argc, char **argv);
 
+/* Symbols used by monitor.c */
+
+struct config {
+	char *nqn;
+	char *transport;
+	char *traddr;
+	char *trsvcid;
+	char *host_traddr;
+	char *hostnqn;
+	char *hostid;
+	int  nr_io_queues;
+	int  nr_write_queues;
+	int  nr_poll_queues;
+	int  queue_size;
+	int  keep_alive_tmo;
+	int  reconnect_delay;
+	int  ctrl_loss_tmo;
+	int  tos;
+	char *raw;
+	char *device;
+	int  duplicate_connect;
+	int  disable_sqflow;
+	int  hdr_digest;
+	int  data_digest;
+	bool persistent;
+	bool matching_only;
+};
+extern struct config cfg;
+
+#define BUF_SIZE 4096
+
+int build_options(char *argstr, int max_len, bool discover);
+int do_discover(char *argstr, bool connect);
+
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
