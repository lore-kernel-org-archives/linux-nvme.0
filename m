Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E50C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uraumx4mnXek9G/QNFNmpy0Li7bFOTNZdvGN9MCb1zM=; b=UzFg3XJNAOk4+B4ZbSlL1K7sfw
	brcwCWFkLJEChpTREWed/vwZJFsGMRkOdONrcaw1QhW0bD+6CqlmxdkewLd9E8SxexLIO4VdkImY1
	eVov+daR1EekJjkyIvH55EZhY0Oghm+MjX4njmjCajsEm+8GHagxcz9A8Ak+TIT4jxu1l1SKN39rd
	APAKTAJWNAkMTG5OIIx5Rsh79cB5I2ouPhFiMSnJiaAoyc6qMQF7Q5/EgPcEXYvHOu4J7hUSbR8xK
	BOkozvEEejeBHB4jD6b1OkGM9j5Dl6yNdbGCOaSxthvSf4z4V10qHWo9JvjFIoa/MKH9NEhw0FlvH
	hXmLJBVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOItd-00000002EB1-1aik;
	Thu, 19 Dec 2024 15:57:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNcKL-0000000EXoG-2jTz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 18:29:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E8A0F5C3CE2;
	Tue, 17 Dec 2024 18:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A3C4CED3;
	Tue, 17 Dec 2024 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460188;
	bh=jEw2W00hJQ1lt+cTJ+qzs1E4wepHrE7BqSO1rO5WRPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fg2T7St/v8YfU2qpzV7JQguqKZ21VuLdqCSDnXtpZhe1E/4yDcm3yEvMRZsMOeYzM
	 5vUp66eT2WwpL0W/0K1D33L2GqqTbL0QmIzJ8ODYOoxrnQVI2quOOvgZOGY2O2WQnH
	 ks+eXh1WTZARtVTrjzPzTwef4rK/tJCNA2RtmKGIPG1YuM5ih6YY+/3COClq7MuHFk
	 5fJldEHT+48JpzBaL78xmuZajblNhHjPw0IZmy4zkXaF5mWhpIqgxuO8GwgAZTDSSL
	 T48xkQHtP6zxb24x4wJWXZAoPJmmRDZBeCmGXY87GT1sh4Q2Ej08IsLbwHf6T0XpWv
	 MVbbrGI9Dlp8g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Dec 2024 19:29:36 +0100
Subject: [PATCH v4 2/9] sched/isolation: document HK_TYPE housekeeping
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-isolcpus-io-queues-v4-2-5d355fbb1e14@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
In-Reply-To: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Don Brace <don.brace@microchip.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_102949_773980_DFC64939 
X-CRM114-Status: GOOD (  10.19  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

The enum is a public API which can be used all over the kernel. This
warrants a bit of documentation.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/sched/isolation.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fad0fd0ef1ad759fe44695dc635e8c..6649c3a48e0ea0a88c84bf5f2a74bff039fadaf2 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -6,6 +6,19 @@
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
+ */
 enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,

-- 
2.47.1


