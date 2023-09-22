Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FBFCD4F2B
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Sep 2023 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CBLqoMyIVireLlLreZE4y9YWUgoFtH3j+ZLwtIAR6bY=; b=sREEOlsGi/OyCgpaVhp/FnNR/Y
	wt7SevtbH1FfQf7Xk14luGAvRkyQDF1vrjTDYBopaT80779LECbe9i0PQbC504OZZ2JEXFSH0V1hb
	n+ANyQdvm8caeKYdmrTwaboOEf6PtAwVr4EswwoZ0e5R9ZyHYvSh1Bb4Pna12WiUJfji9QCj86928
	XISISF4YrLunPlGAmBHXixgzTekJbc35keHuHAvkjHcUdvpu8jeA4OeB/xjGCNYNqsAT3fNK7Zq3u
	qEy56s7zf6KwIMlSGNDcqfwCuLANlb+eR8pCQh6ELcLbchFHxxPBx9Rx5GUEZANkp1N2NO/sZoN4B
	2dYLQB5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjb9W-008KbB-2t;
	Fri, 22 Sep 2023 08:04:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjb9S-008KZA-36
	for linux-nvme@lists.infradead.org;
	Fri, 22 Sep 2023 08:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695369876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBLqoMyIVireLlLreZE4y9YWUgoFtH3j+ZLwtIAR6bY=;
	b=OZg+BjedXGezaJGvSswT2cR2z4Wvi+UaVVtrltDAFYnsTdpHgZ9f8XspLfva5TjeymwK/5
	+AGwRakaTSyR0v0klQ3MNnOj857VtM+XieAEr12c1LvAkgqmxAI0YHFYm5JOaUJAJ0w8De
	kBnr40Rrg1pzVhlmMNyTa0stLjR3XUM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-movzolr0O5q7EvlVO3dTTQ-1; Fri, 22 Sep 2023 04:04:32 -0400
X-MC-Unique: movzolr0O5q7EvlVO3dTTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C4131C06E0B;
	Fri, 22 Sep 2023 08:04:32 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 190AF40C2064;
	Fri, 22 Sep 2023 08:04:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
Date: Fri, 22 Sep 2023 16:04:25 +0800
Message-ID: <20230922080425.2745715-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_010439_068374_0BE762ED 
X-CRM114-Status: GOOD (  16.44  )
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
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..ee272c4cefcc 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -366,13 +366,25 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
+	/*
+	 * Make a local cache of 'cpu_present_mask', so the two stages
+	 * spread can observe consistent 'cpu_present_mask' without holding
+	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
+	 * hotplug code.
+	 *
+	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
+	 * we can live with the case because it only affects that hotplug
+	 * CPU is handled in the 1st or 2nd stage, and either way is correct
+	 * from API user viewpoint since 2-stage spread is sort of
+	 * optimization.
+	 */
+	cpumask_copy(npresmsk, data_race(cpu_present_mask));
+
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
+				  npresmsk, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
@@ -387,15 +399,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_build_affinity:
-	cpus_read_unlock();
-
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numgrps);
 
-- 
2.41.0


