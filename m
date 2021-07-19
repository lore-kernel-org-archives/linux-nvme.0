Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB78C12002
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD3761164
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD3761164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YqE9nCyIHUeDQVmWdTQzs+ghFSoFmX3p0SEPA3dHas=; b=UCvZhEdYe18r5LJDp9sLTAAff+
	UNdW4NwsYRZiehijXxkRMlkuPAKkuzY+cqUJF7fLaa9VgjCQ+zsMi1OXWg1SX7OZ2KzIOuTdnBuoR
	9KjWNRz4L94AXS+ZqerDmYScGd/NLUqjLDBscHZqKRPCCbucPl2549eIKAulRkAH87ahRg4TANUa2
	qrsK0Dyfbdq+ACzn1VGAHclx9TH62IDLOref++eMVIr4UUL1oxvh9P7f0YjsQqsL55dKkQAVoNU0U
	Zn1+n2cRbCb3iKPG3oRJeiAUO9VgWmRLNX7TRLJvrtS00KhvZkHqq7qdwzoWSDL3TcNRx5izvPOlq
	DxLV86NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5O3y-008g78-2y; Mon, 19 Jul 2021 07:51:42 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5O3i-008g1W-FP
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 07:51:28 +0000
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GStvX0hMDz6D8Zn;
 Mon, 19 Jul 2021 15:36:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 09:51:20 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 08:51:19 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>, "Hannes
 Reinecke" <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
Date: Mon, 19 Jul 2021 08:51:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210715120844.636968-2-ming.lei@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_005126_822443_784E7763 
X-CRM114-Status: GOOD (  23.21  )
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

On 15/07/2021 13:08, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info because managed irq will be shutdown when all
> CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers(pci subsystem,
> platform device, ...), and it is consumed by blk-mq, so different subsystems
> are involved in this info flow
> 
> Address this issue by adding one field of .irq_affinity_managed into
> 'struct device'.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Did you consider that for PCI device we effectively have this info already:

bool dev_has_managed_msi_irq(struct device *dev)
{
	struct msi_desc *desc;

	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
		if (desc->affinity && desc->affinity->is_managed)
			return true;
	}

	return false;
}

Thanks,
John

> ---
>   drivers/base/platform.c | 7 +++++++
>   drivers/pci/msi.c       | 3 +++
>   include/linux/device.h  | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8640578f45e9..d28cb91d5cf9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
>   				ptr->irq[i], ret);
>   			goto err_free_desc;
>   		}
> +
> +		/*
> +		 * mark the device as irq affinity managed if any irq affinity
> +		 * descriptor is managed
> +		 */
> +		if (desc[i].is_managed)
> +			dev->dev.irq_affinity_managed = true;
>   	}
>   
>   	devres_add(&dev->dev, ptr);
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3d6db20d1b2b..7ddec90b711d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   	if (flags & PCI_IRQ_AFFINITY) {
>   		if (!affd)
>   			affd = &msi_default_affd;
> +		dev->dev.irq_affinity_managed = true;
>   	} else {
>   		if (WARN_ON(affd))
>   			affd = NULL;
> @@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   			return nvecs;
>   	}
>   
> +	dev->dev.irq_affinity_managed = false;
> +
>   	/* use legacy IRQ if allowed */
>   	if (flags & PCI_IRQ_LEGACY) {
>   		if (min_vecs == 1 && dev->irq) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 59940f1744c1..9ec6e671279e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -569,6 +569,7 @@ struct device {
>   #ifdef CONFIG_DMA_OPS_BYPASS
>   	bool			dma_ops_bypass : 1;
>   #endif
> +	bool			irq_affinity_managed : 1;
>   };
>   
>   /**
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
