Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9698C07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748A260200
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748A260200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+eK6iJrcoSmddOCUT5MGZsU6Nt+7bEj+9H580SOtB0=; b=l1MiwgJ/XBPBot7X78IJBd6Cfa
	w/+vgwGSbbQ2ttPnTc34/3AikhMLgUKZIAxC2HfHsjqMKWXPdvvZGNcEtEspm/HGfBzmr1tkY9O8v
	as99DKD49mxHhx/Fpu7jBa7LutNpbWZ4W/V+Q1zqLm6AnLfmX1/2sZOZpAeRoQKXpQ07zf+/EPwkC
	BhIoHPE6OyqxXmz8nuovDm69zkcO/wb2FkTrVt3hSsGtTYmEawFMLwqvjM1ROhffiLOko3sVfmSz7
	Ui4cVdfHLloUDARuE66Y9dTwYRzxFaNYOzap6FZWL2koq3VM0UXzWqsF0jqV5oiDnb1QKPihPoBRd
	VxkbqKPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Qgo-009ICX-5K; Mon, 19 Jul 2021 10:39:58 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Qgl-009IAZ-4t
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 10:39:56 +0000
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GSydy5Btxz6D8wM;
 Mon, 19 Jul 2021 18:25:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 19 Jul 2021 12:39:50 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 11:39:50 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To: Christoph Hellwig <hch@lst.de>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner
 <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke
 <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
Date: Mon, 19 Jul 2021 11:39:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210719094414.GC431@lst.de>
Content-Language: en-US
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_033955_370281_5B29EECF 
X-CRM114-Status: GOOD (  19.84  )
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

On 19/07/2021 10:44, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>>> Address this issue by adding one field of .irq_affinity_managed into
>>> 'struct device'.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Did you consider that for PCI device we effectively have this info already:
>>
>> bool dev_has_managed_msi_irq(struct device *dev)
>> {
>> 	struct msi_desc *desc;
>>
>> 	list_for_each_entry(desc, dev_to_msi_list(dev), list)

I just noticed for_each_msi_entry(), which is the same


>> 		if (desc->affinity && desc->affinity->is_managed)
>> 			return true;
>> 	}
>>
>> 	return false;
> 
> Just walking the list seems fine to me given that this is not a
> performance criticial path.  But what are the locking implications?

Since it would be used for sequential setup code, I didn't think any 
locking was required. But would need to consider where that function 
lived and whether it's public.

> 
> Also does the above imply this won't work for your platform MSI case?
> .
> 

Right. I think that it may be possible to reach into the platform msi 
descriptors to get this info, but I am not sure it's worth it. There is 
only 1x user there and there is no generic .map_queues function, so 
could set the flag directly:

int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev 
*pdev,
  		for_each_cpu(cpu, mask)
  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
  	}
+	qmap->use_managed_irq = dev_has_managed_msi_irq(&pdev->dev);
}

--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3563,6 +3563,8 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
                        qmap->mq_map[cpu] = qmap->queue_offset + queue;
        }

+       qmap->use_managed_irq = 1;
+
        return 0;
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
