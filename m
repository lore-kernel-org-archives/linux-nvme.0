Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07C764E17
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07C764E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oPBDsSme92CbROb3NZQ9JzXIrMXjNy0V969oqOsU/+g=; b=BqWdRJ1dwjTrtaQN0/AtLCAPa
	Ur/O0lPz45qEl+N6KrZ3qkCVrI4/Hq7KaLaIKCa2ieXlT7VAZg8kcqDW2F8SkE+BmAft0KoSsQKgN
	7Z08NCtxaNfZfpsze8k3JGKnR9qQjK9HPMIDHmAvfb0D5QW7clhb79jM1wXtpo2v4IJ9/UJhrhH8G
	a4oQmS3Nam6+FjUZCic+f6HNsrrxd6RtAhO/QiM6BuuNARX9d5sX50z8yDYhGGtoTNwnNDRoRUoB1
	k/3Jl6lVe4b8AwXNSQCIrn+ZOoHAsGHQG93/f3hlHiCTXpTmsAEwzS0SVrfkLjUbM9CdToStRjTuX
	5P4nNsU0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5BbR-0006zJ-3t; Thu, 28 Jan 2021 18:01:09 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5BbO-0006ym-8x
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 18:01:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E9313A1;
 Thu, 28 Jan 2021 10:01:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34273F719;
 Thu, 28 Jan 2021 10:00:59 -0800 (PST)
Subject: Re: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
To: Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
 marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
 gregkh@linuxfoundation.org, saravanak@google.com,
 heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
 andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
 bgolaszewski@baylibre.com, jroedel@suse.de,
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-4-jxgao@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com>
Date: Thu, 28 Jan 2021 18:00:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128003829.1892018-4-jxgao@google.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_130106_454761_A05A6E7E 
X-CRM114-Status: GOOD (  24.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

On 2021-01-28 00:38, Jianxiong Gao wrote:
> NVMe driver relies on the address offset to function properly.
> This patch adds the offset preserve mask to NVMe driver when mapping
> via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> depends on the page size defined by CC.MPS register of NVMe
> controller.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>   drivers/nvme/host/pci.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 856aa31931c1..0b23f04068be 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>   static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> +	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
>   				    rq_dma_dir(req));
>   	else
>   		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> +	if (dma_set_page_offset_mask(dev->dev, 0))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
>   }
>   
>   static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> @@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   	blk_status_t ret = BLK_STS_RESOURCE;
> -	int nr_mapped;
> +	int nr_mapped, offset_ret;
>   
>   	if (blk_rq_nr_phys_segments(req) == 1) {
>   		struct bio_vec bv = req_bvec(req);
> @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	if (!iod->nents)
>   		goto out_free_sg;
>   
> +	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
> +		goto out_free_sg;
> +	}
> +
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>   				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>   	else
>   		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>   					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
> +		goto out_free_sg;

If it were possible for this to fail, you might leak the DMA mapping 
here. However if dev->dma_parms somehow disappeared since a dozen lines 
above then I think you've got far bigger problems anyway.

That said, do you really need to keep toggling this back and forth all 
the time? Even if the device does make other mappings elsewhere that 
don't necessarily need the same strict alignment, would it be 
significantly harmful just to set it once at probe and leave it in place 
anyway?

Robin.

> +	}
>   	if (!nr_mapped)
>   		goto out_free_sg;
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
