Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4BFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4917207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oQIL0KTI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x1UogFGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4917207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rlBG+0+qrmpu3J9bUOqpudn/38t1OyPccZ4527i+dI8=; b=oQIL0KTIsq85Rl
	yX5O60SItIp+jzn8lraU+ZducEVvb0PPwJsRMHpt89iF6NCNKjqst4pgBsNqe3BUJaov4KLJ4H9Yq
	qn9FoCaKP0CwntIkNSo0Kcn5Ga/dcHKC5ofd4K58b0bhe0JD1w70u2HL49MOV23EgWrt4wEbQcu8j
	jXTCDR1x2c5PkcdwSqIYhcyV1l0ucfzWwHqBfSI6qAENmdkFvGOraBYlU/ZNMXSs32JdxxwD7TlMG
	RIA4xsuEFpx08Huk7KnarXDTdc/Xy/SACWi2pF556P48BQi9TrGXGIXLn45J0/ILEFa/ylduEgOwV
	vwbQ0zSEiGkC7N1R3gmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je2BH-000772-Ar; Wed, 27 May 2020 19:57:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je2BD-00076f-Oz
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 19:57:37 +0000
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 70D2E207E8;
 Wed, 27 May 2020 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590609455;
 bh=3zaCqBy55uzGBnvvKGcUczY5pS1yCJcmGph62h7vnLY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x1UogFGedDxc7rRYgaJ7AFaZatoD30ON4AJ7h8W0oOad56m0N8uz/nCBc/6f9AaG0
 4Um1RmSv2lgRNrTkA2AevMtqWIHfRBE9OrqsGt+/z1B1KTK6tWAt0KpK9UjLxjzIxX
 fAl7XZISi4wOOZEt7TsxdvwGBB5WMMp/NohriLUc=
Date: Wed, 27 May 2020 13:57:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH] nvme: cancel requests for real
Message-ID: <20200527195732.GA14631@C02WT3WMHTD6>
References: <20200527190913.3461503-1-kbusch@kernel.org>
 <eaccdf19-25ef-cf15-5183-dee97b964025@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eaccdf19-25ef-cf15-5183-dee97b964025@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_125735_833459_B96A530A 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: axboe@kernel.dk, alan.adamson@oracle.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 27, 2020 at 12:36:07PM -0700, Dongli Zhang wrote:
> On 5/27/20 12:09 PM, Keith Busch wrote:
> > Once the driver decides to cancel requests, the concept of those
> > requests timing out should no longer exist. Since we can't stop fake
> > timeouts from preventing a forced reclaim, continue completing the same
> > request until the block layer isn't told to pretend that didn't happen.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ba860efd250d..72e5973dda3a 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
> >  		return true;
> >  
> >  	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> > -	blk_mq_complete_request(req);
> > +	while (!blk_mq_complete_request(req));
> If the probability is configured to fail every time with 100% probability, we
> would run into endless loop?

If completing requests is not possible, it's already endless. This is just a
tighter loop in that case.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
