Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F98C04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SdkdgSqxhMyRTJ5vgJIEJL/WyHf61DHGM5o0eLsF7g=; b=RHt4ewsLibgUptJPz7HiDmysXh
	cag27jOJg06YFenDW5gYEyoCkfa3r5Txs25DGDwCXeMs+MiCJv5AEYr6WF+ga50SuHdqX7zXmbTO3
	NmGb9ANwKMhxdcAZeIaGmUA+zXcFK9NM1TCz1B2fpfuzcvHCiEcTvzffBWmKhm6igaKiTKo7enMwq
	kB1chwU4PddTBV75OFEFPylJ0/fbojMY4yWexSsrt2QJVYYcd7pbPOZtYGE+bDpshtsmVsuIUCOfq
	5Pwxw5VucY/m3ZqBSEMF+RfS8wfPJLKG48WeOjaZ/XYATskc0wkTofi1Bju4cL6L43jfSv0fn6AOQ
	h6IZwovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKB8-002JLS-0Y;
	Tue, 08 Aug 2023 10:43:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKB5-002JI4-0D
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SdkdgSqxhMyRTJ5vgJIEJL/WyHf61DHGM5o0eLsF7g=;
	b=GKrx8hL/gUe0mcHcj8kux2dtazr1jOwLW0KKDELlOBlfeST3JMdbbnqYtG08K7SH7wnCMI
	UENzhNrBvgUXzrFdEkmor8BMYVVfeT8QEeJ6DopJTbG0JzXmnxtfYHOa3zZxpCq3ZY9otX
	NMi9gVIjUhtn3S0CbEMEH9yXeoSmLLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-HN97ZHsCP7utxVyyzgqj-Q-1; Tue, 08 Aug 2023 06:42:59 -0400
X-MC-Unique: HN97ZHsCP7utxVyyzgqj-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EAA6185A78B;
	Tue,  8 Aug 2023 10:42:58 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A81182166B27;
	Tue,  8 Aug 2023 10:42:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 03/14] ublk: limit max allowed nr_hw_queues
Date: Tue,  8 Aug 2023 18:42:28 +0800
Message-Id: <20230808104239.146085-4-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034303_201899_C4D81B87 
X-CRM114-Status: GOOD (  15.29  )
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 21d2e71c5514..6cf4981951e2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2045,7 +2045,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
-			ub->dev_info.nr_hw_queues, nr_cpu_ids);
+			ub->dev_info.nr_hw_queues, blk_mq_max_nr_hw_queues());
 	ublk_align_max_io_size(ub);
 
 	ret = ublk_init_queues(ub);
-- 
2.40.1


