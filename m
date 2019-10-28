Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E71CA9EAF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 00:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933402070B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 00:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dEy9TnL4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6NmPeo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933402070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RdajLOFqoyjjVxOpoJkjUFcCdJmGEhqiUg3ZtXJPkV8=; b=dEy9TnL4ZlebBs
	AOicMv/C6U6dGQm4172Mzw4xebCN1HwWX5Jpy2gT3TP8p/dBSS9heamG6fN9NhlMX7mbFuTLYWgpj
	MhSZJmS+7VkG6ac586VPw4CxKeZg5r+vDcLAeyZ3zvsG0IgNkyyR33outy0CxKLDl+VocNoXYjo6M
	FVgl8lPj3LF/mXbYhgIIk+FdSddreZZBaDrHnbG98FMDiJIBz9E246Sc6jcEP5DbUCxXCwulfdbIv
	gxJ/wc8vqIl8AliBUXmochsIfoSoea3LigRAtKgDXGeZDgRGnkz3FbRDuGCAzwQlbu8TY4U5LBkdG
	lc2yWMDYTDNuiHGHGq/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOtJe-0005R8-2d; Mon, 28 Oct 2019 00:55:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOtJc-0005Ql-2X
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 00:55:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99D0F2070B;
 Mon, 28 Oct 2019 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572224123;
 bh=fe1483DfHjKhVG55fXlTwG0+3QaDzZft9vKk2HY4LY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n6NmPeo/tWyzyC7jULhcnY5EhSvrl3fl6m9st3jNzlap4iAiR/FO2mM9Ud1cO7qMx
 Dot2ix3HE2xAfox5Raa/2BU8NvTizw7sLsUUQ/WDzS8n+Zwqjuuzmhc7Si/UlruXqV
 amHkHR8vn5fkGmPBvvJCXg+2TcuhIQ7gWdUfvrpw=
Date: Mon, 28 Oct 2019 09:55:17 +0900
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Message-ID: <20191028005517.GA6693@redsun51.ssa.fujisawa.hgst.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
 <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
 <20191027150330.GA5843@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191027150330.GA5843@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191027_175524_137751_6DF224C0 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>, Hannes Reinecke <hare@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Oct 27, 2019 at 04:03:30PM +0100, hch@lst.de wrote:
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 04a9cd2a2604..ed1a8d0ab30e 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -147,6 +147,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  	int sg_cnt = req->sg_cnt;
>  	struct bio *bio;
>  	struct scatterlist *sg;
> +	struct blk_plug plug;
>  	sector_t sector;
>  	int op, op_flags = 0, i;
>  
> @@ -185,6 +186,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  	bio->bi_end_io = nvmet_bio_done;
>  	bio_set_op_attrs(bio, op, op_flags);
>  
> +	blk_start_plug(&plug);
>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>  		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
>  				!= sg->length) {
> @@ -202,6 +204,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  		sector += sg->length >> 9;
>  		sg_cnt--;
>  	}
> +	blk_finish_plug(&plug);
>  
>  	submit_bio(bio);
>  }

The blk_finish_plug() should be after the last submit_bio().

I looked at plugging too since that is a difference between the
submit_bio and write_iter paths, but I thought we needed to plug the
entire IO queue drain. Otherwise this random 4k write workload should
plug a single request, which doesn't sound like it would change anything.

Using the block plug for the entire IO queue drain requires quite a bit
larger change, though. Also, I saw a similar performance difference with
a ramdisk back-end, which doesn't use plugs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
