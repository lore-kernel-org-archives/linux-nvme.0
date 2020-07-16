Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF79C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 20:00:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A55207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rCgWVJ3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A55207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OT55JMWvxv4exBkGZmBOqk9gVD5PsD7ie90UYHvRqrQ=; b=rCgWVJ3qNgn/kg/UR6DzEnqdn
	YdAg6eyKX97UwSRpyL2nU0F3bAkLbbJ9epU7GEuRYxUHdaBezu7FKFFWd+gTje+11V4XPqkbirk36
	bCQ6YEkIMPLHHHnU2s+1AXmB9jtqzx45BDb71taClDx+icNeEjlEKeD2G5kuksr/hBaRz31vmLIz2
	lrub95CXW3dGEWo7ZdPUv6tirMtV1wf4wJ+XFGjJNPWbJQCtzB5dnZqVZphGjclxGdP5v0eJkZKb9
	iKfzv0mcSukDR1THmntls55af8TFA+YqXSrNOBAjnSAqtnQofE4BHHvjtpups0rB2RQZxLhVpPBM9
	zjj+5iRjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwA35-0003zi-4y; Thu, 16 Jul 2020 20:00:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwA33-0003yZ-7A
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 20:00:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78D51B71C;
 Thu, 16 Jul 2020 20:00:06 +0000 (UTC)
From: mwilck@suse.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] nvme: multipath: round-robin: don't fall back to numa
Date: Thu, 16 Jul 2020 21:59:29 +0200
Message-Id: <20200716195929.28399-2-mwilck@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716195929.28399-1-mwilck@suse.com>
References: <20200716195929.28399-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_160005_409832_ED4A2951 
X-CRM114-Status: GOOD (  15.87  )
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

Currently, if the RR path selector returns a non-optimized path,
we fall back to __nvme_find_path(), which uses the logic of the
numa path selector. For a given numa node, this always chooses
the same path, thus preventing round-robin logic on non-optimized
paths.

By handling the situation where the current ns is NULL in
nvme_round_robin_path(), we can avoid falling back from round-robin
to NUMA, fixing the issue. The iopolicy case distinction in
__nvme_find_path() can be skipped now.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/multipath.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2c575b783d3e..ff93bab0d549 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -181,10 +181,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
-			distance = node_distance(node, ns->ctrl->numa_node);
-		else
-			distance = LOCAL_DISTANCE;
+		distance = node_distance(node, ns->ctrl->numa_node);
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -225,7 +222,13 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 		int node, struct nvme_ns *old)
 {
 	struct nvme_ns *ns, *found = NULL;
+	bool was_null = (old == NULL);
 
+	if (unlikely(was_null))
+		old = list_first_or_null_rcu(&head->list,
+					     struct nvme_ns, siblings);
+	if (unlikely(!old))
+		return NULL;
 
 	for (ns = nvme_next_ns(head, old);
 	     ns != old;
@@ -244,9 +247,12 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	/* Fall back to old if it's better than the others */
 	if (!nvme_path_is_disabled(old) &&
 	    (old->ana_state == NVME_ANA_OPTIMIZED ||
-	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED))) {
 		found = old;
-
+		if (!was_null)
+			/* No need to switch */
+			return found;
+	}
 	if (!found)
 		return NULL;
 
@@ -267,8 +273,9 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
-		ns = nvme_round_robin_path(head, node, ns);
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+		return nvme_round_robin_path(head, node, ns);
+
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
 	return ns;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
