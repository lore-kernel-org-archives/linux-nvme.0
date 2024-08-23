Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F249C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixrJ6JmQGZ7Xczw7QEVI0LeUBYrkzpVEyLiAzqYbGw8=; b=inANugNmxnfM6++eTxkKt8Jk0A
	MRjHqlCGjZHtw2k09LaANij6KbU0O93exVrCgKDSyc3DCqfyFpxJgJlHHD+zXaeDg5TG4v3GzC0bF
	ceiPG8djx8pLcCu1igIaE25gq7JdmuxdSBodV5nO5OPzSTIDiVrCwuDawuaUWx7W+7iluz6/4wEMv
	abldiz3qsXNLn976/kv2VykVLR3ZTWG45EanrTc5QolvnrgeMeyD9D0DURHsQMuQuX1w+XrBfqGHC
	jR8A3luy6yw1RE865pLnflQoO+PdLboQezb8lkEOTBnF4X/WBe/FTqe3s/YVNXBS9/BMi5UqhZ5bN
	o+tw7nSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPfZ-0000000FsTP-2dTp;
	Fri, 23 Aug 2024 08:29:17 +0000
Received: from bee.tesarici.cz ([37.205.15.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPWc-0000000Fq9x-3dAu
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 08:20:04 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D0DE51EF47C;
	Fri, 23 Aug 2024 10:20:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724401201; bh=ixrJ6JmQGZ7Xczw7QEVI0LeUBYrkzpVEyLiAzqYbGw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AEEDNHHPPIZTHRbuQLTaO5bYKSLdrPYLnnUqMZ9mUSFZeN2DlQWA1jp7g4zlZLrDv
	 an7eRJNknbGyaE4OAbSTR52oU/ViTySj+6C/GfxN8LaBNz1toCIrcQxWljfXg/csMX
	 zKT83/A+cTX9SULjCGIhbfVa504XyHcSIMhfp3faF5PGg8vlrw76KCLZ88cNXOWHpT
	 hmogCwKELv+0k+wcxC2D7RuNFVEV+RGLdfGy7+SEnOAfec9ZluMm38RPMAu5Qt2Pza
	 BNXLyB+7cZr6MR6Akh6/zLz3C6085c6ISmTs1AS+bt5upfeS968kVwZmlgwfmWC050
	 dW+apIxb69jMQ==
Date: Fri, 23 Aug 2024 10:19:59 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Message-ID: <20240823101959.1dfe251e@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-6-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-6-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_012003_094256_6974B8E7 
X-CRM114-Status: GOOD (  32.85  )
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

On Thu, 22 Aug 2024 11:37:16 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
> because DMA cannot be done to private (encrypted) portions of VM
> memory. The bounce buffer memory is marked shared (decrypted) at
> boot time, so I/O is done to/from the bounce buffer memory and then
> copied by the CPU to/from the final target memory (i.e, "bounced").
> Storage devices can be large consumers of bounce buffer memory because it
> is possible to have large numbers of I/Os in flight across multiple
> devices. Bounce buffer memory must be pre-allocated at boot time, and
> it is difficult to know how much memory to allocate to handle peak
> storage I/O loads. Consequently, bounce buffer memory is typically
> over-provisioned, which wastes memory, and may still not avoid a peak
> that exhausts bounce buffer memory and cause storage I/O errors.
> 
> To solve this problem for Coco VMs running on Hyper-V, update the
> storvsc driver to permit bounce buffer throttling. First, use
> scsi_dma_map_attrs() instead of scsi_dma_map(). Then gate the
> throttling behavior on a DMA layer check indicating that throttling is
> useful, so that no change occurs in a non-CoCo VM. If throttling is
> useful, pass the DMA_ATTR_MAY_BLOCK attribute, and set the block queue
> flag indicating that the I/O request submission path may sleep, which
> could happen when throttling. With these options in place, DMA map
> requests are pended when necessary to reduce the likelihood of usage
> peaks caused by storvsc that could exhaust bounce buffer memory and
> generate errors.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM, but I'm not familiar with this driver or the SCSI layer. In
particular, I don't know if it's OK to change the value of
host->queuecommand_may_block after scsi_host_alloc() initialized it
from a scsi host template, although it seems to be fine.

Petr T

> ---
>  drivers/scsi/storvsc_drv.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..7bedd5502d07 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -457,6 +457,7 @@ struct hv_host_device {
>  	struct workqueue_struct *handle_error_wq;
>  	struct work_struct host_scan_work;
>  	struct Scsi_Host *host;
> +	unsigned long dma_attrs;
>  };
>  
>  struct storvsc_scan_work {
> @@ -1810,7 +1811,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  		payload->range.len = length;
>  		payload->range.offset = offset_in_hvpg;
>  
> -		sg_count = scsi_dma_map(scmnd);
> +		sg_count = scsi_dma_map_attrs(scmnd, host_dev->dma_attrs);
>  		if (sg_count < 0) {
>  			ret = SCSI_MLQUEUE_DEVICE_BUSY;
>  			goto err_free_payload;
> @@ -2030,6 +2031,12 @@ static int storvsc_probe(struct hv_device *device,
>  	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
>  	 */
>  	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
> +
> +	if (dma_recommend_may_block(&device->device)) {
> +		host->queuecommand_may_block = true;
> +		host_dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
> +	}
> +
>  	/*
>  	 * For non-IDE disks, the host supports multiple channels.
>  	 * Set the number of HW queues we are supporting.


