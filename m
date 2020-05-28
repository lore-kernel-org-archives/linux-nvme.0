Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDA52078C
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YlfgPjMP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc3pttDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDA52078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KLv/yoJhl9JE71Mve5TKf60KnzlbBeCg8x/GFxUJPqY=; b=YlfgPjMP2bYYQc
	qjv/y34WLul2/p0kbejlxkMEN5MurKzBC4Wwd67hODpQetwWpq573uYrdrRihVhWIBs05AFrKq8Kz
	iytS0FoRcrPsugB48++jCvTbeY1rDUO59QiP2zERI7qgBxiE6F38I2rBJd2j0yUwHW1oBymQKa2kz
	HsdqzqMTm2tkj6bvuBApeeJt1OxODtusPfPWhhSGTqzH7FtRy2o5NC+2+J9QSCoFoE+LiS8zRVG2A
	E5Tt1lzVFedwvVCUu4rVv25RhO4GZiK6KQQ1Sexu/ujUkrUgWd5TAEJ+xBQXwBGL0w6u0xqpRU2DU
	JQWG4/7fxpL6qC9gdlBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeOLD-0005wS-HS; Thu, 28 May 2020 19:37:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeOLB-0005w2-FD
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 19:37:22 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C91E2078C;
 Thu, 28 May 2020 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590694640;
 bh=0GlKIVN/GyMbjfQ+dMLsLI+2neiE8SMyaHSN3vMSjFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lc3pttDoXGXUBQcd/3XzTs6LAia3oRn55bPd5xPeBWaV5M6C1ZBJlljCRXU0Gwkwj
 532awzV025A/7sL3qV/VWCjgn/nHf24a9wny0BFa1rnSGXfy0EmsctuhObWUbqY0oa
 gluHtiEINC2eqGDANHD+YFYvpVE2SqwI2wKtpJT0=
Date: Thu, 28 May 2020 12:37:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: cancel requests for real
Message-ID: <20200528193718.GB3504350@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200527190913.3461503-1-kbusch@kernel.org>
 <20200528045820.GA28678@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528045820.GA28678@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_123721_526382_B72414EE 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 alan.adamson@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 06:58:20AM +0200, Christoph Hellwig wrote:
> On Wed, May 27, 2020 at 12:09:13PM -0700, Keith Busch wrote:
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
> >  	return true;
> 
> This is just disgusting.  

Thanks for noticing. :)

> I'm also thinking that whole idea of randomly not doing anything in
> blk_mq_complete_request is just a bad idea vs doing targeted hooks
> in the actual drivers.

Yeah, I don't like fake test code in the middle of production code.
Testing code shouldn't modify the code being testing. IMO, leave real
stuff alone and create a thunk for error injection, preferably one
specific to the low-level driver. I know we can do that on x86, but not
so sure about other archs.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
