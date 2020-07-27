Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799FC433EC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87582073E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2kDoazfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87582073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JESuxcq+KHHgtRzZv8M9vNqjHF9yTbakpfT2E1pfd94=; b=2kDoazfl5JFKCq3foSCwSKPvaf
	0UENHNyGGI3ysHqQDYiWuHCDOaG9N0t4QQJ8P4TSlb6PTmDFWz1rdLjwxSIqWBBtmpTRCSI+VOjCa
	QumQdsKHDJGlMJuToSX9482T3XPbTNi+pVOPwhpQ1+tIwXYPJOsgsNGteM/36UiLLFF8aXSUGhNKg
	5XxNqyTDYvWj8iewWkWsuDDGQun9ovVy7rAHZtmZZDDE4U0H2fBMPS6gCyxltYTyROvA1C/FwMHiO
	Ayh8/7KCzPp2jDSF1ZjS2okQ1ZRqSN0cwc+N2YAhdqSJVorpAcRX7/m5CaXWD+sJ89DjNWzRQr6X3
	1iYOLj0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k05fl-0004da-Kf; Mon, 27 Jul 2020 16:08:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k05fh-0004c2-GN
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 16:08:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 87B2DAC1D;
 Mon, 27 Jul 2020 16:08:21 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme-multipath: do not fall back to __nvme_find_path()
 for non-optimized paths
Date: Mon, 27 Jul 2020 18:08:03 +0200
Message-Id: <20200727160803.55683-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200727160803.55683-1-hare@suse.de>
References: <20200727160803.55683-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_120813_700902_02C0DE66 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Martin Wilck <mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When nvme_round_robin_path() finds a valid namespace we should be using it;
falling back to __nvme_find_path() for non-optimized paths will cause the
result from nvme_round_robin_path() to be ignored for non-optimized paths.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fe8f7f123fac..97d3c19b5684 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -272,8 +272,11 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns) {
 		ns = nvme_round_robin_path(head, node, ns);
+		if (ns)
+			return ns;
+	}
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
 	return ns;
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
