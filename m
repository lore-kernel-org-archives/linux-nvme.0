Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5AAC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5mhCBQQFyo/pEHelnW5w0jjgQcj3b/N98E7vKt3bO0=; b=wecNkLSc9qcDTIbXCNBFyc0rzO
	T3QQFItWCBn7le30DT6t4pUKKRk24U9M0ZQ54tHO4MO1UqZAaqn1ZusQkY+AAebkbocUg6C4NggnF
	vX7GKy/sp48BPF0I0gklLz53GoBVdfqSLAGOxZ4dQ+5L3AvHLmgmobVEQWExWNbsLtNuKQENXLQT4
	HtOwbxa/mJu99l0covf1YpGSaZtn/u7xz/MgRPrx8f/cgewQs2aj3DKs2DqTv2uGQjWGgp6k0MKn+
	LozLyDEf1ADFT63Qrvukd8J+ORN0vKnYAc5kMDFfpjgiIqnrNDrN7V44vQNO6zXeyIkIWLUwWb4uq
	Atw8Vnig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKehq-00000009PB8-3l1p;
	Fri, 21 Jun 2024 13:53:34 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKehm-00000009P9I-3My0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 13:53:32 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7984DAD81;
	Fri, 21 Jun 2024 15:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718978001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=k5mhCBQQFyo/pEHelnW5w0jjgQcj3b/N98E7vKt3bO0=;
	b=htY7I9hcSpMywnTn+OdfkPekbPSrDaFGG0Bk8oZvxcOj20UnFyizWaZbbvX6l30hPMhn4+
	sS8V6IuJ31CF+3yVpZULD9v8xe5n2/l5fiSWlUmmgc85BQpraQA3/1K/FZO/pfCTU+cE/5
	5JSaeKfljBcxXAW1NhYX1/ih6CJSc4skiphQJpWWTHjcTbKGY6N2kGaulSpejFH368lEua
	70gwOBwGSJtrZp6t0Ccut8BPHOX9v/c2WMCM5cOPl01F18aV81g+B8y4tSkn+1EN+yz4Pf
	J0P1KlokKjtL0yZE5g0ZyGYClpHHHL+tP4et8n60qp1+9TnNCBJo36Aj8fY5KA==
From: Daniel Wagner <dwagner@suse.de>
Date: Fri, 21 Jun 2024 15:53:12 +0200
Subject: [PATCH 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-isolcpus-io-queues-v1-3-8b169bf41083@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
In-Reply-To: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_065331_005158_D1FC0149 
X-CRM114-Status: GOOD (  15.85  )
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

group_cpus_evenly distributes all present CPUs into groups. This
ignores the isolcpus configuration and assigns isolated CPUs into the
groups.

Make group_cpus_evenly aware of isolcpus configuration and use the
housekeeping CPU mask as base for distributing the available CPUs into
groups.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 lib/group_cpus.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..f1517a44abc9 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #ifdef CONFIG_SMP
 
@@ -330,7 +331,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 }
 
 /**
- * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * group_possible_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
  *
  * Return: cpumask array if successful, NULL otherwise. And each element
@@ -344,7 +345,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+static struct cpumask *group_possible_cpus_evenly(unsigned int numgrps)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
@@ -423,6 +424,65 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	}
 	return masks;
 }
+
+static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
+					      const struct cpumask *cpu_mask)
+{
+	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk;
+	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_nmsk;
+
+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
+	build_node_to_cpumask(node_to_cpumask);
+
+	ret = __group_cpus_evenly(0, numgrps, node_to_cpumask, cpu_mask, nmsk,
+				  masks);
+
+fail_node_to_cpumask:
+	free_node_to_cpumask(node_to_cpumask);
+
+fail_nmsk:
+	free_cpumask_var(nmsk);
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
+}
+
+/**
+ * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ *
+ * Return: cpumask array if successful, NULL otherwise. And each element
+ * includes CPUs assigned to this group
+ *
+ * @group_possible_cpus_evently is used for distributing the cpus
+ * on all possible cpus in absence of isolcpus command line argument.
+ * If the isolcpus argument is used with io_queue option only
+ * the housekeeping CPUs are considered.
+ */
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	const struct cpumask *io_queue_mask;
+
+	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	if (!cpumask_empty(io_queue_mask))
+		return group_mask_cpus_evenly(numgrps, io_queue_mask);
+	else
+		return group_possible_cpus_evenly(numgrps);
+}
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {

-- 
2.45.2


