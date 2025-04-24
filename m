Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A5AC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6svzt1x1mC554bsRoRw8kg4s3922MIrLQnEZlc5Y/4=; b=PIxqSOY/gGzYFtvMgYjg22AMUH
	lWJDg/oFL6OgWNc6Q1U2e0POFIbB26SVoaQFoJh90+rRTglGyvV+wss2WGNkuNdQaJwrZVaal6bT0
	PNB0rmlsZ1zljsAbFkda2qwgKl6IJ7JPM0aiipVpasZoPr/YRisZ7qHVDZvFztk/nb2zku4Gj6vVe
	gIL3W9RMlYxsB8IDl6nDXUPCVsjKqdX8d/nB6oltCHRb4O88E2eeATpVbBxKvSDxYf1q3R8OlqN8f
	gJej1lycnDVWTg/MDK8L+Ffc4BB5Tg7IhOuR5EgGPo77Kfv7M/6FUpoRv4a9H/9IwIBzvQswaGQ2q
	eGifgXDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81B9-0000000F02E-1Mnc;
	Thu, 24 Apr 2025 18:20:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81B6-0000000Ezxs-090f
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:20:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09CD74A717;
	Thu, 24 Apr 2025 18:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4049C4CEEE;
	Thu, 24 Apr 2025 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518803;
	bh=ESLdMXYBM3B8MU09r7uQESEbFY24U9of5fSwsUyPBL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WSddQFb9HoKtNj6oN8xQVX7nVnG+gaRSYoD7m8LEVY3dlkMKfMZkSXpjhcca8ycRg
	 03cQHbU7111SE9ATw/9KS29owS6bvX/iWpOcrwwWOwbLO6sJN2RV9Ja+iPw9cVgijj
	 UeMPYH1J7Oon7hLiTMvqbiTeF/tBqbjvz4gibIgBqfPP7qtjteQMbIMFmBG5ZmQycU
	 xf9bZDpIJ4yu8iQ/2OTfWPk/OK0m0kdItX+XqhGlOYRZKh8ycg8JYZTUvUVZL78lVN
	 Yn24hf+C8wGB7Y2Z5CRVBOgTiqpLEzmakSCboCh7qsT2KF2l73scWgmAEUQWO+WVS4
	 BY+yOrg3h2f+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 24 Apr 2025 20:19:45 +0200
Subject: [PATCH v6 6/9] isolation: introduce io_queue isolcpus type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-isolcpus-io-queues-v6-6-9a53a870ca1f@kernel.org>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_112004_116166_897A8BBD 
X-CRM114-Status: GOOD (  13.38  )
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

Multiqueue drivers spreading IO queues on all CPUs for optimal
performance. The drivers are not aware of the CPU isolated requirement
and will spread all queues ignoring the isolcpus configuration.

Introduce a new isolcpus mask which allows the user to define on which
CPUs IO queues should be placed. This is similar to the managed_irq but
for drivers which do not use the managed IRQ infrastructure.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b583b8a1c91574446382f093bccdb1..6b6ae9c5b2f61a93c649a98ea27482b932627fca 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -9,6 +9,7 @@
 enum hk_type {
 	HK_TYPE_DOMAIN,
 	HK_TYPE_MANAGED_IRQ,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MAX,
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 81bc8b329ef17cd3a3f5ae0a20ca02af3a1a69bc..687b11f900e31ab656e25cae263f15f6d8f46a9a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -11,6 +11,7 @@
 enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
@@ -224,6 +225,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "io_queue,", 9)) {
+			str += 9;
+			flags |= HK_FLAG_IO_QUEUE;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.

-- 
2.49.0


