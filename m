Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9886FFCE082
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvSdk0KLyMP/hTAjLBaZknkvcL3DKU1Hy13uOwtU7QA=; b=N/qPlT+7Et+Sb2Kt2C9yG1wHrO
	H7XfgeJ4xRwybHaGBm8FoUUursJsr/vZsDGHas53HCW4O4wFi+i5v0ab7x1Gb3gsVBxA8pM9SgFNz
	Qb3eF7EmCiQq4ZrsibGFPZXFP1U4Vh2WJQmdyI2ahb/lbEnbvyqkfSwmDIMGiErFxjd+6hd1LL034
	86Q4nRTeyAnl3h/6dYT18K1YMaHXeBcoEtFqnfw5HYrpbFn23Tkbzjlvvz6jUobULAOYZyFZdLexa
	EKUc3r3AuUVeT+j/mvGxVcGn0/jTJlp7o5bHGgdfFqojcpB+z3PAXprjkQAcuq5Yzc85igfoxogU4
	Tg6wWnBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbcA-00000006Evm-3YZS;
	Thu, 26 Feb 2026 13:41:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbc0-00000006Eo2-1BsM
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 13:41:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B3B8C6012A;
	Thu, 26 Feb 2026 13:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D21FC19423;
	Thu, 26 Feb 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113263;
	bh=2eeVb+zoDlOmD27kv8yJ2Z71w8S3koXAwM5JTxOP9Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kVRVl7DmCTMD7dun7p1l3c0b+fLQDADieEnBM5Km3bpiPK2wV+ynl7BnBKqSuw1Dw
	 JaW2qMwfT8n3K3BKwg0XD2Tt3kzFEi9wOvy4Y0teutExQhhnnLTl305Yx8IOwIK98h
	 2fCHLGpfxFcvDQNlDTKpghCCSmCgswV7bfI4vwqGP8ReT8F2t730EReLN818YzVh5G
	 zP5IS5jQMEQ7w3w57krCFz5MaBgRQDt6VYhGvfoRhP7tiFb/cjEf8/bme0b6AOa4Gv
	 1efMu4OiDNY3Q7ceJ5Ur2CczR6+0InButBy4g6/B2JMSG4sYPTwF8lFNKWktakfVNz
	 MLmfOTlKPBjpw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 26 Feb 2026 14:40:37 +0100
Subject: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu hotplug
 lock in group_cpus_evenly"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
In-Reply-To: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.

The reason the lock was removed was that the nvme-pci driver reset
handler attempted to acquire the CPU read lock during CPU hotplug
offlining (holds the CPU write lock). Consequently, the block layer
offline notifier callback could not progress because in-flight requests
were detected.

Since then, in-flight detection has been improved, and the nvme-pci
driver now explicitly updates the hctx state when it is safe to ignore
detected in-flight requests. As a result, it's possible to reintroduce
the CPU read lock in group_cpus_evenly.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 lib/group_cpus.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..533c722b5c2c 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -510,25 +510,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
+	/* Stabilize the cpumasks */
+	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/*
-	 * Make a local cache of 'cpu_present_mask', so the two stages
-	 * spread can observe consistent 'cpu_present_mask' without holding
-	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
-	 * hotplug code.
-	 *
-	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
-	 * we can live with the case because it only affects that hotplug
-	 * CPU is handled in the 1st or 2nd stage, and either way is correct
-	 * from API user viewpoint since 2-stage spread is sort of
-	 * optimization.
-	 */
-	cpumask_copy(npresmsk, data_race(cpu_present_mask));
-
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+				  cpu_present_mask, nmsk, masks);
 	if (ret < 0)
 		goto fail_node_to_cpumask;
 	nr_present = ret;
@@ -543,13 +531,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_node_to_cpumask:
+	cpus_read_unlock();
 	free_node_to_cpumask(node_to_cpumask);
 
  fail_npresmsk:

-- 
2.53.0


