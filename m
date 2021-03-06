Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2683C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:53:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6123D65077
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6123D65077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZxAeinuo6osnoYEdZ8zbSi7CCR8jeR10tfakuU8yh6k=; b=rLFFrma4C5HA2e6lQIoy24wUS
	bx3g8ZNFgErAxgxO9c/5833VYqSmmsEDjopE+ofLWL7cbky6XCoy3sF1E5iX9onxGyCAuUXS2Ej0V
	irBMg+sDE6OghDAIZSGcW88xSl3lMGLxzO6vVneYQS03sIFAh3tmT+j97SsmfChDHU6swS8+yFLed
	0zWgftcOVHa/5/SGfDIuSgVcJ0shCZCJjh/KNZRqw5j8528naz94Nod41duNH9LHFz1bbqEcn1oWp
	21Vn9KC6/az2k5zJpLCUdHWj3wrsuNXxDRSH82lp9j76R7YmUoiZXbg792mLaVbTg2USXK3IDmNhm
	6bBZyXagw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lILC3-00HauM-O9; Sat, 06 Mar 2021 00:53:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwf-00HVkG-Ml
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wq27Nn+ryzchd0rYU8bPsS5Gxwqk4hr8+XxP7NqMPFA=;
 b=LHtv7zaa4CeVMsxrnlCK+bBm/sCOUQgWYVCCHYZmdyKuHmoZpj4rYGTJlsbqf3qVxAxGQF
 tMIG2qxRg9hJ/Ly+L3cKIaK9XvLbQBTmn7p6vorGFpAqhFqTv5ZE7lNDYC1mE73KrJ1+mS
 AgjDwVmxn4yLh8HmAaHXnYldem8maf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 01C5FAF5C;
 Sat,  6 Mar 2021 00:37:21 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 16/16] nvme-monitor(1): add man page for nvme-monitor
Date: Sat,  6 Mar 2021 01:36:59 +0100
Message-Id: <20210306003659.21207-17-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003727_118091_99AC83FC 
X-CRM114-Status: GOOD (  16.75  )
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

Add documentation for the nvme-monitor command.
---
 Documentation/cmds-main.txt     |    4 +
 Documentation/nvme-monitor.1    |  180 ++++++
 Documentation/nvme-monitor.html | 1018 +++++++++++++++++++++++++++++++
 Documentation/nvme-monitor.txt  |  144 +++++
 4 files changed, 1346 insertions(+)
 create mode 100644 Documentation/nvme-monitor.1
 create mode 100644 Documentation/nvme-monitor.html
 create mode 100644 Documentation/nvme-monitor.txt

diff --git a/Documentation/cmds-main.txt b/Documentation/cmds-main.txt
index 46df03d..d058a54 100644
--- a/Documentation/cmds-main.txt
+++ b/Documentation/cmds-main.txt
@@ -168,3 +168,7 @@ linknvme:nvme-disconnect-all[1]::
 
 linknvme:nvme-get-property[1]::
 	Reads and shows NVMe-over-Fabrics controller property
