Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A98E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0u8PYpNnPUCNq0zyEYP0/BWBineln/SEGUV0d46HlI=; b=L13CNUBuJWf8mbQFdeSwE2iqus
	xx2PXC9Bc7xdJ4QGKF28GAUNHEtpoil0P/l0lmNPAzXJ98fvEgRFKzLsgxvlaOfEqa/OEgzeXRGyf
	n9kDWVENh2plN18I7NM1/FJXu1yp5VUwPPBgoW7ZezmYYH19uPDshF+s7LfyE5VMtbpXAZACRuE13
	+TJKj3APMo7jnArw6+j25zwYabi1gyoMNTFnqNU1RdEbjOlkvC1oksi3EYBGt1uxzJnhNW4sU1w6U
	IwkFFZXLA8nQFHBpp/FqrAmVyMZrrc7PKgznaPzuH27u2aa+Lr0a4MuHhvehTCaefoBYVZsnQ/KjH
	yprIJmrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHv5-0000000GGf3-38Af;
	Fri, 10 Jan 2025 16:31:35 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqd-0000000GEy1-2qr7
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:27:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 67459A426B8;
	Fri, 10 Jan 2025 16:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E13C4CED6;
	Fri, 10 Jan 2025 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526418;
	bh=2WOikGN/ZqobQqHz6R5F6l81bCwlMDfxRu+pSaWFjzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QwU9t/0nxb9qVso7q/8qOHCxbw3XJ06xXtDuidpB3Tg1BXgS0D3ZJxnFV/7hjC4rE
	 /lKP/IL569W8mJGxXaq4Em1yJTxk6mzSx3P7nvOhBIbrMy4Z/rd4sGpFAg5B40C2eY
	 IFPMxV0xAZVh3k0RY3YngN/+4EK87qSmY73dbheISoK63GL/klDISwivJ3F8WzkzYz
	 jABk+o6gHzGxMzPUNPP5hvjLzjvgmWAxKNoKmI/LjnVaYYLqf9mzwle86xrAUD1nVe
	 scBeTPVZYFajjLNU3yKHPTdxYExO+RzyqA4uqaE/uqtgf5WG34iW1ySVgh7m2MolVB
	 yDFj55MlmiRNw==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:43 +0100
Subject: [PATCH v5 5/9] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-5-0e4f118680b0@kernel.org>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
In-Reply-To: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_082659_784143_914CEDFD 
X-CRM114-Status: GOOD (  14.79  )
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

Multiqueue devices should only allocate queues for the housekeeping CPUs
when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Use helpers which calculates the correct number of queues which should
be used when isolcpus is used.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 5 ++---
 drivers/scsi/virtio_scsi.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 71a7ffeafb32ccd6329102d3166da7cbc8bc9539..c5b2ceebd645659d86299d07224d85bb7671a9a7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -976,9 +976,8 @@ static int init_vq(struct virtio_blk *vblk)
 		return -EINVAL;
 	}
 
-	num_vqs = min_t(unsigned int,
-			min_not_zero(num_request_queues, nr_cpu_ids),
-			num_vqs);
+	num_vqs = blk_mq_num_possible_queues(
+			min_not_zero(num_request_queues, num_vqs));
 
 	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 60be1a0c61836ba643adcf9ad8d5b68563a86cb1..46ca0b82f57ce2211c7e2817dd40ee34e65bcbf9 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -919,6 +919,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
 	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
+	num_queues = blk_mq_num_possible_queues(num_queues);
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 

-- 
2.47.1


