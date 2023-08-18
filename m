Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7D2C7115A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Km5bEjvHFKHGKfuEsrUW3JzJAnKEezHhvxomlDHV3DU=; b=LvG0or49zG9qHqxGdorUchHQNq
	VTDvzevqhTfK2e1mdPq9T/mqtpVg3wKspMjDSK/zOYzWoLbNjyO62YCjjVeojT/JsU+5tPdB2rn0m
	tnrdhrDUKLAl4R0lGiMBbAnMjXn14TxbZ/tqT7nXJifhUOyzgTp4EIeaUq2/LYcGC/CaQFz6K/h1W
	Rl7apTgPasbxzrIWuDBJyIhVC8nrrnHr6YK4zqXHvGlHwBmTVc7cWkd2W7cLnIVqK2UssHyFkvbqI
	F9FGJjTvDhZk8tIKUUCAWoa5SBfmqWbm3rhaGJcHxljVd7I3hUgnFpH92M7m7NpEzbeZCImMvsWFR
	zQ62VHDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qX037-009SCq-0p;
	Fri, 18 Aug 2023 14:02:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qX034-009SB9-07
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 14:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692367317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Km5bEjvHFKHGKfuEsrUW3JzJAnKEezHhvxomlDHV3DU=;
	b=c3aWLpN/uon7e6QUB9ZGMUoa7ZI7Eu2VH99M2yyBADld6b5T36iIa6rGT8rMFxwK/v/enR
	bQLK7gp8bDYACdByhacsVbpyt8a9Ub/3DZIMeX/AewzSKD6pqO68stt8LTKO7z4vJwvqU1
	DbGhN0wTBzHnjLw5v2gwt2eqiFJy678=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-gY35I9gfO6u6S84jANp4JA-1; Fri, 18 Aug 2023 10:01:51 -0400
X-MC-Unique: gY35I9gfO6u6S84jANp4JA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0621A85CBE2;
	Fri, 18 Aug 2023 14:01:51 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C787E140E96E;
	Fri, 18 Aug 2023 14:01:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
Date: Fri, 18 Aug 2023 22:01:45 +0800
Message-Id: <20230818140145.1229805-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230818_070158_199075_CCEC860D 
X-CRM114-Status: GOOD (  16.31  )
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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- reuse `npresmsk`, and avoid to allocate new variable, suggested by
	Chengming Zhou

V2:
	- fix "Cc: block list"
	- add tested-by tag

 lib/group_cpus.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..fffe8a893597 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -366,13 +366,18 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
+	/*
+	 * Make a local cache of 'cpu_present_mask', so the two stages
+	 * spread can observe consistent 'cpu_present_mask' without holding
+	 * cpu hotplug lock.
+	 */
+	cpumask_copy(npresmsk, cpu_present_mask);
+
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
+				  npresmsk, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
@@ -387,15 +392,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
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
2.40.1