+
+linknvme:nvme-monitor[1]::
+	Monitor Discovery events and Discover and Connect automatically
+
diff --git a/Documentation/nvme-monitor.1 b/Documentation/nvme-monitor.1
new file mode 100644
index 0000000..c87988e
--- /dev/null
+++ b/Documentation/nvme-monitor.1
@@ -0,0 +1,180 @@
+'\" t
+.\"     Title: nvme-monitor
+.\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
+.\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
+.\"      Date: 02/25/2021
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-MONITOR" "1" "02/25/2021" "NVMe" "NVMe Manual"
+.\" -----------------------------------------------------------------
+.\" * Define some portability stuff
+.\" -----------------------------------------------------------------
+.\" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.\" http://bugs.debian.org/507673
+.\" http://lists.gnu.org/archive/html/groff/2009-02/msg00013.html
+.\" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
+.\" -----------------------------------------------------------------
+.\" * set default formatting
+.\" -----------------------------------------------------------------
+.\" disable hyphenation
+.nh
+.\" disable justification (adjust text to left margin only)
+.ad l
+.\" -----------------------------------------------------------------
+.\" * MAIN CONTENT STARTS HERE *
+.\" -----------------------------------------------------------------
+.SH "NAME"
+nvme-monitor \- Monitor Discovery events and Discover and Connect automatically
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme discover\fR
+                [\-\-no\-auto                | \-N]
+                [\-\-hostnqn=<hostnqn>      | \-q <hostnqn>]
+                [\-\-hostid=<hostid>        | \-I <hostid>]
+                [\-\-keep\-alive\-tmo=<#>     | \-k <#>]
+                [\-\-reconnect\-delay=<#>    | \-c <#>]
+                [\-\-ctrl\-loss\-tmo=<#>      | \-l <#>]
+                [\-\-hdr\-digest             | \-g]
+                [\-\-data\-digest            | \-G]
+                [\-\-nr\-io\-queues=<#>       | \-i <#>]
+                [\-\-nr\-write\-queues=<#>    | \-W <#>]
+                [\-\-nr\-poll\-queues=<#>     | \-P <#>]
+                [\-\-queue\-size=<#>         | \-Q <#>]
+                [\-\-matching               | \-m]
+                [\-\-persistent             | \-p]
+                [\-\-silent                 | \-S]
+                [\-\-verbose                | \-v]
+                [\-\-debug                  | \-D]
+                [\-\-timestamps             | \-t]
+.fi
+.SH "DESCRIPTION"
+.sp
+Listen to Discovery events (Asynchronous Event Notifications, AENs) on NVMe\-over\-Fabrics (NVMeoF) Discovery Controllers and for other events related to NVMeoF Discovery, and optionally connect to newly discovered controllers\&.
+.sp
+If no parameters are given, then \fInvme monitor\fR listens to Discovery\-related udev events (uevents)\&. If an event is received, it connects to the Discovery Controller and performs the equivalent of an \fInvme connect\-all\fR on the associated transport address\&. When run through a systemd service in rhis mode, the monitor can be used as an alternative to the udev\-rule based auto\-activation of NVMeoF connections\&. If this is done, it is recommended to deactivate the udev rule\-based autoconnection mechanism, e\&.g\&. by creating a symlink /run/udev/rules\&.d/70\-nvmf\-autoconnect\&.rules to /dev/null\&. Otherwise both mechanisms will run discovery in parallel, which causes unnecessary system activity spurious error messages\&.
+.sp
+Currently, the following event types are supported:
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+"Discovery Log Page Change" Asynchronous Event Notifications (AENs) delivered via persistent connections to NVMeoF discovery controllers connected to the discovery service (nqn\&.2014\-08\&.org\&.nvmexpress\&.discovery)\&.
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+FC\-NVMe auto\-connect uevents sent when the FibreChannel transport discovers N_Ports offering NVMe services\&.
+.RE
+.sp
+See the documentation for the nvme\-connect\-all(1) and nvme\-discover(1) commands for further background\&.
+.SH "OPTIONS"
+.PP
+\-N, \-\-no\-connect
+.RS 4
+If this option is given,
+\fInvme monitor\fR
+will not attempt to connect to newly discovered controllers\&. Instead, information about found discovery log entries will be printed to stdout (in other words, instead of
+\fInvme connect\-all\fR, the monitor only executes
+\fInvme discover\fR
+for detected discovery controllers)\&.
+.RE
+.PP
+\-C, \-\-cleanup
+.RS 4
+Disconnect discovery controllers when the program exits\&. This affects only discovery controller connections created while the program was running\&.
+.RE
+.PP
+\-q <hostnqn>, \-\-hostnqn=<hostnqn>, \-I <hostid>, \-\-hostid=<hostid>, \-k <#>, \-\-keep\-alive\-tmo=<#>, \-c <#>, \-\-reconnect\-delay=<#>, \-l <#>, \-\-ctrl\-loss\-tmo=<#>, \-g, \-\-hdr\-digest, \-G, \-\-data\-digest, \-i <#>, \-\-nr\-io\-queues=<#>, \-W <#>, \-\-nr\-write\-queues=<#>, \-P <#>, \-\-nr\-poll\-queues=<#>, \-Q <#>, \-\-queue\-size=<#>, \-m, \-\-matching
+.RS 4
+These options have the same meaning as for
+\fInvme connect\-all\fR\&. See the man page nvme\-connect\-all(1) for details\&.
+.RE
+.PP
+\-S, \-\-silent
+.RS 4
+Only print warnings and severe error messages\&. Do not log discoveries and newly created controllers\&.
+.RE
+.PP
+\-v, \-\-verbose
+.RS 4
+Log informational messages\&. This option overrides
+\fI\-\-silent\fR\&.
+.RE
+.PP
+\-D, \-\-debug
+.RS 4
+Log informational and debug messages\&. This option overrieds
+\fI\-\-silent\fR
+and
+\fI\-\-verbose\fR\&.
+.RE
+.PP
+\-t, \-\-timestamps
+.RS 4
+Add timestamps to log messages\&.
+.RE
+.SH "EXAMPLES"
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Listen to FC\-NVME events and AENs, creating persistent Discovery Controllers on the way, and automatically connect to all discovered controllers:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme monitor
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Like the above, but print more log messages, remove created discovery controller connections on exit, and use a non\-standard host NQN:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme monitor \-\-verbose \-\-cleanup \-\-hostqn=host1\-rogue\-nqn
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "SEE ALSO"
+.sp
+nvme\-discover(1) nvme\-connect\-all(1)
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-monitor.html b/Documentation/nvme-monitor.html
new file mode 100644
index 0000000..bcc8f93
--- /dev/null
+++ b/Documentation/nvme-monitor.html
@@ -0,0 +1,1018 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc" />
+<title>nvme-monitor(1)</title>
+<style type="text/css">
+/* Shared CSS for AsciiDoc xhtml11 and html5 backends */
+
+/* Default font. */
+body {
+  font-family: Georgia,serif;
+}
+
+/* Title font. */
+h1, h2, h3, h4, h5, h6,
+div.title, caption.title,
+thead, p.table.header,
+#toctitle,
+#author, #revnumber, #revdate, #revremark,
+#footer {
+  font-family: Arial,Helvetica,sans-serif;
+}
+
+body {
+  margin: 1em 5% 1em 5%;
+}
+
+a {
+  color: blue;
+  text-decoration: underline;
+}
+a:visited {
+  color: fuchsia;
+}
+
+em {
+  font-style: italic;
+  color: navy;
+}
+
+strong {
+  font-weight: bold;
+  color: #083194;
+}
+
+h1, h2, h3, h4, h5, h6 {
+  color: #527bbd;
+  margin-top: 1.2em;
+  margin-bottom: 0.5em;
+  line-height: 1.3;
+}
+
+h1, h2, h3 {
+  border-bottom: 2px solid silver;
+}
+h2 {
+  padding-top: 0.5em;
+}
+h3 {
+  float: left;
+}
+h3 + * {
+  clear: left;
+}
+h5 {
+  font-size: 1.0em;
+}
+
+div.sectionbody {
+  margin-left: 0;
+}
+
+hr {
+  border: 1px solid silver;
+}
+
+p {
+  margin-top: 0.5em;
+  margin-bottom: 0.5em;
+}
+
+ul, ol, li > p {
+  margin-top: 0;
+}
+ul > li     { color: #aaa; }
+ul > li > * { color: black; }
+
+.monospaced, code, pre {
+  font-family: "Courier New", Courier, monospace;
+  font-size: inherit;
+  color: navy;
+  padding: 0;
+  margin: 0;
+}
+pre {
+  white-space: pre-wrap;
+}
+
+#author {
+  color: #527bbd;
+  font-weight: bold;
+  font-size: 1.1em;
+}
+#email {
+}
+#revnumber, #revdate, #revremark {
+}
+
+#footer {
+  font-size: small;
+  border-top: 2px solid silver;
+  padding-top: 0.5em;
+  margin-top: 4.0em;
+}
+#footer-text {
+  float: left;
+  padding-bottom: 0.5em;
+}
+#footer-badges {
+  float: right;
+  padding-bottom: 0.5em;
+}
+
+#preamble {
+  margin-top: 1.5em;
+  margin-bottom: 1.5em;
+}
+div.imageblock, div.exampleblock, div.verseblock,
+div.quoteblock, div.literalblock, div.listingblock, div.sidebarblock,
+div.admonitionblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+div.admonitionblock {
+  margin-top: 2.0em;
+  margin-bottom: 2.0em;
+  margin-right: 10%;
+  color: #606060;
+}
+
+div.content { /* Block element content. */
+  padding: 0;
+}
+
+/* Block element titles. */
+div.title, caption.title {
+  color: #527bbd;
+  font-weight: bold;
+  text-align: left;
+  margin-top: 1.0em;
+  margin-bottom: 0.5em;
+}
+div.title + * {
+  margin-top: 0;
+}
+
+td div.title:first-child {
+  margin-top: 0.0em;
+}
+div.content div.title:first-child {
+  margin-top: 0.0em;
+}
+div.content + div.title {
+  margin-top: 0.0em;
+}
+
+div.sidebarblock > div.content {
+  background: #ffffee;
+  border: 1px solid #dddddd;
+  border-left: 4px solid #f0f0f0;
+  padding: 0.5em;
+}
+
+div.listingblock > div.content {
+  border: 1px solid #dddddd;
+  border-left: 5px solid #f0f0f0;
+  background: #f8f8f8;
+  padding: 0.5em;
+}
+
+div.quoteblock, div.verseblock {
+  padding-left: 1.0em;
+  margin-left: 1.0em;
+  margin-right: 10%;
+  border-left: 5px solid #f0f0f0;
+  color: #888;
+}
+
+div.quoteblock > div.attribution {
+  padding-top: 0.5em;
+  text-align: right;
+}
+
+div.verseblock > pre.content {
+  font-family: inherit;
+  font-size: inherit;
+}
+div.verseblock > div.attribution {
+  padding-top: 0.75em;
+  text-align: left;
+}
+/* DEPRECATED: Pre version 8.2.7 verse style literal block. */
+div.verseblock + div.attribution {
+  text-align: left;
+}
+
+div.admonitionblock .icon {
+  vertical-align: top;
+  font-size: 1.1em;
+  font-weight: bold;
+  text-decoration: underline;
+  color: #527bbd;
+  padding-right: 0.5em;
+}
+div.admonitionblock td.content {
+  padding-left: 0.5em;
+  border-left: 3px solid #dddddd;
+}
+
+div.exampleblock > div.content {
+  border-left: 3px solid #dddddd;
+  padding-left: 0.5em;
+}
+
+div.imageblock div.content { padding-left: 0; }
+span.image img { border-style: none; vertical-align: text-bottom; }
+a.image:visited { color: white; }
+
+dl {
+  margin-top: 0.8em;
+  margin-bottom: 0.8em;
+}
+dt {
+  margin-top: 0.5em;
+  margin-bottom: 0;
+  font-style: normal;
+  color: navy;
+}
+dd > *:first-child {
+  margin-top: 0.1em;
+}
+
+ul, ol {
+    list-style-position: outside;
+}
+ol.arabic {
+  list-style-type: decimal;
+}
+ol.loweralpha {
+  list-style-type: lower-alpha;
+}
+ol.upperalpha {
+  list-style-type: upper-alpha;
+}
+ol.lowerroman {
+  list-style-type: lower-roman;
+}
+ol.upperroman {
+  list-style-type: upper-roman;
+}
+
+div.compact ul, div.compact ol,
+div.compact p, div.compact p,
+div.compact div, div.compact div {
+  margin-top: 0.1em;
+  margin-bottom: 0.1em;
+}
+
+tfoot {
+  font-weight: bold;
+}
+td > div.verse {
+  white-space: pre;
+}
+
+div.hdlist {
+  margin-top: 0.8em;
+  margin-bottom: 0.8em;
+}
+div.hdlist tr {
+  padding-bottom: 15px;
+}
+dt.hdlist1.strong, td.hdlist1.strong {
+  font-weight: bold;
+}
+td.hdlist1 {
+  vertical-align: top;
+  font-style: normal;
+  padding-right: 0.8em;
+  color: navy;
+}
+td.hdlist2 {
+  vertical-align: top;
+}
+div.hdlist.compact tr {
+  margin: 0;
+  padding-bottom: 0;
+}
+
+.comment {
+  background: yellow;
+}
+
+.footnote, .footnoteref {
+  font-size: 0.8em;
+}
+
+span.footnote, span.footnoteref {
+  vertical-align: super;
+}
+
+#footnotes {
+  margin: 20px 0 20px 0;
+  padding: 7px 0 0 0;
+}
+
+#footnotes div.footnote {
+  margin: 0 0 5px 0;
+}
+
+#footnotes hr {
+  border: none;
+  border-top: 1px solid silver;
+  height: 1px;
+  text-align: left;
+  margin-left: 0;
+  width: 20%;
+  min-width: 100px;
+}
+
+div.colist td {
+  padding-right: 0.5em;
+  padding-bottom: 0.3em;
+  vertical-align: top;
+}
+div.colist td img {
+  margin-top: 0.3em;
+}
+
+@media print {
+  #footer-badges { display: none; }
+}
+
+#toc {
+  margin-bottom: 2.5em;
+}
+
+#toctitle {
+  color: #527bbd;
+  font-size: 1.1em;
+  font-weight: bold;
+  margin-top: 1.0em;
+  margin-bottom: 0.1em;
+}
+
+div.toclevel0, div.toclevel1, div.toclevel2, div.toclevel3, div.toclevel4 {
+  margin-top: 0;
+  margin-bottom: 0;
+}
+div.toclevel2 {
+  margin-left: 2em;
+  font-size: 0.9em;
+}
+div.toclevel3 {
+  margin-left: 4em;
+  font-size: 0.9em;
+}
+div.toclevel4 {
+  margin-left: 6em;
+  font-size: 0.9em;
+}
+
+span.aqua { color: aqua; }
+span.black { color: black; }
+span.blue { color: blue; }
+span.fuchsia { color: fuchsia; }
+span.gray { color: gray; }
+span.green { color: green; }
+span.lime { color: lime; }
+span.maroon { color: maroon; }
+span.navy { color: navy; }
+span.olive { color: olive; }
+span.purple { color: purple; }
+span.red { color: red; }
+span.silver { color: silver; }
+span.teal { color: teal; }
+span.white { color: white; }
+span.yellow { color: yellow; }
+
+span.aqua-background { background: aqua; }
+span.black-background { background: black; }
+span.blue-background { background: blue; }
+span.fuchsia-background { background: fuchsia; }
+span.gray-background { background: gray; }
+span.green-background { background: green; }
+span.lime-background { background: lime; }
+span.maroon-background { background: maroon; }
+span.navy-background { background: navy; }
+span.olive-background { background: olive; }
+span.purple-background { background: purple; }
+span.red-background { background: red; }
+span.silver-background { background: silver; }
+span.teal-background { background: teal; }
+span.white-background { background: white; }
+span.yellow-background { background: yellow; }
+
+span.big { font-size: 2em; }
+span.small { font-size: 0.6em; }
+
+span.underline { text-decoration: underline; }
+span.overline { text-decoration: overline; }
+span.line-through { text-decoration: line-through; }
+
+div.unbreakable { page-break-inside: avoid; }
+
+
+/*
+ * xhtml11 specific
+ *
+ * */
+
+div.tableblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+div.tableblock > table {
+  border: 3px solid #527bbd;
+}
+thead, p.table.header {
+  font-weight: bold;
+  color: #527bbd;
+}
+p.table {
+  margin-top: 0;
+}
+/* Because the table frame attribute is overridden by CSS in most browsers. */
+div.tableblock > table[frame="void"] {
+  border-style: none;
+}
+div.tableblock > table[frame="hsides"] {
+  border-left-style: none;
+  border-right-style: none;
+}
+div.tableblock > table[frame="vsides"] {
+  border-top-style: none;
+  border-bottom-style: none;
+}
+
+
+/*
+ * html5 specific
+ *
+ * */
+
+table.tableblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+thead, p.tableblock.header {
+  font-weight: bold;
+  color: #527bbd;
+}
+p.tableblock {
+  margin-top: 0;
+}
+table.tableblock {
+  border-width: 3px;
+  border-spacing: 0px;
+  border-style: solid;
+  border-color: #527bbd;
+  border-collapse: collapse;
+}
+th.tableblock, td.tableblock {
+  border-width: 1px;
+  padding: 4px;
+  border-style: solid;
+  border-color: #527bbd;
+}
+
+table.tableblock.frame-topbot {
+  border-left-style: hidden;
+  border-right-style: hidden;
+}
+table.tableblock.frame-sides {
+  border-top-style: hidden;
+  border-bottom-style: hidden;
+}
+table.tableblock.frame-none {
+  border-style: hidden;
+}
+
+th.tableblock.halign-left, td.tableblock.halign-left {
+  text-align: left;
+}
+th.tableblock.halign-center, td.tableblock.halign-center {
+  text-align: center;
+}
+th.tableblock.halign-right, td.tableblock.halign-right {
+  text-align: right;
+}
+
+th.tableblock.valign-top, td.tableblock.valign-top {
+  vertical-align: top;
+}
+th.tableblock.valign-middle, td.tableblock.valign-middle {
+  vertical-align: middle;
+}
+th.tableblock.valign-bottom, td.tableblock.valign-bottom {
+  vertical-align: bottom;
+}
+
+
+/*
+ * manpage specific
+ *
+ * */
+
+body.manpage h1 {
+  padding-top: 0.5em;
+  padding-bottom: 0.5em;
+  border-top: 2px solid silver;
+  border-bottom: 2px solid silver;
+}
+body.manpage h2 {
+  border-style: none;
+}
+body.manpage div.sectionbody {
+  margin-left: 3em;
+}
+
+@media print {
+  body.manpage div#toc { display: none; }
+}
+
+
+</style>
+<script type="text/javascript">
+/*<![CDATA[*/
+var asciidoc = {  // Namespace.
+
+/////////////////////////////////////////////////////////////////////
+// Table Of Contents generator
+/////////////////////////////////////////////////////////////////////
+
+/* Author: Mihai Bazon, September 2002
+ * http://students.infoiasi.ro/~mishoo
+ *
+ * Table Of Content generator
+ * Version: 0.4
+ *
+ * Feel free to use this script under the terms of the GNU General Public
+ * License, as long as you do not remove or alter this notice.
+ */
+
+ /* modified by Troy D. Hanson, September 2006. License: GPL */
+ /* modified by Stuart Rackham, 2006, 2009. License: GPL */
+
+// toclevels = 1..4.
+toc: function (toclevels) {
+
+  function getText(el) {
+    var text = "";
+    for (var i = el.firstChild; i != null; i = i.nextSibling) {
+      if (i.nodeType == 3 /* Node.TEXT_NODE */) // IE doesn't speak constants.
+        text += i.data;
+      else if (i.firstChild != null)
+        text += getText(i);
+    }
+    return text;
+  }
+
+  function TocEntry(el, text, toclevel) {
+    this.element = el;
+    this.text = text;
+    this.toclevel = toclevel;
+  }
+
+  function tocEntries(el, toclevels) {
+    var result = new Array;
+    var re = new RegExp('[hH]([1-'+(toclevels+1)+'])');
+    // Function that scans the DOM tree for header elements (the DOM2
+    // nodeIterator API would be a better technique but not supported by all
+    // browsers).
+    var iterate = function (el) {
+      for (var i = el.firstChild; i != null; i = i.nextSibling) {
+        if (i.nodeType == 1 /* Node.ELEMENT_NODE */) {
+          var mo = re.exec(i.tagName);
+          if (mo && (i.getAttribute("class") || i.getAttribute("className")) != "float") {
+            result[result.length] = new TocEntry(i, getText(i), mo[1]-1);
+          }
+          iterate(i);
+        }
+      }
+    }
+    iterate(el);
+    return result;
+  }
+
+  var toc = document.getElementById("toc");
+  if (!toc) {
+    return;
+  }
+
+  // Delete existing TOC entries in case we're reloading the TOC.
+  var tocEntriesToRemove = [];
+  var i;
+  for (i = 0; i < toc.childNodes.length; i++) {
+    var entry = toc.childNodes[i];
+    if (entry.nodeName.toLowerCase() == 'div'
+     && entry.getAttribute("class")
+     && entry.getAttribute("class").match(/^toclevel/))
+      tocEntriesToRemove.push(entry);
+  }
+  for (i = 0; i < tocEntriesToRemove.length; i++) {
+    toc.removeChild(tocEntriesToRemove[i]);
+  }
+
+  // Rebuild TOC entries.
+  var entries = tocEntries(document.getElementById("content"), toclevels);
+  for (var i = 0; i < entries.length; ++i) {
+    var entry = entries[i];
+    if (entry.element.id == "")
+      entry.element.id = "_toc_" + i;
+    var a = document.createElement("a");
+    a.href = "#" + entry.element.id;
+    a.appendChild(document.createTextNode(entry.text));
+    var div = document.createElement("div");
+    div.appendChild(a);
+    div.className = "toclevel" + entry.toclevel;
+    toc.appendChild(div);
+  }
+  if (entries.length == 0)
+    toc.parentNode.removeChild(toc);
+},
+
+
+/////////////////////////////////////////////////////////////////////
+// Footnotes generator
+/////////////////////////////////////////////////////////////////////
+
+/* Based on footnote generation code from:
+ * http://www.brandspankingnew.net/archive/2005/07/format_footnote.html
+ */
+
+footnotes: function () {
+  // Delete existing footnote entries in case we're reloading the footnodes.
+  var i;
+  var noteholder = document.getElementById("footnotes");
+  if (!noteholder) {
+    return;
+  }
+  var entriesToRemove = [];
+  for (i = 0; i < noteholder.childNodes.length; i++) {
+    var entry = noteholder.childNodes[i];
+    if (entry.nodeName.toLowerCase() == 'div' && entry.getAttribute("class") == "footnote")
+      entriesToRemove.push(entry);
+  }
+  for (i = 0; i < entriesToRemove.length; i++) {
+    noteholder.removeChild(entriesToRemove[i]);
+  }
+
+  // Rebuild footnote entries.
+  var cont = document.getElementById("content");
+  var spans = cont.getElementsByTagName("span");
+  var refs = {};
+  var n = 0;
+  for (i=0; i<spans.length; i++) {
+    if (spans[i].className == "footnote") {
+      n++;
+      var note = spans[i].getAttribute("data-note");
+      if (!note) {
+        // Use [\s\S] in place of . so multi-line matches work.
+        // Because JavaScript has no s (dotall) regex flag.
+        note = spans[i].innerHTML.match(/\s*\[([\s\S]*)]\s*/)[1];
+        spans[i].innerHTML =
+          "[<a id='_footnoteref_" + n + "' href='#_footnote_" + n +
+          "' title='View footnote' class='footnote'>" + n + "</a>]";
+        spans[i].setAttribute("data-note", note);
+      }
+      noteholder.innerHTML +=
+        "<div class='footnote' id='_footnote_" + n + "'>" +
+        "<a href='#_footnoteref_" + n + "' title='Return to text'>" +
+        n + "</a>. " + note + "</div>";
+      var id =spans[i].getAttribute("id");
+      if (id != null) refs["#"+id] = n;
+    }
+  }
+  if (n == 0)
+    noteholder.parentNode.removeChild(noteholder);
+  else {
+    // Process footnoterefs.
+    for (i=0; i<spans.length; i++) {
+      if (spans[i].className == "footnoteref") {
+        var href = spans[i].getElementsByTagName("a")[0].getAttribute("href");
+        href = href.match(/#.*/)[0];  // Because IE return full URL.
+        n = refs[href];
+        spans[i].innerHTML =
+          "[<a href='#_footnote_" + n +
+          "' title='View footnote' class='footnote'>" + n + "</a>]";
+      }
+    }
+  }
+},
+
+install: function(toclevels) {
+  var timerId;
+
+  function reinstall() {
+    asciidoc.footnotes();
+    if (toclevels) {
+      asciidoc.toc(toclevels);
+    }
+  }
+
+  function reinstallAndRemoveTimer() {
+    clearInterval(timerId);
+    reinstall();
+  }
+
+  timerId = setInterval(reinstall, 500);
+  if (document.addEventListener)
+    document.addEventListener("DOMContentLoaded", reinstallAndRemoveTimer, false);
+  else
+    window.onload = reinstallAndRemoveTimer;
+}
+
+}
+asciidoc.install();
+/*]]>*/
+</script>
+</head>
+<body class="manpage">
+<div id="header">
+<h1>
+nvme-monitor(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-monitor -
+   Monitor Discovery events and Discover and Connect automatically
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme discover</em>
+                [--no-auto                | -N]
+                [--hostnqn=&lt;hostnqn&gt;      | -q &lt;hostnqn&gt;]
+                [--hostid=&lt;hostid&gt;        | -I &lt;hostid&gt;]
+                [--keep-alive-tmo=&lt;#&gt;     | -k &lt;#&gt;]
+                [--reconnect-delay=&lt;#&gt;    | -c &lt;#&gt;]
+                [--ctrl-loss-tmo=&lt;#&gt;      | -l &lt;#&gt;]
+                [--hdr-digest             | -g]
+                [--data-digest            | -G]
+                [--nr-io-queues=&lt;#&gt;       | -i &lt;#&gt;]
+                [--nr-write-queues=&lt;#&gt;    | -W &lt;#&gt;]
+                [--nr-poll-queues=&lt;#&gt;     | -P &lt;#&gt;]
+                [--queue-size=&lt;#&gt;         | -Q &lt;#&gt;]
+                [--matching               | -m]
+                [--persistent             | -p]
+                [--silent                 | -S]
+                [--verbose                | -v]
+                [--debug                  | -D]
+                [--timestamps             | -t]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Listen to Discovery events (Asynchronous Event Notifications, AENs) on
+NVMe-over-Fabrics (NVMeoF) Discovery Controllers and for other events related
+to NVMeoF Discovery, and optionally connect to newly discovered controllers.</p></div>
+<div class="paragraph"><p>If no parameters are given, then <em>nvme monitor</em> listens to Discovery-related
+udev events (uevents). If an event is received, it connects to the Discovery
+Controller and performs the equivalent of an <em>nvme connect-all</em> on the
+associated transport address. When run through a systemd service in rhis
+mode, the monitor can be used as an alternative to the udev-rule based
+auto-activation of NVMeoF connections. If this is done, it is recommended
+to deactivate the udev rule-based autoconnection mechanism, e.g. by creating
+a symlink <code>/run/udev/rules.d/70-nvmf-autoconnect.rules</code> to <code>/dev/null</code>.
+Otherwise both mechanisms will run discovery in parallel, which causes
+unnecessary system activity spurious error messages.</p></div>
+<div class="paragraph"><p>Currently, the following event types are supported:</p></div>
+<div class="ulist"><ul>
+<li>
+<p>
+"Discovery Log Page Change" Asynchronous Event Notifications (AENs)
+  delivered via persistent connections to NVMeoF discovery controllers
+  connected to the discovery service (<code>nqn.2014-08.org.nvmexpress.discovery</code>).
+</p>
+</li>
+<li>
+<p>
+FC-NVMe auto-connect uevents sent when the FibreChannel transport discovers
+  N_Ports offering NVMe services.
+</p>
+</li>
+</ul></div>
+<div class="paragraph"><p>See the documentation for the nvme-connect-all(1) and nvme-discover(1)
+commands for further background.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-N
+</dt>
+<dt class="hdlist1">
+--no-connect
+</dt>
+<dd>
+<p>
+        If this option is given, <em>nvme monitor</em> will not  attempt to connect to
+        newly discovered controllers. Instead, information about found
+        discovery log entries will be printed to stdout (in other words, instead of
+        <em>nvme connect-all</em>, the monitor only executes <em>nvme discover</em> for
+        detected discovery controllers).
+</p>
+</dd>
+<dt class="hdlist1">
+-C
+</dt>
+<dt class="hdlist1">
+--cleanup
+</dt>
+<dd>
+<p>
+        Disconnect discovery controllers when the program exits. This affects
+        only discovery controller connections created while the program was running.
+</p>
+</dd>
+<dt class="hdlist1">
+-q &lt;hostnqn&gt;
+</dt>
+<dt class="hdlist1">
+--hostnqn=&lt;hostnqn&gt;
+</dt>
+<dt class="hdlist1">
+-I &lt;hostid&gt;
+</dt>
+<dt class="hdlist1">
+--hostid=&lt;hostid&gt;
+</dt>
+<dt class="hdlist1">
+-k &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--keep-alive-tmo=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-c &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--reconnect-delay=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-l &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--ctrl-loss-tmo=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-g
+</dt>
+<dt class="hdlist1">
+--hdr-digest
+</dt>
+<dt class="hdlist1">
+-G
+</dt>
+<dt class="hdlist1">
+--data-digest
+</dt>
+<dt class="hdlist1">
+-i &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--nr-io-queues=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-W &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--nr-write-queues=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-P &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--nr-poll-queues=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-Q &lt;#&gt;
+</dt>
+<dt class="hdlist1">
+--queue-size=&lt;#&gt;
+</dt>
+<dt class="hdlist1">
+-m
+</dt>
+<dt class="hdlist1">
+--matching
+</dt>
+<dd>
+<p>
+        These options have the same meaning as for <em>nvme connect-all</em>. See the
+        man page nvme-connect-all(1) for details.
+</p>
+</dd>
+<dt class="hdlist1">
+-S
+</dt>
+<dt class="hdlist1">
+--silent
+</dt>
+<dd>
+<p>
+        Only print warnings and severe error messages. Do not log discoveries
+        and newly created controllers.
+</p>
+</dd>
+<dt class="hdlist1">
+-v
+</dt>
+<dt class="hdlist1">
+--verbose
+</dt>
+<dd>
+<p>
+        Log informational messages. This option overrides <em>--silent</em>.
+</p>
+</dd>
+<dt class="hdlist1">
+-D
+</dt>
+<dt class="hdlist1">
+--debug
+</dt>
+<dd>
+<p>
+        Log informational and debug messages. This option overrieds <em>--silent</em>
+        and <em>--verbose</em>.
+</p>
+</dd>
+<dt class="hdlist1">
+-t
+</dt>
+<dt class="hdlist1">
+--timestamps
+</dt>
+<dd>
+<p>
+        Add timestamps to log messages.
+</p>
+</dd>
+</dl></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Listen to FC-NVME events and AENs, creating persistent Discovery Controllers
+on the way, and automatically connect to all discovered controllers:
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme monitor</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Like the above, but print more log messages, remove created discovery controller
+connections on exit, and use a non-standard host NQN:
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme monitor --verbose --cleanup --hostqn=host1-rogue-nqn</code></pre>
+</div></div>
+</li>
+</ul></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_see_also">SEE ALSO</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>nvme-discover(1)
+nvme-connect-all(1)</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated
+ 2021-02-25 00:42:13 CET
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-monitor.txt b/Documentation/nvme-monitor.txt
new file mode 100644
index 0000000..79f9c03
--- /dev/null
+++ b/Documentation/nvme-monitor.txt
@@ -0,0 +1,144 @@
+nvme-monitor(1)
+===============
+
+NAME
+----
+nvme-monitor - Monitor Discovery events and Discover and Connect automatically
+
+SYNOPSIS
+--------
+[verse]
+'nvme discover'
+		[--no-auto                | -N]
+		[--hostnqn=<hostnqn>      | -q <hostnqn>]
+		[--hostid=<hostid>        | -I <hostid>]
+		[--keep-alive-tmo=<#>     | -k <#>]
+		[--reconnect-delay=<#>    | -c <#>]
+		[--ctrl-loss-tmo=<#>      | -l <#>]
+		[--hdr-digest             | -g]
+		[--data-digest            | -G]
+		[--nr-io-queues=<#>       | -i <#>]
+		[--nr-write-queues=<#>    | -W <#>]
+		[--nr-poll-queues=<#>     | -P <#>]
+		[--queue-size=<#>         | -Q <#>]
+		[--matching               | -m]
+		[--persistent             | -p]
+		[--silent                 | -S]
+		[--verbose                | -v]
+		[--debug                  | -D]
+		[--timestamps             | -t]
+
+DESCRIPTION
+-----------
+Listen to Discovery events (Asynchronous Event Notifications, AENs) on
+NVMe-over-Fabrics (NVMeoF) Discovery Controllers and for other events related
+to NVMeoF Discovery, and optionally connect to newly discovered controllers.
+
+If no parameters are given, then 'nvme monitor' listens to Discovery-related
+udev events (uevents). If an event is received, it connects to the Discovery
+Controller and performs the equivalent of an 'nvme connect-all' on the
+associated transport address. When run through a systemd service in this
+mode, the monitor can be used as an alternative to the udev-rule based
+auto-activation of NVMeoF connections. If this is done, it is recommended
+to deactivate the udev rule-based autoconnection mechanism, e.g. by creating
+a symlink `/run/udev/rules.d/70-nvmf-autoconnect.rules` to `/dev/null`.
+Otherwise both mechanisms will run discovery in parallel, which causes
+unnecessary system activity and spurious error messages.
+
+Currently, the following event types are supported:
+
+- "Discovery Log Page Change" Asynchronous Event Notifications (AENs)
+  delivered via persistent connections to NVMeoF discovery controllers
+  connected to the discovery service (`nqn.2014-08.org.nvmexpress.discovery`).
+
+- FC-NVMe auto-connect uevents sent when the FibreChannel transport discovers
+  N_Ports offering NVMe services.
+
+See the documentation for the nvme-connect-all(1) and nvme-discover(1)
+commands for further background.
+
+OPTIONS
+-------
+
+-N::
+--no-connect::
+	If this option is given, 'nvme monitor' will not  attempt to connect to
+	newly discovered controllers. Instead, information about found
+	discovery log entries will be printed to stdout (in other words, instead of
+	'nvme connect-all', the monitor only executes 'nvme discover' for
+	detected discovery controllers).
+
+-C::
+--cleanup::
+	Disconnect discovery controllers when the program exits. This affects
+	only discovery controller connections created while the program was running.
+
+-q <hostnqn>::
+--hostnqn=<hostnqn>::
+-I <hostid>::
+--hostid=<hostid>::
+-k <#>::
+--keep-alive-tmo=<#>::
+-c <#>::
+--reconnect-delay=<#>::
+-l <#>::
+--ctrl-loss-tmo=<#>::
+-g::
+--hdr-digest::
+-G::
+--data-digest::
+-i <#>::
+--nr-io-queues=<#>::
+-W <#>::
+--nr-write-queues=<#>::
+-P <#>::
+--nr-poll-queues=<#>::
+-Q <#>::
+--queue-size=<#>::
+-m::
+--matching::
+	These options have the same meaning as for 'nvme connect-all'. See the
+	man page nvme-connect-all(1) for details.
+
+-S::
+--silent::
+	Only print warnings and severe error messages. Do not log discoveries
+	and newly created controllers.
+
+-v::
+--verbose::
+	Log informational messages. This option overrides '--silent'.
+
+-D::
+--debug::
+	Log informational and debug messages. This option overrieds '--silent'
+	and '--verbose'.
+
+-t::
+--timestamps::
+	Add timestamps to log messages.
+
+EXAMPLES
+--------
+* Listen to FC-NVME events and AENs, creating persistent Discovery Controllers
+on the way, and automatically connect to all discovered controllers:
++
+-------------
+# nvme monitor
+-------------
++
+* Like the above, but print more log messages, remove created discovery controller
+connections on exit, and use a non-standard host NQN:
++
+------------
+# nvme monitor --verbose --cleanup --hostqn=host1-rogue-nqn
+------------
+
+SEE ALSO
+--------
+nvme-discover(1)
+nvme-connect-all(1)
+
+NVME
+----
+Part of the nvme-user suite
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
