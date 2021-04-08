Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B73EC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86C5610F7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86C5610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dypuhSg0q2Jn1anF9/DpdBmzpK4LdhzMHTiCM11EFoA=; b=I9ESaqCY0HLpDhbDCbAnbeR2Q
	fZLf3z2g3yibQzrgh0UhAZLEiaz+FkoGlSPKZXbOZzmAyblWLLxBMg5/Hthl6CBO6AXU+WyesoOwS
	ghyUcVr2pwyO31wuYA7rbYYouNJswof9FVBrQQGJBrUETOWLMffE37mGzcQR3srmNts/7lInYari0
	o+OpQ6FP7ERglwryFmsF6AI23k6nOxaC0S/RdGMM/zaZUMVFYlvjWBVVZpFlfCCh/SgIFVMCjsdzw
	JDYQRNQvNk0Td7h5Ei3CIYozOG9a8BksSAguLGUakTynwC3IV8j0ooXUUA4m9KtzEoPg7uL2kgTQ1
	XKSwvnxQA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUdMn-009OUO-AY; Thu, 08 Apr 2021 22:43:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUdMj-009OTh-Jt
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 22:43:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D23610F7;
 Thu,  8 Apr 2021 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617921786;
 bh=ZWOQpdZTQBtm1FjtHQ+10DHRuP67cKdQJjPX8vYkBu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gxIwBhZD88sMwGmHQSES/RqN+BotIxzXPl8QzEn/izYm23BOZ6TBRtuGmzciDIkhr
 Vqjwr4bdx65xIap6p6aWeAadxy1E7/7eSkbD6NEpt28Dg0DiFnTlJEgpJQrimTMt/o
 CsfqEqUP2LoseFj/aXU3q9xRYAWpjMJxkng2NwMgjlzKLdu11cn3HvdS/SscOjpsXV
 kVzRBxhw60on4I6BuTcUtSEqWoiMVM/Iaz52S7imaYk12d0rGSQDgIK0er/1cqaMZo
 w+xD9aiygvqodhw3CvnScMyDtqqum4emm491VAvKjOWuMUttyAhuiz68YGLlBCS4n0
 JK9YWIX96Zs+Q==
Date: Fri, 9 Apr 2021 07:42:59 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/13] nvme: let namespace probing continue for
 unsupported features
Message-ID: <20210408224259.GA28814@redsun51.ssa.fujisawa.hgst.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-13-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-13-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_234309_914764_A3F266FB 
X-CRM114-Status: GOOD (  20.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 08, 2021 at 02:08:41PM +0200, Christoph Hellwig wrote:
> Instead of failing to scan the namespace entirely when unsupported
> features are detected, just mark the gendisk hidden but allow other
> access like the upcoming per-namespace character device.

This part looks fine for what it is, but I thought we were going even
further by allocating a namespace for the generic char device even if
its Command Set Indicator was unsupported by the kernel.
 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 11 ++++++++++-
>  drivers/nvme/host/zns.c  |  4 ++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7ebe0225e01412..eba676b260b820 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1832,7 +1832,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	if (blk_queue_is_zoned(ns->queue)) {
>  		ret = nvme_revalidate_zones(ns);
>  		if (ret && !nvme_first_scan(ns->disk))
> -			return ret;
> +			goto out;
>  	}
>  
>  	if (nvme_ns_head_multipath(ns->head)) {
> @@ -1847,6 +1847,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  
>  out_unfreeze:
>  	blk_mq_unfreeze_queue(ns->disk->queue);
> +out:
> +	/*
> +	 * If probing fails due an unsupported feature, hide the block device,
> +	 * but still allow other access.
> +	 */
> +	if (ret == -ENODEV) {
> +		ns->disk->flags |= GENHD_FL_HIDDEN;
> +		ret = 0;
> +	}
>  	return ret;
>  }
>  
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index bc2f344f0ae018..475dd45c3db49b 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -96,7 +96,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  		dev_warn(ns->ctrl->device,
>  			"zone operations:%x not supported for namespace:%u\n",
>  			le16_to_cpu(id->zoc), ns->head->ns_id);
> -		status = -EINVAL;
> +		status = -ENODEV;
>  		goto free_data;
>  	}
>  
> @@ -105,7 +105,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  		dev_warn(ns->ctrl->device,
>  			"invalid zone size:%llu for namespace:%u\n",
>  			ns->zsze, ns->head->ns_id);
> -		status = -EINVAL;
> +		status = -ENODEV;
>  		goto free_data;
>  	}
>  
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
