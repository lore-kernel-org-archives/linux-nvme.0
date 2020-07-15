Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C40C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700C42065E
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n6q+ccvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C42065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XNGTKrlKifZhlWeooUhFae6S7BmTotzc8QRkvTEzYHQ=; b=n6q+ccvbsxXld1JkCZpg1J5U0
	8fGc+ZjrjsQaHAhiKBYJgZbY4mzGgpiSnOCLngOfDRmoIYpxGzzgtsh6w0OXHikrDfZzcPcohkNdn
	8SfdkDvUhSmpE4vRWhAQg4q7jh81W0XBgsr9Ot4r/6eQB4/icIBAz7Pad6njmEvm3A4gbymwRjgQ/
	FFeYzDuxb0Giy8pmlA5z1JuPxh0XjfEDkoE0l6P4NGZC1BEaZEiGO+vx+NwUnPeYCSY4QeE3IHPDD
	ACHeO+r1eM/9ggQsXdVEOopHfkKrWP8/GDYPw7i6XGsHGdfGLmOX38biURA8qVIzK1t2L8BWhxtM9
	+BbMMbA3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvbYn-0000MO-55; Wed, 15 Jul 2020 07:10:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvbYj-0000Ke-VQ
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 07:10:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC20C6736F; Wed, 15 Jul 2020 09:10:27 +0200 (CEST)
Date: Wed, 15 Jul 2020 09:10:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 10/10] nvmet: use xarray for ctrl ns storing
Message-ID: <20200715071027.GB22320@lst.de>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-11-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714233057.10915-11-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_031030_159546_C3BEB7CB 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 willy@infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> index 9cdc39c8b729..2908acc7b1e2 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -115,13 +115,14 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
>  
>  static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
>  {
> -	struct nvmet_ns *ns;
> +	unsigned long nsid = 0;
> +	struct nvmet_ns *cur;
> +	unsigned long idx;
>  
> -	if (list_empty(&subsys->namespaces))
> -		return 0;
> +	xa_for_each(&subsys->namespaces, idx, cur)
> +		nsid = cur->nsid;
>  
> -	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
> -	return ns->nsid;
> +	return nsid;
>  }

If Matthew wants to add a helper to return the highest id for an xarray
this would be the place to use it.


> +	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
> +	if (ret)
> +		goto out_dev_put;

I don't think out_dev_put is enough here as that fails to tear down
ns->ref.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
