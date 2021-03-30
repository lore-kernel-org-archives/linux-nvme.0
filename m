Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C78C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:00:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70971619C5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70971619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UmyAlVjHMZuS44gu0SB8vVzYNTCZIc0Indg8gmxUFK0=; b=lddH4Ianv9P5uqHNR+Wu3tmOr
	KQppENiYfw1JIMm5w7x6spjgbALO8X35SincL5cQQhuUghDFMrp3NWBzTmpTITtyvM2vuU+bHL7y+
	nL+wvn12n9Hmqjwgqp110LY7V99FW27M3jLpSNaEKc2op45bMypDVI5A6vMElGMk66hvQX8SLPa0h
	cCa8aY3fHDzpUaoMPCP32y4rNPEUWo+yGmYCADJ5W8CPYB451WR7PvDbjwfcFiZXNDb+lUra0eDOv
	YsUUivG8VFQbavWo5YXfgpwvgqFpQ655/uEGBbRRjC6xao89ZxsVguvdLDIk6n3DvrU992OyaWU6N
	ZgjMy1FPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGmu-004Hes-AP; Tue, 30 Mar 2021 16:00:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGll-004HQn-PH
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18Tb5FqEvVCUDnkzD5baq+Gdve4H7Kv6cHUZMsM65BE=;
 b=HQzWx/mb8+8cTbVMqMitVVExQcpRdAhn2ut18he3qQheqCNS1ZRUTV4/5MiGEyCeAwj4Jd
 obV2bxo2amd0CZ7rPWdTTkDVUEA6EI3QvbY+QPXyMJZqlh3lcV3C294zRIUM0N/bpZ8bs7
 byDfsJu/uN9fFJdAdCen2hhVORyAhcg=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 899FEB02D;
 Tue, 30 Mar 2021 15:59:01 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 3/9] nvme-connect-all(1): fix documentation for --quiet/-S
Date: Tue, 30 Mar 2021 17:57:05 +0200
Message-Id: <20210330155711.8436-4-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165906_223500_F2E0EAAC 
X-CRM114-Status: GOOD (  11.51  )
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

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 Documentation/nvme-connect-all.1    |  8 ++++----
 Documentation/nvme-connect-all.html | 10 +++++-----
 Documentation/nvme-connect-all.txt  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/nvme-connect-all.1 b/Documentation/nvme-connect-all.1
index 91d6896..a53a017 100644
--- a/Documentation/nvme-connect-all.1
+++ b/Documentation/nvme-connect-all.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-connect-all
 .\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
 .\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
-.\"      Date: 10/20/2020
+.\"      Date: 01/20/2021
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-CONNECT\-ALL" "1" "10/20/2020" "NVMe" "NVMe Manual"
+.TH "NVME\-CONNECT\-ALL" "1" "01/20/2021" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -51,7 +51,7 @@ nvme-connect-all \- Discover and Connect to Fabrics controllers\&.
                 [\-\-queue\-size=<#>         | \-Q <#>]
                 [\-\-matching               | \-m]
                 [\-\-persistent             | \-p]
-                [\-\-quiet                  | \-q]
+                [\-\-quiet                  | \-S]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -193,7 +193,7 @@ If a traddr was specified on the command line or in the configuration file, only
 Don\(cqt remove the discovery controller after retrieving the discovery log page\&.
 .RE
 .PP
-\-q, \-\-quiet
+\-S, \-\-quiet
 .RS 4
 Suppress error messages\&.
 .RE
diff --git a/Documentation/nvme-connect-all.html b/Documentation/nvme-connect-all.html
index beae013..f779c7b 100644
--- a/Documentation/nvme-connect-all.html
+++ b/Documentation/nvme-connect-all.html
@@ -4,7 +4,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.10" />
+<meta name="generator" content="AsciiDoc" />
 <title>nvme-connect-all(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -436,7 +436,7 @@ thead, p.table.header {
 p.table {
   margin-top: 0;
 }
-/* Because the table frame attribute is overriden by CSS in most browsers. */
+/* Because the table frame attribute is overridden by CSS in most browsers. */
 div.tableblock > table[frame="void"] {
   border-style: none;
 }
@@ -768,7 +768,7 @@ nvme-connect-all(1) Manual Page
                 [--queue-size=&lt;#&gt;         | -Q &lt;#&gt;]
                 [--matching               | -m]
                 [--persistent             | -p]
-                [--quiet                  | -q]</pre>
+                [--quiet                  | -S]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -1048,7 +1048,7 @@ cellspacing="0" cellpadding="4">
 </p>
 </dd>
 <dt class="hdlist1">
--q
+-S
 </dt>
 <dt class="hdlist1">
 --quiet
@@ -1115,7 +1115,7 @@ nvme-connect(1)</p></div>
 <div id="footer">
 <div id="footer-text">
 Last updated
- 2020-10-20 16:47:21 PDT
+ 2021-01-20 23:40:57 CET
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-connect-all.txt b/Documentation/nvme-connect-all.txt
index 128f336..820dd6c 100644
--- a/Documentation/nvme-connect-all.txt
+++ b/Documentation/nvme-connect-all.txt
@@ -27,7 +27,7 @@ SYNOPSIS
 		[--queue-size=<#>         | -Q <#>]
 		[--matching               | -m]
 		[--persistent             | -p]
-		[--quiet                  | -q]
+		[--quiet                  | -S]
 
 DESCRIPTION
 -----------
@@ -154,7 +154,7 @@ OPTIONS
 	Don't remove the discovery controller after retrieving the discovery
 	log page.
 
--q::
+-S::
 --quiet::
 	Suppress error messages.
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
