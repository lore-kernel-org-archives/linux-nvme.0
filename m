Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C1C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:41:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3747C22DFB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3747C22DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iaw8UBWWPQSQe9Dvz4ETuRt+prZwZbcqX9RlkbnWmCc=; b=VTQjgO8Y37YN9xV2N+z8l7Kz4
	38IgaYefjLDU3PWfJQCIAC3a2/duJN44I9AeWqLe1lW2KqiZhhaOwHYIVZBwClSE6BgXwQqFITR6E
	RJ7/yLrJDM9yxqzYFmaiTpwUnmw7XMm8ybURMX1wHaHTQmsit8idWUwNaQSnx9bc8qG1jEdvCJq67
	lLkaiC8Pj5FVdU2kw1d++aPgOU320XFHhgu7foUxyNgmGFoAUry4VYAbQt0Z0p4r+VIoQ4rQ5oloK
	CYousNdpxNqr2XDjLbsw1SLcVVbpfDotK9+wSKTRGve/Gj8Wdzcn4M3lC4LzEQsr34s+cS1fRxhOF
	2OBIUTeRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V8X-00044s-Bo; Tue, 26 Jan 2021 20:40:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V5B-0002Qo-Oc
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 20:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=QwSHg6pQ3fsgrcxfgBEcRHIrJIF2pWvrGmk1msS4sfo=; b=v7Mfi+hMgbapMuQAz0rTOyuJ1m
 GbHl/pGyO/uApzBDCJ8ATQb6VyysxmlfgOdgrJLnQCSNasGarEFBlJCVJw/rn1k57BgGioKEEIR7w
 Ik+tleDexCQlBfsHDXWEYktcoOw9JqrLA5VDWR5T79TugiYMcteFu6790GHGZjgbVxiHsfCa7OJIz
 0DqETlwoYFTMOn08kFfWIUIUDdTKyEdGercqCuQvm5KAXF51NL4tLKJHRCU+ZS/RMzI7rO7+GUN2O
 kb1RrwJLuyVcBJCTaf8854mScfU06OGlGzjl0beMwxSDiOyyUxrP2OCUU0PO5Z0yYzLyP1oxDvJ8w
 ntQxpPEA==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l4V2O-006FGr-RD
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwSHg6pQ3fsgrcxfgBEcRHIrJIF2pWvrGmk1msS4sfo=;
 b=DQ3sMWEoUQd0egJNm3sthcVJtTVgwV2WtIzckMBvjYkJLapyLkGPbVCH5KCm/1Ot69Kwr1
 e7cl1b4c0vwQj/vILnZMrqSh14VK1MDz0SeoZcxtdoOjOJWMqPt1XtXmbDiCTHuzQqreDh
 pWhk3gm/fseXuEXoxfVgpacEkq+vUTI=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D0A43AF54;
 Tue, 26 Jan 2021 20:33:51 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 33/35] nvme-connect-all(1): fix documentation for --quiet/-S
Date: Tue, 26 Jan 2021 21:33:22 +0100
Message-Id: <20210126203324.23610-34-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_203459_436996_21C028AD 
X-CRM114-Status: GOOD (  11.28  )
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
