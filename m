Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C411C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7FE221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7FE221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Az35+lyOMt0i41r0SIBRhtkyjzY6jsYP7w4YCPFkiWY=; b=pUlYS4heCf9ntZwW9MXvr3dnp
	wuN3XI0M2lp2dZOf7YtnppBGqmlCmhSHx1VvH4Z1mBpVyGTFuJAasBoXgCfGEUOBa4OFTo8MGH0K2
	zWOH9pFCrDWtZRjIoc65TUqZzd+8xctqXV6QWs7+j2AGDTv7yGWq9tUNp6Tk42wb6kCkqRV5lMTgu
	/tmT/kcTE+ayTMlehm656PqzVCY3JfwgWhm5gHT2i9t9apTrMzZrME6Hqx6TuMs/RGZDc9aGTiXZe
	JJ4Wr+p8Y+rKWF+qxNkzlEKSTAQBOITFw6kbDk32CMPWG0arOFFLMNw6TnoqDRUb1jbt9Yf2Fhz7Z
	vYiOIArmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3t-0001oA-Kf; Tue, 26 Jan 2021 20:35:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2C-00011G-1L
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qkaspjlY78hMQLB4ONfW8NUlCguAMnlMZUaEduteWQ=;
 b=efFps0H32pS4rTPYkb5J344us8vW2/4kh+Q0DIvWPlvTMWPcKUllMT+4WMDNPATp5wmmcw
 ImlfSuBLlJphx6of65t3BUlYQguqlHiL1KFqOygXaZff5T2KRbQJVT69X34YzqG7qyTrHS
 0su+orvD6yr2vucZMzBkvXswXp5W9Ss=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3E2CAAF52;
 Tue, 26 Jan 2021 20:33:51 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 31/35] completions: add completions for nvme monitor
Date: Tue, 26 Jan 2021 21:33:20 +0100
Message-Id: <20210126203324.23610-32-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_722254_0C7600A8 
X-CRM114-Status: GOOD (  11.92  )
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
 completions/bash-nvme-completion.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/completions/bash-nvme-completion.sh b/completions/bash-nvme-completion.sh
index d669e9b..9bf0da8 100644
--- a/completions/bash-nvme-completion.sh
+++ b/completions/bash-nvme-completion.sh
@@ -11,7 +11,7 @@ _cmds="list id-ctrl id-ns list-ns id-iocs create-ns delete-ns \
 	resv-report dsm flush compare read write write-zeroes \
 	write-uncor copy reset subsystem-reset show-regs discover \
 	connect-all connect disconnect version help \
-	intel lnvm memblaze list-subsys"
+	intel lnvm memblaze list-subsys monitor"
 
 nvme_list_opts () {
         local opts=""
@@ -231,6 +231,10 @@ nvme_list_opts () {
 		"disconnect")
 		opts+=" --nqn -n --device -d"
 			;;
+		"monitor")
+		opts+=" --autoconnect -A --persistent -p --startup -U \
+			--hostnqn= -q --verbose -v --clockstamps -C"
+			;;
 		"version")
 		opts+=""
 			;;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
