Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B2E7718E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPEL7rkAL7uKLl1dkPPvbC39E4DX31WvLrM0OuuB73M=; b=V2DUReBf9IwSIxeKQH7bgj2T8C
	ddx+gXQCnDK/d2rQ5wU0+VSm9OX2xKnW0ttX/4tGhtL6tgg/UZR+oXoZSkzXcaOrO6pykDkrhSMI5
	6MjwlHGnfCOFBgz997BEw0htiuiws8e71LjIm78XnFEPUx3yT5oOxazVI0SOS8cmc3XH1eJVrHrr+
	hes7KOtfBA47iSxkjUd+0G5qvH+2eKxvAOM8RSgsUY4zIJ7i8o946Hh1lyb/VhXcypOKgcZg1dhDG
	rd5rGgVXqoV+xRvIHYEEjKiXGnk8qwu5OiCNdxtjontjTZ60rQGLF9tFvUpJN2qFBU1ol+WxUWzW3
	/xW1TUxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOIti-00000002EGB-2dg0;
	Thu, 19 Dec 2024 15:57:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNcKd-0000000EXzY-1DVF
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 18:30:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CBA98A41F4C;
	Tue, 17 Dec 2024 18:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEDBC4CED7;
	Tue, 17 Dec 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460206;
	bh=6NgFV7+SLJHkzCci3gNbm7cBYHWTyZIkNamwDIlbLeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6Kv27+RnXSPrl2jQCg0fkmNWjHVSiB/hAypqxFY66hSV7caMFNcFSK9tefnE2j9D
	 4VbA1/GbM9ZVKy8tWqx699sdcqv9NCX8Pbgz/cDonCQ1O4uhOltf/ng8vOftMg8qLI
	 lmxKzV9+CUUzhx85La7dhEaQgYdecAI5Ogz0N/F6chL7REarIP7YADQY4s+x45YeFH
	 vV5ptlSjGSqA+RYyXOk99DPYju/HT35KkViwL5WI2VvpjJK6uNHYY5ZLa1KLPSUkk7
	 xMfjlLKxelpJ/H5zZtseSfB/nl/OowQ7AE/vSLMPBeemE+TXvoPmt90w9y20mhLuQh
	 bglrtOGwWgJRA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Dec 2024 19:29:43 +0100
Subject: [PATCH v4 9/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
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
X-CRM114-CacheID: sfid-20241217_103007_468499_BF6C1C7E 
X-CRM114-Status: GOOD (  16.71  )
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

When we offlining a hardware context which also serves isolcpus mapped
to it, any IO issued by the isolcpus will stall as there is nothing
which handles the interrupts etc.

This configuration/setup is not supported at this point thus just issue
a warning.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index de15c0c76f874a2a863b05a23e0f3dba20cb6488..f9af0f5dd6aac8da855777acf2ffc61128f15a74 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3619,6 +3619,45 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static void blk_mq_hctx_check_isolcpus_online(struct blk_mq_hw_ctx *hctx, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+	int i;
+
+	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
+		return;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+
+	for (i = 0; i < hctx->nr_ctx; i++) {
+		struct blk_mq_ctx *ctx = hctx->ctxs[i];
+
+		if (ctx->cpu == cpu)
+			continue;
+
+		/*
+		 * Check if this context has at least one online
+		 * housekeeping CPU in this case the hardware context is
+		 * usable.
+		 */
+		if (cpumask_test_cpu(ctx->cpu, hk_mask) &&
+		    cpu_online(ctx->cpu))
+			break;
+
+		/*
+		 * The context doesn't have any online housekeeping CPUs
+		 * but there might be an online isolated CPU mapped to
+		 * it.
+		 */
+		if (cpu_is_offline(ctx->cpu))
+			continue;
+
+		pr_warn("%s: offlining hctx%d but there is still an online isolcpu CPU %d mapped to it, IO stalls expected\n",
+			hctx->queue->disk->disk_name,
+			hctx->queue_num, ctx->cpu);
+	}
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3638,8 +3677,10 @@ static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 			continue;
 
 		/* this hctx has at least one online CPU */
-		if (this_cpu != cpu)
+		if (this_cpu != cpu) {
+			blk_mq_hctx_check_isolcpus_online(hctx, this_cpu);
 			return true;
+		}
 	}
 
 	return false;

-- 
2.47.1


