Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28ACC4320E
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 10:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC861056
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 10:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62CC861056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A7wjjgpPmnPX50kl0uKvn8J6IbRb8JSa1P8danoqhWM=; b=3TzDAh/Tvp2nnz
	SGNdUk1Wxy+zdU4OZsrwd3QTN1d1Av28tW5YU3xJZoNe0P/03cKuGYQwO3hnCDbwmwCPc9FnL16UF
	q1pQpqStpl3967171nWoDB30uSklnugcSlp1EIZfVBdHuhTs5EHFjhIsaPyasq1SPYRl4qrGOXwVU
	OwnQWE/l+ehZh4Gbm2neHiIlrZMker5rCKVJXWvI1aMjbx9p5fdA3giNdqh4G9bEE7d6NPxM3wcDh
	5HlW6uTrOg9GP79xpM3/OsaItttCY83HnpyiHKx+eSgDEqn2cBNghOlYpgIFMcG2TZPiePr0/wI7p
	WWgwhV1/qic3CrUiNSYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLNv4-005NMP-9m; Wed, 01 Sep 2021 10:56:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLMUw-004sAC-MU
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 09:25:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1303F1FED2;
 Wed,  1 Sep 2021 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630488329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+YRDyHEd0/BbrJjaiTEJ0u9b/syuNDaZjHPGP+HRcTk=;
 b=gxZAuuRYo4um9VhWmQFpBfBzUkO/Vvk6T+X3j6soRekCeo9n2WkXLR+VdAGXgd69xuIm4+
 vu5ihxduiVqWosyO5yVWspxwM3jJoHK7hCoRAmrO6jxIBy/Xd96OIHMExRFscPFV9jJCEj
 2pCXl/PbWWkElgsSKnwCGmQkBrLGZjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630488329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+YRDyHEd0/BbrJjaiTEJ0u9b/syuNDaZjHPGP+HRcTk=;
 b=Q5ZeS9YcXGgTK6kCB8wv6MUKYl1FiJ9GAlmTRGQnMNpDwnSHEATh6C2MQji69bGpmWYMma
 EvsNgdyHP2yxXKAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0D54EA3B9C;
 Wed,  1 Sep 2021 09:25:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id F3DE5518DE46; Wed,  1 Sep 2021 11:25:28 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1] nvme: only call synhronize_srcu when clearing current path
Date: Wed,  1 Sep 2021 11:25:24 +0200
Message-Id: <20210901092524.131610-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_022534_931048_0EA6D239 
X-CRM114-Status: GOOD (  13.72  )
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

The function nmve_mpath_clear_current_path returns true if the current
path has changed. In this case we have to wait for all concurrent
submissions to finish. But if we didn't change the current path, there
is no point in waiting for another RCU period to finish.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d5cc947525..5b3c74fa89bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3814,8 +3814,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
-	nvme_mpath_clear_current_path(ns);
-	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
+	if (nvme_mpath_clear_current_path(ns))
+		synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (!nvme_ns_head_multipath(ns->head))
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
