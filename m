Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0934FC49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01SA/ETFeIEmF8ZNMro6rqmj4KMi2qeg7vDPqXd61VM=; b=OJFjzTMmVwPmhDgb7i/NLGM1TX
	Z1zPODxN7G9CErEJXlxhu8mlPbXjIPXFICtQcbdHQxD/7WDtAebAISrdVmUSOhnjjAB5txhLqYlrW
	+Qgn/CWrm+H1knY1F1n9C7wmpo/tvrzbSLCSPu6SIJts0wZQuQmzOowDC4QsDp8axJmQRReMGrAEY
	HnxXRbBQf+Lipmjk6ejmer+0uvqGSfqJcUAhYz9n6gkea+wMVll87Z8NpIS+fpvQAbPkKuWbC4zRq
	XhAqSRPqJZV7vVfjAVbTyf/iQC1qvHm6pKdwg44cNhlIkaHyJk2Bl+4NVKI+peCltLyJrAJhckE9Y
	GwRVcf/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXy-000000023Ti-0icX;
	Tue, 06 Aug 2024 14:52:22 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyd-00000001RAC-20tB
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:45 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73D8EDAE26;
	Tue,  6 Aug 2024 14:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946061; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=01SA/ETFeIEmF8ZNMro6rqmj4KMi2qeg7vDPqXd61VM=;
	b=VjldReTTsvbzIN95Vq7AR8slamM5p2g4sQfg3Dcmn8w5s6JxmyoSZxLf9FagVrJwLPYqyR
	n1OHyeA2juHr4ozqwNPUdJRdoRwAGfB1B9msvQ8lm+P2mNG/b56199hUA2PR2iRRRqgqiG
	bdY3ZIf8J2Kdz0zSwrIg00V18ZVksTg7QIfvwhyZUqvUGOvFDn7UpK9xZCmUYmNrkY4jjO
	sIWS2vGZ201IrldvsmGqfNRLXzwgL0crclR2FvFoY8btS3HkswCqYGRsPtoxfEGmIDz+2L
	EgFZkXoREXIU5gtJU/v+9xNkEEMJ1rbJLUh4qtWmp2uMkS9ZwXLguWeFBIF5QA==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:46 +0200
Subject: [PATCH v3 14/15] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-14-da0eecfeaf8b@suse.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-doc@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_050743_849187_2F06F14E 
X-CRM114-Status: GOOD (  16.88  )
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

group_cpus_evenly distributes all present CPUs into groups. This ignores
the isolcpus configuration and assigns isolated CPUs into the groups.

Make group_cpus_evenly aware of isolcpus configuration and use the
housekeeping CPU mask as base for distributing the available CPUs into
groups.

Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 lib/group_cpus.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..713c9fdd774a 100644
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
@@ -423,6 +424,76 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	}
 	return masks;
 }
+
+/**
+ * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ * @cpu_mask: CPU to consider for the grouping
+ *
+ * Return: cpumask array if successful, NULL otherwise. And each element
+ * includes CPUs assigned to this group.
+ *
+ * Try to put close CPUs from viewpoint of CPU and NUMA locality into
+ * same group. Allocate present CPUs on these groups evenly.
+ */
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
+ * Return: cpumask array if successful, NULL otherwise.
+ *
+ * group_possible_cpus_evently() is used for distributing the cpus on all
+ * possible cpus in absence of isolcpus command line argument.
+ * group_mask_cpu_evenly() is used when the isolcpus command line
+ * argument is used with managed_irq option. In this case only the
+ * housekeeping CPUs are considered.
+ */
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	const struct cpumask *hk_mask;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	if (!cpumask_empty(hk_mask))
+		return group_mask_cpus_evenly(numgrps, hk_mask);
+
+	return group_possible_cpus_evenly(numgrps);
+}
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {

-- 
2.46.0


