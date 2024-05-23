Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44AFC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQUquqtb6nc3Z5Y3SUxZ2nv+ANeQKSKLo7pB44ee164=; b=fUXe26b9YtGOj2l6Vj5t8rdjFL
	JXKEnQhVEz4muUaECwMwhsZIb2wS9nBLr/PAhDQBlnQTYhv3BA2L4wbrAcAVd9w7vCIO0s0kCExuV
	Zat7BKWoWMPEPtOmzeENsU+kmcl9xkMi1DRpQuCyzzL3cepL7x1ov2wH9HF9/VCcJ4xvawksS5BwE
	CuFbhR6cpZnYE9AkaFs6esbYpBb8+HMBgWZpfW+3VVbWg0Nipkk4qZX6dF2La4SfZ4ZHGDwTxHgfF
	RC5Uj2KXeVp8MC5EXPNenyoDFnvneONgCyDBTaSZXr8o0dXrJue3L1THlp+m/DNRbEy1Mkr/EPviW
	CvnN27lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAga-00000006hYH-2b0e;
	Thu, 23 May 2024 15:48:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAgV-00000006hWH-3utb
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:48:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716479330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQUquqtb6nc3Z5Y3SUxZ2nv+ANeQKSKLo7pB44ee164=;
	b=XQdiBv45s4wK3wx0goB7tGT8tJdELkEuRBZTA3qtQxipsWfNtZU7uDSuxXxh20nFkrhYwY
	meCCkcmohsK8508ZJNolP/vjGbdbbXC0SrVKY1W+Kx4ItE4tu7crga/agX7BfylXQs7O87
	ighB7EnRuzuwQWk37bM3qvoKau3NfdA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-gGgK3U6JPj2tF8bOxmChaA-1; Thu,
 23 May 2024 11:48:47 -0400
X-MC-Unique: gGgK3U6JPj2tF8bOxmChaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6CB3C025C7;
	Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 975AC2027019;
	Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 81DFB30C1C33; Thu, 23 May 2024 15:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7F03C3FB52;
	Thu, 23 May 2024 17:48:46 +0200 (CEST)
Date: Thu, 23 May 2024 17:48:46 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
Message-ID: <f537bcb-bd99-e741-cf2e-8f5ace404252@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk> <7060a917-6537-4334-4961-601a182bca54@redhat.com> <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com> <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_084852_136973_0169E59D 
X-CRM114-Status: GOOD (  23.84  )
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



On Thu, 23 May 2024, Jens Axboe wrote:

> On 5/23/24 9:11 AM, Mikulas Patocka wrote:
> >>> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> >>>  			goto out_free_cmd;
> >>>  	}
> >>>  
> >>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >>>  	if (blk_integrity_rq(req)) {
> >>>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
> >>>  		if (ret)
> >>>  			goto out_unmap_data;
> >>>  	}
> >>> +#endif
> >>
> >> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
> >>
> >> ?
> > 
> > That wouldn't work, because the calls to rq_integrity_vec need to be 
> > eliminated by the preprocessor.
> 
> Why not just do this incremental? Cleans up the ifdef mess too, leaving
> only the one actually using rq_integrity_vec in place.
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5f857cbc95c8..bd56416a7fa8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -821,10 +821,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
>  static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  		struct nvme_command *cmnd)
>  {
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct bio_vec bv = rq_integrity_vec(req);
>  
> @@ -832,9 +832,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  	if (dma_mapping_error(dev->dev, iod->meta_dma))
>  		return BLK_STS_IOERR;
>  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> +#endif
>  	return BLK_STS_OK;
>  }
> -#endif
>  
>  static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  {
> @@ -855,20 +855,16 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  			goto out_free_cmd;
>  	}
>  
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
> -	if (blk_integrity_rq(req)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>  		if (ret)
>  			goto out_unmap_data;
>  	}
> -#endif
>  
>  	nvme_start_request(req);
>  	return BLK_STS_OK;
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
>  out_unmap_data:
>  	nvme_unmap_data(dev, req);
> -#endif
>  out_free_cmd:
>  	nvme_cleanup_cmd(req);
>  	return ret;
> 
> > Should I change rq_integrity_vec to this? Then, we could get rid of the 
> > ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> > static inline struct bio_vec rq_integrity_vec(struct request *rq)
> > {
> > 	struct bio_vec bv = { };
> > 	return bv;
> > }
> 
> Only if that eliminates runtime checking for !INTEGRITY, which I don't
> thin it will.

It will eliminate the ifdefs. If we are compiling without 
CONFIG_BLK_DEV_INTEGRITY, blk_integrity_rq(req) is inline and it always 
returns 0. So the optimizer will remove anything guarded with "if 
(blk_integrity_rq(req))" - including the calls to nvme_map_metadata and 
rq_integrity_vec.

But we need to provide dummy rq_integrity_vec for the compiler front-end. 
The front-end doesn't know that blk_integrity_rq always returns zero.

So, the patch will be smaller if we get rid of the ifdefs and provide a 
dummy rq_integrity_vec.

Mikulas

> 
> 
> -- 
> Jens Axboe
> 


