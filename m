Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B397FC531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4JppdwbWGFP1nVYHk+FUidvoThmdHfNE8PVWBlwh/8=; b=1NRBpnuXMHJmDSw9w2VPcEdL9q
	M0ntceNsaZJqdvqSgcJ3i7g8a/CZr1pnTDW39xK/BtP/BLcaXxnduDax8lSZjIPjFdkAdx8x14nIx
	d0ouCU1JBRd/jeEwMuCpiuwAdIjNpKDAVE27dfGD59nJFx3N6hz/oBAtG4OyzUI7+w3pHSzIh9DQx
	GUsiDGVJ9UBcIU3kvIv8QyNeb1X9kU/prlJYj3QGZWoUJPnRRNcjImKE0cokjwCpLML0XqBPFHxq0
	fm2+AdaqOMclWVAwV3fbLOhFA3VZiBr0BVbVbHO8ZHYzyBqDC4bxHWgrDgxLEu8kWS8Tb548dvVEB
	oAKf4VFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPW5-0000000Fq2e-1H11;
	Fri, 23 Aug 2024 08:19:29 +0000
Received: from bee.tesarici.cz ([37.205.15.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPLr-0000000FmVv-3MLe
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 08:08:57 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id EB98F1F1F0E;
	Fri, 23 Aug 2024 10:08:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724400534; bh=O4JppdwbWGFP1nVYHk+FUidvoThmdHfNE8PVWBlwh/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANKZx1em/5Hq+8j2ti8Uu3/wZvJAcwNqvopisDqkkv0AfwfKI/eteuieZAqpAky0Y
	 fmrScluuWbIfY2O9que2bpi3QOuIYuK55RLkpQ0soLVsLIPlK+EGZzx7iUqXMbP+A+
	 Rx0yX9NKjrjcwroew40JHSjb6jhtE9tlEePOiIu1MYkeD5PV5/8jfe3KZ5sg2O+j6+
	 w7oacKUAjf2joF8DWR2CKq///aRssgU+blLd5urdTAzb7IoJCtDi9RSqC1WciFRFwt
	 KfMQxbW0xM/vurn0o+aY1rX2FFXPFmlUTpiqjVKV5/K6Ns4lo25l+xdDDe1Rce08QJ
	 Sl8wmIb2j5dnQ==
Date: Fri, 23 Aug 2024 10:08:53 +0200
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
Subject: Re: [RFC 4/7] scsi_lib_dma: Add _attrs variant of scsi_dma_map()
Message-ID: <20240823100853.6cab2245@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-5-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-5-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_010856_020257_4F9187F1 
X-CRM114-Status: GOOD (  19.83  )
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

On Thu, 22 Aug 2024 11:37:15 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> Extend the SCSI DMA mapping interfaces by adding the "_attrs" variant
> of scsi_dma_map(). This variant allows passing DMA_ATTR_* values, such
> as is needed to support swiotlb throttling. The existing scsi_dma_map()
> interface is unchanged, so no incompatibilities are introduced.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/scsi/scsi_lib_dma.c | 13 +++++++------
>  include/scsi/scsi_cmnd.h    |  7 +++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib_dma.c b/drivers/scsi/scsi_lib_dma.c
> index 5723915275ad..34453a79be97 100644
> --- a/drivers/scsi/scsi_lib_dma.c
> +++ b/drivers/scsi/scsi_lib_dma.c
> @@ -14,30 +14,31 @@
>  #include <scsi/scsi_host.h>
>  
>  /**
> - * scsi_dma_map - perform DMA mapping against command's sg lists
> + * scsi_dma_map_attrs - perform DMA mapping against command's sg lists
>   * @cmd:	scsi command
> + * @attrs:	DMA attribute flags
>   *
>   * Returns the number of sg lists actually used, zero if the sg lists
>   * is NULL, or -ENOMEM if the mapping failed.
>   */
> -int scsi_dma_map(struct scsi_cmnd *cmd)
> +int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
>  {
>  	int nseg = 0;
>  
>  	if (scsi_sg_count(cmd)) {
>  		struct device *dev = cmd->device->host->dma_dev;
>  
> -		nseg = dma_map_sg(dev, scsi_sglist(cmd), scsi_sg_count(cmd),
> -				  cmd->sc_data_direction);
> +		nseg = dma_map_sg_attrs(dev, scsi_sglist(cmd),
> +			scsi_sg_count(cmd), cmd->sc_data_direction, attrs);
>  		if (unlikely(!nseg))
>  			return -ENOMEM;
>  	}
>  	return nseg;
>  }
> -EXPORT_SYMBOL(scsi_dma_map);
> +EXPORT_SYMBOL(scsi_dma_map_attrs);
>  
>  /**
> - * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map
> + * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map_attrs
>   * @cmd:	scsi command
>   */
>  void scsi_dma_unmap(struct scsi_cmnd *cmd)
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 45c40d200154..6603003bc588 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -170,11 +170,14 @@ extern void scsi_kunmap_atomic_sg(void *virt);
>  blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
>  void scsi_free_sgtables(struct scsi_cmnd *cmd);
>  
> +#define scsi_dma_map(cmd) scsi_dma_map_attrs(cmd, 0)
> +
>  #ifdef CONFIG_SCSI_DMA
> -extern int scsi_dma_map(struct scsi_cmnd *cmd);
> +extern int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs);
>  extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
>  #else /* !CONFIG_SCSI_DMA */
> -static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
> +static inline int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
> +						{ return -ENOSYS; }
>  static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
>  #endif /* !CONFIG_SCSI_DMA */
>  


