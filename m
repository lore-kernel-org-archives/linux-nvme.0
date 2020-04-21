Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387FC54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28FB2068F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GX1PVbAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28FB2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uzxagg9Y6dBNt8m2yxPRt0NZ3szkivikWiD4wM6CD5k=; b=GX1PVbAz4b9mzI
	WyFvNWcb3bh5ZVroMQze8c7OUIC0sXpTnQ8V6X0F2gNZl8M0weEmOwMtDoKF/QRpsX4BXCNk+A1v9
	dnyUljhLRFsR5dlz6HbWQeOtNXkrzpoTSZdzeF7yatUOT6uyNDV0AxIqlKHQQMHQGdSji9Cut1eyM
	A87+uJA8zEuTdD+NS/orJ3TY3iYW+pwxpYj3v5M8hSt5xZpd3ledmuLMUo87IS/cKvD8JeI8uTKZT
	h8nhknY28gU1jnJHcvJJzg98mjJYsTgSF7WJ7z2+Ig7JTh64hBAv0z0XC1wEoPJDWf73VGHxRCzeN
	jcl74kSorUNZAY2a8SJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQuiE-0000rN-HB; Tue, 21 Apr 2020 15:21:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQuiC-0000qP-QV
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 15:21:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC80668C4E; Tue, 21 Apr 2020 17:21:21 +0200 (CEST)
Date: Tue, 21 Apr 2020 17:21:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 09/17] nvmet: prepare metadata request
Message-ID: <20200421152121.GB10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-11-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-11-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_082125_006148_BB7155B1 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 27, 2020 at 08:15:37PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> Allocate the metadata SGL buffers and set metadata fields for the
> request. This is a preparation for adding metadata support over the
> fabrics.

I don't think having this as a separate prep patch is a good idea, it
should go with the code making use of it.

> -						       req->transfer_len);
> -			if (req->sg) {
> -				req->p2p_dev = p2p_dev;
> -				return 0;
> +						       data_len);
> +			if (!req->sg)
> +				goto fallback;
> +
> +			if (req->md_len) {
> +				req->md_sg =
> +					pci_p2pmem_alloc_sgl(p2p_dev,
> +							     &req->md_sg_cnt,
> +							     req->md_len);
> +				if (!req->md_sg) {
> +					pci_p2pmem_free_sgl(req->p2p_dev,
> +							    req->sg);
> +					goto fallback;
> +				}
>  			}
> +			req->p2p_dev = p2p_dev;
> +			return 0;
>  		}
>  
>  		/*
> @@ -984,23 +1001,40 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
>  		 */
>  	}
>  
> -	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
> +fallback:
> +	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
>  	if (unlikely(!req->sg))
>  		return -ENOMEM;
>  
> +	if (req->md_len) {
> +		req->md_sg = sgl_alloc(req->md_len, GFP_KERNEL,
> +					 &req->md_sg_cnt);
> +		if (unlikely(!req->md_sg)) {
> +			sgl_free(req->sg);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);

I suspect this might be a little cleaner with a nvmet_alloc_sgl
helper that returns a scatterlist instead of duplicating all the
code for data vs metadata.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
