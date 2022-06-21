Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC28CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tycmKxVKcU9O/iAG9UdP9GRWtyIedZHEa8v6sPek/Ew=; b=VnC1NwOagUG3Gc6zSvkTd7n6a+
	jPkoychZto545Ki1z1hYsuOekia6pW2glCwuIJYoaqt36LH3/I7RM+Z5Vz4IH65FwbvDTP4mXlCUf
	R5XVkQVgZAfi22RkyOhqQHrySOJYjvPH9ljVzxsRY886BZkxHeHW9wG2DlcYc+M0mZ4tuyC2ReVvy
	38JnjSq/VYe9Ti+M7eZan1f9d5BQ/8vdgx6M14A1ktDiOF9JJoL7zFF3GGje6xLHXobJJRQo8JxaY
	DdM+j0+OofFbTMwMWWi++/8JNAtRwLXRIoA9QIezKMP2O3urVDvYfEwIDyMlfErTDRHdVZRIVoI4P
	PNaBS5BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bxd-0052LU-Qa; Tue, 21 Jun 2022 11:22:21 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bxa-0052KM-Gu
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 11:22:20 +0000
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LS3xn14Wbz689td;
	Tue, 21 Jun 2022 19:21:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 13:22:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 12:22:06 +0100
From: John Garry <john.garry@huawei.com>
To: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
	<sebaddel@cisco.com>, <kartilak@cisco.com>
CC: <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nbd@other.debian.org>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH v2 2/6] blk-mq: Add a flag for reserved requests
Date: Tue, 21 Jun 2022 19:15:39 +0800
Message-ID: <1655810143-67784-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_042218_744222_A49326B6 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

Add a flag for reserved requests so that drivers may know this for any
special handling.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5aa95964191b..d38c97fe89f5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -474,6 +474,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (!(data->rq_flags & RQF_ELV))
 		blk_mq_tag_busy(data->hctx);
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
@@ -588,6 +591,9 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	else
 		data.rq_flags |= RQF_ELV;
 
+	if (flags & BLK_MQ_REQ_RESERVED)
+		data.rq_flags |= RQF_RESV;
+
 	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..6d81fe10e850 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,6 +57,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 /* queue has elevator attached */
 #define RQF_ELV			((__force req_flags_t)(1 << 22))
+#define RQF_RESV			((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -823,6 +824,11 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
 }
 
+static inline bool blk_mq_is_reserved_rq(struct request *rq)
+{
+	return rq->rq_flags & RQF_RESV;
+}
+
 /*
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
-- 
2.25.1


