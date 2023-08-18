Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51FC3DA66
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f42bCxvlAvmcujooXy3bffnAnWJZzzFDZ6+tYkOrJJ0=; b=bva6F194QPN/GkyixytRDyprpk
	44f3hE/jLA1yKf89S6CmlWd3Cg8tet5SuN+ylqulYBKXGS/Voy0FmQgbl6Tr9MP04P/V4vYjKx1BX
	VELSROJSF53oYTffZ8J1NgmteHuUvB3CcxBBi/uWCoaKet3tCtGlOFoPJeTyYaIJjxmYJkh3DSFpm
	HLO/iwQrZwI09dxGPd0GYqSubUROGujN+jUSNuFDNcj1Y1UWWVoT2SrJsIpIIiNhjEe9z7mwpC8Au
	w4GgHZPP6QuMQ4aeNP1KFyx1dE4ecJ7fHN8kA+cGURSYM7PXDm1+mt/X/ZdAC5L0AUS6NboJdBAzy
	0d3WVpUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWoff-007Vgw-2i;
	Fri, 18 Aug 2023 01:53:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWofd-007Vfy-13
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 01:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692323578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f42bCxvlAvmcujooXy3bffnAnWJZzzFDZ6+tYkOrJJ0=;
	b=cyxdhrMCvMylwSCdh7NhvAwRVBijrKSAp0WGGDc5Y44SvN+dhx3U+gGLZzHsVGOu9WYHP8
	xw6pt8WKQo6OTnEDTKfTMnDJuxR6YBdg0cpiMpE5Ih0o9oqCTNv9alVskO41LkETEnrBzj
	XRsqg6wQVhsUeQjobnnsI5lZlie31KA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-tyZm7me1N8SlX0ks18qw8Q-1; Thu, 17 Aug 2023 21:52:54 -0400
X-MC-Unique: tyZm7me1N8SlX0ks18qw8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CD8E3C01C1B;
	Fri, 18 Aug 2023 01:52:54 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33F84C15BAD;
	Fri, 18 Aug 2023 01:52:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH V2] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
Date: Fri, 18 Aug 2023 09:52:44 +0800
Message-Id: <20230818015244.1176929-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_185301_460114_0334DEBD 
X-CRM114-Status: GOOD (  18.28  )
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

group_cpus_evenly() could be part of storage driver's error handler,
such as nvme driver, when may happen during CPU hotplug, in which
storage queue has to drain its pending IOs because all CPUs associated
with the queue are offline and the queue is becoming inactive. And
handling IO needs error handler to provide forward progress.

Then dead lock is caused:

1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
handler is waiting for inflight IO

2) error handler is waiting for CPU hotplug lock

3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
error handling can't provide forward progress.

Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
in which two stage spreads are taken: 1) the 1st stage is over all present
CPUs; 2) the end stage is over all other CPUs.

Turns out the two stage spread just needs consistent 'cpu_present_mask', and
remove the CPU hotplug lock by storing it into one local cache. This way
doesn't change correctness, because all CPUs are still covered.

Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Tested-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix "Cc: block list"
	- add tested-by tag

 lib/group_cpus.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..15006e79196f 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -348,6 +348,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t local_cpu_present_mask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
@@ -355,6 +356,16 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
+	if (!zalloc_cpumask_var(&local_cpu_present_mask, GFP_KERNEL))
+		goto fail_local_pres_mask;
+
+	/*
+	 * Make a local cache of 'cpu_present_mask', so the two stages
+	 * spread can observe consistent 'cpu_present_mask' without holding
+	 * cpu hotplug lock.
+	 */
+	cpumask_copy(local_cpu_present_mask, cpu_present_mask);
+
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
 
@@ -366,13 +377,11 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
+				  local_cpu_present_mask, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
@@ -387,15 +396,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	cpumask_andnot(npresmsk, cpu_possible_mask, local_cpu_present_mask);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_build_affinity:
-	cpus_read_unlock();
-
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numgrps);
 
@@ -406,6 +413,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	free_cpumask_var(npresmsk);
 
  fail_nmsk:
+	free_cpumask_var(local_cpu_present_mask);
+
+ fail_local_pres_mask:
 	free_cpumask_var(nmsk);
 	if (ret < 0) {
 		kfree(masks);
-- 
2.40.1


