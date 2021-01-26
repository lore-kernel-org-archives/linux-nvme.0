Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:38:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C4B207A8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C4B207A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5OyywPKqfb3CzW3xkJl7p+Nc0q1riG/3/BxjOVD3ZlM=; b=TQxyj52o8f2uGs+zwJswvWNUL
	gPUySIRDuAAdUjS8Ls/NkYJrfS0WiX7rXMNav6HK/H/19VErjAheg2DFAtToNbGN4AmipzR4B/mRm
	0NVJM9HW0zaFopuVPKBuV2MRvJOcSnWrBJT0zDhPsEfLsmweO0LRgM4XvZ7uYXRQw/KddThA5omqN
	aNimifyLNx8YBFSQUYbnX+ayXBOhsy1FaXQBEYO067RpciUMwn4a3YpLDf9sJa6lwn1vv1gehzitl
	Own+2/UFko2fmj4xRmt9W9TmABW22SWj7PaGXI4agb2L4b9sbp41IqdnN1PEog8kuBFIZogoHxwLn
	6xv10fCAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V65-0002nV-5W; Tue, 26 Jan 2021 20:37:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2E-00013j-K8
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hVBm7/Pk0a3/7wQOKYQKx9OHYJfsLSxo5V5wWSfas0=;
 b=EgqNsMmpOGDgpI6NEncgncd2xYsSbpC213khiQbh6ufxiK2b5RM8Te4VxwF7Nk2ZXfKj4h
 y5BBbQBmYQrVmYYoyyPRgVuKvRzfT53S/+1Gez8m3serx/wL0VmCQgbfZoA6McAW1ZaSej
 McOjnIwT8gsJsDhamBRymZM4ieENcio=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 83960B173;
 Tue, 26 Jan 2021 20:33:52 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 35/35] monitor: add option --keep/-K
Date: Tue, 26 Jan 2021 21:33:24 +0100
Message-Id: <20210126203324.23610-36-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153358_946174_2438D7E7 
X-CRM114-Status: GOOD (  20.06  )
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

With this option, "nvme monitor" will keep created discovery controllers
running even after it exits. If running in the initrd, this is will be
done automatically. That has the advantage that the new monitor instance
that will be started automatically after switching root can simply take
over the already created discovery controllers.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Documentation/nvme-monitor.1    | 28 +++++++++++++++++++++-------
 Documentation/nvme-monitor.html | 30 ++++++++++++++++++++++++------
 Documentation/nvme-monitor.txt  |  1 +
 monitor.c                       | 15 ++++++++++++++-
 4 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/nvme-monitor.1 b/Documentation/nvme-monitor.1
index 1578e4c..36b015d 100644
--- a/Documentation/nvme-monitor.1
+++ b/Documentation/nvme-monitor.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-monitor
 .\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
 .\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
-.\"      Date: 01/20/2021
+.\"      Date: 01/25/2021
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-MONITOR" "1" "01/20/2021" "NVMe" "NVMe Manual"
+.TH "NVME\-MONITOR" "1" "01/25/2021" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -33,9 +33,10 @@ nvme-monitor \- Monitor Discovery events and Discover and Connect automatically
 .sp
 .nf
 \fInvme discover\fR
