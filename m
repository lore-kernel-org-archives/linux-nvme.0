Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A9CCCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbaUww0+uCbucAspLl2X9s3lwDDZOs3w6iMH7m7wD+Y=; b=vWI99XNHmdHhSUFYpLuFKUINKm
	P0rpadql4JdkbSLipBXNjdrGGDPy8l0KBQNv4j902Idc0ugW1BupUIuAUFeQmrgialbZ//6VzSSz/
	a9uBfXQo21fxfF1EOlOhWf/J8Tz5EK9+Hy6E57QqkDWmPVj6UnamBn9HSa2MqCi5lgVhyUWDkobzR
	yXYFGfe0YjaxaymSKJYYr9lllt9PEbd/KLdBUKNxEm7CvQUYUT7MjFoi8EGAdonkvoDsp0yznyJ0l
	1Ufnrr1pPFVM5jOoZPTdHgebiPR3nDjj5LcVn9IiVJ8/HrFyZ0vNtFI225JgJE4FWkNXDKyEVd4XT
	Y22JrpkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3by6-0052Uu-HT; Tue, 21 Jun 2022 11:22:50 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bxr-0052OL-0s
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 11:22:36 +0000
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LS3wQ0Twwz6H6r5;
	Tue, 21 Jun 2022 19:20:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 13:22:33 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 12:22:27 +0100
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
Subject: [PATCH v2 6/6] blk-mq: Drop local variable for reserved tag
Date: Tue, 21 Jun 2022 19:15:43 +0800
Message-ID: <1655810143-67784-7-git-send-email-john.garry@huawei.com>
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
X-CRM114-CacheID: sfid-20220621_042235_252512_488450BA 
X-CRM114-Status: UNSURE (   9.67  )
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

The local variable is now only referenced once so drop it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 509c35f080a9..b8cc8b41553f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -266,7 +266,6 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
 	struct request_queue *q = iter_data->q;
 	struct blk_mq_tag_set *set = q->tag_set;
-	bool reserved = iter_data->reserved;
 	struct blk_mq_tags *tags;
 	struct request *rq;
 	bool ret = true;
@@ -276,7 +275,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	else
 		tags = hctx->tags;
 
-	if (!reserved)
+	if (!iter_data->reserved)
 		bitnr += tags->nr_reserved_tags;
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
@@ -337,12 +336,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
 	bool ret = true;
 	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
 
-	if (!reserved)
+	if (!(iter_data->flags & BT_TAG_ITER_RESERVED))
 		bitnr += tags->nr_reserved_tags;
 
 	/*
-- 
2.25.1


