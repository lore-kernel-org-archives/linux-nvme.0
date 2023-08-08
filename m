Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B72C04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9r/GcSpKKC2dt0ISzH0rvZ1VrInscXGexGqDsV7Zgfk=; b=FMo263/120Xp3OOLeIVSOcR3Vw
	ZfCwcxkZXMgNIEL6rT8jJ5njnl4EfbdVyBmuTzpw/TSNuWv7rlizjadquYmW5/s5v+CnJY/qED15b
	7TSgqShWfRE3L2X1l9D8lNwjX9SSIVhaskkBZg/w8iWWvh1a0QI8HlK82UPRRcOoQjJ/u7JnR0qyF
	n1obCNjgAhLPE4x4x6X6MTruW+S4rDuMPugIKwuzZYklw38vP5EHMp21aYmKNYz1nEQOik3L+RPnj
	B4bvIgi2FrTG61E3d68O3GkzK/83h2wc9baKFoF/iTQVpIYziUoKxIJ+DfD92GFjqAbMspayY2TBF
	L4piquJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKG8-002NUb-1P;
	Tue, 08 Aug 2023 10:48:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKG4-002NQx-1M
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:48:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9r/GcSpKKC2dt0ISzH0rvZ1VrInscXGexGqDsV7Zgfk=;
	b=SrkUcsj9wFDCA7ucpSljeYGbv6cBZl1+KANsvdOntJ+jDZPNJbBy+//JfWX4bxrF3qUBlw
	IRHX+/hqGlgWqpVE7TveE+buJ7q/p5bFDcogpba2slwS0akEi95A0gXeNULs1Whq4AIzIl
	4l1Kt2S3h4JGFm/iH5KdNbNupV32hkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-MBMMJmWsMYifeEoAwq7xkg-1; Tue, 08 Aug 2023 06:48:09 -0400
X-MC-Unique: MBMMJmWsMYifeEoAwq7xkg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 354F4185A7A5;
	Tue,  8 Aug 2023 10:43:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 62944401061;
	Tue,  8 Aug 2023 10:43:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH V3 04/14] virtio-blk: limit max allowed submit queues
Date: Tue,  8 Aug 2023 18:42:29 +0800
Message-Id: <20230808104239.146085-5-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034812_572639_6B8FAA7D 
X-CRM114-Status: GOOD (  15.10  )
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

Take blk-mq's knowledge into account for calculating io queues.

Fix wrong queue mapping in case of kdump kernel.

On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
`Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1fe011676d07..4ba79fe2a1b4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1047,7 +1047,8 @@ static int init_vq(struct virtio_blk *vblk)
 
 	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
 
-	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = min_t(unsigned,
+			num_vqs - num_poll_vqs, blk_mq_max_nr_hw_queues());
 	vblk->io_queues[HCTX_TYPE_READ] = 0;
 	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
 
-- 
2.40.1


