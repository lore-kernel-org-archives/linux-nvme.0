Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB6C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E61664ECB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E61664ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L+F794DqVEnTDLf/+6KLpR3+eqPzkXLcrCMjdEI6oVE=; b=hFia7wg6Ba3xLfaZwdNuglUTds
	7P3dr7zmG1+4/XBJSNJutHqsVzjV014j6bIzAy45F630tDEz3Gfb/CcMnXylI7LX8wAe0mthdcasc
	ve7XiEp9IcA4VwXo6YoyvMzyuNcRUW79dH6cqKt/+0Hp0Oz7KJnUCbN22cUXVR2PgOd1A73APvvEt
	i3GSn5EL+3h4SbOB3ujBwyjpArjPfWjGLObj6T+dJBvTEHCGhLgjWrhSi9kvddSoMivZgjFZZV/YZ
	dBL7t1zL5OfhX3lyt0KYn+X0M4VPNdGppvD+2gEVPynsgTMWTRfiFf8FE2NThNk08d4c/aK4jpAW4
	l2sqKijw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6fC2-0004W2-Pg; Mon, 01 Feb 2021 19:49:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6fBv-0004TX-3e
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 19:48:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF6B64ECC;
 Mon,  1 Feb 2021 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612208934;
 bh=Y2WWrsQZXP1KuYOOZvcAik6xXFPSIOEazvpxSzXSZS8=;
 h=From:To:Cc:Subject:Date:From;
 b=RZoL1x9avf4uhg/y1RkMbLGTHoZ5YtLybvht7GA8FRVGATA0I5mYU/SomEXDXr08q
 yurcokuQCeA6jB97TI0kgd7BqN3wcruC9PmF4Gf15pLkcko8g8S4Qa8FDddqEKOONN
 uTu3xs6wx0KnBcFG4fz7od+kyEyaJ42giicDLhjeq816CSQxUoVgbng8fYlTM+ulyR
 wfMu4dzmdvieM10o2gU/Vozmh0yTJz07MOF37VEkBtGHl8++YQnGqI27zFEg7NAs7J
 GbFOpy0UM+foduIjOJWVqbUKPOe6sdnNA48LnuxPO5U8qSAuipd/YdrBnMxddwgBq2
 7odknELEpHNNQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] Update email address
Date: Mon,  1 Feb 2021 11:48:44 -0800
Message-Id: <20210201194844.2127981-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_144855_268277_12A6540A 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Redirect my older email addresses that are in the git logs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index b1ab0129c7d6..c0ce7f0951a0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -182,6 +182,8 @@ Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>
 Kees Cook <keescook@chromium.org> <keescook@google.com>
 Kees Cook <keescook@chromium.org> <kees@outflux.net>
 Kees Cook <keescook@chromium.org> <kees@ubuntu.com>
+Keith Busch <kbusch@kernel.org> <keith.busch@intel.com>
+Keith Busch <kbusch@kernel.org> <keith.busch@linux.intel.com>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
