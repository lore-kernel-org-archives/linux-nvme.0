Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682F5D5C0E1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4SNNSoPJkIeHOpErS7qWq9ikd2wqc5VoidBD3EiGDk=; b=rwtz81r1gmvGBHTujzsOBDVGbd
	fdQZcmbs2/XDsjGrD2+WLv3YaSrasCRDnKJCaxkbwowt0xAQ7n/1QzZvHBbaOFKLTt17V1weOV1QX
	0RBwLB8Ddr0xqRAMch0/ycdHJnH0rrI2NYTLcxmOfo8lL+eBGzEKJBOv+iBgipYAdIzRYyHKo0Zrg
	5oAXwlVMj8jYc6a1QfEVFcvWrRfLauFXjXYfwCDdFI5239T0rgsBfwFvWcPpl3EAg/95GioFtgne0
	eMwT0zkoQIJv5sqlAWyELkBr7EkAARE8r1X2xszECKs9RJAu/vyZLo8y8Dj5+t5tsRNyNm1CAyyoy
	FD174jCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QY6-0000000Axi8-2kD7;
	Fri, 08 Nov 2024 15:05:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Pxj-0000000Aqja-0cNn
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E3F068AA6; Fri,  8 Nov 2024 15:27:43 +0100 (CET)
Date: Fri, 8 Nov 2024 15:27:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
Message-ID: <20241108142743.GG6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-14-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-14-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062747_451268_77396ABD 
X-CRM114-Status: GOOD (  12.22  )
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

On Thu, Nov 07, 2024 at 11:38:48AM -0800, Keith Busch wrote:
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 516af7b419189..f688d7fdf7d67 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -915,6 +915,9 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
>  		id->nsattr |= NVME_NS_ATTR_RO;
>  	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
>  		id->nsfeat |= NVME_NS_ROTATIONAL;
> +	if ((req->ns->file && !req->ns->buffered_io) ||

I don't think this check is correct.  Direct I/O still requires cache
flushes for durability.


