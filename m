Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 20:00:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A41207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wX6vyspK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A41207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Alq5ts+l9pn02cyDQZiQxuoity1UF+XAHQVsjHgv0Fs=; b=wX6vyspKv8KZm4osFX6cR9+GV6
	0DJil4e2vuXy3ZG/4V6J01V2unO/7b7fEspCtiPVYJWehx/kZiY1bx5ywQ7+QkeePQ+iL1rAa2f+R
	azIlUMfq6R9D9NjlJqitioJ7JUaidcskcABQAEljIrqVjjbfZV7GtRh6m2s1egzsXeboRGJdPrGB5
	Ww8ejuWYvLOU+ZTb7RnxCx+dhAjTP8FYs4DIO9VVXdux6pfp8PGRmFYLO+r8nVPuIV5QEuu8kVnPr
	tK66R4mTpKJ/sRBzIqp80rl3v7KvHByWjdKmWwsFMk71VkDNCH8d+0YOqv+0mAsNLwjPu6BrVtJFY
	iDTBnlEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwA36-0003zy-B0; Thu, 16 Jul 2020 20:00:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwA33-0003yY-56
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 20:00:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 59014B71D;
 Thu, 16 Jul 2020 20:00:06 +0000 (UTC)
From: mwilck@suse.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvme: multipath: round-robin: fix logic for non-optimized
 paths
Date: Thu, 16 Jul 2020 21:59:28 +0200
Message-Id: <20200716195929.28399-1-mwilck@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_160005_325269_F5914632 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: marting@netapp.com, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

Handle the special case where we have exactly one optimized path,
which we should keep using in this case. Also, use the next
non-optimized path, not the last one.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/multipath.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74bad4e3d377..2c575b783d3e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -224,13 +224,8 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 		int node, struct nvme_ns *old)
 {
-	struct nvme_ns *ns, *found, *fallback = NULL;
+	struct nvme_ns *ns, *found = NULL;
 
-	if (list_is_singular(&head->list)) {
-		if (nvme_path_is_disabled(old))
-			return NULL;
-		return old;
-	}
 
 	for (ns = nvme_next_ns(head, old);
 	     ns != old;
@@ -242,13 +237,19 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 			found = ns;
 			goto out;
 		}
-		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
-			fallback = ns;
+		if (!found && ns->ana_state == NVME_ANA_NONOPTIMIZED)
+			found = ns;
 	}
 
-	if (!fallback)
+	/* Fall back to old if it's better than the others */
+	if (!nvme_path_is_disabled(old) &&
+	    (old->ana_state == NVME_ANA_OPTIMIZED ||
+	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+		found = old;
+
+	if (!found)
 		return NULL;
-	found = fallback;
+
 out:
 	rcu_assign_pointer(head->current_path[node], found);
 	return found;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
