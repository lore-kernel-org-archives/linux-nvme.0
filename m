Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438D9C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=63rCAUPPGTr7u+nNGur/IRXROcMp4717V2yA3+yESCY=; b=n3SA4++Ch0yfDDYvThLjNT5lXr
	cP/A+m8fh0niQqbssPHZ0O/+unoO4+nUqrjJkJ027ucXc5868/SoYSMIOUlCX4Hx5faitseSyhNJb
	hpzpGY3kZoXnQygXTfFDCWvmIFLdYtjVHk8s+GWWwDFUomytnQ5XSaoGRODrIW5Hf7gTht6EbA2ln
	F/IvUJJ1lfaGuiO4uR3h8/woVXmw6xhBPULIt6KH3KpNLTFu0EFFonZ4mU+TBN8j5oReR3lvAegds
	0bdIvT2/cyt+8PsrxMQzeaGcHWIszG2tiT1b6+q5blsQ8Y0oD/JBPMZUQrW5mzXJ4NXDF2sqJcX5V
	CbCr4emg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUMW-00CIPU-1X;
	Fri, 12 May 2023 15:07:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUMT-00CIOa-1e
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:07:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23C6668AFE; Fri, 12 May 2023 17:07:10 +0200 (CEST)
Date: Fri, 12 May 2023 17:07:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Irvin Cote <irvincoteg@gmail.com>
Subject: Re: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Message-ID: <20230512150709.GC6005@lst.de>
References: <20230503150925.863308-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503150925.863308-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_080713_690437_B6C05FE5 
X-CRM114-Status: GOOD (  20.15  )
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

On Wed, May 03, 2023 at 06:09:25PM +0300, Sagi Grimberg wrote:
> -	if (!ctrl->discard_page) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!ctrl->discard_page)
> +		return -ENOMEM;

Can we please pre-load these cleanups in a separate patch?

> -out:
> -	if (ctrl->discard_page)
> -		__free_page(ctrl->discard_page);
> +	ctrl->instance = NVME_CTRL_INSTANCE_UNINITIALIZED;
> +	/* pairs with device_initialize .release method will cleanup */
> +	nvme_put_ctrl(ctrl);

Err, no.  We should not go through .release with a partial 
initialization.  Please do proper unwinding before the device
is added, and make sure everything is in a proper state by the
time ->release can be called.

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..920403589670 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -255,6 +255,7 @@ struct nvme_ctrl {
>  	struct request_queue *connect_q;
>  	struct request_queue *fabrics_q;
>  	struct device *dev;
> +#define NVME_CTRL_INSTANCE_UNINITIALIZED (-1)
>  	int instance;
>  	int numa_node;
>  	struct blk_mq_tag_set *tagset;
> -- 
> 2.34.1
---end quoted text---

