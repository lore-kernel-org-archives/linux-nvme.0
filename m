Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E4C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C332070A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GMJEnAJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C332070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cCv721Y1E2qYv06mD9sQJzSDR2qI+KqH1NY39aZnbXE=; b=GMJEnAJaf/X6Q8aJ4d2DORmaR
	s7LQ2Ihj7XD9yQm0MqUjlpp4VV+YpyBME0CFNnnMJayYld7Zef4hCM3cgTbSOtS2ujLALg73WoA1n
	Q+JfZLaE1WpM4su/VjW3AehubEkSi6AJaWhUT/W5p4OI1OI67yaNtaFLtw57H1WY4WQ+LzZclfw0K
	pxXomLcF1WK/jrSVu6SU0rJbCisls99ix4RW3Bn2VXfNLYCOXZs6Qy8FkAVSvFrzIeVdyOoObJaqe
	/R+oY1iD6Gtib1xU08mDiVm7MkzO/65Uvr/v/L1DByh2KWgzMGPHaf08nEQRMGYQ0xM13zwTHf9g2
	mjMQ9OaYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3foh-000356-Iz; Thu, 06 Aug 2020 13:20:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3fod-00032t-Qk
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 13:20:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A56BAB6CA;
 Thu,  6 Aug 2020 13:20:27 +0000 (UTC)
From: mwilck@suse.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] nvme: multipath: round-robin: eliminate "fallback"
 variable
Date: Thu,  6 Aug 2020 15:19:32 +0200
Message-Id: <20200806131932.20017-3-mwilck@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806131932.20017-1-mwilck@suse.com>
References: <20200806131932.20017-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_092015_967085_A385C610 
X-CRM114-Status: GOOD (  15.01  )
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
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

If we find an optimized path, we quit the loop immediately. Thus we can use
just one variable for the next path, slighly simplifying the code.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/multipath.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a64dfff0d0ce..760f625cefc8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -233,7 +233,7 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 		int node, struct nvme_ns *old)
 {
-	struct nvme_ns *ns, *found, *fallback = NULL;
+	struct nvme_ns *ns, *found = NULL;
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -252,7 +252,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 			goto out;
 		}
 		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
-			fallback = ns;
+			found = ns;
 	}
 
 	/*
@@ -263,12 +263,11 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	 */
 	if (!nvme_path_is_disabled(old) &&
 	    (old->ana_state == NVME_ANA_OPTIMIZED ||
-	     (!fallback && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
 		return old;
 
-	if (!fallback)
+	if (!found)
 		return NULL;
-	found = fallback;
 out:
 	rcu_assign_pointer(head->current_path[node], found);
 	return found;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
