Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A95C52D76
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGHIibLh7VAu9I4NPj8HyvkwsyByHUpfbBbGy49uXs8=; b=qSEsWaoZS8NtNC0LSRXKknPx1K
	y4HuyK9MGnj8FqU45GztMiWttQhCySeQqA1YNeWhBnzwCgJy/gzKubMiJAWsKfjXLPRG8kxT/vQJw
	uJDcp91kGeF0ohm9Ads+UjywORQ8DyFRsHr48+wp7xb5Yf8Kb65SMYiHP066u+X1Rz5yOz8HpKpFE
	avbqwdIpy0oAkl2srYTKVoveAO4Ocjb2IZFVUVDiojISl3F4cqOxUWWnv18/jb9L40NCZkZ/olD5m
	/DwXJWF0WZFEmowFLrkV5GYNnC/5aMBTFg6P/IGf1aSCzEkj6pewS6lvR4OQp+LxQNuzHnj0EjdpV
	gJk5s3zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXf-000000023C2-0zeF;
	Tue, 06 Aug 2024 14:52:03 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyQ-00000001R0l-28P5
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:32 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DD50DAE1D;
	Tue,  6 Aug 2024 14:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HGHIibLh7VAu9I4NPj8HyvkwsyByHUpfbBbGy49uXs8=;
	b=v2ETkv+BBkWSAxgMFSEQzaS4FkIjHuM35t/9M3xy6fA0tFeZkNYnxxHcGAssFmbjzBrf+E
	bwOIH6tKTIxeZcwItusD7HyJV4lFWqvogq/eZAP2F2S96QY+RTkvbGf+PPr50yM0Z1+IhK
	vIkfb2fBqatq3jg1t/MF47GnwBZsHRrK2ZEmAMRKz9VHewQdMldpAqFYsKeUcC3ACMhBzP
	HjaZWUkPI3kU+mQhBlSwy9BCVcNSZYSb2qZAaMukwR3xs1LvxgbbpUALG5cXEG8tRkAid1
	rzIm1IB4dvY6e0bWnvPYcnrBedr/C30z6+7T5pEOKGxPsrqVsMR+kjfcBFH9Ew==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:40 +0200
Subject: [PATCH v3 08/15] sched/isolation: Add io_queue housekeeping option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-8-da0eecfeaf8b@suse.de>
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
X-CRM114-CacheID: sfid-20240806_050730_729313_CE3937C1 
X-CRM114-Status: GOOD (  11.86  )
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

Multiqueue drivers such as nvme-pci are spreading IO queues on all CPUs
for optimal performance. isolcpu users are usually more concerned about
noise on isolated CPUs. Introduce a new isolcpus mask which allows the
user to define on which CPUs IO queues should be placed.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 include/linux/sched/isolation.h | 15 +++++++++++++++
 kernel/sched/isolation.c        |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..0101d0fc8c00 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -6,6 +6,20 @@
 #include <linux/init.h>
 #include <linux/tick.h>
 
+/**
+ * enum hk_type - housekeeping cpu mask types
+ * @HK_TYPE_TIMER:	housekeeping cpu mask for timers
+ * @HK_TYPE_RCU:	housekeeping cpu mask for RCU
+ * @HK_TYPE_MISC:	housekeeping cpu mask for miscalleanous resources
+ * @HK_TYPE_SCHED:	housekeeping cpu mask for scheduling
+ * @HK_TYPE_TICK:	housekeeping cpu maks for timer tick
+ * @HK_TYPE_DOMAIN:	housekeeping cpu mask for general SMP balancing
+ *			and scheduling algoririthms
+ * @HK_TYPE_WQ:		housekeeping cpu mask for worksqueues
+ * @HK_TYPE_MANAGED_IRQ: housekeeping cpu mask for managed IRQs
+ * @HK_TYPE_KTHREAD:	housekeeping cpu mask for kthreads
+ * @HK_TYPE_IO_QUEUE:	housekeeping cpu mask for I/O queues
+ */
 enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,
@@ -16,6 +30,7 @@ enum hk_type {
 	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_KTHREAD,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_MAX
 };
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..91d7a434330c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -18,6 +18,7 @@ enum hk_flags {
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -228,6 +229,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
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
2.46.0


