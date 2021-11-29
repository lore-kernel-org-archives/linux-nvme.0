Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E321C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CCRQTXs8qnS29gtvSomxf9nPqePygJihSUCqTMewCJM=; b=3fjfxfgS4T9eHtTA35t6FLxnN+
	FZ3ljy700KHQVePm+cNHfXDNYkbZSeW2Su2zdEUY4+2RegjSg+KNb8tKHjeFbakMUZNIiOBV8RhiB
	GJSDxwr69f5EltHJSJ9XOM85TPToykhxOwXLyMUMVdeg90WIIrU03uh2gb8Wyo2GXKZnNxnPzaCGD
	MLorDHoUuSUlrvOAhHoe53tg7H1Y5Lz2Us58e+DYdG8dlhuj7f8OWoN9WtjzxnYQWTTZMOlCvsowQ
	s0z5uQvAT5Vt8Mi7umZ7UTQXrm93zZg5MafjyfvV1eu5VCEDB/n7BjC/z5sOK6gqkStya5hsKjEue
	68KKr3Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrjSL-001PlT-Hy; Mon, 29 Nov 2021 16:24:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrjSJ-001Pl8-I1
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 16:24:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6A261572;
 Mon, 29 Nov 2021 16:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F83C53FD4;
 Mon, 29 Nov 2021 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638203078;
 bh=JN/g9TZMpwopQRY/UPN5JWxwnXw9+nGhyHPfHz52OCU=;
 h=From:To:Cc:Subject:Date:From;
 b=l+hd4aUlyGbN/XmWgxG8Cw44K5xYg50atfgFLKn8vKT0uiPzSFrT7GwAG0uTCC5hm
 wiZm5jhEreQFxwqluXkfvY4RBzkCRrz+dmLfyel+G/Mpmn+BSx8NJOXZ8azIaeHjJd
 DMtERqdnAb+0GshqzPAf4qLQWQNsS40eNVODgQGqRe7vqz7hfVd5Jo9RHtFF/VlGLC
 iTRJcQ66YNC85rOXABQ89XiFr2CrLO7rbVUImg/yyLGv7j6FJWx3/Rhpq9161HQ74K
 +iT3j9kb9P3uKkxqSafZIMBgYMZxyHyyQ847zxUduHSsWzS5yqeHQwrw2kD36wfhY7
 gGrX2NBdw6N8Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: show subsys nqn for duplicate cntlids
Date: Mon, 29 Nov 2021 08:24:34 -0800
Message-Id: <20211129162434.3611259-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_082439_652443_C325372A 
X-CRM114-Status: GOOD (  10.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The driver assigned nvme handle isn't persistent across reboots, so is
not enough information to match up where the collisions are occuring.
Add the subsys nqn string to the output so that it can more easily be
identified later.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215099
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47a941207058..96db941c01b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2684,8 +2684,9 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 
 		if (tmp->cntlid == ctrl->cntlid) {
 			dev_err(ctrl->device,
-				"Duplicate cntlid %u with %s, rejecting\n",
-				ctrl->cntlid, dev_name(tmp->device));
+				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
+				ctrl->cntlid, dev_name(tmp->device),
+				subsys->subnqn);
 			return false;
 		}
 
-- 
2.25.4


