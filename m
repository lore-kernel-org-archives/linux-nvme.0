Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64EC07E98
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585C561248
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C561248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KEA1Qgy7dk0LmBq7gNl0UORcsNuC/pBf6/bIlEILTm0=; b=oBZrJWvC4koMyRfY6nHcwRuJc1
	txl7XBQwPMAkh5kxm10Kh4Box/VckTsXF2/sc/hXYJGPkORvyXdDuwIqKAJtG7INrjzsARnkttqMM
	RVAP/UigBv2GIfHu2wdo0v6GYkEhoZXXFBfcQHIH3TxP6w0pVvaADQv4PrFWXkZCSBMGmL1S4eWya
	echaq4jjQnCjikSHVF6zlJJDhx7j6+p1DbfEq/3wO85phzNHQa6YMqGwvQUI6WpxpPyjct7ldIEY3
	7ZW/YgzwDMFAQOkSsMgL8y3IAiUNNiYBhfdwGZQ53btI0JbZP7Ppgw6vmuZEqzQqq7cIN9wLoxq7r
	nqTx60FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0KyE-008R3S-Hp; Mon, 05 Jul 2021 09:32:54 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0KyA-008R1Z-QU
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 09:32:52 +0000
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJKqn18Ydz6H7x1;
 Mon,  5 Jul 2021 17:18:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 11:32:45 +0200
Received: from [10.47.92.124] (10.47.92.124) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 10:32:45 +0100
Subject: Re: [PATCH V2 3/6] scsi: add flag of .use_managed_irq to 'struct
 Scsi_Host'
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-scsi@vger.kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, "Wen
 Xiong" <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-4-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com>
Date: Mon, 5 Jul 2021 10:25:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-4-ming.lei@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.47.92.124]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_023251_224793_5E37A675 
X-CRM114-Status: GOOD (  15.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/07/2021 16:05, Ming Lei wrote:
> blk-mq needs this information of using managed irq for improving
> deactivating hctx, so add such flag to 'struct Scsi_Host', then
> drivers can pass such flag to blk-mq via scsi_mq_setup_tags().
> 
> The rule is that driver has to tell blk-mq if managed irq is used.
> 
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

As was said before, can we have something like this instead of relying 
on the LLDs to do the setting:

--------->8------------

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..2037a5b69fe1 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -37,7 +37,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map 
*qmap, struct pci_dev *pdev,
  		for_each_cpu(cpu, mask)
  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
  	}
-
+	qmap->drain_hwq = 1;
  	return 0;

  fallback:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 46fe5b45a8b8..7b610e680e08 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3408,7 +3408,8 @@ static int blk_mq_update_queue_map(struct 
blk_mq_tag_set *set)
  		set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;

  	if (set->ops->map_queues && !is_kdump_kernel()) {
-		int i;
+		struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
+		int i, ret;

  		/*
  		 * transport .map_queues is usually done in the following
@@ -3427,7 +3428,12 @@ static int blk_mq_update_queue_map(struct 
blk_mq_tag_set *set)
  		for (i = 0; i < set->nr_maps; i++)
  			blk_mq_clear_mq_map(&set->map[i]);

-		return set->ops->map_queues(set);
+		ret = set->ops->map_queues(set);
+		if (ret)
+			return ret;
+		if (qmap->drain_hwq)
+			set->flags |= BLK_MQ_F_MANAGED_IRQ;
+		return 0;
  	} else {
  		BUG_ON(set->nr_maps > 1);
  		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 65ed99b3f2f0..2b2e71ff43e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -193,6 +193,7 @@ struct blk_mq_queue_map {
  	unsigned int *mq_map;
  	unsigned int nr_queues;
  	unsigned int queue_offset;
+	bool drain_hwq;
  };





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
