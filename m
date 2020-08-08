Return-Path: <SRS0=sRvj=BS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79222C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 23:47:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48285206C3
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 23:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WLwv3yZj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTxVKWDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48285206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OzdZVlwH6YhZGD7wk88W1TDSRL3e/FGoKUGx31CdG9k=; b=WLwv3yZj1BwTfwda6CXAUq5Nj
	WGbC4noEJD3ij4trUeetcKQ1YqFiElS3TCrtAdOHTrF2F11ouvYRQ1YWEAfEwrZPYbIf+52XrP4v4
	Xq9aDQUvsqOzFx3oIY59EIYoyMdrn2LHTpV3XJs6y5jeRe3wSf5AStm7PzZSVr1L1n1qeFOMjZH6x
	Em0+Uxcr8kc3fVpVpn47HqSdoz2GFvUj5+lqX8ZMOHGJ4RFwZhgV2ffQ8p4DCobiIplVeQKqnZos7
	n5bol5RB16ntczAJ7n9Uh8FKlBijq8II0YpDASZAAGZEDkJGKyzJhulCV8y9mubVSIJmavdaGZYgP
	yS81QV1EA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4YYi-0001Y6-0w; Sat, 08 Aug 2020 23:47:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4YQG-00027V-TL
 for linux-nvme@lists.infradead.org; Sat, 08 Aug 2020 23:38:46 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 523D920825;
 Sat,  8 Aug 2020 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596929922;
 bh=L07yy2GmUsjLM3+nAixezYsG4RZHhf9+qZPnLqSltYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WTxVKWDKWeDU+ufz5p2azMbcJu2XOPS7K5nUVCOZ8slbGY84lL3TUsqNWsxtVf2mp
 D6O8/5KCM/B+D1rKHCTTf5W3F0FeqYOT/qR5qGwZJyKwxyLuXGHRZ7rQKIBR2or/+c
 LAyRi+aCyALUyBFeq4Oyv8DL4CjEhgKHgojOgAZo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 57/58] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
Date: Sat,  8 Aug 2020 19:37:23 -0400
Message-Id: <20200808233724.3618168-57-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200808_193845_300757_6D1E2A46 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]

When nvme_round_robin_path() finds a valid namespace we should be using it;
falling back to __nvme_find_path() for non-optimized paths will cause the
result from nvme_round_robin_path() to be ignored for non-optimized paths.

Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2c94e084a61b8..d3914b7e8f52c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -272,10 +272,13 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
-		ns = nvme_round_robin_path(head, node, ns);
-	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
-		ns = __nvme_find_path(head, node);
+	if (unlikely(!ns))
+		return __nvme_find_path(head, node);
+
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+		return nvme_round_robin_path(head, node, ns);
+	if (unlikely(!nvme_path_is_optimized(ns)))
+		return __nvme_find_path(head, node);
 	return ns;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
