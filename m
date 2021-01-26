Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C1C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B78B22A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B78B22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J74qIPLxAGLDy402N4tGNFdEzCN+DRz+cCeW1ojV2l0=; b=H51trAHqH1cmMiV74xtFr7yEX
	vWOYXUHJ6Z3Q2LcdPT+UivhLIx46TibEmg+4jU93F1BcbCOuiXUUghgPJX0rQYOinVqSUgGaPblHE
	moKgRX0PGvb/wxOhddhNVWdJ6XMMp9z/LeykDYcN4vLXJ6sOKOONlZ1ZkQlj66Ly9nMW7MeVCbAo3
	qWZf3scUS/wWuTbs5osmZzUNCpFESDJb2561Wfb2khoyy9zDNo6FoUqRMkpOM5/glSBEf3evLWIcC
	HJaEAM8YGic77h1Pe4PPIuxDEfCNZrSuYArSlzj5KNOGsh0qynn9nyloPcLe6DBjA1DV5L/bzv4Kk
	5GX/MqT2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V4a-00028R-G5; Tue, 26 Jan 2021 20:36:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-00011C-UA
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUe49oZMjp+F7W9pFZXltLsKuoGYCEzMbRwP9B6ZRVY=;
 b=SUsKToGGvnmY0w0iR9ClmPQwpeee/+NQwPvQM2e+m2UGaccBp/D8Kk7WMT2LWgNa8UGuFz
 n7e2YT6W7cJMF1snYl5HsIrd6mei0zq/39MTUsVYexcEBdM44Gdf/3kR8rPtKRmo5NHsnJ
 frdBVh7d12BdqeqPN9fp7XlmROVVC/Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 011F5AE89;
 Tue, 26 Jan 2021 20:33:51 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 30/35] monitor: add connection property options from
 connect-all
Date: Tue, 26 Jan 2021 21:33:19 +0100
Message-Id: <20210126203324.23610-31-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_727084_9227A5FD 
X-CRM114-Status: GOOD (  11.97  )
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

This code is simply copied from fabrics_discover(). That's possible
because we simply access the fabric "cfg" variable directly.
These parameters are assumed to be constant over the runtime
of the monitor.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/monitor.c b/monitor.c
index 37c9ace..ecf6706 100644
--- a/monitor.c
+++ b/monitor.c
@@ -669,6 +669,19 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
 		OPT_FLAG("startup",        'U', &mon_cfg.start_ctrls, "start discovery controllers on startup"),
 		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connections"),
+		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
+		OPT_LIST("hostid",         'I', &cfg.hostid,          "user-defined hostid (if default not used)"),
+		OPT_INT("keep-alive-tmo",  'k', &cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
+		OPT_INT("reconnect-delay", 'c', &cfg.reconnect_delay, "reconnect timeout period in seconds"),
+		OPT_INT("ctrl-loss-tmo",   'l', &cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
+		OPT_INT("tos",             'T', &cfg.tos,             "type of service"),
+		OPT_FLAG("hdr_digest",     'g', &cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
+		OPT_FLAG("data_digest",    'G', &cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+		OPT_INT("nr-io-queues",    'i', &cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
+		OPT_INT("nr-write-queues", 'W', &cfg.nr_write_queues, "number of write queues to use (default 0)"),
+		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
+		OPT_INT("queue-size",      'Q', &cfg.queue_size,      "number of io queue elements to use (default 128)"),
+		OPT_FLAG("matching",       'm', &cfg.matching_only,   "connect only records matching the traddr"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
 		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
 		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
