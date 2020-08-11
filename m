Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2337206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bgQdWX8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2337206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9YVzsRQLMQC3ccJA9s2ArxLiUitmCy/a3017AW5KGTU=; b=bgQdWX8H3ztiNFkD68yOYfeSX
	pvlc7nbdbYl3QCSupYGAAARZKhgAf3BFEWi65okPtIWpglHtW4nwoCK+ufslfXZuT4rIYqeY87vnx
	Ku3LwoNZGoKnymxJZlP5Vl1CKa7jJoU2poumjcRkN0WVaqzV7Ur1xM/91mUyD6nk/27YQRO7U6+cy
	2Y8x/MQjJEBOEOHTF2H1v7P3lk+WmSmCcZ5nXRuoUCWqFHwHGrHdaZzvxCBYVEEgkJ/zQa4cjphe5
	T/6ZzKCVmbNiy9kNiYwlnrDkcurncI8X/Y8WJei9QeClf2269sJIS1rmhs+57dSSE927ZTDBwsJZW
	gBDaQ3jAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOg-0005LZ-8H; Tue, 11 Aug 2020 21:01:26 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bOZ-0005IX-6O
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:20 +0000
Received: by mail-pf1-f195.google.com with SMTP id x25so4917385pff.4
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AHRa+YkmLQcTpMTxlPvWnCrn2hDL5XCMaLx+f7rGfws=;
 b=OaBBILu9uyX/STJhRDNzzqJbknXOTRWBQLCeclBi7RHrUHIJsNmWtUtN4MMpSbQcgy
 lU+C1dqo8GWN0kV8ekNF/0FwLynT7+uaBW9e1W6ijPPO0p15Y+TmVtB9CGxDNiKg+asC
 nKo2SIsqONoUEp6krpEow/39NohNvhmMXALE0FwFwKkzQOqyu9UvVXPL2WiCYDITpPOu
 NZyureiSFKYLyI9emjxQu1mD4ghGv41oFSRXf7e44Uo3FMJukuMEzCFIjHpHVVFJUdsJ
 qvtP4DDUhGpfUA1TLdbAy9iCguiHDi04JqNxXm1Ltw+Z6c6maaaXLtKdk7sRq6Lb5EB9
 0CHA==
X-Gm-Message-State: AOAM531VAzvrvPiMPcBW0/bEw3YT5U9y0I6RSZycqiXlqNEO+0BRx81w
 uMuM0tTsUd53SZ9FIouZHMcaR3GtZmk=
X-Google-Smtp-Source: ABdhPJxwUjksoyjNiZXFmx16nWf/elaBbdLSb3p2YNFGJYWBKigmQzttycUYNOleemLlb8mxtDN8Pg==
X-Received: by 2002:a65:534c:: with SMTP id w12mr2233622pgr.156.1597179677399; 
 Tue, 11 Aug 2020 14:01:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 6/7] common: move module_unload to common
Date: Tue, 11 Aug 2020 14:01:01 -0700
Message-Id: <20200811210102.194287-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170119_395406_2EDEFF1F 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It creates a dependency between multipath-over-rdma
and test/nvmeof/rc which is not a natural home
for it. Move it to common helpers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/rc          | 13 +++++++++++++
 tests/nvmeof-mp/rc | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/common/rc b/common/rc
index 7f02103dc786..cdc0150ea5ea 100644
--- a/common/rc
+++ b/common/rc
@@ -291,3 +291,16 @@ _filter_xfs_io_error() {
 _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
+
+# Arguments: module to unload ($1) and retry count ($2).
+unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index e446db297ba1..829b26624b7f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -145,19 +145,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 start_nvme_client() {
 	modprobe nvme-core dyndbg=+pmf &&
 		modprobe nvme dyndbg=+pmf &&
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
