Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEFC433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:26:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C72123117
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wNYszq7t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFxdi9yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C72123117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c0+ioAPGsV+psmJXj73umG6HLbA5d0P2yu1U86TfHzQ=; b=wNYszq7tTlW3lSLNOZZ1Bo8x7
	34vhJqbAvqng17IvpGmQaSFVNnr+8WDyIfq0tpu9sVyrd27683bWzRI9S5B2DAE+J62AavTiCQIFD
	+oBqXLlr2g7sSY8ovajawN3PCU93551RXZLqDfjaCRDKcDyUXqJknU2DzqCKqaIlpIJdd/FuRXiJp
	N+GaX79luom8VUZpNZ3s/NDFoyUDmaz3solGHw+uVQo8ESctpcz/tGqtZ74kbO9KiBn+TtEbvYctZ
	a5PSFYidMA0pXzraUk1/8lSnEvn4wAyA6GWnJFYoA73YEH+2hJdTqBN8JRhiddfP6hnFP9neS+ouA
	8XrorD9fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3iiW-0007m6-Ct; Thu, 06 Aug 2020 16:26:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3iiU-0007lj-Bc
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 16:26:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B33FB23117;
 Thu,  6 Aug 2020 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596731165;
 bh=Vy+j61I0ySwK7vAh82UDz0ZL3DXRpk7NcuNOvirHXOk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DFxdi9yvnAE2s2mN2zrBRUbRvvh3I/tYzDanXur5rTbq7S4iSbrzPh0Hy0IbBPK4E
 okjRhFq7pYHVDFlsuAeUL3wB0T8G3v8b/YvdQgaYR1j0lDetTOeMOhl6dV8j8qqvui
 gyZ7VtPi/SeNjSzk8g7jMIe2hWGN5Z/VQMdGHNDI=
Date: Thu, 6 Aug 2020 09:26:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Message-ID: <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_122606_544021_8A5A8E6F 
X-CRM114-Status: GOOD (  25.18  )
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
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 10:12:24AM -0600, Logan Gunthorpe wrote:
> On 2020-08-06 9:42 a.m., Keith Busch wrote:
> > On Thu, Aug 06, 2020 at 12:31:50AM -0700, Chaitanya Kulkarni wrote:
> >> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
> >> following Oops :-
> 
> It would be nice to have in the changelog what was done to trigger this
> oops.
> 
> > Suggested changelog:
> >
> >   A passthrough request may be NULL if an invalid namespace is used, or
> >   if the allocation failed. Check for a valid request before releasing
> >   it to fix a NULL pointer dereference.
> 
> I don't think this is quite accurate either. It looks to me like it's
> just a bug in the error path logic. If the namespace is invalid, it
> doesn't even try to allocate the request so it should really just order
> the cleanup correctly and skip it, if it's not allocated.
> 
> I think a fix like this would be cleaner:

Agree, this looks like a more appropriate way to unwind on failure. 
 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index a260c09b5ab2..96bc9aa11ddb 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -239,7 +239,6 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
> 
>  	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
>  	if (IS_ERR(rq)) {
> -		rq = NULL;
>  		status = NVME_SC_INTERNAL;
>  		goto fail_out;
>  	}
> @@ -248,7 +247,7 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
>  		ret = nvmet_passthru_map_sg(req, rq);
>  		if (unlikely(ret)) {
>  			status = NVME_SC_INTERNAL;
> -			goto fail_out;
> +			goto fail_put_req;
>  		}
>  	}
> 
> @@ -275,11 +274,12 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
> 
>  	return;
> 
> +fail_put_req:
> +	blk_put_request(rq);
>  fail_out:
>  	if (ns)
>  		nvme_put_ns(ns);
>  	nvmet_req_complete(req, status);
> -	blk_put_request(rq);
>  }
> 
>  /*

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
