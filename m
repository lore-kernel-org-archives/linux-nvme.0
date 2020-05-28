Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B765DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 04:58:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D442089D
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 04:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwnBjnQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D442089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eQpOKm27lX483SRP3ESyECCWFxG9GtsG12ky7Jf8XlY=; b=UwnBjnQLU4mGqz
	iKMzGqLESxhALqWlEliZO1m4YcZ9Y/1rHctP+3sBQx3i5A7lwkL7K5w99+12ldpj2Bwy2f9eF48rQ
	HwODk+WT4Q/MGJo3aQl9yq7VLfFxF6u3n7Kkl7eHHBBfPo+81zHYXP+Rmee7Gkr85452qZyn9/Hzr
	wwhIvF+NG4iTfQrmqm+ZsVLY4vsy9wxTiqCs0Kxpehd1JlinQ6GD7nz8FRZJsnBqOf301xiI9fkob
	9evqX00kSrJoClVGySpIT6kHnIf+bnuWimLb4OgOkIs9kMb4BqG/H8sphrzpx2tsdRVw4cnwhiYQ1
	0gdQLixSvZPDBBsw0Tow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAca-0000hL-W0; Thu, 28 May 2020 04:58:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeAcZ-0000gp-3S
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 04:58:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4BCC168B05; Thu, 28 May 2020 06:58:20 +0200 (CEST)
Date: Thu, 28 May 2020 06:58:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: cancel requests for real
Message-ID: <20200528045820.GA28678@lst.de>
References: <20200527190913.3461503-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527190913.3461503-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_215823_296662_553C7FF4 
X-CRM114-Status: GOOD (  14.68  )
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

On Wed, May 27, 2020 at 12:09:13PM -0700, Keith Busch wrote:
> Once the driver decides to cancel requests, the concept of those
> requests timing out should no longer exist. Since we can't stop fake
> timeouts from preventing a forced reclaim, continue completing the same
> request until the block layer isn't told to pretend that didn't happen.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..72e5973dda3a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>  		return true;
>  
>  	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -	blk_mq_complete_request(req);
> +	while (!blk_mq_complete_request(req));
>  	return true;

This is just disgusting.  Take a look at how blk_mq_complete_request
is implemented, and what might be a better function to export and call
here, or any other error handling context. Bonus points for finding a
saner name for it.

I'm also thinking that whole idea of randomly not doing anything in
blk_mq_complete_request is just a bad idea vs doing targeted hooks
in the actual drivers.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
