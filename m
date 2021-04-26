Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BE6C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C453F61004
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C453F61004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T/TnrXuiule6/xEzaBua9S00owiGK4V2xDSwZeZwK0o=; b=UhrGKiP1JHCcutQOcI+fwAyI3
	hCH5uNjzk7QuxElytKlYOIeG9+1iwwuSxWiSvvi8E4wO8XrFxJwD9ssanFZlCOT0TGdjYmtn0r4FY
	hG6fACA9CMtGJz7/VX8LhBLyNYz6XWqgW4TSN0Nj+9TzJRCQlT1UE+F0mjnzVry8Ez0q/qiu0gWAV
	b6dSNYPDOmmWHmeuy6D+rBrZfL9FF+px5nRnyQl8q7utbXM9z2Q973OqqUl10W0x1Ps/15qR5KFQd
	xVKQsVLlOFdas3veTPvK1YRk+OKe/TtVKS73YFCvPQF5GBFwnw+6vk8ZKb9wnpixNQgXZpKGFXer8
	E3+ll8KCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2HI-007qlg-RN; Mon, 26 Apr 2021 14:32:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2HG-007qkv-3E
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=99gZteMWnWseEGh3T5AmCrUTGfNP8UOgXuVoZ4p2FTs=; b=N+n28HAORzNQq5hegdoo4ogKBN
 f30EVIj6O3pBscCxtTyehiazpiFEbRKvYo2dPmJt32PscLx73zH/FXaugyrgjVZYecUinEZxnVkJ6
 i92pUlzOpwU9gmxipKlHlYY85PA5fjQCHMX5YXJpWhhED2GWtztcHtKmyOMkvs5CtcgcoUttUrA+g
 9tj4qhTdtSL+tlqDpZr/psJcneLKpZXovxlF9Mj34xs/+WZ5AqV9eooexZG0Y8mPs4N2ijVow0QfT
 /Onpq58vEPsNBX+pnW1LAQwYy7Rp8GMTl6G3rnpXpLlepkaJNDkX0zkF1zO4f3+f8sBrMZUJiO0PJ
 /+oBtQfw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2HD-00G0uz-AV
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:31:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CE78E68C4E; Mon, 26 Apr 2021 16:31:46 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:31:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH 1/2] block: return errors from blk_execute_rq()
Message-ID: <20210426143146.GB19408@lst.de>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_073155_531284_AC55CB31 
X-CRM114-Status: GOOD (  19.31  )
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

On Fri, Apr 23, 2021 at 02:57:59PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> completion status.
> 
> Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c       | 6 ++++--
>  include/linux/blkdev.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..3877a2677dd4 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
>  {
>  	struct completion *waiting = rq->end_io_data;
>  
> -	rq->end_io_data = NULL;
> +	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));

I think we should propagate the blk_status_t here as we're entirely inside
the block layer.  I.e. declare a blk_status_t on-stack in blk_execute_rq
and pass a pointer to it in ->end_io_data.

> -extern void blk_execute_rq(struct gendisk *, struct request *, int);
> +extern int blk_execute_rq(struct gendisk *, struct request *, int);

It would be nice to drop the extern here and spell out the argument
names.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
