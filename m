Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FDC28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB72D20663
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UsSN24Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB72D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dwGDtWwIzB5bDNGs5i9eLB25RD2F4dkCa+BQ/1CV2wA=; b=UsSN24SrrClt20
	8iec/KtGxWTBEuazBUEeTxMNeRCUeVYgsiU640STV2c1Ln79WJe2QxB5Dj4bktUbVORJYOIA5KH5O
	GRwGqkJB3IHOw6h7p1Equ+u7t2BuGaTilID9ophRgw/UFmso6BQOVMAx/SGghqrqeQ5xkGRQLjFyC
	w00PD/8eiQPxVjUKcnt8ijhVCoD2WmdzYCppAoYGh6/1/tK2LJj6kRH79TKe9fkkILR6m9Lm+wlSy
	PbmnT34tYa4vdTfSJnTFl9XNZngPvvsZfSZofjwp/hKWKUtWCwxY5yHhLp5MOr+PapvFrnX0juCOL
	Mac3l0LWNEi/6rU2ejCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWEG8-0004L4-Nz; Wed, 06 May 2020 07:14:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWEG5-0004KS-FS
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 07:14:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A1F9868C4E; Wed,  6 May 2020 09:14:19 +0200 (CEST)
Date: Wed, 6 May 2020 09:14:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/3] nvmet: add async event tracing support
Message-ID: <20200506071419.GC12145@lst.de>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
 <20200506014629.39509-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200506014629.39509-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_001422_164475_34258581 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 05, 2020 at 06:46:29PM -0700, Chaitanya Kulkarni wrote:
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 219bcf21d4bf..d4f11078a578 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -151,6 +151,8 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
>  		kfree(aen);
>  
>  		mutex_unlock(&ctrl->lock);
> +		trace_nvmet_async_event(ctrl,
> +				(req->cqe->result.u32 & 0xff00) >> 8);

Can you move the extraction into trace_nvmet_async_event so that it
isn't executed when tracing isn't enabled?

Otherwise this looks fine.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
