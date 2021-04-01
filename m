Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62720C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:17:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF82861379
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF82861379
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aoro3cYuzmCzZLwk3kC/6he7jlR3jWJv7pTE3SMQQcE=; b=MSOd6SlL7Daj027q4oXUoIsnM
	YcU1mqN9huHNs4K6Pzgn0uaX8rkpFFxYIP0mVS9SdT6PwkA4IquR472xt1xxY6u//9O8B8t8o6+Pz
	Tz7UFi+Ih4kAkvgJFvHiyW40UI6RiR2bG0/SalZxtGXhNjOlAniMQsYQ02ncxNh62IzODLiD0X0Y0
	Vn0kOlzRebn8QDmOrjVrdNAn+vXKfo4VNJeJFtqVSOiz3dN9EL8N87dZRxABPgBdseJEAziy6lN/T
	ePxln7ZRWl9Uqr5WG4ojbLNlzvLIj4QlDAdA+vSweC8kuIu17wIcnwxTGO99QO9xQG+IgFalFgdfE
	Aw9OvHLTw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS00B-00ADyY-O4; Thu, 01 Apr 2021 16:16:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzey-00A6ba-21
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 15:55:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0CEB61247;
 Thu,  1 Apr 2021 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617292502;
 bh=aNAJWUhXH4hx5rx7fkJuy28Cr/cjSeb2elAeGbPkHCw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kf0c0bWHlu9QsTUrnnhG5mnXJlKpIAQ/GE6N2MnP8r1fNv76vRKs8Yvx/b+KXEzne
 LkWXch2Wyt9aspmHS/dnVemlxkv0EA6EZOAH/2d6LBVg+Zx8Py2d9lt7U4OYIzRPZ/
 h7BKPtaHBFkRlzCaCjKg0qrS+9xhC31WanRMPOF4V3BawmTY7lWJvufcRfoGI8Cq3Z
 PWVXjCK+CJ3rcTRjKNKXpkyPA0BZFWAn2+lsIqzET5UgEr3NllmiguLClTMxLpd5FN
 fCUONKFpTyJ3i9/hMPcB0jNhCgKA6ewaEENd6GJPYawLjR5DrHk0rWVuGehyP58KQP
 dIATC3ARQPDiQ==
Date: Fri, 2 Apr 2021 00:54:56 +0900
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Fix handling of large MDTS values
Message-ID: <20210401155456.GA31698@redsun51.ssa.fujisawa.hgst.com>
References: <20210401035952.7249-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401035952.7249-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_165505_031834_54F0ECEA 
X-CRM114-Status: GOOD (  15.42  )
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

On Wed, Mar 31, 2021 at 08:59:52PM -0700, Bart Van Assche wrote:
> Instead of triggering an integer overflow and undefined behavior if MDTS is
> large, set max_hw_sectors to UINT_MAX.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v1: removed a dev_err() call.
> 
>  drivers/nvme/host/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..25bc28e8845f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3123,10 +3123,11 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  
>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
>  	ctrl->vwc = id->vwc;
> -	if (id->mdts)
> -		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
> -	else
> +	max_hw_sectors = UINT_MAX;
> +	if (id->mdts && check_shl_overflow(1U, id->mdts + page_shift - 9,
> +					   &max_hw_sectors)) {
>  		max_hw_sectors = UINT_MAX;
> +	}

The condition can be rearranged so that max_hw_sectors is set to
UINT_MAX just once:

	if (!id->mdts || check_shl_overflow(1U, id->mdts + page_shift - 9,
					    &max_hw_sectors)) {
  		max_hw_sectors = UINT_MAX;
	}

>  	ctrl->max_hw_sectors =
>  		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
>  

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