-                [\-\-autoconnect            | \-A
-                [\-\-startup                | \-U
-                [\-\-persistent             | \-p
+                [\-\-autoconnect            | \-A]
+                [\-\-startup                | \-U]
+                [\-\-persistent             | \-p]
+                [\-\-keep                   | \-K]
                 [\-\-hostnqn=<hostnqn>      | \-q <hostnqn>]
                 [\-\-hostid=<hostid>        | \-I <hostid>]
                 [\-\-keep\-alive\-tmo=<#>     | \-k <#>]
@@ -118,9 +119,22 @@ option to make the Discovery Controllers persist after retrieving the Discovery
 This option has the same meaning as for
 \fInvme discover\fR; Discovery Controllers will remain after the Discovery Log Page has been retrieved\&. This is necessary for receiving AENs from the transport connection that the Discovery controller is associated with\&. Without this option, AENs can only be received and acted upon if the administrator manually creates persistent Discovery controller connections\&. When
 \fInvme monitor\fR
-terminates, it will attempt to take down all Discovery Controllers it has created (i\&.e\&. ones that didn\(cqt already exist when
+terminates and the, it will attempt to take down all Discovery Controllers it has created (i\&.e\&. ones that didn\(cqt already exist when
 \fInvme monitor\fR
-was started\&.
+was started (but see
+\fI\-\-keep\fR)\&.
+.RE
+.PP
+\-K, \-\-keep
+.RS 4
+Do not tear down created persistent discovery controllers when exiting\&. This option makes only sense together with
+\fI\-\-persistent\fR\&. When
+\fInvme monitor\fR
+detects that it is running in the initial RAM FS (initrd),
+\fI\-\-keep\fR
+is implicitly assumed, i\&.e\&. discovery connections are not stopped\&. This is because after switching from the initrd to the real root file system, another
+\fInvme monitor\fR
+instance will probably be started that can reuse the created controller instances\&.
 .RE
 .PP
 \-q <hostnqn>, \-\-hostnqn=<hostnqn>, \-I <hostid>, \-\-hostid=<hostid>, \-k <#>, \-\-keep\-alive\-tmo=<#>, \-c <#>, \-\-reconnect\-delay=<#>, \-l <#>, \-\-ctrl\-loss\-tmo=<#>, \-g, \-\-hdr\-digest, \-G, \-\-data\-digest, \-i <#>, \-\-nr\-io\-queues=<#>, \-W <#>, \-\-nr\-write\-queues=<#>, \-P <#>, \-\-nr\-poll\-queues=<#>, \-Q <#>, \-\-queue\-size=<#>, \-m, \-\-matching
diff --git a/Documentation/nvme-monitor.html b/Documentation/nvme-monitor.html
index c2b9a64..bd57a22 100644
--- a/Documentation/nvme-monitor.html
+++ b/Documentation/nvme-monitor.html
@@ -750,9 +750,10 @@ nvme-monitor(1) Manual Page
 <div class="sectionbody">
 <div class="verseblock">
 <pre class="content"><em>nvme discover</em>
-                [--autoconnect            | -A
-                [--startup                | -U
-                [--persistent             | -p
+                [--autoconnect            | -A]
+                [--startup                | -U]
+                [--persistent             | -p]
+                [--keep                   | -K]
                 [--hostnqn=&lt;hostnqn&gt;      | -q &lt;hostnqn&gt;]
                 [--hostid=&lt;hostid&gt;        | -I &lt;hostid&gt;]
                 [--keep-alive-tmo=&lt;#&gt;     | -k &lt;#&gt;]
@@ -863,9 +864,26 @@ commands for further background.</p></div>
         this option, AENs can only be received and acted upon if the
         administrator manually creates persistent Discovery controller
         connections.
-        When <em>nvme monitor</em> terminates, it will attempt to take down all
+        When <em>nvme monitor</em> terminates and the, it will attempt to take down all
         Discovery Controllers it has created (i.e. ones that didn&#8217;t already
-        exist when <em>nvme monitor</em> was started.
+        exist when <em>nvme monitor</em> was started (but see <em>--keep</em>).
+</p>
+</dd>
+<dt class="hdlist1">
+-K
+</dt>
+<dt class="hdlist1">
+--keep
+</dt>
+<dd>
+<p>
+        Do not tear down created persistent discovery controllers when
+        exiting. This option makes only sense together with <em>--persistent</em>.
+        When <em>nvme monitor</em> detects that it is running in the initial RAM FS
+        (initrd), <em>--keep</em> is implicitly assumed, i.e. discovery connections
+        are not stopped. This is because after switching from the initrd to
+        the real root file system, another <em>nvme monitor</em> instance will
+        probably be started that can reuse the created controller instances.
 </p>
 </dd>
 <dt class="hdlist1">
@@ -1042,7 +1060,7 @@ nvme-connect-all(1)</p></div>
 <div id="footer">
 <div id="footer-text">
 Last updated
- 2021-01-20 23:53:52 CET
+ 2021-01-25 22:35:29 CET
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-monitor.txt b/Documentation/nvme-monitor.txt
index 9232fab..517d036 100644
--- a/Documentation/nvme-monitor.txt
+++ b/Documentation/nvme-monitor.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 		[--autoconnect            | -A]
 		[--startup                | -U]
 		[--persistent             | -p]
+		[--keep                   | -K]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--hostid=<hostid>        | -I <hostid>]
 		[--keep-alive-tmo=<#>     | -k <#>]
diff --git a/monitor.c b/monitor.c
index ecf6706..40d1f29 100644
--- a/monitor.c
+++ b/monitor.c
@@ -44,6 +44,7 @@ static struct monitor_config {
 	bool autoconnect;
 	bool skip_udev_on_exit;
 	bool start_ctrls;
+	bool keep_ctrls;
 } mon_cfg;
 
 static struct udev *udev;
@@ -669,6 +670,7 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
 		OPT_FLAG("startup",        'U', &mon_cfg.start_ctrls, "start discovery controllers on startup"),
 		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connections"),
+		OPT_FLAG("keep",           'K', &mon_cfg.keep_ctrls,  "keep discovery controllers after exit"),
 		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
 		OPT_LIST("hostid",         'I', &cfg.hostid,          "user-defined hostid (if default not used)"),
 		OPT_INT("keep-alive-tmo",  'k', &cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
@@ -716,6 +718,11 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 	return ret;
 }
 
+static bool running_in_initrd(void)
+{
+	return access("/etc/initrd-release", F_OK) >= 0;
+}
+
 int aen_monitor(const char *desc, int argc, char **argv)
 {
 	int ret;
@@ -724,11 +731,16 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	ret = monitor_parse_opts(desc, argc, argv);
 	if (ret)
 		goto out;
+
 	ret = monitor_init_signals();
 	if (ret != 0) {
 		log(LOG_ERR, "monitor: failed to initialize signals: %m\n");
 		goto out;
 	}
+
+	if (running_in_initrd())
+		mon_cfg.keep_ctrls = true;
+
 	ret = create_udev_monitor(&monitor);
 	if (ret == 0) {
 		conndb_init_from_sysfs();
@@ -739,7 +751,8 @@ int aen_monitor(const char *desc, int argc, char **argv)
 	}
 
 	conndb_for_each(monitor_kill_discovery_task, NULL);
-	if (mon_cfg.autoconnect || mon_cfg.start_ctrls)
+	if ((mon_cfg.autoconnect || mon_cfg.start_ctrls) &&
+	    !mon_cfg.keep_ctrls)
 		conndb_for_each(monitor_remove_discovery_ctrl, NULL);
 	conndb_free();
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
